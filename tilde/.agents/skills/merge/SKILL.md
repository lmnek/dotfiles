---
name: merge
description: >
  Guided branch-merge round-trip: merge another branch into the current one,
  hunt semantic conflicts with parallel review agents, verify, and optionally
  merge the result back into the original branch (worktree -> integration
  branch included). Use when the user says "/merge", "merge it back",
  "merge <branch> in", "sync with <branch>", or asks to reconcile diverged
  branches.
---

Merge `SRC` into the current branch, stabilize, and (if asked) merge back into
`DST`. Decisions stay with the user via AskUserQuestion; you do the legwork.
NEVER push unless explicitly asked.

Users range from git experts to vibe coders: use correct git terms, but every
option and recommendation must say in plain words what happens and what could
go wrong (e.g. "Rebase: replays your commits on top of develop; history stays
clean; safe here because nobody else has these commits"). If a non-expert
couldn't weigh the trade-off from the description alone, rewrite it.

Keep every user-facing output small: the brief, findings, and report each fit
one screen — a few short bullets, no walls of text, no raw command dumps.
Lead with what needs a decision; details only on request.

## Arguments

`/merge [SRC] [into DST]` — free-form; parse intent, and restate the parsed
plan in the brief so a misread is caught before anything runs:

- `/merge <branch>` → one-way: merge it into the current branch (phases 0–3).
- `/merge X into Y` → round-trip landing X on Y: merge Y into X first
  (phases 0–3, stabilize on X), then phase 4 merges X into Y. X must be the
  current branch — if not, ask before switching.
- `/merge into Y` / "…back" → round-trip of the current branch (default Y:
  the branch it forked from / the worktree's origin branch).
- Bare `/merge` → infer (worktree's origin branch; tracked remote if
  diverged). Several plausible candidates → ask, showing ahead/behind counts.

## 0. Brief

- `git fetch origin <branch>` for the branches involved — never `--all --prune`.
- Map: merge-base, ahead/behind both ways, `git worktree list` (SRC/DST
  checked out elsewhere? dirty?), dirty files in every involved tree,
  changed-file intersection
  `comm -12 <(git diff --name-only BASE..A | sort) <(git diff --name-only BASE..B | sort)`,
  lock-file and DB-migration deltas.
- **Contamination guard**: SRC wholesale-contains an unrelated branch's
  history → warn; offer cherry-pick extraction instead.
- Discover repo gates: CLAUDE.md quality gate, task-runner verify tasks,
  and `docs/**/merg*` playbooks (follow them if present).
- Run the gates (tests, linters, typecheck) once now — anything already
  failing is baseline, not merge damage; only new failures count later.
- Present a one-screen brief + recommended strategy; say which rule fired:
  - X unpushed, not checked out elsewhere, no other session built on it →
    **rebase X onto Y, then merge** — clean history at zero risk.
  - X pushed, shared, or checked out elsewhere → **sync-merge**; never rewrite
    shared history. The history noise is the price; `git log --first-parent`
    keeps it readable and the final MR can squash it away.
  - X is a few polish commits with no extraction value → offer **squash-merge**
    (granularity is lost — say so).
  - `--ff-only` whenever it applies.

## 1. Merge in

- User's own uncommitted changes → ask first: commit, stash, or stop; never
  merge over them.
- Then: `git branch backup/<branch>-pre-merge` (escape hatch; user deletes it).
- Probe by running the real merge — it aborts atomically. A *foreign* dirty
  file blocking it (another session's buffer) → **ask** before
  `git stash push -- <file>` → merge → `stash pop`.
- Conflicts: resolve mechanical ones (imports, adjacent additions) silently,
  list them in the report. Lock files: regenerate, never hand-merge.
  Both-sides-changed-behavior → AskUserQuestion with side-by-side previews.
- Two migration heads (alembic etc.) → create a merge revision.

## 2. Semantic hunt

Textual conflicts are the easy part; the merges that hurt were clean
auto-merges. Skim what each side changed, then judge which lenses this diff
needs — the list below is examples, not a checklist: drop ones that can't
apply, invent ones the diff calls for. Launch parallel read-only agents, one
lens each — 2 for small merges, 4–5 when shared/central files are touched:

- **Merge-born bugs** (always dispatch, top priority) — new bugs neither side
  had alone, created by the combination and not covered by existing tests
  (written before the combination existed); trace the riskiest interaction
  paths between the two sides' changes by hand.
- **Undone changes** — one side's deletion or fix silently reverted by the
  other: removed code resurrected, a bug fix lost to a refactor.
- **Contract drift** — names or shapes changed on one side (fields, functions,
  endpoints, schemas) still used in the old form elsewhere.
- **Split-brain** — both sides solved the same problem differently; one must win.
- **Central registries** — both sides registering into the same routing/DI/
  index/migration table: compiles, fails at runtime.
- **Stale couplings** — tests green only via a default the merge changed;
  generated/mirrored files desynced from their source.

Then run the phase-0 verify gates. Dependencies changed → reinstall first; a
missing package fails tests in ways that read like source bugs.

## 3. Gate

Report findings most-severe first; user picks fix / proceed / abort per
finding. Fix-and-reverify until gates are green.

## 4. Merge back (round-trip only)

- Re-check DST's tip — other sessions move branches. Moved + your commits
  local-unpushed → rebase onto it, **re-run the verify gates**, retry.
- `git merge --ff-only` probe; else `--no-ff -m "merge: <what> (<src> -> <dst>)"`
  in whatever format the repo's commit hooks enforce.
- Never delete the source branch/worktree yourself. If the user asks for
  cleanup, first confirm `git merge-base --is-ancestor <src> <dst>`.

## 5. Report

What merged, conflicts resolved, semantic findings and outcomes, verify
results, backup ref name, explicit "not pushed — say the word". UI surfaces
changed → screenshot the affected screen with Playwright, show it, then ask
for the final eyeball.
