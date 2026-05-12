# Xcode Integration Guide - La Pina Features

This guide provides step-by-step instructions to integrate all La Pina feature files into your Xcode project for production builds.

## Prerequisites

- Xcode 14.0 or later
- Valid Apple Developer Account
- Project repository cloned locally
- Code signing certificates configured

## File Organization Overview

All La Pina files are located in:
```
Euki/ViewControllers/LaPina/
├── PinaBlogViewController.swift
├── PinaCycleHomeViewController.swift
├── PinaInsightsViewController.swift
├── PinaPaywallViewController.swift
├── PinaPregnancyViewController.swift
├── PinaSettingsViewController.swift
└── PinaSymptomsViewController.swift
```

Additional resources:
```
Euki/Resources/
├── Config.template.plist
├── Config.production-example.plist
└── LaPinaTheme.plist
```

## Step 1: Add View Controllers to Xcode Project

### Method 1: Using Xcode Navigator (Recommended)

1. Open your Euki project in Xcode (`Euki.xcodeproj` or `Euki.xcworkspace`)
2. In the Project Navigator (left sidebar), locate the `ViewControllers` group/folder
3. Right-click on `ViewControllers` → "New Group" → Name it "LaPina"
4. Right-click on the new "LaPina" group → "Add Files to 'Euki'..."
5. Navigate to `Euki/ViewControllers/LaPina/`
6. Select all Swift files:
   - PinaBlogViewController.swift
   - PinaCycleHomeViewController.swift
   - PinaInsightsViewController.swift
   - PinaPaywallViewController.swift
   - PinaPregnancyViewController.swift
   - PinaSettingsViewController.swift
   - PinaSymptomsViewController.swift
7. **Important Options:**
   - ✅ Check "Copy items if needed" (if files are outside project)
   - ✅ Check "Create groups" (NOT "Create folder references")
   - ✅ Under "Add to targets", select your main app target (usually "Euki")
   - ✅ Ensure files will be added to your target's "Compile Sources"
8. Click "Add"

### Method 2: Drag and Drop

1. Open Finder and navigate to `Euki/ViewControllers/LaPina/`
2. Open Xcode with your project
3. Drag all `.swift` files from Finder into the "ViewControllers" group in Xcode
4. When prompted:
   - ✅ Check "Copy items if needed"
   - ✅ Select "Create groups"
   - ✅ Add to your app target
5. Click "Finish"

### Verification

After adding files, verify in Xcode:

1. Select your project in Project Navigator
2. Select your app target
3. Go to "Build Phases" tab
4. Expand "Compile Sources"
5. Verify all 7 La Pina ViewControllers are listed

If any are missing:
- Click the "+" button under "Compile Sources"
- Search for the missing file
- Add it to the list

## Step 2: Add Resource Files

### Add Configuration Plists

1. In Project Navigator, locate the "Resources" group
2. Right-click "Resources" → "Add Files to 'Euki'..."
3. Navigate to `Euki/Resources/`
4. Select:
   - `LaPinaTheme.plist`
   - `Config.production-example.plist` (if using)
5. **Important Options:**
   - ✅ Check "Copy items if needed"
   - ✅ Add to target
   - ✅ Ensure they appear in "Copy Bundle Resources" build phase

### Verification

1. Select your app target
2. Go to "Build Phases" tab
3. Expand "Copy Bundle Resources"
4. Verify `LaPinaTheme.plist` is included
5. If missing, click "+" and add it

## Step 3: Configure Build Settings

### Swift Compiler Settings

1. Select your project → Select app target → "Build Settings"
2. Search for "Swift Language Version"
3. Set to **Swift 5** or later
4. Search for "Optimization Level"
   - Debug: `-Onone` (No optimization)
   - Release: `-O` or `-Osize` (Optimize for speed or size)

### Code Signing

1. In "Build Settings", search for "Code Signing"
2. Set for **Release** configuration:
   - Code Signing Identity: "Apple Distribution" or "iOS Distribution"
   - Development Team: Your team ID
   - Provisioning Profile: "Automatic" or select your Distribution profile

3. For **Debug** configuration:
   - Code Signing Identity: "Apple Development" or "iOS Developer"
   - Development Team: Your team ID
   - Provisioning Profile: "Automatic" or select your Development profile

### Deployment Target

1. Search for "iOS Deployment Target"
2. Set to minimum iOS version (recommend iOS 13.0 or later)
3. Ensure all La Pina features are compatible with this version

## Step 4: Update Info.plist for Production

### Required Permissions

If La Pina features require specific permissions, add to `Info.plist`:

```xml
<!-- Camera Access (for profile photos, etc.) -->
<key>NSCameraUsageDescription</key>
<string>La Pina uses your camera to capture profile photos and health documentation.</string>

<!-- Photo Library Access -->
<key>NSPhotoLibraryUsageDescription</key>
<string>La Pina accesses your photo library to select and save health-related images.</string>

<!-- Calendar Access (for cycle tracking) -->
<key>NSCalendarsUsageDescription</key>
<string>La Pina uses calendar access to track your menstrual cycle and health events.</string>

<!-- Notifications -->
<key>NSUserNotificationsUsageDescription</key>
<string>La Pina sends notifications for cycle reminders and health insights.</string>
```

### Privacy Manifest (iOS 17+)

For iOS 17 and later, you may need a Privacy Manifest (`PrivacyInfo.xcprivacy`):

1. File → New → File
2. Choose "App Privacy" under Resource
3. Configure required APIs and data usage

## Step 5: Verify Dependencies

### Check Pod Dependencies

If using CocoaPods:

