export default function InsightsLoading() {
  return (
    <div className="w-full">
      {/* Header Skeleton */}
      <div className="bg-gradient-to-br from-pina-yellow to-pina-pink h-48 animate-pulse"></div>

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Key Metrics Skeleton */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          {Array.from({ length: 4 }).map((_, i) => (
            <div
              key={i}
              className="card h-24 animate-pulse bg-neutral-100"
            ></div>
          ))}
        </div>

        {/* Alerts Skeleton */}
        <div className="space-y-4 mb-8">
          <div className="h-6 bg-neutral-200 rounded w-56 mb-4 animate-pulse"></div>
          {Array.from({ length: 3 }).map((_, i) => (
            <div
              key={i}
              className="card h-20 bg-neutral-50 animate-pulse"
            ></div>
          ))}
        </div>

        {/* Pattern Analysis Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-48 mb-6 animate-pulse"></div>
          <div className="h-64 bg-neutral-100 rounded animate-pulse"></div>
        </div>

        {/* Symptom Trends Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-40 mb-4 animate-pulse"></div>
          <div className="space-y-4">
            {Array.from({ length: 4 }).map((_, i) => (
              <div key={i}>
                <div className="h-4 bg-neutral-200 rounded w-32 mb-2 animate-pulse"></div>
                <div className="h-2 bg-neutral-100 rounded-full animate-pulse"></div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
