# Legal Components - Usage Guide

This directory contains reusable legal disclaimer components for La Piña.

## Components

### 1. MedicalDisclaimer

**Purpose**: Display medical disclaimers wherever health information is shown.

**Variants**:
- `inline` - Small one-line disclaimer
- `card` - Full card with detailed disclaimer (default)
- `banner` - Horizontal banner style
- `modal` - Full-screen modal overlay

**Usage**:
```tsx
import { MedicalDisclaimer } from '@/app/legal/disclaimers'

// Inline variant (minimal)
<MedicalDisclaimer variant="inline" />

// Card variant (recommended for most pages)
<MedicalDisclaimer variant="card" />

// With emergency resources
<MedicalDisclaimer variant="card" showEmergencyResources={true} />

// Banner at top of page
<MedicalDisclaimer variant="banner" />
```

**Best Practices**:
- Use on: Cycle predictions, symptom insights, pregnancy tracking, health blog posts
- Place at top of page or before critical health information
- Always show on pages with AI-generated health insights

---

### 2. EmergencyResources

**Purpose**: Display emergency hotline numbers for US and Mexico.

**Usage**:
```tsx
import { EmergencyResources } from '@/app/legal/disclaimers'

<EmergencyResources />
```

**Best Practices**:
- Show on: Crisis-related content, pregnancy complications info, mental health pages
- Collapsible by default to avoid alarm but easily accessible

---

### 3. WhenToSeeDoctor

**Purpose**: Guide users on when to consult healthcare professionals.

**Usage**:
```tsx
import { WhenToSeeDoctor } from '@/app/legal/disclaimers'

<WhenToSeeDoctor />
```

**Best Practices**:
- Show on: Symptom tracking pages, pregnancy mode, cycle insights
- Helps users understand when app insights require professional follow-up

---

### 4. AffiliateDisclosure

**Purpose**: Disclose Amazon affiliate relationships.

**Usage**:
```tsx
import { AffiliateDisclosure } from '@/app/legal/disclaimers'

<AffiliateDisclosure />
```

**Best Practices**:
- Required on: Blog posts with product links, product recommendation pages
- Place at top or bottom of page

---

### 5. PrivacyNotice

**Purpose**: Highlight privacy-first approach.

**Usage**:
```tsx
import { PrivacyNotice } from '@/app/legal/disclaimers'

<PrivacyNotice />
```

**Best Practices**:
- Show on: Onboarding, settings, data export pages
- Reassures users about data handling

---

### 6. EducationalNotice

**Purpose**: Short educational content disclaimer.

**Usage**:
```tsx
import { EducationalNotice } from '@/app/legal/disclaimers'

<EducationalNotice />
```

**Best Practices**:
- Use on: Blog articles, educational content, tips
- Lightweight alternative to full medical disclaimer

---

## Example Integration

### Pregnancy Tracking Page
```tsx
import {
  MedicalDisclaimer,
  WhenToSeeDoctor,
  EmergencyResources
} from '@/app/legal/disclaimers'

export default function PregnancyPage() {
  return (
    <div>
      {/* Medical disclaimer at top */}
      <MedicalDisclaimer variant="banner" />

      {/* Page content */}
      <PregnancyTracker />

      {/* Guidance section */}
      <WhenToSeeDoctor className="mt-8" />

      {/* Emergency resources */}
      <EmergencyResources />
    </div>
  )
}
```

### Blog Post with Affiliate Links
```tsx
import {
  EducationalNotice,
  AffiliateDisclosure
} from '@/app/legal/disclaimers'

export default function BlogPost() {
  return (
    <article>
      <EducationalNotice className="mb-6" />

      {/* Blog content */}
      <BlogContent />

      {/* Affiliate products */}
      <ProductRecommendations />

      <AffiliateDisclosure className="mt-8" />
    </article>
  )
}
```

