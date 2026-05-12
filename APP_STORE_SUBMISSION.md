# App Store Submission Checklist - La Pina

Complete guide for submitting La Pina to the App Store for review and public release.

## Table of Contents

1. [Pre-Submission Checklist](#pre-submission-checklist)
2. [Required Information](#required-information)
3. [App Store Connect Configuration](#app-store-connect-configuration)
4. [Submission Process](#submission-process)
5. [Common Rejection Reasons](#common-rejection-reasons)
6. [Post-Submission](#post-submission)
7. [Release Management](#release-management)

---

## Pre-Submission Checklist

### Technical Requirements

- [ ] **Minimum iOS Version**: iOS 13.0 or later supported
- [ ] **Device Support**: iPhone and iPad (if applicable)
- [ ] **Orientation**: Portrait and landscape as appropriate
- [ ] **App Size**: Optimized and within reasonable limits (<200MB ideal)
- [ ] **Launch Time**: App launches in under 3 seconds
- [ ] **Performance**: No crashes, smooth scrolling, responsive UI
- [ ] **Memory Usage**: No memory leaks or excessive usage
- [ ] **Battery Usage**: No excessive battery drain
- [ ] **Network**: Handles poor connectivity gracefully
- [ ] **Offline**: Core features work without internet (if applicable)

### Content Requirements

- [ ] **No Placeholder Content**: All screens have real content
- [ ] **No Lorem Ipsum**: All text is final and localized
- [ ] **Images Load**: All images display correctly
- [ ] **Links Work**: All external links are valid and working
- [ ] **Localization**: English and Spanish complete and accurate
- [ ] **Copyright**: No copyrighted content without permission
- [ ] **Trademarks**: No trademark violations
- [ ] **Age-Appropriate**: Content appropriate for target age rating

### Privacy & Security

- [ ] **Privacy Policy**: Published and accessible via URL
- [ ] **Terms of Service**: Published and accessible (if applicable)
- [ ] **Data Collection**: Clearly disclosed in app and Privacy Policy
- [ ] **Permissions**: All permission requests have clear explanations
- [ ] **Info.plist**: All usage descriptions are user-friendly
- [ ] **Data Encryption**: Sensitive data encrypted at rest and in transit
- [ ] **Authentication**: Secure login/signup if applicable
- [ ] **Third-party SDKs**: All disclosed, privacy-compliant
- [ ] **Export Compliance**: Encryption usage documented

### App Store Materials

- [ ] **App Icon**: 1024x1024 PNG without transparency
- [ ] **Screenshots**: All required device sizes created
- [ ] **Screenshots Localized**: English and Spanish versions
- [ ] **App Preview Videos**: Created (optional but recommended)
- [ ] **App Name**: Finalized (max 30 characters)
- [ ] **Subtitle**: Finalized (max 30 characters)
- [ ] **Description**: Written in both languages (max 4,000 characters)
- [ ] **Keywords**: Optimized (max 100 characters)
- [ ] **Promotional Text**: Written (max 170 characters)
- [ ] **What's New**: Release notes written

### Legal & Business

- [ ] **Apple Developer Account**: Active ($99/year paid)
- [ ] **Paid Apps Agreement**: Signed in App Store Connect
- [ ] **Tax & Banking**: Set up if offering paid app/IAP
- [ ] **Contact Information**: Valid email and phone
- [ ] **Support URL**: Live and functional
- [ ] **Marketing URL**: Live and functional (optional)
- [ ] **Copyright**: Correct copyright year and holder
- [ ] **Age Rating**: Accurate based on questionnaire

### In-App Purchases (If Applicable)

- [ ] **IAP Configured**: All subscriptions/products set up
- [ ] **IAP Tested**: Sandbox testing completed
- [ ] **Restore Purchases**: Works correctly
- [ ] **Subscription Management**: Links to App Store subscriptions
- [ ] **Pricing**: Set for all territories
- [ ] **Localizations**: IAP names/descriptions in all languages
- [ ] **Screenshot**: Shows IAP in context

### Testing

- [ ] **TestFlight Testing**: Completed with no critical bugs
- [ ] **Multiple Devices**: Tested on various iPhone/iPad models
- [ ] **iOS Versions**: Tested on supported iOS versions
- [ ] **Fresh Install**: Tested clean install experience
- [ ] **Update Path**: Tested update from previous version (if applicable)
- [ ] **Edge Cases**: Tested poor network, background/foreground, etc.
- [ ] **Accessibility**: VoiceOver and Dynamic Type tested
- [ ] **Rotation**: Tested orientation changes (if supported)

### Code Quality

- [ ] **No Debug Code**: All debug/test code removed
- [ ] **No Hardcoded Credentials**: All sensitive data in Config.plist
- [ ] **Console Logs**: Excessive logging removed
- [ ] **Third-party Libraries**: All up to date
- [ ] **Deprecated APIs**: No use of deprecated APIs
- [ ] **Warnings**: All compiler warnings addressed
- [ ] **Code Signing**: Valid distribution certificate and profile
- [ ] **Bitcode**: Disabled (no longer required)

---

## Required Information

### App Information

Gather this information before starting submission:

#### Basic Information

```
App Name: La Pina
Subtitle: Period Tracker, Pregnancy & Health Insights
Primary Language: English (U.S.)
Bundle ID: com.lapina.euki (or your bundle ID)
SKU: com.lapina.euki.001
```

#### Version Information

```
Version Number: 1.0.0
Build Number: 1 (unique for each upload)
Copyright: 2026 La Pina Inc. (or your entity)
```

#### Categories

```
Primary Category: Health & Fitness
Secondary Category: Medical (or Lifestyle)
```

#### Age Rating

Based on Apple's questionnaire, La Pina will likely be:

```
Age Rating: 12+ or 17+
(Depending on health/medical content detail)

Reason: Medical/Treatment Information, Infrequent/Mild Sexual Content or Nudity
```

**Age Rating Questionnaire Answers:**
- Unrestricted Web Access: No
- Medical/Treatment Information: Frequent/Intense (if detailed health info)
- Sexual Content or Nudity: Infrequent/Mild (if any educational content)
- Alcohol, Tobacco, or Drug Use or References: None
- Profanity or Crude Humor: None
- Horror/Fear Themes: None
- Mature/Suggestive Themes: None
- Violence: None
- Realistic Violence: None
- Cartoon or Fantasy Violence: None
- Gambling: None
- Contests: None

#### Contact Information

```
First Name: [Your First Name]
Last Name: [Your Last Name]
Phone Number: [Your Phone with Country Code]
Email: support@lapina.app
```

#### URLs

```
App Privacy Policy URL: https://lapina.app/privacy
App Support URL: https://lapina.app/support
Marketing URL: https://lapina.app (optional)
```

#### App Review Information

Provide demo account if app requires login:

```
Demo Account Username: demo@lapina.app
Demo Account Password: [Secure Password]

Notes for Reviewer:
"La Pina is a women's health tracking app for menstrual cycles and pregnancy.

To test premium features, use the demo account provided. The subscription is configured for sandbox testing.

Key features to review:
1. Cycle tracking and predictions
2. Pregnancy week-by-week tracking
3. AI-powered health insights (premium)
4. Educational blog content in English and Spanish
5. Symptom and mood logging

All health data is stored locally and encrypted. The app complies with HIPAA privacy guidelines.

For questions, please contact: appreview@lapina.app"
```

---

## App Store Connect Configuration

### Step 1: Create App Record

1. Log in to [App Store Connect](https://appstoreconnect.apple.com)
2. Go to "My Apps"
3. Click the "+" button
4. Select "New App"
5. Fill in:
   - **Platforms**: iOS
   - **Name**: La Pina
   - **Primary Language**: English (U.S.)
   - **Bundle ID**: Select from dropdown (must be registered)
   - **SKU**: Unique identifier (e.g., com.lapina.euki.001)
   - **User Access**: Full Access

### Step 2: App Information

In the App Information section:

1. **Name**: La Pina (max 30 characters)
2. **Subtitle**: Period Tracker, Pregnancy & Health Insights
3. **Privacy Policy URL**: https://lapina.app/privacy
4. **Category**: Primary = Health & Fitness, Secondary = Medical
5. **License Agreement**: Standard Apple EULA (or custom)
6. **Age Rating**: Click "Edit" and complete questionnaire

### Step 3: Pricing and Availability

1. **Price**: Free (with In-App Purchases)
2. **Availability**: All territories (or select specific countries)
3. **Pre-Order**: No (for initial release)
4. **App Store Distribution**: Available

### Step 4: Prepare for Submission

In the "Prepare for Submission" section:

#### Screenshots and Previews

Upload screenshots for all required device sizes:

1. **6.9" Display (iPhone 16 Pro Max)**: Upload 3-10 screenshots
2. **6.7" Display (iPhone 15 Plus)**: Upload 3-10 screenshots
3. **12.9" Display (iPad Pro)**: Upload 3-10 screenshots (if iPad support)

For each set:
- Click "+" to add screenshots
- Drag and drop images in desired order
- First screenshot is most important (shown in search results)
- Repeat for Spanish localization

#### Promotional Text (Optional)

```
Track your cycle, pregnancy, and health with AI-powered insights. Your personal women's health companion. Private, secure, and empowering.
```

**Note**: Promotional text can be updated without new app version.

#### Description

Paste your full app description (see APP_STORE_ASSETS.md for full text).

#### Keywords

```
period tracker,pregnancy,cycle,ovulation,fertility,women's health,menstrual,calendario menstrual
```

**Important**: Max 100 characters, comma-separated, no spaces after commas.

#### Support URL

```
https://lapina.app/support
```

#### Marketing URL (Optional)

```
https://lapina.app
```

#### Version Information

What's New in This Version:

```
Welcome to La Pina 1.0!

Your comprehensive women's health companion is here. Track your menstrual cycle, manage pregnancy, and gain personalized AI-powered health insights.

KEY FEATURES:
🌸 Accurate cycle tracking and predictions
🤰 Week-by-week pregnancy companion
📊 AI-powered personalized insights
💊 Symptom and wellness logging
📚 Expert health content in English & Spanish
🔒 Private and secure - your data, your control

We're excited to support you on your health journey!

Questions or feedback? Contact us at support@lapina.app
```

#### Build

1. Click "Select a build before you submit your app"
2. Choose your processed build from TestFlight
3. Answer export compliance questions:
   - "Does your app use encryption?": No (or Yes if applicable)
   - If Yes, follow prompts for export compliance

#### App Review Information

1. **Sign-in Required**: Yes (if applicable)
2. **Contact Information**:
   - First Name: [Your Name]
   - Last Name: [Your Last Name]
   - Phone: [Your Phone]
   - Email: appreview@lapina.app
3. **Demo Account**:
   - Username: demo@lapina.app
   - Password: [Secure Password]
4. **Notes**:
   ```
   La Pina is a women's health tracking app for menstrual cycles and pregnancy.

   TESTING INSTRUCTIONS:
   1. Log in with provided demo account
   2. Navigate to "Cycle Tracking" to see period predictions
   3. Test "Pregnancy Tracking" feature
   4. View "Insights" for AI-powered recommendations (premium)
   5. Browse "Blog" for health content in English/Spanish

   PREMIUM FEATURES:
   - Subscription is configured for sandbox testing
   - Test subscription purchase flow if needed

   DATA PRIVACY:
   - All health data encrypted locally
   - No data shared with third parties
   - Complies with HIPAA privacy standards

   Contact: appreview@lapina.app for questions
   ```
5. **Attachment**: Upload demo video or screenshots if needed

#### Version Release

Choose release option:
- **Automatically release this version**: App goes live immediately after approval
- **Manually release this version**: You control when to release after approval
- **Schedule for release**: Set specific date/time for release

**Recommendation**: Choose "Manually release" for first version to prepare marketing.

#### App Privacy

Click "Edit" to add privacy details:

1. **Data Collection**: Yes
2. **Data Types Collected**:
   - Health & Fitness (cycle data, pregnancy info, symptoms)
   - Identifiers (email, user ID if applicable)
   - Usage Data (analytics)
3. **Data Use**:
   - App Functionality
   - Analytics
   - Product Personalization
4. **Data Sharing**: None (unless using third-party analytics)
5. **Data Linked to User**: Yes (for personalization)
6. **Data Tracking**: Only if using third-party tracking tools

Complete all questions thoroughly and accurately.

---

## Submission Process

### Final Review Before Submission

Go through this checklist one more time:

- [ ] All information entered correctly
- [ ] Screenshots uploaded for all required sizes
- [ ] Description and keywords optimized
- [ ] Build selected and export compliance answered
- [ ] App Review Information complete with demo account
- [ ] Privacy details filled out
- [ ] Pricing and availability set
- [ ] Age rating assigned

### Submit for Review

1. In "Prepare for Submission", scroll to bottom
2. Click **"Add for Review"** (or "Submit for Review")
3. If using In-App Purchases:
   - Ensure all IAPs are "Ready to Submit"
   - They will be submitted with the app
4. Confirm submission
5. Status will change to **"Waiting for Review"**

### Review Timeline

**Typical timeline:**
- **Submission**: Status = "Waiting for Review"
- **In Review**: 24-48 hours after submission
- **Review Duration**: 1-3 days typically
- **Total Time**: 2-5 days on average (can vary)

**You'll receive emails for:**
- Submission received
- App enters review ("In Review")
- Additional information needed (if applicable)
- Rejection (if applicable) with reasons
- Approval ("Ready for Sale" or pending manual release)

---

## Common Rejection Reasons

### How to Avoid Rejections

#### 1. Guideline 2.1 - App Completeness

**Issue**: App not fully functional, crashes, placeholder content

**How to Avoid**:
- [ ] Test thoroughly before submission
- [ ] Remove all placeholder text/images
- [ ] Ensure no crashes on launch or during review
- [ ] Provide working demo account if login required
- [ ] Test on fresh device/install

#### 2. Guideline 4.0 - Design

**Issue**: Poor UI/UX, inconsistent design, confusing navigation

**How to Avoid**:
- [ ] Follow Apple Human Interface Guidelines
- [ ] Consistent design throughout app
- [ ] Intuitive navigation
- [ ] Proper use of iOS UI elements
- [ ] Readable text and sufficient contrast

#### 3. Guideline 5.1.1 - Privacy

**Issue**: Missing privacy policy, unclear data usage, inappropriate data collection

**How to Avoid**:
- [ ] Privacy Policy URL accessible and thorough
- [ ] All permission requests have clear explanations
- [ ] Info.plist usage descriptions are user-friendly
- [ ] Privacy details in App Store Connect accurate
- [ ] Don't collect unnecessary data

**Example of good usage description**:
```xml
<key>NSCameraUsageDescription</key>
<string>La Pina uses your camera to capture profile photos and health documentation for your personal records.</string>
```

**Bad example**:
```xml
<string>This app needs camera access.</string>
```

#### 4. Guideline 5.1.2 - Data Use and Sharing

**Issue**: Data shared without user consent, tracking without disclosure

**How to Avoid**:
- [ ] Disclose all data collection in Privacy Policy
- [ ] Get explicit consent for data sharing
- [ ] Implement App Tracking Transparency (ATT) if tracking
- [ ] Be transparent about third-party SDKs

#### 5. Guideline 2.3 - Accurate Metadata

**Issue**: Screenshots don't match app, misleading description

**How to Avoid**:
- [ ] Screenshots show actual app functionality
- [ ] Description accurately represents features
- [ ] Don't promise features not yet implemented
- [ ] Keywords relevant to actual app content

#### 6. Guideline 3.1.1 - In-App Purchase

**Issue**: Subscription not properly implemented, alternative payment methods

**How to Avoid**:
- [ ] Use Apple's In-App Purchase for digital goods/subscriptions
- [ ] Restore purchases must work
- [ ] Subscription management links to App Store
- [ ] Pricing clear before purchase
- [ ] Don't link to external payment sites for app features

#### 7. Guideline 4.2 - Minimum Functionality

**Issue**: App too simple, just a website wrapper, not useful

**How to Avoid**:
- [ ] Provide meaningful functionality
- [ ] Not just a web view of existing website
- [ ] Sufficient features to justify an app
- [ ] Better than just using mobile web

#### 8. Guideline 1.4 - Physical Harm

**Issue**: Health app giving medical advice without proper disclaimers

**How to Avoid for La Pina**:
- [ ] Include disclaimer that app is not medical advice
- [ ] Recommend consulting healthcare providers
- [ ] Don't diagnose conditions
- [ ] Be careful with medical terminology

**Example disclaimer** (include in app and description):
```
La Pina is not a medical device and should not replace professional medical advice.
Always consult with a healthcare provider for medical decisions.
```

#### 9. Guideline 2.5 - Software Requirements

**Issue**: Using deprecated APIs, private APIs, crashes on specific iOS versions

**How to Avoid**:
- [ ] Test on minimum iOS version you claim to support
- [ ] Don't use private APIs
- [ ] Update deprecated API calls
- [ ] Handle all iOS versions gracefully

#### 10. Guideline 3.1.2 - Subscriptions

**Issue**: Subscription benefits not clear, auto-renewal not disclosed

**How to Avoid**:
- [ ] Clearly explain what subscription includes
- [ ] Show pricing prominently
- [ ] Explain auto-renewal
- [ ] Easy to find cancellation instructions
- [ ] Provide terms of service link

---

## Post-Submission

### During Review

**What to expect:**
1. **Waiting for Review**: Can take 24-48 hours to enter review
2. **In Review**: Usually 1-3 days
3. **May receive questions**: Apple may ask for clarifications

**If Apple contacts you:**
- Respond quickly (within 24 hours)
- Provide clear, helpful answers
- Include screenshots/videos if helpful
- Be professional and courteous

### If Rejected

**Don't panic!** Rejections are common, especially for first submission.

**Steps to take:**

1. **Read rejection carefully**: Apple provides specific guideline violations
2. **Understand the issue**: Research the guideline mentioned
3. **Fix the problem**: Address all points in rejection
4. **Respond or resubmit**:
   - Use "Resolution Center" to reply if you disagree or need clarification
   - Or fix issues and submit new build

**Common fixes:**
- Update Info.plist usage descriptions
- Improve app review notes with better instructions
- Add missing features or fix bugs
- Update screenshots or description to be more accurate
- Revise privacy policy

**Resubmission:**
1. Upload new build with fixes (increment build number)
2. Update App Store Connect metadata if needed
3. Submit for review again
4. Reference previous rejection in notes if helpful

### If Approved

**Congratulations!** 🎉

**Next steps:**

1. **Check email**: Apple sends approval notification
2. **Status**: Changes to "Pending Developer Release" (if manual release) or "Ready for Sale"
3. **Release**:
   - **Manual**: Go to App Store Connect and click "Release this version"
   - **Automatic**: Already live
4. **Verify**: Check App Store to see your app live
5. **Celebrate**: Share the news with your team and users!

---

## Release Management

### Going Live

#### Pre-Launch Checklist

- [ ] App approved and ready to release
- [ ] Marketing materials prepared (social posts, emails, etc.)
- [ ] Press kit ready (if applicable)
- [ ] Support email monitored
- [ ] Analytics configured
- [ ] Crash reporting active
- [ ] Server capacity checked (if applicable)
- [ ] Team notified of launch

#### Launch Strategy

**Soft Launch** (Recommended for first app):
1. Release to one country first (e.g., US or Mexico)
2. Monitor for critical bugs
3. Address any issues
4. Expand to more countries gradually

**Global Launch**:
1. Release to all territories simultaneously
2. Requires more preparation and monitoring
3. Higher risk but greater visibility

#### Release Day

1. **Morning release recommended**: Gives you time to monitor
2. **Click "Release this version"** in App Store Connect
3. **Wait**: Can take 1-6 hours to appear in App Store
4. **Verify**: Search App Store to confirm it's live
5. **Monitor**: Watch for user feedback, crashes, reviews
6. **Promote**: Share on social media, email list, website

### Post-Launch Monitoring

#### First 24 Hours

- [ ] Check crash reports every few hours
- [ ] Monitor user reviews
- [ ] Respond to support emails quickly
- [ ] Track downloads and installs
- [ ] Monitor server load (if applicable)
- [ ] Check social media mentions

#### First Week

- [ ] Daily check of crash reports
- [ ] Read and respond to reviews
- [ ] Analyze user behavior with analytics
- [ ] Note common feature requests
- [ ] Plan updates based on feedback

#### Metrics to Track

**App Store Connect Analytics**:
- App Units (downloads)
- Impressions
- Product Page Views
- Conversion Rate
- Crashes (Crash Organizer)
- Ratings and Reviews

**In-App Analytics** (Firebase, Mixpanel, etc.):
- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- Session Duration
- Retention Rate (Day 1, Day 7, Day 30)
- Feature Usage
- Conversion to Premium

### Responding to Reviews

**Best practices:**

1. **Respond to all reviews** (especially negative ones)
2. **Be professional and empathetic**
3. **Thank users for positive reviews**
4. **Address concerns in negative reviews**
5. **Don't argue or be defensive**
6. **Offer to help via support email**

**Example responses:**

**Positive review:**
```
Thank you so much for your kind words! We're thrilled that La Pina is helping
you on your health journey. If you ever have suggestions or questions, please
reach out at support@lapina.app 🌸
```

**Negative review:**
```
We're sorry to hear about your experience. Your feedback is valuable and helps
us improve. We'd love to learn more and make this right. Please email us at
support@lapina.app so we can assist you directly. Thank you!
```

**Bug report review:**
```
Thank you for reporting this issue! We've identified the bug and will include
a fix in our next update (coming soon). We appreciate your patience and for
helping us improve La Pina. 🙏
```

### Planning Updates

**Update frequency:**
- **Bug fixes**: As soon as critical bugs are found
- **Minor updates**: Every 2-4 weeks
- **Major updates**: Every 2-3 months

**Update best practices:**
1. Increment version number appropriately (semantic versioning)
2. Write clear "What's New" notes
3. Test thoroughly before submission
4. Consider phased release (gradual rollout)
5. Monitor closely after update release

---

## Version Management

### Semantic Versioning

Use format: **MAJOR.MINOR.PATCH**

**Examples:**
- `1.0.0` - Initial release
- `1.0.1` - Bug fix
- `1.1.0` - New feature (minor)
- `2.0.0` - Major redesign or breaking changes

### Build Numbers

- Increment for every upload to App Store Connect
- Must be unique
- Can use date-based: `202603091` (YYYYMMDDB)
- Or sequential: `1`, `2`, `3`, etc.

### Phased Release

**What is it?**
Gradual rollout over 7 days to small percentage of users first.

**Benefits:**
- Catch critical bugs before all users affected
- Monitor metrics on smaller scale
- Can pause release if issues found

**How to enable:**
1. In App Store Connect → App Store → Version
2. Under "Phased Release", toggle ON
3. Release rollout:
   - Day 1: 1% of users
   - Day 2: 2%
   - Day 3: 5%
   - Day 4: 10%
   - Day 5: 20%
   - Day 6: 50%
   - Day 7: 100%

**When to use:**
- Major updates
- First time releasing to new territories
- After significant code changes

---

## Emergency Procedures

### Critical Bug After Release

If a critical bug is discovered after app goes live:

**Immediate steps:**

1. **Assess severity**:
   - Crashes on launch? → **Extremely Critical**
   - Data loss? → **Critical**
   - Feature broken? → **High Priority**
   - UI glitch? → **Medium Priority**

2. **For Extremely Critical bugs**:
   - Fix immediately
   - Create hotfix build
   - Submit expedited review request
   - Contact Apple through developer support
   - Consider removing app from sale temporarily

3. **For Critical/High Priority bugs**:
   - Fix as soon as possible
   - Test thoroughly
   - Submit update
   - Monitor crash reports

4. **Communicate**:
   - Post status update on social media
   - Email affected users (if possible)
   - Add in-app message about known issue
   - Update App Store description if needed

### Requesting Expedited Review

**When to use:**
- Critical bug affecting many users
- Security vulnerability
- Time-sensitive event or content

**How to request:**
1. Go to App Store Connect
2. Contact Us → App Review
3. Select "Request Expedited Review"
4. Explain the critical issue
5. Provide evidence (crash logs, etc.)
6. Be specific and honest

**Note**: Don't abuse this - only for genuine emergencies.

### Removing App from Sale

**Last resort option** if critical bug can't be fixed immediately:

1. App Store Connect → Pricing and Availability
2. Remove all territories
3. Save
4. App no longer available for download
5. Existing users can still use and update

---

## Checklist: Final Pre-Submission Review

Before clicking "Submit for Review":

- [ ] App fully tested with no critical bugs
- [ ] All screenshots uploaded (all device sizes)
- [ ] App icon uploaded (1024x1024 PNG)
- [ ] Description written and optimized
- [ ] Keywords researched and entered
- [ ] Privacy Policy URL accessible
- [ ] Support URL functional
- [ ] Demo account working (if applicable)
- [ ] App Review Information complete
- [ ] Build selected and export compliance answered
- [ ] Age rating assigned correctly
- [ ] Pricing and availability set
- [ ] In-App Purchases configured (if applicable)
- [ ] App Privacy questionnaire completed
- [ ] Version release option selected
- [ ] "What's New" text written
- [ ] Team notified of submission
- [ ] Support inbox monitored
- [ ] Analytics configured
- [ ] Crash reporting enabled

---

## Resources

### Apple Documentation

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

### Helpful Tools

- [App Store Connect](https://appstoreconnect.apple.com)
- [Apple Developer Portal](https://developer.apple.com/account)
- [App Privacy Policy Generator](https://www.privacypolicies.com/app-privacy-policy-generator/)

### Support

- [Apple Developer Support](https://developer.apple.com/support/)
- [App Review](https://developer.apple.com/contact/app-store/)

---

## Contact

For La Pina specific questions:
- Support Email: support@lapina.app
- App Review Contact: appreview@lapina.app

---

**Good luck with your submission!** 🚀

Remember: Even if you get rejected, it's a normal part of the process. Learn from feedback and resubmit. Most apps get approved within 1-2 submissions.

**Last Updated:** March 2026
**Target App Store Release:** Q2 2026
