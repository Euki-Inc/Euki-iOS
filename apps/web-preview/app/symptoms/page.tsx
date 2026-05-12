'use client'

import { useState } from 'react'
import { SpiralHeader } from '@/components/SpiralHeader'
import { mockSymptoms } from '@/lib/data'

const MOOD_OPTIONS = [
  { id: 'happy', label: 'Happy', emoji: '😊' },
  { id: 'energetic', label: 'Energetic', emoji: '⚡' },
  { id: 'calm', label: 'Calm', emoji: '😌' },
  { id: 'anxious', label: 'Anxious', emoji: '😰' },
  { id: 'tired', label: 'Tired', emoji: '😴' },
  { id: 'sad', label: 'Sad', emoji: '😢' },
]

const BODY_OPTIONS = [
  { id: 'cramps', label: 'Cramps', emoji: '⚠️' },
  { id: 'headache', label: 'Headache', emoji: '🤕' },
  { id: 'bloating', label: 'Bloating', emoji: '🫖' },
  { id: 'fatigue', label: 'Fatigue', emoji: '😵' },
  { id: 'clear_skin', label: 'Clear Skin', emoji: '✨' },
  { id: 'backpain', label: 'Back Pain', emoji: '🔙' },
]

export default function SymptomsPage() {
  const [selectedMoods, setSelectedMoods] = useState<string[]>([])
  const [selectedBody, setSelectedBody] = useState<string[]>([])
  const [sleepHours, setSleepHours] = useState(7)
  const [notes, setNotes] = useState('')

  const toggleMood = (id: string) => {
    setSelectedMoods((prev) =>
      prev.includes(id) ? prev.filter((m) => m !== id) : [...prev, id]
    )
  }

  const toggleBody = (id: string) => {
    setSelectedBody((prev) =>
      prev.includes(id) ? prev.filter((b) => b !== id) : [...prev, id]
    )
  }

  const handleSave = () => {
    const data = {
      mood: selectedMoods,
      body: selectedBody,
      sleep: sleepHours,
      notes,
      date: new Date().toISOString().split('T')[0],
    }
    console.log('Saving symptoms:', data)
    alert('Symptoms logged! This is demo data.')
  }

  return (
    <div className="w-full">
      <SpiralHeader title="Symptom Tracker" subtitle="How are you feeling today?" />

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Mood Section */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Mood</h3>
          <div className="grid grid-cols-3 md:grid-cols-6 gap-3">
            {MOOD_OPTIONS.map((mood) => (
              <button
                key={mood.id}
                onClick={() => toggleMood(mood.id)}
                className={`p-3 rounded-lg transition-all flex flex-col items-center gap-2 ${
                  selectedMoods.includes(mood.id)
                    ? 'bg-pina-pink bg-opacity-10 border-2 border-pina-pink'
                    : 'bg-neutral-50 border-2 border-transparent hover:border-pina-pink'
                }`}
              >
                <span className="text-2xl">{mood.emoji}</span>
                <span className="text-xs font-medium text-center">{mood.label}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Body Symptoms Section */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Body Symptoms</h3>
          <div className="grid grid-cols-3 md:grid-cols-6 gap-3">
            {BODY_OPTIONS.map((symptom) => (
              <button
                key={symptom.id}
                onClick={() => toggleBody(symptom.id)}
                className={`p-3 rounded-lg transition-all flex flex-col items-center gap-2 ${
                  selectedBody.includes(symptom.id)
                    ? 'bg-pina-purple bg-opacity-10 border-2 border-pina-purple'
                    : 'bg-neutral-50 border-2 border-transparent hover:border-pina-purple'
                }`}
              >
                <span className="text-2xl">{symptom.emoji}</span>
                <span className="text-xs font-medium text-center">{symptom.label}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Sleep Section */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Sleep Quality</h3>
          <div className="flex items-center gap-4">
            <input
              type="range"
              min="0"
              max="12"
              step="0.5"
              value={sleepHours}
              onChange={(e) => setSleepHours(parseFloat(e.target.value))}
              className="flex-1 h-2 bg-gradient-to-r from-pina-purple to-pina-pink rounded-lg appearance-none cursor-pointer"
            />
            <span className="text-2xl font-bold text-pina-pink min-w-20">{sleepHours.toFixed(1)}h</span>
          </div>
          <p className="text-xs text-neutral-600 mt-2">Hours of sleep</p>
        </div>

        {/* Notes Section */}
        <div className="card mb-8">
          <h3 className="text-lg font-bold mb-4 text-neutral-900">Notes</h3>
          <textarea
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            placeholder="Add any additional notes about how you're feeling..."
            className="w-full p-4 rounded-lg border border-neutral-200 focus:ring-2 focus:ring-pina-pink focus:border-transparent"
            rows={4}
          />
        </div>

        {/* Today's Summary */}
        {mockSymptoms.length > 0 && (
          <div className="card mb-8 bg-neutral-50">
            <h3 className="text-lg font-bold mb-4 text-neutral-900">Today's Log</h3>
            <div className="space-y-3">
              {mockSymptoms[0] && (
                <>
                  <div>
                    <p className="text-xs text-neutral-600 uppercase tracking-wide">Mood</p>
                    <div className="flex flex-wrap gap-2 mt-1">
                      {mockSymptoms[0].mood.map((m) => (
                        <span key={m} className="badge bg-pina-pink bg-opacity-10 text-pina-pink">
                          {m.replace('_', ' ')}
                        </span>
                      ))}
                    </div>
                  </div>
                  <div>
                    <p className="text-xs text-neutral-600 uppercase tracking-wide">Body</p>
                    <div className="flex flex-wrap gap-2 mt-1">
                      {mockSymptoms[0].body.map((b) => (
                        <span key={b} className="badge bg-pina-purple bg-opacity-10 text-pina-purple">
                          {b.replace('_', ' ')}
                        </span>
                      ))}
                    </div>
                  </div>
                  <div>
                    <p className="text-xs text-neutral-600 uppercase tracking-wide">Sleep</p>
                    <p className="font-semibold text-neutral-900 mt-1">{mockSymptoms[0].sleep_hours} hours</p>
                  </div>
                </>
              )}
            </div>
          </div>
        )}

        {/* Recent Symptoms */}
        <div className="space-y-4 mb-8">
          <h3 className="text-xl font-bold text-neutral-900">Symptom History</h3>
          {mockSymptoms.map((entry) => (
            <div key={entry.date} className="card">
              <div className="flex justify-between items-start mb-3">
                <p className="font-semibold text-neutral-900">{entry.date}</p>
                <span className="text-sm text-neutral-600">{entry.sleep_hours}h sleep</span>
              </div>
              {entry.notes && (
                <p className="text-sm text-neutral-600 mb-3 italic">"{entry.notes}"</p>
              )}
              <div className="flex flex-wrap gap-2">
                {entry.mood.map((m) => (
                  <span key={m} className="badge bg-pina-pink bg-opacity-10 text-pina-pink text-xs">
                    {m.replace('_', ' ')}
                  </span>
                ))}
                {entry.body.map((b) => (
                  <span key={b} className="badge bg-pina-purple bg-opacity-10 text-pina-purple text-xs">
                    {b.replace('_', ' ')}
                  </span>
                ))}
              </div>
            </div>
          ))}
        </div>

        <button onClick={handleSave} className="btn-primary w-full">
          Log Symptoms
        </button>
      </div>
    </div>
  )
}
