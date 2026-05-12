import type { Metadata } from 'next'

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://lapina.com'

export const metadata: Metadata = {
  title: 'Health Insights',
  description: 'AI-powered health insights and personalized recommendations based on your cycle patterns, symptoms, and wellness data. Understand your body better.',
  keywords: [
    'health insights',
    'AI health analysis',
    'cycle patterns',
    'personalized recommendations',
    'health analytics',
    'wellness insights',
    'period predictions',
    'cycle syncing',
  ],
  openGraph: {
    title: 'Health Insights | La Piña',
    description: 'AI-powered health insights and personalized recommendations based on your cycle patterns and wellness data.',
    url: `${baseUrl}/insights`,
    type: 'website',
    images: [
      {
        url: '/og-insights.png',
        width: 1200,
        height: 630,
        alt: 'La Piña Health Insights',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Health Insights | La Piña',
    description: 'AI-powered health insights and personalized recommendations based on your cycle patterns.',
    images: ['/twitter-insights.png'],
  },
  alternates: {
    canonical: `${baseUrl}/insights`,
  },
}

export default function InsightsLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <>{children}</>
}
