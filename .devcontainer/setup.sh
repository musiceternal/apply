#!/bin/bash
set -e

echo "🎵 Music Eternal - Apply Setup Starting..."
echo "=========================================="

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
php artisan key:generate --ansi

# Install NPM dependencies
echo "📦 Installing NPM dependencies..."
npm install

# Run migrations
echo "🗄️  Running database migrations..."
php artisan migrate:fresh --force --seed

# Build frontend assets
echo "🎨 Building frontend assets..."
npm run build

# Create storage link
echo "🔗 Creating storage symlink..."
php artisan storage:link

# Run tests to verify everything works
echo "🧪 Running tests to verify setup..."
php artisan test

echo ""
echo "✅ Setup Complete!"
echo "=========================================="
echo "🚀 Application: http://localhost"
echo "🎨 Vite Dev: http://localhost:5173"
echo "🔍 Meilisearch: http://localhost:7700"
echo ""
echo "📧 Login Credentials:"
echo "   Admin: admin@musiceternal.test / password"
echo "   Teacher: teacher@musiceternal.test / password"
echo "   Student: student@musiceternal.test / password"
echo ""
echo "📚 Next Steps:"
echo "   1. Visit http://localhost and login"
echo "   2. Check /challenges folder for assessment tasks"
echo "   3. Run 'npm run dev' for hot-reload during development"
echo ""
echo "Good luck! 🎸"
