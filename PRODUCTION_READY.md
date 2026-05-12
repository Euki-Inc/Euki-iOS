# iOS Production Preparation - La Pina

This document provides an overview of all production preparation materials created for the La Pina iOS app.

## Overview

All necessary guides, scripts, and configuration files have been created to prepare the La Pina iOS app for TestFlight distribution and App Store submission.

## Created Files

### 1. Xcode Integration Guide
**Location:** `/Euki/ViewControllers/LaPina/XCODE_INTEGRATION.md`

Complete step-by-step instructions for adding all La Pina features to Xcode project:
- Adding ViewControllers to Xcode project
- Configuring build settings
- Code signing setup
- Build troubleshooting
- Verification steps

**Use this when:** Integrating La Pina features into the Xcode project for the first time.

---

### 2. Production Info.plist
**Location:** `/Euki/Support Files/Info-Production.plist`

Production-ready Info.plist configuration including:
- All required privacy permissions with Spanish descriptions
- URL schemes for deep linking
- Background modes configuration
- App Transport Security settings
- Localization support (English & Spanish)

**Use this when:** Configuring the app for production builds.

**Note:** Copy to `Info.plist` or configure in Xcode build settings to use per-configuration.

---

### 3. App Store Assets Guide
**Location:** `/Euki/Resources/APP_STORE_ASSETS.md`

Comprehensive marketing assets guide covering:
- **App Icon Requirements:** All required sizes and specifications
- **Screenshots:** Device sizes, content strategy, design best practices
- **App Preview Videos:** Specifications and creation guidelines
- **App Store Descriptions:** Templates in English and Spanish
- **Keywords & ASO:** Optimized keywords for App Store discoverability
- **Category Recommendations:** Best categories for La Pina

**Use this when:** Creating marketing materials for App Store submission.

---

### 4. TestFlight Beta Guide
**Location:** `/TESTFLIGHT_GUIDE.md` (project root)

Complete TestFlight distribution guide:
- Archive and upload process (Xcode, CLI, Transporter)
- TestFlight configuration in App Store Connect
- Internal vs external testing strategies
- Beta tester management and invitation
- Feedback collection and tracking
- Testing checklist (what to test)
- Common issues and solutions

**Use this when:** Distributing beta builds to testers.

---

### 5. Production Build Script
**Location:** `/scripts/ios-build-production.sh`

Automated production build script with:
- Pre-flight checks (Xcode version, workspace/project detection)
- Code signing verification
- Optional test execution
- Archive creation
- IPA export
- Upload preparation
- Build summary report

**Command line options:**
```bash
./scripts/ios-build-production.sh [options]

Options:
  --skip-tests          Skip running tests before build
  --skip-upload         Create archive but don't upload
  --export-only         Only export IPA, don't upload
  --increment-build     Auto-increment build number
  --clean               Clean build folder before building
```

**Example usage:**
```bash
# Full build with tests
./scripts/ios-build-production.sh

# Quick build without tests
./scripts/ios-build-production.sh --skip-tests

# Build and auto-increment version
./scripts/ios-build-production.sh --increment-build --clean

# Export IPA only (no upload)
./scripts/ios-build-production.sh --export-only
```

**Use this when:** Automating production builds for TestFlight/App Store.

---

### 6. App Store Submission Checklist
**Location:** `/APP_STORE_SUBMISSION.md` (project root)

Complete App Store submission guide:
- **Pre-submission Checklist:** Technical, content, privacy, testing requirements
- **Required Information:** All data needed for submission
- **App Store Connect Setup:** Step-by-step configuration
- **Submission Process:** How to submit for review
- **Common Rejection Reasons:** How to avoid rejections (10+ common issues)
- **Post-Submission:** What happens during and after review
- **Release Management:** Going live and monitoring
- **Emergency Procedures:** Handling critical bugs after release

**Use this when:** Submitting app to App Store for review.

---

### 7. Production Configuration Template
**Location:** `/Euki/Resources/Config.production-example.plist`

Production configuration template with:
- **Supabase:** Production URL and anon key configuration
- **Stripe:** Public key and subscription product IDs
- **Claude AI:** API key for health insights (with security notes)
- **Apify:** Token for content scraping
- **Blog:** Vercel deployment URL
- **Feature Flags:** Enable/disable features in production
- **API Endpoints:** Centralized endpoint configuration
- **Analytics:** GA4, Mixpanel, Amplitude, Sentry
- **Push Notifications:** FCM/OneSignal configuration
- **App Config:** Environment, caching, network settings
- **Content Delivery:** CDN and storage bucket URLs
- **Localization:** Supported languages and regions
- **Support URLs:** Privacy policy, terms, support email
- **Subscriptions:** In-App Purchase product IDs
- **Remote Config:** Minimum version, maintenance mode

**Setup instructions:**
```bash
# Copy template to actual config
cp Euki/Resources/Config.production-example.plist Euki/Resources/Config.plist

# Edit with real production values
# nano Euki/Resources/Config.plist

# Verify it's in .gitignore (already configured)
# grep Config.plist .gitignore
```

