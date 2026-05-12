//
//  PinaContextStub.swift
//  Euki
//
//  Stubbed MCP (Model Context Protocol) context for personalization
//  Returns mock user context without making real MCP calls
//

import Foundation

// MARK: - User Context Models

struct PinaUserProfile {
    let userId: String
    let email: String
    let displayName: String
    let age: Int
    let cycleLength: Int
    let lastCycleStartDate: Date
    let timezone: String
    let language: String
    let createdAt: Date
}

struct PinaContextData {
    let userProfile: PinaUserProfile
    let currentCyclePhase: String
    let estimatedFertilityWindow: (start: Date, end: Date)?
    let premiumStatus: Bool
    let lastActivityDate: Date
}

struct PinaContextResponse {
    let success: Bool
    let context: PinaContextData?
    let message: String
}

// MARK: - Context Stub

class PinaContextStub {
    static let sharedInstance = PinaContextStub()

    private var cachedContext: PinaContextData?

    // MARK: - Public Methods

    /// Stub get user context method
    /// - Parameters:
    ///   - userId: User identifier
    ///   - completion: Returns mock user context
    func getUserContext(userId: String, completion: @escaping (PinaContextResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            let mockProfile = PinaUserProfile(
                userId: userId,
                email: "user@example.com",
                displayName: "Test User",
                age: 28,
                cycleLength: 28,
                lastCycleStartDate: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                timezone: TimeZone.current.identifier,
                language: "en",
                createdAt: Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date()
            )

            let estimatedFertilityWindow = (
                start: Calendar.current.date(byAdding: .day, value: 11, to: Date()) ?? Date(),
                end: Calendar.current.date(byAdding: .day, value: 16, to: Date()) ?? Date()
            )

            let mockContext = PinaContextData(
                userProfile: mockProfile,
                currentCyclePhase: "follicular",
                estimatedFertilityWindow: estimatedFertilityWindow,
                premiumStatus: false,
                lastActivityDate: Date()
            )

            self?.cachedContext = mockContext

            let response = PinaContextResponse(
                success: true,
                context: mockContext,
                message: "Context loaded successfully (stub)"
            )
            completion(response)
        }
    }

    /// Stub update context method
    /// - Parameters:
    ///   - userId: User identifier
    ///   - updates: Dictionary of updates to apply
    ///   - completion: Returns updated context
    func updateContext(userId: String, updates: [String: Any], completion: @escaping (PinaContextResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            // In a real implementation, would merge updates with existing context
            if let existingContext = self?.cachedContext {
                let response = PinaContextResponse(
                    success: true,
                    context: existingContext,
                    message: "Context updated successfully (stub)"
                )
                completion(response)
            } else {
                let response = PinaContextResponse(
                    success: false,
                    context: nil,
                    message: "No context found to update (stub)"
                )
                completion(response)
            }
        }
    }

    /// Get cached context
    /// - Returns: Last loaded context data if available
    func getCachedContext() -> PinaContextData? {
        return cachedContext
    }

    /// Stub get personalized recommendations
    /// - Parameters:
    ///   - userId: User identifier
    ///   - completion: Returns array of recommendations
    func getPersonalizedRecommendations(userId: String, completion: @escaping (([String]) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let recommendations = [
                "Based on your cycle phase, consider gentle yoga or stretching",
                "Stay hydrated during this phase of your cycle",
                "Try journaling to track your emotional patterns",
                "Consider a nutrient-rich meal to support your wellness",
                "Premium feature: Get advanced cycle predictions"
            ]
            completion(recommendations)
        }
    }

    /// Clear cached context
    func clearCache() {
        cachedContext = nil
    }
}
