#!/bin/bash

# Vercel Deployment Script for LA PINA Women's Health App
# This script automates the deployment process to Vercel

set -e

echo "================================"
echo "LA PINA Vercel Deployment Script"
echo "================================"
echo ""

# Step 1: Copy environment variables
echo "Step 1: Setting up environment variables..."
if [ ! -f "apps/web-preview/.env.local" ]; then
    if [ -f "apps/web-preview/.env.example" ]; then
        cp apps/web-preview/.env.example apps/web-preview/.env.local
        echo "✓ Created .env.local from .env.example"
    else
        echo "⚠ Warning: .env.example not found. Creating minimal .env.local..."
        touch apps/web-preview/.env.local
    fi
else
    echo "✓ .env.local already exists"
fi
echo ""

# Step 2: Install dependencies
echo "Step 2: Installing dependencies..."
npm install
echo "✓ Dependencies installed successfully"
echo ""

# Step 3: Deploy to Vercel
echo "Step 3: Deploying to Vercel..."
if [ -n "$VERCEL_TOKEN" ]; then
    echo "VERCEL_TOKEN is set. Proceeding with automated deployment..."
    vercel deploy --prod
    echo ""
    echo "✓ Deployment to Vercel completed successfully!"
    echo ""
else
    echo "⚠ VERCEL_TOKEN environment variable is not set."
    echo ""
    echo "Manual Deployment Instructions:"
    echo "================================"
    echo ""
    echo "1. Install Vercel CLI globally (if not already installed):"
    echo "   npm install -g vercel"
    echo ""
    echo "2. Link your project to Vercel:"
    echo "   vercel link"
    echo ""
    echo "3. Deploy to production:"
    echo "   vercel deploy --prod"
    echo ""
    echo "4. Or deploy with specific token:"
    echo "   VERCEL_TOKEN=your_token_here vercel deploy --prod"
    echo ""
    echo "Alternatively, use the Vercel Dashboard:"
    echo "- Go to https://vercel.com/dashboard"
    echo "- Import your Git repository"
    echo "- Configure build settings if needed"
    echo "- Click 'Deploy'"
    echo ""
fi
