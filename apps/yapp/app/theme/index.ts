/**
 * Centralized theme export
 */

export * from './colors';
export * from './typography';
export * from './spacing';
export * from './shadows';

import { Colors } from './colors';
import { Typography } from './typography';
import { Spacing } from './spacing';
import { Shadows } from './shadows';

export const Theme = {
  colors: Colors,
  typography: Typography,
  spacing: Spacing,
  shadows: Shadows,
};

export default Theme;