```bash
cd Euki/
pod install
```

Ensure all dependencies are installed and up-to-date.

### Check Swift Package Manager

If using SPM:
1. In Xcode, go to File → Packages → Resolve Package Versions
2. Ensure all packages are fetched

### Common Dependencies for La Pina

Verify these are included in your `Podfile` or Package dependencies:
- Alamofire (for networking)
- Kingfisher (for image loading)
- Charts (for insights visualization)
- Any Supabase/Stripe SDKs if integrated

## Step 6: Build and Test

### Clean Build Folder

1. In Xcode menu: Product → Clean Build Folder (⇧⌘K)
2. This ensures no cached build artifacts

### Build for Testing

1. Select a simulator or device target
2. Product → Build (⌘B)
3. Check for any compilation errors

### Common Build Errors and Solutions

#### Error: "No such module 'X'"
**Solution:** Missing dependency
- Check Podfile/Package.swift
- Run `pod install` or resolve packages
- Restart Xcode

#### Error: "Duplicate symbol"
**Solution:** File added multiple times
- Check "Compile Sources" in Build Phases
- Remove duplicates

#### Error: "Code signing error"
**Solution:** Invalid or missing certificate
- Go to Signing & Capabilities tab
- Select correct team
- Download certificates from Apple Developer portal

#### Error: "Use of unresolved identifier"
**Solution:** Missing imports or bridging header
- Ensure all imports are present in Swift files
- Check Bridging Header if using Objective-C

## Step 7: Archive for Production

### Configure Release Scheme

1. Product → Scheme → Edit Scheme (⌘<)
2. Select "Archive" from left sidebar
3. Build Configuration: **Release**
4. Click "Close"

### Create Archive

1. Select "Any iOS Device (arm64)" as destination (not simulator)
2. Product → Archive
3. Wait for archive to complete (appears in Organizer window)

### Upload to App Store Connect

From Xcode Organizer:
1. Select your archive
2. Click "Distribute App"
3. Choose "App Store Connect"
4. Follow prompts for upload

## Step 8: Configuration Management

### Production Configuration

Create `Config.plist` from template:

```bash
cp Euki/Resources/Config.template.plist Euki/Resources/Config.plist
```

Edit with production values:
- SUPABASE_URL: Your production Supabase URL
- SUPABASE_ANON_KEY: Production anonymous key
- STRIPE_PUBLIC_KEY: Production Stripe public key
- BLOG_BASE_URL: Your Vercel blog URL

**IMPORTANT:** Never commit `Config.plist` with real keys to version control!

Add to `.gitignore`:
```
Euki/Resources/Config.plist
```

## Build Configurations Best Practices

### Multiple Configurations

Consider creating separate schemes for:
- **Development:** Uses staging/dev API endpoints
- **Staging:** Pre-production testing environment
- **Production:** Live App Store version

### Environment-Specific Files

Use different Info.plist files:
- `Info-Development.plist`
- `Info-Staging.plist`
- `Info-Production.plist`

Configure in Build Settings:
1. Search for "Info.plist File"
2. Set per-configuration path

## Troubleshooting

### Files Not Compiling

1. Check file is in target membership:
   - Select file in Project Navigator
   - View File Inspector (right sidebar)
   - Ensure target checkbox is checked

2. Verify file is in "Compile Sources":
   - Target → Build Phases → Compile Sources
   - Add if missing

### Resources Not Found at Runtime

1. Check "Copy Bundle Resources":
   - Target → Build Phases → Copy Bundle Resources
   - Add missing .plist files

2. Verify bundle loading code:
   ```swift
   if let path = Bundle.main.path(forResource: "LaPinaTheme", ofType: "plist") {
       // Load plist
   }
   ```

### Build Slow After Adding Files

1. Check for circular dependencies
2. Ensure modular imports
3. Consider using Swift's explicit module builds
4. Use whole module optimization for Release builds

## Continuous Integration

For automated builds (CI/CD):

### Fastlane Integration

See `scripts/ios-build-production.sh` for automated build script.

### GitHub Actions / GitLab CI

Example configuration:
```yaml
- name: Archive app
  run: |
    xcodebuild archive \
      -workspace Euki.xcworkspace \
      -scheme Euki \
      -archivePath build/Euki.xcarchive \
      -configuration Release \
      CODE_SIGNING_REQUIRED=NO
```

## Additional Resources

- [Apple Documentation: Xcode Build System](https://developer.apple.com/documentation/xcode/build-system)
- [Code Signing Guide](https://developer.apple.com/support/code-signing/)
- [TestFlight Distribution](https://developer.apple.com/testflight/)

## Support

For build issues specific to La Pina features:
1. Check error logs in Xcode's Report Navigator
2. Review this integration guide
3. Verify all dependencies are correctly configured
4. Ensure code signing is properly set up

## Checklist

Before submitting to TestFlight/App Store:

- [ ] All La Pina ViewControllers added to Xcode project
- [ ] Files appear in "Compile Sources" build phase
- [ ] Resource plists in "Copy Bundle Resources"
- [ ] Build Settings configured for Release
- [ ] Code signing configured correctly
- [ ] Info.plist updated with required permissions
- [ ] Production Config.plist created with real values
- [ ] Clean build succeeds (⇧⌘K, then ⌘B)
- [ ] Archive created successfully
- [ ] App tested on physical device
- [ ] All dependencies installed and up-to-date
- [ ] No warnings in build output (ideally)
- [ ] Version and build numbers incremented

---

**Last Updated:** March 2026
**Xcode Version:** 14.0+
**iOS Deployment Target:** 13.0+