**IMPORTANT SECURITY NOTES:**
- Never commit `Config.plist` with real credentials to git
- Use different API keys for dev/staging/production
- Rotate keys regularly
- Store production secrets securely (1Password, AWS Secrets Manager)
- Backend calls preferred over embedding API keys in app

**Use this when:** Setting up production API keys and configuration.

---

## Production Preparation Workflow

### Phase 1: Xcode Setup
1. **Read:** `XCODE_INTEGRATION.md`
2. Add all La Pina ViewControllers to Xcode project
3. Configure build settings and code signing
4. Copy `Info-Production.plist` to `Info.plist` or configure per-configuration
5. Verify build succeeds locally

### Phase 2: Configuration
1. **Copy:** `Config.production-example.plist` → `Config.plist`
2. Fill in production values:
   - Supabase production URL and keys
   - Stripe production public key and price IDs
   - Blog Vercel URL
   - Analytics tokens
3. **Verify:** Config.plist is in `.gitignore` (already set)
4. Test with production endpoints

### Phase 3: Marketing Assets
1. **Read:** `APP_STORE_ASSETS.md`
2. Create app icon (1024x1024 and all required sizes)
3. Design screenshots for all device sizes
4. Localize screenshots (English & Spanish)
5. (Optional) Create app preview videos
6. Write app descriptions using provided templates
7. Optimize keywords for ASO

### Phase 4: TestFlight Distribution
1. **Read:** `TESTFLIGHT_GUIDE.md`
2. Run production build script:
   ```bash
   ./scripts/ios-build-production.sh --clean --increment-build
   ```
3. Upload to App Store Connect (via Xcode Organizer or script)
4. Configure TestFlight settings
5. Add "What to Test" information
6. Invite internal testers (development team)
7. Fix any critical bugs
8. Submit for external TestFlight review
9. Invite external beta testers
10. Collect and address feedback

### Phase 5: App Store Submission
1. **Read:** `APP_STORE_SUBMISSION.md`
2. Complete pre-submission checklist
3. Configure App Store Connect listing
4. Upload all marketing assets
5. Fill in all required information
6. Add app review notes with demo account
7. Complete privacy questionnaire
8. Submit for App Store review
9. Monitor submission status
10. Address any rejection feedback if needed

### Phase 6: Launch
1. App approved by Apple
2. Verify app appears correctly in App Store
3. Release to public (manual or automatic)
4. Monitor crash reports and reviews
5. Respond to user feedback
6. Plan first update based on feedback

---

## Quick Reference

### Important URLs to Configure

Before submission, ensure these URLs are live and functional:

```
Privacy Policy:  https://lapina.app/privacy
Support:         https://lapina.app/support
Terms of Service: https://lapina.app/terms
Marketing Site:  https://lapina.app
Blog:            https://lapina-blog.vercel.app
```

### Required Apple Developer Setup

- [ ] Apple Developer account active ($99/year)
- [ ] App ID created: `com.lapina.euki` (or your bundle ID)
- [ ] Distribution certificate installed
- [ ] App Store Connect app record created
- [ ] Paid Apps Agreement signed
- [ ] Tax & Banking info configured (if using IAP)
- [ ] TestFlight reviewed (for external testing)

### Build Configuration Summary

| Configuration | Use Case | Code Signing | Build Number |
|---------------|----------|--------------|--------------|
| Debug | Development | Apple Development | Any |
| Release | Production/TestFlight | Apple Distribution | Unique per upload |

**Version Numbering:**
- Marketing Version: `1.0.0` (Semantic versioning: MAJOR.MINOR.PATCH)
- Build Number: `1`, `2`, `3`... (Increment for each upload)

### Key Files to Keep Secret

Never commit these to version control:

```
Euki/Resources/Config.plist          # Production API keys
*.mobileprovision                    # Provisioning profiles
*.p12 / *.cer                        # Certificates
Euki.xcarchive                       # Build archives
*.ipa                                # Distribution packages
```

Already protected by `.gitignore` ✓

---

## Checklists

### Pre-TestFlight Checklist

- [ ] All La Pina features integrated in Xcode
- [ ] Build succeeds in Release configuration
- [ ] Code signing configured correctly
- [ ] Config.plist created with production values
- [ ] No hardcoded credentials in code
- [ ] All compiler warnings addressed
- [ ] Tested on multiple devices and iOS versions
- [ ] No crashes or critical bugs
- [ ] Privacy permissions properly described
- [ ] Version and build numbers set

### Pre-App Store Submission Checklist

- [ ] TestFlight testing completed
- [ ] All critical bugs fixed
- [ ] App icon created (all sizes)
- [ ] Screenshots created (all devices)
- [ ] App descriptions written (English & Spanish)
- [ ] Keywords optimized
- [ ] Privacy Policy URL live
- [ ] Support URL functional
- [ ] Demo account working
- [ ] App Review Information complete
- [ ] Age rating assigned correctly
- [ ] In-App Purchases configured (if applicable)

