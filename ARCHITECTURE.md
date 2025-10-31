# Music Eternal - Apply Architecture

This document explains the architectural patterns used in this hiring assessment repo. These patterns mirror our production codebase.

## Core Principles

1. **Thin Controllers** - Controllers only handle HTTP concerns
2. **Invocable Actions** - Business logic lives in single-responsibility action classes
3. **Data DTOs** - Type-safe data transfer using Spatie Laravel Data
4. **Form Requests** - Validation separated from controllers
5. **Policies** - Authorization logic in dedicated policy classes

## Architecture Layers

```
HTTP Request
    ↓
Controller (thin, just wires things up)
    ↓
FormRequest (validates input)
    ↓
Action (invocable, contains business logic)
    ↓
Models/Database
    ↓
Response (Inertia render or JSON)
```

## Pattern Examples

### 1. Invocable Actions (NOT Services!)

**✅ We use Action Pattern:**
- Single-responsibility invocable classes
- One action = one operation
- Type-hinted dependencies via constructor
- Invoked via `__invoke()` method

**Example:**
```php
<?php

namespace App\Actions\Lesson;

use App\Data\Lesson\GetLessonsFiltersData;
use App\Models\Lesson;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class GetLessonsAction
{
    public function __invoke(GetLessonsFiltersData $filters): LengthAwarePaginator
    {
        return Lesson::query()
            ->with(['teacher', 'student', 'instrument'])
            ->when($filters->search, fn($q, $search) =>
                $q->where('title', 'like', "%{$search}%")
            )
            ->paginate(15);
    }
}
```

**Usage in Controller:**
```php
public function index(
    GetLessonsRequest $request,
    GetLessonsAction $action
): \Inertia\Response {
    $filters = GetLessonsFiltersData::from($request->validated());
    $lessons = $action($filters);

    return Inertia::render('Lesson/Index', ['lessons' => $lessons]);
}
```

### 2. Data Transfer Objects (DTOs)

We use **Spatie Laravel Data** for type-safe DTOs:

```php
<?php

namespace App\Data\Lesson;

use Spatie\LaravelData\Data;

class GetLessonsFiltersData extends Data
{
    public function __construct(
        public ?string $search = null,
        public ?string $instrument = null,
        public ?string $teacher = null,
    ) {}
}
```

**Benefits:**
- Type safety
- Auto-validation
- Easy transformation from requests
- Works with Inertia props

### 3. Form Requests

Validation stays in dedicated request classes:

```php
<?php

namespace App\Http\Requests\Lesson;

use Illuminate\Foundation\Http\FormRequest;

class GetLessonsRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'search' => ['nullable', 'string', 'max:255'],
            'instrument' => ['nullable', 'string', 'exists:instruments,id'],
            'teacher' => ['nullable', 'string', 'exists:users,id'],
        ];
    }
}
```

### 4. Thin Controllers

Controllers orchestrate, don't implement:

```php
<?php

namespace App\Http\Controllers;

use App\Actions\Lesson\GetLessonsAction;
use App\Data\Lesson\GetLessonsFiltersData;
use App\Http\Requests\Lesson\GetLessonsRequest;
use Inertia\Inertia;

class LessonController extends Controller
{
    // Just wire up: Request → Action → Response
    public function index(
        GetLessonsRequest $request,
        GetLessonsAction $action
    ): \Inertia\Response {
        $filters = GetLessonsFiltersData::from($request->validated());
        $lessons = $action($filters);

        return Inertia::render('Lesson/Index', ['lessons' => $lessons]);
    }
}
```

### 5. Policies for Authorization

```php
<?php

namespace App\Policies;

use App\Models\Lesson;
use App\Models\User;

class LessonPolicy
{
    public function view(User $user, Lesson $lesson): bool
    {
        return $user->isAdmin()
            || $user->id === $lesson->teacher_id
            || $user->id === $lesson->student_id;
    }
}
```

## What We DON'T Use

❌ **Service Classes** - We use Actions instead
❌ **Repositories** - Eloquent is our abstraction
❌ **Heavy abstractions** - YAGNI principle
❌ **Manager/Handler suffixes** - Action suffix only

## Directory Structure

```
app/
├── Actions/              # Invocable business logic
│   ├── Lesson/
│   │   ├── GetLessonsAction.php
│   │   ├── CreateLessonAction.php
│   │   └── UpdateLessonAction.php
│   └── Student/
├── Data/                 # Spatie Laravel Data DTOs
│   ├── Lesson/
│   │   ├── LessonData.php
│   │   └── GetLessonsFiltersData.php
│   └── Student/
├── Http/
│   ├── Controllers/      # Thin controllers
│   ├── Requests/         # Form validation
│   └── Middleware/
├── Models/               # Eloquent models
└── Policies/             # Authorization
```

## Testing Strategy

**Feature Tests** test the full flow:
```php
it('can get lessons with filters', function () {
    $teacher = User::factory()->teacher()->create();
    $lesson = Lesson::factory()->for($teacher)->create();

    $response = $this->actingAs(User::factory()->admin()->create())
        ->get(route('lessons.index', ['teacher' => $teacher->id]));

    $response->assertOk();
    $response->assertInertia(fn($page) =>
        $page->component('Lesson/Index')
            ->has('lessons.data', 1)
    );
});
```

**Unit Tests** test actions in isolation:
```php
it('filters lessons by teacher', function () {
    $teacher = User::factory()->teacher()->create();
    Lesson::factory()->for($teacher)->count(3)->create();
    Lesson::factory()->count(2)->create(); // Other teacher

    $action = new GetLessonsAction();
    $filters = new GetLessonsFiltersData(teacher: $teacher->id);

    $result = $action($filters);

    expect($result->total())->toBe(3);
});
```

## Key Takeaways for Candidates

1. ✅ Keep controllers thin - delegate to actions
2. ✅ Use invocable actions for business logic
3. ✅ Leverage Spatie Data for DTOs
4. ✅ Separate validation into Form Requests
5. ✅ Use policies for authorization
6. ✅ Write feature tests that prove the full flow works
7. ✅ Follow existing patterns - consistency matters

## Questions?

If you're stuck during the assessment:
- Check existing code for patterns
- Read this document
- Inspect test examples
- Use Laravel docs when needed

Good luck! 🎸
