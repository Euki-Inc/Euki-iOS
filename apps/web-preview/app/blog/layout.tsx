import type { Metadata } from 'next'

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://lapina.com'

export const metadata: Metadata = {
  title: 'Blog & Wellness',
  description: 'Expert articles on women\'s health, wellness tips, luxury self-care, cycle syncing, intimacy, and mental health. Premium content curated for your journey.',
  keywords: [
    'women\'s health blog',
    'wellness articles',
    'luxury self-care',
    'cycle syncing',
    'intimacy tips',
    'mental health',
    'health resources',
    'expert advice',
  ],
  openGraph: {
    title: 'Blog & Wellness | La Piña',
    description: 'Expert articles on women\'s health, wellness tips, luxury self-care, and cycle syncing. Premium content curated for your journey.',
    url: `${baseUrl}/blog`,
    type: 'website',
    images: [
      {
        url: '/og-blog.png',
        width: 1200,
        height: 630,
        alt: 'La Piña Blog & Wellness',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Blog & Wellness | La Piña',
    description: 'Expert articles on women\'s health, wellness tips, and luxury self-care.',
    images: ['/twitter-blog.png'],
  },
  alternates: {
    canonical: `${baseUrl}/blog`,
  },
}

export default function BlogLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <>{children}</>
}
