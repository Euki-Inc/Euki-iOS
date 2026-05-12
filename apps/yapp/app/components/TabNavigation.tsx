/**
 * Tab Navigation component for La Piña app
 * Custom tab navigation bar with glassmorphism effect
 */

import React from 'react';
import { View, TouchableOpacity, StyleSheet, Text } from 'react-native';
import { BlurView } from 'expo-blur';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Colors, Typography, Spacing, Shadows } from '@/theme';

interface TabItem {
  id: string;
  label: string;
  icon: React.ReactNode;
}

interface TabNavigationProps {
  tabs: TabItem[];
  activeTabId: string;
  onTabPress: (tabId: string) => void;
  backgroundColor?: string;
}

export const TabNavigation: React.FC<TabNavigationProps> = ({
  tabs,
  activeTabId,
  onTabPress,
  backgroundColor = 'rgba(255, 251, 248, 0.8)',
}) => {
  const insets = useSafeAreaInsets();

  const styles = StyleSheet.create({
    container: {
      position: 'absolute',
      bottom: 0,
      left: 0,
      right: 0,
      ...Shadows.strong,
    },
    blurContainer: {
      paddingBottom: insets.bottom,
      paddingHorizontal: Spacing.sm,
      paddingTop: Spacing.sm,
      backgroundColor,
      borderTopColor: 'rgba(255, 255, 255, 0.35)',
      borderTopWidth: 1,
      flexDirection: 'row',
      justifyContent: 'space-around',
      alignItems: 'center',
    },
    tabButton: {
      flex: 1,
      height: Spacing.tabBarHeight - insets.bottom,
      justifyContent: 'center',
      alignItems: 'center',
      paddingVertical: Spacing.sm,
      borderRadius: Spacing.md,
      marginHorizontal: Spacing.xs,
    },
    activeTabButton: {
      backgroundColor: 'rgba(230, 126, 91, 0.15)',
    },
    tabLabel: {
      ...Typography.labelSmall,
      color: Colors.textSecondary,
      marginTop: Spacing.xs,
      textAlign: 'center',
    },
    activeTabLabel: {
      color: Colors.primary,
      fontWeight: '600',
    },
    tabContent: {
      alignItems: 'center',
    },
    icon: {
      width: 24,
      height: 24,
    },
  });

  return (
    <View style={styles.container}>
      <BlurView intensity={40}>
        <View style={styles.blurContainer}>
          {tabs.map((tab) => (
            <TouchableOpacity
              key={tab.id}
              style={[
                styles.tabButton,
                activeTabId === tab.id && styles.activeTabButton,
              ]}
              onPress={() => onTabPress(tab.id)}
              activeOpacity={0.6}
            >
              <View style={styles.tabContent}>
                <View style={styles.icon}>{tab.icon}</View>
                <Text
                  style={[
                    styles.tabLabel,
                    activeTabId === tab.id && styles.activeTabLabel,
                  ]}
                  numberOfLines={1}
                >
                  {tab.label}
                </Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>
      </BlurView>
    </View>
  );
};

export default TabNavigation;
