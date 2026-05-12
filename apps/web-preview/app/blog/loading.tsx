export default function BlogLoading() {
  return (
    <div className="w-full">
      {/* Header Skeleton */}
      <div className="bg-gradient-to-br from-pina-pink to-pina-yellow h-48 animate-pulse"></div>

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Premium Upsell Skeleton */}
        <div className="card mb-8 h-48 animate-pulse bg-gradient-to-br from-purple-50 to-pink-50"></div>

        {/* Category Filter Skeleton */}
        <div className="mb-8 flex gap-2">
          {Array.from({ length: 6 }).map((_, i) => (
            <div
              key={i}
              className="h-10 w-28 rounded-full bg-neutral-100 animate-pulse"
            ></div>
          ))}
        </div>

        {/* Blog Posts Skeleton */}
        <div className="space-y-4 mb-8">
          {Array.from({ length: 5 }).map((_, i) => (
            <div
              key={i}
              className="card"
            >
              <div className="h-4 bg-neutral-200 rounded w-24 mb-3 animate-pulse"></div>
              <div className="h-6 bg-neutral-200 rounded w-3/4 mb-3 animate-pulse"></div>
              <div className="h-16 bg-neutral-100 rounded animate-pulse"></div>
            </div>
          ))}
        </div>

        {/* Featured Collection Skeleton */}
        <div className="mb-8">
          <div className="h-6 bg-neutral-200 rounded w-48 mb-4 animate-pulse"></div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="h-48 rounded-lg bg-gradient-to-br from-orange-100 to-red-100 animate-pulse"></div>
            <div className="h-48 rounded-lg bg-gradient-to-br from-blue-100 to-teal-100 animate-pulse"></div>
          </div>
        </div>
      </div>
    </div>
  )
}
