'use client'

import { useState } from 'react'
import { SpiralHeader } from '@/components/SpiralHeader'
import { MockChart } from '@/components/MockChart'
import { mockInsights } from '@/lib/data'

export default function InsightsPage() {
  const [expandedAlert, setExpandedAlert] = useState<string | null>(null)

  return (
    <div className="w-full">
      <SpiralHeader title="Health Insights" subtitle="Understand your body patterns" />

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Key Metrics */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          <div className="card">
            <p className="text-xs text-neutral-600 uppercase tracking-wide">Cycle Length</p>
            <p className="text-3xl font-bold text-pina-pink mt-2">28d</p>
            <p className="text-xs text-neutral-600 mt-1">avg</p>
          </div>
          <div className="card">
            <p className="text-xs text-neutral-600 uppercase tracking-wide">Regularity</p>
            <p className="text-3xl font-bold text-pina-teal mt-2">97%</p>
            <p className="text-xs text-neutral-600 mt-1">regular</p>
          </div>
          <div className="card">
            <p className="text-xs text-neutral-600 uppercase tracking-wide">Period Length</p>
            <p className="text-3xl font-bold text-pina-purple mt-2">5d</p>
            <p className="text-xs text-neutral-600 mt-1">avg</p>
          </div>
          <div className="card">
            <p className="text-xs text-neutral-600 uppercase tracking-wide">Next Period</p>
            <p className="text-3xl font-bold text-pina-yellow mt-2">15d</p>
            <p className="text-xs text-neutral-600 mt-1">away</p>
          </div>
        </div>

        {/* Alerts & Recommendations */}
        <div className="space-y-4 mb-8">
          <h3 className="text-xl font-bold text-neutral-900">Alerts & Recommendations</h3>
          {mockInsights.map((alert) => (
            <div
              key={alert.type}
              className={`card cursor-pointer transition-all ${
                expandedAlert === alert.type ? 'ring-2 ring-pina-pink' : ''
              } ${alert.severity === 'low' ? 'border-l-4 border-yellow-400' : 'border-l-4 border-blue-400'}`}
              onClick={() => setExpandedAlert(expandedAlert === alert.type ? null : alert.type)}
            >
              <div className="flex items-start gap-3">
                <span className="text-2xl flex-shrink-0">{alert.icon}</span>
                <div className="flex-1">
                  <h4 className="font-semibold text-neutral-900">{alert.title}</h4>
                  {expandedAlert === alert.type && (
                    <p className="text-sm text-neutral-600 mt-2">{alert.message}</p>
                  )}
                </div>
                <span
                  className={`badge text-xs font-semibold ${
                    alert.severity === 'low'
                      ? 'bg-yellow-100 text-yellow-700'
                      : 'bg-blue-100 text-blue-700'
                  }`}
                >
                  {alert.severity}
                </span>
              </div>
            </div>
          ))}
        </div>

        {/* Pattern Analysis */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-6 text-neutral-900">Cycle Pattern Analysis</h3>
          <MockChart />
          <div className="mt-6 pt-6 border-t border-neutral-200">
            <p className="text-sm text-neutral-600">
              Your cycles are very regular with minimal variation. This makes it easier to predict
              your fertile window and plan accordingly. Keep tracking for best results.
            </p>
          </div>
        </div>

        {/* Symptom Trends */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Common Symptoms</h3>
          <div className="space-y-3">
            {[
              { symptom: 'Bloating', frequency: 85, color: 'from-pina-pink' },
              { symptom: 'Cramps', frequency: 72, color: 'from-pina-purple' },
              { symptom: 'Fatigue', frequency: 68, color: 'from-pina-teal' },
              { symptom: 'Headache', frequency: 45, color: 'from-pina-yellow' },
            ].map((item) => (
              <div key={item.symptom}>
                <div className="flex justify-between items-center mb-1">
                  <p className="text-sm font-medium text-neutral-900">{item.symptom}</p>
                  <p className="text-xs text-neutral-600">{item.frequency}%</p>
                </div>
                <div className="w-full bg-neutral-100 rounded-full h-2 overflow-hidden">
                  <div
                    className={`h-full bg-gradient-to-r ${item.color} to-transparent`}
                    style={{ width: `${item.frequency}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Health Recommendations */}
        <div className="card mb-8 bg-gradient-to-br from-blue-50 to-purple-50">
          <h3 className="text-lg font-bold mb-4 text-neutral-900 flex items-center gap-2">
            <span className="text-2xl">💡</span>
            Personalized Recommendations
          </h3>
          <ul className="space-y-3">
            <li className="flex items-start gap-3">
              <span className="text-lg flex-shrink-0">🥗</span>
              <div>
                <p className="text-sm font-medium text-neutral-900">Nutrition</p>
                <p className="text-xs text-neutral-600">
                  Increase iron intake before your period to combat fatigue
                </p>
              </div>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-lg flex-shrink-0">🧘</span>
              <div>
                <p className="text-sm font-medium text-neutral-900">Wellness</p>
                <p className="text-xs text-neutral-600">
                  Try yoga or stretching during your follicular phase
                </p>
              </div>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-lg flex-shrink-0">😴</span>
              <div>
                <p className="text-sm font-medium text-neutral-900">Sleep</p>
                <p className="text-xs text-neutral-600">
                  Aim for 8-9 hours during your luteal phase
                </p>
              </div>
            </li>
            <li className="flex items-start gap-3">
              <span className="text-lg flex-shrink-0">💪</span>
              <div>
                <p className="text-sm font-medium text-neutral-900">Exercise</p>
                <p className="text-xs text-neutral-600">
                  Sync your workouts with your cycle for optimal performance
                </p>
              </div>
            </li>
          </ul>
        </div>

        {/* Educational Content */}
        <div className="space-y-4 mb-8">
          <h3 className="text-xl font-bold text-neutral-900">Learn More</h3>
          {[
            {
              title: 'Understanding Your Menstrual Cycle',
              excerpt: 'Learn the four phases and how they affect your body and mood',
              icon: '📚',
            },
            {
              title: 'Cycle Syncing 101',
              excerpt: 'Optimize your lifestyle based on your cycle phase',
              icon: '🔄',
            },
            {
              title: 'When to See a Doctor',
              excerpt: 'Red flags and warning signs you should know about',
              icon: '🏥',
            },
          ].map((article) => (
            <div
              key={article.title}
              className="card hover:shadow-medium cursor-pointer transition-all hover:border-pina-pink border"
            >
              <div className="flex items-start gap-3">
                <span className="text-2xl flex-shrink-0">{article.icon}</span>
                <div className="flex-1">
                  <h4 className="font-semibold text-neutral-900">{article.title}</h4>
                  <p className="text-xs text-neutral-600 mt-1">{article.excerpt}</p>
                </div>
              </div>
            </div>
          ))}
        </div>

        <button className="btn-primary w-full mb-4">
          Get AI Insights
        </button>
      </div>
    </div>
  )
}
