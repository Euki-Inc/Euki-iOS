'use client'

import { useState } from 'react'
import { SpiralHeader } from '@/components/SpiralHeader'
import { PaywallCard } from '@/components/PaywallCard'
import { mockBlogPosts, premiumFeatures } from '@/lib/data'

const CATEGORIES = ['All', 'Luxury Wellness', 'Intimacy', 'Mental Health', 'Fitness', 'Gourmet']

export default function BlogPage() {
  const [selectedCategory, setSelectedCategory] = useState('All')
  const [expandedPost, setExpandedPost] = useState<number | null>(null)

  const filteredPosts = mockBlogPosts.filter((post) => {
    if (selectedCategory === 'All') return true
    return post.category.replace('_', ' ').toLowerCase().includes(selectedCategory.toLowerCase())
  })

  return (
    <div className="w-full">
      <SpiralHeader title="Blog & Wellness" subtitle="Expert content and lifestyle tips" />

      <div className="px-4 md:px-6 py-6 max-w-4xl mx-auto">
        {/* Premium Upsell */}
        <PaywallCard features={premiumFeatures} />

        {/* Category Filter */}
        <div className="mb-8 overflow-x-auto scrollbar-hide">
          <div className="flex gap-2 pb-2">
            {CATEGORIES.map((category) => (
              <button
                key={category}
                onClick={() => setSelectedCategory(category)}
                className={`whitespace-nowrap px-4 py-2 rounded-full text-sm font-medium transition-all ${
                  selectedCategory === category
                    ? 'bg-pina-pink text-white shadow-soft'
                    : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'
                }`}
              >
                {category}
              </button>
            ))}
          </div>
        </div>

        {/* Blog Posts Grid */}
        <div className="space-y-4 mb-8">
          {filteredPosts.map((post) => (
            <div
              key={post.id}
              className="card hover:shadow-medium cursor-pointer transition-all hover:border-pina-pink border"
              onClick={() => setExpandedPost(expandedPost === post.id ? null : post.id)}
            >
              {/* Post Header */}
              <div className="flex justify-between items-start mb-3">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    <span className="badge badge-primary text-xs">
                      {post.category.replace('_', ' ')}
                    </span>
                  </div>
                  <h3 className="text-lg font-bold text-neutral-900">{post.title}</h3>
                </div>
              </div>

              {/* Excerpt */}
              <p className="text-sm text-neutral-600 mb-3">{post.excerpt}</p>

              {/* Expanded Content */}
              {expandedPost === post.id && (
                <div className="mt-4 pt-4 border-t border-neutral-200">
                  <p className="text-sm text-neutral-700 mb-4">
                    This premium article provides in-depth insights on wellness and self-care practices
                    tailored for women throughout their menstrual cycle.
                  </p>

                  {/* Affiliate Products */}
                  {post.affiliate_products.length > 0 && (
                    <div className="mb-4">
                      <h4 className="text-sm font-semibold text-neutral-900 mb-3">Featured Products</h4>
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                        {post.affiliate_products.map((product) => (
                          <a
                            key={product.name}
                            href={product.link}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="bg-gradient-to-br from-yellow-50 to-orange-50 rounded-lg p-3 hover:shadow-soft transition-all"
                          >
                            <p className="font-medium text-sm text-neutral-900">{product.name}</p>
                            <p className="text-xs text-pina-pink font-semibold mt-1">{product.price}</p>
                          </a>
                        ))}
                      </div>
                    </div>
                  )}

                  <div className="flex gap-2">
                    <button className="btn-primary flex-1">Read Full Article</button>
                    {post.affiliate_products.length > 0 && (
                      <a
                        href={post.affiliate_products[0]?.link}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="btn-secondary flex-1"
                      >
                        Shop Now
                      </a>
                    )}
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>

        {/* Featured Content */}
        <div className="mb-8">
          <h3 className="text-xl font-bold text-neutral-900 mb-4">Featured Collection</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="card-gradient gradient-sunset min-h-48 rounded-lg p-6 text-white flex flex-col justify-end">
              <h4 className="text-xl font-bold">Luxury Self-Care</h4>
              <p className="text-sm opacity-90">Premium products for your wellness journey</p>
            </div>
            <div className="card-gradient gradient-ocean min-h-48 rounded-lg p-6 text-white flex flex-col justify-end">
              <h4 className="text-xl font-bold">Cycle Syncing Guide</h4>
              <p className="text-sm opacity-90">Optimize your life based on your cycle</p>
            </div>
          </div>
        </div>

        {/* Newsletter Signup */}
        <div className="card bg-gradient-to-br from-purple-50 to-pink-50 mb-8">
          <h3 className="text-lg font-bold text-neutral-900 mb-2">Stay Updated</h3>
          <p className="text-sm text-neutral-600 mb-4">
            Get weekly wellness tips, expert advice, and exclusive product recommendations.
          </p>
          <div className="flex gap-2">
            <input
              type="email"
              placeholder="Enter your email"
              className="flex-1 px-4 py-3 rounded-lg border border-neutral-200 text-sm focus:ring-2 focus:ring-pina-pink focus:border-transparent"
            />
            <button className="btn-primary">Subscribe</button>
          </div>
        </div>

        {/* Resources */}
        <div className="space-y-4">
          <h3 className="text-xl font-bold text-neutral-900">Resources</h3>
          {[
            {
              title: 'AR Flipbook Experience',
              description: 'Immersive wellness magazine with augmented reality',
              icon: '🔮',
            },
            {
              title: 'Expert Interviews',
              description: 'In-depth conversations with gynecologists and wellness experts',
              icon: '👥',
            },
            {
              title: 'Product Reviews',
              description: 'Honest reviews of wellness and health products',
              icon: '⭐',
            },
          ].map((resource) => (
            <div key={resource.title} className="card hover:shadow-soft cursor-pointer transition-all">
              <div className="flex items-start gap-3">
                <span className="text-2xl">{resource.icon}</span>
                <div>
                  <h4 className="font-semibold text-neutral-900">{resource.title}</h4>
                  <p className="text-sm text-neutral-600 mt-1">{resource.description}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
