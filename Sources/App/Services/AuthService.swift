import Foundation
import Domain

public class AuthService {
    private let adminService: AdminServiceProtocol
    private let sessionRepository: SessionRepositoryProtocol
    
    public init(
        adminService: AdminServiceProtocol,
        sessionRepository: SessionRepositoryProtocol
    ) {
        self.adminService = adminService
        self.sessionRepository = sessionRepository
    }
    
    // MARK: - Authentication Methods
    
    public func login(username: String, password: String, rememberMe: Bool = false) async throws -> AuthResult {
        do {
            let response = try await adminService.login(
                username: username,
                password: password,
                rememberMe: rememberMe
            )
            
            if response.success, let session = response.session {
                return AuthResult.success(session)
            } else {
                return AuthResult.failure(response.message ?? "로그인에 실패했습니다")
            }
        } catch {
            return AuthResult.failure("로그인 중 오류가 발생했습니다: \(error.localizedDescription)")
        }
    }
    
    public func logout(token: String) async throws -> Bool {
        do {
            return try await adminService.logout(token: token)
        } catch {
            throw AuthError.logoutFailed(error.localizedDescription)
        }
    }
    
    public func validateToken(_ token: String) async throws -> AdminSession? {
        do {
            return try await adminService.validateSession(token: token)
        } catch {
            throw AuthError.tokenValidationFailed(error.localizedDescription)
        }
    }
    
    public func refreshToken(_ token: String) async throws -> AdminSession? {
        do {
            return try await adminService.refreshSession(token: token)
        } catch {
            throw AuthError.tokenRefreshFailed(error.localizedDescription)
        }
    }
    
    public func hasPermission(token: String, permission: AdminPermission) async throws -> Bool {
        guard let session = try await validateToken(token) else {
            return false
        }
        
        do {
            return try await adminService.hasPermission(
                adminId: session.adminId,
                permission: permission
            )
        } catch {
            throw AuthError.permissionCheckFailed(error.localizedDescription)
        }
    }
    
    public func updateActivity(token: String) async throws -> Bool {
        do {
            return try await adminService.updateLastActivity(token: token)
        } catch {
            throw AuthError.activityUpdateFailed(error.localizedDescription)
        }
    }
    
    // MARK: - Session Management
    
    public func getCurrentSession(token: String) async throws -> AdminSession? {
        return try await validateToken(token)
    }
    
    public func isSessionValid(token: String) async throws -> Bool {
        let session = try await validateToken(token)
        return session != nil
    }
    
    public func getSessionExpiration(token: String) async throws -> Date? {
        let session = try await validateToken(token)
        return session?.expiresAt
    }
    
    public func cleanupExpiredSessions() async throws -> Int {
        do {
            return try await sessionRepository.deleteExpiredSessions()
        } catch {
            throw AuthError.sessionCleanupFailed(error.localizedDescription)
        }
    }
    
    // MARK: - Security Methods
    
    public func generateSecureToken() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<64).map { _ in characters.randomElement()! })
    }
    
    public func hashPassword(_ password: String) -> String {
        // TODO: Implement proper password hashing (bcrypt, scrypt, etc.)
        return password.sha256
    }
    
    public func verifyPassword(_ password: String, hashedPassword: String) -> Bool {
        return hashPassword(password) == hashedPassword
    }
    
    // MARK: - Rate Limiting
    
    private var loginAttempts: [String: [Date]] = [:]
    private let maxAttempts = 5
    private let attemptWindow: TimeInterval = 15 * 60 // 15 minutes
    
    public func canAttemptLogin(ipAddress: String) -> Bool {
        let now = Date()
        let attempts = loginAttempts[ipAddress] ?? []
        let recentAttempts = attempts.filter { now.timeIntervalSince($0) < attemptWindow }
        
        return recentAttempts.count < maxAttempts
    }
    
    public func recordLoginAttempt(ipAddress: String, success: Bool) {
        let now = Date()
        
        if success {
            // Clear attempts on successful login
            loginAttempts.removeValue(forKey: ipAddress)
        } else {
            // Record failed attempt
            var attempts = loginAttempts[ipAddress] ?? []
            attempts.append(now)
            loginAttempts[ipAddress] = attempts
        }
    }
    
    public func getRemainingAttempts(ipAddress: String) -> Int {
        let now = Date()
        let attempts = loginAttempts[ipAddress] ?? []
        let recentAttempts = attempts.filter { now.timeIntervalSince($0) < attemptWindow }
        
        return max(0, maxAttempts - recentAttempts.count)
    }
}

// MARK: - AuthResult

public enum AuthResult {
    case success(AdminSession)
    case failure(String)
    
    public var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    
    public var session: AdminSession? {
        switch self {
        case .success(let session): return session
        case .failure: return nil
        }
    }
    
    public var errorMessage: String? {
        switch self {
        case .success: return nil
        case .failure(let message): return message
        }
    }
}

// MARK: - AuthError

public enum AuthError: Error, LocalizedError {
    case loginFailed(String)
    case logoutFailed(String)
    case tokenValidationFailed(String)
    case tokenRefreshFailed(String)
    case permissionCheckFailed(String)
    case activityUpdateFailed(String)
    case sessionCleanupFailed(String)
    case rateLimitExceeded
    case invalidCredentials
    case sessionExpired
    case sessionNotFound
    
    public var errorDescription: String? {
        switch self {
        case .loginFailed(let message): return "로그인 실패: \(message)"
        case .logoutFailed(let message): return "로그아웃 실패: \(message)"
        case .tokenValidationFailed(let message): return "토큰 검증 실패: \(message)"
        case .tokenRefreshFailed(let message): return "토큰 갱신 실패: \(message)"
        case .permissionCheckFailed(let message): return "권한 확인 실패: \(message)"
        case .activityUpdateFailed(let message): return "활동 업데이트 실패: \(message)"
        case .sessionCleanupFailed(let message): return "세션 정리 실패: \(message)"
        case .rateLimitExceeded: return "로그인 시도 횟수 초과"
        case .invalidCredentials: return "잘못된 인증 정보"
        case .sessionExpired: return "세션이 만료되었습니다"
        case .sessionNotFound: return "세션을 찾을 수 없습니다"
        }
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
