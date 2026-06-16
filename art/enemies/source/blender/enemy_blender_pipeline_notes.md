# Phase 27 Repair Enemy Blender Pipeline Notes

## Purpose

The failed flat PNG enemy pass is replaced by real Blender-made 3D enemy models. These models preserve existing enemy behavior and collision.

## Source / Export

Blender sources:

- `art/enemies/source/blender/chaser.blend`
- `art/enemies/source/blender/tank.blend`
- `art/enemies/source/blender/shooter.blend`
- `art/enemies/source/blender/exploder.blend`
- `art/enemies/source/blender/spiral_drifter.blend`
- `art/enemies/source/blender/shield_node.blend`
- `art/enemies/source/blender/hex_slicer.blend`
- `art/enemies/source/blender/prism_leech.blend`
- `art/enemies/source/blender/triad_splitter.blend`
- `art/enemies/source/blender/triad_fragment.blend`
- `art/enemies/source/blender/hex_pulser.blend`
- `art/enemies/source/blender/rail_skimmer.blend`
- `art/enemies/source/blender/grid_splitter.blend`
- `art/enemies/source/blender/grid_fragment.blend`

Runtime GLBs:

- `art/enemies/exported/3d/chaser.glb`
- `art/enemies/exported/3d/tank.glb`
- `art/enemies/exported/3d/shooter.glb`
- `art/enemies/exported/3d/exploder.glb`
- `art/enemies/exported/3d/spiral_drifter.glb`
- `art/enemies/exported/3d/shield_node.glb`
- `art/enemies/exported/3d/hex_slicer.glb`
- `art/enemies/exported/3d/prism_leech.glb`
- `art/enemies/exported/3d/triad_splitter.glb`
- `art/enemies/exported/3d/triad_fragment.glb`
- `art/enemies/exported/3d/hex_pulser.glb`
- `art/enemies/exported/3d/rail_skimmer.glb`
- `art/enemies/exported/3d/grid_splitter.glb`
- `art/enemies/exported/3d/grid_fragment.glb`

## Model Rules

- Dark body faces.
- Neon tube edge meshes.
- Unique silhouette by enemy family.
- Existing geometry tree identities preserved.
- No enemy behavior, HP, speed, damage, spawn timing, or balance changes.

## Phase 27 Repair 2 Readability Pass

- Enemy neon material emission was increased.
- White-hot core/route accents were strengthened.
- Object-level readability frames were added per shape family:
  - Chaser/Triad: triangle routes.
  - Shooter/Shield/Hex Pulser/Hex Slicer: hex routes.
  - Tank: rectangular armor routes.
  - Prism Leech: diamond routes.
  - Spiral Drifter/Exploder: ring/cage routes.
- This is visual-only and does not change collision or behavior.

## Godot Integration

`_apply_enemy_blender_model()` maps active enemy types to the correct GLB and attaches the generated scene as `Blender3DEnemyModel_*`.

## Phase 35 Hyper Grid Enemy Assets

Phase 35 adds Blender-backed Sector 4 enemies:

- Rail Skimmer: stretched diamond/arrow skimmer with cyan rail tubes, white center rail, and gold charge nose. It supports a telegraphed straight-line dash behavior in the official runtime.
- Grid Splitter: square/rectangular circuit enemy with cyan grid frame and gold node accents. It splits into capped fragments on death.
- Grid Fragment: small rectangular grid shard spawned by Grid Splitter. It is not a direct wave enemy and should remain capped.

These assets are integrated through the existing `_apply_enemy_blender_model()` path. Runtime procedural meshes remain as emergency fallbacks only if a GLB fails to load.
