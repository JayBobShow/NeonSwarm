# Neon Swarm Phase 49 Sector 2 Subsector Arena Content Pass Report

Phase 49 builds the Sector 2 Prism Rift subsector arena content pass only. The
pass keeps 2.0 Prism Gate on the approved base Sector 2 arena and adds full
visual runtime arena-layout variants for 2A through 2D.

No Phase 50 work, Sector 3 subsector art, Sector 4 subsector art, Sector 5
runtime content, final boss content, ending sequence, HUD redesign, gameplay
balance change, movement change, collision change, or official scene path
change is included.

## References Checked

- `art/reference/README.md`
- `art/reference/sector_2_prism_rift/README.md`
- `art/reference/sector_2_prism_rift/sector_2_reference_sheet.png`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_CAMPAIGN_STRUCTURE_PLAN.md`
- `docs/NEON_SWARM_PHASE_39_SECTOR_2_3D_ARENA_PRISM_RIFT_MAP_PASS_REPORT.md`
- Existing Sector 2 arena source and notes under
  `art/arenas/sector_2/source/blender/`

The Sector 2 user reference sheet is the primary visual guide. It is a
1408x768 multi-image PNG titled `SECTOR 2 REFERENCE SHEET -- PRISM RIFT`.

Reference panel mapping:

- Panel 1: `2.0 Prism Gate` / current approved base arena.
- Panel 2: `2A Mirror Flats` / reflective prism floor.
- Panel 3: `2B Fracture Hall` / cracked hall.
- Panel 4: `2C Violet Glassway` / long route with lens nodes.
- Panel 5: `2D Rift Lens` / final focusing lens approach.

Copied as design intent: purple/magenta/violet prism mood, large readable glass
floor faces, controlled reflection, broken hall plates, long glassway route
logic, focal lens construction, dark sci-fi rift supports, and boundary
architecture.

Not copied directly: the PNG is not used as a texture, decal, flat board, or
image plane. The Blender generator rebuilds the concepts as real low-profile
3D geometry with project materials.

## Official Docs Reviewed

Blender official documentation reviewed:

- Bevel Modifier:
  `https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/bevel.html`
- Weighted Normal Modifier:
  `https://docs.blender.org/manual/en/latest/modeling/modifiers/normals/weighted_normal.html`
- Mesh Normals:
  `https://docs.blender.org/manual/en/latest/modeling/meshes/editing/mesh/normals.html`
- Principled BSDF:
  `https://docs.blender.org/manual/en/latest/render/shader_nodes/shader/principled.html`
- Materials:
  `https://docs.blender.org/manual/en/latest/render/materials/index.html`
- glTF / GLB Export:
  `https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html`
- Blender Python API:
  `https://docs.blender.org/api/current/index.html`

Workflow categories reviewed from the approved visual workflow lock: modular
sci-fi floor construction, hard-surface paneling, readable bevels at the
top-down gameplay camera, glass/prism/refraction material setup, neon channel
integration as structural accent, and avoiding flat-grid/random-strip/glow-only
visuals. No third-party design was copied.

## Role Delegation Summary

- Environment Art Director: use the Sector 2 reference sheet as the primary
  layout source and keep all variants in the Prism Rift family.
- Blender Hard-Surface Environment Artist: build modeled plates, ribs, glass
  inserts, focal rings, route structures, prism shards, and readable boundary
  architecture instead of random decals or line overlays.
- Material / Lighting Artist: reuse the existing `NS_S2_HR3_*` material family
  so Godot material visibility boosts keep glass/floor faces readable and avoid
  black-collapse.
- Godot Technical Artist: integrate variants through the Phase 48 runtime
  pattern, keep 2.0 on the approved base GLB, and keep Rift Lens active through
  the Veyraxis boss gate.
- Gameplay Readability QA: validate campaign switching, no duplicate base
  arena on 2A-2D, no collision nodes in variant imports, Veyraxis after 2D,
  Memory Shard II after Veyraxis, and preserved Phase 47/48 flow.

## Blender Assets Created

- Source generator:
  `art/arenas/sector_2/source/blender/build_sector_2_subsector_arena_kit.py`
- Source blend:
  `art/arenas/sector_2/source/blender/sector_2_subsector_arena_kit.blend`
- Source notes:
  `art/arenas/sector_2/source/blender/sector_2_subsector_art_notes.md`

Runtime GLB exports:

- `art/arenas/sector_2/exported/sector_2_mirror_flats.glb`
- `art/arenas/sector_2/exported/sector_2_fracture_hall.glb`
- `art/arenas/sector_2/exported/sector_2_violet_glassway.glb`
- `art/arenas/sector_2/exported/sector_2_rift_lens.glb`

The generator sets bevels, weighted normals, Principled BSDF materials, and GLB
exports. The new GLBs are visual-only and contain no collision, cameras, lights,
scripts, navigation, or alternate playable scene setup.

## Runtime Integration

Runtime integration is in `scripts/NeonSwarm3DGameplayPrototype.gd`.

- Sector 2 campaign data now includes `arena_variant_key` only for 2A-2D.
- `SECTOR2_SUBSECTOR_ARENA_SCENE_PATHS` maps those keys to exported GLBs.
- `_create_sector2_prism_rift_3d_architecture()` creates the approved base
  Sector 2 arena only for 2.0.
- `_create_sector2_subsector_arena_variant()` loads the current 2A-2D full
  layout under `Sector2SubsectorArenaVariantRoot`.
- `_current_sector2_subsector_arena_variant_key()` returns no variant for 2.0,
  returns the current 2A-2D key during normal subsectors, and lets Rift Lens
  persist into the Veyraxis boss gate after 2D.
- The existing Sector 2 material visibility pass is applied to the imported
  variant root.

No player collision, hurtbox, arena bounds, enemy behavior, boss timing, reward
logic, Memory Shard logic, weapon balance, or official scene path was changed.

## Visual Identity

- 2A Mirror Flats: broad mirrored prism floor plates, controlled symmetry,
  shallow reflective panels, side mirror rails, horizontal headers, and edge
  prism clusters.
- 2B Fracture Hall: broken split floor plates, central cracked glass path,
  embedded magenta rift split geometry, fractured cross ribs, and wall prism
  ribs.
- 2C Violet Glassway: long route foundation, central glass channel, three lens
  nodes, raised violet side structures, route end frames, and controlled
  magenta route core.
- 2D Rift Lens: large focal lens construction, central magenta/cyan eye, radial
  focusing ribs, prism tower structures, approach frames, and a heavier north
  boss approach wall.

## Manual Test Checklist

- Start a run and use F6/F11 test flow to reach Sector 2.
- Confirm 2.0 Prism Gate uses the approved base Sector 2 arena.
- Confirm 2A loads Mirror Flats as a full modeled layout.
- Confirm 2B loads Fracture Hall as a full modeled layout.
- Confirm 2C loads Violet Glassway as a full modeled layout.
- Confirm 2D loads Rift Lens as a full modeled layout.
- Confirm the boss gate after 2D still leads to Veyraxis, Prism Widow.
- Confirm Prism Shard II still unlocks after Veyraxis.
- Confirm player core, ripple, XP, enemies, bullets, HUD, Lyra, story cards,
  Memory Shard reveal, and reward/comparison panels remain readable.
- Confirm Sector 3 subsector art, Sector 5 runtime, and ending content are not
  present.

## Deferred

- Sector 3 subsector arena content is deferred to Phase 50.
- Sector 4 subsector arena content is deferred to Phase 51.
- Sector 5 / Black Crown runtime remains future-only.
- Ending sequence remains future-only.
