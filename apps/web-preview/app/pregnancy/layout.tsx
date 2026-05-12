import type { Metadata } from 'next'

const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'https://lapina.com'

export const metadata: Metadata = {
  title: 'Pregnancy Guide',
  description: 'Week-by-week pregnancy guide with fetal development information, prenatal care tips, and expert advice. Track your pregnancy journey with La Piña.',
  keywords: [
    'pregnancy tracker',
    'pregnancy guide',
    'fetal development',
    'prenatal care',
    'pregnancy tips',
    'week by week pregnancy',
    'pregnancy symptoms',
    'trimester guide',
  ],
  openGraph: {
    title: 'Pregnancy Guide | La Piña',
    description: 'Week-by-week pregnancy guide with fetal development information, prenatal care tips, and expert advice.',
    url: `${baseUrl}/pregnancy`,
    type: 'website',
    images: [
      {
        url: '/og-pregnancy.png',
        width: 1200,
        height: 630,
        alt: 'La Piña Pregnancy Guide',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Pregnancy Guide | La Piña',
    description: 'Week-by-week pregnancy guide with fetal development information and prenatal care tips.',
    images: ['/twitter-pregnancy.png'],
  },
  alternates: {
    canonical: `${baseUrl}/pregnancy`,
  },
}

export default function PregnancyLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <>{children}</>
}
