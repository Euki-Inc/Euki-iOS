# La Piña YAPP - Project Index & Quick Reference

## Quick Navigation

### Getting Started
1. Start here: [SETUP_GUIDE.md](./SETUP_GUIDE.md)
2. Project overview: [README.md](./README.md)
3. Implementation plan: [IMPLEMENTATION_CHECKLIST.md](./IMPLEMENTATION_CHECKLIST.md)

### Project Structure

#### 🎨 Design System
- **Colors**: `app/theme/colors.ts` - Mexican-inspired palette
- **Typography**: `app/theme/typography.ts` - 11 typography scales
- **Spacing**: `app/theme/spacing.ts` - 8px-based grid system
- **Shadows**: `app/theme/shadows.ts` - Glassmorphism effects

#### 🗣️ Localization
- **Setup**: `app/localization/i18n.ts`
- **Spanish (Mexico)**: `app/localization/es-MX.json` (500+ strings)
- **English**: `app/localization/en.json` (500+ strings)

#### 📱 Screens (7 Total)
- **Home**: `app/screens/HomeScreen.tsx` - Dashboard
- **Cycle**: `app/screens/CycleScreen.tsx` - Menstrual tracking
- **Symptoms**: `app/screens/SymptomsScreen.tsx` - Symptom logging
- **Pregnancy**: `app/screens/PregnancyScreen.tsx` - Pregnancy tracking
- **Blog**: `app/screens/BlogScreen.tsx` - Articles & content
- **Insights**: `app/screens/InsightsScreen.tsx` - Analytics & trends
- **Settings**: `app/screens/SettingsScreen.tsx` - App preferences

#### 🧩 Components
- **Header**: `app/components/Header.tsx` - App header with navigation
- **GlassmorphismCard**: `app/components/GlassmorphismCard.tsx` - Frosted glass cards
- **TabNavigation**: `app/components/TabNavigation.tsx` - Bottom tab bar
- **LoadingPlaceholder**: `app/components/LoadingPlaceholder.tsx` - Loading states

#### 🗺️ Navigation
- **RootNavigator**: `app/navigation/RootNavigator.tsx` - Tab-based navigation

#### 🔧 Services
- **Supabase**: `app/services/supabaseClient.ts` - Authentication & setup
- **Storage**: `app/services/storageService.ts` - AsyncStorage wrapper (20+ methods)
- **API**: `app/services/apiService.ts` - Backend API layer (15+ methods)

#### 🪝 Custom Hooks
- **useLocalization**: `app/hooks/useLocalization.ts` - i18n hook
- **useAppState**: `app/hooks/useAppState.ts` - App state management

#### 📝 Types
- **TypeScript Definitions**: `app/types/index.ts` - 20+ type definitions
  - User profiles
  - Cycle data structures
  - Symptom & mood types
  - Enums (CyclePhase, SymptomType, etc.)

#### 🛠️ Utilities
- **Date Utils**: `app/utils/dateUtils.ts` - 12 date/cycle functions
  - Cycle day calculation
  - Ovulation prediction
  - Fertility window calculation
  - Cycle phase determination

#### 📦 Root Files
- **App.tsx**: `app/App.tsx` - Root component
- **index.js**: `index.js` - Expo entry point

### Configuration Files

| File | Purpose |
|------|---------|
| `package.json` | Dependencies (45+) and scripts |
| `tsconfig.json` | TypeScript configuration |
| `babel.config.js` | Babel setup with path aliases |
| `app.json` | Expo manifest |
| `app.config.ts` | Expo TypeScript config |
| `.eslintrc.js` | Linting rules |
| `.prettierrc` | Code formatting |
| `.gitignore` | Git ignore patterns |
| `jest.setup.js` | Test configuration |
| `eas.json` | EAS Build settings |

---

## File Organization

```
apps/yapp/
├── app/
│   ├── screens/              [7 screens]
│   ├── components/           [4 base components]
│   ├── navigation/           [Route setup]
│   ├── theme/               [Design system]
│   ├── localization/        [i18n setup]
│   ├── services/            [Backend & storage]
│   ├── hooks/               [Custom hooks]
│   ├── types/               [TypeScript types]
│   ├── utils/               [Utilities]
│   └── App.tsx              [Root]
├── docs/                    [Documentation folder]
├── Configuration files      [10+ config files]
└── Documentation files      [4 markdown files]
```

---

## Key Commands

### Development
```bash
npm start              # Start development server
npm run ios            # Run on iOS
npm run android        # Run on Android
npm run web            # Run in web browser
```

### Code Quality
```bash
npm run lint           # ESLint
npm run format         # Prettier format
npm run type-check     # TypeScript check
npm test               # Run tests
```

### Building
```bash
npm run build          # Create build
npm run build:ios      # iOS build
npm run build:android  # Android build
npm run submit         # Submit to stores
```

