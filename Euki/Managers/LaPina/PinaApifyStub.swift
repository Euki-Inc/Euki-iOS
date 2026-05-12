//
//  PinaApifyStub.swift
//  Euki
//
//  Stubbed Apify web scraping for trend monitoring and UGC
//  Returns empty arrays without making real scraping calls
//

import Foundation

// MARK: - Trend Models

struct PinaTrend {
    let id: String
    let title: String
    let description: String
    let category: String
    let engagementScore: Double
    let sourceUrl: String
    let timestamp: Date
}

struct PinaTrendResponse {
    let success: Bool
    let trends: [PinaTrend]
    let message: String
}

// MARK: - Apify Stub

class PinaApifyStub {
    static let sharedInstance = PinaApifyStub()

    // MARK: - Public Methods

    /// Stub scrape trends method
    /// - Parameters:
    ///   - query: Search query for trends
    ///   - completion: Returns empty trends array
    func scrapeTrends(query: String, completion: @escaping (PinaTrendResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let response = PinaTrendResponse(
                success: true,
                trends: [],
                message: "No trends available (stub mode)"
            )
            completion(response)
        }
    }

    /// Stub scrape social media trends
    /// - Parameters:
    ///   - platform: Social media platform (e.g., "instagram", "tiktok")
    ///   - category: Trend category
    ///   - completion: Returns empty trends array
    func scrapeSocialMediaTrends(platform: String, category: String, completion: @escaping (PinaTrendResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let response = PinaTrendResponse(
                success: true,
                trends: [],
                message: "No social media trends available (stub mode)"
            )
            completion(response)
        }
    }

    /// Stub scrape health/wellness trends
    /// - Parameter completion: Returns empty trends array
    func scrapeWellnessTrends(completion: @escaping (PinaTrendResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let response = PinaTrendResponse(
                success: true,
                trends: [],
                message: "No wellness trends available (stub mode)"
            )
            completion(response)
        }
    }

    /// Stub monitor UGC (user-generated content)
    /// - Parameters:
    ///   - hashtags: Array of hashtags to monitor
    ///   - completion: Returns empty UGC trends array
    func monitorUGC(hashtags: [String], completion: @escaping (PinaTrendResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let response = PinaTrendResponse(
                success: true,
                trends: [],
                message: "No UGC data available (stub mode)"
            )
            completion(response)
        }
    }

    /// Get trending categories
    /// - Returns: Array of popular categories
    func getTrendingCategories() -> [String] {
        return [
            "wellness",
            "fitness",
            "mental_health",
            "nutrition",
            "lifestyle",
            "beauty",
            "spirituality"
        ]
    }

    /// Check if scraping is available
    /// - Returns: Always returns false in stub mode
    var isScrapingAvailable: Bool {
        return false
    }
}
