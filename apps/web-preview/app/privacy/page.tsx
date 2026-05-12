import { Metadata } from 'next'
import Link from 'next/link'

export const metadata: Metadata = {
  title: 'Privacy Policy',
  description: 'La Piña Privacy Policy - How we protect your personal health data',
}

export default function PrivacyPolicyPage() {
  const lastUpdated = '2026-03-09'

  return (
    <div className="w-full min-h-screen bg-neutral-0">
      {/* Header */}
      <div className="bg-gradient-to-br from-pina-pink to-pina-purple text-white py-12 px-4">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-3xl md:text-4xl font-bold mb-3">Privacy Policy</h1>
          <p className="text-white/90 text-lg">Your privacy is our priority</p>
          <p className="text-white/80 text-sm mt-4">Last Updated: {lastUpdated}</p>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto px-4 py-12">
        {/* Quick Summary */}
        <div className="card bg-gradient-to-br from-purple-50 to-pink-50 mb-12">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">Privacy at a Glance</h2>
          <ul className="space-y-3 text-neutral-700">
            <li className="flex items-start gap-3">
              <span className="text-pina-teal text-xl">✓</span>
              <span><strong>Local-First:</strong> Your health data is stored on your device by default</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-pina-teal text-xl">✓</span>
              <span><strong>No Tracking:</strong> We don't use analytics or advertising trackers</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-pina-teal text-xl">✓</span>
              <span><strong>Your Control:</strong> You own your data and can delete it anytime</span>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-pina-teal text-xl">✓</span>
              <span><strong>Optional Cloud Sync:</strong> Backup is optional and encrypted</span>
            </li>
          </ul>
        </div>

        {/* Table of Contents */}
        <nav className="card mb-8">
          <h3 className="font-bold text-neutral-900 mb-3">Contents</h3>
          <ol className="space-y-2 text-sm text-pina-pink">
            <li><a href="#introduction" className="hover:underline">1. Introduction</a></li>
            <li><a href="#data-collection" className="hover:underline">2. Data Collection</a></li>
            <li><a href="#data-storage" className="hover:underline">3. Data Storage</a></li>
            <li><a href="#data-sharing" className="hover:underline">4. Data Sharing</a></li>
            <li><a href="#third-parties" className="hover:underline">5. Third-Party Services</a></li>
            <li><a href="#cookies" className="hover:underline">6. Cookies & Tracking</a></li>
            <li><a href="#user-rights" className="hover:underline">7. Your Rights</a></li>
            <li><a href="#security" className="hover:underline">8. Security</a></li>
            <li><a href="#children" className="hover:underline">9. Children's Privacy</a></li>
            <li><a href="#changes" className="hover:underline">10. Changes to Policy</a></li>
            <li><a href="#contact" className="hover:underline">11. Contact Us</a></li>
          </ol>
        </nav>

        {/* 1. Introduction */}
        <section id="introduction" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">1. Introduction</h2>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              Welcome to La Piña. We are committed to protecting your privacy and handling your personal health information with the utmost care and respect.
            </p>
            <p>
              This Privacy Policy explains how we collect, use, store, and protect your information when you use our mobile application and website. By using La Piña, you agree to the practices described in this policy.
            </p>
            <p>
              <strong className="text-neutral-900">Our Privacy Philosophy:</strong> We believe your health data belongs to you. That's why we've built La Piña with a local-first architecture, meaning your data stays on your device unless you explicitly choose to enable cloud backup.
            </p>
          </div>
        </section>

        {/* 2. Data Collection */}
        <section id="data-collection" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">2. Data Collection</h2>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">2.1 Health Data You Provide</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>When you use La Piña, you may choose to provide the following types of health information:</p>
            <ul className="list-disc pl-6 space-y-2">
              <li><strong>Menstrual Cycle Data:</strong> Period start/end dates, flow intensity, cycle length</li>
              <li><strong>Symptoms:</strong> Physical and emotional symptoms (cramps, mood, energy levels, etc.)</li>
              <li><strong>Pregnancy Tracking:</strong> Due date, pregnancy week, baby development milestones</li>
              <li><strong>Health Metrics:</strong> Weight, temperature, cervical mucus, ovulation data</li>
              <li><strong>Notes & Logs:</strong> Personal notes, journal entries, custom observations</li>
              <li><strong>Intimacy:</strong> Sexual activity tracking (optional)</li>
            </ul>
            <p className="mt-4">
              <strong className="text-neutral-900">Important:</strong> All health data you enter is stored locally on your device by default. We do not automatically upload or sync this data to our servers.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">2.2 Account Information</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>If you create an account or subscribe to premium features, we collect:</p>
            <ul className="list-disc pl-6 space-y-2">
              <li>Email address</li>
              <li>Name (optional)</li>
              <li>Payment information (processed securely by Stripe - we never see your full card details)</li>
              <li>Subscription status and billing history</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">2.3 Technical Information</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>We may automatically collect minimal technical information:</p>
            <ul className="list-disc pl-6 space-y-2">
              <li>Device type and operating system version (for app compatibility)</li>
              <li>App version number (to ensure you have the latest features)</li>
              <li>Crash reports and error logs (to fix bugs - these do not contain your health data)</li>
              <li>Language preference</li>
            </ul>
            <p className="mt-4">
              <strong className="text-neutral-900">What We DON'T Collect:</strong> We do not use advertising trackers, analytics trackers, or any invasive monitoring tools. We don't track your browsing behavior or sell your data.
            </p>
          </div>
        </section>

        {/* 3. Data Storage */}
        <section id="data-storage" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">3. Data Storage</h2>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">3.1 Local Storage (Default)</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              By default, all your health data is stored locally on your device using secure, encrypted storage. This means:
            </p>
            <ul className="list-disc pl-6 space-y-2">
              <li>Your data never leaves your device unless you enable cloud sync</li>
              <li>We cannot access your health data</li>
              <li>Your data is protected by your device's security (passcode, biometrics)</li>
              <li>If you delete the app, your data is permanently deleted from the device</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">3.2 Cloud Backup (Optional)</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              You may choose to enable cloud backup to sync your data across devices. If you enable this feature:
            </p>
            <ul className="list-disc pl-6 space-y-2">
              <li>Your health data is encrypted before leaving your device</li>
              <li>Data is stored securely on Supabase servers (GDPR and SOC 2 compliant)</li>
              <li>We use end-to-end encryption where possible</li>
              <li>You can disable cloud sync anytime from settings</li>
              <li>Backed-up data is deleted within 30 days of account deletion</li>
            </ul>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">3.3 Data Retention</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <ul className="list-disc pl-6 space-y-2">
              <li><strong>Health Data:</strong> Stored indefinitely on your device until you delete it</li>
              <li><strong>Cloud Backup:</strong> Deleted within 30 days of account deletion</li>
              <li><strong>Account Data:</strong> Retained until you request deletion</li>
              <li><strong>Payment Records:</strong> Retained for 7 years for tax/legal compliance</li>
              <li><strong>Aggregated Analytics:</strong> Retained for 90 days, then deleted</li>
            </ul>
          </div>
        </section>

        {/* 4. Data Sharing */}
        <section id="data-sharing" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">4. Data Sharing</h2>

          <div className="card bg-gradient-to-br from-green-50 to-teal-50 mb-6">
            <p className="text-lg font-semibold text-neutral-900 mb-2">
              We do NOT sell your personal data. Period.
            </p>
            <p className="text-neutral-700">
              Your health information is never sold, rented, or shared for advertising purposes.
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">4.1 When We Share Data</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>We only share your information in these limited circumstances:</p>

            <div className="bg-neutral-50 rounded-lg p-4 mb-4">
              <h4 className="font-semibold text-neutral-900 mb-2">With Your Consent</h4>
              <p>If you explicitly choose to export or share your data (e.g., with your healthcare provider)</p>
            </div>

            <div className="bg-neutral-50 rounded-lg p-4 mb-4">
              <h4 className="font-semibold text-neutral-900 mb-2">Service Providers</h4>
              <p>We share minimal data with trusted service providers who help operate La Piña:</p>
              <ul className="list-disc pl-6 mt-2 space-y-1">
                <li>Stripe (payment processing - they never see your health data)</li>
                <li>Supabase (optional cloud backup - encrypted health data only)</li>
              </ul>
            </div>

            <div className="bg-neutral-50 rounded-lg p-4 mb-4">
              <h4 className="font-semibold text-neutral-900 mb-2">Legal Requirements</h4>
              <p>We may disclose information if required by law, court order, or to protect rights and safety. This would only include the minimum necessary information.</p>
            </div>

            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-2">Business Transfers</h4>
              <p>If La Piña is acquired or merged, your data would be transferred only with your consent or proper notice, and subject to the same privacy protections.</p>
            </div>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3 mt-6">4.2 Aggregated & Anonymized Data</h3>
          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              We may create aggregated, anonymized statistics (e.g., "average cycle length across all users") for research or product improvement. This data cannot be traced back to you individually.
            </p>
          </div>
        </section>

        {/* 5. Third-Party Services */}
        <section id="third-parties" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">5. Third-Party Services</h2>

          <div className="space-y-6">
            <div className="card">
              <h3 className="text-lg font-bold text-neutral-900 mb-2">Stripe (Payment Processing)</h3>
              <p className="text-neutral-700 mb-2">
                <strong>Purpose:</strong> Secure payment processing for subscriptions
              </p>
              <p className="text-neutral-700 mb-2">
                <strong>Data Shared:</strong> Name, email, payment information
              </p>
              <p className="text-neutral-700 mb-2">
                <strong>Health Data:</strong> No health data is shared with Stripe
              </p>
              <a href="https://stripe.com/privacy" target="_blank" rel="noopener noreferrer" className="text-pina-pink hover:underline text-sm">
                View Stripe Privacy Policy →
              </a>
            </div>

            <div className="card">
              <h3 className="text-lg font-bold text-neutral-900 mb-2">Supabase (Cloud Backup)</h3>
              <p className="text-neutral-700 mb-2">
                <strong>Purpose:</strong> Optional encrypted cloud backup and sync
              </p>
              <p className="text-neutral-700 mb-2">
                <strong>Data Shared:</strong> Encrypted health data (only if you enable cloud sync)
              </p>
              <p className="text-neutral-700 mb-2">
                <strong>Security:</strong> SOC 2 Type II certified, GDPR compliant
              </p>
              <a href="https://supabase.com/privacy" target="_blank" rel="noopener noreferrer" className="text-pina-pink hover:underline text-sm">
                View Supabase Privacy Policy →
              </a>
            </div>

            <div className="card">
              <h3 className="text-lg font-bold text-neutral-900 mb-2">Amazon Associates (Affiliate Links)</h3>
              <p className="text-neutral-700 mb-2">
                <strong>Purpose:</strong> Product recommendations in blog content
              </p>
              <p className="text-neutral-700 mb-2">
                <strong>Data Shared:</strong> Click data when you use affiliate links (handled by Amazon)
              </p>
              <p className="text-neutral-700 mb-2">
                <strong>Health Data:</strong> No health data is shared
              </p>
              <a href="https://www.amazon.com/gp/help/customer/display.html?nodeId=468496" target="_blank" rel="noopener noreferrer" className="text-pina-pink hover:underline text-sm">
                View Amazon Privacy Notice →
              </a>
            </div>
          </div>
        </section>

        {/* 6. Cookies & Tracking */}
        <section id="cookies" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">6. Cookies & Tracking</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              La Piña uses minimal cookies and does not use advertising or analytics trackers.
            </p>

            <h3 className="text-lg font-semibold text-neutral-900 mb-3 mt-6">Essential Cookies</h3>
            <div className="bg-neutral-50 rounded-lg p-4">
              <p className="font-medium text-neutral-900 mb-2">Session Cookie</p>
              <p className="text-sm text-neutral-600">
                <strong>Purpose:</strong> User authentication and session management<br />
                <strong>Duration:</strong> Session (deleted when you close the app)<br />
                <strong>Can be disabled:</strong> No (required for app functionality)
              </p>
            </div>

            <h3 className="text-lg font-semibold text-neutral-900 mb-3 mt-6">What We Don't Use</h3>
            <ul className="list-disc pl-6 space-y-2">
              <li>Advertising cookies or trackers</li>
              <li>Third-party analytics (Google Analytics, etc.)</li>
              <li>Social media tracking pixels</li>
              <li>Cross-site tracking</li>
              <li>Behavioral advertising</li>
            </ul>
          </div>
        </section>

        {/* 7. Your Rights */}
        <section id="user-rights" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">7. Your Rights</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed mb-6">
            <p>
              You have comprehensive rights over your personal data. These rights apply regardless of where you live, but are specifically guaranteed under GDPR (European users) and CCPA (California users).
            </p>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">7.1 GDPR Rights (EU/EEA Users)</h3>
          <div className="space-y-3 mb-6">
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Access</h4>
              <p className="text-sm text-neutral-700">Request a copy of all personal data we hold about you</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Rectification</h4>
              <p className="text-sm text-neutral-700">Correct inaccurate or incomplete data</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Erasure ("Right to be Forgotten")</h4>
              <p className="text-sm text-neutral-700">Request deletion of your personal data</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Restrict Processing</h4>
              <p className="text-sm text-neutral-700">Limit how we use your data in certain circumstances</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Data Portability</h4>
              <p className="text-sm text-neutral-700">Export your data in a machine-readable format (available in app settings)</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Object</h4>
              <p className="text-sm text-neutral-700">Object to certain types of processing</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Rights Related to Automated Decision-Making</h4>
              <p className="text-sm text-neutral-700">We do not use automated decision-making or profiling</p>
            </div>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">7.2 CCPA Rights (California Users)</h3>
          <div className="space-y-3 mb-6">
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Know</h4>
              <p className="text-sm text-neutral-700">Know what personal information is collected, used, shared, or sold</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Delete</h4>
              <p className="text-sm text-neutral-700">Request deletion of your personal information</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Opt-Out of Sale</h4>
              <p className="text-sm text-neutral-700">We do not sell personal information, so no opt-out is necessary</p>
            </div>
            <div className="bg-neutral-50 rounded-lg p-4">
              <h4 className="font-semibold text-neutral-900 mb-1">Right to Non-Discrimination</h4>
              <p className="text-sm text-neutral-700">You won't receive discriminatory treatment for exercising your rights</p>
            </div>
          </div>

          <h3 className="text-xl font-semibold text-neutral-900 mb-3">7.3 How to Exercise Your Rights</h3>
          <div className="card bg-gradient-to-br from-purple-50 to-pink-50">
            <p className="text-neutral-700 mb-4">To exercise any of your rights:</p>
            <ul className="list-disc pl-6 space-y-2 text-neutral-700 mb-4">
              <li><strong>Export Data:</strong> Use the "Export Data" feature in app settings</li>
              <li><strong>Delete Data:</strong> Use the "Delete Account" option in settings</li>
              <li><strong>Other Requests:</strong> Email us at <a href="mailto:privacy@lapina.app" className="text-pina-pink hover:underline font-medium">privacy@lapina.app</a></li>
            </ul>
            <p className="text-sm text-neutral-600">We will respond to your request within 30 days.</p>
          </div>
        </section>

        {/* 8. Security */}
        <section id="security" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">8. Security</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              We take the security of your health data seriously and implement industry-standard security measures:
            </p>

            <h3 className="text-lg font-semibold text-neutral-900 mb-3 mt-6">Technical Safeguards</h3>
            <ul className="list-disc pl-6 space-y-2">
              <li><strong>Encryption at Rest:</strong> All data stored on your device is encrypted</li>
              <li><strong>Encryption in Transit:</strong> Data transmitted to cloud backup uses TLS/SSL</li>
              <li><strong>End-to-End Encryption:</strong> Health data is encrypted before cloud backup</li>
              <li><strong>Secure Authentication:</strong> Password hashing with bcrypt, optional biometric login</li>
              <li><strong>Regular Security Audits:</strong> We conduct regular security assessments</li>
            </ul>

            <h3 className="text-lg font-semibold text-neutral-900 mb-3 mt-6">Organizational Safeguards</h3>
            <ul className="list-disc pl-6 space-y-2">
              <li>Limited employee access to personal data (need-to-know basis only)</li>
              <li>Regular security training for team members</li>
              <li>Incident response plan for data breaches</li>
            </ul>

            <h3 className="text-lg font-semibold text-neutral-900 mb-3 mt-6">Your Responsibilities</h3>
            <ul className="list-disc pl-6 space-y-2">
              <li>Use a strong, unique password for your account</li>
              <li>Enable device lock (passcode/biometrics) on your phone</li>
              <li>Keep your app updated to the latest version</li>
              <li>Don't share your account credentials</li>
            </ul>

            <div className="card bg-yellow-50 border-yellow-200 border mt-6">
              <p className="text-neutral-900 font-semibold mb-2">Data Breach Notification</p>
              <p className="text-neutral-700 text-sm">
                In the unlikely event of a data breach that affects your personal information, we will notify you within 72 hours and provide details about what happened and steps to protect yourself.
              </p>
            </div>
          </div>
        </section>

        {/* 9. Children's Privacy */}
        <section id="children" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">9. Children's Privacy</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              La Piña is intended for users aged 13 and older. We do not knowingly collect personal information from children under 13.
            </p>
            <p>
              If you are a parent or guardian and believe your child under 13 has provided us with personal information, please contact us at <a href="mailto:privacy@lapina.app" className="text-pina-pink hover:underline">privacy@lapina.app</a> and we will delete that information.
            </p>
            <p className="text-sm text-neutral-600 italic">
              Note: Users under 18 should discuss using health tracking apps with a parent or guardian.
            </p>
          </div>
        </section>

        {/* 10. Changes to Policy */}
        <section id="changes" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">10. Changes to This Policy</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements.
            </p>
            <p>
              When we make changes:
            </p>
            <ul className="list-disc pl-6 space-y-2">
              <li>We'll update the "Last Updated" date at the top of this page</li>
              <li>For significant changes, we'll notify you via email or in-app notification</li>
              <li>You'll have the opportunity to review changes before they take effect</li>
              <li>Continued use of La Piña after changes indicates acceptance</li>
            </ul>
            <p>
              Previous versions of this policy are available upon request.
            </p>
          </div>
        </section>

        {/* 11. Contact */}
        <section id="contact" className="mb-12 scroll-mt-8">
          <h2 className="text-2xl font-bold text-neutral-900 mb-4">11. Contact Us</h2>

          <div className="space-y-4 text-neutral-700 leading-relaxed">
            <p>
              If you have questions, concerns, or requests regarding this Privacy Policy or your personal data, please contact us:
            </p>

            <div className="card bg-gradient-to-br from-purple-50 to-pink-50">
              <h3 className="font-bold text-neutral-900 mb-4">La Piña Privacy Team</h3>
              <div className="space-y-2 text-neutral-700">
                <p><strong>General Privacy Inquiries:</strong></p>
                <p>Email: <a href="mailto:privacy@lapina.app" className="text-pina-pink hover:underline font-medium">privacy@lapina.app</a></p>

                <p className="mt-4"><strong>Support:</strong></p>
                <p>Email: <a href="mailto:support@lapina.app" className="text-pina-pink hover:underline font-medium">support@lapina.app</a></p>

                <p className="mt-4 text-sm text-neutral-600">
                  We aim to respond to all inquiries within 3 business days.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* Footer Navigation */}
        <div className="border-t border-neutral-200 pt-8 mt-12">
          <div className="flex flex-col sm:flex-row gap-4 justify-between items-center">
            <Link href="/terms" className="text-pina-pink hover:underline font-medium">
              Read Terms of Service →
            </Link>
            <Link href="/" className="text-neutral-600 hover:text-neutral-900">
              ← Back to App
            </Link>
          </div>
        </div>

        {/* Compliance Badges */}
        <div className="mt-8 flex flex-wrap gap-3 justify-center">
          <div className="badge badge-success">GDPR Compliant</div>
          <div className="badge badge-success">CCPA Compliant</div>
          <div className="badge badge-primary">Privacy-First</div>
          <div className="badge badge-primary">Local-First Storage</div>
        </div>
      </div>
    </div>
  )
}
