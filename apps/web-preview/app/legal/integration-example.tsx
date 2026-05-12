/**
 * INTEGRATION EXAMPLES
 *
 * This file shows how to integrate legal disclaimers into various pages.
 * Copy these patterns into your actual page components.
 *
 * DO NOT import this file directly - it's for reference only.
 */

'use client'

import React, { useState } from 'react'
import {
  MedicalDisclaimer,
  EmergencyResources,
  WhenToSeeDoctor,
  AffiliateDisclosure,
  PrivacyNotice,
  EducationalNotice,
} from './disclaimers'

// ============================================================================
// EXAMPLE 1: Pregnancy Tracking Page
// ============================================================================
export function PregnancyPageExample() {
  return (
    <div className="w-full">
      {/* Banner-style disclaimer at the very top */}
      <MedicalDisclaimer variant="banner" />

      {/* Page Header */}
      <div className="px-4 py-6">
        <h1>Pregnancy Tracker</h1>
        <p>Track your pregnancy journey week by week</p>
      </div>

      {/* Main Content */}
      <div className="px-4">
        {/* Your pregnancy tracking UI */}
        <div className="card">
          <h2>Week 12</h2>
          <p>Baby is the size of a plum...</p>
        </div>

        {/* When to see doctor guidance */}
        <WhenToSeeDoctor className="mt-8" />

        {/* Full disclaimer with emergency resources */}
        <MedicalDisclaimer
          variant="card"
          showEmergencyResources={true}
          className="mt-8"
        />
      </div>
    </div>
  )
}

// ============================================================================
// EXAMPLE 2: Cycle Insights Page (AI-powered predictions)
// ============================================================================
export function CycleInsightsExample() {
  return (
    <div className="w-full">
      {/* Page Header */}
      <div className="px-4 py-6">
        <h1>Cycle Insights</h1>
      </div>

      <div className="px-4 space-y-6">
        {/* Prominent disclaimer before AI insights */}
        <MedicalDisclaimer variant="card" />

        {/* AI-generated insights */}
        <div className="card">
          <h2>Predicted Next Period</h2>
          <p>Based on your cycle history...</p>
        </div>

        <div className="card">
          <h2>Fertility Window</h2>
          <div className="bg-red-50 border border-red-200 rounded-lg p-3 mb-3">
            <p className="text-sm font-bold text-neutral-900">
              ⚠️ Not for Birth Control
            </p>
            <p className="text-xs text-neutral-700">
              Do not use these predictions for contraception.
            </p>
          </div>
          <p>Your estimated fertility window...</p>
        </div>

        {/* When to see doctor */}
        <WhenToSeeDoctor />
      </div>
    </div>
  )
}

// ============================================================================
// EXAMPLE 3: Blog Post with Affiliate Links
// ============================================================================
export function BlogPostExample() {
  return (
    <article className="max-w-4xl mx-auto px-4 py-12">
      {/* Article Header */}
      <h1>10 Wellness Products for Your Menstrual Cycle</h1>
      <p className="text-neutral-600">Published March 9, 2026</p>

      {/* Educational notice at top */}
      <EducationalNotice className="my-6" />

      {/* Article content */}
      <div className="prose">
        <p>During your menstrual cycle, self-care is essential...</p>
      </div>

      {/* Product recommendations with affiliate links */}
      <div className="mt-8 space-y-4">
        <h2>Recommended Products</h2>

        <a
          href="https://amazon.com/product?tag=lapina-20"
          target="_blank"
          rel="noopener noreferrer"
          className="card hover:shadow-medium"
        >
          <h3>Heating Pad</h3>
          <p className="text-pina-pink font-bold">$29.99</p>
        </a>

        {/* More products... */}
      </div>

      {/* Affiliate disclosure at bottom */}
      <AffiliateDisclosure className="mt-12" />

      {/* Medical disclaimer footer */}
      <MedicalDisclaimer variant="inline" className="mt-6" />
    </article>
  )
}

