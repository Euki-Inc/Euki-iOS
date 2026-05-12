//
//  PinaMockData.swift
//  Euki
//
//  Mock data for La Piña development and testing
//  Matches data_seed.json structure
//

import Foundation

// MARK: - Models

struct PinaCycle {
    let id: Int
    let startDate: String
    let endDate: String
    let cycleLength: Int
    let periodLength: Int
    let flow: String
    let symptoms: [String]
}

struct PinaSymptom {
    let date: String
    let mood: [String]
    let body: [String]
    let sleepHours: Double
    let notes: String
}

struct PinaPregnancyWeek {
    let week: Int
    let title: String
    let description: String
    let fetalDevelopment: String
    let tips: [String]
}

struct PinaInsight {
    let type: String
    let title: String
    let message: String
    let severity: String
    let icon: String
}

struct PinaAffiliateProduct {
    let name: String
    let price: String
    let link: String
}

struct PinaBlogPost {
    let id: Int
    let category: String
    let title: String
    let excerpt: String
    let image: String
    let affiliateProducts: [PinaAffiliateProduct]
}

// MARK: - Mock Data Provider

class PinaMockData {
    static let sharedInstance = PinaMockData()

    // MARK: - Cycles

    var mockCycles: [PinaCycle] {
        return [
            PinaCycle(
                id: 1,
                startDate: "2026-01-05",
                endDate: "2026-01-10",
                cycleLength: 28,
                periodLength: 5,
                flow: "medium",
                symptoms: ["cramps", "bloating", "fatigue"]
            ),
            PinaCycle(
                id: 2,
                startDate: "2025-12-08",
                endDate: "2025-12-13",
                cycleLength: 28,
                periodLength: 5,
                flow: "heavy",
                symptoms: ["cramps", "headache", "mood_swings"]
            ),
            PinaCycle(
                id: 3,
                startDate: "2025-11-10",
                endDate: "2025-11-15",
                cycleLength: 29,
                periodLength: 5,
                flow: "medium",
                symptoms: ["bloating", "fatigue"]
            )
        ]
    }

    // MARK: - Symptoms

    var mockSymptoms: [PinaSymptom] {
        return [
            PinaSymptom(
                date: "2026-01-30",
                mood: ["happy", "energetic"],
                body: ["clear_skin"],
                sleepHours: 7.5,
                notes: "Feeling great today!"
            ),
            PinaSymptom(
                date: "2026-01-29",
                mood: ["anxious", "tired"],
                body: ["headache", "bloating"],
                sleepHours: 6,
                notes: "PMS symptoms starting"
            ),
            PinaSymptom(
                date: "2026-01-28",
                mood: ["calm"],
                body: ["cramps"],
                sleepHours: 8,
                notes: ""
            )
        ]
    }

    // MARK: - Pregnancy Weeks

    var mockPregnancyWeeks: [PinaPregnancyWeek] {
        return [
            PinaPregnancyWeek(
                week: 1,
                title: "Week 1: Preparation",
                description: "Your body is preparing for ovulation",
                fetalDevelopment: "Conception hasn't occurred yet",
                tips: ["Take prenatal vitamins", "Track ovulation"]
            ),
            PinaPregnancyWeek(
                week: 8,
                title: "Week 8: Rapid Growth",
                description: "Baby is growing rapidly",
                fetalDevelopment: "Arms and legs are forming, heart is beating",
                tips: ["Stay hydrated", "Eat small frequent meals"]
            ),
            PinaPregnancyWeek(
                week: 20,
                title: "Week 20: Halfway There",
                description: "You're halfway through pregnancy!",
                fetalDevelopment: "Baby can hear sounds, movements felt",
                tips: ["Start prenatal classes", "Consider nursery planning"]
            )
        ]
    }

    // MARK: - Insights

    var mockInsights: [PinaInsight] {
        return [
            PinaInsight(
                type: "irregular_cycle",
                title: "Cycle Length Variation Detected",
                message: "Your last 3 cycles varied by more than 7 days. This is normal, but if it continues, consider consulting a healthcare provider.",
                severity: "low",
                icon: "info"
            ),
            PinaInsight(
                type: "fertility_window",
                title: "Fertile Window Approaching",
                message: "Based on your cycle, your fertile window is estimated to be Feb 5-10.",
                severity: "info",
                icon: "calendar"
            )
        ]
    }

    // MARK: - Blog Posts

    var mockBlogPosts: [PinaBlogPost] {
        return [
            PinaBlogPost(
                id: 1,
                category: "luxury_wellness",
                title: "The Ultimate Guide to Self-Care Sundays",
                excerpt: "Discover luxury wellness products that elevate your self-care routine",
                image: "self-care-luxury.jpg",
                affiliateProducts: [
                    PinaAffiliateProduct(
                        name: "Rose Quartz Gua Sha",
                        price: "$45",
                        link: "https://amazon.com/placeholder"
                    )
                ]
            ),
            PinaBlogPost(
                id: 2,
                category: "intimacy",
                title: "Empowerment Through Intimacy",
                excerpt: "High-end products designed for your pleasure and wellness",
                image: "intimacy-products.jpg",
                affiliateProducts: [
                    PinaAffiliateProduct(
                        name: "Premium Wellness Wand",
                        price: "$120",
                        link: "https://amazon.com/placeholder"
                    )
                ]
            ),
            PinaBlogPost(
                id: 3,
                category: "mental_wellness",
                title: "Mindfulness Practices for Busy Women",
                excerpt: "Expert advice on mental health and spiritual wellness",
                image: "mindfulness.jpg",
                affiliateProducts: []
            ),
            PinaBlogPost(
                id: 4,
                category: "fitness",
                title: "Cycle-Syncing Your Workouts",
                excerpt: "Optimize your fitness routine based on your menstrual cycle",
                image: "fitness-cycle.jpg",
                affiliateProducts: [
                    PinaAffiliateProduct(
                        name: "Smart Yoga Mat",
                        price: "$89",
                        link: "https://amazon.com/placeholder"
                    )
                ]
            ),
            PinaBlogPost(
                id: 5,
                category: "gourmet",
                title: "Hormone-Balancing Teas & Coffee",
                excerpt: "Delicious beverages that support your wellness journey",
                image: "tea-coffee.jpg",
                affiliateProducts: [
                    PinaAffiliateProduct(
                        name: "Organic Moon Cycle Tea Set",
                        price: "$32",
                        link: "https://amazon.com/placeholder"
                    )
                ]
            )
        ]
    }

    // MARK: - Premium Features

    var mockPremiumFeatures: [String] {
        return [
            "Unlimited AI companion queries",
            "Full blog & flipbook access",
            "Advanced cycle predictions",
            "Export all data (PDF/CSV)",
            "Priority support",
            "Custom reminders",
            "Trend analysis reports"
        ]
    }
}
