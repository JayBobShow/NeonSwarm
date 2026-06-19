# Sector 1 Subsector Arena Art Notes

Phase 48 adds visual-only subsector variants for Sector 1, Neon Grid.

The existing `sector_1_neon_grid_arena.glb` remains the 1.0 Awakening Grid
arena. The 1A-1D GLBs are full visual arena-layout variants loaded instead of
the 1.0 base arena for their specific Sector 1 campaign subsectors.

## Variant Identity

- 1A Relay Yard: raised relay-node hardware, modeled cable trays, embedded
  signal windows, short antenna masts, and low perimeter relay banks.
- 1B Data Trench: long recessed memory channels, bridge plates, and broken data
  panel hardware.
- 1C Capacitor Field: capacitor plates, charge wells, perimeter charge banks,
  side power buses, and contained cell traces.
- 1D Rail Approach: long rail lines, sleeper plates, cool warning strips, and a
  north defense-gate approach for Grix.

Phase 48 hotfix notes:

- Removed the first-pass random decorative neon line families:
  `RelayYardReadableSignalLine`, `DataTrenchBrokenMemoryStrip`,
  `CapacitorFieldLowEnergyConduit`, and `RailApproachCoolWarningStrip`.
- Replaced them with modeled hard-surface arena identity: tray beds and lips,
  recessed trench lanes with bridge plates, capacitor housings and terminals,
  physical rail feet, rail caps, brackets, corridor walls, and gate hardware.
- Neon now appears as embedded windows, sockets, meters, lock faces, and power
  cores attached to the modeled structures.
- The art-direction correction stops stacking 1A-1D over the same base room.
  Each subsector export includes its own floor foundation, boundary frame, and
  large layout landmarks.

## Safety Rules

- Meshes are visual-only. They do not include `CollisionObject3D`,
  `CollisionShape3D`, `Area3D`, gameplay scripts, cameras, lights, or navigation
  nodes.
- All materials use the `NS_S1_` prefix so the existing Godot Sector 1 material
  visibility pass applies.
- Geometry stays low to the floor and away from player collision assumptions.
- 1.0 keeps the approved base Sector 1 arena.
- 1A-1D are not decal layers, random line overlays, or small-box decoration
  passes over the 1.0 room.
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
