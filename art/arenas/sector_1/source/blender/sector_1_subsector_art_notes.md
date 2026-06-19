# Sector 1 Subsector Arena Art Notes

Phase 48 adds visual-only subsector variants for Sector 1, Neon Grid.

The existing `sector_1_neon_grid_arena.glb` remains the base 1.0 Awakening
Grid arena. The new 1A-1D GLBs are additive visual overlays loaded only for
Sector 1 campaign subsectors.

## Variant Identity

- 1A Relay Yard: relay pads, cyan signal paths, and low perimeter relay banks.
- 1B Data Trench: long recessed memory channels, bridge plates, and broken data
  strips.
- 1C Capacitor Field: capacitor plates, charge wells, perimeter charge banks,
  and restrained energy conduits.
- 1D Rail Approach: long rail lines, sleeper plates, cool warning strips, and a
  north defense-gate approach for Grix.

## Safety Rules

- Meshes are visual-only. They do not include `CollisionObject3D`,
  `CollisionShape3D`, `Area3D`, gameplay scripts, cameras, lights, or navigation
  nodes.
- All materials use the `NS_S1_` prefix so the existing Godot Sector 1 material
  visibility pass applies.
- Geometry stays low to the floor and away from player collision assumptions.
- 1.0 keeps the approved base Sector 1 arena.
- Sector 2, Sector 3, Sector 4, Sector 5, weapons, player collision, and boss
  balance are not part of this pass.

## Source And Exports

- Source generator:
  `art/arenas/sector_1/source/blender/build_sector_1_subsector_arena_kit.py`
- Source blend:
  `art/arenas/sector_1/source/blender/sector_1_subsector_arena_kit.blend`
- Runtime exports:
  `art/arenas/sector_1/exported/sector_1_relay_yard.glb`
  `art/arenas/sector_1/exported/sector_1_data_trench.glb`
  `art/arenas/sector_1/exported/sector_1_capacitor_field.glb`
  `art/arenas/sector_1/exported/sector_1_rail_approach.glb`
