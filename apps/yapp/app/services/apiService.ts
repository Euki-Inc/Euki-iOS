/**
 * API service for La Piña app
 * Handles all HTTP requests to backend services
 */

import { supabase } from './supabaseClient';

interface ApiResponse<T = any> {
  data: T | null;
  error: string | null;
  status: number;
}

/**
 * Cycle Management APIs
 */
export const cycleAPI = {
  /**
   * Log period entry
   */
  logPeriod: async (date: string, notes?: string) => {
    try {
      const { data, error } = await supabase.from('cycle_logs').insert([
        {
          date,
          type: 'menstrual',
          notes,
          created_at: new Date().toISOString(),
        },
      ]);

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Get cycle history
   */
  getCycleHistory: async (userId: string, limit = 12) => {
    try {
      const { data, error } = await supabase
        .from('cycle_logs')
        .select('*')
        .eq('user_id', userId)
        .order('date', { ascending: false })
        .limit(limit);

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Predict next period
   */
  predictNextPeriod: async (userId: string) => {
    try {
      const { data, error } = await supabase
        .rpc('predict_next_period', { user_id: userId });

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },
};

/**
 * Symptoms Management APIs
 */
export const symptomsAPI = {
  /**
   * Log symptom
   */
  logSymptom: async (symptom: string, severity: string, date: string, notes?: string) => {
    try {
      const { data, error } = await supabase.from('symptoms').insert([
        {
          symptom,
          severity,
          date,
          notes,
          created_at: new Date().toISOString(),
        },
      ]);

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Get symptoms history
   */
  getSymptomsHistory: async (userId: string, startDate?: string, endDate?: string) => {
    try {
      let query = supabase
        .from('symptoms')
        .select('*')
        .eq('user_id', userId);

      if (startDate) {
        query = query.gte('date', startDate);
      }

      if (endDate) {
        query = query.lte('date', endDate);
      }

      const { data, error } = await query.order('date', { ascending: false });

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },
};

/**
 * Pregnancy Management APIs
 */
export const pregnancyAPI = {
  /**
   * Start pregnancy tracking
   */
  startTracking: async (dueDate: string) => {
    try {
      const { data, error } = await supabase.from('pregnancy_tracking').insert([
        {
          due_date: dueDate,
          started_at: new Date().toISOString(),
        },
      ]);

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Get pregnancy data
   */
  getPregnancyData: async (userId: string) => {
    try {
      const { data, error } = await supabase
        .from('pregnancy_tracking')
        .select('*')
        .eq('user_id', userId)
        .single();

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Stop pregnancy tracking
   */
  stopTracking: async (userId: string) => {
    try {
      const { data, error } = await supabase
        .from('pregnancy_tracking')
        .delete()
        .eq('user_id', userId);

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },
};

/**
 * Blog/Content APIs
 */
export const blogAPI = {
  /**
   * Get articles
   */
  getArticles: async (category?: string, limit = 20, offset = 0) => {
    try {
      let query = supabase
        .from('articles')
        .select('*')
        .eq('published', true)
        .order('published_at', { ascending: false })
        .range(offset, offset + limit);

      if (category) {
        query = query.eq('category', category);
      }

      const { data, error } = await query;

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Get article by ID
   */
  getArticle: async (id: string) => {
    try {
      const { data, error } = await supabase
        .from('articles')
        .select('*')
        .eq('id', id)
        .single();

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Search articles
   */
  searchArticles: async (query: string) => {
    try {
      const { data, error } = await supabase
        .from('articles')
        .select('*')
        .or(`title.ilike.%${query}%, content.ilike.%${query}%`)
        .eq('published', true)
        .limit(20);

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },
};

/**
 * Insights/Analytics APIs
 */
export const insightsAPI = {
  /**
   * Get cycle insights
   */
  getCycleInsights: async (userId: string) => {
    try {
      const { data, error } = await supabase
        .rpc('get_cycle_insights', { user_id: userId });

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Get symptom trends
   */
  getSymptomTrends: async (userId: string, days = 90) => {
    try {
      const { data, error } = await supabase
        .rpc('get_symptom_trends', { user_id: userId, days });

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },

  /**
   * Get mood trends
   */
  getMoodTrends: async (userId: string, days = 90) => {
    try {
      const { data, error } = await supabase
        .rpc('get_mood_trends', { user_id: userId, days });

      return { data, error };
    } catch (error: any) {
      return { data: null, error: error.message };
    }
  },
};

export default {
  cycleAPI,
  symptomsAPI,
  pregnancyAPI,
  blogAPI,
  insightsAPI,
};
