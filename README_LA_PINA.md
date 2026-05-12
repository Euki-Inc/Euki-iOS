# 🍍 LA PIÑA - Build & Deployment Guide

**Version:** 1.0.0
**Date:** January 31, 2026
**Status:** MVP Complete - Ready for Development Testing

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [What's Been Built](#whats-been-built)
4. [Directory Structure](#directory-structure)
5. [Quick Start](#quick-start)
6. [iOS Development](#ios-development)
7. [Web Preview Development](#web-preview-development)
8. [Deployment](#deployment)
9. [Configuration & Secrets](#configuration--secrets)
10. [Testing](#testing)
11. [Next Steps](#next-steps)
12. [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

**La Piña** is a next-generation women's wellness app forked from Euki, offering:
- 📅 **Cycle Tracking** - Period logging, predictions, and fertility windows
- 💭 **Symptom Logging** - Mood, body symptoms, sleep, and journal notes
- 👶 **Pregnancy Mode** - Fetal development tracking and trimester guides
- 💡 **Health Insights** - AI-powered irregularity detection and recommendations
- 📚 **Luxury Blog** - AR flipbook with wellness content and affiliate products
- 🎁 **Premium Subscription** - $9.99/year unlock via Stripe

### Design Language
- **Colors:** Piña Pink (#E10098), Purple (#8E44AD), Yellow (#FFD600), Teal (#00BFB3)
- **Style:** Bubble design, soft gradients, spiral transitions
- **Logo:** Metallic slinky spiral pineapple

### Key Differentiators from Flo
✅ **Privacy-first** - All data stored locally, no cloud tracking
✅ **Cultural warmth** - Latina wellness guide "Piña Buddy"
✅ **Luxury content** - High-end affiliate products and empowerment focus
✅ **Open source** - GNU GPL v3.0 license

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────┐
│                  CLIENT PLATFORMS                    │
├─────────────────────────────────────────────────────┤
│                                                       │
│  iOS (Swift/UIKit)          Web Preview (Next.js)   │
│  ├── ViewControllers        ├── App Router          │
│  ├── Managers (Stubs)       ├── Components          │
│  ├── Models                 ├── Pages (5 tabs)      │
│  └── Resources              └── Lib (utils)         │
│                                                       │
└─────────────────────────────────────────────────────┘
           │                            │
           ▼                            ▼
┌─────────────────────────────────────────────────────┐
│              STUB SERVICES (No Real APIs)           │
├─────────────────────────────────────────────────────┤
│  • PinaSupabaseStub      (Auth)                     │
│  • PinaStripeStub        (Payments)                 │
│  • PinaClaudeStub        (AI Companion)             │
│  • PinaApifyStub         (Trend Scraping)           │
│  • PinaContextStub       (MCP Personalization)      │
│  • PinaMockData          (Static Data)              │
└─────────────────────────────────────────────────────┘
```

### Current State: **STUB MODE**
- ✅ All UI components functional
- ✅ Mock data throughout
- ✅ No real API calls
- ⚠️ Ready for backend integration later

---

## ✅ What's Been Built

### Specifications (5 files)
- `specs/la_pina_master_spec.json` - Product requirements and modules
- `specs/theme.json` - Color palette, typography, animations
- `specs/navigation.json` - Tab structure and routing
- `specs/data_seed.json` - Mock cycles, symptoms, pregnancy data, blog posts
- `specs/agent_prompts.json` - Piña Buddy AI persona and routing
- `specs/reuse_map.json` - Euki controller reuse strategy

### Web Preview (24 files)
Complete Next.js App Router application in `apps/web-preview/`:
- ✅ 5 tab pages (Cycle, Symptoms, Pregnancy, Insights, Blog)
- ✅ Responsive mobile-first design
- ✅ La Piña theme with gradients and animations
- ✅ Mock data integration
- ✅ Premium paywall card
- ✅ Deployable to Vercel in minutes

### iOS App (20+ new files)
Swift/UIKit components in `Euki/`:
- ✅ 7 ViewControllers (Cycle, Symptoms, Pregnancy, Insights, Blog, Paywall, Settings)
- ✅ 7 Stub managers (Supabase, Stripe, Claude, Apify, Context, Env, MockData)
- ✅ UIColor+LaPina extension
- ✅ Theme resources (LaPinaTheme.plist)
- ✅ Config template (Config.template.plist)
- ✅ Navigation updated to 5-tab structure

### Deployment (3 files)
- `deployment/vercel/vercel.json` - Vercel config
- `deployment/vercel/deploy.sh` - Automated deployment script
- `deployment/vercel/README.md` - Deployment instructions

---

## 📁 Directory Structure

```
-la-pina-cdmx/
├── specs/                          # Product specifications
│   ├── la_pina_master_spec.json
│   ├── theme.json
│   ├── navigation.json
│   ├── data_seed.json
│   ├── agent_prompts.json
│   └── reuse_map.json
│
├── apps/web-preview/               # Next.js web app
│   ├── app/                        # App Router pages
│   │   ├── cycle/page.tsx
│   │   ├── symptoms/page.tsx
│   │   ├── pregnancy/page.tsx
│   │   ├── insights/page.tsx
│   │   ├── blog/page.tsx
│   │   ├── layout.tsx
│   │   └── globals.css
│   ├── components/                 # React components
│   │   ├── TabNav.tsx
│   │   ├── SpiralHeader.tsx
│   │   ├── PaywallCard.tsx
│   │   └── MockChart.tsx
│   ├── lib/                        # Utilities
│   │   ├── theme.ts
│   │   ├── data.ts
│   │   ├── stubs.ts
│   │   └── env.ts
│   ├── package.json
│   ├── next.config.js
│   ├── tsconfig.json
│   ├── .env.example
│   └── README.md
│
├── deployment/vercel/              # Deployment scripts
│   ├── vercel.json
│   ├── deploy.sh
│   └── README.md
│
├── Euki/                           # iOS app (Swift)
│   ├── ViewControllers/
│   │   ├── LaPina/                 # New controllers
│   │   │   ├── PinaCycleHomeViewController.swift
│   │   │   ├── PinaSymptomsViewController.swift
│   │   │   ├── PinaPregnancyViewController.swift
│   │   │   ├── PinaInsightsViewController.swift
│   │   │   ├── PinaBlogViewController.swift
│   │   │   ├── PinaPaywallViewController.swift
│   │   │   └── PinaSettingsViewController.swift
│   │   └── Main/
│   │       └── EUKMainViewController.swift (updated)
│   ├── Managers/
│   │   └── LaPina/                 # Stub services
│   │       ├── PinaEnv.swift
│   │       ├── PinaMockData.swift
│   │       ├── PinaSupabaseStub.swift
│   │       ├── PinaStripeStub.swift
│   │       ├── PinaClaudeStub.swift
│   │       ├── PinaApifyStub.swift
│   │       └── PinaContextStub.swift
│   ├── Extensions/
│   │   └── UIColor+LaPina.swift
│   └── Resources/
│       ├── LaPinaTheme.plist
│       ├── Config.template.plist
│       └── ASSETS_TODO.txt
│
├── .gitignore                      # Updated with new paths
├── README.md                       # Original Euki readme
├── README_LA_PINA.md              # This file
└── AUDIT_REPORT.md                 # Initial audit findings
```

---

## 🚀 Quick Start

### Prerequisites
- **iOS Development:** Xcode 12+, macOS, CocoaPods
- **Web Development:** Node.js 18+, npm or yarn
- **Deployment:** Vercel account (free tier works)

### 1. Clone & Setup
```bash
cd /path/to/-la-pina-cdmx

# Install iOS dependencies
pod install

# Install web dependencies
cd apps/web-preview
npm install
```

### 2. Run Web Preview
```bash
cd apps/web-preview
npm run dev
```
Open [http://localhost:3000](http://localhost:3000)

### 3. Run iOS App
```bash
# Create config file
cp Euki/Resources/Config.template.plist Euki/Resources/Config.plist

# Open in Xcode
open Euki.xcworkspace

# Build and run (⌘R)
```

---

## 📱 iOS Development

### Adding La Piña Files to Xcode

**IMPORTANT:** New Swift files must be added to the Xcode project:

1. Open `Euki.xcworkspace` in Xcode
2. Right-click on `Euki` folder → "Add Files to 'Euki'..."
3. Navigate to and select:
   - `Euki/ViewControllers/LaPina/` (all 7 files)
   - `Euki/Managers/LaPina/` (all 7 files)
   - `Euki/Extensions/UIColor+LaPina.swift`
   - `Euki/Resources/LaPinaTheme.plist`
   - `Euki/Resources/Config.template.plist`
4. ✅ Check "Copy items if needed"
5. ✅ Check "Euki" target
6. Click "Add"

### Configuration Setup

1. **Create Config.plist** (local only, gitignored):
```bash
cp Euki/Resources/Config.template.plist Euki/Resources/Config.plist
```

2. **Edit Config.plist** in Xcode:
```xml
<key>BLOG_BASE_URL</key>
<string>http://localhost:3000</string>
<!-- Leave other keys empty for stub mode -->
```

3. **Add Config.plist to Xcode** (same process as above)

### Tab Bar Icons

Update or create these assets in `Euki/Resources/Assets.xcassets/`:
- `IconNavCycleOn` / `IconNavCycleOff`
- `IconNavSymptomsOn` / `IconNavSymptomsOff`
- `IconNavPregnancyOn` / `IconNavPregnancyOff`
- `IconNavInsightsOn` / `IconNavInsightsOff`
- `IconNavBlogOn` / `IconNavBlogOff`

See `Euki/Resources/ASSETS_TODO.txt` for specifications.

### Testing iOS App

```bash
# Build via command line
xcodebuild -workspace Euki.xcworkspace \
           -scheme Euki \
           -configuration Debug \
           -destination 'platform=iOS Simulator,name=iPhone 14' \
           build
```

Or use Xcode:
- Select simulator (iPhone 14 or later)
- Press ⌘R to build and run
- Navigate through 5 tabs (Cycle, Symptoms, Pregnancy, Insights, Blog)

### iOS Stub Services

All services return mock data without network calls:

```swift
// Example: Mock login
PinaSupabaseStub.sharedInstance.login(email: "test@example.com", password: "password") { result in
    switch result {
    case .success(let user):
        print("Logged in: \(user.email)")
    case .failure(let error):
        print("Error: \(error)")
    }
}

// Example: Mock subscription
PinaStripeStub.sharedInstance.purchaseSubscription(productId: "premium_annual", price: "$9.99") { result in
    // Returns success with mock subscription
}

// Example: Mock AI chat
PinaClaudeStub.sharedInstance.sendMessage("What is ovulation?") { response in
    print(response) // Returns canned wellness advice
}
```

---

## 🌐 Web Preview Development

### Local Development

```bash
cd apps/web-preview

# Development server with hot reload
npm run dev

# Production build test
npm run build
npm start
```

### Environment Variables (Optional)

Create `apps/web-preview/.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your-url-here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-key-here
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=pk_test_xxx
CLAUDE_API_KEY=sk-ant-xxx
APIFY_TOKEN=apify_api_xxx
```

**App works perfectly with empty values** - all features use stubs.

### File Structure

```
apps/web-preview/
├── app/
│   ├── layout.tsx          # Root layout with TabNav
│   ├── page.tsx            # Home (redirects to /cycle)
│   ├── globals.css         # Theme styles
│   ├── cycle/page.tsx      # Calendar & period tracking
│   ├── symptoms/page.tsx   # Mood/body/sleep tracker
│   ├── pregnancy/page.tsx  # Fetal development timeline
│   ├── insights/page.tsx   # Health analytics dashboard
│   └── blog/page.tsx       # Luxury wellness articles
├── components/
│   ├── TabNav.tsx          # Bottom navigation (5 tabs)
│   ├── SpiralHeader.tsx    # Animated pineapple header
│   ├── PaywallCard.tsx     # Premium upsell
│   └── MockChart.tsx       # Cycle trend visualization
└── lib/
    ├── theme.ts            # Brand colors & config
    ├── data.ts             # Mock data loader
    ├── stubs.ts            # API stubs
    └── env.ts              # Environment helpers
```

### Customizing Pages

Edit any page in `apps/web-preview/app/*/page.tsx`:

```tsx
// Example: Add new feature to Cycle page
export default function CyclePage() {
  const { cycles } = useMockData();

  return (
    <div>
      <SpiralHeader title="Cycle Tracking" color="#E10098" />
      {/* Add your new feature here */}
      <MyCustomComponent />
    </div>
  );
}
```

### Adding New Components

```bash
# Create new component
touch apps/web-preview/components/MyComponent.tsx
```

```tsx
// apps/web-preview/components/MyComponent.tsx
import { theme } from '@/lib/theme';

export function MyComponent() {
  return (
    <div style={{ background: theme.colors.primary }}>
      My Component
    </div>
  );
}
```

---

## 🚀 Deployment

### Web Preview to Vercel

#### Option 1: Automated (with Vercel token)
```bash
cd /path/to/-la-pina-cdmx

# Set Vercel token
export VERCEL_TOKEN=your-vercel-token-here

# Run deployment script
bash deployment/vercel/deploy.sh
```

#### Option 2: Manual
```bash
cd apps/web-preview

# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel --prod
```

Your app will be live at: `https://your-project.vercel.app`

#### Configure Production Secrets in Vercel

1. Go to Vercel dashboard → Your project → Settings → Environment Variables
2. Add optional secrets:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `NEXT_PUBLIC_STRIPE_PUBLIC_KEY`
   - `CLAUDE_API_KEY`
   - `APIFY_TOKEN`
3. Redeploy for changes to take effect

### iOS to TestFlight

1. **Update iOS Config.plist**:
```xml
<key>BLOG_BASE_URL</key>
<string>https://your-project.vercel.app</string>
```

2. **Build for Archive** in Xcode:
   - Product → Archive
   - Distribute App → App Store Connect
   - Upload to TestFlight

3. **App Store Submission** (when ready):
   - Complete App Store Connect listing
   - Submit for review
   - Wait for approval (~24-48 hours)

---

## 🔐 Configuration & Secrets

### iOS Config.plist

**Template:** `Euki/Resources/Config.template.plist` (committed)
**Actual:** `Euki/Resources/Config.plist` (gitignored)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>SUPABASE_URL</key>
    <string></string>
    <key>SUPABASE_ANON_KEY</key>
    <string></string>
    <key>STRIPE_PUBLIC_KEY</key>
    <string></string>
    <key>STRIPE_SECRET_KEY</key>
    <string></string>
    <key>CLAUDE_API_KEY</key>
    <string></string>
    <key>APIFY_TOKEN</key>
    <string></string>
    <key>BLOG_BASE_URL</key>
    <string>http://localhost:3000</string>
</dict>
</plist>
```

### Web .env.local

**Template:** `apps/web-preview/.env.example` (committed)
**Actual:** `apps/web-preview/.env.local` (gitignored)

```env
# Supabase (optional - stubs work without)
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=

# Stripe (optional)
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=

# AI Companion (optional)
CLAUDE_API_KEY=

# Trend Scraping (optional)
APIFY_TOKEN=
```

### Security Best Practices

✅ **Never commit real secrets**
✅ **Use .env.local for local development**
✅ **Use Vercel environment variables for production**
✅ **Use Xcode build configurations for iOS**
✅ **Rotate keys regularly**
✅ **Use separate keys for dev/staging/production**

---

## 🧪 Testing

### Web Preview Testing

```bash
cd apps/web-preview

# Run dev server
npm run dev

# Test in browsers
# - Chrome
# - Safari
# - Firefox
# - Mobile (Chrome DevTools responsive mode)

# Check all 5 tabs:
# http://localhost:3000/cycle
# http://localhost:3000/symptoms
# http://localhost:3000/pregnancy
# http://localhost:3000/insights
# http://localhost:3000/blog

# Test responsive breakpoints:
# - Mobile: 375px
# - Tablet: 768px
# - Desktop: 1024px+
```

### iOS Testing

```bash
# Simulator testing
xcodebuild test \
  -workspace Euki.xcworkspace \
  -scheme Euki \
  -destination 'platform=iOS Simulator,name=iPhone 14'

# Device testing
# 1. Connect iPhone via USB
# 2. Select device in Xcode
# 3. Trust developer certificate
# 4. Build & Run (⌘R)
```

### Manual Test Checklist

**Web Preview:**
- [ ] All 5 tabs load without errors
- [ ] Bottom tab navigation works
- [ ] Colors match theme (#E10098, #8E44AD, #FFD600, #00BFB3)
- [ ] Spiral header animates
- [ ] Cycle calendar renders current date
- [ ] Symptom toggles add/remove items
- [ ] Sleep slider works (0-12 hours)
- [ ] Pregnancy week selector updates content
- [ ] Charts render
- [ ] Blog filters by category
- [ ] Paywall card shows premium features
- [ ] Responsive on mobile, tablet, desktop

**iOS App:**
- [ ] App launches without crashes
- [ ] 5-tab navigation works
- [ ] Cycle tab shows calendar
- [ ] Symptoms tab has mood/body/notes sections
- [ ] Pregnancy tab shows week selector
- [ ] Insights tab shows health cards
- [ ] Blog tab loads WebView or shows placeholder
- [ ] Paywall modal opens from insights/settings
- [ ] Settings page accessible
- [ ] Theme colors applied throughout
- [ ] No console errors

---

## 🎯 Next Steps

### Immediate (1-2 weeks)

1. **Add iOS to Xcode Project**
   - [ ] Add all LaPina Swift files to Xcode target
   - [ ] Create tab bar icon assets
   - [ ] Add spiral pineapple logo
   - [ ] Test build and fix any import errors

2. **Deploy Web Preview**
   - [ ] Create Vercel project
   - [ ] Deploy from `apps/web-preview`
   - [ ] Get production URL
   - [ ] Update iOS Config.plist with blog URL

3. **Basic Testing**
   - [ ] Test all 5 tabs on iOS simulator
   - [ ] Test web preview in 3+ browsers
   - [ ] Verify colors match design
   - [ ] Check responsive behavior

### Short Term (2-4 weeks)

4. **Backend Integration (Optional)**
   - [ ] Set up Supabase project
   - [ ] Create database schema (cycles, symptoms, users)
   - [ ] Replace stubs with real API calls
   - [ ] Test auth flow (login, signup, logout)

5. **Stripe Integration**
   - [ ] Create Stripe account
   - [ ] Set up subscription product ($9.99/year)
   - [ ] Configure webhook endpoints
   - [ ] Replace PinaStripeStub with real Stripe SDK
   - [ ] Test payment flow (dev mode)

6. **AI Companion (Claude)**
   - [ ] Get Anthropic API key
   - [ ] Implement chat UI
   - [ ] Replace PinaClaudeStub with real API
   - [ ] Test conversation flow
   - [ ] Add safety disclaimers

### Medium Term (1-3 months)

7. **Content Creation**
   - [ ] Write 20+ blog articles
   - [ ] Source affiliate products (Amazon US/MX)
   - [ ] Create AR flipbook assets
   - [ ] Add educational resources

8. **User Testing**
   - [ ] Internal alpha testing (team)
   - [ ] Beta testing (10-50 users)
   - [ ] Collect feedback
   - [ ] Iterate on UX

9. **Compliance & Legal**
   - [ ] Complete privacy policy
   - [ ] Complete terms of service
   - [ ] HIPAA compliance review (if applicable)
   - [ ] App Store guidelines review
   - [ ] Accessibility audit (WCAG AA)

### Long Term (3-6 months)

10. **App Store Launch**
    - [ ] Complete App Store listing
    - [ ] Screenshots and preview videos
    - [ ] App Store review submission
    - [ ] Launch marketing campaign

11. **Android Development**
    - [ ] Decide: React Native rewrite or native Android
    - [ ] If React Native: start YAPP transformation
    - [ ] If native: hire Android developer
    - [ ] Port all features to Android

12. **Growth & Monetization**
    - [ ] Social media presence (TikTok, Instagram)
    - [ ] Influencer partnerships
    - [ ] UGC campaigns
    - [ ] Affiliate revenue optimization
    - [ ] Premium subscription marketing

---

## 🐛 Troubleshooting

### Web Preview Issues

**Problem:** `npm install` fails
```bash
# Solution: Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
```

**Problem:** Pages don't load
```bash
# Solution: Check Next.js version
npm list next
# Should be 14.x or higher

# Update if needed
npm install next@latest react@latest react-dom@latest
```

**Problem:** Styles not applying
```bash
# Solution: Check Tailwind CSS config
# Ensure tailwind.config.ts includes:
content: [
  './app/**/*.{js,ts,jsx,tsx}',
  './components/**/*.{js,ts,jsx,tsx}',
]
```

### iOS Build Issues

**Problem:** Swift files not found
```
Solution:
1. Right-click Euki folder in Xcode
2. "Add Files to 'Euki'..."
3. Select all LaPina folders
4. Check "Euki" target
5. Clean build folder (Shift+⌘+K)
6. Rebuild (⌘B)
```

**Problem:** Config.plist not found
```bash
# Solution: Create it
cp Euki/Resources/Config.template.plist Euki/Resources/Config.plist

# Add to Xcode project
# Right-click Resources → Add Files → Select Config.plist
```

**Problem:** Pod install fails
```bash
# Solution: Update CocoaPods
sudo gem install cocoapods
pod repo update
pod install
```

**Problem:** Simulator crashes
```
Solution:
1. Reset simulator: Device → Erase All Content and Settings
2. Clean build: Shift+⌘+K
3. Rebuild: ⌘B
4. Run: ⌘R
```

### Deployment Issues

**Problem:** Vercel deployment fails
```bash
# Check build logs in Vercel dashboard
# Common issues:
# 1. Wrong build command - should be: cd apps/web-preview && npm run build
# 2. Missing dependencies - run: npm install
# 3. TypeScript errors - run: npm run build locally first
```

**Problem:** iOS Archive fails
```
Solution:
1. Check code signing in Xcode
2. Select correct development team
3. Enable "Automatically manage signing"
4. Clean build folder
5. Archive again
```

---

## 📚 Resources

### Documentation
- **Next.js:** https://nextjs.org/docs
- **React:** https://react.dev
- **Tailwind CSS:** https://tailwindcss.com/docs
- **Swift:** https://docs.swift.org
- **UIKit:** https://developer.apple.com/documentation/uikit

### APIs & Services
- **Supabase:** https://supabase.com/docs
- **Stripe:** https://stripe.com/docs
- **Claude API:** https://docs.anthropic.com
- **Apify:** https://docs.apify.com
- **Vercel:** https://vercel.com/docs

### Design
- **La Piña Figma:** [TODO: Add Figma link]
- **Theme Specs:** `/specs/theme.json`
- **Navigation Specs:** `/specs/navigation.json`

### Community
- **GitHub Issues:** https://github.com/executiveusa/-la-pina-cdmx/issues
- **Original Euki:** https://eukiapp.org
- **License:** GNU GPL v3.0

---

## 🙏 Credits

**Built from:** Euki by Euki, Inc (501c3 nonprofit)
**Forked by:** [Your Team Name]
**Transformation Lead:** Claude (Anthropic AI Assistant)
**Design Inspiration:** "No Estoy Loca" film poster
**Reference Framework:** Ralphy (michaelshimeles/ralphy.git)

---

## 📄 License

GNU General Public License v3.0

See [LICENSE.md](LICENSE.md) for full text.

---

**Ready to build the future of women's wellness?** 🍍✨

For questions or support, open an issue on GitHub or contact the development team.

**Last Updated:** January 31, 2026