// ============================================================================
// EXAMPLE 4: Symptom Tracking Page
// ============================================================================
export function SymptomTrackingExample() {
  return (
    <div className="w-full">
      {/* Banner disclaimer */}
      <MedicalDisclaimer variant="banner" />

      <div className="px-4 py-6">
        <h1>Track Symptoms</h1>

        {/* Symptom logging UI */}
        <div className="card mt-6">
          <h2>How are you feeling today?</h2>
          {/* Symptom checkboxes, sliders, etc. */}
        </div>

        {/* Inline disclaimers near specific symptoms */}
        <div className="card mt-6">
          <h3>Severe Symptoms</h3>
          <div className="space-y-2">
            <label>
              <input type="checkbox" /> Severe pain
            </label>
            <MedicalDisclaimer variant="inline" className="ml-6" />
          </div>
        </div>

        {/* When to see doctor guidance */}
        <WhenToSeeDoctor className="mt-8" />
      </div>
    </div>
  )
}

// ============================================================================
// EXAMPLE 5: Onboarding / First-Time User
// ============================================================================
export function OnboardingExample() {
  return (
    <div className="w-full max-w-2xl mx-auto px-4 py-12">
      <h1>Welcome to La Piña</h1>

      {/* Privacy notice during onboarding */}
      <PrivacyNotice className="my-6" />

      {/* Onboarding steps */}
      <div className="space-y-6">
        <div className="card">
          <h2>Step 1: Your Privacy</h2>
          <p>All data is stored locally on your device...</p>
        </div>

        <div className="card">
          <h2>Step 2: Important Disclaimer</h2>
          <MedicalDisclaimer variant="card" showEmergencyResources={true} />
        </div>

        <div className="card">
          <h2>Step 3: Emergency Resources</h2>
          <p>If you ever need help, here are critical resources:</p>
          <EmergencyResources />
        </div>
      </div>

      {/* Legal acceptance */}
      <div className="mt-8 p-4 bg-neutral-50 rounded-lg text-sm">
        <label className="flex items-start gap-3">
          <input type="checkbox" className="mt-1" />
          <span>
            I understand that La Piña is not medical advice and I agree to the{' '}
            <a href="/terms" className="text-pina-pink hover:underline">
              Terms of Service
            </a>{' '}
            and{' '}
            <a href="/privacy" className="text-pina-pink hover:underline">
              Privacy Policy
            </a>
            .
          </span>
        </label>
      </div>
    </div>
  )
}

// ============================================================================
// EXAMPLE 6: Settings Page with Data Export
// ============================================================================
export function SettingsPageExample() {
  return (
    <div className="w-full max-w-4xl mx-auto px-4 py-12">
      <h1>Settings</h1>

      <div className="space-y-6 mt-6">
        {/* Privacy settings */}
        <div className="card">
          <h2>Privacy & Data</h2>
          <PrivacyNotice className="mb-4" />

          <div className="space-y-3">
            <button className="btn-outline">Export My Data</button>
            <button className="btn-outline text-red-600 border-red-600">
              Delete Account
            </button>
          </div>

          <p className="text-xs text-neutral-600 mt-4">
            For privacy questions, email{' '}
            <a
              href="mailto:privacy@lapina.app"
              className="text-pina-pink hover:underline"
            >
              privacy@lapina.app
            </a>
          </p>
        </div>

        {/* Subscription settings */}
        <div className="card">
          <h2>Subscription</h2>
          <p>
            Premium - $9.99/year
            <br />
            <span className="text-xs text-neutral-600">
              See{' '}
              <a href="/terms#subscription" className="text-pina-pink hover:underline">
                Terms of Service
              </a>{' '}
              for refund policy
            </span>
          </p>
        </div>
      </div>
    </div>
  )
}

