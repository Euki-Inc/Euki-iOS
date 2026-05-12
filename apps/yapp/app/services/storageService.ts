/**
 * Local storage service using AsyncStorage
 * Handles app preferences and local data persistence
 */

import AsyncStorage from '@react-native-async-storage/async-storage';

const STORAGE_KEYS = {
  USER_NAME: '@lapina_user_name',
  USER_PREFERENCES: '@lapina_user_preferences',
  CYCLE_DATA: '@lapina_cycle_data',
  SYMPTOMS_DATA: '@lapina_symptoms_data',
  PREGNANCY_DATA: '@lapina_pregnancy_data',
  MOOD_DATA: '@lapina_mood_data',
  LANGUAGE: '@lapina_language',
  NOTIFICATIONS_ENABLED: '@lapina_notifications_enabled',
  NOTIFICATION_TIME: '@lapina_notification_time',
  THEME: '@lapina_theme',
  ONBOARDING_COMPLETED: '@lapina_onboarding_completed',
  SYNC_TIMESTAMP: '@lapina_sync_timestamp',
};

/**
 * Generic get item from storage
 */
export const getItem = async <T = any>(key: string, defaultValue?: T): Promise<T | null> => {
  try {
    const item = await AsyncStorage.getItem(key);
    if (item === null) return defaultValue ?? null;
    return JSON.parse(item) as T;
  } catch (error) {
    console.error(`Error reading from storage key ${key}:`, error);
    return defaultValue ?? null;
  }
};

/**
 * Generic set item in storage
 */
export const setItem = async <T = any>(key: string, value: T): Promise<void> => {
  try {
    await AsyncStorage.setItem(key, JSON.stringify(value));
  } catch (error) {
    console.error(`Error writing to storage key ${key}:`, error);
  }
};

/**
 * Remove item from storage
 */
export const removeItem = async (key: string): Promise<void> => {
  try {
    await AsyncStorage.removeItem(key);
  } catch (error) {
    console.error(`Error removing storage key ${key}:`, error);
  }
};

/**
 * Clear all storage
 */
export const clearAll = async (): Promise<void> => {
  try {
    await AsyncStorage.clear();
  } catch (error) {
    console.error('Error clearing storage:', error);
  }
};

// User preferences
export const getUserName = async (): Promise<string | null> => {
  return getItem<string>(STORAGE_KEYS.USER_NAME);
};

export const setUserName = async (name: string): Promise<void> => {
  return setItem(STORAGE_KEYS.USER_NAME, name);
};

export const getUserPreferences = async () => {
  return getItem(STORAGE_KEYS.USER_PREFERENCES, {});
};

export const setUserPreferences = async (preferences: Record<string, any>): Promise<void> => {
  return setItem(STORAGE_KEYS.USER_PREFERENCES, preferences);
};

// Language preference
export const getLanguage = async (): Promise<string | null> => {
  return getItem<string>(STORAGE_KEYS.LANGUAGE);
};

export const setLanguage = async (language: string): Promise<void> => {
  return setItem(STORAGE_KEYS.LANGUAGE, language);
};

// Cycle data
export const getCycleData = async () => {
  return getItem(STORAGE_KEYS.CYCLE_DATA, []);
};

export const setCycleData = async (data: any): Promise<void> => {
  return setItem(STORAGE_KEYS.CYCLE_DATA, data);
};

// Symptoms data
export const getSymptomsData = async () => {
  return getItem(STORAGE_KEYS.SYMPTOMS_DATA, []);
};

export const setSymptomsData = async (data: any): Promise<void> => {
  return setItem(STORAGE_KEYS.SYMPTOMS_DATA, data);
};

// Pregnancy data
export const getPregnancyData = async () => {
  return getItem(STORAGE_KEYS.PREGNANCY_DATA, null);
};

export const setPregnancyData = async (data: any): Promise<void> => {
  return setItem(STORAGE_KEYS.PREGNANCY_DATA, data);
};

export const clearPregnancyData = async (): Promise<void> => {
  return removeItem(STORAGE_KEYS.PREGNANCY_DATA);
};

// Mood data
export const getMoodData = async () => {
  return getItem(STORAGE_KEYS.MOOD_DATA, []);
};

export const setMoodData = async (data: any): Promise<void> => {
  return setItem(STORAGE_KEYS.MOOD_DATA, data);
};

// Notifications
export const getNotificationsEnabled = async (): Promise<boolean> => {
  return getItem(STORAGE_KEYS.NOTIFICATIONS_ENABLED, true);
};

export const setNotificationsEnabled = async (enabled: boolean): Promise<void> => {
  return setItem(STORAGE_KEYS.NOTIFICATIONS_ENABLED, enabled);
};

export const getNotificationTime = async (): Promise<string | null> => {
  return getItem<string>(STORAGE_KEYS.NOTIFICATION_TIME);
};

export const setNotificationTime = async (time: string): Promise<void> => {
  return setItem(STORAGE_KEYS.NOTIFICATION_TIME, time);
};

// Onboarding
export const getOnboardingCompleted = async (): Promise<boolean> => {
  return getItem(STORAGE_KEYS.ONBOARDING_COMPLETED, false);
};

export const setOnboardingCompleted = async (completed: boolean): Promise<void> => {
  return setItem(STORAGE_KEYS.ONBOARDING_COMPLETED, completed);
};

// Sync tracking
export const getLastSyncTimestamp = async (): Promise<number | null> => {
  return getItem<number>(STORAGE_KEYS.SYNC_TIMESTAMP);
};

export const setLastSyncTimestamp = async (): Promise<void> => {
  return setItem(STORAGE_KEYS.SYNC_TIMESTAMP, Date.now());
};

export default {
  getItem,
  setItem,
  removeItem,
  clearAll,
  getUserName,
  setUserName,
  getCycleData,
  setSyncleData: setCycleData,
  getSymptomsData,
  setSymptomsData,
  getPregnancyData,
  setPregnancyData,
  getMoodData,
  setMoodData,
  getLanguage,
  setLanguage,
  getNotificationsEnabled,
  setNotificationsEnabled,
  getOnboardingCompleted,
  setOnboardingCompleted,
};
