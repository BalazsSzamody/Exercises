//Solution goes in Sources
extension Array where String == Element {
    func recite(_ first: String? = nil) -> String {
        guard self.count > 0 else {
            return createEnding(with: first)
        }
        var input = self
        let current = input.remove(at: 0)
        let sentence = input.createSentence(with: current)
        
        // Hey Tom, How are you? :D
        // Is it ok to keep this if else?
        // I couldn't figure out a way to extract it without passing in too many variables.
        
        if let first = first {
            return sentence + input.recite(first)
        } else {
            return sentence + input.recite(current)
        }
    }
    
    private func createSentence(with previous: String) -> String {
        guard self.count > 0 else {
            return ""
        }
        return "For want of " + previous.withIndefiniteArticle() + " the " + self[0] + " was lost.\n"
    }
    
    private func createEnding(with first: String?) -> String {
        if let first = first {
            return "And all for the want of " + first.withIndefiniteArticle() + "."
        } else {
            return ""
        }
    }
}

extension String {
    func withIndefiniteArticle() -> String {
        guard let firstCharacter = self.first else {
            return self
        }
        let article = String(firstCharacter).getArticle()
        
        return article + self
    }
    
    private func getArticle() -> String {
        if ["a", "e", "i", "o", "u"].contains(self.lowercased()) {
            return "an "
        } else {
            return "a "
        }
    }
}