// ============================================================================
// EXAMPLE 7: Footer Component (App-Wide)
// ============================================================================
export function AppFooterExample() {
  return (
    <footer className="border-t border-neutral-200 bg-white mt-12">
      <div className="max-w-4xl mx-auto px-4 py-8">
        {/* Medical disclaimer */}
        <MedicalDisclaimer variant="inline" className="mb-4 text-center" />

        {/* Navigation links */}
        <div className="flex flex-wrap gap-4 justify-center text-sm text-neutral-600 mb-4">
          <a href="/privacy" className="hover:text-pina-pink">
            Privacy Policy
          </a>
          <a href="/terms" className="hover:text-pina-pink">
            Terms of Service
          </a>
          <a href="mailto:support@lapina.app" className="hover:text-pina-pink">
            Support
          </a>
          <a href="/blog" className="hover:text-pina-pink">
            Blog
          </a>
        </div>

        {/* Emergency resources link */}
        <div className="text-center mb-4">
          <a
            href="/terms#emergency"
            className="text-xs text-red-600 hover:underline font-medium"
          >
            🚨 Emergency Resources
          </a>
        </div>

        {/* Copyright */}
        <p className="text-xs text-neutral-500 text-center">
          © 2026 La Piña. All rights reserved.
        </p>

        {/* Compliance badges */}
        <div className="flex flex-wrap gap-2 justify-center mt-4">
          <span className="badge badge-success text-xs">GDPR Compliant</span>
          <span className="badge badge-success text-xs">CCPA Compliant</span>
          <span className="badge badge-primary text-xs">Privacy-First</span>
        </div>
      </div>
    </footer>
  )
}

// ============================================================================
// EXAMPLE 8: Modal Disclaimer (First App Launch)
// ============================================================================
export function FirstLaunchModalExample() {
  const [showDisclaimer, setShowDisclaimer] = useState(true)

  if (!showDisclaimer) return null

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div className="bg-gradient-to-br from-pina-pink to-pina-purple text-white p-6">
          <h2 className="text-2xl font-bold mb-2">Welcome to La Piña</h2>
          <p className="text-white/90">Please review this important information</p>
        </div>

        <div className="p-6 space-y-6">
          <MedicalDisclaimer variant="card" showEmergencyResources={true} />

          <PrivacyNotice />

          <div className="bg-neutral-50 rounded-lg p-4 text-sm">
            <label className="flex items-start gap-3">
              <input type="checkbox" className="mt-1" />
              <span className="text-neutral-700">
                I understand that La Piña is not medical advice and agree to the{' '}
                <a href="/terms" className="text-pina-pink hover:underline font-medium">
                  Terms of Service
                </a>{' '}
                and{' '}
                <a href="/privacy" className="text-pina-pink hover:underline font-medium">
                  Privacy Policy
                </a>
                .
              </span>
            </label>
          </div>

          <button
            onClick={() => setShowDisclaimer(false)}
            className="btn-primary w-full"
          >
            I Understand - Continue to App
          </button>
        </div>
      </div>
    </div>
  )
}

// ============================================================================
// BEST PRACTICES SUMMARY
// ============================================================================

/**
 * WHEN TO USE WHICH DISCLAIMER:
 * 
 * MedicalDisclaimer (variant="banner"):
 * - Top of pregnancy tracking
 * - Top of cycle insights
 * - Top of symptom tracking
 * 
 * MedicalDisclaimer (variant="card"):
 * - Before AI-generated insights
 * - On health information pages
 * - In onboarding flow
 * 
 * MedicalDisclaimer (variant="inline"):
 * - Blog post footers
 * - App footer
 * - Near specific health claims
 * 
 * WhenToSeeDoctor:
 * - Symptom tracking pages
 * - Pregnancy mode
 * - After showing cycle insights
 * 
 * EmergencyResources:
 * - Mental health content
 * - Pregnancy complications
 * - Crisis-related pages
 * 
 * AffiliateDisclosure:
 * - REQUIRED on all blog posts with Amazon links
 * - Product recommendation pages
 * 
 * PrivacyNotice:
 * - Onboarding
 * - Settings/account pages
 * - Before enabling cloud sync
 * 
 * EducationalNotice:
 * - Blog posts
 * - Educational articles
 * - Tips and guides
 */
