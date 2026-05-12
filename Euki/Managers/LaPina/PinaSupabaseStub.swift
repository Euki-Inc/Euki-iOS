//
//  PinaSupabaseStub.swift
//  Euki
//
//  Stubbed Supabase authentication and database operations
//  Returns mock success responses without making real network calls
//

import Foundation

// MARK: - Auth Response Models

struct PinaAuthUser {
    let id: String
    let email: String
    let createdAt: Date
}

struct PinaAuthResponse {
    let success: Bool
    let user: PinaAuthUser?
    let message: String
}

// MARK: - Supabase Stub

class PinaSupabaseStub {
    static let sharedInstance = PinaSupabaseStub()

    private var currentUser: PinaAuthUser?

    // MARK: - Public Methods

    /// Stub login method
    /// - Parameters:
    ///   - email: User email address
    ///   - password: User password
    ///   - completion: Returns mock success response
    func login(email: String, password: String, completion: @escaping (PinaAuthResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let mockUser = PinaAuthUser(
                id: UUID().uuidString,
                email: email,
                createdAt: Date()
            )
            self?.currentUser = mockUser
            let response = PinaAuthResponse(
                success: true,
                user: mockUser,
                message: "Login successful (stub)"
            )
            completion(response)
        }
    }

    /// Stub signup method
    /// - Parameters:
    ///   - email: New user email address
    ///   - password: New user password
    ///   - completion: Returns mock success response
    func signup(email: String, password: String, completion: @escaping (PinaAuthResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let mockUser = PinaAuthUser(
                id: UUID().uuidString,
                email: email,
                createdAt: Date()
            )
            self?.currentUser = mockUser
            let response = PinaAuthResponse(
                success: true,
                user: mockUser,
                message: "Signup successful (stub)"
            )
            completion(response)
        }
    }

    /// Stub logout method
    /// - Parameter completion: Returns mock success response
    func logout(completion: @escaping (PinaAuthResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.currentUser = nil
            let response = PinaAuthResponse(
                success: true,
                user: nil,
                message: "Logout successful (stub)"
            )
            completion(response)
        }
    }

    /// Get current authenticated user
    /// - Returns: Current user if authenticated, nil otherwise
    func getCurrentUser() -> PinaAuthUser? {
        return currentUser
    }

    /// Check if user is authenticated
    /// - Returns: Boolean indicating authentication status
    var isAuthenticated: Bool {
        return currentUser != nil
    }

    /// Stub password reset method
    /// - Parameters:
    ///   - email: User email address
    ///   - completion: Returns mock success response
    func resetPassword(email: String, completion: @escaping (PinaAuthResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let response = PinaAuthResponse(
                success: true,
                user: nil,
                message: "Password reset email sent (stub)"
            )
            completion(response)
        }
    }
}
