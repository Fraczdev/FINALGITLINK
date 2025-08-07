/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  images: {
    unoptimized: true,
  },
  // Ensure static files are handled correctly
  assetPrefix: '/_next',
  experimental: {
    // Required for Cloudflare Workers
    runtime: 'edge',
  },
}

module.exports = nextConfig
