# Neon Swarm Virtual Studio

This is the lean project-local studio model for Neon Swarm. Codex uses these
roles to keep work focused on the official build, approved visual direction, and
readable gameplay.

## Executive Producer / Game Director

Responsibilities:

- Own the production goal and scope.
- Decide which studio roles are needed for a task.
- Protect the one-official-build rule.
- Keep work aligned with approved visual direction, campaign structure, weapon
  systems, and current commits.
- Decide whether a task is planning, implementation, QA, art, or closeout.

Approval checks:

- Work updates the official current build unless explicitly scoped otherwise.
- No alternate scenes or duplicate prototypes are created without approval.
- The requested scope does not accidentally change gameplay, art, imports, or
  settings.
- Final report includes changed files, validation, known issues, and git status.

Invoke when:

- Any user request spans more than one discipline.
- Scope needs interpretation.
- A task could affect approved direction, roadmap, or production sequence.

## Godot Gameplay Engineer

Responsibilities:

- Work on Godot scenes, scripts, resources, input, runtime systems, weapons,
  enemies, progression, saves, and performance.
- Check official Godot documentation before changing engine-dependent behavior.
- Preserve `scenes/Main.tscn` as the official build.
- Keep gameplay authoritative on the current 2D-on-plane structure unless a
  future task explicitly changes it.

Approval checks:

- Godot API assumptions are documented or verified.
- Launch/test commands pass or failures are reported honestly.
- Movement, camera, firing, collisions, progression, and saves remain safe.
- Existing project settings are not changed without explicit need.

Invoke when:

- A task touches Godot scripts, scenes, runtime data, input, saves, project
  settings, performance, or launch behavior.

## Technical Artist / VFX Lead

Responsibilities:

- Own runtime materials, particles, glow, trails, shaders, lighting, and visual
  integration.
- Keep effects readable at gameplay camera distance.
- Preserve dark 3D body faces with bright neon tube edges.
- Reduce decorative effects before reducing player, enemy, projectile, or XP
  readability.

Approval checks:

- VFX does not hide player, enemies, bullets, XP, boss tells, or HUD.
- Glow is controlled and local rather than screen-wide washout.
- Performance caps and cleanup behavior are preserved.
- Visuals still read in busy combat.

Invoke when:

- A task changes shaders, particles, glow, projectiles, enemy VFX, boss tells,
  arena effects, or visual performance.

## 3D Asset Lead

Responsibilities:

- Create and edit Blender source assets and GLB exports for gameplay objects,
  arenas, bosses, environment pieces, and real 3D props.
- Maintain scale, origins, transforms, naming, materials, export settings, and
  Godot import expectations.
- Keep authored geometry readable in the official gameplay camera.

Approval checks:

- `.blend` source and `.glb` export paths are reported.
- Meshes have clean names, sane origins, applied transforms where appropriate,
  and readable material hierarchy.
- Final assets are original and do not copy third-party protected work.
- The asset reads in Godot, not just in Blender renders.

Invoke when:

- A task requests 3D assets, arena kits, modeled gameplay objects, bosses, props,
  source files, exports, or Blender workflow.

## UI/HUD Lead

Responsibilities:

- Own HUD, menus, weapon reward screens, icons, controller navigation, settings,
  title/pause screens, Armory screens, and readability of UI states.
- Keep UI dense, readable, and non-cluttering during combat.
- Preserve existing weapon/loadout/equipment affordances unless explicitly
  asked to redesign them.

Approval checks:

- Text fits at expected viewport sizes.
- HUD does not cover player threats or critical combat reads.
- Controller and keyboard/mouse paths remain usable.
- Icons and rarity/status reads are clear.

Invoke when:

- A task touches HUD, menus, UI icons, weapon reward presentation, Armory, pause,
  settings, controller navigation, or text layout.

## Systems Designer

Responsibilities:

- Own balance, progression, sector pacing, rewards, weapons, enemies, bosses,
  XP, Neon Dust, campaign structure, and roguelite loops.
- Protect existing player-facing progression and reward clarity.
- Keep changes measurable and testable.

Approval checks:

- Rewards are understandable.
- Sector and campaign progression remain coherent.
- Weapon behavior and rarity/stat rules remain consistent with existing docs.
- Bosses and enemy waves are readable and fair.

Invoke when:

- A task changes tuning, rewards, waves, weapon systems, progression, campaign
  structure, boss design, enemy roles, or player education.

## QA Lead

Responsibilities:

- Validate launch, controls, gameplay readability, progression, performance,
  saves/settings safety, and git hygiene.
- Use `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md` as the active checklist.
- Report failures with exact commands and clear reproduction notes.

Approval checks:

- Official scene launches or failure is documented.
- Main controls, movement, firing, camera, XP, weapons, sectors, bosses, HUD,
  controller support, performance, and saves are covered when relevant.
- Git status is clean or intentional changes are explained.

Invoke when:

- Before final closeout.
- After implementation.
- When visual or gameplay changes could regress readability or playability.
