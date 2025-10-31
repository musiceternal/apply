#!/bin/bash
set -e

echo "🎵 Music Eternal - Apply Initial Setup..."
echo "=========================================="
echo "⏱️  This runs ONCE on first container creation"
echo ""

# Copy .env if not exists
if [ ! -f .env ]; then
    echo "📋 Creating .env from .env.example..."
    cp .env.example .env
fi

# Install Composer dependencies
echo "📦 Installing Composer dependencies..."
composer install --no-interaction --prefer-dist --optimize-autoloader

# Generate app key
echo "🔑 Generating application key..."
php artisan key:generate --ansi --force

# Install NPM dependencies
echo "📦 Installing NPM dependencies..."
npm install

# Wait for database to be ready
echo "⏳ Waiting for PostgreSQL..."
echo "   (This may take 10-30s on first boot)"
MAX_RETRIES=60
RETRY_COUNT=0
until php artisan db:show 2>&1 | grep -q "pgsql"; do
    RETRY_COUNT=$((RETRY_COUNT + 1))
    if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
        echo ""
        echo "❌ PostgreSQL failed to become ready after ${MAX_RETRIES} attempts (2min timeout)"
        echo "   Checking connection details:"
        php artisan db:show || true
        echo ""
        echo "   Debug: Check if PostgreSQL container is running:"
        echo "   docker ps | grep postgres"
        exit 1
    fi
    echo "   Attempt ${RETRY_COUNT}/${MAX_RETRIES}: Database not ready, waiting 2s..."
    sleep 2
done
echo "✅ PostgreSQL is ready!"

# Run migrations and seed
echo "🗄️  Running database migrations and seeders..."
php artisan migrate:fresh --force --seed

# Build frontend assets (initial build)
echo "🎨 Building frontend assets (initial)..."
npm run build

# Create storage link
echo "🔗 Creating storage symlink..."
php artisan storage:link

# Run tests to verify everything works
echo "🧪 Running tests to verify setup..."
php artisan test

echo ""
echo "✅ Initial Setup Complete!"
echo "=========================================="
echo ""
echo "🎯 Next: Services will auto-start when container opens"
echo "   - Laravel dev server on http://localhost"
echo "   - Vite HMR on http://localhost:5173"
echo ""
echo "Good luck with the challenge! 🎸"
