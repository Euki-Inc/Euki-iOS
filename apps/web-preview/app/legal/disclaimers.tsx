'use client'

import { useState } from 'react'

/**
 * Medical Disclaimer Component
 *
 * Use this component wherever medical/health information is displayed
 * to ensure users understand La Piña is not medical advice.
 *
 * Usage:
 * <MedicalDisclaimer variant="inline" /> - Small inline disclaimer
 * <MedicalDisclaimer variant="card" /> - Card-style disclaimer
 * <MedicalDisclaimer variant="banner" /> - Full-width banner
 */

interface MedicalDisclaimerProps {
  variant?: 'inline' | 'card' | 'banner' | 'modal'
  showEmergencyResources?: boolean
  className?: string
}

export function MedicalDisclaimer({
  variant = 'card',
  showEmergencyResources = false,
  className = ''
}: MedicalDisclaimerProps) {

  if (variant === 'inline') {
    return (
      <div className={`text-xs text-neutral-600 italic ${className}`}>
        ⚕️ This is not medical advice. Consult a healthcare professional for medical concerns.
      </div>
    )
  }

  if (variant === 'banner') {
    return (
      <div className={`bg-gradient-to-r from-yellow-50 to-orange-50 border-l-4 border-yellow-400 p-4 ${className}`}>
        <div className="flex items-start gap-3">
          <span className="text-2xl">⚠️</span>
          <div>
            <h3 className="font-bold text-neutral-900 text-sm mb-1">Not Medical Advice</h3>
            <p className="text-xs text-neutral-700 leading-relaxed">
              La Piña is an educational wellness tool, not a medical device. Always consult qualified healthcare professionals for medical concerns.
            </p>
          </div>
        </div>
      </div>
    )
  }

  if (variant === 'modal') {
    return (
      <div className={`fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50 ${className}`}>
        <div className="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto">
          <div className="bg-gradient-to-br from-pina-pink to-pina-purple text-white p-6">
            <h2 className="text-2xl font-bold mb-2">Important Medical Disclaimer</h2>
            <p className="text-white/90">Please read carefully before using La Piña</p>
          </div>

          <div className="p-6 space-y-6">
            <MedicalDisclaimerContent showEmergencyResources={showEmergencyResources} />
          </div>
        </div>
      </div>
    )
  }

  // Default: card variant
  return (
    <div className={`card bg-gradient-to-br from-yellow-50 to-orange-50 border-2 border-yellow-200 ${className}`}>
      <MedicalDisclaimerContent showEmergencyResources={showEmergencyResources} />
    </div>
  )
}

function MedicalDisclaimerContent({ showEmergencyResources }: { showEmergencyResources: boolean }) {
  return (
    <>
      <div className="flex items-start gap-3 mb-4">
        <span className="text-3xl">⚕️</span>
        <div>
          <h3 className="text-lg font-bold text-neutral-900 mb-2">Not Medical Advice</h3>
          <p className="text-neutral-700 text-sm leading-relaxed">
            La Piña is an <strong>educational and wellness tracking tool</strong>. It is <strong>NOT a medical device</strong> and does <strong>NOT provide medical advice, diagnosis, or treatment</strong>.
          </p>
        </div>
      </div>

      <div className="space-y-3 text-sm text-neutral-700">
        <p className="leading-relaxed">
          Always seek the advice of your physician, gynecologist, or other qualified health provider with any questions you may have regarding a medical condition. Never disregard professional medical advice or delay seeking it because of information you see in La Piña.
        </p>

        <div className="bg-red-50 border border-red-200 rounded-lg p-3">
          <p className="font-semibold text-neutral-900 mb-1">⚠️ Not for Birth Control</p>
          <p className="text-xs text-neutral-700">
            Do NOT use La Piña as a contraceptive method. Consult a healthcare provider about appropriate birth control options.
          </p>
        </div>
      </div>

      {showEmergencyResources && <EmergencyResources />}
    </>
  )
}

/**
 * Emergency Resources Component
 *
 * Displays emergency hotlines for US and Mexico
 */

