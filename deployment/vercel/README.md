# Vercel Deployment Guide

This directory contains the configuration and scripts for deploying the LA PINA Women's Health App to Vercel.

## Files

- **vercel.json** - Vercel project configuration
- **deploy.sh** - Automated deployment script
- **README.md** - This file

## Quick Start

### Automated Deployment

1. Ensure you have the Vercel CLI installed:
   ```bash
   npm install -g vercel
   ```

2. Set your Vercel authentication token (optional for automated CI/CD):
   ```bash
   export VERCEL_TOKEN=your_vercel_token_here
   ```

3. Run the deployment script from the project root:
   ```bash
   bash deployment/vercel/deploy.sh
   ```

### Manual Deployment

1. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```

2. Login to Vercel:
   ```bash
   vercel login
   ```

3. Deploy to production:
   ```bash
   vercel deploy --prod
   ```

## Setting Up Vercel Project

### First Time Setup

1. **Create a Vercel Account**
   - Go to [https://vercel.com](https://vercel.com)
   - Sign up with GitHub, GitLab, or Bitbucket

2. **Import Your Repository**
   - Click "New Project" in your Vercel dashboard
   - Select your Git repository
   - Vercel will detect the framework as Next.js

3. **Configure Build Settings**
   - Build Command: `cd apps/web-preview && npm run build`
   - Output Directory: `apps/web-preview/.next`
   - Root Directory: (leave default or set to repository root)

4. **Deploy**
   - Click "Deploy"
   - Your app will be deployed automatically

### Subsequent Deployments

After initial setup, your app will automatically deploy whenever you push to your connected Git branch.

## Managing Secrets and Environment Variables

### Adding Secrets in Vercel Dashboard

1. Go to your project in the Vercel dashboard
2. Navigate to Settings → Environment Variables
3. Add your environment variables:
   - Click "Add"
   - Enter variable name and value
   - Select which environments it applies to (Production, Preview, Development)
   - Click "Save"

### Common Environment Variables

Depending on your app's needs, you may want to add:

- `DATABASE_URL` - Database connection string
- `API_KEY` - External API keys
- `SECRET_KEY` - Application secrets
- Any other configuration your app requires

### Adding Variables via Vercel CLI

```bash
vercel env add VARIABLE_NAME
```

Then select which environments the variable applies to.

## Project Structure

The configuration assumes this project structure:

```
.
├── apps/
│   └── web-preview/
│       ├── .env.example
│       ├── .env.local (generated from deploy script)
│       ├── package.json
│       └── .next/ (built output)
├── deployment/
│   └── vercel/
│       ├── vercel.json
│       ├── deploy.sh
│       └── README.md
└── .gitignore
```

## Troubleshooting

### Build Failures

If your deployment fails:

1. Check the build logs in the Vercel dashboard
2. Ensure all dependencies are listed in `package.json`
3. Verify environment variables are set correctly
4. Try building locally: `npm run build` from the `apps/web-preview` directory

### Deployment Errors

- **Token Invalid**: Make sure your `VERCEL_TOKEN` is correct and not expired
- **Permission Denied**: Verify you have access to the Vercel project
- **Build Path Issues**: Check that paths in `vercel.json` match your actual project structure

### Environment Variable Issues

- Variables set in the dashboard only take effect on new deployments
- Preview deployments may have different variables than production
- Local `.env.local` is not uploaded to Vercel (for security)

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Deploy to Vercel

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Vercel
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
        run: bash deployment/vercel/deploy.sh
```

### GitLab CI Example

```yaml
deploy_vercel:
  stage: deploy
  script:
    - bash deployment/vercel/deploy.sh
  environment: production
  only:
    - main
  variables:
    VERCEL_TOKEN: $VERCEL_TOKEN
```

## Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Next.js Deployment Guide](https://nextjs.org/docs/deployment)
- [Vercel CLI Documentation](https://vercel.com/docs/cli)
- [Environment Variables in Vercel](https://vercel.com/docs/projects/environment-variables)

## Support

For issues or questions:
1. Check the [Vercel Status Page](https://www.vercel-status.com/)
2. Review the [Vercel Support Documentation](https://vercel.com/support)
3. Check your project logs in the Vercel dashboard
