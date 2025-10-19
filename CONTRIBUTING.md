# Contributing Guide

Thank you for considering contributing to this Laravel + Inertia + Vue application!

## Development Setup

### Prerequisites
- PHP 8.2 or higher
- Composer
- Node.js 20 or higher
- npm

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/musiceternal/apply.git
   cd apply
   ```

2. **Install dependencies**
   ```bash
   composer install
   npm install
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   php artisan key:generate
   touch database/database.sqlite
   ```

4. **Start development**
   ```bash
   # Terminal 1 - Backend
   php artisan serve
   
   # Terminal 2 - Frontend
   npm run dev
   ```

## Using GitHub Codespaces

The fastest way to start contributing is using GitHub Codespaces:

1. Click **Code** → **Create codespace on main**
2. Wait for the environment to set up (automatic)
3. The devcontainer will automatically:
   - Install PHP and Node.js dependencies
   - Set up the environment
   - Configure the database
4. Start the dev servers:
   ```bash
   php artisan serve
   npm run dev
   ```

## Project Structure

- `app/` - Backend application code
- `resources/js/` - Vue/TypeScript frontend code
- `resources/js/Pages/` - Inertia page components
- `resources/js/Components/` - Reusable Vue components
- `routes/` - Application routes
- `tests/` - Test files

## Code Style

### PHP
We use Laravel Pint for PHP code formatting:
```bash
./vendor/bin/pint
```

### TypeScript/Vue
Format your code before committing:
```bash
npm run format  # if configured
```

## Testing

Run the test suite:
```bash
php artisan test
# or
./vendor/bin/phpunit
```

## Making Changes

1. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes
   - Write tests for new features
   - Update documentation if needed
   - Follow existing code style

3. Run tests:
   ```bash
   php artisan test
   npm run build
   ```

4. Commit your changes:
   ```bash
   git commit -m "Description of your changes"
   ```

5. Push and create a pull request:
   ```bash
   git push origin feature/your-feature-name
   ```

## Adding New Pages

To add a new Inertia page:

1. Create a Vue component in `resources/js/Pages/`:
   ```vue
   <script setup lang="ts">
   import { Head } from '@inertiajs/vue3';
   
   defineProps<{
     // your props
   }>();
   </script>
   
   <template>
     <Head title="Page Title" />
     <!-- your content -->
   </template>
   ```

2. Add a route in `routes/web.php`:
   ```php
   Route::get('/your-route', function () {
       return Inertia::render('YourPage', [
           'data' => 'value'
       ]);
   });
   ```

## Adding Components

Create reusable components in `resources/js/Components/`:

```vue
<script setup lang="ts">
defineProps<{
  title: string;
}>();
</script>

<template>
  <div class="component">
    <h2>{{ title }}</h2>
  </div>
</template>
```

Import and use in pages:
```vue
<script setup lang="ts">
import YourComponent from '@/Components/YourComponent.vue';
</script>
```

## TypeScript Types

Add types in `resources/js/types/`:
```typescript
export interface YourType {
  id: number;
  name: string;
}
```

## Database Migrations

Create a migration:
```bash
php artisan make:migration create_your_table
```

Run migrations:
```bash
php artisan migrate
```

## Questions?

If you have questions or need help, please open an issue!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
