# Multi-stage Status-Page Dockerfile for EKS Deployment
# Optimized for production with security and performance best practices

# Frontend build stage
FROM node:18-alpine AS frontend

WORKDIR /frontend

# Copy package files first for better layer caching
COPY statuspage/project-static/package.json statuspage/project-static/yarn.lock ./

# Install dependencies
#RUN yarn install --frozen-lockfile --production=false
RUN yarn install --production=false


# Copy source files
COPY statuspage/project-static/ ./

# Build frontend assets
ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN yarn bundle

# Main application stage
FROM python:3.11-slim AS production

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Create non-root user for security
RUN groupadd -r statuspage && useradd -r -g statuspage statuspage

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Set working directory
WORKDIR /app

#ENV PYTHONPATH=/app/statuspage:$PYTHONPATH \
    #STATUS_PAGE_CONFIGURATION=statuspage.configuration

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Copy application code
#COPY statuspage/ ./statuspage/
#COPY contrib/ ./contrib/
COPY . .
COPY statuspage/project-static/dist/ /app/static/
# Make sure configuration.py is included
COPY statuspage/statuspage/configuration.py ./statuspage/statuspage/
#COPY statuspage/manage.py .
# Copy built frontend assets from frontend stage
COPY --from=frontend /frontend/dist/ ./statuspage/project-static/dist/
COPY --from=frontend /frontend/img/ ./statuspage/project-static/img/

# Create necessary directories with proper permissions
RUN mkdir -p /app/statuspage/static /app/statuspage/media \
    && chown -R statuspage:statuspage /app

# Switch to non-root user
USER statuspage

# Expose port
EXPOSE 8000

# Health check for Kubernetes probes
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/api/health/ || exit 1

# Default command
#CMD ["gunicorn", "--chdir", "/app/statuspage", "--bind", "0.0.0.0:8000", "--workers", "3", "--worker-class", "sync", "--worker-connections", "1000", "--max-requests", "1000", "--max-requests-jitter", "100", "--timeout", "30", "--keep-alive", "2", "--access-logfile", "-", "--error-logfile", "-", "statuspage.wsgi:application"]

CMD ["gunicorn", "--chdir", "/app/statuspage", "--bind", "0.0.0.0:8000", "--workers", "3", "statuspage.wsgi:application"]
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "statuspage.wsgi:application"]
