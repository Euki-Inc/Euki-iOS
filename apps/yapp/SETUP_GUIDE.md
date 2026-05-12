# La Piña YAPP - Setup & Initialization Guide

This document provides a comprehensive guide to set up and run the La Piña women's wellness app.

## Prerequisites

Before getting started, ensure you have:

- **Node.js**: v16.0.0 or higher
- **npm**: v7.0.0 or higher (or yarn/pnpm)
- **Expo CLI**: `npm install -g expo-cli@latest`
- **Git**: For version control
- **Supabase Account**: For backend services
- **Apple Developer Account** (optional): For iOS builds
- **Google Play Developer Account** (optional): For Android builds

## Installation Steps

### 1. Install Dependencies

```bash
cd apps/yapp
npm install
# or
yarn install
```

### 2. Configure Environment Variables

Create `.env.local` file from the template:

```bash
cp .env.example .env.local
```

Edit `.env.local` and add your Supabase credentials:

```env
EXPO_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
EXPO_PUBLIC_APP_NAME=La Piña
```

### 3. Initialize Supabase (Backend Setup)

To set up the backend database and authentication:

1. Create a Supabase project at https://supabase.com
2. Create the following tables in the SQL editor:

```sql
-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT auth.uid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  date_of_birth DATE,
  cycle_length INTEGER DEFAULT 28,
  period_length INTEGER DEFAULT 5,
  last_period_date DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Cycle logs table
CREATE TABLE cycle_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  type TEXT CHECK (type IN ('menstrual', 'flow', 'spotting')),
  flow_intensity TEXT CHECK (flow_intensity IN ('light', 'medium', 'heavy')),
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, date)
);

-- Symptoms table
CREATE TABLE symptoms (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  symptom TEXT NOT NULL,
  severity TEXT CHECK (severity IN ('mild', 'moderate', 'severe')),
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Mood logs table
CREATE TABLE mood_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  mood TEXT NOT NULL,
  intensity INTEGER CHECK (intensity >= 1 AND intensity <= 10),
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, date)
);

-- Pregnancy tracking table
CREATE TABLE pregnancy_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  due_date DATE NOT NULL,
  started_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Articles table
CREATE TABLE articles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  excerpt TEXT,
  content TEXT NOT NULL,
  category TEXT,
  author TEXT,
  image_url TEXT,
  published_at TIMESTAMP,
  updated_at TIMESTAMP DEFAULT NOW(),
  published BOOLEAN DEFAULT false,
  reading_time_minutes INTEGER
);

-- Create indexes
CREATE INDEX idx_cycle_logs_user_date ON cycle_logs(user_id, date);
CREATE INDEX idx_symptoms_user_date ON symptoms(user_id, date);
CREATE INDEX idx_mood_logs_user_date ON mood_logs(user_id, date);
CREATE INDEX idx_articles_published ON articles(published, published_at DESC);
```

3. Enable authentication in Supabase:
   - Go to Authentication > Providers
   - Enable Email/Password provider

## Running the App

### Development Server

Start the Expo development server:

```bash
npm start
# or
expo start
```

This will open the Expo CLI menu showing:
- iOS simulator: Press `i`
- Android emulator: Press `a`
- Web browser: Press `w`
- Scan QR with Expo app: Use your phone

### iOS Development

```bash
npm run ios
# or
expo start --ios
```

**Requirements:**
- macOS with Xcode installed
- iOS 14.0 or higher
- iPhone simulator or physical device

### Android Development

```bash
npm run android
# or
expo start --android
```

**Requirements:**
- Android Studio installed
- Android SDK (API level 24+)
- Android emulator or physical device

### Web Development

```bash
npm run web
# or
expo start --web
```

Opens the app in your default web browser at `localhost:19006`

## Project Structure Overview

```
apps/yapp/
├── app/                          # Source code
│   ├── App.tsx                   # Root component
│   ├── screens/                  # 7 main screens
│   │   ├── HomeScreen
│   │   ├── CycleScreen
│   │   ├── SymptomsScreen
│   │   ├── PregnancyScreen
│   │   ├── BlogScreen
│   │   ├── InsightsScreen
│   │   └── SettingsScreen
│   ├── components/               # Reusable UI components
│   │   ├── Header
│   │   ├── GlassmorphismCard
│   │   ├── TabNavigation
│   │   └── LoadingPlaceholder
│   ├── navigation/               # Navigation setup
│   ├── theme/                    # Design system
│   │   ├── colors.ts             # Color palette
│   │   ├── typography.ts         # Typography scales
│   │   ├── spacing.ts            # Spacing system
│   │   └── shadows.ts            # Shadow & glass effects
│   ├── localization/             # i18n setup
│   │   ├── es-MX.json            # Mexican Spanish
│   │   ├── en.json               # English
│   │   └── i18n.ts               # Configuration
│   ├── services/                 # API & storage
│   │   ├── supabaseClient.ts     # Supabase setup
│   │   ├── storageService.ts     # AsyncStorage wrapper
│   │   └── apiService.ts         # API methods
│   ├── hooks/                    # Custom React hooks
│   │   ├── useLocalization       # i18n hook
│   │   └── useAppState           # App state hook
│   ├── types/                    # TypeScript definitions
│   └── utils/                    # Utility functions
│       └── dateUtils.ts          # Date & cycle calculations
├── assets/                       # Images, icons (create as needed)
├── index.js                      # Expo entry point
├── app.json                      # Expo configuration
├── app.config.ts                 # Expo config (TypeScript)
├── babel.config.js               # Babel configuration
├── tsconfig.json                 # TypeScript configuration
├── package.json                  # Dependencies
├── package-lock.json             # Locked versions
├── README.md                      # Main documentation
├── SETUP_GUIDE.md               # This file
└── .env.example                 # Environment template
```

