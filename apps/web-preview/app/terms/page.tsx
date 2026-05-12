import { Metadata } from 'next'
import Link from 'next/link'

export const metadata: Metadata = {
  title: 'Terms of Service',
  description: 'La Piña Terms of Service - Legal terms and conditions for using our app',
}

export default function TermsOfServicePage() {
  const lastUpdated = '2026-03-09'
  const effectiveDate = '2026-03-09'

  return (
    <div className="w-full min-h-screen bg-neutral-0">
      {/* Header */}
      <div className="bg-gradient-to-br from-pina-purple to-pina-pink text-white py-12 px-4">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-3xl md:text-4xl font-bold mb-3">Terms of Service</h1>
          <p className="text-white/90 text-lg">Legal terms for using La Piña</p>
          <p className="text-white/80 text-sm mt-4">
            Last Updated: {lastUpdated} | Effective: {effectiveDate}
          </p>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto px-4 py-12">
        {/* Critical Disclaimer */}
        <div className="card bg-gradient-to-br from-red-50 to-pink-50 border-2 border-red-200 mb-12">
          <div className="flex items-start gap-3">
            <span className="text-3xl">⚠️</span>
            <div>
              <h2 className="text-xl font-bold text-neutral-900 mb-2">Important: Not Medical Advice</h2>
              <p className="text-neutral-700 leading-relaxed mb-3">
                La Piña is an <strong>educational and wellness tracking tool</strong>. It is <strong>NOT a medical device</strong> and does <strong>NOT provide medical advice, diagnosis, or treatment</strong>.
              </p>
              <p className="text-neutral-700 leading-relaxed mb-3">
                Always consult with qualified healthcare professionals for medical concerns. Do not delay or disregard professional medical advice based on anything you read or track in La Piña.
              </p>
              <p className="text-neutral-700 font-semibold">
                In case of emergency, call 911 (US) or your local emergency number immediately.
              </p>
            </div>
          </div>
        </div>

        {/* Table of Contents */}
        <nav className="card mb-8">
          <h3 className="font-bold text-neutral-900 mb-3">Contents</h3>
          <ol className="space-y-2 text-sm text-pina-pink">
            <li><a href="#acceptance" className="hover:underline">1. Acceptance of Terms</a></li>
            <li><a href="#description" className="hover:underline">2. Service Description</a></li>
            <li><a href="#medical-disclaimer" className="hover:underline">3. Medical Disclaimer</a></li>
            <li><a href="#emergency" className="hover:underline">4. Emergency Resources</a></li>
            <li><a href="#accounts" className="hover:underline">5. User Accounts</a></li>
            <li><a href="#subscription" className="hover:underline">6. Subscription & Payment</a></li>
            <li><a href="#user-conduct" className="hover:underline">7. User Conduct</a></li>
            <li><a href="#intellectual-property" className="hover:underline">8. Intellectual Property</a></li>
            <li><a href="#disclaimer-warranties" className="hover:underline">9. Disclaimer of Warranties</a></li>
            <li><a href="#limitation-liability" className="hover:underline">10. Limitation of Liability</a></li>
            <li><a href="#indemnification" className="hover:underline">11. Indemnification</a></li>
            <li><a href="#termination" className="hover:underline">12. Termination</a></li>
            <li><a href="#governing-law" className="hover:underline">13. Governing Law</a></li>
            <li><a href="#changes" className="hover:underline">14. Changes to Terms</a></li>
            <li><a href="#contact" className="hover:underline">15. Contact Information</a></li>
          </ol>
        </nav>

        {/* 1. Acceptance */}
        <section id="acceptance" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">1. Acceptance of Terms</h2>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              Welcome to La Piña. By accessing or using our mobile application, website, or any related services (collectively, the "Service"), you agree to be bound by these Terms of Service ("Terms").
            </p>
            <p>
              <strong className="text-neutral-900">If you do not agree to these Terms, you may not use the Service.</strong>
            </p>
            <p>
              These Terms constitute a legally binding agreement between you ("you" or "User") and La Piña ("we," "us," or "our").
            </p>
          </div>
        </section>

        {/* 2. Service Description */}
        <section id="description" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">2. Service Description</h2>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              La Piña is a women's wellness application that provides:
            </p>
            <ul className="list-disc pl-6 space-y-2">
              <li><strong>Period Tracking:</strong> Tools to log and track menstrual cycles</li>
              <li><strong>Pregnancy Mode:</strong> Pregnancy tracking and baby development information</li>
              <li><strong>Symptom Logging:</strong> Track physical and emotional symptoms</li>
              <li><strong>Health Insights:</strong> Personalized insights based on your tracked data</li>
              <li><strong>Educational Content:</strong> Blog articles, wellness tips, and resources</li>
              <li><strong>Product Recommendations:</strong> Curated product suggestions (may include affiliate links)</li>
            </ul>

            <div className="card bg-purple-50 mt-6">
              <h3 className="font-bold text-neutral-900 mb-2">Service Features</h3>
              <div className="space-y-2 text-sm text-neutral-700">
                <p><strong>Free Features:</strong> Basic cycle tracking, symptom logging, calendar view</p>
                <p><strong>Premium Features:</strong> Advanced insights, AI-powered predictions, pregnancy mode, unlimited data history, cloud backup, export capabilities</p>
              </div>
            </div>

            <p className="mt-4">
              We reserve the right to modify, suspend, or discontinue any part of the Service at any time with reasonable notice.
            </p>
          </div>
        </section>

        {/* 3. Medical Disclaimer */}
        <section id="medical-disclaimer" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">3. Medical Disclaimer</h2>

          <div className="card bg-gradient-to-br from-yellow-50 to-orange-50 border-2 border-yellow-300 mb-6">
            <h3 className="text-xl font-bold text-neutral-900 mb-3">⚕️ Not a Medical Device</h3>
            <div className="space-y-3 text-neutral-700 leading-relaxed">
              <p>
                <strong>La Piña is NOT a medical device and is NOT intended to diagnose, treat, cure, or prevent any disease or medical condition.</strong>
              </p>
              <p>
                The Service is designed for <strong>educational and informational purposes only</strong>. It is a wellness tracking tool to help you monitor and understand your body, but it should never replace professional medical advice.
              </p>
            </div>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">3.1 No Medical Advice</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              Content provided through La Piña, including but not limited to:
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>Cycle predictions and fertility estimates</li>
              <li>Symptom insights and pattern analysis</li>
              <li>Pregnancy information and baby development milestones</li>
              <li>Blog articles and educational content</li>
              <li>Health tips and recommendations</li>
            </ul>
            <p className="mt-4">
              ...is <strong>NOT medical advice</strong> and should not be treated as such.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">3.2 Consult Healthcare Professionals</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              Always seek the advice of your physician, gynecologist, or other qualified health provider with any questions you may have regarding:
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>Medical conditions or symptoms</li>
              <li>Pregnancy or fertility concerns</li>
              <li>Contraception or family planning</li>
              <li>Unusual or concerning symptoms</li>
              <li>Mental health concerns</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">3.3 Not for Birth Control</h3>
          <div className="card bg-red-50 border border-red-200">
            <p className="text-neutral-900 font-bold mb-2">⚠️ Do NOT Use as Contraception</p>
            <p className="text-neutral-700 text-sm">
              La Piña is <strong>NOT a contraceptive device</strong>. Do not rely on cycle predictions or fertility estimates for birth control purposes. If you wish to prevent pregnancy, consult with a healthcare provider about appropriate contraceptive methods.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">3.4 No Guarantee of Accuracy</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              While we strive for accuracy, we make no guarantees about:
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>The accuracy of cycle predictions or fertility estimates</li>
              <li>The completeness or correctness of health information</li>
              <li>The suitability of recommendations for your specific situation</li>
            </ul>
            <p className="mt-4">
              Every person's body is unique. What works for others may not work for you.
            </p>
          </div>
        </section>

        {/* 4. Emergency Resources */}
        <section id="emergency" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">4. Emergency Resources</h2>

          <div className="card bg-gradient-to-br from-red-50 to-pink-50 border-2 border-red-300 mb-6">
            <h3 className="text-lg font-bold text-neutral-900 mb-3">🚨 When to Seek Immediate Medical Attention</h3>
            <p className="text-neutral-700 mb-3">
              Seek emergency medical care immediately if you experience:
            </p>
            <ul className="list-disc pl-6 space-y-1 text-sm text-neutral-700">
              <li>Severe abdominal pain or cramping that doesn't improve</li>
              <li>Unusually heavy bleeding (soaking through a pad in less than 1 hour)</li>
              <li>Signs of infection: fever over 100.4°F (38°C), foul-smelling discharge</li>
              <li>Sudden severe headache or vision changes</li>
              <li>Chest pain or difficulty breathing</li>
              <li>Signs of ectopic pregnancy: severe one-sided pain, shoulder pain, dizziness</li>
              <li>Severe mood changes, depression, or thoughts of self-harm</li>
            </ul>
          </div>

          <div className="grid md:grid-cols-2 gap-6">
            <div className="card bg-blue-50">
              <h3 className="font-bold text-neutral-900 mb-3">🇺🇸 United States</h3>
              <div className="space-y-3 text-sm">
                <div>
                  <p className="font-semibold text-neutral-900">Emergency</p>
                  <p className="text-pina-pink font-bold text-lg">911</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-900">Suicide & Crisis Lifeline</p>
                  <p className="text-pina-pink font-bold text-lg">988</p>
                  <p className="text-neutral-600 text-xs">Available 24/7</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-900">Crisis Text Line</p>
                  <p className="text-pina-pink font-bold">Text HOME to 741741</p>
                  <p className="text-neutral-600 text-xs">Available 24/7</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-900">Domestic Violence Hotline</p>
                  <p className="text-pina-pink font-bold">1-800-799-7233</p>
                  <p className="text-neutral-600 text-xs">Available 24/7</p>
                </div>
              </div>
            </div>

            <div className="card bg-green-50">
              <h3 className="font-bold text-neutral-900 mb-3">🇲🇽 México</h3>
              <div className="space-y-3 text-sm">
                <div>
                  <p className="font-semibold text-neutral-900">Emergencias</p>
                  <p className="text-pina-pink font-bold text-lg">911</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-900">SAPTEL (Salud Mental)</p>
                  <p className="text-pina-pink font-bold">55 5259-8121</p>
                  <p className="text-neutral-600 text-xs">Disponible 24/7</p>
                </div>
                <div>
                  <p className="font-semibold text-neutral-900">Línea contra la Violencia</p>
                  <p className="text-pina-pink font-bold">800-108-4053</p>
                  <p className="text-neutral-600 text-xs">Disponible 24/7</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* 5. User Accounts */}
        <section id="accounts" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">5. User Accounts</h2>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">5.1 Account Creation</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>To access certain features, you may need to create an account. When creating an account, you agree to:</p>
            <ul className="list-disc pl-6 space-y-2">
              <li>Provide accurate, current, and complete information</li>
              <li>Maintain and update your information to keep it accurate</li>
              <li>Maintain the security of your password and account</li>
              <li>Notify us immediately of any unauthorized access</li>
              <li>Be responsible for all activity under your account</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">5.2 Age Requirement</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              You must be at least 13 years old to use La Piña. If you are under 18, you should discuss using this app with a parent or guardian.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">5.3 Account Security</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>You are responsible for:</p>
            <ul className="list-disc pl-6 space-y-1">
              <li>Choosing a strong, unique password</li>
              <li>Keeping your login credentials confidential</li>
              <li>Enabling device security (passcode/biometrics)</li>
              <li>Logging out of shared devices</li>
            </ul>
          </div>
        </section>

        {/* 6. Subscription & Payment */}
        <section id="subscription" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">6. Subscription & Payment</h2>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">6.1 Premium Subscription</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <div className="card bg-purple-50">
              <h4 className="font-bold text-neutral-900 mb-2">La Piña Premium</h4>
              <p className="text-neutral-700 mb-2"><strong>Price:</strong> $9.99 USD per year</p>
              <p className="text-neutral-700 mb-2"><strong>Billing:</strong> Charged annually to your payment method</p>
              <p className="text-neutral-700 mb-2"><strong>Auto-Renewal:</strong> Automatically renews unless cancelled</p>
            </div>

            <p className="mt-4">Premium features include:</p>
            <ul className="list-disc pl-6 space-y-1">
              <li>AI-powered cycle predictions and insights</li>
              <li>Pregnancy mode and baby development tracker</li>
              <li>Unlimited data history</li>
              <li>Cloud backup and multi-device sync</li>
              <li>Advanced symptom analysis</li>
              <li>Export data capabilities</li>
              <li>Priority customer support</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">6.2 Payment Processing</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              All payments are processed securely through Stripe. By subscribing, you authorize us to charge your payment method.
            </p>
            <p>You agree to:</p>
            <ul className="list-disc pl-6 space-y-1">
              <li>Provide valid payment information</li>
              <li>Pay all fees and applicable taxes</li>
              <li>Update payment information if it changes</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">6.3 Refund Policy</h3>
          <div className="card bg-gradient-to-br from-green-50 to-teal-50">
            <h4 className="font-bold text-neutral-900 mb-2">30-Day Money-Back Guarantee</h4>
            <p className="text-neutral-700 text-sm leading-relaxed">
              If you're not satisfied with La Piña Premium, you can request a full refund within 30 days of your initial purchase. After 30 days, subscription fees are non-refundable.
            </p>
            <p className="text-neutral-700 text-sm mt-2">
              To request a refund, email <a href="mailto:support@lapina.app" className="text-pina-pink hover:underline font-medium">support@lapina.app</a> with your account email and reason for refund.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">6.4 Cancellation</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              You may cancel your subscription at any time from your account settings. Cancellation takes effect at the end of your current billing period.
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>No partial refunds for unused portions of the subscription period</li>
              <li>You retain access to premium features until the end of the paid period</li>
              <li>Your data remains accessible after cancellation</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">6.5 Price Changes</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              We may change subscription prices with 30 days' notice. Price changes won't affect your current subscription period but will apply upon renewal.
            </p>
          </div>
        </section>

        {/* 7. User Conduct */}
        <section id="user-conduct" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">7. User Conduct</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>You agree NOT to:</p>
            <ul className="list-disc pl-6 space-y-2">
              <li>Use the Service for any illegal purpose</li>
              <li>Violate any laws or regulations</li>
              <li>Infringe on others' intellectual property rights</li>
              <li>Transmit harmful code, viruses, or malware</li>
              <li>Attempt to gain unauthorized access to the Service</li>
              <li>Reverse engineer, decompile, or disassemble the app</li>
              <li>Use automated systems (bots, scrapers) without permission</li>
              <li>Share your account credentials with others</li>
              <li>Resell or redistribute the Service</li>
              <li>Use the Service to harm, harass, or impersonate others</li>
            </ul>
          </div>
        </section>

        {/* 8. Intellectual Property */}
        <section id="intellectual-property" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">8. Intellectual Property</h2>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">8.1 Our Rights</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              The Service, including all content, features, functionality, software, code, design, graphics, logos, and trademarks, is owned by La Piña and protected by copyright, trademark, and other intellectual property laws.
            </p>
            <p>
              You are granted a limited, non-exclusive, non-transferable license to use the Service for personal, non-commercial purposes.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">8.2 Your Data Rights</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              You retain all rights to the personal data and health information you input into La Piña. By using the Service, you grant us a limited license to process your data solely to provide the Service to you.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">8.3 Feedback</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              If you provide feedback, suggestions, or ideas about La Piña, you grant us the right to use them without compensation or attribution.
            </p>
          </div>
        </section>

        {/* 9. Disclaimer of Warranties */}
        <section id="disclaimer-warranties" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">9. Disclaimer of Warranties</h2>

          <div className="card bg-neutral-100 border border-neutral-300">
            <div className="space-y-4 text-neutral-700 leading-relaxed text-sm">
              <p className="uppercase font-bold text-neutral-900">
                THE SERVICE IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED.
              </p>
              <p>
                TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, INCLUDING BUT NOT LIMITED TO:
              </p>
              <ul className="list-disc pl-6 space-y-1">
                <li>WARRANTIES OF MERCHANTABILITY</li>
                <li>FITNESS FOR A PARTICULAR PURPOSE</li>
                <li>NON-INFRINGEMENT</li>
                <li>ACCURACY, RELIABILITY, OR AVAILABILITY</li>
              </ul>
              <p>
                WE DO NOT WARRANT THAT:
              </p>
              <ul className="list-disc pl-6 space-y-1">
                <li>The Service will be uninterrupted, secure, or error-free</li>
                <li>Defects will be corrected</li>
                <li>The Service is free of viruses or harmful components</li>
                <li>Results from using the Service will be accurate or reliable</li>
              </ul>
            </div>
          </div>
        </section>

        {/* 10. Limitation of Liability */}
        <section id="limitation-liability" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">10. Limitation of Liability</h2>

          <div className="card bg-neutral-100 border border-neutral-300">
            <div className="space-y-4 text-neutral-700 leading-relaxed text-sm">
              <p className="uppercase font-bold text-neutral-900">
                TO THE MAXIMUM EXTENT PERMITTED BY LAW, LA PIÑA AND ITS AFFILIATES, OFFICERS, EMPLOYEES, AND PARTNERS SHALL NOT BE LIABLE FOR:
              </p>
              <ul className="list-disc pl-6 space-y-2">
                <li>ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES</li>
                <li>LOSS OF PROFITS, REVENUE, DATA, OR USE</li>
                <li>PERSONAL INJURY OR PROPERTY DAMAGE</li>
                <li>ANY DAMAGES ARISING FROM YOUR USE OR INABILITY TO USE THE SERVICE</li>
                <li>ANY MEDICAL COMPLICATIONS, PREGNANCY OUTCOMES, OR HEALTH CONSEQUENCES</li>
                <li>RELIANCE ON PREDICTIONS, INSIGHTS, OR RECOMMENDATIONS PROVIDED BY THE SERVICE</li>
              </ul>
              <p className="mt-4">
                IN NO EVENT SHALL OUR TOTAL LIABILITY EXCEED THE AMOUNT YOU PAID US IN THE 12 MONTHS PRECEDING THE CLAIM (OR $100 USD IF YOU HAVEN'T PAID US ANYTHING).
              </p>
              <p>
                SOME JURISDICTIONS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR EXCLUSIONS OF LIABILITY. IN SUCH JURISDICTIONS, OUR LIABILITY WILL BE LIMITED TO THE MAXIMUM EXTENT PERMITTED BY LAW.
              </p>
            </div>
          </div>
        </section>

        {/* 11. Indemnification */}
        <section id="indemnification" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">11. Indemnification</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              You agree to indemnify, defend, and hold harmless La Piña, its affiliates, officers, directors, employees, and agents from any claims, damages, losses, liabilities, and expenses (including legal fees) arising from:
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>Your use of the Service</li>
              <li>Your violation of these Terms</li>
              <li>Your violation of any rights of another person or entity</li>
              <li>Any content you submit or transmit through the Service</li>
            </ul>
          </div>
        </section>

        {/* 12. Termination */}
        <section id="termination" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">12. Termination</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <h3 className="text-lg font-semibold text-neutral-900 mb-2">12.1 Termination by You</h3>
            <p>
              You may terminate your account at any time through the app settings or by emailing <a href="mailto:support@lapina.app" className="text-pina-pink hover:underline">support@lapina.app</a>.
            </p>

            <h3 className="text-lg font-semibold text-neutral-900 mb-2 mt-6">12.2 Termination by Us</h3>
            <p>
              We reserve the right to suspend or terminate your account if:
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>You violate these Terms</li>
              <li>Your account shows suspicious or fraudulent activity</li>
              <li>We're required to do so by law</li>
              <li>We discontinue the Service</li>
            </ul>

            <h3 className="text-lg font-semibold text-neutral-900 mb-2 mt-6">12.3 Effect of Termination</h3>
            <p>
              Upon termination:
            </p>
            <ul className="list-disc pl-6 space-y-1">
              <li>Your right to use the Service ceases immediately</li>
              <li>Local data remains on your device (you should manually delete it)</li>
              <li>Cloud-backed data is deleted within 30 days</li>
              <li>Provisions that should survive termination (disclaimers, limitations, indemnification) remain in effect</li>
            </ul>
          </div>
        </section>

        {/* 13. Governing Law */}
        <section id="governing-law" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">13. Governing Law & Dispute Resolution</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <h3 className="text-lg font-semibold text-neutral-900 mb-2">13.1 Governing Law</h3>
            <p>
              These Terms are governed by and construed in accordance with the laws of the United States and the State of California, without regard to conflict of law principles.
            </p>

            <h3 className="text-lg font-semibold text-neutral-900 mb-2 mt-6">13.2 Dispute Resolution</h3>
            <p>
              If you have a dispute with La Piña, please contact us first at <a href="mailto:support@lapina.app" className="text-pina-pink hover:underline">support@lapina.app</a> and we'll work to resolve it amicably.
            </p>

            <h3 className="text-lg font-semibold text-neutral-900 mb-2 mt-6">13.3 Arbitration</h3>
            <p>
              Any disputes that cannot be resolved informally shall be resolved through binding arbitration, except that either party may bring suit in court for injunctive relief.
            </p>

            <h3 className="text-lg font-semibold text-neutral-900 mb-2 mt-6">13.4 Class Action Waiver</h3>
            <p>
              You agree that any arbitration or proceeding shall be limited to the dispute between you and La Piña individually. You waive the right to participate in a class action, class arbitration, or representative action.
            </p>
          </div>
        </section>

        {/* 14. Changes to Terms */}
        <section id="changes" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">14. Changes to These Terms</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              We may update these Terms from time to time. When we make changes:
            </p>
            <ul className="list-disc pl-6 space-y-2">
              <li>We'll update the "Last Updated" date at the top</li>
              <li>For material changes, we'll notify you via email or in-app notification</li>
              <li>Changes become effective 30 days after posting (or immediately if required by law)</li>
              <li>Continued use of the Service after changes indicates acceptance</li>
            </ul>
            <p>
              If you don't agree to the updated Terms, you must stop using the Service.
            </p>
          </div>
        </section>

        {/* 15. Contact */}
        <section id="contact" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">15. Contact Information</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              For questions, concerns, or issues regarding these Terms or the Service, please contact us:
            </p>

            <div className="card bg-gradient-to-br from-purple-50 to-pink-50">
              <h3 className="font-bold text-neutral-900 mb-4">La Piña Support</h3>
              <div className="space-y-3 text-neutral-700">
                <div>
                  <p className="font-semibold text-neutral-900">General Support</p>
                  <p>Email: <a href="mailto:support@lapina.app" className="text-pina-pink hover:underline font-medium">support@lapina.app</a></p>
                </div>

                <div>
                  <p className="font-semibold text-neutral-900">Legal Inquiries</p>
                  <p>Email: <a href="mailto:legal@lapina.app" className="text-pina-pink hover:underline font-medium">legal@lapina.app</a></p>
                </div>

                <div>
                  <p className="font-semibold text-neutral-900">Privacy Questions</p>
                  <p>Email: <a href="mailto:privacy@lapina.app" className="text-pina-pink hover:underline font-medium">privacy@lapina.app</a></p>
                </div>

                <p className="text-sm text-neutral-600 mt-4">
                  We aim to respond within 3 business days.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* Acknowledgment */}
        <div className="card bg-gradient-to-br from-purple-100 to-pink-100 border-2 border-pina-pink">
          <h3 className="font-bold text-neutral-900 mb-3">Acknowledgment</h3>
          <p className="text-neutral-700 text-sm leading-relaxed">
            BY USING LA PIÑA, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE, UNDERSTAND THEM, AND AGREE TO BE BOUND BY THEM. YOU ALSO ACKNOWLEDGE THAT LA PIÑA IS NOT A MEDICAL DEVICE AND SHOULD NOT BE USED AS A SUBSTITUTE FOR PROFESSIONAL MEDICAL ADVICE.
          </p>
        </div>

        {/* Footer Navigation */}
        <div className="border-t border-neutral-200 pt-8 mt-12">
          <div className="flex flex-col sm:flex-row gap-4 justify-between items-center">
            <Link href="/privacy" className="text-pina-pink hover:underline font-medium">
              Read Privacy Policy →
            </Link>
            <Link href="/" className="text-neutral-600 hover:text-neutral-900">
              ← Back to App
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
