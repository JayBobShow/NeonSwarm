# Phase 27 Repair Player Blender Pipeline Notes

## Purpose

The flat PNG player object pass failed because gameplay objects must be real 3D assets. This repair creates and integrates a Blender-made player core model.

## Source / Export

- Blender source: `art/player/source/blender/player_core.blend`
- Runtime GLB: `art/player/exported/3d/player_core.glb`

## Model Design

- Diamond/hex command-core silhouette.
- Dark glass body faces.
- Cyan neon tube edges.
- Magenta delta wings.
- White-hot central reactor.
- Forward prow for directional read.
- Orbit ring accents.

## Godot Integration

`scripts/NeonSwarm3DGameplayPrototype.gd` loads the GLB with `GLTFDocument.append_from_file()` and attaches it to the existing player visual root as `Blender3DPlayerCoreModel`.

Movement, collision, health, damage flash timing, and weapon behavior were not changed.
