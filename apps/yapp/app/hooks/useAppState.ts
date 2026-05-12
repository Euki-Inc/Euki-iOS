/**
 * Custom hook for managing app state
 */

import { useEffect, useState } from 'react';
import * as storageService from '@/services/storageService';
import { UserPreferences } from '@/types';

const DEFAULT_PREFERENCES: UserPreferences = {
  language: 'es-MX',
  theme: 'light',
  notificationsEnabled: true,
  periodReminderEnabled: true,
  ovulationReminderEnabled: true,
  symptomReminderEnabled: true,
  dailyTipsEnabled: true,
};

export const useAppState = () => {
  const [userName, setUserNameState] = useState<string | null>(null);
  const [preferences, setPreferencesState] = useState<UserPreferences>(DEFAULT_PREFERENCES);
  const [isLoading, setIsLoading] = useState(true);
  const [onboardingCompleted, setOnboardingCompletedState] = useState(false);

  // Load app state on mount
  useEffect(() => {
    const loadAppState = async () => {
      try {
        const [name, prefs, onboarding] = await Promise.all([
          storageService.getUserName(),
          storageService.getUserPreferences(),
          storageService.getOnboardingCompleted(),
        ]);

        if (name) setUserNameState(name);
        if (prefs) setPreferencesState({ ...DEFAULT_PREFERENCES, ...prefs });
        setOnboardingCompletedState(onboarding);
      } catch (error) {
        console.error('Error loading app state:', error);
      } finally {
        setIsLoading(false);
      }
    };

    loadAppState();
  }, []);

  const setUserName = async (name: string) => {
    try {
      setUserNameState(name);
      await storageService.setUserName(name);
    } catch (error) {
      console.error('Error setting user name:', error);
    }
  };

  const updatePreferences = async (newPreferences: Partial<UserPreferences>) => {
    try {
      const updated = { ...preferences, ...newPreferences };
      setPreferencesState(updated);
      await storageService.setUserPreferences(updated);
    } catch (error) {
      console.error('Error updating preferences:', error);
    }
  };

  const setOnboardingCompleted = async (completed: boolean) => {
    try {
      setOnboardingCompletedState(completed);
      await storageService.setOnboardingCompleted(completed);
    } catch (error) {
      console.error('Error setting onboarding completed:', error);
    }
  };

  return {
    userName,
    setUserName,
    preferences,
    updatePreferences,
    isLoading,
    onboardingCompleted,
    setOnboardingCompleted,
  };
};

export default useAppState;
