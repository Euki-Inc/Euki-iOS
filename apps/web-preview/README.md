# La Piña Web Preview

A modern, mobile-first Next.js App Router project showcasing the La Piña women's health and wellness platform.

## Features

- **Cycle Tracking**: Visual calendar and cycle history with predictions
- **Symptom Logger**: Track mood, body symptoms, and sleep quality
- **Pregnancy Guide**: Week-by-week fetal development and prenatal care
- **Health Insights**: Pattern analysis, alerts, and personalized recommendations
- **Luxury Blog**: Articles with affiliate products and wellness tips
- **Responsive Design**: Mobile-first, optimized for all devices
- **Mock Data**: Complete data structures matching production specs
- **Theme Customization**: All La Piña brand colors and styling

## Tech Stack

- **Framework**: Next.js 14+ with App Router
- **Styling**: Tailwind CSS
- **Language**: TypeScript
- **Runtime**: Node.js

## Project Structure

```
apps/web-preview/
├── app/
│   ├── layout.tsx              # Root layout with theme
│   ├── page.tsx                # Home redirect to /cycle
│   ├── globals.css             # Global styles and animations
│   ├── cycle/
│   │   └── page.tsx            # Cycle tracking page
│   ├── symptoms/
│   │   └── page.tsx            # Symptom tracking page
│   ├── pregnancy/
│   │   └── page.tsx            # Pregnancy guide page
│   ├── insights/
│   │   └── page.tsx            # Health insights page
│   └── blog/
│       └── page.tsx            # Blog listing page
├── components/
│   ├── TabNav.tsx              # Bottom navigation (5 tabs)
│   ├── SpiralHeader.tsx        # Header with spinning pineapple
│   ├── PaywallCard.tsx         # Premium upsell component
│   └── MockChart.tsx           # Simple cycle chart
├── lib/
│   ├── theme.ts                # Theme constants and colors
│   ├── env.ts                  # Environment variable helpers
│   ├── data.ts                 # Mock data from specs
│   └── stubs.ts                # Stubbed API functions
├── package.json                # Dependencies
├── next.config.js              # Next.js configuration
├── tsconfig.json               # TypeScript configuration
├── tailwind.config.ts          # Tailwind theme configuration
├── postcss.config.js           # PostCSS configuration
├── .env.example                # Environment template
└── .gitignore                  # Git ignore patterns
```

## Installation

1. Install dependencies:
```bash
npm install
```

2. Create environment file (optional - works without it):
```bash
cp .env.example .env.local
```

3. Start development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Configuration

### Environment Variables (Optional)

Create `.env.local` with the following (all optional):

```env
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=
CLAUDE_API_KEY=
APIFY_TOKEN=
```

The app works perfectly with an empty `.env.local` using mock data.

## Colors

La Piña brand colors are defined in `lib/theme.ts`:

- **Primary Pink**: `#E10098` - Main actions and headers
- **Purple**: `#8E44AD` - Secondary actions
- **Sunshine Yellow**: `#FFD600` - Highlights and warnings
- **Aqua Teal**: `#00BFB3` - Fertility indicators
- **Neutrals**: White, light gray, gray, dark gray, black

## Pages

### Cycle (`/cycle`)
- Visual calendar with period tracking
- Cycle history and statistics
- Fertility window predictions
- Current cycle information

### Symptoms (`/symptoms`)
- Mood tracker with emoji selection
- Body symptom logging
- Sleep quality tracker with slider
- Journal notes
- Historical symptom tracking

### Pregnancy (`/pregnancy`)
- Fertility mode toggle
- Week-by-week timeline (1-40 weeks)
- Fetal development details
- Trimester guide
- Prenatal care checklist

### Insights (`/insights`)
- Key health metrics
- Alerts and recommendations
- Cycle pattern analysis
- Common symptoms trends
- Personalized health tips

### Blog (`/blog`)
- Luxury wellness articles
- Category filtering
- Affiliate product recommendations
- Featured content collections
- Newsletter signup

## Components

### TabNav
Bottom navigation with 5 tabs that appears on mobile. Shows the current route with highlighted color.

### SpiralHeader
Gradient header with spinning pineapple emoji and page title/subtitle.

### PaywallCard
Premium upsell component showing features and CTAs for subscription plans.

### MockChart
Simple bar chart component showing cycle length trends across months.

## Styling

### Tailwind CSS
Customized configuration with:
- La Piña color palette
- Custom spacing (xs, sm, md, lg, xl, xxl)
- Rounded corners (sm, md, lg, full)
- Soft box shadows
- Gradient backgrounds
- Bubble and spiral animations

### Global Styles
`app/globals.css` includes:
- Reset and base styles
- Typography hierarchy
- Button variants (primary, secondary, outline, ghost)
- Card and badge components
- Gradient and shadow utilities
- Custom animations
- Mobile optimizations

## Animations

- **Spiral**: 2s rotation loop
- **Bubble**: 0.3s scale-up with bounce easing
- **Slide Up**: 0.4s fade-in with upward translation

## Responsive Design

Mobile-first approach:
- Mobile: Full-width with bottom tab navigation
- Tablet: 2-column layouts where appropriate
- Desktop: Expanded layouts with max-width containers

## Mock Data

All data comes from `lib/data.ts` and matches the production specs:
- 3 recent cycles with flow and symptoms
- 3 symptom entries with mood/body tracking
- 3 pregnancy weeks (1, 8, 20)
- 2 health insights/alerts
- 5 blog posts with affiliate products
- 7 premium features

## API Stubs

`lib/stubs.ts` provides stubbed functions for:
- `fetchUserData()` - Returns demo user
- `fetchCycleData()` - Returns current cycle info
- `fetchSymptomTracking()` - Returns today's tracking
- `logSymptom()` - Logs symptom data
- `fetchInsights()` - Returns health insights
- `uploadProfilePhoto()` - Handles photo upload
- `getPremiumStatus()` - Returns premium status
- `submitPremiumCheckout()` - Handles premium checkout

## Building for Production

```bash
npm run build
npm start
```

## TypeScript

Full TypeScript support with strict mode enabled. All components are properly typed.

## Browser Support

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Performance

- Optimized images with Next.js Image component
- Code splitting with App Router
- Minimal JavaScript bundle
- CSS-in-JS with Tailwind (no runtime overhead)

## Accessibility

- Semantic HTML
- ARIA labels where appropriate
- Keyboard navigation support
- Reduced motion support
- Color contrast compliance

## License

Copyright La Piña 2026. All rights reserved.
