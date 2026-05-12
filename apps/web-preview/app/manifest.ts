import { MetadataRoute } from 'next'

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: 'La Piña - Women\'s Health & Wellness',
    short_name: 'La Piña',
    description: 'Track your cycle, symptoms, pregnancy, and wellness with luxury care',
    start_url: '/',
    display: 'standalone',
    background_color: '#FAF9F7',
    theme_color: '#E91E63',
    orientation: 'portrait',
    categories: ['health', 'wellness', 'lifestyle'],
    icons: [
      {
        src: '/icon-192x192.png',
        sizes: '192x192',
        type: 'image/png',
        purpose: 'maskable',
      },
      {
        src: '/icon-512x512.png',
        sizes: '512x512',
        type: 'image/png',
        purpose: 'maskable',
      },
    ],
  }
}
