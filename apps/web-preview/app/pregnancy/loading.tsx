export default function PregnancyLoading() {
  return (
    <div className="w-full">
      {/* Header Skeleton */}
      <div className="bg-gradient-to-br from-pina-teal to-blue-400 h-48 animate-pulse"></div>

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Fertility Mode Skeleton */}
        <div className="card mb-8 h-28 animate-pulse bg-gradient-to-br from-blue-100 to-teal-100"></div>

        {/* Week Selection Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-48 mb-4 animate-pulse"></div>
          <div className="grid grid-cols-3 md:grid-cols-6 gap-2">
            {Array.from({ length: 12 }).map((_, i) => (
              <div
                key={i}
                className="h-12 rounded-lg bg-neutral-100 animate-pulse"
              ></div>
            ))}
          </div>
        </div>

        {/* Week Details Skeleton */}
        <div className="card mb-8 h-96 animate-pulse bg-gradient-to-br from-blue-100 to-teal-100"></div>

        {/* Trimester Guide Skeleton */}
        <div className="space-y-4 mb-8">
          <div className="h-6 bg-neutral-200 rounded w-40 mb-4 animate-pulse"></div>
          {Array.from({ length: 3 }).map((_, i) => (
            <div
              key={i}
              className="card h-24 bg-neutral-50 animate-pulse"
            ></div>
          ))}
        </div>
      </div>
    </div>
  )
}
