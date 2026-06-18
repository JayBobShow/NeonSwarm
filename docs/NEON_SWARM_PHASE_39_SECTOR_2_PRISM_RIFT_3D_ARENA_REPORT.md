# Neon Swarm Phase 39 Sector 2 Prism Rift 3D Arena Report

Date: 2026-06-18

Official project:

- `/home/jason/GodotProjects/NeonSwarm`

Official scene:

- `scenes/Main.tscn`

## Scope

Phase 39 creates a true Sector 2-only 3D arena map pass for Prism Rift while preserving the existing 2D gameplay plane and the official scene path.

This pass does not start Phase 40, does not create alternate playable scenes, does not push, and does not change weapon balance or the core combat loop.

## Implemented Runtime Behavior

- Sector 2 now loads `res://art/arenas/sector_2/exported/sector_2_prism_rift_arena.glb` through the existing runtime GLTF loader path.
- Sector 2 spawns `Sector2PrismRift3DArenaArchitectureRoot` under `SectorGeometryIdentityRoot`.
- The active GLB instance is named `Blender3DSector2PrismRiftArenaModel`.
- Sector 2 suppresses the old flat `sector_2_prism_rift_hd.png` background plate so the Blender arena owns the presentation.
- The legacy 2D arena border is hidden for Sector 2 to avoid double-boundary confusion; the modeled border communicates the arena edge.
- Sectors 3 and 4 continue using their existing HD background plates.
- Sector 1 remains on the Phase 38 Blender arena path.
- `ARENA_HALF_SIZE` remains `28.0`; player movement and clamping stay on the existing X/Z plane.
- The new arena adds no gameplay collision nodes.
- Imported Sector 2 arena meshes have shadow casting and GI disabled.
- Imported `NS_S2_*` materials are boosted in Godot with controlled dark violet metal, magenta channels, cyan refraction accents, and transparent violet glass.

## Blender Assets Created

- `art/arenas/sector_2/source/blender/build_sector_2_prism_rift_arena.py`
- `art/arenas/sector_2/source/blender/sector_2_prism_rift_arena.blend`
- `art/arenas/sector_2/exported/sector_2_prism_rift_arena.glb`

The Blender source builds a floor-first hard-surface environment:

- continuous dark underfloor slab
- fractured triangular and diagonal deck plates
- inset dark seams and prism channels
- central diamond refraction routes
- segmented dark outer boundary walls
- magenta/violet rift rails
- small glassy prism shards and outer crystal structures

## Godot Docs And Classes Referenced

Official Godot 4.6 documentation was referenced for the runtime integration decisions:

- `Node3D`: https://docs.godotengine.org/en/4.6/classes/class_node3d.html
- `MeshInstance3D`: https://docs.godotengine.org/en/4.6/classes/class_meshinstance3d.html
- `GeometryInstance3D`: https://docs.godotengine.org/en/4.6/classes/class_geometryinstance3d.html
- `GLTFDocument`: https://docs.godotengine.org/en/4.6/classes/class_gltfdocument.html
- `PackedScene`: https://docs.godotengine.org/en/4.6/classes/class_packedscene.html
- `StandardMaterial3D`: https://docs.godotengine.org/en/4.6/classes/class_standardmaterial3d.html
- `BaseMaterial3D`: https://docs.godotengine.org/en/4.6/classes/class_basematerial3d.html
- `DirectionalLight3D`: https://docs.godotengine.org/en/4.6/classes/class_directionallight3d.html
- Importing 3D scenes: https://docs.godotengine.org/en/4.6/tutorials/assets_pipeline/importing_3d_scenes/index.html
- 3D lights and shadows: https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html

## Compatibility Notes

- The arena is visual-only.
- No physics, collision, spawn, reward, save, Armory, Forge, Evolution, Fusion, Neon Dust, or weapon runtime systems are changed.
- Phase 37 player ripple nodes remain expected under the player presentation path.
- Phase 38 HUD layout is left intact: left stat stack, right 8-slot equipped weapon stack, no in-game HUD scrolling, and the compact run bonus panel from Hotfix 10 remain unchanged.

## Validation Results

Run before commit:

- `git status`: showed the expected Phase 39 modified/untracked files only.
- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed.
- `godot --headless --path . --script /tmp/neon_swarm_phase39_sector2_prism_rift_validate.gd`: passed with `PHASE39_SECTOR2_PRISM_RIFT_ARENA_PASS mesh_count=394 hud_slots=8`.
- `git diff --check`: passed.
- `git diff --stat`: reviewed before commit.
- `git status`: reviewed before commit and again after commit.

Focused validation confirms:

- Sector 2 GLB exists.
- `ARENA_HALF_SIZE` remains `28.0`.
- Sector 2 creates `Sector2PrismRift3DArenaArchitectureRoot`.
- Sector 2 creates exactly one `Blender3DSector2PrismRiftArenaModel` after rebuild.
- The imported Sector 2 arena has `394` `MeshInstance3D` descendants.
- The imported Sector 2 arena has no `CollisionObject3D` or `CollisionShape3D` descendants.
- The old `HDArtSectorBackgroundPlate_PrismRift` is absent in Sector 2.
- Old procedural `PrismRiftDiamondCell` floor cells remain inactive.
- The old flat arena border/core is hidden for Sector 2.
- Sector 1 Blender arena still initializes.
- Sector 3 Null Zone HD background still initializes.
- Sector 4 Hyper Grid HD background still initializes.
- The Phase 37 player ripple disk initializes.
- The right-side equipped weapon HUD initializes `8` slots and contains no `ScrollContainer`.
- Boss alert and weapon reward console nodes initialize.

## Manual Test Checklist

Run:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Test:

- Clear Sector 1 and enter Sector 2.
- Confirm Sector 2 shows a distinct dark purple/magenta/violet Prism Rift 3D arena.
- Confirm the floor reads as fractured prism deck plates, not a flat HD plate or a recolored Sector 1 grid.
- Confirm the modeled boundary makes the playable arena edge clear.
- Confirm the player never appears visually outside the intended playable area.
- Confirm movement remains flat and unchanged.
- Confirm enemies, projectiles, XP pickups, boss telegraphs, and the player ripple remain readable against the floor.
- Confirm Sectors 1, 3, and 4 retain their existing presentation.
- Pause/restart/return to title and confirm no duplicate Sector 2 arena model appears.
