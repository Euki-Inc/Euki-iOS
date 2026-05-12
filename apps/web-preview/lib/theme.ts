export const THEME = {
  colors: {
    primary: {
      hex: '#E10098',
      name: 'Piña Pink',
    },
    secondary: {
      hex: '#8E44AD',
      name: 'Purple',
    },
    accent: {
      hex: '#FFD600',
      name: 'Sunshine Yellow',
    },
    teal: {
      hex: '#00BFB3',
      name: 'Aqua Spiral',
    },
    neutrals: {
      white: '#FFFFFF',
      lightGray: '#F5F5F5',
      gray: '#CCCCCC',
      darkGray: '#666666',
      black: '#1A1A1A',
    },
  },
  gradients: {
    primary: 'linear-gradient(135deg, #E10098 0%, #8E44AD 100%)',
    sunset: 'linear-gradient(90deg, #FFD600 0%, #E10098 100%)',
    ocean: 'linear-gradient(180deg, #00BFB3 0%, #8E44AD 100%)',
  },
  typography: {
    sizes: {
      h1: '32px',
      h2: '24px',
      h3: '20px',
      body: '16px',
      small: '14px',
      tiny: '12px',
    },
    weights: {
      regular: 400,
      medium: 500,
      semibold: 600,
      bold: 700,
    },
  },
  spacing: {
    xs: '4px',
    sm: '8px',
    md: '16px',
    lg: '24px',
    xl: '32px',
    xxl: '48px',
  },
  borderRadius: {
    sm: '8px',
    md: '16px',
    lg: '24px',
    full: '9999px',
  },
  shadows: {
    soft: '0px 4px 16px rgba(0, 0, 0, 0.08)',
    medium: '0px 8px 24px rgba(0, 0, 0, 0.12)',
    heavy: '0px 12px 32px rgba(0, 0, 0, 0.16)',
  },
};

export const TAB_CONFIG = [
  {
    id: 'cycle',
    label: 'Cycle',
    icon: '📅',
    color: '#E10098',
    route: '/cycle',
  },
  {
    id: 'symptoms',
    label: 'Symptoms',
    icon: '💓',
    color: '#8E44AD',
    route: '/symptoms',
  },
  {
    id: 'pregnancy',
    label: 'Pregnancy',
    icon: '👶',
    color: '#00BFB3',
    route: '/pregnancy',
  },
  {
    id: 'insights',
    label: 'Insights',
    icon: '📊',
    color: '#FFD600',
    route: '/insights',
  },
  {
    id: 'blog',
    label: 'Blog',
    icon: '📖',
    color: '#E10098',
    route: '/blog',
  },
];
