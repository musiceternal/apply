# Apply

A modern Laravel 11 application with Inertia.js 2, Vue 3, TypeScript, and Vite.

## Features

- ⚡ **Laravel 11** - Latest version of the Laravel framework
- 🚀 **Inertia.js 2** - Build modern single-page apps without building an API
- 💚 **Vue 3** - Progressive JavaScript framework with Composition API
- 📘 **TypeScript** - Type-safe development experience
- ⚡ **Vite** - Lightning-fast frontend tooling
- 🎨 **Tailwind CSS** - Utility-first CSS framework
- 🐳 **DevContainer** - Containerized development environment for GitHub Codespaces

## Development

### Using GitHub Codespaces

1. Click "Code" → "Create codespace on main"
2. Wait for the container to build and dependencies to install
3. Start the development servers:
   ```bash
   php artisan serve
   ```
   In another terminal:
   ```bash
   npm run dev
   ```
4. Open the forwarded port to view the application

### Local Development

#### Prerequisites

- PHP 8.2+
- Node.js 20+
- Composer
- MySQL or SQLite

#### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/musiceternal/apply.git
   cd apply
   ```

2. Install PHP dependencies:
   ```bash
   composer install
   ```

3. Install Node.js dependencies:
   ```bash
   npm install
   ```

4. Create environment file:
   ```bash
   cp .env.example .env
   ```

5. Generate application key:
   ```bash
   php artisan key:generate
   ```

6. Create database:
   ```bash
   touch database/database.sqlite
   ```

7. Run migrations:
   ```bash
   php artisan migrate
   ```

8. Start development servers:
   ```bash
   # Terminal 1 - Laravel
   php artisan serve
   
   # Terminal 2 - Vite
   npm run dev
   ```

9. Visit `http://localhost:8000`

## Building for Production

```bash
npm run build
```

## Tech Stack

- **Backend**: Laravel 11, PHP 8.2+
- **Frontend**: Vue 3, TypeScript, Inertia.js 2
- **Build Tool**: Vite 5
- **Styling**: Tailwind CSS 3
- **Development**: Docker DevContainer, GitHub Codespaces

## License

MIT