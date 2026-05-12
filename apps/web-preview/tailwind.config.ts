import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './app/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        pina: {
          pink: '#E10098',
          purple: '#8E44AD',
          yellow: '#FFD600',
          teal: '#00BFB3',
        },
        neutral: {
          0: '#FFFFFF',
          50: '#F5F5F5',
          200: '#CCCCCC',
          600: '#666666',
          900: '#1A1A1A',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        sm: '8px',
        md: '16px',
        lg: '24px',
        full: '9999px',
      },
      boxShadow: {
        soft: '0px 4px 16px rgba(0, 0, 0, 0.08)',
        md: '0px 8px 24px rgba(0, 0, 0, 0.12)',
        lg: '0px 12px 32px rgba(0, 0, 0, 0.16)',
      },
      spacing: {
        xs: '4px',
        sm: '8px',
        md: '16px',
        lg: '24px',
        xl: '32px',
        xxl: '48px',
      },
      animation: {
        spiral: 'spin 2s ease-in-out infinite',
        bubble: 'bubble 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)',
      },
      keyframes: {
        bubble: {
          '0%': { transform: 'scale(0.95)' },
          '100%': { transform: 'scale(1)' },
        },
      },
    },
  },
  plugins: [],
}

export default config
