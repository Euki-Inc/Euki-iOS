import type { Metadata } from 'next'

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://lapina.com'

export const metadata: Metadata = {
  title: 'Symptom Tracker',
  description: 'Track your daily symptoms, mood, sleep quality, and body changes. Monitor PMS symptoms, energy levels, and discover patterns in your menstrual health.',
  keywords: [
    'symptom tracker',
    'mood tracker',
    'PMS symptoms',
    'period symptoms',
    'sleep tracker',
    'health journal',
    'wellness tracker',
  ],
  openGraph: {
    title: 'Symptom Tracker | La Piña',
    description: 'Track your daily symptoms, mood, and wellness. Monitor PMS symptoms and discover patterns in your menstrual health.',
    url: `${baseUrl}/symptoms`,
    type: 'website',
    images: [
      {
        url: '/og-symptoms.png',
        width: 1200,
        height: 630,
        alt: 'La Piña Symptom Tracker',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Symptom Tracker | La Piña',
    description: 'Track your daily symptoms, mood, and wellness. Monitor PMS symptoms and discover patterns.',
    images: ['/twitter-symptoms.png'],
  },
  alternates: {
    canonical: `${baseUrl}/symptoms`,
  },
}

export default function SymptomsLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <>{children}</>
}
