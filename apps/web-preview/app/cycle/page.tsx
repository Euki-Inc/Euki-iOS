'use client'

import { useState } from 'react'
import { SpiralHeader } from '@/components/SpiralHeader'
import { MockChart } from '@/components/MockChart'
import { mockCycles } from '@/lib/data'

const DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

function generateCalendarDays(year: number, month: number) {
  const firstDay = new Date(year, month, 1).getDay()
  const daysInMonth = new Date(year, month + 1, 0).getDate()
  const days = []

  for (let i = 0; i < firstDay; i++) {
    days.push(null)
  }

  for (let i = 1; i <= daysInMonth; i++) {
    days.push({
      day: i,
      date: new Date(year, month, i),
      isPeriod: false,
      isFertile: false,
    })
  }

  return days
}

export default function CyclePage() {
  const now = new Date()
  const [currentMonth, setCurrentMonth] = useState(now.getMonth())
  const [currentYear, setCurrentYear] = useState(now.getFullYear())

  const calendarDays = generateCalendarDays(currentYear, currentMonth)

  const handlePrevMonth = () => {
    if (currentMonth === 0) {
      setCurrentMonth(11)
      setCurrentYear(currentYear - 1)
    } else {
      setCurrentMonth(currentMonth - 1)
    }
  }

  const handleNextMonth = () => {
    if (currentMonth === 11) {
      setCurrentMonth(0)
      setCurrentYear(currentYear + 1)
    } else {
      setCurrentMonth(currentMonth + 1)
    }
  }

  return (
    <div className="w-full">
      <SpiralHeader title="Your Cycle" subtitle="Track your menstrual health" />

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Current Cycle Info */}
        <div className="card mb-8 gradient-primary text-white">
          <div className="flex justify-between items-start mb-4">
            <div>
              <p className="text-sm opacity-90">Current Cycle Day</p>
              <h3 className="text-4xl font-bold">14</h3>
            </div>
            <span className="badge bg-white bg-opacity-20 text-white">Medium Flow</span>
          </div>
          <div className="grid grid-cols-3 gap-4">
            <div>
              <p className="text-xs opacity-75">Period Length</p>
              <p className="text-lg font-semibold">5 days</p>
            </div>
            <div>
              <p className="text-xs opacity-75">Cycle Length</p>
              <p className="text-lg font-semibold">28 days</p>
            </div>
            <div>
              <p className="text-xs opacity-75">Next Period</p>
              <p className="text-lg font-semibold">Feb 2</p>
            </div>
          </div>
        </div>

        {/* Fertility Window Alert */}
        <div className="card mb-8 border-l-4 border-pina-teal bg-blue-50">
          <div className="flex items-start gap-3">
            <span className="text-2xl">🧪</span>
            <div>
              <h4 className="font-semibold text-neutral-900">Fertile Window Approaching</h4>
              <p className="text-sm text-neutral-600 mt-1">
                Based on your cycle data, your fertile window is estimated for Feb 5-10.
              </p>
            </div>
          </div>
        </div>

        {/* Calendar */}
        <div className="card mb-8">
          <div className="flex justify-between items-center mb-6">
            <h3 className="text-xl font-bold text-neutral-900">
              {MONTHS[currentMonth]} {currentYear}
            </h3>
            <div className="flex gap-2">
              <button
                onClick={handlePrevMonth}
                className="btn-ghost text-pina-pink hover:bg-red-50"
              >
                ←
              </button>
              <button
                onClick={handleNextMonth}
                className="btn-ghost text-pina-pink hover:bg-red-50"
              >
                →
              </button>
            </div>
          </div>

          <div className="grid grid-cols-7 gap-2 mb-4">
            {DAYS.map((day) => (
              <div key={day} className="text-center text-xs font-semibold text-neutral-600 py-2">
                {day}
              </div>
            ))}
          </div>

          <div className="grid grid-cols-7 gap-2">
            {calendarDays.map((dayObj, idx) => (
              <div
                key={idx}
                className={`aspect-square rounded-lg flex items-center justify-center text-sm font-medium transition-all ${
                  !dayObj
                    ? 'bg-transparent'
                    : dayObj.day === now.getDate() &&
                      currentMonth === now.getMonth() &&
                      currentYear === now.getFullYear()
                    ? 'bg-pina-pink text-white shadow-soft'
                    : dayObj.day <= 10 && currentMonth === 0 && currentYear === 2026
                    ? 'bg-red-100 text-red-700 border-2 border-red-300'
                    : 'bg-neutral-50 text-neutral-900 hover:bg-neutral-100'
                }`}
              >
                {dayObj?.day}
              </div>
            ))}
          </div>

          <div className="mt-6 pt-6 border-t border-neutral-200 flex gap-4 text-sm">
            <div className="flex items-center gap-2">
              <div className="w-4 h-4 rounded bg-red-100 border-2 border-red-300" />
              <span>Period</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-4 h-4 rounded bg-pina-teal bg-opacity-20 border-2 border-pina-teal" />
              <span>Fertile</span>
            </div>
          </div>
        </div>

        {/* Cycle History Chart */}
        <div className="card mb-8">
          <h3 className="text-xl font-bold mb-6 text-neutral-900">Cycle History</h3>
          <MockChart />
        </div>

        {/* Recent Cycles */}
        <div className="space-y-4">
          <h3 className="text-xl font-bold text-neutral-900">Recent Cycles</h3>
          {mockCycles.map((cycle) => (
            <div key={cycle.id} className="card">
              <div className="flex justify-between items-start">
                <div>
                  <p className="text-sm text-neutral-600">Cycle #{cycle.id}</p>
                  <p className="font-semibold text-neutral-900">{cycle.start_date}</p>
                  <p className="text-xs text-neutral-600 mt-1">
                    {cycle.period_length} day period • {cycle.cycle_length} day cycle
                  </p>
                </div>
                <span className={`badge ${cycle.flow === 'heavy' ? 'bg-red-100 text-red-700' : 'bg-orange-100 text-orange-700'}`}>
                  {cycle.flow} flow
                </span>
              </div>
              {cycle.symptoms.length > 0 && (
                <div className="mt-3 flex flex-wrap gap-2">
                  {cycle.symptoms.map((symptom) => (
                    <span
                      key={symptom}
                      className="badge bg-pina-pink bg-opacity-10 text-pina-pink text-xs"
                    >
                      {symptom.replace('_', ' ')}
                    </span>
                  ))}
                </div>
              )}
            </div>
          ))}
        </div>

        {/* Log Period Button */}
        <div className="mt-8 mb-4">
          <button className="btn-primary w-full">
            Log Period
          </button>
        </div>
      </div>
    </div>
  )
}
