/**
 * Loading Placeholder component for La Piña app
 */

import React from 'react';
import { View, StyleSheet, ActivityIndicator } from 'react-native';
import { Colors, Spacing } from '@/theme';

interface LoadingPlaceholderProps {
  size?: 'small' | 'large';
  color?: string;
  fullScreen?: boolean;
}

export const LoadingPlaceholder: React.FC<LoadingPlaceholderProps> = ({
  size = 'large',
  color = Colors.primary,
  fullScreen = false,
}) => {
  const styles = StyleSheet.create({
    container: {
      flex: fullScreen ? 1 : 0,
      justifyContent: 'center',
      alignItems: 'center',
      padding: Spacing.lg,
      backgroundColor: fullScreen ? Colors.background : 'transparent',
      minHeight: fullScreen ? '100%' : 100,
    },
  });

  return (
    <View style={styles.container}>
      <ActivityIndicator size={size} color={color} />
    </View>
  );
};

export default LoadingPlaceholder;
