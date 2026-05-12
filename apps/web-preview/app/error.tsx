'use client'

import { useEffect } from 'react'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  useEffect(() => {
    // Log error to error reporting service
    console.error('Application error:', error)
  }, [error])

  return (
    <div className="w-full min-h-screen flex items-center justify-center bg-neutral-0 px-4">
      <div className="text-center max-w-md">
        <div className="mb-6">
          <div className="text-6xl mb-4">😔</div>
          <h1 className="text-2xl font-bold text-neutral-900 mb-2">
            Oops! Something went wrong
          </h1>
          <p className="text-neutral-600">
            We encountered an unexpected error. Don't worry, your data is safe.
          </p>
        </div>

        <div className="space-y-3">
          <button
            onClick={reset}
            className="btn-primary w-full"
          >
            Try Again
          </button>
          <a
            href="/cycle"
            className="btn-secondary w-full block"
          >
            Go to Home
          </a>
        </div>

        {process.env.NODE_ENV === 'development' && error.message && (
          <div className="mt-6 p-4 bg-red-50 rounded-lg text-left">
            <p className="text-xs font-mono text-red-600 break-all">
              {error.message}
            </p>
          </div>
        )}
      </div>
    </div>
  )
}