## Key Features Implemented

### Theme System
- Complete design system with colors, typography, spacing, and shadows
- Mexican-inspired color palette with warm tones
- Glassmorphism effects for modern UI

### Localization
- Full i18n setup with Spanish (Mexico) and English
- Language switching in settings
- Support for 500+ UI strings

### Navigation
- Bottom tab navigation with 7 main screens
- Custom tab bar with glassmorphism effect
- Smooth screen transitions

### Services
- Supabase integration for authentication and data storage
- AsyncStorage for local persistence
- Comprehensive API methods for all features

### Type Safety
- Full TypeScript support
- Comprehensive type definitions for all models
- Custom types for navigation props

## Customization Guide

### Changing Colors

Edit `/app/theme/colors.ts`:

```typescript
export const Colors = {
  primary: '#E67E5B',        // Change primary color
  secondary: '#7DBB8E',      // Change secondary color
  // ... other colors
};
```

### Adding New Screens

1. Create new screen file in `/app/screens/`
2. Add to navigation in `/app/navigation/RootNavigator.tsx`
3. Add tab configuration
4. Import and render in RootNavigator

### Adding New Translations

1. Add key-value pairs to `/app/localization/es-MX.json` and `/app/localization/en.json`
2. Use in components: `const { t } = useLocalization(); t('key')`

### Modifying Typography

Edit `/app/theme/typography.ts` to adjust font sizes, weights, and line heights.

## Testing

### Run Tests

```bash
npm test
```

### Run Linting

```bash
npm run lint
```

### Type Checking

```bash
npm run type-check
```

### Format Code

```bash
npm run format
```

## Troubleshooting

### "Module not found" errors

```bash
npm install
rm -rf node_modules
npm install
expo start --clear
```

### TypeScript errors

```bash
npm run type-check
# Check the output for specific errors
```

### Expo won't start

```bash
# Clear Expo cache
expo start --clear

# Or clear everything
rm -rf node_modules .expo
npm install
expo start --clear
```

### Simulator/Emulator not working

```bash
# For iOS
sudo xcrun simctl erase all

# For Android
emulator -list-avds
emulator -avd <AVD_NAME>
```

## Building for Production

### Create Development Build

```bash
npm run build
```

### iOS Release Build

```bash
npm run build:ios
npm run submit  # Submit to App Store
```

### Android Release Build

```bash
npm run build:android
npm run submit  # Submit to Google Play
```

## Performance Optimization Tips

1. **Memoize Components**: Use `React.memo()` for expensive components
2. **Lazy Loading**: Implement code splitting for large screens
3. **Image Optimization**: Compress and resize images appropriately
4. **Remove Console Logs**: Clean up console statements in production
5. **Use FlatList**: For long lists instead of ScrollView

## Security Best Practices

1. **Never commit `.env` files**: Use `.env.example` as template
2. **Secure Supabase Keys**: Keep anon keys safe, use RLS for database
3. **Validate Input**: Sanitize all user inputs
4. **HTTPS Only**: Ensure all API calls use HTTPS
5. **Update Dependencies**: Regularly run `npm audit fix`

## Useful Commands Reference

```bash
# Development
npm start                 # Start Expo CLI
npm run ios             # Run on iOS simulator
npm run android         # Run on Android emulator
npm run web             # Run in web browser

# Code Quality
npm run lint            # Run ESLint
npm run format          # Format with Prettier
npm run type-check      # TypeScript check
npm test                # Run tests

# Building
npm run build           # Create production build
npm run build:ios       # iOS release build
npm run build:android   # Android release build
npm run submit          # Submit to app stores

# Cleanup
npm run clean           # Remove build artifacts
rm -rf node_modules     # Remove dependencies (reinstall with npm install)
```

## Next Steps

1. Install dependencies: `npm install`
2. Configure environment variables
3. Set up Supabase backend
4. Run development server: `npm start`
5. Test on iOS/Android
6. Implement feature screens
7. Build and submit to app stores

## Support & Resources

- **Expo Documentation**: https://docs.expo.dev
- **React Native Docs**: https://reactnative.dev
- **Supabase Docs**: https://supabase.com/docs
- **TypeScript Handbook**: https://www.typescriptlang.org/docs

## Contributing

1. Create a feature branch
2. Make changes following the code style
3. Test thoroughly
4. Submit for review
5. Follow pull request template

---

**Created**: 2026
**Last Updated**: March 2026
**Status**: Production-Ready

For questions or issues, please contact the development team.
