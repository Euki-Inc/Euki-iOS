// Stubbed API calls for demo mode

export async function fetchUserData() {
  return {
    id: 'user-123',
    name: 'Demo User',
    email: 'demo@lapina.app',
    is_premium: false,
    created_at: '2025-01-01',
  };
}

export async function fetchCycleData() {
  return {
    current_cycle_day: 14,
    cycle_length: 28,
    period_start: '2026-01-05',
    period_end: '2026-01-10',
    fertile_window: {
      start: '2026-02-05',
      end: '2026-02-10',
    },
  };
}

export async function fetchSymptomTracking() {
  return {
    today: {
      mood: ['energetic'],
      body: [],
      sleep: 7.5,
      notes: '',
    },
  };
}

export async function logSymptom(data: any) {
  console.log('Logging symptom:', data);
  return { success: true, id: 'symptom-' + Date.now() };
}

export async function fetchInsights() {
  return {
    alerts: [],
    trends: {
      avg_cycle_length: 28,
      regularity: 'regular',
    },
  };
}

export async function uploadProfilePhoto(file: File) {
  console.log('Uploading photo:', file.name);
  return { success: true, url: '/placeholder-avatar.jpg' };
}

export async function getPremiumStatus() {
  return {
    is_premium: false,
    trial_days_remaining: 0,
    next_billing_date: null,
  };
}

export async function submitPremiumCheckout(priceId: string) {
  console.log('Submitting premium checkout:', priceId);
  return { success: true, session_id: 'session-' + Date.now() };
}
