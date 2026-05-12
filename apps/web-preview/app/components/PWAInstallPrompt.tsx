'use client'

import { useEffect, useState } from 'react'

/**
 * PWA Install Prompt Component
 *
 * Displays a custom install prompt for Progressive Web App functionality.
 * Shows a banner when the app can be installed on the user's device.
 */

interface BeforeInstallPromptEvent extends Event {
  prompt: () => Promise<void>
  userChoice: Promise<{ outcome: 'accepted' | 'dismissed' }>
}

export function PWAInstallPrompt() {
  const [deferredPrompt, setDeferredPrompt] = useState<BeforeInstallPromptEvent | null>(null)
  const [showPrompt, setShowPrompt] = useState(false)

  useEffect(() => {
    const handler = (e: Event) => {
      // Prevent the mini-infobar from appearing on mobile
      e.preventDefault()

      // Stash the event so it can be triggered later
      setDeferredPrompt(e as BeforeInstallPromptEvent)

      // Show custom install prompt after a delay
      setTimeout(() => {
        setShowPrompt(true)
      }, 3000) // Wait 3 seconds before showing
    }

    window.addEventListener('beforeinstallprompt', handler)

    // Check if app is already installed
    if (window.matchMedia('(display-mode: standalone)').matches) {
      console.log('PWA is already installed')
    }

    return () => {
      window.removeEventListener('beforeinstallprompt', handler)
    }
  }, [])

  const handleInstallClick = async () => {
    if (!deferredPrompt) return

    // Show the install prompt
    deferredPrompt.prompt()

    // Wait for the user to respond to the prompt
    const { outcome } = await deferredPrompt.userChoice

    if (outcome === 'accepted') {
      console.log('User accepted the install prompt')

      // Track installation with analytics
      if (typeof window !== 'undefined' && window.gtag) {
        window.gtag('event', 'pwa_installed')
      }
    } else {
      console.log('User dismissed the install prompt')
    }

    // Clear the deferredPrompt
    setDeferredPrompt(null)
    setShowPrompt(false)
  }

  const handleDismiss = () => {
    setShowPrompt(false)

    // Don't show again for 7 days
    localStorage.setItem('pwa-dismissed', Date.now().toString())
  }

  // Check if user dismissed recently
  useEffect(() => {
    const dismissed = localStorage.getItem('pwa-dismissed')
    if (dismissed) {
      const dismissedTime = parseInt(dismissed)
      const sevenDays = 7 * 24 * 60 * 60 * 1000

      if (Date.now() - dismissedTime < sevenDays) {
        setShowPrompt(false)
      }
    }
  }, [])

  if (!showPrompt || !deferredPrompt) {
    return null
  }

  return (
    <div className="fixed bottom-20 md:bottom-6 left-4 right-4 md:left-auto md:right-6 md:max-w-sm z-50 animate-slide-up">
      <div className="card bg-gradient-to-br from-pina-pink to-pina-purple text-white shadow-large">
        <button
          onClick={handleDismiss}
          className="absolute top-2 right-2 text-white opacity-75 hover:opacity-100 transition-opacity"
          aria-label="Dismiss"
        >
          <svg
            className="w-5 h-5"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>

        <div className="pr-6">
          <h3 className="font-bold text-lg mb-2">Install La Piña</h3>
          <p className="text-sm opacity-90 mb-4">
            Install our app for a better experience. Access your health tracker anytime, even offline.
          </p>

          <div className="flex gap-2">
            <button
              onClick={handleInstallClick}
              className="bg-white text-pina-pink px-4 py-2 rounded-lg font-semibold text-sm hover:bg-neutral-50 transition-colors flex-1"
            >
              Install
            </button>
            <button
              onClick={handleDismiss}
              className="bg-white bg-opacity-20 text-white px-4 py-2 rounded-lg font-semibold text-sm hover:bg-opacity-30 transition-colors"
            >
              Not Now
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

/**
 * iOS Install Instructions Component
 *
 * Shows instructions for iOS users since iOS doesn't support beforeinstallprompt
 */

export function IOSInstallInstructions() {
  const [showIOS, setShowIOS] = useState(false)

  useEffect(() => {
    // Check if device is iOS and not in standalone mode
    const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent)
    const isInStandaloneMode = window.matchMedia('(display-mode: standalone)').matches

    if (isIOS && !isInStandaloneMode) {
      // Check if user dismissed recently
      const dismissed = localStorage.getItem('ios-install-dismissed')
      if (!dismissed) {
        setTimeout(() => setShowIOS(true), 5000)
      }
    }
  }, [])

  const handleDismiss = () => {
    setShowIOS(false)
    localStorage.setItem('ios-install-dismissed', Date.now().toString())
  }

  if (!showIOS) return null

  return (
    <div className="fixed bottom-20 md:bottom-6 left-4 right-4 md:left-auto md:right-6 md:max-w-sm z-50">
      <div className="card bg-gradient-to-br from-pina-teal to-blue-500 text-white shadow-large">
        <button
          onClick={handleDismiss}
          className="absolute top-2 right-2 text-white opacity-75 hover:opacity-100"
          aria-label="Dismiss"
        >
          ×
        </button>

        <div className="pr-6">
          <h3 className="font-bold text-lg mb-2">Add to Home Screen</h3>
          <p className="text-sm opacity-90 mb-3">
            Install La Piña on your iPhone:
          </p>
          <ol className="text-sm space-y-2 opacity-90">
            <li className="flex items-start gap-2">
              <span className="font-bold">1.</span>
              <span>Tap the Share button in Safari</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="font-bold">2.</span>
              <span>Scroll down and tap "Add to Home Screen"</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="font-bold">3.</span>
              <span>Tap "Add" in the top right</span>
            </li>
          </ol>

          <button
            onClick={handleDismiss}
            className="mt-4 bg-white bg-opacity-20 text-white px-4 py-2 rounded-lg font-semibold text-sm hover:bg-opacity-30 transition-colors w-full"
          >
            Got it
          </button>
        </div>
      </div>
    </div>
  )
}
