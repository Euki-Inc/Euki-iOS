/**
 * Date utility functions for La Piña
 */

import { formatDistanceToNow, addDays, differenceInDays, format } from 'date-fns';
import { es, enUS } from 'date-fns/locale';

/**
 * Get locale based on language code
 */
const getLocale = (lang: string) => {
  return lang.includes('es') ? es : enUS;
};

/**
 * Format date as relative time (e.g., "2 days ago")
 */
export const formatRelativeTime = (date: Date | string, language: string = 'en'): string => {
  const dateObj = typeof date === 'string' ? new Date(date) : date;
  return formatDistanceToNow(dateObj, {
    addSuffix: true,
    locale: getLocale(language),
  });
};

/**
 * Add days to a date
 */
export const addDaysToDate = (date: Date | string, days: number): Date => {
  const dateObj = typeof date === 'string' ? new Date(date) : date;
  return addDays(dateObj, days);
};

/**
 * Calculate difference in days between two dates
 */
export const getDaysBetween = (date1: Date | string, date2: Date | string): number => {
  const d1 = typeof date1 === 'string' ? new Date(date1) : date1;
  const d2 = typeof date2 === 'string' ? new Date(date2) : date2;
  return differenceInDays(d2, d1);
};

/**
 * Format date to readable string
 */
export const formatDateReadable = (
  date: Date | string,
  dateFormat: string = 'PPP',
  language: string = 'en'
): string => {
  const dateObj = typeof date === 'string' ? new Date(date) : date;
  return format(dateObj, dateFormat, { locale: getLocale(language) });
};

/**
 * Get current date as ISO string
 */
export const getTodayISO = (): string => {
  return new Date().toISOString().split('T')[0];
};

/**
 * Parse ISO date string
 */
export const parseISODate = (dateString: string): Date => {
  return new Date(dateString);
};

/**
 * Calculate cycle day
 */
export const calculateCycleDay = (lastPeriodDate: string): number => {
  const lastPeriod = new Date(lastPeriodDate);
  const today = new Date();
  const days = differenceInDays(today, lastPeriod);
  return Math.max(1, days + 1);
};

/**
 * Predict next period date
 */
export const predictNextPeriodDate = (
  lastPeriodDate: string,
  cycleLength: number = 28
): string => {
  const lastPeriod = new Date(lastPeriodDate);
  const nextPeriod = addDays(lastPeriod, cycleLength);
  return nextPeriod.toISOString().split('T')[0];
};

/**
 * Calculate ovulation date (typically 14 days before next period)
 */
export const calculateOvulationDate = (
  lastPeriodDate: string,
  cycleLength: number = 28
): string => {
  const nextPeriod = predictNextPeriodDate(lastPeriodDate, cycleLength);
  const ovulation = addDays(new Date(nextPeriod), -14);
  return ovulation.toISOString().split('T')[0];
};

/**
 * Calculate fertility window (typically 5 days before ovulation to ovulation day)
 */
export const calculateFertilityWindow = (
  lastPeriodDate: string,
  cycleLength: number = 28
): { start: string; end: string } => {
  const ovulationDate = calculateOvulationDate(lastPeriodDate, cycleLength);
  const ovulation = new Date(ovulationDate);
  const windowStart = addDays(ovulation, -5);
  const windowEnd = ovulation;

  return {
    start: windowStart.toISOString().split('T')[0],
    end: windowEnd.toISOString().split('T')[0],
  };
};

/**
 * Check if date is within fertility window
 */
export const isInFertilityWindow = (
  date: string,
  lastPeriodDate: string,
  cycleLength: number = 28
): boolean => {
  const { start, end } = calculateFertilityWindow(lastPeriodDate, cycleLength);
  const checkDate = parseISODate(date);
  const windowStart = parseISODate(start);
  const windowEnd = parseISODate(end);

  return checkDate >= windowStart && checkDate <= windowEnd;
};

/**
 * Determine cycle phase
 */
export const determineCyclePhase = (
  cycleDay: number,
  cycleLength: number = 28,
  periodLength: number = 5
): 'menstrual' | 'follicular' | 'ovulation' | 'luteal' => {
  if (cycleDay <= periodLength) {
    return 'menstrual';
  }

  const ovulationDay = Math.floor(cycleLength / 2);
  if (cycleDay <= ovulationDay) {
    return 'follicular';
  }

  if (cycleDay <= ovulationDay + 2) {
    return 'ovulation';
  }

  return 'luteal';
};

export default {
  formatRelativeTime,
  addDaysToDate,
  getDaysBetween,
  formatDateReadable,
  getTodayISO,
  parseISODate,
  calculateCycleDay,
  predictNextPeriodDate,
  calculateOvulationDate,
  calculateFertilityWindow,
  isInFertilityWindow,
  determineCyclePhase,
};
