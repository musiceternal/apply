#!/bin/bash
set -e

echo "Running post-start setup..."

# Ensure storage directories are writable
chmod -R 775 storage bootstrap/cache 2>/dev/null || true

echo "Post-start setup complete!"
echo ""
echo "🚀 Development environment is ready!"
echo ""
echo "To start the development server, run:"
echo "  php artisan serve"
echo ""
echo "To start Vite dev server, run:"
echo "  npm run dev"
echo ""
