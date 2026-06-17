# Neon Swarm Player Core Asset Replacement Hotfix Report

Date: 2026-06-17

## Scope

This was a small visual-only player core asset replacement and orientation hotfix for the official Neon Swarm project and official scene:

- Project: `/home/jason/GodotProjects/NeonSwarm`
- Official scene: `scenes/Main.tscn`
- Baseline before replacement: `441243d Phase 36 full run polish and progression clarity pass`

No Phase 37 work was started. Gameplay stats, controls, player collision, weapons, UI, progression, save systems, Armory, Forge, Evolution/Fusion, Neon Dust, Sector 4, events, bosses, and Wave Director systems were not changed.

## Asset Handling

The existing modified files were treated as the user-provided replacement assets:

- Replacement runtime source: `art/player/exported/3d/player_core.glb`
- Replacement Blender source: `art/player/source/blender/player_core.blend`

Old approved Phase 36 backups recovered from `HEAD`:

- `art/player/exported/3d/player_core_previous_phase36.glb`
- `art/player/source/blender/player_core_previous_phase36.blend`

User original unrotated backups:

- `art/player/source/blender/user_player_core_original_unrotated.glb`
- `art/player/source/blender/user_player_core_original_unrotated.blend`

Corrected replacement source and runtime outputs:

- `art/player/source/blender/player_core_replacement_corrected.blend`
- `art/player/source/blender/player_core.blend`
- `art/player/exported/3d/player_core.glb`

## Orientation Fix

Runtime player yaw uses `scripts/NeonSwarm3DGameplayPrototype.gd::_yaw_for_direction()`, where movement toward world `-Z` maps to yaw `0`. The player GLB is loaded with no runtime yaw offset through `_apply_player_blender_model()`.

The approved Phase 36 Blender model's `PlayerForwardProw` faced Blender `+Y`, which maps to Godot local `-Z` for runtime front. The replacement's cockpit/front detail initially faced Blender `-Y`, so it was backwards for gameplay.

The corrected replacement was rotated 180 degrees around Blender Z and the transform was applied before GLB export. After correction, the cockpit/front detail faces Blender `+Y`, matching the old approved runtime front direction. The rotation preserved the replacement's origin, scale, and vertical bounds.

Blender export bounds after correction:

- X: `-0.95281` to `0.95259`
- Y: `-0.62763` to `0.61567`
- Z: `0.0` to `1.23739`

## Validation Results

Commands run:

- `git status`: showed only expected modified replacement assets and new backup/source/report files before staging.
- `godot --headless --path . --quit-after 3`: passed. Output included `Neon Swarm active development build ready: version=0.17.0-dev sector=Neon Grid enemies=8 xp=0 player_projectiles=0 enemy_projectiles=0 visual_scene_assets=14 music_states=3`.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed with the same readiness output.

Final diff/status validation was run after report creation before commit.

## Manual Test Instructions

Run:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Then:

- Start Game.
- Move around.
- Confirm the player core is visible.
- Confirm it is facing the correct direction.
- Confirm scale is not too large or too small.
- Confirm no gameplay systems broke.
