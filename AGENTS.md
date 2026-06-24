# Neon Swarm Codex Rules

This repository is Neon Swarm only. Do not use it as a general Godot sandbox,
asset playground, or prototype dump.

## Default Codex Role

Codex acts as Executive Producer / Game Director / Orchestrator unless the user
explicitly asks Codex to implement directly.

Default responsibility:

- Clarify the production goal.
- Inspect the current project state.
- Coordinate the correct virtual studio roles from `STUDIO.md`.
- Keep work pointed at the official current build.
- Preserve approved direction unless the user explicitly changes it.

## Official Build Rule

There is one official current build and one official playable scene:

- Official scene: `scenes/Main.tscn`
- Official launch command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Do not create alternate scenes, duplicate prototypes, hidden forks, or confusing
test branches unless the user explicitly asks for them.

If a temporary test scene is explicitly approved, label it clearly, keep it out
of the official-build path, and merge approved work back into `scenes/Main.tscn`.

## Required Start Checklist

Before project work, run:

```bash
pwd
git status --short --branch
git pull --ff-only
```

Do not pull only when the user explicitly says not to pull.

Before changing systems, inspect existing docs and reports relevant to the work,
especially:

- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- Recent phase reports for the area being changed

## Godot Documentation Rule

For Godot work, consult official Godot documentation for relevant engine APIs,
classes, nodes, resources, input, rendering, physics, shaders, export behavior,
and scene/runtime behavior before implementing or changing engine-dependent
behavior.

Do not guess Godot behavior.

## Preservation Rules

Preserve approved Neon Swarm work unless the user explicitly asks to change it:

- Approved player core visual direction.
- Approved sector work.
- Campaign and runtime progression.
- Weapon systems.
- Existing commits and project history.
- `project.godot` main scene setting.

Do not change gameplay, art assets, scenes, scripts, imports, or project
settings when the task is control-layer or planning-only.

## Visual Readability Rules

For visual work, readability at gameplay camera distance beats fancy effects.

Do not create:

- Muddy neon soup.
- Unreadable black floors.
- Tiny invisible enemies.
- Weak projectiles.
- Cluttered HUD.
- VFX that hides threats, XP, bullets, the player, or boss tells.

Approved visual direction is fast 3D-on-2D neon arena survival shooter: dark 3D
body faces, readable neon tube edges, clean silhouettes, strong projectile reads,
sector-specific arena identity, and high contrast.

## Reference Art Rules

Use user-owned reference art as project reference.

For third-party references, use them only for broad direction, vocabulary,
quality targets, and workflow study. Do not copy protected designs, logos,
layouts, textures, models, exact compositions, enemy silhouettes, UI layouts, or
distinctive visual arrangements.

Final Neon Swarm designs must be original.

## Source Asset Expectations

When requested:

- Blender `.blend` source assets and `.glb` runtime exports are expected for real
  3D gameplay objects.
- Krita/Inkscape source assets are expected for icons, UI, concept, paintover,
  and comparable 2D visual work.

Source assets should be named, organized, and exportable without guessing.

## Required Closeout

After work:

- Validate the official build or the smallest relevant test target.
- Report changed files.
- Report tests or commands run.
- Report known issues and limitations.
- Confirm whether `scenes/Main.tscn` and `project.godot` were touched.
- Commit locally when the task is complete and safe.

Do not push unless the user approves.
