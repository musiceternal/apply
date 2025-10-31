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
until php artisan db:show > /dev/null 2>&1; do
    echo "   Database not ready, waiting..."
    sleep 2
done

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
