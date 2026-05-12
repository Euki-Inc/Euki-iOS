# La Piña - Legal Documents Production Launch Checklist

## ✅ Created Files

### Legal Pages
- [x] `/app/privacy/page.tsx` - Comprehensive Privacy Policy (510 lines)
- [x] `/app/terms/page.tsx` - Complete Terms of Service (621 lines)

### Legal Components
- [x] `/app/legal/disclaimers.tsx` - Reusable disclaimer components (321 lines)
  - MedicalDisclaimer (4 variants)
  - EmergencyResources
  - WhenToSeeDoctor
  - AffiliateDisclosure
  - PrivacyNotice
  - EducationalNotice

### Documentation
- [x] `/app/legal/README.md` - Complete usage guide
- [x] `/app/legal/integration-example.tsx` - Integration examples (8 scenarios)

### Data Files
- [x] `/public/legal.json` - Structured legal data (already existed, verified complete)

---

## 📋 Pre-Launch Checklist

### Phase 1: Legal Documents Review
- [ ] Review Privacy Policy with legal counsel (recommended)
- [ ] Review Terms of Service with legal counsel (recommended)
- [ ] Verify all contact emails are functional:
  - [ ] support@lapina.app
  - [ ] privacy@lapina.app
  - [ ] legal@lapina.app
- [ ] Update company jurisdiction if different from "United States"
- [ ] Add physical mailing address (required in some jurisdictions)

### Phase 2: Component Integration
- [ ] Add MedicalDisclaimer to pregnancy tracking pages
- [ ] Add MedicalDisclaimer to cycle insights pages
- [ ] Add MedicalDisclaimer to symptom tracking pages
- [ ] Add AffiliateDisclosure to all blog posts with Amazon links
- [ ] Add EducationalNotice to educational content
- [ ] Add WhenToSeeDoctor to relevant health pages
- [ ] Add app-wide footer with legal links
- [ ] Add first-launch disclaimer modal (optional but recommended)

### Phase 3: Navigation & Accessibility
- [ ] Add Privacy Policy link to app footer
- [ ] Add Terms of Service link to app footer
- [ ] Add Privacy Policy link to account signup flow
- [ ] Add Terms of Service link to account signup flow
- [ ] Test all internal links (privacy → terms, etc.)
- [ ] Test all external links (Stripe privacy, Amazon privacy, etc.)
- [ ] Verify mobile responsiveness of legal pages
- [ ] Test screen reader accessibility
- [ ] Test keyboard navigation

### Phase 4: Data Privacy Implementation
- [ ] Implement data export functionality (GDPR requirement)
  - [ ] Export to JSON
  - [ ] Export to CSV (optional)
  - [ ] Export to PDF (optional)
- [ ] Implement account deletion functionality (GDPR/CCPA requirement)
  - [ ] Delete local data
  - [ ] Delete cloud backup (if enabled)
  - [ ] Confirm deletion to user
  - [ ] 30-day grace period (optional)
- [ ] Verify local-first storage is working
- [ ] Verify cloud sync is optional and encrypted
- [ ] Implement cookie consent if adding non-essential cookies
- [ ] Verify no tracking/analytics without consent

### Phase 5: Subscription & Payment
- [ ] Verify Stripe integration matches terms ($9.99/year)
- [ ] Implement refund request process (30-day guarantee)
- [ ] Test subscription cancellation flow
- [ ] Verify auto-renewal notifications
- [ ] Test price change notification system
- [ ] Add subscription terms to checkout flow
- [ ] Link to refund policy in subscription settings

### Phase 6: Medical Disclaimers & Safety
- [ ] Verify "Not Medical Advice" disclaimer on ALL health pages
- [ ] Verify "Not for Birth Control" warning on fertility predictions
- [ ] Test emergency resources links (call links on mobile)
- [ ] Add emergency resources to help/support section
- [ ] Consider adding disclaimer to app splash screen
- [ ] Review all AI-generated content for medical claims
- [ ] Add disclaimers to any health predictions
- [ ] Review pregnancy tracking for appropriate warnings

### Phase 7: Affiliate Compliance
- [ ] Verify Amazon Associates account is active
- [ ] Add affiliate disclosure to ALL pages with Amazon links
- [ ] Use correct Amazon affiliate tags (US: -20, MX: varies)
- [ ] Ensure affiliate links open in new tab with noopener
- [ ] Review Amazon Associates Operating Agreement compliance
- [ ] Add "Ad" or "Sponsored" labels if required by jurisdiction

### Phase 8: Testing & Validation
- [ ] Test legal pages on iOS Safari
- [ ] Test legal pages on Android Chrome
- [ ] Test legal pages on desktop Chrome
- [ ] Test legal pages on desktop Firefox
- [ ] Test legal pages on desktop Safari
- [ ] Verify all links work (no 404s)
- [ ] Verify all email links work (mailto:)
- [ ] Verify all phone links work (tel:)
- [ ] Test text readability (Flesch reading ease > 50 recommended)
- [ ] Verify no spelling/grammar errors
- [ ] Check contrast ratios for accessibility (WCAG AA)
- [ ] Test with screen readers (VoiceOver, TalkBack)

