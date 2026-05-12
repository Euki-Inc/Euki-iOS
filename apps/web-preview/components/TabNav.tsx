'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { TAB_CONFIG } from '@/lib/theme'

export function TabNav() {
  const pathname = usePathname()

  return (
    <nav className="fixed bottom-0 left-0 right-0 md:hidden bg-white border-t border-neutral-100 shadow-heavy z-40">
      <div className="flex justify-around items-center h-20">
        {TAB_CONFIG.map((tab) => {
          const isActive = pathname === tab.route || (tab.route === '/cycle' && pathname === '/')
          return (
            <Link
              key={tab.id}
              href={tab.route}
              className={`flex flex-col items-center justify-center gap-1 py-2 px-4 transition-all duration-200 flex-1 h-full ${
                isActive
                  ? 'opacity-100'
                  : 'opacity-60 hover:opacity-80'
              }`}
              style={isActive ? { color: tab.color } : { color: '#CCCCCC' }}
            >
              <span className={`text-2xl transition-transform ${isActive ? 'scale-110 animate-bubble' : 'scale-100'}`}>
                {tab.icon}
              </span>
              <span className="text-xs font-semibold truncate">{tab.label}</span>
            </Link>
          )
        })}
      </div>
    </nav>
  )
}
