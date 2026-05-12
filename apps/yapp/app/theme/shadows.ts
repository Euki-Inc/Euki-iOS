/**
 * Shadow system for La Piña
 * Glassmorphism and elevation effects
 */

import { Platform } from 'react-native';

export const Shadows = {
  // Subtle shadow for cards
  subtle: Platform.select({
    ios: {
      shadowColor: '#3D3D3D',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.08,
      shadowRadius: 4,
    },
    android: {
      elevation: 2,
    },
  }),

  // Medium shadow for elevated elements
  medium: Platform.select({
    ios: {
      shadowColor: '#3D3D3D',
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.12,
      shadowRadius: 8,
    },
    android: {
      elevation: 4,
    },
  }),

  // Strong shadow for modals
  strong: Platform.select({
    ios: {
      shadowColor: '#3D3D3D',
      shadowOffset: { width: 0, height: 8 },
      shadowOpacity: 0.15,
      shadowRadius: 12,
    },
    android: {
      elevation: 8,
    },
  }),

  // Extra strong shadow for overlays
  extraStrong: Platform.select({
    ios: {
      shadowColor: '#3D3D3D',
      shadowOffset: { width: 0, height: 12 },
      shadowOpacity: 0.2,
      shadowRadius: 16,
    },
    android: {
      elevation: 12,
    },
  }),

  // No shadow
  none: Platform.select({
    ios: {
      shadowColor: 'transparent',
      shadowOffset: { width: 0, height: 0 },
      shadowOpacity: 0,
      shadowRadius: 0,
    },
    android: {
      elevation: 0,
    },
  }),
};

// Glassmorphism effects
export const GlassEffects = {
  light: {
    backgroundColor: 'rgba(255, 251, 248, 0.7)',
    borderColor: 'rgba(255, 255, 255, 0.3)',
    borderWidth: 1,
  },
  medium: {
    backgroundColor: 'rgba(255, 251, 248, 0.8)',
    borderColor: 'rgba(255, 255, 255, 0.4)',
    borderWidth: 1.5,
  },
  strong: {
    backgroundColor: 'rgba(255, 251, 248, 0.9)',
    borderColor: 'rgba(255, 255, 255, 0.5)',
    borderWidth: 1.5,
  },
};

export type ShadowKey = keyof typeof Shadows;
