/**
 * Jest setup file for test configuration
 */

import 'jest-expo/setup';

// Mock AsyncStorage
jest.mock('@react-native-async-storage/async-storage', () => ({
  getItem: jest.fn(),
  setItem: jest.fn(),
  removeItem: jest.fn(),
  clear: jest.fn(),
}));

// Mock Supabase
jest.mock('@supabase/supabase-js', () => ({
  createClient: jest.fn(() => ({
    auth: {
      getSession: jest.fn(),
      signInWithPassword: jest.fn(),
      signUp: jest.fn(),
      signOut: jest.fn(),
      resetPasswordForEmail: jest.fn(),
    },
    from: jest.fn(),
    rpc: jest.fn(),
  })),
}));

// Mock expo-localization
jest.mock('expo-localization', () => ({
  locale: 'en-US',
}));

// Suppress console errors in tests
global.console.error = jest.fn();
global.console.warn = jest.fn();
