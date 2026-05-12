import Script from 'next/script'

/**
 * Google Analytics 4 Component
 *
 * Add this to your root layout to enable Google Analytics tracking.
 * Set NEXT_PUBLIC_GA_MEASUREMENT_ID in your environment variables.
 *
 * Usage:
 * import { GoogleAnalytics } from '@/app/components/GoogleAnalytics'
 *
 * In layout.tsx:
 * <GoogleAnalytics />
 */

export function GoogleAnalytics() {
  const measurementId = process.env.NEXT_PUBLIC_GA_MEASUREMENT_ID

  if (!measurementId) {
    // Don't render in development or if GA is not configured
    return null
  }

  return (
    <>
      <Script
        strategy="afterInteractive"
        src={`https://www.googletagmanager.com/gtag/js?id=${measurementId}`}
      />
      <Script
        id="google-analytics"
        strategy="afterInteractive"
        dangerouslySetInnerHTML={{
          __html: `
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', '${measurementId}', {
              page_path: window.location.pathname,
              send_page_view: true
            });
          `,
        }}
      />
    </>
  )
}

/**
 * Plausible Analytics (Alternative to GA)
 *
 * A privacy-friendly, lightweight alternative to Google Analytics.
 * No cookies, GDPR compliant by default.
 *
 * Usage:
 * export function PlausibleAnalytics() {
 *   if (!process.env.NEXT_PUBLIC_PLAUSIBLE_DOMAIN) return null
 *
 *   return (
 *     <Script
 *       defer
 *       data-domain={process.env.NEXT_PUBLIC_PLAUSIBLE_DOMAIN}
 *       src="https://plausible.io/js/script.js"
 *     />
 *   )
 * }
 */
