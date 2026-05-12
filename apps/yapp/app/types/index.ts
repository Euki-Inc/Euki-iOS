/**
 * Type definitions for La Piña app
 */

/**
 * Cycle Phase Types
 */
export enum CyclePhase {
  MENSTRUAL = 'menstrual',
  FOLLICULAR = 'follicular',
  OVULATION = 'ovulation',
  LUTEAL = 'luteal',
}

/**
 * Fertility Status
 */
export enum FertilityStatus {
  FERTILE = 'fertile',
  NOT_FERTILE = 'not_fertile',
  HIGHLY_FERTILE = 'highly_fertile',
}

/**
 * Symptom Types
 */
export enum SymptomType {
  CRAMPS = 'cramps',
  BLOATING = 'bloating',
  BREAST_TENDERNESS = 'breast_tenderness',
  HEADACHE = 'headache',
  FATIGUE = 'fatigue',
  MOOD_SWINGS = 'mood_swings',
  ACNE = 'acne',
  BACK_PAIN = 'back_pain',
  NAUSEA = 'nausea',
  OTHER = 'other',
}

/**
 * Symptom Severity
 */
export enum SymptomSeverity {
  MILD = 'mild',
  MODERATE = 'moderate',
  SEVERE = 'severe',
}

/**
 * Mood Types
 */
export enum MoodType {
  HAPPY = 'happy',
  ENERGETIC = 'energetic',
  CALM = 'calm',
  STRESSED = 'stressed',
  TIRED = 'tired',
  ANXIOUS = 'anxious',
}

/**
 * User Profile
 */
export interface UserProfile {
  id: string;
  email: string;
  name: string;
  dateOfBirth?: string;
  cycleLength: number;
  periodLength: number;
  lastPeriodDate: string;
  createdAt: string;
  updatedAt: string;
}

/**
 * Cycle Log Entry
 */
export interface CycleLogEntry {
  id: string;
  userId: string;
  date: string;
  type: 'menstrual' | 'flow' | 'spotting';
  flowIntensity?: 'light' | 'medium' | 'heavy';
  notes?: string;
  createdAt: string;
  updatedAt: string;
}

/**
 * Symptom Log Entry
 */
export interface SymptomLogEntry {
  id: string;
  userId: string;
  date: string;
  symptom: SymptomType;
  severity: SymptomSeverity;
  notes?: string;
  createdAt: string;
  updatedAt: string;
}

/**
 * Mood Log Entry
 */
export interface MoodLogEntry {
  id: string;
  userId: string;
  date: string;
  mood: MoodType;
  intensity: number; // 1-10
  notes?: string;
  createdAt: string;
  updatedAt: string;
}

/**
 * Pregnancy Tracking
 */
export interface PregnancyTracking {
  id: string;
  userId: string;
  dueDate: string;
  weekNumber: number;
  startedAt: string;
  updatedAt: string;
}

/**
 * Cycle Prediction
 */
export interface CyclePrediction {
  nextPeriodDate: string;
  fertilityWindowStart: string;
  fertilityWindowEnd: string;
  ovulationDate: string;
  currentPhase: CyclePhase;
  daysIntoCycle: number;
  cycleLength: number;
}

/**
 * Blog Article
 */
export interface Article {
  id: string;
  title: string;
  slug: string;
  excerpt: string;
  content: string;
  category: string;
  author: string;
  imageUrl?: string;
  publishedAt: string;
  updatedAt: string;
  readingTimeMinutes: number;
}

/**
 * Cycle Insights
 */
export interface CycleInsights {
  averageCycleLength: number;
  averagePeriodLength: number;
  mostCommonSymptoms: Array<{
    symptom: SymptomType;
    frequency: number;
  }>;
  predictedNextPeriod: string;
  cycleRegularity: 'regular' | 'irregular' | 'varies';
}

/**
 * App User Preferences
 */
export interface UserPreferences {
  language: 'es-MX' | 'en';
  theme: 'light' | 'dark' | 'auto';
  notificationsEnabled: boolean;
  notificationTime?: string;
  periodReminderEnabled: boolean;
  ovulationReminderEnabled: boolean;
  symptomReminderEnabled: boolean;
  dailyTipsEnabled: boolean;
}

/**
 * Navigation Props Types
 */
export interface RootStackParamList {
  Home: undefined;
  Cycle: undefined;
  Symptoms: undefined;
  Pregnancy: undefined;
  Blog: undefined;
  Insights: undefined;
  Settings: undefined;
  ArticleDetail: { articleId: string };
}

/**
 * API Response Types
 */
export interface ApiResponse<T = any> {
  data: T | null;
  error: string | null;
  status: number;
}

/**
 * Pagination
 */
export interface PaginationParams {
  page: number;
  limit: number;
  offset?: number;
}

/**
 * Date Range
 */
export interface DateRange {
  startDate: string;
  endDate: string;
}

export default {
  CyclePhase,
  FertilityStatus,
  SymptomType,
  SymptomSeverity,
  MoodType,
};