---

## Color Palette Reference

### Primary Colors
- Primary: `#E67E5B` (Terra cotta)
- Primary Light: `#F5A379`
- Primary Dark: `#D46A45`

### Secondary Colors
- Secondary: `#7DBB8E` (Sage green)
- Secondary Light: `#A8D5BA`
- Secondary Dark: `#6A9B76`

### Accent Colors
- Accent: `#F9A875` (Peachy coral)
- Accent Variant: `#FFD4A8` (Soft peach)
- Warning: `#F4A460` (Sandy brown)
- Error: `#E07856` (Reddish coral)

### Cycle Phase Colors
- Menstrual: `#E8899B`
- Follicular: `#FFD4A8`
- Ovulation: `#FDB813`
- Luteal: `#B8A8D9`

---

## TypeScript Path Aliases

```typescript
// These aliases are configured in tsconfig.json and babel.config.js
import { Something } from '@/screens'          // app/screens
import { Component } from '@/components'       // app/components
import { theme } from '@/theme'                // app/theme
import { t } from '@/localization'             // app/localization
import { supabase } from '@/services'          // app/services
import { useLocalization } from '@/hooks'      // app/hooks
import { CyclePhase } from '@/types'           // app/types
import { dateUtils } from '@/utils'            // app/utils
```

---

## Feature Checklist

### Completed
- ✅ Project structure
- ✅ Configuration setup
- ✅ Design system
- ✅ Type definitions
- ✅ Localization infrastructure
- ✅ Navigation setup
- ✅ Service layer
- ✅ Custom hooks
- ✅ Utility functions
- ✅ Documentation

### In Development
- [ ] Screen implementations
- [ ] Feature development
- [ ] Backend integration
- [ ] Testing

---

## Documentation Roadmap

| Document | Purpose | Status |
|----------|---------|--------|
| README.md | Main documentation | ✅ Complete |
| SETUP_GUIDE.md | Detailed setup | ✅ Complete |
| IMPLEMENTATION_CHECKLIST.md | Development tasks | ✅ Complete |
| YAPP_PROJECT_SUMMARY.md | Project overview | ✅ Complete |
| PROJECT_INDEX.md | This file | ✅ Complete |

---

## Technology Stack Summary

### Frontend
- React Native 0.74.0
- Expo 51.0.0
- TypeScript 5.3.0
- React Navigation 6.1.0

### UI Components
- React Native Paper 5.12.0
- React Native Reanimated 3.8.0
- Expo Blur (Glassmorphism)

### Data & Services
- Supabase 2.38.0
- AsyncStorage 1.21.0
- date-fns 2.30.0

### Localization
- i18n-js 4.4.0

### Charts
- react-native-chart-kit 6.12.0
- chart.js 4.4.0

### Development Tools
- ESLint 8.50.0
- Prettier 3.0.0
- Jest 29.7.0

---

## Common Development Tasks

### Adding a New Translation
1. Edit `app/localization/es-MX.json` and `en.json`
2. Add your key-value pair
3. Use in component: `const { t } = useLocalization(); t('your.key')`

### Changing Theme Colors
1. Edit `app/theme/colors.ts`
2. Update color value
3. Changes apply automatically (colors are imported)

### Creating a New Screen
1. Create file in `app/screens/YourScreen.tsx`
2. Add to navigation in `app/navigation/RootNavigator.tsx`
3. Import screens and update tab configuration

### Calling an API
1. Use methods from `app/services/apiService.ts`
2. Handle responses and errors
3. Example: `const { data, error } = await cycleAPI.getCycleHistory(userId)`

### Storing Local Data
1. Use `app/services/storageService.ts` methods
2. Example: `await storageService.setUserName('Maria')`
3. Retrieve: `const name = await storageService.getUserName()`

---

## Useful Resources

### Official Docs
- [Expo Documentation](https://docs.expo.dev)
- [React Native Docs](https://reactnative.dev)
- [React Navigation](https://reactnavigation.org)
- [Supabase Docs](https://supabase.com/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)

### Community
- [Expo Forum](https://forums.expo.dev)
- [React Native Community](https://reactnative.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/react-native)

---

## Support

For issues or questions:
1. Check SETUP_GUIDE.md for common issues
2. Review IMPLEMENTATION_CHECKLIST.md for tasks
3. Consult component prop documentation
4. Check TypeScript definitions for types

---

## Project Statistics

- **Total Files**: 43+
- **Lines of Code**: 3,600+
- **Screens**: 7
- **Components**: 4 base + extensible
- **Type Definitions**: 20+
- **API Methods**: 15+
- **Storage Methods**: 20+
- **Date Utils**: 12+
- **Translation Keys**: 500+
- **Color Palette**: 50+

---

**Last Updated**: March 12, 2026
**Status**: ✅ Ready for Development
**Next Phase**: Feature Implementation
