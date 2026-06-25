# Sector 3 Ember Circuit Arena Notes

## Scope

Phase 53 creates the visual-only base arena for Sector 3 / 3.0 Foundry Gate.

This asset replaces the temporary legacy Sector 3 Null Zone HD plate in the
runtime presentation path. It does not add gameplay collision, hazards, enemy
behavior, boss behavior, weapons, HUD changes, Sector 4 work, Sector 5 work, or
alternate scenes.

## Visual Target

Sector 3 is Ember Circuit: a corrupted weapon-foundry circuit board with dark
machined faces, low-profile foundry plates, contained heat channels, hexagonal
forge nodes, and restrained ember/orange neon.

Primary shape: rectangular foundry circuit board.

Secondary shapes:

- Rectangular heat busways.
- Hexagonal forge nodes.
- Octagonal corner heat caps.
- Low boundary rails and service return stacks.

The floor must read as authored dark hard-surface material, not black void, old
Null Zone art, or random orange line overlays.

## Runtime Expectations

- Source blend: `art/arenas/sector_3/source/blender/sector_3_ember_circuit_arena.blend`
- Runtime GLB: `art/arenas/sector_3/exported/sector_3_ember_circuit_arena.glb`
- Proof render: `art/arenas/sector_3/review/sector_3_ember_circuit_arena_blender_proof.png`
- Official scene: `scenes/Main.tscn`

The GLB is visual-only. It contains no collision nodes, cameras, lights, scripts,
navigation, or alternate playable scene setup.

## Material Intent

Material names use the `NS_S3_` prefix so Godot can apply Sector 3 readability
overrides consistently.

Key material groups:

- `NS_S3_HR1_Dark_Foundry_Floor`
- `NS_S3_HR1_Raised_Gunmetal_Panel`
- `NS_S3_HR1_Recessed_Heat_Groove`
- `NS_S3_HR1_Charcoal_Border_Wall`
- `NS_S3_HR1_Burnt_Service_Trim`
- `NS_S3_HR1_Dark_Forge_Clamp`
- `NS_S3_HR1_Ember_Neon_Channel`
- `NS_S3_HR1_Yellow_White_Molten_Core`
- `NS_S3_HR1_Dim_Cobalt_Memory_Accent`
- `NS_S3_HR1_Smoked_Heat_Glass`

Face materials stay darker than edge/channel materials. Ember light is contained
inside rails, slots, busways, and node caps so it supports gameplay readability
instead of washing over player, enemies, projectiles, XP, or HUD.

## Collision

Collision strategy: visual-only, no collision.

The asset deliberately avoids collision objects because Phase 53 is a
readability/background foundation pass. Gameplay remains authoritative on the
existing flat X/Z plane.
