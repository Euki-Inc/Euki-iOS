/**
 * Main App component for La Piña
 * Entry point for the application
 */

import React, { useEffect } from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import * as SplashScreen from 'expo-splash-screen';
import { RootNavigator } from '@/navigation/RootNavigator';
import { useLocalization } from '@/hooks/useLocalization';
import { useAppState } from '@/hooks/useAppState';
import { Colors } from '@/theme';

// Keep the splash screen visible while we fetch resources
SplashScreen.preventAutoHideAsync().catch((_error) => {
  // Do nothing if the splash screen was already hidden
});

interface AppProps {
  skipOnboarding?: boolean;
}

export const App: React.FC<AppProps> = ({ skipOnboarding = false }) => {
  const { isLoading: localizationLoading } = useLocalization();
  const { isLoading: appStateLoading, onboardingCompleted } = useAppState();

  useEffect(() => {
    const prepare = async () => {
      try {
        // Perform any additional app initialization here
        // (fetch fonts, load data, etc.)

        // Simulate a small delay for better UX
        await new Promise((resolve) => setTimeout(resolve, 500));
      } catch (error) {
        console.warn('Error during app preparation:', error);
      } finally {
        // Hide splash screen
        await SplashScreen.hideAsync();
      }
    };

    if (!localizationLoading && !appStateLoading) {
      prepare();
    }
  }, [localizationLoading, appStateLoading]);

  // Show splash screen while loading
  if (localizationLoading || appStateLoading) {
    return null;
  }

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <SafeAreaProvider>
        <StatusBar
          barStyle="dark-content"
          backgroundColor={Colors.background}
          translucent={false}
        />
        <RootNavigator />
      </SafeAreaProvider>
    </GestureHandlerRootView>
  );
};

export default App;
