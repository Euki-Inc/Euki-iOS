'use client'

import { useState } from 'react'
import { SpiralHeader } from '@/components/SpiralHeader'
import { mockPregnancyWeeks } from '@/lib/data'

export default function PregnancyPage() {
  const [selectedWeek, setSelectedWeek] = useState(mockPregnancyWeeks[1])

  return (
    <div className="w-full">
      <SpiralHeader
        title="Pregnancy Guide"
        subtitle="Track fetal development week by week"
      />

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Fertility Mode Toggle */}
        <div className="card mb-8 gradient-ocean text-white">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="text-lg font-bold">Fertility Mode</h3>
              <p className="text-sm opacity-90">Track your path to pregnancy</p>
            </div>
            <button className="bg-white bg-opacity-20 hover:bg-opacity-30 text-white rounded-lg px-6 py-2 font-semibold transition-all">
              Enable
            </button>
          </div>
        </div>

        {/* Week Selection */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Pregnancy Timeline</h3>
          <div className="grid grid-cols-3 md:grid-cols-6 gap-2">
            {mockPregnancyWeeks.map((week) => (
              <button
                key={week.week}
                onClick={() => setSelectedWeek(week)}
                className={`p-3 rounded-lg transition-all text-center ${
                  selectedWeek.week === week.week
                    ? 'bg-pina-teal text-white border-2 border-pina-teal'
                    : 'bg-neutral-50 text-neutral-900 border-2 border-transparent hover:border-pina-teal'
                }`}
              >
                <span className="text-xs font-bold">W{week.week}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Selected Week Details */}
        <div className="card mb-8 gradient-ocean text-white">
          <h2 className="text-2xl font-bold mb-2">{selectedWeek.title}</h2>
          <p className="opacity-90 mb-6">{selectedWeek.description}</p>

          <div className="bg-white bg-opacity-10 rounded-lg p-4 mb-6">
            <h4 className="font-semibold mb-2">Fetal Development</h4>
            <p className="text-sm opacity-90">{selectedWeek.fetal_development}</p>
          </div>

          <div>
            <h4 className="font-semibold mb-3">Tips for This Week</h4>
            <ul className="space-y-2">
              {selectedWeek.tips.map((tip) => (
                <li key={tip} className="flex items-start gap-2">
                  <span className="text-lg">✓</span>
                  <span className="text-sm">{tip}</span>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Trimester Guide */}
        <div className="space-y-4 mb-8">
          <h3 className="text-xl font-bold text-neutral-900">Trimester Overview</h3>

          <div className="card border-l-4 border-pina-pink">
            <h4 className="font-semibold text-neutral-900 mb-2">First Trimester (Weeks 1-13)</h4>
            <p className="text-sm text-neutral-600">
              Rapid cell division and development. Morning sickness may occur. Focus on prenatal vitamins and healthy nutrition.
            </p>
          </div>

          <div className="card border-l-4 border-pina-purple">
            <h4 className="font-semibold text-neutral-900 mb-2">Second Trimester (Weeks 14-27)</h4>
            <p className="text-sm text-neutral-600">
              Baby is growing fast. You may feel movement. Energy levels typically improve. Great time for maternity photos.
            </p>
          </div>

          <div className="card border-l-4 border-pina-teal">
            <h4 className="font-semibold text-neutral-900 mb-2">Third Trimester (Weeks 28-40)</h4>
            <p className="text-sm text-neutral-600">
              Baby is getting ready for birth. Practice relaxation techniques. Plan for labor and delivery.
            </p>
          </div>
        </div>

        {/* Symptoms & Care */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Common Pregnancy Symptoms</h3>
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
            {[
              { symptom: 'Morning Sickness', icon: '🤢' },
              { symptom: 'Fatigue', icon: '😴' },
              { symptom: 'Cravings', icon: '🍕' },
              { symptom: 'Mood Changes', icon: '🎭' },
              { symptom: 'Swelling', icon: '💧' },
              { symptom: 'Heartburn', icon: '🔥' },
            ].map((item) => (
              <div key={item.symptom} className="bg-neutral-50 rounded-lg p-4 text-center">
                <span className="text-3xl block mb-2">{item.icon}</span>
                <p className="text-sm font-medium text-neutral-900">{item.symptom}</p>
              </div>
            ))}
          </div>
        </div>

        {/* Prenatal Care */}
        <div className="card mb-8 bg-gradient-to-br from-yellow-50 to-orange-50">
          <h3 className="text-lg font-bold mb-4 text-neutral-900 flex items-center gap-2">
            <span className="text-2xl">🏥</span>
            Prenatal Care Checklist
          </h3>
          <div className="space-y-2">
            {[
              'Schedule regular check-ups every 2-4 weeks',
              'Take prenatal vitamins with folic acid',
              'Eat a balanced, nutritious diet',
              'Stay hydrated (8-10 glasses of water daily)',
              'Exercise moderately (30 minutes, 5 days/week)',
              'Get adequate sleep (7-9 hours)',
              'Manage stress through meditation or yoga',
              'Avoid smoking, alcohol, and harmful substances',
            ].map((item) => (
              <label key={item} className="flex items-center gap-3 p-2 rounded hover:bg-white transition-all cursor-pointer">
                <input type="checkbox" className="w-5 h-5 rounded border-pina-teal accent-pina-teal cursor-pointer" />
                <span className="text-sm text-neutral-700">{item}</span>
              </label>
            ))}
          </div>
        </div>

        <button className="btn-primary w-full">
          Talk to AI Companion
        </button>
      </div>
    </div>
  )
}
