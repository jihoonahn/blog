import Foundation

extension String {
    var slug: String {
        return self
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "[^a-z0-9가-힣-]", with: "", options: .regularExpression)
            .trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }

    func truncate(to length: Int, suffix: String = "...") -> String {
        if self.count <= length {
            return self
        }
        return String(self.prefix(length)) + suffix
    }
}
