# Setup Notes for Testing

## Current Status

✅ **DevContainer configured** with:
- PHP 8.4, PostgreSQL 15, Redis, Meilisearch
- Auto-start Laravel dev server + Vite on container open
- VS Code extensions pre-configured
- Sail-based Docker setup

## To Test Codespace Experience

1. **Create GitHub Codespace**:
   - Go to https://github.com/musiceternal/apply
   - Click "Code" → "Codespaces" → "Create codespace on main"

2. **What Should Happen**:
   - Codespace builds (2-3 minutes first time)
   - DevContainer opens in VS Code
   - `postCreateCommand` runs setup script (installs deps, migrates DB, runs tests)
   - `postStartCommand` starts Laravel + Vite automatically
   - App accessible at forwarded port

3. **Test Checklist**:
   - [ ] Container builds without errors
   - [ ] Setup script completes successfully
   - [ ] Tests pass
   - [ ] Visit http://localhost → see Laravel welcome page
   - [ ] `npm run dev` works (if not auto-started)
   - [ ] Database migrations ran
   - [ ] VS Code extensions loaded

## Known Issues to Watch For

⚠️ **Likely problems**:
- Docker compose may need `sail:install` run manually
- `.env` may not auto-configure correctly
- Services may not auto-start (need manual `php artisan serve`)

## If It Breaks

**Fallback manual setup**:
```bash
# Install Sail properly
php artisan sail:install --with=pgsql,redis,meilisearch --devcontainer

# Then start services
./vendor/bin/sail up -d
./vendor/bin/sail npm run dev
```

## Next Steps After Testing

Based on your feedback, I'll:
1. Fix any devcontainer issues you find
2. Create core models (Lesson, Instrument, TeacherProfile)
3. Build realistic seeders
4. Write challenge instructions
5. Create epic README

## Goal

**60 seconds from "Open Codespace" to working app** ✨
