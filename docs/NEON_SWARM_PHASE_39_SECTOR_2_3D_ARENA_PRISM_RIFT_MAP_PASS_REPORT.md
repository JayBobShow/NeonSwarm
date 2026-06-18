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
- No physics, collision, spawn, reward, save, Armory, Forge, Evolution, Fusion, or Neon Dust systems are changed.
- The repair pass changes run-bonus weapon runtime activation so `NEW RUN WEAPON` cards enter the active firing arsenal without touching equipped loadout slots.
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

## Repair - Prism Rift Visibility and Run Weapon Autofire

User rejection:

- The first Phase 39 Sector 2 arena was too black.
- The floor did not read clearly.
- It looked like magenta/cyan neon lines over a dark invisible board instead of a readable 3D prism arena.
- The user also reported that selected `NEW RUN WEAPON` rewards did not appear to autofire.

Sector 2 visibility repair:

- Rebuilt the Sector 2 Blender source and GLB.
- Brightened the actual fractured floor materials from near-black violet to readable dark violet/gunmetal.
- Added raised `NS_S2_Readable_Prism_Floor_Face_AAA` and `NS_S2_Amethyst_Glass_Floor_Face_AAA` top-face geometry to every fractured floor cell.
- Kept the fractured/prism identity as modeled deck faces, bevels, and glassy plate surfaces instead of adding more line art.
- Reduced magenta/cyan channel radii and lowered their emission so neon reads as accent detail.
- Increased Sector 2 visual-layer key light and ambient purple light enough for panel faces and bevels to remain visible.
- Kept the old Sector 2 flat HD plate suppressed.
- Kept Sector 1, Sector 3, and Sector 4 presentation paths unchanged.

Run weapon autofire audit result:

- Current `NEW RUN WEAPON` card paths are the Fractal Shard upgrade cards using `fractal_shard_enable`.
- The selected reward was already tracked in `_run_bonus_weapon_definitions`, and the run-bonus HUD could show it.
- The bug risk was real: active weapon state was primarily rebuilt from `_equipped_weapon_instances`, with only a Fractal-specific refresh path afterward.
- The repair makes run-bonus definitions part of the active runtime weapon set during `_rebuild_weapon_stat_bonuses()`.
- `_activate_run_bonus_weapon("fractal_shard", true)` now marks the run bonus active, refreshes weapon state, updates the run-bonus HUD, and primes the Fractal Shard timer to `0.0`.
- The next unpaused `_update_weapons()` call includes Fractal Shard through `_weapon_state["fractal_shard"]["enabled"] == true`.
- The run bonus does not append to or replace `_equipped_weapon_instances`.
- The right-side `8` equipped weapon HUD remains unchanged.
- Run bonus state clears on title entry, start-run reset, return-to-title, restart, death, and run complete.

Validation run after repair:

- `godot --headless --path . --script /tmp/neon_swarm_phase39_repair_validate.gd`: passed with `PHASE39_REPAIR_PASS sector2_meshes=466 equipped_slots=8`.

Focused repair validation confirms:

- Sector 2 repaired GLB exists and loads.
- Sector 2 imports at least `450` mesh instances; observed `466`.
- `Sector2ReadablePrismFloorFace*` and `Sector2ReadableAmethystFloorFace*` meshes import.
- `NS_S2_Readable_Prism_Floor_Face_AAA` and `NS_S2_Amethyst_Glass_Floor_Face_AAA` materials import.
- Runtime material overrides for the repaired floor faces are not blacked out.
- Sector 2 remains collisionless and keeps the old HD Prism Rift plate suppressed.
- Player ripple, enemy arrays, XP/projectile arrays, boss reward console, and the right-side `8` equipped HUD initialize.
- `NEW RUN WEAPON` Fractal Shard does not alter `_equipped_weapon_instances`.
- Fractal Shard is tracked through `_run_bonus_weapon_definitions`.
- Fractal Shard enables `_weapon_state["fractal_shard"]`.
- Fractal Shard timer is primed to `0.0` on selection.
- The run-bonus HUD indicator appears.
- The active `_update_weapons()` loop fires a `fractal_shard` projectile when a target is in range.
- Run-bonus Fractal Shard survives `_rebuild_weapon_stat_bonuses()`.
- Run-bonus Fractal Shard clears through cleanup, run complete, and death paths.

Manual repair test focus:

- Start a run with all `8` equipped loadout slots full and Fractal Shard not equipped.
- Select a `NEW RUN WEAPON` Fractal Shard reward card.
- Confirm `RUN BONUS WEAPONS / FRACTAL SHARD` appears below the right-side equipped stack.
- Confirm Fractal Shard fires automatically shortly after selection.
- Confirm the right-side `8` equipped loadout slots do not change.
- Take another reward/stat rebuild and confirm Fractal Shard remains active for the current run.
- Die, restart, return to title, or complete the run and confirm the run-only weapon is cleared.
- Clear Sector 1, enter Sector 2, and confirm the repaired Prism Rift floor has visible violet/gunmetal prism panels, raised amethyst/glass faces, bevels, and readable fractured geometry rather than a black void with neon lines.

## Studio Rule Update - Blender Documentation-First Art Workflow

Current Sector 2 approval status:

- The Phase 39 Sector 2 Prism Rift arena remains visually rejected after the repair pass.
- User rejection reasons: messy neon strips, weak glass/prism read, unconvincing professional floor modeling, and visual identity that still does not meet the target for Prism Rift.
- The `NEW RUN WEAPON` autofire repair remains preserved and is not part of this art-rule update.

Permanent rule added:

- Every Blender asset task must complete a documentation, reference, and virtual-role checklist before modeling, scripting, exporting, or integrating art.
- The rule applies to all Blender work and is mandatory for environment, arena, and hard-surface work.
- Codex must read relevant official Blender Manual pages, identify the required Blender tools/workflows, review reputable tutorial/reference material for the target style, avoid copying copyrighted models/textures/layouts/designs, delegate to the correct virtual art roles, and verify the result in Blender and in Godot at actual gameplay camera distance.
- The asset must be rejected internally if it only looks good in a report, isolated render, object count, or validation pass but does not read in gameplay.

Required virtual roles for future Blender environment work:

- Environment Art Director.
- Blender Hard-Surface Environment Artist.
- Material / Lighting Artist.
- Godot Technical Artist.
- Gameplay Readability QA.

Required future report evidence:

- Official Blender docs/manual pages referenced.
- Outside tutorial/reference categories reviewed.
- What was learned from those references.
- Which virtual roles were delegated.
- What each role approved or rejected.
- Blender source path.
- GLB export path.
- In-game screenshot or manual test instructions.
- Whether the asset reads correctly at gameplay camera distance.
- Honest limitations and any unapproved visual risks.

Documentation locations:

- Primary permanent rule: `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- Geometry approval status and risk tracking: `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- Sector roadmap status: `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- Phase 39 rejection/studio-rule note: this report

Sector 2 Prism Rift direction going forward:

- Do not continue by adding random neon line overlays.
- Do not rely on purple/magenta line work over dark floor material.
- The next Sector 2 art repair must use reference-backed hard-surface and glass/prism workflows.
- The target remains a readable fractured prism/glass sci-fi arena with visible floor material, readable modeled surface, professional direction, and clear gameplay-camera readability.
