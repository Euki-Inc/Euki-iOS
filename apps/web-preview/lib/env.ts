export function getEnv() {
  return {
    supabaseUrl: process.env.NEXT_PUBLIC_SUPABASE_URL || '',
    supabaseAnonKey: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '',
    stripePublicKey: process.env.NEXT_PUBLIC_STRIPE_PUBLIC_KEY || '',
    claudeApiKey: process.env.CLAUDE_API_KEY || '',
    apifyToken: process.env.APIFY_TOKEN || '',
  };
}

export const isDemoMode = () => {
  return !process.env.NEXT_PUBLIC_SUPABASE_URL;
};
