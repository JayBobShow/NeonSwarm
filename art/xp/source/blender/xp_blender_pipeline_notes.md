# Phase 27 Repair 2 XP Blender Pipeline Notes

## Purpose

XP pickups must be real Blender-made 3D gameplay objects, not flat sprites or old procedural placeholders.

## Source / Export

- Blender source: `art/xp/source/blender/xp_shard.blend`
- Runtime GLB: `art/xp/exported/3d/xp_shard.glb`

## Model Design

- Large readable 3D `XP` letters as the primary pickup silhouette.
- Deep dark blue neon-toned letter-depth body, replacing the earlier near-black body material so XP separates better from dark sector backgrounds.
- Cyan neon tube edge around the `XP` form.
- Blue inner glass letter face.
- White readable front glyph layer.
- Subtle collector halo and magenta reward arc behind the letters.
- Small blue side-depth facets for collectible reward depth.
- XP-specific material emission remains at the half-intensity Phase 27 Repair 3 hotfix values, not the rejected overbright Repair 2 values.
- Dark blue body material: `XPDarkBlueNeonDepth`, base color `(0.018, 0.080, 0.240, 1.0)`, low emission `0.24`.

## Godot Integration

`scripts/NeonSwarm3DGameplayPrototype.gd` loads the GLB with `GLTFDocument.append_from_file()` and attaches it to each XP pickup as `Blender3DXPPickupModel`.

XP value, collision radius, magnet radius, pull speed, collection behavior, sound, and level-up behavior were not changed.
