//Solution goes in Sources

enum CircularBufferError: Error {
    case bufferEmpty
    case bufferFull
}

class CircularBuffer<T> {
    private var buffer: [Container<T>]
    private var first: Container<T>
    private var last: Container<T>
    
    init(capacity: Int) {
        buffer = CircularBuffer.buildBuffer(for: capacity)
        first = buffer[0]
        last = buffer.last!
    }
    
    func read() throws -> T {
        guard let value = first.value else {
            throw CircularBufferError.bufferEmpty
        }
        first.value = nil
        first = first.next!
        
        return value
    }
    
    func write(_ value: T) throws {
        let current = last.next!
        guard current.value == nil else {
            throw CircularBufferError.bufferFull
        }
        current.value = value
        if first.value == nil {
            first = current
        }
        last = current
    }
    
    func overwrite(_ value: T) {
        if last.next?.value != nil {
            first.value = nil
            first = first.next!
        }
        try! write(value)
    }
    
    func clear() {
        first = buffer[0]
        last = buffer.last!
        for container in buffer {
            container.value = nil
        }
    }
    
    private static func buildBuffer(for capacity: Int) -> [Container<T>] {
        var buffer: [Container<T>] = []
        var previous: Container<T>? = nil
        for _ in 1 ... capacity {
            let current = Container<T>()
            if let previous = previous {
                current.setNext(for: previous)
            }
            buffer.append(current)
            previous = current
        }
        buffer[0].setNext(for: buffer[capacity - 1])
        return buffer
    }
}

class Container<T> {
    var value: T?
    var next: Container<T>?
    
    fileprivate func setNext(for container: Container<T>) {
        container.next = self
    }
}

