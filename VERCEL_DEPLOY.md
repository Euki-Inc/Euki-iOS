# 🚀 La Piña Vercel Deployment Guide

**Status:** ✅ Build successful
**App Location:** `/home/user/-la-pina-cdmx/apps/web-preview`
**Vercel CLI:** Installed (v50.9.6)

---

## Quick Deploy (3 Steps)

### Step 1: Login to Vercel

```bash
cd /home/user/-la-pina-cdmx/apps/web-preview
vercel login
```

This will open a browser or provide a login link. Options:
- **Email** - Enter your email, click verification link
- **GitHub** - OAuth login
- **GitLab** - OAuth login
- **Bitbucket** - OAuth login

### Step 2: Deploy to Production

```bash
vercel --prod
```

The CLI will ask a few questions:
```
? Set up and deploy "~/apps/web-preview"? [Y/n] Y
? Which scope do you want to deploy to? [Your Account]
? Link to existing project? [y/N] N
? What's your project's name? la-pina-web
? In which directory is your code located? ./
? Want to override the settings? [y/N] N
```

**Just press Enter for defaults** - the configuration is already correct!

### Step 3: Get Your URL

After deployment completes (~30-60 seconds), you'll see:
```
✅ Production: https://la-pina-web.vercel.app [copied]
```

**Your app is live!** 🎉

---

## Alternative: Deploy with Token (CI/CD)

If you have a Vercel token:

```bash
export VERCEL_TOKEN=your-token-here
vercel --prod --token $VERCEL_TOKEN --yes
```

Get a token at: https://vercel.com/account/tokens

---

## What Gets Deployed

✅ All 5 pages: Cycle, Symptoms, Pregnancy, Insights, Blog
✅ All components: TabNav, SpiralHeader, PaywallCard, Charts
✅ La Piña theme with gradients
✅ Mock data (no backend needed)
✅ Fully responsive design
✅ Zero configuration required

---

## After Deployment

### Update iOS Config.plist

Once deployed, update your iOS app to load the blog:

```bash
# Edit Euki/Resources/Config.plist
```

```xml
<key>BLOG_BASE_URL</key>
<string>https://la-pina-web.vercel.app</string>
```

Now the iOS Blog tab will load your live web app!

### Configure Custom Domain (Optional)

In Vercel dashboard:
1. Go to your project → Settings → Domains
2. Add custom domain: `lapina.app` or `www.lapina.app`
3. Update DNS records as instructed
4. SSL certificate auto-provisions

### Add Environment Variables (Optional - for future)

If you add real APIs later:

1. Go to Vercel dashboard → Your Project → Settings → Environment Variables
2. Add:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `NEXT_PUBLIC_STRIPE_PUBLIC_KEY`
   - `CLAUDE_API_KEY`
   - `APIFY_TOKEN`
3. Redeploy for changes to take effect

---

## Deployment Options Comparison

| Method | Speed | Control | Use Case |
|--------|-------|---------|----------|
| **Vercel CLI** | Fast | Full | Development, quick deploys |
| **GitHub Integration** | Auto | Medium | Continuous deployment |
| **Vercel Dashboard** | Manual | Full | One-off imports |

---

## GitHub Integration (Recommended for Production)

For automatic deployments on every push:

1. Go to https://vercel.com/new
2. Click "Import Git Repository"
3. Select your GitHub account
4. Choose: `executiveusa/-la-pina-cdmx`
5. Set Root Directory: `apps/web-preview`
6. Framework Preset: Next.js (auto-detected)
7. Click "Deploy"

Now every push to `main` branch auto-deploys! 🚀

---

## Troubleshooting

### Build Fails

**Error:** `Module not found`
```bash
# Solution: Install dependencies
cd apps/web-preview
npm install
vercel --prod
```

### Authentication Issues

**Error:** `Not authenticated`
```bash
# Solution: Re-login
vercel logout
vercel login
```

### Old Deployment Still Showing

```bash
# Solution: Clear cache and redeploy
vercel --prod --force
```

---

## Deployment Checklist

- [x] Build succeeds locally (`npm run build` ✅)
- [x] Vercel CLI installed (v50.9.6 ✅)
- [ ] Login to Vercel account
- [ ] Deploy with `vercel --prod`
- [ ] Verify live URL works
- [ ] Update iOS Config.plist with URL
- [ ] Test iOS Blog tab loads web app
- [ ] (Optional) Set up custom domain
- [ ] (Optional) Configure GitHub auto-deploy

---

## Next Steps After Deploy

1. **Test Live Site:**
   - Visit all 5 tabs: /cycle, /symptoms, /pregnancy, /insights, /blog
   - Test on mobile, tablet, desktop
   - Verify colors and animations

2. **Share Preview:**
   - Send URL to team/stakeholders
   - Get feedback on design
   - Test with real users

3. **iOS Integration:**
   - Update Config.plist with Vercel URL
   - Build iOS app
   - Test Blog tab WebView
   - Submit to TestFlight

4. **Launch Prep:**
   - Add real content to blog posts
   - Set up analytics (Plausible, Fathom)
   - Configure SEO metadata
   - Add social sharing cards

---

## Support

**Vercel Docs:** https://vercel.com/docs
**Next.js Deployment:** https://nextjs.org/docs/deployment
**Issues:** https://github.com/executiveusa/-la-pina-cdmx/issues

---

**Ready to deploy?** Run: `vercel login` then `vercel --prod`

🍍 Your La Piña web app will be live in 60 seconds!
