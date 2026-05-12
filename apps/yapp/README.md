# La Piña - Women's Wellness App (YAPP)

A beautiful, feature-rich React Native Expo app for women's health and wellness tracking. Built with a Mexican-inspired design system featuring glassmorphism effects and a warm, welcoming color palette.

## Features

- **Cycle Tracking**: Log and track your menstrual cycle with detailed insights
- **Symptom Management**: Track symptoms across different cycle phases
- **Pregnancy Tracking**: Monitor pregnancy with week-by-week updates
- **Health Blog**: Access curated articles on wellness, nutrition, and health
- **Insights & Analytics**: Visualize patterns and trends in your health data
- **Bilingual Support**: Spanish (Mexico) and English languages
- **Beautiful UI**: Glassmorphism design with warm, earthy color palette

## Tech Stack

- **Framework**: React Native (Expo)
- **Language**: TypeScript
- **Navigation**: React Navigation (Bottom Tabs)
- **State Management**: React Hooks + AsyncStorage
- **Backend**: Supabase
- **UI Components**: React Native Paper, Custom Components
- **Localization**: i18n-js
- **Animations**: React Native Reanimated
- **Charts**: react-native-chart-kit

## Project Structure

```
apps/yapp/
├── app/
│   ├── screens/              # App screens
│   │   ├── HomeScreen.tsx
│   │   ├── CycleScreen.tsx
│   │   ├── SymptomsScreen.tsx
│   │   ├── PregnancyScreen.tsx
│   │   ├── BlogScreen.tsx
│   │   ├── InsightsScreen.tsx
│   │   └── SettingsScreen.tsx
│   ├── components/           # Reusable components
│   │   ├── Header.tsx
│   │   ├── GlassmorphismCard.tsx
│   │   ├── TabNavigation.tsx
│   │   ├── LoadingPlaceholder.tsx
│   │   └── shared/
│   ├── navigation/           # Navigation setup
│   │   └── RootNavigator.tsx
│   ├── theme/               # Design system
│   │   ├── colors.ts
│   │   ├── typography.ts
│   │   ├── spacing.ts
│   │   ├── shadows.ts
│   │   └── index.ts
│   ├── localization/        # i18n setup
│   │   ├── i18n.ts
│   │   ├── es-MX.json
│   │   └── en.json
│   ├── services/            # API & Storage services
│   │   ├── supabaseClient.ts
│   │   ├── storageService.ts
│   │   └── apiService.ts
│   ├── hooks/               # Custom hooks
│   │   ├── useLocalization.ts
│   │   ├── useAppState.ts
│   │   └── index.ts
│   ├── types/               # TypeScript definitions
│   │   └── index.ts
│   └── App.tsx              # Root component
├── assets/                  # Images, icons, fonts
├── app.json                 # Expo config
├── app.config.ts            # Expo config (TypeScript)
├── babel.config.js          # Babel config
├── tsconfig.json            # TypeScript config
├── package.json
└── README.md
```

## Getting Started

### Prerequisites

- Node.js 16+ and npm/yarn
- Expo CLI: `npm install -g expo-cli`

### Installation

1. Navigate to the YAPP directory:
   ```bash
   cd apps/yapp
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   ```bash
   cp .env.example .env.local
   # Edit .env.local with your Supabase credentials
   ```

### Running the App

#### Development Server
```bash
npm start
# or
expo start
```

#### iOS
```bash
npm run ios
# or
expo start --ios
```

#### Android
```bash
npm run android
# or
expo start --android
```

#### Web
```bash
npm run web
# or
expo start --web
```

## Available Scripts

- `npm start` - Start the development server
- `npm run dev` - Start with dev client
- `npm run android` - Build and run on Android
- `npm run ios` - Build and run on iOS
- `npm run web` - Run web version
- `npm test` - Run tests
- `npm run lint` - Run ESLint
- `npm run type-check` - TypeScript type checking
- `npm run format` - Format code with Prettier
- `npm run build` - Build for distribution
- `npm run submit` - Submit to app stores

## Environment Variables

Create a `.env.local` file in the root directory:

```env
EXPO_PUBLIC_SUPABASE_URL=your_supabase_url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## Theme & Design System

### Color Palette

- **Primary**: Terra cotta (#E67E5B)
- **Secondary**: Sage green (#7DBB8E)
- **Accent**: Peachy coral (#F9A875)
- **Background**: Off-white (#FFFBF8)

### Typography

Responsive typography system with:
- Headings (h1 - h6)
- Body text (large, medium, small)
- Labels and captions

### Spacing

8px base unit with consistent scale:
- xs: 4px, sm: 8px, md: 12px, lg: 16px, xl: 24px, etc.

## Localization

The app supports Spanish (Mexico) and English with easy language switching in settings.

Add translations in:
- `app/localization/es-MX.json` - Mexican Spanish
- `app/localization/en.json` - English

## Contributing

1. Create a feature branch
2. Follow the existing code structure and naming conventions
3. Use TypeScript for all new code
4. Format with Prettier: `npm run format`
5. Test with ESLint: `npm run lint`

## Development Guidelines

### Component Development

- Create functional components with TypeScript
- Use custom hooks for state management
- Keep components small and focused
- Document props with JSDoc comments

### Screen Development

All screens follow this pattern:
```tsx
const ScreenName: React.FC<ScreenNameProps> = ({ navigation }) => {
  const { t } = useLocalization();
  // Component implementation
};
```

### Styling

- Use theme values from `@/theme`
- Define styles with StyleSheet.create()
- Follow mobile-first responsive design

## Testing

Run tests with:
```bash
npm test
```

Watch mode:
```bash
npm run test:watch
```

## Building for Production

### iOS
```bash
npm run build:ios
npm run submit
```

### Android
```bash
npm run build:android
npm run submit
```

## Troubleshooting

### Expo Won't Start
```bash
npm install -g expo-cli@latest
rm -rf node_modules package-lock.json
npm install
expo start --clear
```

### TypeScript Errors
```bash
npm run type-check
```

### Styling Issues
Clear the Expo cache and restart:
```bash
expo start --clear
```

## License

Proprietary - La Piña Women's Wellness App

## Support

For issues and questions, contact: support@lapina.app

## Roadmap

- [ ] Complete screen implementations
- [ ] Push notifications
- [ ] Health data integration
- [ ] Community features
- [ ] Wellness recommendations
- [ ] Data export functionality

---

Made with care for women's wellness.
