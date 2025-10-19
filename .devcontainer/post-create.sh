#!/bin/bash
set -e

echo "Running post-create setup..."

# Install PHP dependencies
if [ -f "composer.json" ]; then
    echo "Installing PHP dependencies..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

# Install Node.js dependencies
if [ -f "package.json" ]; then
    echo "Installing Node.js dependencies..."
    npm install
fi

# Copy .env file
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    echo "Creating .env file..."
    cp .env.example .env
fi

# Generate application key
if [ -f "artisan" ]; then
    echo "Generating application key..."
    php artisan key:generate --ansi
fi

# Create SQLite database if using SQLite
if [ ! -f "database/database.sqlite" ]; then
    echo "Creating SQLite database..."
    touch database/database.sqlite
fi

# Run migrations
if [ -f "artisan" ]; then
    echo "Running migrations..."
    php artisan migrate --force || echo "Migrations not ready yet or failed"
fi

# Set permissions
echo "Setting permissions..."
chmod -R 775 storage bootstrap/cache

echo "Post-create setup complete!"
