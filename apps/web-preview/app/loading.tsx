export default function Loading() {
  return (
    <div className="w-full min-h-screen flex items-center justify-center bg-neutral-0">
      <div className="text-center">
        <div className="inline-block">
          {/* La Piña Logo Spinner */}
          <div className="relative w-16 h-16 mb-4">
            <div className="absolute inset-0 rounded-full border-4 border-neutral-200"></div>
            <div className="absolute inset-0 rounded-full border-4 border-pina-pink border-t-transparent animate-spin"></div>
          </div>
        </div>
        <p className="text-sm text-neutral-600 font-medium">Loading La Piña...</p>
      </div>
    </div>
  )
}
