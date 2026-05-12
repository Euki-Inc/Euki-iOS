export default function SymptomsLoading() {
  return (
    <div className="w-full">
      {/* Header Skeleton */}
      <div className="bg-gradient-to-br from-pina-purple to-pina-teal h-48 animate-pulse"></div>

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Mood Section Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-32 mb-4 animate-pulse"></div>
          <div className="grid grid-cols-3 md:grid-cols-6 gap-3">
            {Array.from({ length: 6 }).map((_, i) => (
              <div
                key={i}
                className="h-24 rounded-lg bg-neutral-100 animate-pulse"
              ></div>
            ))}
          </div>
        </div>

        {/* Body Symptoms Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-40 mb-4 animate-pulse"></div>
          <div className="grid grid-cols-3 md:grid-cols-6 gap-3">
            {Array.from({ length: 6 }).map((_, i) => (
              <div
                key={i}
                className="h-24 rounded-lg bg-neutral-100 animate-pulse"
              ></div>
            ))}
          </div>
        </div>

        {/* Sleep Section Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-36 mb-4 animate-pulse"></div>
          <div className="h-8 bg-neutral-100 rounded-full animate-pulse"></div>
        </div>
      </div>
    </div>
  )
}
