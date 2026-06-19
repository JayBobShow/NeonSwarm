# Sector 2 Subsector Arena Art Notes

Phase 49 adds visual-only subsector variants for Sector 2, Prism Rift.

The existing `sector_2_prism_rift_arena.glb` remains the 2.0 Prism Gate base
arena. The 2A-2D GLBs are full visual arena-layout variants loaded instead of
the 2.0 base arena for their specific Sector 2 campaign subsectors.

Primary reference:

- `art/reference/sector_2_prism_rift/sector_2_reference_sheet.png`

Reference panel mapping:

- Panel 1: `2.0 Prism Gate` / current approved base arena.
- Panel 2: `2A Mirror Flats` / broad reflective prism floor.
- Panel 3: `2B Fracture Hall` / broken cracked hall.
- Panel 4: `2C Violet Glassway` / long lens-node route.
- Panel 5: `2D Rift Lens` / focal lens approach to Veyraxis.

The PNG is not used as a texture or decal. It is translated into modeled
hard-surface/glass layouts using the existing `NS_S2_HR3_*` material family.

## Variant Identity

- 2A Mirror Flats: broad mirrored prism plates, symmetric reflective panel
  fields, side mirror rails, horizontal headers, and edge prism clusters.
- 2B Fracture Hall: broken split floor plates, a central cracked glass path,
  magenta rift split geometry, fractured cross ribs, and wall prism ribs.
- 2C Violet Glassway: a deliberate long glass route with three lens nodes,
  raised side structures, route end frames, and a controlled magenta core.
- 2D Rift Lens: a large focal lens construction with ring stack, central eye
  core, radial focusing ribs, prism towers, approach frames, and a heavier boss
  approach wall.

## Safety Rules

- Meshes are visual-only. They do not include `CollisionObject3D`,
  `CollisionShape3D`, `Area3D`, gameplay scripts, cameras, lights, or navigation
  nodes in the exported runtime GLBs.
- 2.0 keeps the approved base Sector 2 Prism Rift arena.
- 2A-2D are not random neon lines, random decals, random boxes, or flipped
  copies of the same room.
- Gameplay remains on the existing flat plane with unchanged movement, camera,
  collision, weapons, rewards, Memory Shards, and campaign progression.
- Sector 1, Sector 3, Sector 4, Sector 5, final boss, and ending content are
  not part of this pass.

## Source And Exports

- Source generator:
  `art/arenas/sector_2/source/blender/build_sector_2_subsector_arena_kit.py`
- Source blend:
  `art/arenas/sector_2/source/blender/sector_2_subsector_arena_kit.blend`
- Runtime exports:
  `art/arenas/sector_2/exported/sector_2_mirror_flats.glb`
  `art/arenas/sector_2/exported/sector_2_fracture_hall.glb`
  `art/arenas/sector_2/exported/sector_2_violet_glassway.glb`
  `art/arenas/sector_2/exported/sector_2_rift_lens.glb`
