/**
 * Symptoms Screen for La Piña app
 */

import React, { useEffect, useState } from 'react';
import { View, StyleSheet, SafeAreaView, ScrollView } from 'react-native';
import { useLocalization } from '@/hooks/useLocalization';
import { Header, LoadingPlaceholder } from '@/components';
import { Colors, Spacing } from '@/theme';

interface SymptomsScreenProps {
  navigation?: any;
}

export const SymptomsScreen: React.FC<SymptomsScreenProps> = ({ navigation }) => {
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
  });

  if (isLoading) {
    return (
      <SafeAreaView style={styles.container}>
        <Header title={t('symptoms.title')} />
        <LoadingPlaceholder fullScreen />
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <Header title={t('symptoms.title')} />
      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Symptoms tracking content will be implemented here */}
      </ScrollView>
    </SafeAreaView>
  );
};

export default SymptomsScreen;
