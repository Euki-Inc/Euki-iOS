/**
 * Blog Screen for La Piña app
 */

import React, { useEffect, useState } from 'react';
import { View, StyleSheet, SafeAreaView, ScrollView } from 'react-native';
import { useLocalization } from '@/hooks/useLocalization';
import { Header, LoadingPlaceholder } from '@/components';
import { Colors, Spacing } from '@/theme';

interface BlogScreenProps {
  navigation?: any;
}

export const BlogScreen: React.FC<BlogScreenProps> = ({ navigation }) => {
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
        <Header title={t('blog.title')} />
        <LoadingPlaceholder fullScreen />
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <Header title={t('blog.title')} />
      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Blog content will be implemented here */}
      </ScrollView>
    </SafeAreaView>
  );
};

export default BlogScreen;
