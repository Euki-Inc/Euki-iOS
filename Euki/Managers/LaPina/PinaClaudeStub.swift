//
//  PinaClaudeStub.swift
//  Euki
//
//  Stubbed Claude AI companion for health advice and chat
//  Returns canned responses without making real API calls
//

import Foundation

// MARK: - Chat Models

struct PinaChatMessage {
    let id: String
    let content: String
    let role: String
    let timestamp: Date
}

struct PinaChatResponse {
    let success: Bool
    let message: PinaChatMessage?
    let error: String?
}

// MARK: - Claude Stub

class PinaClaudeStub {
    static let sharedInstance = PinaClaudeStub()

    private var conversationHistory: [PinaChatMessage] = []

    // MARK: - Canned Responses

    private let cannedResponses = [
        "That's interesting! Based on your cycle tracking, I notice a pattern. Have you considered keeping a symptom journal to identify triggers?",
        "Health is unique to each person. While your symptoms are common, if they persist or worsen, consulting a healthcare provider is always a good idea.",
        "Great self-awareness! Tracking your wellness helps you understand your body better. Keep up the excellent work!",
        "Your cycle seems fairly regular. This is a good indicator of overall reproductive health. Stay hydrated and get enough sleep!",
        "Mood changes around certain cycle phases are completely normal. Some people find exercise or meditation helpful during these times.",
        "I'm here to provide general wellness insights, but remember I'm not a substitute for professional medical advice.",
        "Your data shows some interesting patterns. Have you explored how your lifestyle factors into your wellness?",
        "Congratulations on consistent tracking! This data will help us provide better personalized insights over time.",
        "If you're planning to try something new for your wellness, starting small and observing how your body responds is a smart approach.",
        "Remember to listen to your body and adjust your routine based on how you feel. Self-care is key!"
    ]

    // MARK: - Public Methods

    /// Stub send message to Claude AI
    /// - Parameters:
    ///   - message: User's message
    ///   - completion: Returns mock chat response with canned reply
    func sendMessage(_ message: String, completion: @escaping (PinaChatResponse) -> Void) {
        // Add user message to history
        let userMessage = PinaChatMessage(
            id: UUID().uuidString,
            content: message,
            role: "user",
            timestamp: Date()
        )
        conversationHistory.append(userMessage)

        // Simulate API delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // Return random canned response
            let responseText = self?.cannedResponses.randomElement() ?? "I'm here to help with your wellness journey!"
            let assistantMessage = PinaChatMessage(
                id: UUID().uuidString,
                content: responseText,
                role: "assistant",
                timestamp: Date()
            )
            self?.conversationHistory.append(assistantMessage)

            let response = PinaChatResponse(
                success: true,
                message: assistantMessage,
                error: nil
            )
            completion(response)
        }
    }

    /// Get conversation history
    /// - Returns: Array of chat messages
    func getConversationHistory() -> [PinaChatMessage] {
        return conversationHistory
    }

    /// Clear conversation history
    func clearConversation() {
        conversationHistory.removeAll()
    }

    /// Get health insight based on symptom
    /// - Parameters:
    ///   - symptom: Symptom or concern
    ///   - completion: Returns mock insight response
    func getHealthInsight(forSymptom symptom: String, completion: @escaping (PinaChatResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let insightMessage = PinaChatMessage(
                id: UUID().uuidString,
                content: "Based on your report of \(symptom), here are some wellness suggestions: Stay hydrated, maintain consistent sleep, and consider gentle exercise. If symptoms persist, consult a healthcare provider.",
                role: "assistant",
                timestamp: Date()
            )

            let response = PinaChatResponse(
                success: true,
                message: insightMessage,
                error: nil
            )
            completion(response)
        }
    }

    /// Ask Claude about pregnancy
    /// - Parameters:
    ///   - week: Pregnancy week
    ///   - completion: Returns mock pregnancy insight
    func getPregnancyInsight(week: Int, completion: @escaping (PinaChatResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let insight = "At week \(week) of pregnancy, your body is undergoing important changes. Make sure to: get adequate rest, eat nutritious foods, and attend prenatal appointments. This is a wonderful journey!"
            let message = PinaChatMessage(
                id: UUID().uuidString,
                content: insight,
                role: "assistant",
                timestamp: Date()
            )

            let response = PinaChatResponse(
                success: true,
                message: message,
                error: nil
            )
            completion(response)
        }
    }
}
