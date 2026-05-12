export function MockChart() {
  const data = [
    { month: 'Nov', value: 29, avg: 28 },
    { month: 'Dec', value: 28, avg: 28 },
    { month: 'Jan', value: 28, avg: 28 },
  ]

  const maxValue = 32

  return (
    <div className="w-full">
      <div className="flex items-flex-end justify-around gap-4 h-48 py-4">
        {data.map((item) => (
          <div key={item.month} className="flex flex-col items-center flex-1">
            <div className="flex gap-2 items-flex-end h-40 w-full">
              {/* Actual value bar */}
              <div className="flex-1 flex flex-col-reverse items-center">
                <div className="w-full rounded-t-lg bg-gradient-to-t from-pina-pink to-pina-pink transition-all"
                  style={{ height: `${(item.value / maxValue) * 100}%` }}
                />
                <span className="text-xs font-bold text-pina-pink mt-2 h-5">{item.value}d</span>
              </div>

              {/* Average line indicator */}
              <div className="w-1 rounded-full bg-neutral-300"
                style={{ height: `${(item.avg / maxValue) * 100}%` }}
              />
            </div>
            <span className="text-xs font-medium text-neutral-600 mt-2">{item.month}</span>
          </div>
        ))}
      </div>

      {/* Legend */}
      <div className="flex justify-center gap-6 text-xs text-neutral-600 pt-4">
        <div className="flex items-center gap-2">
          <div className="w-3 h-3 rounded-sm bg-pina-pink" />
          <span>Actual</span>
        </div>
        <div className="flex items-center gap-2">
          <div className="w-1 h-3 rounded-full bg-neutral-300" />
          <span>Average</span>
        </div>
      </div>
    </div>
  )
}
