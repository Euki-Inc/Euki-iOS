# Production Deployment Guide - La Piña Web Preview

Last Updated: 2026-03-09

## Table of Contents
1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Environment Variables](#environment-variables)
3. [Build & Deploy](#build--deploy)
4. [Post-Deployment](#post-deployment)
5. [Performance Monitoring](#performance-monitoring)
6. [SEO Verification](#seo-verification)
7. [Security Checklist](#security-checklist)
8. [Troubleshooting](#troubleshooting)

---

## Pre-Deployment Checklist

### Code Quality
- [ ] All TypeScript errors resolved (`npm run lint`)
- [ ] No console.log statements in production code
- [ ] All TODO comments addressed or documented
- [ ] Code reviewed and approved
- [ ] Tests passing (when implemented)

### Assets
- [ ] All images optimized (WebP/AVIF formats)
- [ ] Favicon and PWA icons generated
  - [ ] `/public/favicon.ico`
  - [ ] `/public/icon-192x192.png`
  - [ ] `/public/icon-512x512.png`
  - [ ] `/public/apple-touch-icon.png`
- [ ] Social media images created
  - [ ] `/public/og-image.png` (1200x630)
  - [ ] `/public/og-cycle.png`
  - [ ] `/public/og-symptoms.png`
  - [ ] `/public/og-pregnancy.png`
  - [ ] `/public/og-insights.png`
  - [ ] `/public/og-blog.png`
  - [ ] `/public/twitter-image.png` (1200x630)
  - [ ] Twitter images for each page

### Configuration Files
- [ ] `.env.production` configured with production values
- [ ] `next.config.js` reviewed
- [ ] `middleware.ts` security headers verified
- [ ] `robots.txt` updated with correct domain
- [ ] `sitemap.ts` returns correct URLs

---

## Environment Variables

### Required Production Variables

Copy `.env.production` and fill in all values:

```bash
# 1. Base URL - CRITICAL
NEXT_PUBLIC_BASE_URL=https://lapina.com

# 2. Supabase (Required)
NEXT_PUBLIC_SUPABASE_URL=your_production_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_production_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key

# 3. Stripe (Required for payments)
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=pk_live_xxx
STRIPE_SECRET_KEY=sk_live_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

# 4. Claude AI (Required for AI features)
CLAUDE_API_KEY=sk-ant-xxx

# 5. Apify (Required for web scraping)
APIFY_TOKEN=your_token
```

### Optional but Recommended

```bash
# Analytics
NEXT_PUBLIC_GA_MEASUREMENT_ID=G-XXXXXXXXXX

# Error Tracking
NEXT_PUBLIC_SENTRY_DSN=https://xxx@xxx.ingest.sentry.io/xxx
SENTRY_AUTH_TOKEN=xxx

# Email
SENDGRID_API_KEY=SG.xxx
```

### Vercel Deployment

If deploying to Vercel:
1. Add all environment variables in Vercel dashboard
2. Set `NEXT_PUBLIC_BASE_URL` to your production domain
3. Configure domains in Vercel settings
4. Enable Vercel Analytics (automatic)

---

## Build & Deploy

### Local Production Build Test

```bash
# 1. Clean install
rm -rf node_modules .next
npm install

# 2. Build for production
npm run build

# 3. Test production build locally
npm run start

# 4. Visit http://localhost:3000 and test all pages
```

### Expected Build Output

```
Route (app)                              Size     First Load JS
┌ ○ /                                    0 B            XX kB
├ ○ /blog                                X kB           XX kB
├ ○ /cycle                               X kB           XX kB
├ ○ /insights                            X kB           XX kB
├ ○ /pregnancy                           X kB           XX kB
└ ○ /symptoms                            X kB           XX kB
+ First Load JS shared by all            XX kB
  ├ chunks/framework-xxx.js              XX kB
  └ chunks/main-app-xxx.js               XX kB

○  (Static)  prerendered as static content
```

### Deploy to Vercel

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy to production
vercel --prod
```

### Deploy to Other Platforms

#### Netlify
1. Connect GitHub repository
2. Build command: `npm run build`
3. Publish directory: `.next`
4. Add environment variables

#### AWS Amplify / CloudFront
1. Use Next.js SSR support
2. Configure CloudFront for image optimization
3. Set up Lambda@Edge for middleware

#### Docker
```dockerfile
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV production
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
EXPOSE 3000
CMD ["node", "server.js"]
```

---

## Post-Deployment

### Immediate Verification

- [ ] Homepage loads correctly
- [ ] All navigation links work
- [ ] Images load and display properly
- [ ] Mobile responsive design works
- [ ] PWA installable on mobile devices
- [ ] Forms submit correctly (when implemented)
- [ ] No console errors in browser DevTools
- [ ] Check all pages in incognito mode

### DNS & Domain

- [ ] Domain configured and pointing to deployment
- [ ] SSL certificate active (HTTPS working)
- [ ] WWW redirect configured (if applicable)
- [ ] DNS propagated worldwide (use whatsmydns.net)

### Performance Check

Visit these tools and verify scores:
- [ ] [PageSpeed Insights](https://pagespeed.web.dev/) - Target: 90+ on mobile
- [ ] [WebPageTest](https://www.webpagetest.org/) - Target: A grades
- [ ] [GTmetrix](https://gtmetrix.com/) - Target: A/B grades
- [ ] Core Web Vitals all green

---

## Performance Monitoring

### Metrics to Track

1. **Core Web Vitals**
   - LCP (Largest Contentful Paint): < 2.5s
   - FID (First Input Delay): < 100ms
   - CLS (Cumulative Layout Shift): < 0.1

2. **Additional Metrics**
   - TTFB (Time to First Byte): < 600ms
   - FCP (First Contentful Paint): < 1.8s
   - TTI (Time to Interactive): < 3.8s

### Monitoring Tools

- **Google Analytics 4**: User behavior and conversions
- **Vercel Analytics**: Real-time performance data
- **Sentry**: Error tracking and performance monitoring
- **LogRocket**: Session replay and debugging

### Set Up Alerts

Configure alerts for:
- Error rate > 1%
- Response time > 3s
- Uptime < 99.9%

---

## SEO Verification

### Search Console Setup

1. **Google Search Console**
   - Add property at [search.google.com/search-console](https://search.google.com/search-console)
   - Verify ownership (meta tag in layout.tsx)
   - Submit sitemap: `https://lapina.com/sitemap.xml`

2. **Bing Webmaster Tools**
   - Add site at [bing.com/webmasters](https://www.bing.com/webmasters)
   - Submit sitemap

### Verify Sitemap

- [ ] Visit `/sitemap.xml` and verify all pages listed
- [ ] Check `lastModified` dates are correct
- [ ] Verify priorities are logical (1.0 for home, 0.8-0.9 for important pages)

### Check robots.txt

- [ ] Visit `/robots.txt` and verify content
- [ ] Ensure sitemap URL is correct
- [ ] Verify no important pages are blocked

### Social Media Preview

Test Open Graph tags:
- [ ] [Facebook Debugger](https://developers.facebook.com/tools/debug/)
- [ ] [Twitter Card Validator](https://cards-dev.twitter.com/validator)
- [ ] [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/)

### Structured Data

Consider adding:
- Organization schema
- Article schema for blog posts
- FAQ schema for help content

---

## Security Checklist

### Headers Verification

Visit [securityheaders.com](https://securityheaders.com/) and verify:
- [ ] Strict-Transport-Security: HSTS enabled
- [ ] X-Frame-Options: SAMEORIGIN
- [ ] X-Content-Type-Options: nosniff
- [ ] Content-Security-Policy: Configured
- [ ] Referrer-Policy: Set
- [ ] Permissions-Policy: Configured

### Additional Security

- [ ] All API keys are environment variables (never in code)
- [ ] `.env.production` is in `.gitignore`
- [ ] HTTPS enforced (no HTTP access)
- [ ] CORS configured properly (if using API)
- [ ] Rate limiting implemented (when backend ready)
- [ ] Input validation on all forms
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (React escapes by default)

### Secrets Management

- [ ] Rotate all API keys after deployment
- [ ] Use Vercel/AWS Secrets Manager for sensitive data
- [ ] Never commit `.env.production` to git
- [ ] Limit team access to production secrets

---

## Troubleshooting

### Build Fails

**Error: Cannot find module**
```bash
rm -rf node_modules package-lock.json
npm install
npm run build
```

**Error: Out of memory**
```bash
NODE_OPTIONS=--max_old_space_size=4096 npm run build
```

### Images Not Loading

1. Check image paths are correct
2. Verify images exist in `/public`
3. Check browser console for 404 errors
4. Verify CDN/image optimization settings

### Slow Performance

1. Check bundle size: `npm run build` shows bundle sizes
2. Verify images are optimized (use WebP/AVIF)
3. Check for large dependencies: `npx webpack-bundle-analyzer .next/server/app/*.js`
4. Enable compression in hosting platform
5. Use CDN for static assets

### SEO Issues

**Pages not indexed**
1. Check robots.txt isn't blocking
2. Submit sitemap to Search Console
3. Verify canonical URLs are correct
4. Check for crawl errors in Search Console

**Social previews not working**
1. Clear cache: Use Facebook Debugger "Scrape Again"
2. Verify meta tags in page source (view-source:)
3. Check image URLs are absolute, not relative
4. Ensure images are at least 1200x630px

### Environment Variables Not Working

1. Verify variable names start with `NEXT_PUBLIC_` for client-side
2. Rebuild after changing env vars: `npm run build`
3. Restart dev server: `npm run dev`
4. Check Vercel dashboard for correct values

---

## Maintenance

### Regular Tasks

**Weekly**
- [ ] Review error logs in Sentry
- [ ] Check Core Web Vitals in Search Console
- [ ] Monitor uptime and response times

**Monthly**
- [ ] Update dependencies: `npm outdated` then `npm update`
- [ ] Review and rotate API keys
- [ ] Analyze user analytics
- [ ] Review and fix broken links

**Quarterly**
- [ ] Security audit
- [ ] Performance optimization review
- [ ] SEO content refresh
- [ ] Backup verification

---

## Support & Resources

### Documentation
- [Next.js Production Checklist](https://nextjs.org/docs/going-to-production)
- [Vercel Deployment Docs](https://vercel.com/docs)
- [Web Vitals Guide](https://web.dev/vitals/)

### Team Contacts
- DevOps: [Add contact]
- Security: [Add contact]
- Product: [Add contact]

---

## Rollback Procedure

If deployment fails or critical issues arise:

### Vercel
```bash
# List deployments
vercel ls

# Rollback to previous
vercel rollback [deployment-url]
```

### Manual Rollback
1. Revert git commit: `git revert HEAD`
2. Push to main: `git push origin main`
3. Trigger new deployment

---

## Success Metrics

### Week 1 Targets
- ✅ 99.9% uptime
- ✅ PageSpeed score > 85
- ✅ All Core Web Vitals in green
- ✅ Zero critical errors

### Month 1 Targets
- ✅ Indexed by Google
- ✅ 100+ organic visits
- ✅ Social media previews working
- ✅ PWA installation rate > 5%

---

**Questions?** Contact the development team or refer to the main README.md

**Last Deployment:** [Add date]
**Deployed By:** [Add name]
**Version:** [Add version from package.json]
