/**
 * Spacing system for La Piña
 * 8px base unit for consistent spacing
 */

export const Spacing = {
  // Base unit - 8px
  xs: 4,      // 0.5x
  sm: 8,      // 1x
  md: 12,     // 1.5x
  lg: 16,     // 2x
  xl: 24,     // 3x
  xxl: 32,    // 4x
  xxxl: 48,   // 6x
  huge: 64,   // 8x

  // Aliases for common patterns
  none: 0,
  tiny: 4,
  small: 8,
  medium: 16,
  large: 24,
  xLarge: 32,

  // Screen padding
  screenPadding: 16,
  screenPaddingBottom: 24,
  screenPaddingTop: 16,

  // Component spacing
  componentGap: 12,
  cardPadding: 16,
  cardRadius: 16,
  smallRadius: 8,
  largeRadius: 24,

  // Button dimensions
  buttonHeight: 48,
  buttonHeightSmall: 40,
  smallButtonHeight: 36,
  buttonRadius: 12,
  buttonPaddingHorizontal: 16,
  buttonPaddingVertical: 12,

  // Input dimensions
  inputHeight: 48,
  inputRadius: 12,
  inputPadding: 12,

  // Tab bar
  tabBarHeight: 80,
  tabBarPadding: 8,

  // Header
  headerHeight: 56,
  headerPadding: 12,
};

// Responsive spacing helpers
export const getResponsiveSpacing = (baseSize: number, screenWidth: number) => {
  if (screenWidth >= 768) {
    return baseSize * 1.25;
  }
  return baseSize;
};

export type SpacingKey = keyof typeof Spacing;
