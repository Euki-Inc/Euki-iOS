/**
 * Mexican-inspired color palette for La Piña
 * Warm, earthy tones with wellness-focused hues
 */

export const Colors = {
  // Primary colors - Terra cotta & warm tones
  primary: '#E67E5B',           // Warm terra cotta
  primaryLight: '#F5A379',      // Light terra cotta
  primaryDark: '#D46A45',       // Dark terra cotta
  primaryVariant: '#F4A869',    // Soft orange

  // Secondary colors - Sage green & natural
  secondary: '#7DBB8E',         // Sage green
  secondaryLight: '#A8D5BA',    // Light sage
  secondaryDark: '#6A9B76',     // Dark sage
  secondaryVariant: '#B8D9C5',  // Soft sage

  // Accent colors
  accent: '#F9A875',            // Peachy coral
  accentVariant: '#FFD4A8',     // Soft peach
  warning: '#F4A460',           // Sandy brown
  error: '#E07856',             // Reddish coral

  // Wellness & cycle tracking colors
  cyclePhase: {
    menstrual: '#E8899B',       // Soft red/pink
    follicular: '#FFD4A8',      // Light peach
    ovulation: '#FDB813',       // Warm yellow
    luteal: '#B8A8D9',          // Soft purple
  },

  // Mood colors
  mood: {
    happy: '#FFD700',           // Gold
    energetic: '#FF6B6B',       // Coral red
    calm: '#7DBB8E',            // Sage green
    stressed: '#FF8C42',        // Orange
    tired: '#9B8FC4',           // Lavender
    anxious: '#FFB347',         // Light orange
  },

  // Backgrounds & Surfaces
  background: '#FFFBF8',        // Off-white with warm tint
  surface: '#FFFBF8',
  surfaceVariant: '#F5F0ED',
  surfaceLight: '#FEFDFB',

  // Grayscale
  text: '#3D3D3D',              // Dark gray
  textSecondary: '#757575',     // Medium gray
  textTertiary: '#A0A0A0',      // Light gray
  textDisabled: '#BDBDBD',      // Disabled gray
  divider: '#E8E8E8',           // Divider gray
  border: '#E8DDD8',            // Warm gray border

  // Status colors
  success: '#7DBB8E',
  info: '#5B9BD5',
  disabled: '#E0E0E0',

  // Glass morphism
  glassBg: 'rgba(255, 251, 248, 0.7)',     // Translucent background
  glassBlur: 'rgba(255, 251, 248, 0.85)',  // Stronger glass effect

  // Gradient bases
  gradient: {
    primary: ['#E67E5B', '#F5A379'],
    secondary: ['#7DBB8E', '#A8D5BA'],
    wellness: ['#FFD4A8', '#F9A875'],
    sunset: ['#E67E5B', '#F4A869'],
  },
};

export const DarkColors = {
  // Adjusted for dark mode (if needed later)
  primary: '#F5A379',
  secondary: '#A8D5BA',
  background: '#1A1A1A',
  surface: '#2D2D2D',
  text: '#F5F5F5',
  textSecondary: '#B0B0B0',
};

export type ColorKey = keyof typeof Colors;