### Cycle Insights Page
```tsx
import {
  MedicalDisclaimer,
  WhenToSeeDoctor
} from '@/app/legal/disclaimers'

export default function InsightsPage() {
  return (
    <div>
      {/* Card disclaimer before insights */}
      <MedicalDisclaimer
        variant="card"
        showEmergencyResources={false}
        className="mb-6"
      />

      {/* AI-generated insights */}
      <CycleInsights />

      {/* When to consult doctor */}
      <WhenToSeeDoctor className="mt-8" />
    </div>
  )
}
```

---

## Legal Pages

### Privacy Policy
**URL**: `/privacy`
**File**: `apps/web-preview/app/privacy/page.tsx`

**Sections**:
- Data Collection (what we collect)
- Data Storage (local-first, optional cloud)
- Data Sharing (we don't sell data)
- Third-Party Services (Stripe, Supabase, Amazon)
- Cookies & Tracking (minimal)
- User Rights (GDPR, CCPA)
- Security measures
- Children's Privacy
- Contact information

### Terms of Service
**URL**: `/terms`
**File**: `apps/web-preview/app/terms/page.tsx`

**Sections**:
- Medical Disclaimer (prominent)
- Emergency Resources
- Service Description
- Subscription Terms ($9.99/year)
- Refund Policy (30-day guarantee)
- User Conduct
- Intellectual Property
- Disclaimers & Liability Limitations
- Governing Law
- Contact information

---

## Legal Data Reference

**File**: `apps/web-preview/public/legal.json`

Contains structured legal data:
- Version and effective dates
- Contact emails
- Emergency resources (US, MX)
- Medical disclaimer text
- Subscription terms
- Data retention policies
- Third-party services
- Cookie information
- User rights (GDPR, CCPA)

**Usage**:
```tsx
import legalData from '@/public/legal.json'

const emergencyUS = legalData.emergencyResources.us.suicide
// { name: "National Suicide Prevention Lifeline", phone: "988", available: "24/7" }
```

---

## Compliance Checklist

Before production launch:

### Medical Liability
- [ ] Medical disclaimer on ALL health-related pages
- [ ] "Not for birth control" warning prominent
- [ ] Emergency resources accessible
- [ ] Clear statement: "Not a medical device"

### Privacy Compliance
- [ ] Privacy Policy accessible from all pages
- [ ] Cookie consent (if adding cookies)
- [ ] Data export functionality
- [ ] Account deletion functionality
- [ ] GDPR rights implemented
- [ ] CCPA rights implemented

### Payment & Subscriptions
- [ ] Refund policy clearly stated
- [ ] Subscription terms transparent
- [ ] Cancellation process documented
- [ ] Stripe ToS linked

### Affiliate Links
- [ ] Disclosure on ALL pages with affiliate links
- [ ] Amazon Associates ToS compliance
- [ ] Clear distinction between recommendations and ads

### General
- [ ] Terms of Service accessible
- [ ] Contact email functional (support@lapina.app)
- [ ] Privacy email functional (privacy@lapina.app)
- [ ] Legal review (recommended before launch)

---

## Footer Integration

Add to app footer:
```tsx
<footer className="border-t border-neutral-200 p-4 text-center">
  <div className="flex flex-wrap gap-4 justify-center text-sm text-neutral-600">
    <Link href="/privacy" className="hover:text-pina-pink">Privacy Policy</Link>
    <Link href="/terms" className="hover:text-pina-pink">Terms of Service</Link>
    <a href="mailto:support@lapina.app" className="hover:text-pina-pink">Contact</a>
  </div>
  <p className="text-xs text-neutral-500 mt-2">
    © 2026 La Piña. Not medical advice. Consult healthcare professionals.
  </p>
</footer>
```

---

## Important Notes

1. **Keep Updated**: Review legal docs quarterly or when features change
2. **Version Control**: Update version numbers in legal.json when changing policies
3. **User Notification**: Notify users of material changes via email/in-app
4. **Legal Review**: Consider professional legal review before production launch
5. **Accessibility**: Ensure all legal pages are screen-reader friendly

---

## Contact for Legal Questions

- **Privacy**: privacy@lapina.app
- **Legal**: legal@lapina.app
- **Support**: support@lapina.app

Last Updated: 2026-03-09