export function EmergencyResources() {
  const [expanded, setExpanded] = useState(false)

  return (
    <div className="mt-6 border-t border-neutral-200 pt-6">
      <button
        onClick={() => setExpanded(!expanded)}
        className="flex items-center justify-between w-full text-left group"
      >
        <h4 className="font-bold text-neutral-900 text-sm">🚨 Emergency Resources</h4>
        <span className="text-pina-pink group-hover:opacity-70 transition-opacity">
          {expanded ? '−' : '+'}
        </span>
      </button>

      {expanded && (
        <div className="mt-4 space-y-4 animate-slide-up">
          <div className="bg-red-50 border border-red-200 rounded-lg p-4">
            <h5 className="font-bold text-neutral-900 mb-3 text-sm">⚠️ When to Seek Immediate Medical Attention</h5>
            <ul className="space-y-1 text-xs text-neutral-700">
              <li>• Severe abdominal pain or cramping that doesn't improve</li>
              <li>• Unusually heavy bleeding (soaking through a pad in less than 1 hour)</li>
              <li>• Signs of infection: fever over 100.4°F (38°C), foul-smelling discharge</li>
              <li>• Sudden severe headache or vision changes</li>
              <li>• Chest pain or difficulty breathing</li>
              <li>• Signs of ectopic pregnancy: severe one-sided pain, shoulder pain, dizziness</li>
              <li>• Severe mood changes, depression, or thoughts of self-harm</li>
            </ul>
          </div>

          <div className="grid md:grid-cols-2 gap-4">
            <div className="bg-blue-50 rounded-lg p-4">
              <h5 className="font-bold text-neutral-900 mb-3 text-sm">🇺🇸 United States</h5>
              <div className="space-y-3 text-xs">
                <div>
                  <p className="font-semibold text-neutral-700">Emergency</p>
                  <a href="tel:911" className="text-pina-pink font-bold text-lg hover:underline">911</a>
                </div>
                <div>
                  <p className="font-semibold text-neutral-700">Suicide & Crisis Lifeline</p>
                  <a href="tel:988" className="text-pina-pink font-bold hover:underline">988</a>
                  <p className="text-neutral-600">Available 24/7</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-700">Crisis Text Line</p>
                  <p className="text-pina-pink font-bold">Text HOME to 741741</p>
                  <p className="text-neutral-600">Available 24/7</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-700">Domestic Violence Hotline</p>
                  <a href="tel:1-800-799-7233" className="text-pina-pink font-bold hover:underline">1-800-799-7233</a>
                  <p className="text-neutral-600">Available 24/7</p>
                </div>
              </div>
            </div>

            <div className="bg-green-50 rounded-lg p-4">
              <h5 className="font-bold text-neutral-900 mb-3 text-sm">🇲🇽 México</h5>
              <div className="space-y-3 text-xs">
                <div>
                  <p className="font-semibold text-neutral-700">Emergencias</p>
                  <a href="tel:911" className="text-pina-pink font-bold text-lg hover:underline">911</a>
                </div>
                <div>
                  <p className="font-semibold text-neutral-700">SAPTEL (Salud Mental)</p>
                  <a href="tel:5552598121" className="text-pina-pink font-bold hover:underline">55 5259-8121</a>
                  <p className="text-neutral-600">Disponible 24/7</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-700">Línea contra la Violencia</p>
                  <a href="tel:8001084053" className="text-pina-pink font-bold hover:underline">800-108-4053</a>
                  <p className="text-neutral-600">Disponible 24/7</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

/**
 * When to See a Doctor Component
 *
 * Provides guidance on when users should consult healthcare professionals
 */

export function WhenToSeeDoctor({ className = '' }: { className?: string }) {
  return (
    <div className={`card bg-gradient-to-br from-blue-50 to-teal-50 ${className}`}>
      <div className="flex items-start gap-3">
        <span className="text-2xl">👩‍⚕️</span>
        <div>
          <h3 className="font-bold text-neutral-900 mb-3">When to Consult a Healthcare Provider</h3>
          <div className="space-y-4 text-sm text-neutral-700">
            <div>
              <h4 className="font-semibold text-neutral-900 mb-1">Menstrual Cycle Concerns:</h4>
              <ul className="list-disc pl-5 space-y-1">
                <li>Periods lasting longer than 7 days</li>
                <li>Cycles shorter than 21 days or longer than 35 days</li>
                <li>Severe pain that interferes with daily activities</li>
                <li>Sudden changes in flow or cycle pattern</li>
                <li>Bleeding between periods</li>
              </ul>
            </div>

            <div>
              <h4 className="font-semibold text-neutral-900 mb-1">Pregnancy Concerns:</h4>
              <ul className="list-disc pl-5 space-y-1">
                <li>Any vaginal bleeding during pregnancy</li>
                <li>Severe nausea or vomiting</li>
                <li>Reduced fetal movement</li>
                <li>Persistent headaches or vision changes</li>
                <li>Signs of preterm labor</li>
              </ul>
            </div>

            <div>
              <h4 className="font-semibold text-neutral-900 mb-1">General Health:</h4>
              <ul className="list-disc pl-5 space-y-1">
                <li>New or unusual symptoms</li>
                <li>Persistent mood changes or anxiety</li>
                <li>Questions about fertility or contraception</li>
                <li>Concerns about sexual health</li>
              </ul>
            </div>

            <p className="text-xs text-neutral-600 italic mt-4">
              Remember: You know your body best. If something feels wrong, don't hesitate to reach out to a healthcare professional.
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

/**
 * Affiliate Disclosure Component
 *
 * Use this on pages with Amazon affiliate links (blog, product recommendations)
 */

export function AffiliateDisclosure({ className = '' }: { className?: string }) {
  return (
    <div className={`text-xs text-neutral-600 bg-neutral-50 rounded-lg p-3 ${className}`}>
      <p className="font-semibold text-neutral-900 mb-1">Affiliate Disclosure</p>
      <p className="leading-relaxed">
        La Piña participates in the Amazon Services LLC Associates Program and Amazon Mexico Associates Program.
        We may earn a small commission from qualifying purchases made through our affiliate links at no additional cost to you.
        We only recommend products we genuinely believe will benefit your wellness journey.
      </p>
    </div>
  )
}

/**
 * HIPAA Notice Component
 *
 * Clarifies that while we're not a HIPAA-covered entity, we take privacy seriously
 */

export function PrivacyNotice({ className = '' }: { className?: string }) {
  return (
    <div className={`card bg-gradient-to-br from-purple-50 to-pink-50 ${className}`}>
      <div className="flex items-start gap-3">
        <span className="text-2xl">🔒</span>
        <div>
          <h3 className="font-bold text-neutral-900 mb-2">Your Privacy Matters</h3>
          <p className="text-sm text-neutral-700 leading-relaxed mb-3">
            While La Piña is not a HIPAA-covered entity (we're not a healthcare provider), we're committed to protecting your privacy with the same level of care.
          </p>
          <ul className="text-xs text-neutral-700 space-y-1">
            <li>✓ Local-first storage (data stays on your device)</li>
            <li>✓ Optional encrypted cloud backup</li>
            <li>✓ No data selling or advertising</li>
            <li>✓ GDPR and CCPA compliant</li>
          </ul>
          <p className="text-xs text-neutral-600 mt-3">
            <a href="/privacy" className="text-pina-pink hover:underline font-medium">
              Read our Privacy Policy →
            </a>
          </p>
        </div>
      </div>
    </div>
  )
}

/**
 * Educational Purpose Notice
 *
 * Short notice for educational content
 */

export function EducationalNotice({ className = '' }: { className?: string }) {
  return (
    <div className={`bg-purple-50 border-l-4 border-pina-purple p-3 text-xs ${className}`}>
      <p className="text-neutral-700">
        <strong className="text-neutral-900">Educational Content:</strong> This information is for educational purposes only and should not be considered medical advice. Always consult healthcare professionals for personalized medical guidance.
      </p>
    </div>
  )
}

export default MedicalDisclaimer
