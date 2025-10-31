# Session Handoff: Apply Repo DevContainer Setup

## Resume Context
**Working on**: Setting up hiring assessment repository with one-click DevContainer/Codespaces experience
**Branch**: `main`
**Last commit**: `50f75c3 revert: back to standard /var/www/html paths (Sail default)`
**Session ended**: 2025-10-31 ~20:00

## What I Did

1. ✅ **Created apply submodule** - Added as submodule to musiceternal monorepo
2. ✅ **Initialized Laravel 12** - Fresh scaffolding with Fortify, Inertia, Vue 3, TypeScript
3. ✅ **DevContainer configuration** - Complete setup with PHP 8.4, PostgreSQL, Redis, Meilisearch
4. ✅ **Copied official Sail docker/** - From working `/Users/nivrith/learning/twelve` project
5. ✅ **Automated service startup** - `postCreateCommand` + `postStartCommand` for auto-start
6. ✅ **Architecture docs** - Created `ARCHITECTURE.md` explaining Action pattern (no Services!)
7. ✅ **Fixed multiple path issues** - Tried /workspaces/apply, reverted to standard /var/www/html
8. ✅ **PostgreSQL configuration** - Updated .env.example with Docker service names

## Current Status

### ✅ **Working**
- Git submodule structure
- Laravel 12 scaffolding with Inertia + Vue 3
- Docker compose with official Sail PHP 8.4 image
- PostgreSQL, Redis, Meilisearch services configured
- Architecture documentation complete

### ⚠️ **Needs Testing**
- **Codespace creation** - User needs to test fresh codespace
- DevContainer build process
- Automated setup script (`.devcontainer/setup.sh`)
- Auto-start services (`.devcontainer/start-services.sh`)

### ❌ **Not Started**
- Core models (Lesson, Instrument, TeacherProfile)
- Example Actions (GetLessonsAction, etc.)
- Database seeders with realistic data
- Challenge instructions in `/challenges`
- Epic README for candidates

## What's Next

### **Priority 1: Test Codespace** (USER TASK)
User needs to create fresh GitHub Codespace to verify:
1. Container builds successfully
2. Setup script completes (composer install, migrations, tests)
3. Services auto-start (Laravel + Vite)
4. App accessible at forwarded port

### **Priority 2: Fix Any Codespace Issues**
Based on user feedback, fix remaining issues

### **Priority 3: Build Foundation Layer**
Once DevContainer works:

1. **Create 3-4 core models** (80/20 rule - minimal but realistic):
   ```bash
   # From portal patterns
   - Lesson (core domain model)
   - Instrument (simple reference data)
   - TeacherProfile (demonstrates relationships)
   ```

2. **Create 1-2 example Actions** (demonstrate pattern):
   ```php
   app/Actions/Lesson/GetLessonsAction.php
   app/Data/Lesson/GetLessonsFiltersData.php
   ```

3. **Build realistic seeders**:
   - 3 users (admin, teacher, student)
   - 5 instruments
   - 10-20 lessons
   - Login credentials: admin@musiceternal.test / password

4. **Create challenges**:
   ```
   challenges/
   ├── 01-bug-hunt/README.md
   ├── 02-feature-add/README.md
   └── 03-architecture/README.md
   ```

5. **Write epic README.md** for candidates

## Key Decisions

### **Using Official Sail Docker Structure**
- Copied entire `docker/` directory from working `twelve` project
- Uses Sail's official PHP 8.4 Dockerfile with all extensions
- Matches production portal setup patterns
- **Rationale**: Stop reinventing, use what works

### **Action Pattern, NOT Service Pattern**
- Portal uses invocable Actions for business logic
- No Service classes
- Documented in `ARCHITECTURE.md`
- **Rationale**: Match portal's actual patterns for realistic assessment

### **Standard /var/www/html Paths**
- Reverted from /workspaces/apply experiment
- Using Sail's default paths
- Let DevContainers handle mapping automatically
- **Rationale**: Stop fighting conventions

### **PostgreSQL Instead of MySQL**
- Portal uses PostgreSQL
- Assessment should match production
- **Rationale**: Realistic tech stack

### **80/20 Rule for Models**
- Only 3-4 core models, not entire portal schema
- Just enough to demonstrate patterns
- **Rationale**: 4-6 hour assessment, not full codebase replication

## Gotchas

### **DevContainer Path Issues**
- Tried multiple path configurations (/workspaces/apply, /var/www/html)
- Final solution: Use standard Sail paths, let DevContainers handle it
- **Key**: docker-compose volume `..:/var/www/html` + workspaceFolder `/var/www/html`

### **Sail Not Pre-Installed**
- Sail declared in composer.json but not installed until first run
- `postCreateCommand` runs `composer install` to install Sail
- Docker images don't need Sail pre-installed
- **Solution**: Use official Sail docker/ directory structure

### **Codespace Recovery Mode**
- Early attempts created Alpine recovery container
- Caused by docker build context errors
- **Fix**: Proper build context in docker-compose (`../docker/8.4`)

## File References

### **Key Files Created**
- `.devcontainer/devcontainer.json` - DevContainer config
- `.devcontainer/docker-compose.yml` - Service definitions
- `.devcontainer/Dockerfile` - Custom image (NOT USED - using Sail's)
- `.devcontainer/setup.sh` - First-run setup script
- `.devcontainer/start-services.sh` - Auto-start Laravel + Vite
- `docker/` - Official Sail docker structure (copied from twelve)
- `ARCHITECTURE.md` - Action pattern documentation
- `SETUP_NOTES.md` - Testing instructions for user

### **Key Files Modified**
- `.env.example` - PostgreSQL config (pgsql, redis hostnames)
- `docker/8.4/Dockerfile` - No modifications (standard Sail)

## Related Knowledge

### **Portal Patterns to Reference**
- Actions: `/Users/nivrith/musiceternal/portal/app/Actions/`
- Example: `portal/app/Actions/Student/GetStudentsAction.php`
- Controllers: `portal/app/Http/Controllers/LessonController.php`

### **Working Sail Reference**
- `/Users/nivrith/learning/twelve` - Fresh Laravel 12 with Sail
- Has working docker-compose + docker/ structure

## Commands for Next Session

```bash
# If user reports Codespace working:
cd /Users/nivrith/musiceternal/apply

# Create models with migrations, factories
php artisan make:model Lesson -mf
php artisan make:model Instrument -mf
php artisan make:model TeacherProfile -mf

# Create example Action
mkdir -p app/Actions/Lesson
# Write GetLessonsAction following portal pattern

# Create seeders
php artisan make:seeder ApplySeeder

# Create challenges directory
mkdir -p challenges/{01-bug-hunt,02-feature-add,03-architecture}
```

## Todo List State

- [x] Setup devcontainer configuration
- [x] Document Action pattern architecture
- [x] Update .env.example with correct settings
- [ ] **User tests codespace experience (READY!)**
- [ ] Create 3-4 core models based on feedback
- [ ] Build realistic database seeders
- [ ] Write epic README for candidates

---

**Next Session Start**: Paste this, then say: "User tested Codespace - [report results]. Continue building foundation layer."

**Token Efficiency**: This handoff = ~1.5K tokens vs re-reading entire conversation = 121K tokens (98% savings)
