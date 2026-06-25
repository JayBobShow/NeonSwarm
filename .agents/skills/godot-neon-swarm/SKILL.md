---
name: godot-neon-swarm
description: Use for Neon Swarm Godot work that touches scenes, scripts, input, runtime systems, rendering, shaders, progression, UI, performance, or launch validation.
---

# Godot Neon Swarm

Use this skill when working inside the Neon Swarm Godot project.

## Start Checklist

Run first unless the user explicitly says not to pull:

```bash
pwd
git status --short --branch
git pull --ff-only
```

Read relevant local project docs before changing systems:

- `AGENTS.md`
- `STUDIO.md`
- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- Recent phase reports for the affected area

## Godot Documentation Rule

Before implementing or changing engine-dependent behavior, consult official
Godot documentation for the relevant version, APIs, classes, nodes, resources,
input behavior, rendering behavior, physics behavior, shaders, import behavior,
or project settings.

Do not guess Godot behavior.

Useful official starting points:

- Godot stable docs: `https://docs.godotengine.org/en/stable/`
- Class reference: `https://docs.godotengine.org/en/stable/classes/`
- Shading language: `https://docs.godotengine.org/en/stable/tutorials/shaders/`
- Input: `https://docs.godotengine.org/en/stable/tutorials/inputs/`
- 2D and 3D rendering docs as relevant

## Implementation Rules

- Treat `scenes/Main.tscn` as the only official playable scene.
- Do not create alternate playable scenes, duplicate prototypes, or test forks
  unless the user explicitly asks.
- Do not change `project.godot` unless the task requires it.
- Preserve player movement, weapon systems, campaign/runtime progression,
  approved sector work, save/settings safety, and approved player-core visuals
  unless explicitly asked to change them.
- Keep gameplay on the established X/Z gameplay plane unless a future task
  explicitly approves a gameplay architecture change.
- Use existing scripts, helpers, naming, and data patterns before adding new
  abstractions.

## Validation

Pick the smallest useful validation for the change, then include the official
build when the change could affect runtime behavior.

Common commands:

```bash
godot --headless --path . --quit-after 3
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

When UI, controller, visuals, sectors, progression, or saves are affected, also
use `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`.

## Closeout

Report:

- Godot docs consulted.
- Files changed.
- Validation commands and results.
- Whether `scenes/Main.tscn` changed.
- Whether `project.godot` changed.
- Known issues.

Commit locally when complete and safe. Do not push unless the user approves.
