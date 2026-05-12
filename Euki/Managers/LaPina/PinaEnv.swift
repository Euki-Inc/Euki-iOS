//
//  PinaEnv.swift
//  Euki
//
//  Environment configuration manager for La Piña
//  Reads configuration from Config.plist
//

import Foundation

class PinaEnv {
    static let sharedInstance = PinaEnv()

    private let configDict: [String: Any]

    init() {
        if let configPath = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: configPath) as? [String: Any] {
            self.configDict = dict
        } else {
            self.configDict = [:]
        }
    }

    /// Returns SUPABASE_URL or empty string if not configured
    var supabaseURL: String {
        return configDict["SUPABASE_URL"] as? String ?? ""
    }

    /// Returns SUPABASE_ANON_KEY or empty string if not configured
    var supabaseAnonKey: String {
        return configDict["SUPABASE_ANON_KEY"] as? String ?? ""
    }

    /// Returns STRIPE_PUBLIC_KEY or empty string if not configured
    var stripePublicKey: String {
        return configDict["STRIPE_PUBLIC_KEY"] as? String ?? ""
    }

    /// Returns STRIPE_SECRET_KEY or empty string if not configured
    var stripeSecretKey: String {
        return configDict["STRIPE_SECRET_KEY"] as? String ?? ""
    }

    /// Returns CLAUDE_API_KEY or empty string if not configured
    var claudeAPIKey: String {
        return configDict["CLAUDE_API_KEY"] as? String ?? ""
    }

    /// Returns APIFY_TOKEN or empty string if not configured
    var apifyToken: String {
        return configDict["APIFY_TOKEN"] as? String ?? ""
    }

    /// Returns BLOG_BASE_URL or empty string if not configured
    var blogBaseURL: String {
        return configDict["BLOG_BASE_URL"] as? String ?? ""
    }
}
