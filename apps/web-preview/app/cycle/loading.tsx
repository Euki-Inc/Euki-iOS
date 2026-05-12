export default function CycleLoading() {
  return (
    <div className="w-full">
      {/* Header Skeleton */}
      <div className="bg-gradient-to-br from-pina-pink to-pina-purple h-48 animate-pulse"></div>

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Current Cycle Info Skeleton */}
        <div className="card mb-8 h-40 animate-pulse bg-neutral-100"></div>

        {/* Calendar Skeleton */}
        <div className="card mb-8">
          <div className="h-8 bg-neutral-200 rounded w-48 mb-6 animate-pulse"></div>
          <div className="grid grid-cols-7 gap-2">
            {Array.from({ length: 35 }).map((_, i) => (
              <div
                key={i}
                className="aspect-square rounded-lg bg-neutral-100 animate-pulse"
              ></div>
            ))}
          </div>
        </div>

        {/* Chart Skeleton */}
        <div className="card mb-8">
          <div className="h-6 bg-neutral-200 rounded w-40 mb-4 animate-pulse"></div>
          <div className="h-64 bg-neutral-100 rounded animate-pulse"></div>
        </div>
      </div>
    </div>
  )
}
