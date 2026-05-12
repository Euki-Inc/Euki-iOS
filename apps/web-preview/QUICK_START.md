# Quick Start Guide - La Piña Web Preview Production Deployment

This is a TL;DR version of the production deployment guide. For comprehensive details, see `PRODUCTION_DEPLOYMENT.md`.

## ⚡ 5-Minute Setup (Minimum Viable Production)

### 1. Create Required Assets (Use placeholders if needed)

```bash
cd /home/user/-la-pina-cdmx/apps/web-preview/public

# Create placeholder images (replace with real ones ASAP)
# These are the CRITICAL ones needed for launch:

# Favicon and PWA icons
touch favicon.ico
touch icon-192x192.png
touch icon-512x512.png
touch apple-touch-icon.png

# Main OG image
touch og-image.png
```

### 2. Set Environment Variables

```bash
# Copy the production template
cp .env.production .env.production.local

# Edit and fill in these REQUIRED values:
# - NEXT_PUBLIC_BASE_URL=https://yourdomain.com
# - NEXT_PUBLIC_SUPABASE_URL=your_url
# - NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key
# - NEXT_PUBLIC_STRIPE_PUBLIC_KEY=your_key
# - CLAUDE_API_KEY=your_key
# - STRIPE_SECRET_KEY=your_key
# - APIFY_TOKEN=your_token
```

### 3. Update Domain References

```bash
# Update these files with your actual domain:
# - public/robots.txt (line 9: Sitemap URL)
# - public/security.txt (all URLs)
# - public/.well-known/security.txt (all URLs)
```

### 4. Build & Test

```bash
# Install dependencies
npm install

# Build for production
npm run build

# Test locally
npm run start

# Visit http://localhost:3000 and verify:
# - Homepage loads
# - All navigation works
# - No console errors
```

### 5. Deploy to Vercel (Easiest)

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel --prod

# Add environment variables in Vercel dashboard
# https://vercel.com/dashboard/[your-project]/settings/environment-variables
```

### 6. Post-Deploy Verification

```bash
# Visit these URLs and verify they work:
https://yourdomain.com
https://yourdomain.com/sitemap.xml
https://yourdomain.com/robots.txt
https://yourdomain.com/api/health
https://yourdomain.com/.well-known/security.txt
```

---

## 📋 Complete Pre-Launch Checklist

### Assets Required ⚠️
- [ ] favicon.ico (generated)
- [ ] icon-192x192.png (generated)
- [ ] icon-512x512.png (generated)
- [ ] apple-touch-icon.png (generated)
- [ ] og-image.png (1200x630, designed)
- [ ] og-cycle.png (1200x630, designed)
- [ ] og-symptoms.png (1200x630, designed)
- [ ] og-pregnancy.png (1200x630, designed)
- [ ] og-insights.png (1200x630, designed)
- [ ] og-blog.png (1200x630, designed)
- [ ] twitter-image.png (1200x630, designed)
- [ ] Twitter images for each page

**Tools to Generate:**
- Favicon: https://realfavicongenerator.net/
- OG Images: Design in Figma/Canva with La Piña branding

### Environment Variables ⚠️
- [ ] NEXT_PUBLIC_BASE_URL set
- [ ] Supabase credentials configured
- [ ] Stripe keys configured
- [ ] Claude API key set
- [ ] Apify token set
- [ ] Optional: Google Analytics ID
- [ ] Optional: Sentry DSN

### Configuration ⚠️
- [ ] Domain pointed to hosting
- [ ] SSL certificate active
- [ ] robots.txt domain updated
- [ ] security.txt domain updated

### Testing ✅
- [ ] Build succeeds (`npm run build`)
- [ ] All pages load
- [ ] Mobile responsive
- [ ] No console errors
- [ ] Forms work (when implemented)
- [ ] PWA installable

### External Services 🔧
- [ ] Google Search Console verified
- [ ] Sitemap submitted
- [ ] Social previews tested
- [ ] Analytics tracking verified

---

## 🚀 Deployment Options

### Option 1: Vercel (Recommended - Easiest)

```bash
vercel --prod
```

**Pros:**
- Zero config for Next.js
- Automatic SSL
- CDN included
- Analytics included
- Easy environment variables
- Preview deployments

**Time:** 5 minutes

### Option 2: Netlify

```bash
# Connect GitHub repo in Netlify dashboard
# Build command: npm run build
# Publish directory: .next
```

**Time:** 10 minutes

### Option 3: Docker

```bash
# See PRODUCTION_DEPLOYMENT.md for Dockerfile
docker build -t lapina-web .
docker run -p 3000:3000 lapina-web
```

**Time:** 30 minutes

---

## 📊 Success Metrics (Week 1)

After deployment, verify:
- [ ] 99.9%+ uptime
- [ ] PageSpeed Insights score > 85
- [ ] All Core Web Vitals green
- [ ] Zero critical errors in logs
- [ ] Indexed by Google

---

## 🆘 Troubleshooting Quick Fixes

### Build Fails
```bash
rm -rf node_modules .next package-lock.json
npm install
npm run build
```

### Environment Variables Not Working
```bash
# Rebuild after changing env vars
npm run build

# For Vercel: Add in dashboard, then redeploy
vercel --prod
```

### Images Not Loading
- Check images exist in `/public`
- Check paths don't have leading `/`
- Verify image optimization is enabled

### Slow Performance
```bash
# Analyze bundle
npm run build:analyze

# Check images are optimized (WebP/AVIF)
# Enable compression in hosting platform
```

---

## 📞 Need Help?

1. **Quick Reference:** See `PRODUCTION_SETUP.md`
2. **Comprehensive Guide:** See `PRODUCTION_DEPLOYMENT.md`
3. **Changes Made:** See `PRODUCTION_CHANGES.md`
4. **Next.js Docs:** https://nextjs.org/docs

---

## ✨ What's Included

This production setup includes:
- ✅ Security headers (HSTS, CSP, etc.)
- ✅ SEO optimization (meta tags, sitemap, robots.txt)
- ✅ Performance optimization (image optimization, caching, compression)
- ✅ PWA support (manifest, install prompt)
- ✅ Error handling (error boundaries, 404 page)
- ✅ Loading states (skeletons for all pages)
- ✅ Analytics ready (GA4, Plausible support)
- ✅ Health check endpoint
- ✅ Security disclosure policy
- ✅ Comprehensive documentation

---

## 🎯 Launch Day Timeline

**Morning:**
- [ ] Final build test
- [ ] Verify all environment variables
- [ ] Check all assets are uploaded

**Afternoon:**
- [ ] Deploy to production
- [ ] Verify all URLs work
- [ ] Submit sitemap to Google
- [ ] Test on mobile devices

**Evening:**
- [ ] Monitor error logs
- [ ] Check analytics tracking
- [ ] Verify social previews
- [ ] Celebrate! 🎉

---

**Ready to deploy?** Follow the steps above and you'll be live in under an hour!

**Questions?** Check the comprehensive guides in this directory.

**Version:** 1.0.0
**Last Updated:** 2026-03-09
