// Mock data matching the specs
export const mockCycles = [
  {
    id: 1,
    start_date: '2026-01-05',
    end_date: '2026-01-10',
    cycle_length: 28,
    period_length: 5,
    flow: 'medium',
    symptoms: ['cramps', 'bloating', 'fatigue'],
  },
  {
    id: 2,
    start_date: '2025-12-08',
    end_date: '2025-12-13',
    cycle_length: 28,
    period_length: 5,
    flow: 'heavy',
    symptoms: ['cramps', 'headache', 'mood_swings'],
  },
  {
    id: 3,
    start_date: '2025-11-10',
    end_date: '2025-11-15',
    cycle_length: 29,
    period_length: 5,
    flow: 'medium',
    symptoms: ['bloating', 'fatigue'],
  },
];

export const mockSymptoms = [
  {
    date: '2026-01-30',
    mood: ['happy', 'energetic'],
    body: ['clear_skin'],
    sleep_hours: 7.5,
    notes: 'Feeling great today!',
  },
  {
    date: '2026-01-29',
    mood: ['anxious', 'tired'],
    body: ['headache', 'bloating'],
    sleep_hours: 6,
    notes: 'PMS symptoms starting',
  },
  {
    date: '2026-01-28',
    mood: ['calm'],
    body: ['cramps'],
    sleep_hours: 8,
    notes: '',
  },
];

export const mockPregnancyWeeks = [
  {
    week: 1,
    title: 'Week 1: Preparation',
    description: 'Your body is preparing for ovulation',
    fetal_development: "Conception hasn't occurred yet",
    tips: ['Take prenatal vitamins', 'Track ovulation'],
  },
  {
    week: 8,
    title: 'Week 8: Rapid Growth',
    description: 'Baby is growing rapidly',
    fetal_development: 'Arms and legs are forming, heart is beating',
    tips: ['Stay hydrated', 'Eat small frequent meals'],
  },
  {
    week: 20,
    title: 'Week 20: Halfway There',
    description: "You're halfway through pregnancy!",
    fetal_development: 'Baby can hear sounds, movements felt',
    tips: ['Start prenatal classes', 'Consider nursery planning'],
  },
];

export const mockInsights = [
  {
    type: 'irregular_cycle',
    title: 'Cycle Length Variation Detected',
    message: 'Your last 3 cycles varied by more than 7 days. This is normal, but if it continues, consider consulting a healthcare provider.',
    severity: 'low',
    icon: 'ℹ️',
  },
  {
    type: 'fertility_window',
    title: 'Fertile Window Approaching',
    message: 'Based on your cycle, your fertile window is estimated to be Feb 5-10.',
    severity: 'info',
    icon: '📅',
  },
];

export const mockBlogPosts = [
  {
    id: 1,
    category: 'luxury_wellness',
    title: 'The Ultimate Guide to Self-Care Sundays',
    excerpt: 'Discover luxury wellness products that elevate your self-care routine',
    image: 'self-care-luxury.jpg',
    affiliate_products: [
      {
        name: 'Rose Quartz Gua Sha',
        price: '$45',
        link: 'https://amazon.com/placeholder',
      },
    ],
  },
  {
    id: 2,
    category: 'intimacy',
    title: 'Empowerment Through Intimacy',
    excerpt: 'High-end products designed for your pleasure and wellness',
    image: 'intimacy-products.jpg',
    affiliate_products: [
      {
        name: 'Premium Wellness Wand',
        price: '$120',
        link: 'https://amazon.com/placeholder',
      },
    ],
  },
  {
    id: 3,
    category: 'mental_wellness',
    title: 'Mindfulness Practices for Busy Women',
    excerpt: 'Expert advice on mental health and spiritual wellness',
    image: 'mindfulness.jpg',
    affiliate_products: [],
  },
  {
    id: 4,
    category: 'fitness',
    title: 'Cycle-Syncing Your Workouts',
    excerpt: 'Optimize your fitness routine based on your menstrual cycle',
    image: 'fitness-cycle.jpg',
    affiliate_products: [
      {
        name: 'Smart Yoga Mat',
        price: '$89',
        link: 'https://amazon.com/placeholder',
      },
    ],
  },
  {
    id: 5,
    category: 'gourmet',
    title: 'Hormone-Balancing Teas & Coffee',
    excerpt: 'Delicious beverages that support your wellness journey',
    image: 'tea-coffee.jpg',
    affiliate_products: [
      {
        name: 'Organic Moon Cycle Tea Set',
        price: '$32',
        link: 'https://amazon.com/placeholder',
      },
    ],
  },
];

export const premiumFeatures = [
  'Unlimited AI companion queries',
  'Full blog & flipbook access',
  'Advanced cycle predictions',
  'Export all data (PDF/CSV)',
  'Priority support',
  'Custom reminders',
  'Trend analysis reports',
];
