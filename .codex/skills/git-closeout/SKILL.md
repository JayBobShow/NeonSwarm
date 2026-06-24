---
name: git-closeout
description: Use at the end of Neon Swarm work to review status, summarize diffs, validate, report changed files, commit locally when safe, and avoid pushing without approval.
---

# Git Closeout

Use this skill before finishing Neon Swarm work.

## Status Review

Run:

```bash
git status --short --branch
git diff --stat
```

Inspect relevant diffs before committing:

```bash
git diff -- <path>
```

Do not revert user changes. If unrelated dirty files exist, leave them alone and
explain they were not touched.

## Validation Review

Confirm validation appropriate to the task:

- Docs-only change: syntax/readback and targeted file review are usually enough.
- Godot runtime change: launch or headless validation.
- Visual/art change: gameplay camera readability check.
- Blender asset change: `.blend` source and `.glb` export checks.
- UI/HUD change: viewport, text fit, and controller/mouse path checks.

Use `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md` when gameplay, UI, visual,
progression, or save behavior could be affected.

## Report Requirements

Final report must include:

- Files changed.
- Tests or commands run.
- Known issues.
- Whether `scenes/Main.tscn` changed.
- Whether `project.godot` changed.
- What was intentionally not touched when scope restrictions matter.

## Commit Rule

Commit locally when the task is complete and safe.

Before committing:

- Review `git status --short --branch`.
- Review relevant diff summary.
- Ensure the commit includes only intended files.
- Use a concise commit message that matches the work.

Do not push unless the user approves.
