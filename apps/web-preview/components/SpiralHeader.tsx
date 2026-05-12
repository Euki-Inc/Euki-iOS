'use client'

import { useEffect, useState } from 'react'

interface SpiralHeaderProps {
  title: string
  subtitle: string
}

export function SpiralHeader({ title, subtitle }: SpiralHeaderProps) {
  const [isSpinning, setIsSpinning] = useState(true)

  useEffect(() => {
    setIsSpinning(true)
  }, [title])

  return (
    <div className="w-full bg-gradient-to-br from-pina-pink via-pina-purple to-pina-teal py-8 md:py-12 px-4 text-white">
      <div className="max-w-4xl mx-auto flex items-center gap-4">
        {/* Pineapple Spiral */}
        <div className="flex-shrink-0">
          <div
            className={`w-16 h-16 md:w-20 md:h-20 rounded-full bg-white bg-opacity-20 flex items-center justify-center backdrop-blur-sm ${
              isSpinning ? 'animate-spiral' : ''
            }`}
          >
            <span className="text-4xl md:text-5xl">🍍</span>
          </div>
        </div>

        {/* Header Text */}
        <div className="flex-1">
          <h1 className="text-3xl md:text-4xl font-bold mb-1">{title}</h1>
          <p className="text-white opacity-90 text-sm md:text-base">{subtitle}</p>
        </div>
      </div>
    </div>
  )
}
