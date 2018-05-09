//
//  CircularBufferOld.swift
//  CircularBuffer
//
//  Created by Szamódy Zs. Balázs on 2018. 05. 08..
//

import Foundation

struct CircularBufferOld<T> {
    let capacity: Int
    private var elements: [T] = []
    var freeSpace: Int {
        return capacity - elements.count
    }
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    mutating func read() throws -> T {
        guard !(capacity == freeSpace) else {
            throw CircularBufferError.bufferEmpty
        }
        return elements.removeFirst()
    }
    
    mutating func write(_ element: T) throws {
        guard freeSpace > 0 else {
            throw CircularBufferError.bufferFull
        }
        elements.append(element)
    }
    
    mutating func overwrite(_ element: T) {
        if freeSpace == 0 {
            _ = elements.removeFirst()
        }
        elements.append(element)
    }
    
    mutating func clear() {
        elements = []
    }
}
