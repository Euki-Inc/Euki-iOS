import type { Metadata } from 'next'
import './globals.css'
import { TabNav } from '@/components/TabNav'

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://lapina.com'

export const metadata: Metadata = {
  metadataBase: new URL(baseUrl),
  title: {
    default: 'La Piña - Women\'s Health & Wellness Tracker',
    template: '%s | La Piña',
  },
  description: 'Track your menstrual cycle, symptoms, pregnancy, and wellness with luxury care. Personalized insights, AI-powered recommendations, and expert content for women\'s health.',
  keywords: [
    'menstrual cycle tracker',
    'period tracker',
    'women\'s health',
    'pregnancy tracker',
    'symptom tracker',
    'wellness app',
    'fertility tracking',
    'cycle syncing',
    'women\'s wellness',
  ],
  authors: [{ name: 'La Piña Team' }],
  creator: 'La Piña',
  publisher: 'La Piña',
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: baseUrl,
    siteName: 'La Piña',
    title: 'La Piña - Women\'s Health & Wellness Tracker',
    description: 'Track your menstrual cycle, symptoms, pregnancy, and wellness with luxury care. Personalized insights and AI-powered recommendations.',
    images: [
      {
        url: '/og-image.png',
        width: 1200,
        height: 630,
        alt: 'La Piña - Women\'s Health & Wellness',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'La Piña - Women\'s Health & Wellness Tracker',
    description: 'Track your menstrual cycle, symptoms, pregnancy, and wellness with luxury care.',
    images: ['/twitter-image.png'],
    creator: '@lapina',
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  icons: {
    icon: [
      { url: '/favicon.ico' },
      { url: '/icon-192x192.png', sizes: '192x192', type: 'image/png' },
      { url: '/icon-512x512.png', sizes: '512x512', type: 'image/png' },
    ],
    apple: [
      { url: '/apple-touch-icon.png' },
    ],
  },
  manifest: '/manifest.webmanifest',
  viewport: {
    width: 'device-width',
    initialScale: 1,
    maximumScale: 1,
  },
  verification: {
    google: 'google-site-verification-code',
    // yandex: 'yandex-verification-code',
    // yahoo: 'yahoo-verification-code',
  },
  alternates: {
    canonical: baseUrl,
  },
  category: 'health',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <head>
        {/* Optimized font loading with preconnect and dns-prefetch */}
        <link rel="dns-prefetch" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link
          href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet"
          // Font display swap for better performance
          media="print"
          // @ts-ignore
          onLoad="this.media='all'"
        />
        <noscript>
          <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet"
          />
        </noscript>
      </head>
      <body className="bg-neutral-0 text-neutral-900">
        <div className="min-h-screen w-full flex flex-col pb-24 md:pb-0">
          <main className="flex-1 w-full">
            {children}
          </main>
          <TabNav />
        </div>
      </body>
    </html>
  )
}
