/**
 * Custom hook for localization
 */

import { useEffect, useState } from 'react';
import { getLanguage, setLanguage as setAppLanguage, t as translate } from '@/localization/i18n';
import * as storageService from '@/services/storageService';

export const useLocalization = () => {
  const [language, setLanguageState] = useState<string>(getLanguage());
  const [isLoading, setIsLoading] = useState(true);

  // Load language preference on mount
  useEffect(() => {
    const loadLanguage = async () => {
      try {
        const savedLanguage = await storageService.getLanguage();
        if (savedLanguage) {
          setAppLanguage(savedLanguage);
          setLanguageState(savedLanguage);
        }
      } catch (error) {
        console.error('Error loading language preference:', error);
      } finally {
        setIsLoading(false);
      }
    };

    loadLanguage();
  }, []);

  const t = (key: string, params?: Record<string, any>): string => {
    return translate(key, params);
  };

  const setLanguage = async (languageCode: string) => {
    try {
      setAppLanguage(languageCode);
      setLanguageState(languageCode);
      await storageService.setLanguage(languageCode);
    } catch (error) {
      console.error('Error setting language:', error);
    }
  };

  return {
    language,
    setLanguage,
    t,
    isLoading,
  };
};

export default useLocalization;
