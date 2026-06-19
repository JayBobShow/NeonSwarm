# Sector 1 Subsector Arena Art Notes

Phase 48 adds visual-only subsector variants for Sector 1, Neon Grid.

The existing `sector_1_neon_grid_arena.glb` remains the 1.0 Awakening Grid
arena. The 1A-1D GLBs are full visual arena-layout variants loaded instead of
the 1.0 base arena for their specific Sector 1 campaign subsectors.

The primary visual guide for this rebuild is the user-provided multi-image
reference sheet:

- `art/reference/sector_1_neon_grid/sector_1_refference_sheet.png`

Its five panels map left-to-right to 1.0 Awakening Grid, 1A Relay Yard, 1B Data
Trench, 1C Capacitor Field, and 1D Rail Approach. The PNG is not used as a
texture or decal; the sheet is translated into modeled hard-surface layouts.

## Variant Identity

- 1A Relay Yard: four large relay stations, a rectangular central
  communications hub, modeled orthogonal cable trays, embedded signal windows,
  short antenna masts, and low perimeter relay banks.
- 1B Data Trench: a dominant central sunken trench, narrower side data
  conduits, raised deck islands, bridge plates, side guards, and broken memory
  panel hardware.
- 1C Capacitor Field: a central power spine, capacitor cell blocks, charge
  wells, perimeter charge banks, side power buses, meters, terminals, and
  contained cell traces.
- 1D Rail Approach: strong transit-corridor composition, physical rail feet,
  raised rail caps, sleeper plates, brackets, side armor ribs, and a heavier
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
- The reference-first correction makes the layout silhouettes match the user
  sheet more directly: rectangular relay hub, readable trench depth, structured
  capacitor-bank field, and a directed rail corridor.

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