### Post-Launch Checklist

- [ ] App appears correctly in App Store
- [ ] Downloads tracking (App Store Connect Analytics)
- [ ] Crash monitoring active (Crashlytics/Sentry)
- [ ] User reviews monitored
- [ ] Support email monitored
- [ ] Analytics configured (Firebase/Mixpanel)
- [ ] First update planned
- [ ] Marketing materials shared

---

## Troubleshooting

### Build Issues

**Problem:** Archive fails or code signing errors

**Solution:**
1. Check `XCODE_INTEGRATION.md` → "Common Build Errors and Solutions"
2. Verify code signing in Xcode: Target → Signing & Capabilities
3. Delete derived data: `~/Library/Developer/Xcode/DerivedData`
4. Clean build folder: Product → Clean Build Folder (⇧⌘K)
5. Restart Xcode

### Upload Issues

**Problem:** Upload to App Store Connect fails

**Solution:**
1. Check `TESTFLIGHT_GUIDE.md` → "Common Issues"
2. Ensure export compliance is configured
3. Verify provisioning profile is valid
4. Try manual upload via Transporter app
5. Check App Store Connect status page

### Rejection Issues

**Problem:** App rejected by Apple

**Solution:**
1. Read rejection email carefully
2. Check `APP_STORE_SUBMISSION.md` → "Common Rejection Reasons"
3. Fix all issues mentioned
4. Update build and resubmit
5. Use Resolution Center if clarification needed

---

## Support

### Internal Team

For questions about these guides:
- **Technical Lead:** [Your name]
- **Email:** dev@lapina.app
- **Slack:** #ios-production

### External Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [TestFlight Documentation](https://developer.apple.com/testflight/)

---

## Next Steps

### Immediate (This Week)

1. [ ] Review all documentation files
2. [ ] Integrate La Pina features into Xcode (follow XCODE_INTEGRATION.md)
3. [ ] Set up production Config.plist
4. [ ] Create test build locally
5. [ ] Verify all features work in Release configuration

### Short Term (Next 2 Weeks)

1. [ ] Create app icon and marketing assets
2. [ ] Run production build script successfully
3. [ ] Upload first build to TestFlight
4. [ ] Begin internal testing
5. [ ] Create privacy policy and support pages

### Medium Term (Next Month)

1. [ ] Complete TestFlight beta testing
2. [ ] Gather and address feedback
3. [ ] Create App Store screenshots and descriptions
4. [ ] Prepare for App Store submission
5. [ ] Submit for App Store review

### Long Term (Q2 2026)

1. [ ] Launch on App Store
2. [ ] Monitor initial user feedback
3. [ ] Plan first update
4. [ ] Scale marketing efforts
5. [ ] Expand to new markets/languages

---

## File Structure Summary

```
-la-pina-cdmx/
├── Euki/
│   ├── ViewControllers/
│   │   └── LaPina/
│   │       ├── XCODE_INTEGRATION.md        ← Xcode setup guide
│   │       ├── PinaBlogViewController.swift
│   │       ├── PinaCycleHomeViewController.swift
│   │       ├── PinaInsightsViewController.swift
│   │       ├── PinaPaywallViewController.swift
│   │       ├── PinaPregnancyViewController.swift
│   │       ├── PinaSettingsViewController.swift
│   │       └── PinaSymptomsViewController.swift
│   ├── Resources/
│   │   ├── APP_STORE_ASSETS.md             ← Marketing guide
│   │   ├── Config.template.plist
│   │   ├── Config.production-example.plist ← Production config template
│   │   ├── Config.plist                    ← (Create from template - gitignored)
│   │   └── LaPinaTheme.plist
│   └── Support Files/
│       ├── Info.plist
│       └── Info-Production.plist           ← Production Info.plist
├── scripts/
│   └── ios-build-production.sh             ← Automated build script
├── TESTFLIGHT_GUIDE.md                     ← TestFlight distribution guide
├── APP_STORE_SUBMISSION.md                 ← App Store submission guide
├── PRODUCTION_READY.md                     ← This file
└── .gitignore                              ← (Config.plist protected)
```

---

## Version History

### Version 1.0.0 (March 2026)
- Initial production preparation documentation
- All iOS guides and scripts created
- Ready for TestFlight distribution

---

**Last Updated:** March 9, 2026
**Status:** Ready for Production Preparation
**Next Milestone:** TestFlight Beta Release

---

## Quick Start

**New to this project?** Start here:

1. Read `XCODE_INTEGRATION.md` first
2. Integrate La Pina features into Xcode
3. Set up `Config.plist` from template
4. Read `TESTFLIGHT_GUIDE.md`
5. Run production build script
6. Begin TestFlight testing

**Ready to submit?** Follow this path:

1. Complete TestFlight testing
2. Read `APP_STORE_ASSETS.md`
3. Create all marketing materials
4. Read `APP_STORE_SUBMISSION.md`
5. Submit for App Store review
6. Launch! 🚀

---

Good luck with your iOS production launch! 🌸
