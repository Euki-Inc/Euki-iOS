/**
 * Header component for La Piña app
 */

import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Platform } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Colors, Typography, Spacing, Shadows } from '@/theme';

interface HeaderProps {
  title: string;
  onLeftPress?: () => void;
  onRightPress?: () => void;
  leftIcon?: React.ReactNode;
  rightIcon?: React.ReactNode;
  subtitle?: string;
  backgroundColor?: string;
}

export const Header: React.FC<HeaderProps> = ({
  title,
  onLeftPress,
  onRightPress,
  leftIcon,
  rightIcon,
  subtitle,
  backgroundColor = Colors.background,
}) => {
  const insets = useSafeAreaInsets();

  const styles = StyleSheet.create({
    container: {
      paddingTop: insets.top,
      paddingLeft: Spacing.screenPadding,
      paddingRight: Spacing.screenPadding,
      paddingBottom: Spacing.lg,
      backgroundColor,
      ...Shadows.subtle,
    },
    contentContainer: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      minHeight: Spacing.headerHeight,
    },
    titleContainer: {
      flex: 1,
      marginHorizontal: Spacing.lg,
    },
    title: {
      ...Typography.h3,
      color: Colors.text,
      marginBottom: subtitle ? Spacing.sm : 0,
    },
    subtitle: {
      ...Typography.bodySmall,
      color: Colors.textSecondary,
    },
    iconButton: {
      padding: Spacing.md,
      justifyContent: 'center',
      alignItems: 'center',
    },
  });

  return (
    <View style={styles.container}>
      <View style={styles.contentContainer}>
        {onLeftPress || leftIcon ? (
          <TouchableOpacity
            style={styles.iconButton}
            onPress={onLeftPress}
            disabled={!onLeftPress}
            activeOpacity={0.6}
          >
            {leftIcon}
          </TouchableOpacity>
        ) : (
          <View style={styles.iconButton} />
        )}

        <View style={styles.titleContainer}>
          <Text style={styles.title} numberOfLines={1}>
            {title}
          </Text>
          {subtitle && (
            <Text style={styles.subtitle} numberOfLines={1}>
              {subtitle}
            </Text>
          )}
        </View>

        {onRightPress || rightIcon ? (
          <TouchableOpacity
            style={styles.iconButton}
            onPress={onRightPress}
            disabled={!onRightPress}
            activeOpacity={0.6}
          >
            {rightIcon}
          </TouchableOpacity>
        ) : (
          <View style={styles.iconButton} />
        )}
      </View>
    </View>
  );
};

export default Header;
