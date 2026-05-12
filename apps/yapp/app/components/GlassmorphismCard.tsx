/**
 * Glassmorphism Card component for La Piña app
 * Creates beautiful frosted glass effect cards
 */

import React from 'react';
import { View, ViewStyle, StyleSheet } from 'react-native';
import { BlurView } from 'expo-blur';
import { Colors, Spacing, Shadows } from '@/theme';

interface GlassmorphismCardProps {
  children: React.ReactNode;
  style?: ViewStyle;
  intensity?: 'light' | 'medium' | 'strong';
  onPress?: () => void;
  disabled?: boolean;
  padding?: number;
  borderRadius?: number;
  shadowIntensity?: 'subtle' | 'medium' | 'strong';
}

export const GlassmorphismCard: React.FC<GlassmorphismCardProps> = ({
  children,
  style,
  intensity = 'medium',
  onPress,
  disabled = false,
  padding = Spacing.cardPadding,
  borderRadius = Spacing.cardRadius,
  shadowIntensity = 'medium',
}) => {
  const getBlurIntensity = () => {
    switch (intensity) {
      case 'light':
        return 20;
      case 'medium':
        return 30;
      case 'strong':
        return 50;
      default:
        return 30;
    }
  };

  const getBackgroundColor = () => {
    switch (intensity) {
      case 'light':
        return 'rgba(255, 251, 248, 0.6)';
      case 'medium':
        return 'rgba(255, 251, 248, 0.75)';
      case 'strong':
        return 'rgba(255, 251, 248, 0.9)';
      default:
        return 'rgba(255, 251, 248, 0.75)';
    }
  };

  const getShadow = () => {
    switch (shadowIntensity) {
      case 'subtle':
        return Shadows.subtle;
      case 'medium':
        return Shadows.medium;
      case 'strong':
        return Shadows.strong;
      default:
        return Shadows.medium;
    }
  };

  const styles = StyleSheet.create({
    container: {
      borderRadius,
      overflow: 'hidden',
      opacity: disabled ? 0.6 : 1,
      ...getShadow(),
    },
    blurContainer: {
      padding,
      backgroundColor: getBackgroundColor(),
      borderColor: 'rgba(255, 255, 255, 0.35)',
      borderWidth: 1,
    },
    content: {
      flex: 1,
    },
  });

  const containerStyle = [styles.container, style];

  if (onPress) {
    return (
      <View style={containerStyle}>
        <BlurView intensity={getBlurIntensity()}>
          <View
            style={styles.blurContainer}
            onTouchEnd={!disabled ? onPress : undefined}
          >
            <View style={styles.content}>{children}</View>
          </View>
        </BlurView>
      </View>
    );
  }

  return (
    <View style={containerStyle}>
      <BlurView intensity={getBlurIntensity()}>
        <View style={styles.blurContainer}>
          <View style={styles.content}>{children}</View>
        </View>
      </BlurView>
    </View>
  );
};

export default GlassmorphismCard;
