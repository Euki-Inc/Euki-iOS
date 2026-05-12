/**
 * i18n configuration for La Piña app
 * Supports Spanish (Mexico) and English
 */

import I18n from 'i18n-js';
import { NativeModules, Platform } from 'react-native';
import * as Localization from 'expo-localization';

// Import localization files
import esMX from './es-MX.json';
import en from './en.json';

// Set up translations
I18n.translations = {
  'es-MX': esMX,
  'es': esMX,
  'en': en,
  'en-US': en,
};

// Set fallback to English
I18n.fallbacks = {
  'es-MX': 'es',
  'es': 'en',
  'en-US': 'en',
};

// Determine device language
const getDeviceLanguage = (): string => {
  let deviceLanguage = Platform.OS === 'ios'
    ? NativeModules.SettingsManager?.settings?.AppleLanguages?.[0] ||
      Localization.locale
    : Localization.locale;

  // Normalize language codes
  if (deviceLanguage.startsWith('es')) {
    return 'es-MX';
  }

  return 'en';
};

// Initialize i18n
I18n.locale = getDeviceLanguage();
I18n.enableFallback = true;
I18n.isRTL = false;

/**
 * Get translation with interpolation support
 */
export const t = (key: string, params?: Record<string, any>): string => {
  try {
    return I18n.t(key, params);
  } catch (error) {
    console.warn(`Translation missing for key: ${key}`);
    return key;
  }
};

/**
 * Change app language
 */
export const setLanguage = (languageCode: string): void => {
  const supportedLanguages = ['es-MX', 'es', 'en', 'en-US'];

  if (supportedLanguages.includes(languageCode)) {
    I18n.locale = languageCode;
  } else {
    console.warn(`Language ${languageCode} not supported`);
  }
};

/**
 * Get current language
 */
export const getLanguage = (): string => {
  return I18n.locale;
};

/**
 * Get supported languages
 */
export const getSupportedLanguages = (): { code: string; name: string }[] => {
  return [
    { code: 'es-MX', name: 'Español (México)' },
    { code: 'en', name: 'English' },
  ];
};

/**
 * Format date based on current locale
 */
export const formatDate = (date: Date, format?: string): string => {
  const locale = I18n.locale.includes('es') ? 'es-MX' : 'en-US';

  return new Intl.DateTimeFormat(locale, {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date);
};

/**
 * Format number based on current locale
 */
export const formatNumber = (num: number, decimals?: number): string => {
  const locale = I18n.locale.includes('es') ? 'es-MX' : 'en-US';

  return new Intl.NumberFormat(locale, {
    minimumFractionDigits: decimals ?? 0,
    maximumFractionDigits: decimals ?? 2,
  }).format(num);
};

export default I18n;
