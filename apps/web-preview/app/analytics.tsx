'use client'

import { useEffect } from 'react'
import { usePathname, useSearchParams } from 'next/navigation'

/**
 * Analytics Component
 *
 * This component tracks page views and sends them to your analytics provider.
 * Uncomment and configure based on your chosen analytics service.
 *
 * Supported providers:
 * - Google Analytics 4 (GA4)
 * - Vercel Analytics (automatic on Vercel)
 * - Plausible Analytics
 * - Custom analytics
 */

declare global {
  interface Window {
    gtag?: (...args: any[]) => void
    plausible?: (...args: any[]) => void
  }
}

export function Analytics() {
  const pathname = usePathname()
  const searchParams = useSearchParams()

  useEffect(() => {
    if (!pathname) return

    const url = pathname + (searchParams?.toString() ? `?${searchParams.toString()}` : '')

    // Google Analytics 4
    if (typeof window.gtag !== 'undefined') {
      window.gtag('config', process.env.NEXT_PUBLIC_GA_MEASUREMENT_ID, {
        page_path: url,
      })
    }

    // Plausible Analytics
    if (typeof window.plausible !== 'undefined') {
      window.plausible('pageview', { url })
    }

    // Custom analytics (example)
    // trackPageView(url)

  }, [pathname, searchParams])

  return null
}

/**
 * Event tracking functions
 * Use these throughout your app to track user interactions
 */

export const trackEvent = (
  eventName: string,
  eventParams?: Record<string, any>
) => {
  // Google Analytics 4
  if (typeof window.gtag !== 'undefined') {
    window.gtag('event', eventName, eventParams)
  }

  // Plausible Analytics
  if (typeof window.plausible !== 'undefined') {
    window.plausible(eventName, { props: eventParams })
  }

  // Console log in development
  if (process.env.NODE_ENV === 'development') {
    console.log('📊 Analytics Event:', eventName, eventParams)
  }
}

/**
 * Common event tracking helpers
 */

export const analytics = {
  // Track button clicks
  trackClick: (buttonName: string, location?: string) => {
    trackEvent('button_click', {
      button_name: buttonName,
      location: location || 'unknown',
    })
  },

  // Track form submissions
  trackFormSubmit: (formName: string, success: boolean = true) => {
    trackEvent('form_submit', {
      form_name: formName,
      success,
    })
  },

  // Track cycle logging
  trackCycleLog: (cycleDay: number) => {
    trackEvent('cycle_logged', {
      cycle_day: cycleDay,
    })
  },

  // Track symptom logging
  trackSymptomLog: (symptomCount: number) => {
    trackEvent('symptom_logged', {
      symptom_count: symptomCount,
    })
  },

  // Track premium upgrade
  trackPremiumUpgrade: (plan: string) => {
    trackEvent('premium_upgrade', {
      plan,
    })
  },

  // Track article views
  trackArticleView: (articleId: string, category: string) => {
    trackEvent('article_view', {
      article_id: articleId,
      category,
    })
  },

  // Track PWA install
  trackPWAInstall: () => {
    trackEvent('pwa_installed')
  },

  // Track errors
  trackError: (errorType: string, errorMessage: string) => {
    trackEvent('error_occurred', {
      error_type: errorType,
      error_message: errorMessage,
    })
  },
}

/**
 * Usage Examples:
 *
 * // In your components:
 * import { analytics } from '@/app/analytics'
 *
 * // Track button click
 * <button onClick={() => analytics.trackClick('log_period', 'cycle_page')}>
 *   Log Period
 * </button>
 *
 * // Track form submit
 * const handleSubmit = () => {
 *   try {
 *     // ... submit logic
 *     analytics.trackFormSubmit('symptom_form', true)
 *   } catch (error) {
 *     analytics.trackFormSubmit('symptom_form', false)
 *     analytics.trackError('form_submission', error.message)
 *   }
 * }
 *
 * // Track cycle logging
 * analytics.trackCycleLog(14)
 *
 * // Track article view
 * analytics.trackArticleView('cycle-syncing-101', 'wellness')
 */
