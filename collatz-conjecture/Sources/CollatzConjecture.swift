//Solution goes in Sources
struct CollatzConjecture {
    
    static func steps(_ number: Int) throws -> Int {
        guard number > 0 else {
            throw CollatzConjectureError.numberNotAboveZero
        }
        
        guard number != 1 else {
            return 0
        }
        
        let nextNumber = getNextNumber(number)
        
        return try steps(nextNumber) + 1
    }
    
    private static func getNextNumber(_ current: Int) -> Int {
        let nextNumber: Int
        
        if current % 2 == 0 {
            nextNumber = current / 2
        } else {
            nextNumber = 3 * current + 1
        }
        
        return nextNumber
    }
}

extension CollatzConjecture {
    
    enum CollatzConjectureError: Error {
        case numberNotAboveZero
    }
}
