//Solution goes in Sources
class Diamond {
    
    static func makeDiamond(letter: String) -> [String] {
        let middleCharacter = Character(letter.uppercased())
        let buildingCharacters = Character.upperCaseAlphabet.filter { $0 < middleCharacter }
        let diamondCharacters = buildingCharacters + [middleCharacter] + buildingCharacters.reversed()
        
        return diamondCharacters.map { $0.paddingForDiamond(middle: buildingCharacters.count) }
    }
}

extension Array where Element: Equatable {
    func getIndex(of element: Element) -> Int? {
        for (i, currentElement) in self.enumerated() {
            if element == currentElement {
                return i
            }
        }
        return nil
    }
}

extension Character {
    static var upperCaseAlphabet: [Character] {
        return Array(65 ... 90).map { Character(UnicodeScalar($0)) }
    }
    
    func paddingForDiamond(middle: Int) -> String {
        guard let index = Character.upperCaseAlphabet.getIndex(of: self) else {
            return ""
        }
        var padding: [Character] = []
        for i in 0 ... middle * 2 {
            if i == middle - index || i == middle + index {
                padding.append(self)
            } else {
                padding.append(" ")
            }
        }
        
        return String(padding)
    }
    
}
