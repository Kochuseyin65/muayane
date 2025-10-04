# Repository Guidelines

## Project Structure & Module Organization
- `backend/`: Express API (controllers, routes, middleware, utils) plus SQL migrations under `config/migrations/`. Run-time uploads live in `backend/uploads/` (ignore in commits).
- `frontend/`: Vite + React client organized feature-first (`src/features/*`). Shared UI and store utilities reside in `src/components`, `src/store`, and `src/utils`.
- `docs/`: Authoritative architecture, API, and workflow references. Update relevant files whenever backend or frontend behaviour changes.
- `scripts/`: Helper tooling (e.g., `scripts/test_backend.py`) for smoke-testing the API.

## Build, Test, and Development Commands
- Backend setup: `cd backend && npm ci && npm run migrate` (runs all SQL migrations via `utils/migrate.js`).
- Backend dev server: `npm run dev` (nodemon on `http://localhost:3000/api`).
- Frontend dev server: `cd frontend && npm ci && npm run dev` (Vite on `http://localhost:5173`).
- Frontend production build: `npm run build` to ensure TypeScript compiles and bundles pass.
- Optional smoke test: `python scripts/test_backend.py` after seeding auth tokens in `.env`.

## Coding Style & Naming Conventions
- JavaScript/TypeScript: 2-space indentation, trailing commas when multi-line, camelCase for variables/functions, PascalCase for React components.
- Keep responses and errors in `{ success, data?, error? }` format (see `docs/api.md`).
- Prefer feature-specific directories and keep shared helpers in `src/utils` or `backend/utils`.
- Run `npm run build` before submitting frontend changes to catch TS issues; backend relies on ESLint-by-convention—stay consistent with existing patterns.

## Testing Guidelines
- No formal unit test suite yet; rely on `scripts/test_backend.py` and manual flow checks (Offers → Work Orders → Inspections → Reports).
- When adding tests, colocate them near the target module (e.g., `frontend/src/features/.../__tests__`). Name files `*.test.ts(x)`.
- Ensure new migrations are covered with at least one manual verification (run migrate on a fresh database).

## Commit & Pull Request Guidelines
- Follow conventional, actionable commit messages (e.g., `feat: add inspection task dates`, `fix: guard empty customer select`).
- Each PR should include: summary of changes, impacted routes/UI, migration notes, and manual/automated test evidence. Attach screenshots or GIFs for UI updates.
- Link to relevant issues or tickets and reference updated docs (e.g., `docs/frontend.md`).

## Security & Configuration Tips
- Keep `.env` files local; template sensitive keys via `.env.example` when possible.
- Helmet, CORS, and rate limiting defaults assume distinct frontend/backend origins—update `CORS_ORIGINS` when deploying.
- File uploads and signed reports live in `backend/uploads/`; never commit generated artifacts.
