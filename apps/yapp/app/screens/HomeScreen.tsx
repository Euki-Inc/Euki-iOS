/**
 * Home Screen for La Piña app
 */

import React, { useEffect, useState } from 'react';
import { View, StyleSheet, SafeAreaView, ScrollView } from 'react-native';
import { useLocalization } from '@/hooks/useLocalization';
import { Header, LoadingPlaceholder } from '@/components';
import { Colors, Spacing } from '@/theme';

interface HomeScreenProps {
  navigation?: any;
}

export const HomeScreen: React.FC<HomeScreenProps> = ({ navigation }) => {
  const { t } = useLocalization();
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    // Initialize screen
    setIsLoading(false);
  }, []);

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: Colors.background,
    },
    content: {
      flex: 1,
      padding: Spacing.screenPadding,
      paddingBottom: Spacing.tabBarHeight,
    },
    placeholder: {
      justifyContent: 'center',
      alignItems: 'center',
      flex: 1,
    },
  });

  if (isLoading) {
    return (
      <SafeAreaView style={styles.container}>
        <Header title={t('home.title')} />
        <LoadingPlaceholder fullScreen />
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <Header title={t('home.title')} />
      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Home screen content will be implemented here */}
      </ScrollView>
    </SafeAreaView>
  );
};

export default HomeScreen;
