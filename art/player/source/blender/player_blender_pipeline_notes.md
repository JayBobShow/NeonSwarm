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

## Player Core Replacement Orientation Hotfix

- Old Phase 36 runtime backup: `art/player/exported/3d/player_core_previous_phase36.glb`
- Old Phase 36 Blender source backup: `art/player/source/blender/player_core_previous_phase36.blend`
- User replacement original, unrotated runtime copy: `art/player/source/blender/user_player_core_original_unrotated.glb`
- User replacement original, unrotated Blender copy: `art/player/source/blender/user_player_core_original_unrotated.blend`
- Corrected Blender source: `art/player/source/blender/player_core_replacement_corrected.blend`
- Corrected runtime GLB: `art/player/exported/3d/player_core.glb`

The replacement source was rotated 180 degrees around Blender Z, then exported so the cockpit/front detail faces Blender `+Y`, matching the approved Phase 36 prow direction and Godot local `-Z` runtime front.
