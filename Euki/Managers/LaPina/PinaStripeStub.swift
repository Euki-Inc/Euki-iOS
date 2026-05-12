//
//  PinaStripeStub.swift
//  Euki
//
//  Stubbed Stripe subscription and payment operations
//  Returns mock premium status without making real payment calls
//

import Foundation

// MARK: - Subscription Models

struct PinaSubscription {
    let id: String
    let productId: String
    let price: String
    let status: String
    let startDate: Date
    let renewalDate: Date
}

struct PinaPaymentResponse {
    let success: Bool
    let subscription: PinaSubscription?
    let message: String
}

// MARK: - Stripe Stub

class PinaStripeStub {
    static let sharedInstance = PinaStripeStub()

    private var currentSubscription: PinaSubscription?
    private var isPremium = false

    // MARK: - Public Methods

    /// Stub purchase subscription method
    /// - Parameters:
    ///   - productId: Product identifier
    ///   - price: Price string (e.g., "$9.99/year")
    ///   - completion: Returns mock subscription response
    func purchaseSubscription(productId: String, price: String, completion: @escaping (PinaPaymentResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            let mockSubscription = PinaSubscription(
                id: UUID().uuidString,
                productId: productId,
                price: price,
                status: "active",
                startDate: Date(),
                renewalDate: Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()
            )
            self?.currentSubscription = mockSubscription
            self?.isPremium = true

            let response = PinaPaymentResponse(
                success: true,
                subscription: mockSubscription,
                message: "Subscription purchased successfully (stub)"
            )
            completion(response)
        }
    }

    /// Stub cancel subscription method
    /// - Parameter completion: Returns mock success response
    func cancelSubscription(completion: @escaping (PinaPaymentResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.currentSubscription = nil
            self?.isPremium = false

            let response = PinaPaymentResponse(
                success: true,
                subscription: nil,
                message: "Subscription cancelled (stub)"
            )
            completion(response)
        }
    }

    /// Get current subscription
    /// - Returns: Current subscription if active, nil otherwise
    func getCurrentSubscription() -> PinaSubscription? {
        return currentSubscription
    }

    /// Check if user has premium subscription
    /// - Returns: Boolean indicating premium status
    var hasPremiumSubscription: Bool {
        return isPremium && currentSubscription != nil
    }

    /// Stub restore purchases method
    /// Restores previous purchases and returns the current active subscription if one exists
    /// - Parameter completion: Returns mock subscription response with active subscription (or nil if none found)
    func restorePurchases(completion: @escaping (PinaPaymentResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let response: PinaPaymentResponse
            if let subscription = self?.currentSubscription {
                response = PinaPaymentResponse(
                    success: true,
                    subscription: subscription,
                    message: "Purchases restored (stub)"
                )
            } else {
                response = PinaPaymentResponse(
                    success: true,
                    subscription: nil,
                    message: "No previous purchases found (stub)"
                )
            }
            completion(response)
        }
    }

    /// Get premium subscription price
    /// - Returns: Price string
    func getPremiumPrice() -> String {
        return "$9.99/year"
    }

    /// Get premium features list
    /// - Returns: Array of premium feature strings
    func getPremiumFeatures() -> [String] {
        return PinaMockData.sharedInstance.mockPremiumFeatures
    }
}
