#!/bin/bash
set -e

echo "🚀 Starting Music Eternal Apply services..."

# Ensure .env exists
if [ ! -f .env ]; then
    echo "📋 Creating .env from .env.example..."
    cp .env.example .env
    php artisan key:generate --ansi
fi

# Start Laravel development server in background
echo "🎸 Starting Laravel dev server (port 80)..."
php artisan serve --host=0.0.0.0 --port=80 > /tmp/laravel-serve.log 2>&1 &

# Start Vite dev server in background
echo "🎨 Starting Vite dev server (port 5474)..."
npm run dev > /tmp/vite-dev.log 2>&1 &

# Wait a moment for services to start
sleep 2

echo ""
echo "✅ Services Started!"
echo "=========================================="
echo "🌐 Laravel App: http://localhost"
echo "⚡ Vite HMR: http://localhost:5474"
echo ""
echo "📧 Login Credentials:"
echo "   Admin: admin@musiceternal.test / password"
echo "   Teacher: teacher@musiceternal.test / password"
echo "   Student: student@musiceternal.test / password"
echo ""
echo "📝 View logs:"
echo "   Laravel: tail -f /tmp/laravel-serve.log"
echo "   Vite: tail -f /tmp/vite-dev.log"
echo ""
echo "📚 Ready to code! Check /challenges for tasks."
echo "=========================================="
