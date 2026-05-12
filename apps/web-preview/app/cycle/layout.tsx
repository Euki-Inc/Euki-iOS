import type { Metadata } from 'next'

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://lapina.com'

export const metadata: Metadata = {
  title: 'Cycle Tracker',
  description: 'Track your menstrual cycle, period dates, fertile window, and cycle patterns. Get accurate predictions and personalized insights for your reproductive health.',
  openGraph: {
    title: 'Cycle Tracker | La Piña',
    description: 'Track your menstrual cycle with precision. Monitor periods, fertile windows, and get AI-powered predictions.',
    url: `${baseUrl}/cycle`,
    images: [
      {
        url: '/og-cycle.png',
        width: 1200,
        height: 630,
        alt: 'La Piña Cycle Tracker',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Cycle Tracker | La Piña',
    description: 'Track your menstrual cycle with precision. Monitor periods, fertile windows, and get AI-powered predictions.',
    images: ['/twitter-cycle.png'],
  },
  alternates: {
    canonical: `${baseUrl}/cycle`,
  },
}

export default function CycleLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <>{children}</>
}
