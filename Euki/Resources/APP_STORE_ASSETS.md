# App Store Marketing Assets Guide - La Pina

Complete guide for creating and submitting App Store marketing assets for La Pina.

## Table of Contents

1. [App Icon Requirements](#app-icon-requirements)
2. [Screenshots Specifications](#screenshots-specifications)
3. [App Preview Videos](#app-preview-videos)
4. [App Store Descriptions](#app-store-descriptions)
5. [Keywords and ASO](#keywords-and-aso)
6. [Category Recommendations](#category-recommendations)
7. [Additional Marketing Assets](#additional-marketing-assets)

---

## App Icon Requirements

### Required Icon Sizes

App icons must be provided in the following sizes for iOS:

#### iOS App Icon Sizes

| Size | Usage | Required |
|------|-------|----------|
| 1024x1024 | App Store | ✅ Yes (PNG, no transparency, no alpha) |
| 180x180 | iPhone (3x) | ✅ Yes |
| 167x167 | iPad Pro | ✅ Yes |
| 152x152 | iPad, iPad mini (2x) | ✅ Yes |
| 120x120 | iPhone (2x) | ✅ Yes |
| 87x87 | iPhone (3x) Settings | ✅ Yes |
| 80x80 | iPad (2x) Settings | ✅ Yes |
| 76x76 | iPad | ✅ Yes |
| 60x60 | iPhone Spotlight | ✅ Yes |
| 58x58 | iPhone Settings | ✅ Yes |
| 40x40 | iPad Spotlight | ✅ Yes |
| 29x29 | iPhone/iPad Settings | ✅ Yes |
| 20x20 | iPad Notifications | ✅ Yes |

### App Icon Guidelines

**Design Requirements:**
- No transparency or alpha channels
- Square shape (iOS adds rounded corners automatically)
- RGB color space
- 72 DPI minimum
- PNG or JPEG format

**Design Best Practices:**
- Use La Pina brand colors (pink/rose tones)
- Simple, recognizable design
- Avoid text (too small to read)
- Test at all sizes
- Ensure visibility on both light and dark backgrounds
- Consider the silhouette test (recognizable in black)

**La Pina Icon Suggestions:**
- Stylized pineapple icon with health/wellness elements
- Abstract feminine health symbol
- Calendar/cycle tracking visual
- Combination of La Pina branding with health motifs

### Asset Catalog Setup

In Xcode:
1. Navigate to `Assets.xcassets`
2. Select `AppIcon`
3. Drag and drop each icon size into corresponding slot
4. Verify all slots are filled

---

## Screenshots Specifications

### Required Screenshot Sizes

You must provide screenshots for these device sizes:

#### iPhone Screenshots

| Device Size | Resolution | Required |
|-------------|-----------|----------|
| 6.9" Display (iPhone 16 Pro Max) | 1320x2868 | ✅ Yes |
| 6.7" Display (iPhone 15 Plus) | 1290x2796 | ✅ Yes |
| 6.5" Display | 1242x2688 | Recommended |
| 5.5" Display | 1242x2208 | Optional (older devices) |

#### iPad Screenshots

| Device Size | Resolution | Required |
|-------------|-----------|----------|
| 12.9" Display (iPad Pro) | 2048x2732 | ✅ Yes (if supporting iPad) |
| 11" Display (iPad Pro) | 1668x2388 | Recommended |

### Screenshot Requirements

- **Format:** PNG or JPEG
- **Color Space:** RGB
- **No transparency**
- **Minimum:** 3-10 screenshots per device size
- **Maximum:** 10 screenshots per device size
- **Order matters:** First screenshot is the most important

### Screenshot Content Strategy

**Recommended Screenshot Flow (1-10):**

1. **Hero/Welcome Screen**
   - Beautiful onboarding or main dashboard
   - Tagline: "Tu compañera de salud femenina"

2. **Cycle Tracking**
   - Show calendar view with cycle predictions
   - Highlight: "Seguimiento preciso de tu ciclo"

3. **Pregnancy Tracking**
   - Pregnancy timeline and milestones
   - Highlight: "Acompaña tu embarazo semana a semana"

4. **Health Insights**
   - Charts and personalized insights
   - Highlight: "Insights personalizados con IA"

5. **Symptoms Logging**
   - Easy symptom tracking interface
   - Highlight: "Registra síntomas fácilmente"

6. **Blog & Content**
   - Health articles and resources
   - Highlight: "Contenido educativo de expertos"

7. **Privacy & Security**
   - Data security features
   - Highlight: "Tu salud, tu privacidad"

8. **Reminders & Notifications**
   - Smart reminders
   - Highlight: "Nunca olvides tu pastilla"

9. **Settings & Customization**
   - Personalization options
   - Highlight: "Personaliza tu experiencia"

10. **Community/Support (Optional)**
    - Support features or community aspect

### Screenshot Design Best Practices

**Technical:**
- Use actual app screenshots (no mockups for main screenshots)
- Add device frames for better visual appeal
- Include status bar with full battery, WiFi, and cellular
- Set time to 9:41 AM (Apple standard)

**Design:**
- Add text overlays highlighting key features
- Use La Pina brand colors for text/highlights
- Ensure text is readable on all backgrounds
- Maintain consistent design across all screenshots
- Use high-quality, crisp images

**Localization:**
- Create separate screenshot sets for English and Spanish
- Ensure translations are accurate and culturally appropriate

### Tools for Creating Screenshots

**Screenshot Capture:**
- Xcode Simulator (Device → Screenshot)
- TestFlight on physical devices
- Xcode's Instruments for automated captures

**Design Tools:**
- [Figma](https://figma.com) - Free for single user
- [Screenshot Design by Apple](https://developer.apple.com/design/resources/)
- [Previewed](https://previewed.app) - Screenshot mockup tool
- [App Store Screenshot](https://appstoresscreenshot.com)

**Automation:**
- Fastlane Snapshot for automated screenshot generation
- [Shotbot](https://shotbot.io) - AI-powered screenshot generation

---

## App Preview Videos

### Video Specifications

| Property | Requirement |
|----------|-------------|
| Format | .mov, .m4v, or .mp4 |
| Codec | H.264 or HEVC (H.265) |
| Resolution | Match screenshot resolutions |
| Duration | 15-30 seconds |
| File Size | Up to 500 MB |
| Frame Rate | 30 fps |
| Audio | Optional but recommended |

### Device Sizes for Videos

Provide videos for:
- 6.9" Display (1320x2868)
- 6.7" Display (1290x2796)
- 12.9" iPad (2048x2732) - if supporting iPad

### Video Content Guidelines

**Structure (15-30 seconds):**

1. **Opening (2-3s):** App logo and tagline
2. **Feature 1 (4-5s):** Cycle tracking in action
3. **Feature 2 (4-5s):** Pregnancy tracking or insights
4. **Feature 3 (4-5s):** Health logging/symptoms
5. **Closing (2-3s):** Download CTA with logo

**Best Practices:**
- Show actual app functionality
- No hands/fingers on screen
- Smooth transitions
- Upbeat, feminine background music
- Text overlays for key features (in app language)
- Professional voiceover (optional)
- Demonstrate user flow naturally

**What to Avoid:**
- Stock footage (use actual app)
- Excessive animations
- Slow pacing
- Low-quality audio
- Misleading features

### Video Creation Tools

- **iMovie** (Mac) - Free
- **Final Cut Pro** (Mac) - Professional
- **Adobe Premiere Pro** - Cross-platform
- **DaVinci Resolve** - Free option
- **Screen Studio** - Mac screen recording with beautiful output

### Recording Tips

1. Use Xcode Simulator at exact device size
2. Record at 60fps, export at 30fps for smoothness
3. Use QuickTime Player for screen recording
4. Add background music from royalty-free sources:
   - YouTube Audio Library
   - Epidemic Sound
   - Artlist

---

## App Store Descriptions

### English Version

#### App Name
**La Pina - Women's Health**

(Max 30 characters, including app name)

#### Subtitle
**Period Tracker, Pregnancy & Health Insights**

(Max 30 characters)

#### Promotional Text
(Max 170 characters - can be updated without new app version)

```
Track your cycle, pregnancy, and health with AI-powered insights. Your personal women's health companion. Private, secure, and empowering.
```

#### Description
(Max 4,000 characters)

```
LA PINA - YOUR COMPLETE WOMEN'S HEALTH COMPANION

Take control of your reproductive health with La Pina, the comprehensive app designed by women, for women. Track your menstrual cycle, manage pregnancy, log symptoms, and gain personalized insights powered by AI.

KEY FEATURES

🌸 CYCLE TRACKING
• Accurate period predictions using advanced algorithms
• Ovulation tracking and fertility windows
• Customizable cycle length and symptoms
• Visual calendar with predictions up to 12 months

🤰 PREGNANCY COMPANION
• Week-by-week pregnancy tracking
• Milestone reminders and baby development info
• Contraction timer and kick counter
• Pregnancy-safe health tips

📊 HEALTH INSIGHTS
• AI-powered personalized insights based on your data
• Symptom pattern recognition
• Mood and wellness tracking
• Beautiful charts and visualizations

💊 SYMPTOM & WELLNESS LOGGING
• Track physical symptoms, moods, and activities
• Medication and supplement reminders
• Custom symptom categories
• Export health reports for your doctor

📚 EDUCATIONAL CONTENT
• Expert-written articles on women's health
• Pregnancy guides and tips
• Sexual health education
• Spanish and English content

🔒 PRIVACY & SECURITY
• All data encrypted and stored securely
• No ads, no data selling
• Optional cloud backup
• Passcode and biometric lock

💎 PREMIUM FEATURES
• Advanced AI health insights
• Unlimited data export
• Priority support
• Access to exclusive content

WHY LA PINA?

La Pina combines the best of cycle tracking, pregnancy management, and health analytics in one beautiful, easy-to-use app. Whether you're trying to conceive, managing your cycle, pregnant, or simply want to understand your body better, La Pina is here for you.

OUR COMMITMENT
La Pina is committed to providing accessible, accurate, and culturally relevant health information for all women, especially Latinas and Spanish-speaking communities.

SUBSCRIPTION INFORMATION
La Pina offers a free version with core features. Premium subscription unlocks advanced AI insights, unlimited exports, and more. Subscriptions are billed monthly or annually.

Download La Pina today and start your journey to better health!

---
La Pina is not a medical device and should not replace professional medical advice. Always consult with a healthcare provider for medical decisions.
```

#### Keywords
(Max 100 characters - comma separated, no spaces after commas)

```
period tracker,pregnancy,cycle,ovulation,fertility,women's health,menstrual,calendario menstrual
```

### Spanish Version

#### App Name
**La Pina - Salud Femenina**

#### Subtitle
**Calendario Menstrual y Embarazo**

#### Promotional Text
```
Rastrea tu ciclo, embarazo y salud con insights de IA. Tu compañera personal de salud femenina. Privada, segura y empoderadora.
```

#### Description

```
LA PINA - TU COMPAÑERA COMPLETA DE SALUD FEMENINA

Toma control de tu salud reproductiva con La Pina, la app integral diseñada por mujeres, para mujeres. Rastrea tu ciclo menstrual, gestiona tu embarazo, registra síntomas y obtén insights personalizados con IA.

CARACTERÍSTICAS PRINCIPALES

🌸 SEGUIMIENTO DE CICLO
• Predicciones precisas de periodo usando algoritmos avanzados
• Rastreo de ovulación y ventanas de fertilidad
• Ciclos y síntomas personalizables
• Calendario visual con predicciones hasta 12 meses

🤰 COMPAÑERA DE EMBARAZO
• Seguimiento de embarazo semana por semana
• Recordatorios de hitos y desarrollo del bebé
• Temporizador de contracciones y contador de patadas
• Consejos de salud seguros para el embarazo

📊 INSIGHTS DE SALUD
• Insights personalizados con IA basados en tus datos
• Reconocimiento de patrones de síntomas
• Seguimiento de ánimo y bienestar
• Gráficos y visualizaciones hermosas

💊 REGISTRO DE SÍNTOMAS Y BIENESTAR
• Rastrea síntomas físicos, ánimos y actividades
• Recordatorios de medicamentos y suplementos
• Categorías de síntomas personalizadas
• Exporta reportes de salud para tu doctor

📚 CONTENIDO EDUCATIVO
• Artículos escritos por expertos sobre salud femenina
• Guías y consejos de embarazo
• Educación en salud sexual
• Contenido en español e inglés

🔒 PRIVACIDAD Y SEGURIDAD
• Todos los datos encriptados y almacenados de forma segura
• Sin anuncios, sin venta de datos
• Respaldo en la nube opcional
• Bloqueo con código y biométrico

💎 FUNCIONES PREMIUM
• Insights avanzados de IA
• Exportación ilimitada de datos
• Soporte prioritario
• Acceso a contenido exclusivo

¿POR QUÉ LA PINA?

La Pina combina lo mejor del seguimiento de ciclos, gestión de embarazo y análisis de salud en una app hermosa y fácil de usar. Ya sea que estés intentando concebir, gestionando tu ciclo, embarazada, o simplemente quieras entender mejor tu cuerpo, La Pina está aquí para ti.

NUESTRO COMPROMISO
La Pina está comprometida a proporcionar información de salud accesible, precisa y culturalmente relevante para todas las mujeres, especialmente latinas y comunidades hispanohablantes.

INFORMACIÓN DE SUSCRIPCIÓN
La Pina ofrece una versión gratuita con funciones básicas. La suscripción Premium desbloquea insights avanzados de IA, exportaciones ilimitadas y más. Las suscripciones se cobran mensual o anualmente.

¡Descarga La Pina hoy y comienza tu viaje hacia una mejor salud!

---
La Pina no es un dispositivo médico y no debe reemplazar el consejo médico profesional. Siempre consulta con un proveedor de salud para decisiones médicas.
```

#### Keywords

```
calendario menstrual,embarazo,ciclo,ovulación,fertilidad,salud femenina,periodo,menstruación
```

---

## Keywords and ASO

### App Store Optimization Strategy

#### Primary Keywords (High Volume)
- period tracker
- pregnancy app
- cycle tracker
- ovulation calculator
- fertility tracker
- calendario menstrual
- embarazo

#### Secondary Keywords (Medium Volume)
- menstrual calendar
- women's health
- period calendar
- pregnancy tracker
- ovulation tracker
- salud femenina
- rastreador de periodo

#### Long-tail Keywords (Specific)
- AI health insights
- Spanish period tracker
- Latina health app
- cycle prediction
- pregnancy week by week
- insights de salud

### Keyword Research Tools
- [App Radar](https://appradar.com)
- [Sensor Tower](https://sensortower.com)
- [AppTweak](https://apptweak.com)
- Apple Search Ads keyword planner

### Keyword Best Practices

1. **Use all 100 characters** - maximize keyword space
2. **No spaces after commas** - saves characters
3. **No plurals needed** - Apple indexes both
4. **No app name repetition** - already indexed
5. **Mix English and Spanish** - bilingual audience
6. **Track keyword rankings** - adjust over time
7. **A/B test keywords** - optimize performance

---

## Category Recommendations

### Primary Category
**Health & Fitness**

This is the most appropriate category for La Pina as it focuses on women's health, cycle tracking, and wellness.

### Secondary Category
**Medical**

Secondary category helps with discoverability. Medical is appropriate given the health tracking and symptom logging features.

### Alternative Categories to Consider
- **Lifestyle** - If focusing more on wellness aspect
- **Education** - If emphasizing educational content

### Category Strategy

**Pros of Health & Fitness:**
- Large, engaged audience
- Expected category for health tracking apps
- Good for ASO and organic discovery
- Aligns with app purpose

**Considerations:**
- Competitive category (many period trackers)
- Need strong ASO to stand out
- Quality screenshots and reviews critical

---

## Additional Marketing Assets

### What's New Section
(Max 4,000 characters - updated with each version)

Update this with each release to highlight new features:

```
Version 1.1.0

NEW FEATURES
🎉 AI-Powered Health Insights - Get personalized recommendations based on your cycle and symptoms
🌐 Full Spanish Language Support - La app ahora está completamente en español
📊 Enhanced Charts - Beautiful new visualizations for your health data

IMPROVEMENTS
⚡️ Faster app performance
🐛 Bug fixes and stability improvements
💎 Improved premium subscription features

We're constantly improving La Pina based on your feedback. Thank you for being part of our community!
```

### Support URL
Provide a support website URL:
- https://lapina.app/support
- Include FAQ, contact form, privacy policy

### Marketing URL
Your main app website:
- https://lapina.app

### Privacy Policy URL
**Required** - Must be accessible:
- https://lapina.app/privacy

### Terms of Service URL
Recommended for subscription apps:
- https://lapina.app/terms

### App Store Rating Prompt

In your app code, request ratings at appropriate times:
```swift
import StoreKit

// Request rating after positive user actions
if #available(iOS 14.0, *) {
    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
        SKStoreReviewController.requestReview(in: scene)
    }
}
```

**Best times to request ratings:**
- After successfully logging 7+ cycles
- After using AI insights feature
- After completing pregnancy milestone
- After 30 days of active use

### Social Media Assets

Create consistent branding across:
- **Instagram:** @lapinaapp
- **Twitter/X:** @lapinaapp
- **TikTok:** @lapinaapp
- **Facebook:** facebook.com/lapinaapp

**Social Media Image Sizes:**
- Instagram Post: 1080x1080
- Instagram Story: 1080x1920
- Facebook Post: 1200x630
- Twitter Post: 1200x675

---

## Submission Checklist

### Before Submission

- [ ] App icons created for all required sizes
- [ ] Screenshots created for all device sizes
- [ ] Screenshots localized (English & Spanish)
- [ ] App preview videos created (optional but recommended)
- [ ] App name finalized (max 30 characters)
- [ ] Subtitle finalized (max 30 characters)
- [ ] Description written (both languages)
- [ ] Keywords optimized (100 characters used)
- [ ] Categories selected (Primary & Secondary)
- [ ] Support URL active and functional
- [ ] Privacy Policy URL active and accessible
- [ ] Marketing website live
- [ ] What's New text prepared
- [ ] Age rating determined (likely 12+ or 17+)
- [ ] Copyright information ready
- [ ] Contact information verified

### Content Rating Considerations

For La Pina, expect:
- **Medical/Treatment Information:** Yes
- **Sexual Content or Nudity:** Infrequent/Mild (educational)
- **Age Rating:** 12+ or 17+ (depending on content detail)

---

## Tools & Resources

### Design Resources
- [Apple Design Resources](https://developer.apple.com/design/resources/)
- [SF Symbols](https://developer.apple.com/sf-symbols/) - Apple's icon library
- [iOS Design Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

### ASO Tools
- [App Radar](https://appradar.com)
- [AppTweak](https://apptweak.com)
- [Sensor Tower](https://sensortower.com)
- [TheTool](https://thetool.io)

### Analytics
- App Store Connect Analytics (built-in)
- Google Analytics for Firebase
- Mixpanel
- Amplitude

---

## Next Steps

1. **Create app icons** using La Pina branding guidelines
2. **Design screenshots** highlighting key features
3. **Write localized descriptions** with ASO keywords
4. **Set up App Store Connect** listing
5. **Prepare preview videos** (optional but recommended)
6. **Submit for review** following TestFlight testing

---

**Last Updated:** March 2026
**Target Launch:** Q2 2026
**Supported Languages:** English, Spanish
**Supported Devices:** iPhone (iOS 13+), iPad (iPadOS 13+)
