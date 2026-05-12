interface PaywallCardProps {
  features: string[]
}

export function PaywallCard({ features }: PaywallCardProps) {
  return (
    <div className="card mb-8 gradient-primary text-white p-6 md:p-8">
      <div className="flex justify-between items-start mb-4">
        <div>
          <h3 className="text-2xl font-bold">Unlock Premium</h3>
          <p className="text-white opacity-90 mt-1">Get unlimited access to all features</p>
        </div>
        <span className="badge bg-pina-yellow bg-opacity-30 text-white text-xs font-bold">
          ✨ PREMIUM
        </span>
      </div>

      <ul className="space-y-2 mb-6 py-4 border-t border-white border-opacity-20 border-b">
        {features.slice(0, 4).map((feature) => (
          <li key={feature} className="flex items-center gap-2 text-sm">
            <span className="text-lg">✓</span>
            <span>{feature}</span>
          </li>
        ))}
      </ul>

      <div className="grid grid-cols-2 gap-3">
        <button className="bg-white text-pina-pink font-bold py-3 rounded-lg hover:opacity-90 transition-all">
          Start Free Trial
        </button>
        <button className="border-2 border-white text-white font-bold py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-all">
          View Plans
        </button>
      </div>

      <p className="text-xs opacity-75 mt-4 text-center">
        Try 7 days free. Cancel anytime. No credit card required.
      </p>
    </div>
  )
}
