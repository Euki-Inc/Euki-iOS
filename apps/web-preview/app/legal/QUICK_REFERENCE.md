# Legal Components - Quick Reference Card

## 🚀 Most Common Use Cases

### 1. Pregnancy Page
```tsx
import { MedicalDisclaimer, WhenToSeeDoctor } from '@/app/legal/disclaimers'

<MedicalDisclaimer variant="banner" />
{/* content */}
<WhenToSeeDoctor className="mt-8" />
```

### 2. Cycle Insights
```tsx
import { MedicalDisclaimer } from '@/app/legal/disclaimers'

<MedicalDisclaimer variant="card" />
{/* AI predictions */}
```

### 3. Blog Post
```tsx
import { EducationalNotice, AffiliateDisclosure } from '@/app/legal/disclaimers'

<EducationalNotice className="mb-6" />
{/* content */}
<AffiliateDisclosure className="mt-8" />
```

### 4. App Footer
```tsx
<footer>
  <Link href="/privacy">Privacy</Link>
  <Link href="/terms">Terms</Link>
  <a href="mailto:support@lapina.app">Support</a>
</footer>
```

### 5. Onboarding
```tsx
import { MedicalDisclaimer, PrivacyNotice } from '@/app/legal/disclaimers'

<MedicalDisclaimer variant="card" showEmergencyResources={true} />
<PrivacyNotice className="mt-6" />
```

---

## 📋 Component Cheat Sheet

| Component | When to Use | Variant |
|-----------|-------------|---------|
| `MedicalDisclaimer` | ALL health pages | `banner`, `card`, `inline` |
| `WhenToSeeDoctor` | After insights/tracking | - |
| `EmergencyResources` | Crisis content | - |
| `AffiliateDisclosure` | Amazon links | - |
| `EducationalNotice` | Blog/tips | - |
| `PrivacyNotice` | Settings/onboarding | - |

---

## ✅ Pre-Launch Essentials

- [ ] Medical disclaimer on pregnancy page
- [ ] Medical disclaimer on cycle insights
- [ ] Medical disclaimer on symptom tracking
- [ ] Affiliate disclosure on blog posts
- [ ] Footer links (privacy, terms, support)
- [ ] Onboarding terms acceptance
- [ ] Data export button in settings
- [ ] Delete account button in settings
- [ ] Email addresses working (support@, privacy@)

---

## 📞 Contact Emails

- `support@lapina.app` - General support
- `privacy@lapina.app` - GDPR/CCPA requests
- `legal@lapina.app` - Legal questions

Response time: **3 business days**

---

## 🔗 Legal Page URLs

- Privacy Policy: `/privacy`
- Terms of Service: `/terms`
- Emergency Resources: `/terms#emergency`

---

## 🚨 Emergency Numbers

**US**: 911 (emergency), 988 (crisis)  
**MX**: 911 (emergencias), 55 5259-8121 (SAPTEL)

---

## 📚 Documentation

- `/app/legal/README.md` - Full usage guide
- `/app/legal/SUMMARY.md` - This summary
- `/app/legal/integration-example.tsx` - Code examples
- `/LEGAL_LAUNCH_CHECKLIST.md` - Pre-launch checklist

---

## ⚠️ Critical Rules

1. **ALWAYS** add medical disclaimer to health pages
2. **ALWAYS** add affiliate disclosure to Amazon links
3. **NEVER** make medical claims or treatment promises
4. **NEVER** market as birth control or medical device
5. **ALWAYS** respond to privacy requests within 30 days

---

## 🎯 Quick Decision Tree

**Is this a health/medical page?**  
→ Yes: Add `MedicalDisclaimer`

**Does it have AI predictions?**  
→ Yes: Use `variant="card"` + `WhenToSeeDoctor`

**Does it have Amazon links?**  
→ Yes: Add `AffiliateDisclosure`

**Is it educational content?**  
→ Yes: Add `EducationalNotice`

**Is it onboarding/settings?**  
→ Yes: Add `PrivacyNotice`

---

**Last Updated**: 2026-03-09
