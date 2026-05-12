/**
 * Root Navigation for La Piña app
 * Manages tab navigation between main screens
 */

import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { HomeScreen } from '@/screens/HomeScreen';
import { CycleScreen } from '@/screens/CycleScreen';
import { SymptomsScreen } from '@/screens/SymptomsScreen';
import { PregnancyScreen } from '@/screens/PregnancyScreen';
import { BlogScreen } from '@/screens/BlogScreen';
import { InsightsScreen } from '@/screens/InsightsScreen';
import { SettingsScreen } from '@/screens/SettingsScreen';
import { TabNavigation } from '@/components/TabNavigation';
import { useLocalization } from '@/hooks/useLocalization';
import { Colors } from '@/theme';

/**
 * Home Icon
 */
const HomeIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      borderRadius: 6,
      backgroundColor: Colors.primary,
    }}
  />
);

/**
 * Cycle Icon
 */
const CycleIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      borderRadius: 12,
      borderWidth: 2,
      borderColor: Colors.textSecondary,
    }}
  />
);

/**
 * Symptoms Icon
 */
const SymptomsIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      borderRadius: 4,
      backgroundColor: Colors.warning,
    }}
  />
);

/**
 * Pregnancy Icon
 */
const PregnancyIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      borderRadius: 12,
      backgroundColor: Colors.secondary,
    }}
  />
);

/**
 * Blog Icon
 */
const BlogIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      backgroundColor: Colors.accentVariant,
    }}
  />
);

/**
 * Insights Icon
 */
const InsightsIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      backgroundColor: Colors.primaryLight,
    }}
  />
);

/**
 * Settings Icon
 */
const SettingsIcon = () => (
  <View
    style={{
      width: 24,
      height: 24,
      backgroundColor: Colors.textTertiary,
    }}
  />
);

interface RootNavigatorProps {
  onNavigationReady?: () => void;
}

export const RootNavigator: React.FC<RootNavigatorProps> = ({ onNavigationReady }) => {
  const { t } = useLocalization();
  const [activeTab, setActiveTab] = useState('home');

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: Colors.background,
    },
    screenContainer: {
      flex: 1,
    },
  });

  const tabs = [
    { id: 'home', label: t('navigation.home'), icon: <HomeIcon /> },
    { id: 'cycle', label: t('navigation.cycle'), icon: <CycleIcon /> },
    { id: 'symptoms', label: t('navigation.symptoms'), icon: <SymptomsIcon /> },
    { id: 'pregnancy', label: t('navigation.pregnancy'), icon: <PregnancyIcon /> },
    { id: 'blog', label: t('navigation.blog'), icon: <BlogIcon /> },
    { id: 'insights', label: t('navigation.insights'), icon: <InsightsIcon /> },
    { id: 'settings', label: t('navigation.settings'), icon: <SettingsIcon /> },
  ];

  const renderScreen = () => {
    switch (activeTab) {
      case 'home':
        return <HomeScreen />;
      case 'cycle':
        return <CycleScreen />;
      case 'symptoms':
        return <SymptomsScreen />;
      case 'pregnancy':
        return <PregnancyScreen />;
      case 'blog':
        return <BlogScreen />;
      case 'insights':
        return <InsightsScreen />;
      case 'settings':
        return <SettingsScreen />;
      default:
        return <HomeScreen />;
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.screenContainer}>{renderScreen()}</View>
      <TabNavigation tabs={tabs} activeTabId={activeTab} onTabPress={setActiveTab} />
    </View>
  );
};

export default RootNavigator;
