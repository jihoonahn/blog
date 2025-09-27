import Foundation

public struct AdminCredentials: Codable, Equatable {
    public let username: String
    public let password: String
    public let rememberMe: Bool
    
    public init(
        username: String,
        password: String,
        rememberMe: Bool = false
    ) {
        self.username = username
        self.password = password
        self.rememberMe = rememberMe
    }
    
    public var isValid: Bool {
        return !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !password.isEmpty &&
               username.count >= 3 &&
               password.count >= 6
    }
    
    public var trimmedUsername: String {
        return username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    public var hashedPassword: String {
        return password.sha256
    }
}

public struct AdminRegistration: Codable, Equatable {
    public let username: String
    public let email: String
    public let password: String
    public let confirmPassword: String
    public let displayName: String
    public let role: AdminRole
    
    public init(
        username: String,
        email: String,
        password: String,
        confirmPassword: String,
        displayName: String,
        role: AdminRole = .editor
    ) {
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.displayName = displayName
        self.role = role
    }
    
    public var isValid: Bool {
        return !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !password.isEmpty &&
               !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               password == confirmPassword &&
               username.count >= 3 &&
               password.count >= 6 &&
               isValidEmail(email)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    public var trimmedUsername: String {
        return username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    public var trimmedEmail: String {
        return email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    public var trimmedDisplayName: String {
        return displayName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var hashedPassword: String {
        return password.sha256
    }
}

public struct PasswordChangeRequest: Codable, Equatable {
    public let currentPassword: String
    public let newPassword: String
    public let confirmPassword: String
    
    public init(
        currentPassword: String,
        newPassword: String,
        confirmPassword: String
    ) {
        self.currentPassword = currentPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
    }
    
    public var isValid: Bool {
        return !currentPassword.isEmpty &&
               !newPassword.isEmpty &&
               newPassword == confirmPassword &&
               newPassword.count >= 6 &&
               currentPassword != newPassword
    }
    
    public var hashedCurrentPassword: String {
        return currentPassword.sha256
    }
    
    public var hashedNewPassword: String {
        return newPassword.sha256
    }
}

public struct PasswordResetRequest: Codable, Equatable {
    public let email: String
    
    public init(email: String) {
        self.email = email
    }
    
    public var isValid: Bool {
        return !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               isValidEmail(email)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    public var trimmedEmail: String {
        return email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}

// MARK: - String Extension for Hashing
extension String {
    var sha256: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { bytes in
            return bytes.bindMemory(to: UInt8.self)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
