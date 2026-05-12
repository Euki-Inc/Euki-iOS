# TestFlight Beta Testing Guide - La Pina

Complete guide for distributing La Pina through TestFlight for beta testing before App Store submission.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Archive and Upload](#archive-and-upload)
3. [TestFlight Setup](#testflight-setup)
4. [Beta Tester Management](#beta-tester-management)
5. [Feedback Collection](#feedback-collection)
6. [Testing Checklist](#testing-checklist)
7. [Common Issues](#common-issues)

---

## Prerequisites

### Apple Developer Account

- [ ] Active Apple Developer Program membership ($99/year)
- [ ] App ID created in Apple Developer portal
- [ ] Distribution certificate installed
- [ ] App Store Connect access configured

### Xcode Configuration

- [ ] Xcode 14.0 or later installed
- [ ] Valid signing certificates
- [ ] Provisioning profiles configured
- [ ] Team selected in project settings

### App Store Connect Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to "My Apps"
3. Click "+" to create new app
4. Fill in app information:
   - **Platform:** iOS
   - **Name:** La Pina
   - **Primary Language:** English (US)
   - **Bundle ID:** Select your bundle identifier
   - **SKU:** Unique identifier (e.g., com.lapina.euki)
   - **User Access:** Full Access

---

## Archive and Upload

### Method 1: Using Xcode (Recommended)

#### Step 1: Prepare for Archive

1. Open your project in Xcode
2. Select your project in the navigator
3. Select your app target
4. Go to "Signing & Capabilities" tab
5. Ensure settings are correct:
   ```
   Automatically manage signing: ✓ (recommended)
   Team: [Your Team Name]
   Provisioning Profile: Automatic
   Signing Certificate: Apple Distribution
   ```

#### Step 2: Set Version and Build Number

1. Select your target → General tab
2. Set version numbers:
   - **Version:** 1.0.0 (semantic versioning)
   - **Build:** 1 (increment for each upload)
3. **Important:** Each upload must have a unique build number

#### Step 3: Select Archive Scheme

1. Product → Scheme → Edit Scheme (⌘<)
2. Select "Archive" from sidebar
3. Ensure Build Configuration is set to **Release**
4. Click Close

#### Step 4: Create Archive

1. In Xcode toolbar, select destination: **"Any iOS Device (arm64)"**
   - Do NOT select a simulator
   - Device doesn't need to be connected
2. Product → Archive (or ⌃⌘A)
3. Wait for archive process to complete
   - This may take 3-10 minutes
   - Watch for any compilation errors
4. Xcode Organizer window will open automatically

#### Step 5: Upload to App Store Connect

1. In Organizer window, select your new archive
2. Click **"Distribute App"**
3. Select **"App Store Connect"**
4. Click **"Next"**
5. Select **"Upload"** (not Export)
6. Click **"Next"**
7. Select distribution options:
   - [ ] Upload your app's symbols (recommended for crash reports)
   - [ ] Manage version and build number (if needed)
8. Click **"Next"**
9. Review signing certificate (should be automatic)
10. Click **"Upload"**
11. Wait for upload to complete
    - Progress bar will show upload status
    - May take 5-15 minutes depending on app size

#### Step 6: Processing in App Store Connect

After upload completes:
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to "My Apps" → "La Pina"
3. Click "TestFlight" tab
4. Wait for build to process
   - Status will show "Processing"
   - Processing typically takes 5-15 minutes
   - You'll receive email when complete
5. Once processed, build will appear under "Builds" section

### Method 2: Using Command Line (Advanced)

#### Using xcodebuild

```bash
# Navigate to project directory
cd /home/user/-la-pina-cdmx/Euki

# Clean build folder
xcodebuild clean -workspace Euki.xcworkspace -scheme Euki

# Create archive
xcodebuild archive \
  -workspace Euki.xcworkspace \
  -scheme Euki \
  -configuration Release \
  -archivePath build/Euki.xcarchive

# Export IPA for App Store
xcodebuild -exportArchive \
  -archivePath build/Euki.xcarchive \
  -exportPath build/ \
  -exportOptionsPlist ExportOptions.plist

# Upload using altool (deprecated in Xcode 14+)
# Use Transporter app or notarytool instead
```

#### Using Fastlane (Recommended for CI/CD)

See `scripts/ios-build-production.sh` for automated script.

### Method 3: Using Transporter App

If you prefer to upload manually:

1. Create IPA using Xcode Export
2. Download [Transporter](https://apps.apple.com/app/transporter/id1450874784) from Mac App Store
3. Open Transporter
4. Sign in with Apple ID
5. Drag and drop IPA file
6. Click "Deliver"
7. Wait for upload confirmation

---

## TestFlight Setup

### Configure Build for Testing

Once build is processed in App Store Connect:

#### Step 1: Add Export Compliance

1. Go to App Store Connect → TestFlight
2. Select your build
3. Under "Export Compliance," click "Provide"
4. Answer questions:
   - **Does your app use encryption?** No (select if true)
   - If yes, follow additional prompts
5. Click "Start Internal Testing" (if ready)

#### Step 2: Add Test Information

1. Select your build
2. Fill in "What to Test" section:
   ```
   Version 1.0.0 - Beta 1

   FOCUS AREAS FOR THIS BUILD:
   - Cycle tracking accuracy
   - Pregnancy tracking features
   - AI insights functionality
   - Spanish language localization
   - Premium subscription flow

   KNOWN ISSUES:
   - [List any known bugs]

   TESTING NOTES:
   - Please test on both WiFi and cellular
   - Try both English and Spanish languages
   - Test subscription purchase (sandbox mode)

   Thank you for testing La Pina!
   ```

#### Step 3: Add Beta App Description

1. In TestFlight → App Information
2. Add Beta App Description:
   ```
   La Pina is your comprehensive women's health companion.

   Track your menstrual cycle, manage pregnancy, and gain
   personalized health insights powered by AI. This beta
   version includes all core features and premium capabilities.

   We value your feedback to make La Pina the best women's
   health app available!
   ```

3. Add Beta App Review Information:
   - **Contact Information:** Your email
   - **Demo Account (if needed):** Provide test credentials

#### Step 4: Configure Feedback Email

1. In App Information
2. Add "Feedback Email": support@lapina.app
3. This email receives feedback from testers

---

## Beta Tester Management

### Internal Testing (Apple's Team)

**Who can test:**
- Members of your App Store Connect team
- Up to 100 internal testers
- No TestFlight review required

**How to add internal testers:**

1. Go to TestFlight → Internal Testing
2. Click "+" next to "Internal Group"
3. Add testers by email
4. Select build to distribute
5. Testers receive invite email immediately
6. No waiting for review

**Use internal testing for:**
- Core development team
- QA team
- Quick iteration cycles
- Pre-external testing validation

### External Testing (Public Beta)

**Who can test:**
- Anyone with an email address
- Up to 10,000 external testers
- Requires TestFlight review (24-48 hours)

**How to add external testers:**

#### Create Test Group

1. Go to TestFlight → External Testing
2. Click "+" to create new group
3. Name the group (e.g., "Beta Testers - Wave 1")
4. Add build to group
5. Submit for TestFlight review

#### Add Testers to Group

**Method 1: Email Invites**
1. Click on your test group
2. Click "+" next to Testers
3. Add email addresses (one per line or CSV import)
4. Add optional personal message
5. Click "Invite"

**Method 2: Public Link**
1. Click on your test group
2. Enable "Public Link"
3. Copy and share the link
4. Anyone with link can join (up to max testers)
5. Best for social media, newsletter, website

**Method 3: TestFlight Public Link**
Example: `https://testflight.apple.com/join/[CODE]`

Share this link on:
- Your website
- Social media
- Email newsletters
- Blog posts

### TestFlight Review Process

**Before submitting for external testing:**

1. Complete export compliance
2. Fill in "What to Test" information
3. Add beta app description
4. Provide demo account (if app requires login)
5. Ensure app doesn't crash on launch

**Submission:**
1. Add build to external test group
2. Click "Submit for Review"
3. Wait for Apple review (usually 24-48 hours)

**Review criteria:**
- App launches without crashing
- Core functionality works
- No inappropriate content
- Complies with TestFlight guidelines

**If rejected:**
- Address feedback from Apple
- Upload new build
- Resubmit for review

---

## Feedback Collection

### Built-in TestFlight Feedback

**How testers provide feedback:**

1. Testers shake device while using app
2. TestFlight overlay appears
3. Option to "Take Screenshot" or "Provide Feedback"
4. Tester writes feedback and submits
5. Feedback includes:
   - Screenshot (optional)
   - Device info
   - iOS version
   - App version

**Viewing feedback:**

1. App Store Connect → TestFlight → Builds
2. Select build
3. Click "Feedback" tab
4. View all feedback submissions
5. Export feedback as needed

### External Feedback Tools

#### Recommended Tools

1. **Crashlytics (Firebase)**
   - Real-time crash reporting
   - Detailed crash logs
   - Integration with Xcode

   Setup:
   ```swift
   import Firebase

   func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       FirebaseApp.configure()
       return true
   }
   ```

2. **TestFlight Feedback Form**
   - Create Google Form or Typeform
   - Include link in app or TestFlight description
   - Collect structured feedback

3. **Slack Channel**
   - Create #beta-feedback channel
   - Invite testers
   - Real-time discussion

4. **Email Feedback**
   - Dedicated email: beta@lapina.app
   - Monitor regularly
   - Respond to critical issues

### Feedback Categories to Track

Create a feedback tracking system:

**Bug Reports:**
- Description
- Steps to reproduce
- Expected vs actual behavior
- Device info
- iOS version
- Screenshots/videos

**Feature Requests:**
- Feature description
- Use case
- Priority level
- Tester count requesting

**User Experience Feedback:**
- Navigation issues
- Confusing UI elements
- Performance problems
- Suggestions for improvement

**Localization Issues:**
- Translation errors
- Cultural appropriateness
- Missing translations

### Feedback Response Process

1. **Acknowledge receipt** (within 24 hours)
2. **Categorize** (bug, feature, UX, etc.)
3. **Prioritize** (critical, high, medium, low)
4. **Track** (use issue tracker like Jira, Linear, GitHub Issues)
5. **Fix and communicate** (let testers know when fixed)
6. **Release new build** with fixes

---

## Testing Checklist

### What to Test - Internal Team

#### Core Functionality
- [ ] App launches successfully
- [ ] Onboarding flow completes
- [ ] User registration/login works
- [ ] Cycle tracking entry and display
- [ ] Pregnancy tracking features
- [ ] Symptom logging
- [ ] AI insights generation
- [ ] Blog content loading
- [ ] Settings and preferences
- [ ] Data persistence (close and reopen app)

#### Premium Features
- [ ] Subscription screen displays
- [ ] Sandbox purchase works
- [ ] Premium features unlock after purchase
- [ ] Restore purchases works
- [ ] Subscription management works

#### Localization
- [ ] English language complete and correct
- [ ] Spanish language complete and correct
- [ ] Language switching works
- [ ] Date/time formats correct per locale
- [ ] Currency displays correctly

#### Performance
- [ ] App loads in < 3 seconds
- [ ] Smooth scrolling in lists
- [ ] No crashes during normal use
- [ ] Memory usage acceptable
- [ ] Battery drain reasonable
- [ ] Network requests complete

#### UI/UX
- [ ] All screens render correctly
- [ ] Navigation flows logically
- [ ] Buttons and taps responsive
- [ ] Images load and display
- [ ] Colors match brand guidelines
- [ ] Text readable on all backgrounds

#### Device Testing
- [ ] iPhone SE (small screen)
- [ ] iPhone 14/15 Pro (standard)
- [ ] iPhone 15 Pro Max (large screen)
- [ ] iPad (if supported)
- [ ] Different iOS versions (13, 14, 15, 16, 17)

#### Edge Cases
- [ ] Poor network connectivity
- [ ] No network connectivity
- [ ] First launch experience
- [ ] Update from previous version
- [ ] Background/foreground transitions
- [ ] Push notification receipt
- [ ] Deep link handling

### What to Test - External Testers

Provide clear testing instructions:

```
TESTING INSTRUCTIONS - La Pina Beta v1.0.0

Thank you for testing La Pina! Please focus on these areas:

1. FIRST IMPRESSIONS
   - Is the onboarding clear and welcoming?
   - Do you understand what the app does?

2. CYCLE TRACKING
   - Log your period start date
   - Add symptoms and moods
   - Check if predictions make sense

3. PREGNANCY TRACKING (if applicable)
   - Enter your due date or LMP
   - Review weekly information
   - Try contraction timer

4. AI INSIGHTS
   - Navigate to Insights section
   - Review personalized recommendations
   - Rate accuracy and helpfulness

5. BLOG & CONTENT
   - Browse health articles
   - Try both English and Spanish content
   - Check if content loads properly

6. PREMIUM SUBSCRIPTION
   - View subscription screen
   - Try sandbox purchase (won't charge)
   - Check if premium features unlock

PLEASE REPORT:
- Any crashes or freezes
- Confusing or broken features
- Translation errors (Spanish)
- Suggestions for improvement

Use TestFlight's built-in feedback (shake device) or email beta@lapina.app

Thank you! 🌸
```

### Testing Phases

#### Phase 1: Internal Testing (Week 1)
- 5-10 internal testers
- Focus on critical bugs
- Test all major features
- Multiple devices and iOS versions

#### Phase 2: Limited External Beta (Week 2-3)
- 50-100 external testers
- Mix of target users
- Collect initial feedback
- Fix critical issues

#### Phase 3: Expanded Beta (Week 4-5)
- 500-1,000 external testers
- Broader demographic
- Stress test servers
- Refine based on feedback

#### Phase 4: Final Beta (Week 6)
- All available testers
- Final validation
- Prepare for public release
- Create App Store materials

---

## Common Issues

### Upload Issues

**Issue:** "Archive not suitable for upload"
**Solution:**
- Ensure you selected "Any iOS Device (arm64)" not simulator
- Check code signing settings
- Verify provisioning profile is valid

**Issue:** "Missing compliance information"
**Solution:**
- Add export compliance in App Store Connect
- Or add to Info.plist:
  ```xml
  <key>ITSAppUsesNonExemptEncryption</key>
  <false/>
  ```

**Issue:** "Invalid code signature"
**Solution:**
- Delete derived data: `~/Library/Developer/Xcode/DerivedData`
- Clean build folder in Xcode
- Re-download certificates and provisioning profiles
- Try manual code signing

### TestFlight Issues

**Issue:** Build stuck in "Processing"
**Solution:**
- Wait at least 30 minutes
- Check for email from Apple (may indicate issue)
- If stuck >2 hours, upload new build

**Issue:** Testers not receiving invites
**Solution:**
- Check spam folders
- Verify email addresses are correct
- Ensure build passed TestFlight review (external)
- Resend invite

**Issue:** "This beta isn't accepting any new testers"
**Solution:**
- Check if you've hit 10,000 tester limit
- Create new test group
- Remove inactive testers

**Issue:** Crash on TestFlight but not in development
**Solution:**
- Check crash logs in App Store Connect
- Enable symbolication (upload dSYM files)
- Test in Release configuration locally
- Check for environment-specific issues

### Subscription Testing Issues

**Issue:** Sandbox purchases not working
**Solution:**
- Create sandbox tester in App Store Connect
- Sign out of real Apple ID on device
- Sign in with sandbox account when purchasing
- Clear sandbox account if having issues

**Issue:** "Cannot connect to iTunes Store"
**Solution:**
- Ensure device has internet connection
- Sign out and back in with sandbox account
- Delete and reinstall app
- Check if In-App Purchases are configured in App Store Connect

---

## Analytics and Monitoring

### Key Metrics to Track

1. **Crash Rate**
   - Target: <1% of sessions
   - Monitor in App Store Connect

2. **Adoption Rate**
   - % of invited testers who install
   - Track in TestFlight metrics

3. **Session Duration**
   - Average time in app
   - Use Firebase Analytics

4. **Feature Usage**
   - Which features are used most
   - Track with analytics events

5. **Feedback Volume**
   - Number of feedback submissions
   - Quality of feedback

### Setting Up Analytics

```swift
// Firebase Analytics
import Firebase
import FirebaseAnalytics

// Track screen view
Analytics.logEvent(AnalyticsEventScreenView,
                   parameters: [AnalyticsParameterScreenName: "CycleTracking",
                              AnalyticsParameterScreenClass: "PinaCycleHomeViewController"])

// Track feature usage
Analytics.logEvent("cycle_logged", parameters: [
    "cycle_day": 1,
    "symptoms_count": 3
])

// Track errors
Analytics.logEvent("error_occurred", parameters: [
    "error_type": "network_failure",
    "screen": "Insights"
])
```

---

## Beta Timeline Template

### 8-Week Beta Program

**Week 1: Internal Testing**
- Upload build 1
- 10 internal testers
- Fix critical bugs
- Upload build 2

**Week 2: Limited External Beta**
- Submit for TestFlight review
- Invite 50 beta testers
- Collect feedback
- Monitor crashes

**Week 3: Feedback Integration**
- Review all feedback
- Fix high-priority issues
- Upload build 3
- Continue testing

**Week 4: Expanded Beta**
- Invite 500 more testers
- Test scalability
- Monitor server load
- Collect more feedback

**Week 5: Polish and Refine**
- Fix UI/UX issues
- Improve performance
- Upload build 4
- Final feature additions

**Week 6: Final Beta**
- Invite all available testers
- Stress test
- Final bug fixes
- Upload build 5 (release candidate)

**Week 7: Release Preparation**
- Create App Store materials
- Write release notes
- Prepare marketing
- Final QA

**Week 8: App Store Submission**
- Submit for App Store review
- Keep TestFlight active
- Monitor for issues
- Prepare for launch

---

## Graduation to Production

### Before Submitting to App Store

- [ ] All critical bugs fixed
- [ ] Positive feedback from testers
- [ ] Crash rate < 1%
- [ ] Performance acceptable
- [ ] Localization complete
- [ ] App Store materials ready
- [ ] Marketing plan in place
- [ ] Support resources prepared

### Keeping TestFlight Active Post-Launch

Even after App Store launch:
- Continue TestFlight for beta features
- Test new versions before public release
- Maintain beta tester community
- Get early feedback on updates

---

## Resources

- [TestFlight Official Guide](https://developer.apple.com/testflight/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Beta Testing Best Practices](https://developer.apple.com/testflight/testers/)

---

## Contact

For TestFlight support:
- Email: beta@lapina.app
- Slack: #beta-testing (for internal team)

---

**Last Updated:** March 2026
**Current Build:** 1.0.0 (1)
**Next Build:** 1.0.0 (2)
