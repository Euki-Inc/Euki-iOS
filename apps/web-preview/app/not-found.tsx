import Link from 'next/link'

export default function NotFound() {
  return (
    <div className="w-full min-h-screen flex items-center justify-center bg-neutral-0 px-4">
      <div className="text-center max-w-md">
        <div className="mb-6">
          <div className="text-6xl mb-4">🍍</div>
          <h1 className="text-2xl font-bold text-neutral-900 mb-2">
            Page Not Found
          </h1>
          <p className="text-neutral-600">
            This page doesn't exist. Let's get you back on track.
          </p>
        </div>

        <div className="space-y-3">
          <Link
            href="/cycle"
            className="btn-primary w-full block"
          >
            Go to Home
          </Link>
          <Link
            href="/blog"
            className="btn-secondary w-full block"
          >
            Browse Blog
          </Link>
        </div>

        <div className="mt-8 pt-8 border-t border-neutral-200">
          <p className="text-sm text-neutral-600">Popular Pages</p>
          <div className="mt-4 flex flex-wrap gap-2 justify-center">
            <Link href="/cycle" className="badge bg-pina-pink bg-opacity-10 text-pina-pink hover:bg-opacity-20 transition-colors">
              Cycle
            </Link>
            <Link href="/symptoms" className="badge bg-pina-purple bg-opacity-10 text-pina-purple hover:bg-opacity-20 transition-colors">
              Symptoms
            </Link>
            <Link href="/pregnancy" className="badge bg-pina-teal bg-opacity-10 text-pina-teal hover:bg-opacity-20 transition-colors">
              Pregnancy
            </Link>
            <Link href="/insights" className="badge bg-pina-yellow bg-opacity-10 text-pina-yellow hover:bg-opacity-20 transition-colors">
              Insights
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