### Phase 9: Version Control & Updates
- [ ] Document current version in legal.json (currently 1.0.0)
- [ ] Set up quarterly legal review calendar reminder
- [ ] Create process for notifying users of policy changes
- [ ] Set up email notification system for major changes
- [ ] Archive previous versions of policies
- [ ] Create changelog for legal document updates

### Phase 10: International Considerations
- [ ] Add Spanish translations (if targeting Mexico primarily)
- [ ] Review GDPR compliance for EU users
- [ ] Review CCPA compliance for California users
- [ ] Consider LGPD (Brazil) if expanding to Brazil
- [ ] Add country-specific emergency resources if needed
- [ ] Verify data storage location (US, EU, etc.)
- [ ] Check if you need data processing agreements

---

## 🚨 Critical Pre-Launch Items (Must Complete)

1. **Medical Disclaimer Everywhere**
   - Every page with health info must have disclaimer
   - "Not for birth control" must be prominent
   - Emergency resources must be accessible

2. **Functional Contact Emails**
   - support@lapina.app must work
   - privacy@lapina.app must work
   - Must respond within stated timeframes

3. **Data Rights Implementation**
   - Users must be able to export data
   - Users must be able to delete account
   - Must respond to GDPR/CCPA requests within 30 days

4. **Affiliate Disclosure**
   - Required by FTC (US) and similar laws
   - Must be on EVERY page with affiliate links
   - Must be clear and conspicuous

5. **Terms Acceptance**
   - Users should explicitly accept terms during signup
   - Consider checkbox during onboarding
   - Log acceptance date/time

---

## 📝 Optional Enhancements

### Nice-to-Have Features
- [ ] Add FAQ section to legal pages
- [ ] Create plain-language summaries of legal docs
- [ ] Add "What's New" section for policy updates
- [ ] Create video explanations of key policies
- [ ] Add chatbot for legal questions
- [ ] Translate legal docs to Spanish
- [ ] Add data processing agreements for B2B (if applicable)
- [ ] Create HIPAA compliance documentation (even though not covered entity)

### SEO for Legal Pages
- [ ] Add structured data (Schema.org) to legal pages
- [ ] Optimize meta descriptions
- [ ] Add to sitemap.xml
- [ ] Internal linking from blog to privacy policy
- [ ] Add last updated date prominently

---

## 🔄 Post-Launch Monitoring

### First Week
- [ ] Monitor legal page traffic (verify links working)
- [ ] Check for user questions about policies
- [ ] Monitor support email for privacy/legal questions
- [ ] Test all user-initiated data operations
- [ ] Check refund requests (if any)

### First Month
- [ ] Review data deletion requests (compliance check)
- [ ] Review data export requests (compliance check)
- [ ] Check for any legal inquiries
- [ ] Review affiliate link performance
- [ ] Update FAQ based on user questions

### Quarterly
- [ ] Review legal documents for updates needed
- [ ] Check for new regulations (GDPR, CCPA updates)
- [ ] Review third-party service changes (Stripe, Supabase ToS)
- [ ] Update emergency resources if numbers changed
- [ ] Review medical disclaimer for clarity

---

## 📞 Key Contacts

### Legal Resources
- Legal counsel: [Add contact]
- GDPR consultant: [Add contact if applicable]
- Insurance provider: [Add contact]

### Service Providers
- Stripe support: https://support.stripe.com
- Supabase support: https://supabase.com/support
- Amazon Associates: https://affiliate-program.amazon.com/support

### Emergency Hotlines (Verify Current Numbers)
- US Suicide & Crisis: 988
- US Domestic Violence: 1-800-799-7233
- MX SAPTEL: 55 5259-8121
- MX Violence Hotline: 800-108-4053

---

## ✅ Sign-Off

Before launching to production, confirm:

- [ ] All legal pages are complete and reviewed
- [ ] All components are integrated where needed
- [ ] All data privacy features are implemented
- [ ] All contact emails are functional
- [ ] Emergency resources are current and tested
- [ ] Legal counsel has reviewed (if using legal counsel)
- [ ] Team has read and understands policies
- [ ] Support team trained on legal questions
- [ ] Incident response plan in place

**Final Review Date**: _______________

**Reviewed By**: _______________

**Approved for Production**: [ ] Yes [ ] No

---

## 📚 Additional Resources

### Legal Templates Used
- Privacy Policy: Custom (GDPR/CCPA compliant)
- Terms of Service: Custom (health app focused)
- Medical Disclaimer: Custom (FDA guidance considered)

### Reference Documents
- FTC Endorsement Guidelines: https://www.ftc.gov/legal-library/browse/rules/guides-concerning-use-endorsements-testimonials-advertising
- GDPR Official Text: https://gdpr-info.eu/
- CCPA Official Text: https://oag.ca.gov/privacy/ccpa
- FDA Mobile Medical Apps: https://www.fda.gov/medical-devices/digital-health-center-excellence/mobile-medical-applications

### Tools for Compliance
- Privacy policy generator: (used custom)
- GDPR checklist: https://gdpr.eu/checklist/
- CCPA compliance guide: https://www.oag.ca.gov/privacy/ccpa
- Accessibility checker: WAVE, axe DevTools

---

**Last Updated**: 2026-03-09
**Version**: 1.0.0
