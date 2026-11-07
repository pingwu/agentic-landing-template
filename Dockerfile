# PING AI Services - Production Dockerfile
# Multi-stage build for Next.js with standalone output
# Runs on any container host

# Stage 1: Build the application
FROM node:22-alpine AS builder
WORKDIR /app

# Copy package files first for better layer caching
COPY package.json package-lock.json* ./

# Install all dependencies (including devDependencies for build)
RUN npm ci

# Copy source files after dependencies are installed
COPY . .

# Disable Next.js telemetry during build
ENV NEXT_TELEMETRY_DISABLED=1

# Build the application
RUN npm run build

# Stage 2: Production image
FROM node:22-alpine AS runner
WORKDIR /app

# Image metadata
LABEL org.opencontainers.image.title="Agentic Landing Template"
LABEL org.opencontainers.image.description="Next.js landing page template for AI-assisted development"
LABEL org.opencontainers.image.version="1.0.0"

# Set production environment
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Create non-root user for security
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Copy public assets
COPY --from=builder /app/public ./public

# Copy standalone build output
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Switch to non-root user
USER nextjs

# Expose port 3000
EXPOSE 3000

# Listen on all interfaces inside the container
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Start the application
CMD ["node", "server.js"]
