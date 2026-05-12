import { NextResponse } from 'next/server'

export const dynamic = 'force-dynamic'

/**
 * Health check endpoint for monitoring and load balancers
 * GET /api/health
 */
export async function GET() {
  const healthCheck = {
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
    version: process.env.npm_package_version || '0.1.0',
    checks: {
      database: 'not_implemented', // Add Supabase check when ready
      cache: 'not_implemented', // Add Redis check if using
      external_apis: 'not_implemented', // Add third-party API checks
    },
  }

  // Check if environment variables are set (basic validation)
  const requiredEnvVars = ['NEXT_PUBLIC_BASE_URL']
  const missingEnvVars = requiredEnvVars.filter(
    (varName) => !process.env[varName]
  )

  if (missingEnvVars.length > 0) {
    return NextResponse.json(
      {
        ...healthCheck,
        status: 'warning',
        warnings: [`Missing environment variables: ${missingEnvVars.join(', ')}`],
      },
      { status: 200 } // Still return 200 for load balancer
    )
  }

  return NextResponse.json(healthCheck, {
    status: 200,
    headers: {
      'Cache-Control': 'no-store, max-age=0',
    },
  })
}
