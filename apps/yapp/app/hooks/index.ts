/**
 * Export all custom hooks
 */

export { useLocalization } from './useLocalization';
export { useAppState } from './useAppState';

export default {
  useLocalization: () => require('./useLocalization').useLocalization(),
  useAppState: () => require('./useAppState').useAppState(),
};
