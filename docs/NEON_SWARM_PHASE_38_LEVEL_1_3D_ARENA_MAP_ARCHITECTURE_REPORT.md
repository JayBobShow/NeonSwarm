# Neon Swarm Phase 38 Level 1 3D Arena Map Architecture Report

Date: 2026-06-18

## Scope

Phase 38 adds the first real 3D arena map architecture prototype for Level 1 / Sector 1 - Neon Grid only.

- Project: `/home/jason/GodotProjects/NeonSwarm`
- Official scene: `scenes/Main.tscn`
- Official runtime script: `scripts/NeonSwarm3DGameplayPrototype.gd`
- No alternate playable scene was created.
- No Phase 39 work was started.
- Player movement, enemy movement, projectile logic, XP collection, weapons, bosses, events, Armory, Forge, Evolution/Fusion, Neon Dust, UI, controller support, save paths, and the Phase 37 propulsion ripple were preserved.

## Godot Docs / Classes Referenced

- `Node3D`: `https://docs.godotengine.org/en/stable/classes/class_node3d.html`
- `MeshInstance3D`: `https://docs.godotengine.org/en/stable/classes/class_meshinstance3d.html`
- `StandardMaterial3D`: `https://docs.godotengine.org/en/stable/classes/class_standardmaterial3d.html`
- `BaseMaterial3D`: `https://docs.godotengine.org/en/stable/classes/class_basematerial3d.html`
- Imported 3D scenes: `https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/index.html`
- `GLTFDocument`: `https://docs.godotengine.org/en/stable/classes/class_gltfdocument.html`
- `PackedScene`: `https://docs.godotengine.org/en/stable/classes/class_packedscene.html`
- `Camera3D`: `https://docs.godotengine.org/en/stable/classes/class_camera3d.html`
- `DirectionalLight3D`: `https://docs.godotengine.org/en/stable/classes/class_directionallight3d.html`
- 3D lights and shadows / light-count performance guidance: `https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html`

Why these were chosen:

- `Node3D` is the documented base for 3D scene-space hierarchy and transforms, so the arena architecture is organized as Sector 1-only `Node3D` roots under the existing `SectorGeometryIdentityRoot`.
- `MeshInstance3D` is the documented 3D mesh instance node, so the imported Blender GLB is validated as real mesh-based 3D architecture rather than 2D background art.
- `StandardMaterial3D` and `BaseMaterial3D` provide the documented material properties used for opaque aluminum/gunmetal panel faces: albedo, metallic, roughness, specular strength, and restrained emission.
- The imported 3D scene docs, `GLTFDocument`, and `PackedScene` match the existing runtime GLB loading path: the GLB is read, converted into a Godot node tree, packed/cached, and instantiated under the Sector 1 geometry root.
- `Camera3D` documents the orthographic size used to fix the visible playfield mismatch without changing gameplay bounds.
- `DirectionalLight3D` and the 3D lighting docs were reviewed for the metal readability pass, but the hotfix did not add a new dynamic light because the floor uses controlled material sheen and existing environment light.
- The 3D lighting docs note renderer limits/performance costs for many dynamic lights, so Phase 38 uses emissive materials and existing environment tone instead of adding new dynamic light spam.

## Delegation

The Scene Architecture Lead inspected the official runtime and identified the safe integration point:

- Add Sector 1 architecture below `SectorGeometryIdentityRoot`.
- Rebuild only through `_rebuild_sector_geometry_identity()`.
- Keep raised walls collisionless and outside the gameplay clamp.
- Preserve `ARENA_HALF_SIZE` and the existing X/Z gameplay plane.
- Keep the Phase 37 ripple at its current player-following root.

The Technical Art Lead specified the Blender kit footprint and material separation:

- 7x7 modeled floor panels centered at `-24, -16, -8, 0, 8, 16, 24`.
- Raised rails/walls at the existing `ARENA_HALF_SIZE = 28.0` border.
- Dark opaque aluminum/gunmetal metal as the dominant floor material.
- Thin cyan neon geometry only for seams/rails so the Phase 37 blue propulsion ripple stays readable.

## 3D Arena Architecture Added

Added a Sector 1-only visual root:

- `Sector1NeonGrid3DArenaArchitectureRoot`

Active child:

- `Blender3DSector1NeonGridArenaModel`

Level 1 / Sector 1 visual elements:

- One Blender-authored GLB arena kit instanced under the Sector 1 geometry root.
- 49 modeled aluminum/gunmetal floor panels with actual thickness and bevels.
- Inset top plates, anchor blocks, sparse sheen strips, and thin gaps/seams between panels.
- Separate cyan neon seam geometry and top rail geometry.
- Raised border wall pieces aligned to the existing arena boundary.
- Corner pylon/anchor assemblies with metal bases, pylon cores, and cyan caps.
- Subtle out-of-bounds buttresses and far rails to create background depth without implying playable paths.

## Gameplay Plane Preservation

Gameplay remains locked to the existing 2D X/Z movement plane:

- `ARENA_HALF_SIZE` was not changed.
- Player movement and enemy chase logic were not changed.
- No `Area3D`, `StaticBody3D`, `CollisionShape3D`, or other collision nodes were added for the arena architecture.
- Raised walls and depth pieces are visual-only `Node3D` / `MeshInstance3D` nodes.
- The player, enemies, bullets, XP, and events continue using the existing gameplay systems.

## Blender Floor Panel Foundation

The active Level 1 floor is now built in Blender, not assembled from runtime box/tube helpers:

- Source: `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`
- Runtime GLB: `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`
- Rebuild script: `art/arenas/sector_1/source/blender/build_sector_1_neon_grid_arena.py`
- Panel count: 49 modeled panels in a 7x7 grid.
- Panel centers: `-24, -16, -8, 0, 8, 16, 24` on the gameplay X/Z footprint.
- Panel size: approximately `7.18 x 7.18 x 0.16` world units.
- Border walls and top rails align at `+/-28.0`, matching `ARENA_HALF_SIZE`.

The prior procedural Phase 38 builders remain in the file as inactive utilities, but `_create_sector1_neon_grid_3d_architecture()` now instances the Blender GLB only. `_sector1_arena_panel_motion` stays empty, so no procedural panel pulse runs in the active hard repair.

## Future Darker Arena Support

The architecture is separated from gameplay and tied to Sector 1 identity only. Future sectors can use the same pattern:

- sector-specific materials
- sector-specific floor plate layouts
- sector-specific border architecture
- sector-specific brightness and background depth
- no gameplay collision unless explicitly approved

For Level 1, the floor remains readable: opaque aluminum/gunmetal Blender panel faces are paired with thin cyan emissive seams and sparse sheen strips. The older flat Sector 1 HD plate, low-alpha floor underlay, and Phase 38 procedural tile roots are disabled so the Phase 37 blue propulsion ripple reads on top of actual 3D geometry.

## Collision / Readability Safeguards

- Visual walls align to the authoritative `ARENA_HALF_SIZE` arena boundary while the player center remains clamped inside that boundary.
- The `Camera3D` orthographic size is now `47.5`, so the existing `ARENA_HALF_SIZE` playfield and Sector 1 visual border fit inside a 1280x720 gameplay viewport.
- Decorative depth pieces sit beyond the walls.
- No ramps or raised platforms were added inside the gameplay area.
- The Blender floor stays visual-only and does not imply vertical gameplay.
- No HUD/menu/title UI was changed.
- The Phase 37 player ripple was not redesigned or removed.

## Performance Safeguards

- All arena nodes are persistent.
- No per-frame node creation.
- No dynamic lights added.
- The Blender GLB is loaded through the existing `GLTFDocument` path and cached as a `PackedScene` for reuse.
- The active Sector 1 arena is one persistent GLB node tree, created only during sector identity rebuild.
- Imported arena `GeometryInstance3D` nodes have shadow casting disabled after instancing.
- MeshInstance3D draw calls are bounded and Sector 1-only.
- Sector geometry root is cleared/rebuilt by the existing sector identity path, preventing duplicate architecture on sector changes.

## Phase 38 Hotfix - Arena Bounds and Aluminum Floor Tile Rebuild

Phase 38 was not approved initially because testing showed two visible failures:

- The player could travel outside the visible play area.
- The Sector 1 arena still read as an old flat background instead of a real 3D floor.

Root cause of the bounds issue:

- Gameplay bounds were still the original `ARENA_HALF_SIZE = 28.0`, with player center clamp at +/-27.0.
- The camera remained at orthographic size `35.0`, which did not show the full gameplay square at the normal 1280x720 view.
- Phase 38 visual rails extended past the existing arena boundary, making the camera/gameplay mismatch more obvious.

Bounds/screen-fit fix:

- `ARENA_HALF_SIZE` was preserved to avoid rebalancing gameplay, enemy spawning, bosses, projectiles, XP, and events.
- `Camera3D.size` now uses `GAMEPLAY_CAMERA_SIZE = 47.5`.
- `Camera3D.position` remains `Vector3(0.0, 31.0, 24.0)`.
- Sector 1 visual border rails now align to `ARENA_HALF_SIZE` instead of extending beyond it.
- Focused validation confirms the player clamp corners and visible arena border are inside a 1280x720 camera frustum.

Old background disabled:

- `_create_neon_grid_background_depth()` is now a Sector 1 no-op.
- This prevents `HDArtSectorBackgroundPlate_NeonGrid` and the old Sector 1 HD light runners from being created.
- Sectors 2-4 still use `_build_hd_sector_background()` and their existing HD background plates.

Aluminum floor tile rebuild:

- Sector 1 floor is now a 7x7 grid of `MeshInstance3D` box tiles.
- Tile faces use opaque `StandardMaterial3D` materials instead of the previous blue-black shader faces.
- Panel gaps and cyan tube linework form the tile seams.
- Sparse `Sector1AluminumReflectionStreak*` meshes add restrained fake neon sheen without adding real reflections or dynamic lights.
- The flat cyan underlay plane was removed.

Material settings used:

- `Sector1DarkBrushedAluminumPanel`: albedo `Color(0.115, 0.125, 0.135)`, metallic `0.78`, roughness `0.47`, subtle blue-green emission `0.055`.
- `Sector1RaisedGunmetalPanel`: albedo `Color(0.155, 0.170, 0.178)`, metallic `0.82`, roughness `0.42`, subtle blue-green emission `0.075`.
- `Sector1GunmetalBorderWall`: albedo `Color(0.080, 0.096, 0.112)`, metallic `0.72`, roughness `0.54`.
- `Sector1DarkAluminumDepthPlate`: albedo `Color(0.044, 0.056, 0.074)`, metallic `0.48`, roughness `0.72`.
- `Sector1AluminumReflectionStreak*`: low-alpha cyan emissive strips for controlled fake reflectivity.

Gameplay remains locked to the 2D plane:

- No arena collision nodes were added.
- `ARENA_HALF_SIZE` and gameplay clamp/spawn systems remain unchanged.
- Player/enemy/projectile/XP/event systems continue to use their existing X/Z logic.
- The Phase 37 blue propulsion ripple remains above the tile surface and was not weakened.

Hotfix-focused validation confirms:

- No `HDArtSectorBackgroundPlate_NeonGrid` is created.
- `Sector1NeonGrid3DArenaArchitectureRoot` still initializes.
- The intermediate 49 runtime aluminum panels initialized before this hard repair; the active hard repair validation confirms those procedural panels are now bypassed in favor of the Blender GLB.
- The intermediate sample floor panel used `StandardMaterial3D` with metallic/roughness settings before the Blender hard repair superseded it.
- Player clamp corners and visible arena bounds fit the 1280x720 `Camera3D` frustum.
- No collision nodes exist under the Sector 1 architecture root.
- Phase 37 propulsion ripple root remains present.
- Enemy, projectile, and XP arrays initialize.
- Reapplying sector visual identity does not duplicate arena nodes or restore the old Sector 1 HD plate.

## Hard Repair - Blender-Built Level 1 3D Arena Kit

The previous Phase 38 result was rejected because, even after the bounds/aluminum hotfix, it still read as a runtime procedural grid of flat boxes and tubes instead of an authored 3D arena map.

Blender source created:

- `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`

Runtime GLB exported:

- `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`

Source build script retained:

- `art/arenas/sector_1/source/blender/build_sector_1_neon_grid_arena.py`

How the arena is modeled:

- 49 real modeled floor panels with thickness and bevels.
- Inset metal top plates on each panel.
- Small anchor/bolt blocks on panels for surface detail.
- Sparse low-intensity metal sheen strips for reflective-looking highlights.
- Separate cyan neon seam bars crossing between panels.
- Raised gunmetal border walls at the `+/-28.0` arena edge.
- Cylindrical cyan top rails on each border.
- Corner pylon assemblies with metal bases, vertical cores, and cyan caps.
- Out-of-bounds buttress blocks and far cyan rails for subtle background depth.

Godot integration:

- `scripts/NeonSwarm3DGameplayPrototype.gd` defines `SECTOR1_BLENDER_ARENA_SCENE_PATH`.
- `_create_sector1_neon_grid_3d_architecture()` now creates `Sector1NeonGrid3DArenaArchitectureRoot` and calls `_create_sector1_blender_arena_kit()`.
- `_create_sector1_blender_arena_kit()` uses the existing `_add_blender_asset_instance()` helper with child name `Blender3DSector1NeonGridArenaModel`.
- The existing `_load_blender_asset_scene()` path uses `GLTFDocument.append_from_file()`, `generate_scene()`, and `PackedScene.pack()` to cache the imported GLB before instancing it.
- `_configure_sector1_blender_arena_visuals()` disables shadow casting on imported `GeometryInstance3D` nodes to avoid unnecessary lighting cost.

Procedural arena bypassed:

- `_create_sector1_floor_panel_foundation()` is no longer called.
- `_create_sector1_cyan_grid_linework()` is no longer called.
- `_create_sector1_raised_border_architecture()` is no longer called.
- `_create_sector1_background_depth_architecture()` is no longer called.
- Focused validation confirms zero `Sector1FloorPanelR*`, `Sector1DarkFloorPanelFoundationRoot`, `Sector1CyanGridLineRoot`, `Sector1RaisedBorderWallRailRoot`, and `Sector1SubtleBackgroundDepthRoot` nodes in the active Sector 1 scene.

Bounds and screen fit:

- `ARENA_HALF_SIZE` remains `28.0`.
- The player center clamp remains inside the existing gameplay boundary at `+/-27.0`.
- The Blender border walls/rails are placed at `+/-28.0`, matching the real arena boundary.
- `GAMEPLAY_CAMERA_SIZE` remains `47.5`; focused validation confirms player clamp corners and visible rail bounds fit the 1280x720 `Camera3D` frustum.

Material settings used in Blender:

- `NS_S1_Dark_Brushed_Aluminum`: base `(0.105, 0.116, 0.125)`, metallic `0.82`, roughness `0.46`, subtle blue-green emission `0.045`.
- `NS_S1_Raised_Gunmetal_Panel`: base `(0.150, 0.164, 0.174)`, metallic `0.86`, roughness `0.39`, subtle emission `0.055`.
- `NS_S1_Beveled_Edge_Gunmetal`: base `(0.065, 0.078, 0.092)`, metallic `0.76`, roughness `0.52`.
- `NS_S1_Dark_Depth_Metal`: base `(0.040, 0.050, 0.064)`, metallic `0.58`, roughness `0.66`.
- `NS_S1_Cyan_Neon_Channel`: cyan emission strength `2.60`.
- `NS_S1_White_Cyan_Hot_Core`: pale cyan emission strength `4.20`.
- `NS_S1_Cool_Aluminum_Sheen`: controlled cool sheen, metallic `0.35`, roughness `0.18`, emission `0.18`.

Gameplay remains locked to the 2D plane:

- No arena collision nodes were exported or added.
- Focused validation confirms no `CollisionObject3D` or `CollisionShape3D` under `Blender3DSector1NeonGridArenaModel`.
- Player movement, enemy movement, projectile logic, XP, bosses, events, UI, save, controller support, and Phase 37 ripple were not changed.

Manual test focus:

- Confirm the arena now reads as an authored 3D Blender kit rather than a flat procedural grid.
- Confirm the player cannot leave the visible arena.
- Confirm rails/walls match the actual movement boundary.
- Confirm enemies, XP, bullets, event objectives, and the Phase 37 ripple remain readable.
- Confirm pause/restart/return-to-title do not duplicate the arena model.

## Hard Repair 2 - Remove Debug Grid Look and Strengthen 3D Aluminum Arena Read

The previous Blender-built result was rejected because the in-game read was still too flat and grid-board-like. The screenshot feedback called out a giant bright cross through the floor, marker-like glowing corner dots, weak visible 3D relief, and not enough aluminum/gunmetal material presence.

Diagnosis:

- `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb` was being loaded in the official Sector 1 runtime as `Blender3DSector1NeonGridArenaModel`.
- The old Phase 38 procedural roots (`Sector1DarkFloorPanelFoundationRoot`, `Sector1CyanGridLineRoot`, `Sector1RaisedBorderWallRailRoot`, and `Sector1SubtleBackgroundDepthRoot`) were not active in the official Sector 1 runtime.
- The generic Godot arena grid nodes (`ArenaGridMinorLines`, `ArenaGridMajorLines`, and `ArenaGridAxisLines`) were already hidden, but the generic `ArenaBorderColoredTube` and `ArenaBorderWhiteHotCore` still sat on top of the Sector 1 GLB before this repair.
- The large debug-looking white/cyan cross came from the Blender GLB source itself: the previous `create_neon_seams()` generated full-length bright `Sector1BlenderNeonSeamX*` and `Sector1BlenderNeonSeamY*` bars using `NS_S1_White_Cyan_Hot_Core`.
- The top-down orthographic gameplay camera compressed shallow floor relief, so the previous `0.16` panel thickness, `0.075` bevels, tiny inset plates, and bright emissive seams made the floor read more like a flat neon board than modeled metal.

What was removed:

- Full-length `Sector1BlenderNeonSeamX*` and `Sector1BlenderNeonSeamY*` bright seam bars.
- `NS_S1_White_Cyan_Hot_Core` material usage from the Sector 1 Blender arena kit.
- Bright `Sector1BlenderCornerPylonCyanCap*` cap markers.
- Sector 1 runtime visibility for the generic `ArenaBorderColoredTube` and `ArenaBorderWhiteHotCore` overlay. Those generic borders still remain available for non-Sector-1 visual identities.

Blender geometry changes:

- Regenerated `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`.
- Re-exported `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`.
- Increased floor panel thickness from `0.16` to `0.34`.
- Increased primary panel bevels from `0.075` to `0.135`.
- Increased inset plate height and bevel so panel tops have a visible metal layer.
- Added four raised dark metal lips per panel for physically modeled seams instead of relying on flat cyan lines.
- Added two brushed dark groove details per panel.
- Reduced per-panel marker clutter from four bright/dot-like anchors to two darker rectangular metal anchors.
- Replaced full-length bright grid lines with recessed dark metal seam channels plus short, dim cyan embedded accent segments.
- Raised border walls were increased to `1.06` height with `0.150` bevels so side faces read at gameplay zoom.
- Corner pylons now use dark metal caps with small cyan side slits rather than bright top-dot caps.
- Far cyan rails were thinned to keep depth accents behind the arena from overpowering the floor.

Material changes:

- `NS_S1_Dark_Brushed_Aluminum`: base `(0.132, 0.140, 0.146)`, metallic `0.88`, roughness `0.36`, emission strength `0.018`.
- `NS_S1_Raised_Gunmetal_Panel`: base `(0.178, 0.190, 0.198)`, metallic `0.90`, roughness `0.32`, emission strength `0.024`.
- `NS_S1_Beveled_Edge_Gunmetal`: base `(0.044, 0.052, 0.064)`, metallic `0.82`, roughness `0.48`, emission strength `0.014`.
- `NS_S1_Dark_Depth_Metal`: base `(0.024, 0.030, 0.040)`, metallic `0.64`, roughness `0.72`, emission strength `0.008`.
- `NS_S1_Dim_Cyan_Embedded_Channel`: cyan accent material, emission strength `1.05`.
- `NS_S1_Soft_Cyan_Rail_Core`: restrained rail material, emission strength `1.45`.
- `NS_S1_Cool_Aluminum_Sheen`: metallic highlight strip material, metallic `0.68`, roughness `0.20`, emission strength `0.045`.

How 3D depth is now visible at gameplay zoom:

- The floor is no longer visually dominated by continuous neon grid lines; dark raised lips, inset plates, grooves, and bevel shadows now carry the construction read.
- The modeled GLB now has 599 mesh instances in the active imported node tree, including 196 raised panel lips, 98 brushed groove details, 16 recessed seam channels, 32 short cyan accent pieces, 4 dark pylon caps, and 0 old full-length bright seam-cross nodes.
- Metal panels use stronger light/dark contrast and higher metallic values so the floor reads as gunmetal/aluminum rather than flat black squares.
- The cyan language is restrained to embedded accent channels and rails so the Phase 37 blue propulsion ripple remains visible without fighting a giant floor grid.

Godot integration changes:

- Sector 1 still uses `_create_sector1_blender_arena_kit()` to instance the GLB under `Sector1NeonGrid3DArenaArchitectureRoot`.
- `_configure_sector1_blender_arena_visuals()` still disables imported `GeometryInstance3D` shadow casting for performance.
- `_apply_sector_visual_identity()` now hides the generic `ArenaBorderColoredTube` and `ArenaBorderWhiteHotCore` while `_sector_index == 0`, so the Blender border owns the Sector 1 playfield edge.
- No new collision nodes, lights, camera movement, gameplay movement, enemy logic, projectile logic, XP logic, event logic, or UI logic were added.

Bounds and screen fit:

- `ARENA_HALF_SIZE` remains `28.0`.
- The player center clamp remains inside the arena at `+/-27.0`.
- Blender walls/rails remain aligned to `+/-28.0`, matching the authoritative gameplay boundary.
- `Camera3D.size` remains `47.5`, preserving the Phase 38 bounds/screen-fit repair.

Godot docs/classes referenced:

- Imported 3D scenes / GLB import pipeline: confirms GLB scenes can be imported/instanced as 3D scene resources.
- `MeshInstance3D`: used for the imported mesh-node runtime representation.
- `BaseMaterial3D` / `StandardMaterial3D`: used for metallic, roughness, albedo, and emission-driven material settings.
- `Camera3D`: used to preserve the existing orthographic camera size and bounds fit.
- 3D lights and shadows guidance: used to keep this pass lightweight by avoiding dynamic light spam and disabling unnecessary imported shadow casting.

Focused validation added/run:

- Confirms the Sector 1 GLB source file exists and instances in the official scene.
- Confirms old Phase 38 procedural Sector 1 floor/grid/border/depth roots are absent.
- Confirms generic grid and generic arena border overlays are hidden for Sector 1.
- Confirms old full-length Blender seam nodes and the old white/cyan hot-core material are absent.
- Confirms the rebuilt GLB contains modeled 3D detail counts listed above.
- Confirms player clamp still keeps the player inside the visible arena.
- Confirms the Phase 37 propulsion ripple root still initializes.
- Confirms reapplying sector visual identity does not duplicate the arena model and that Sector 1 GLB clears/restores correctly across sector identity changes.

Manual test focus for this repair:

- Start Sector 1 and confirm the giant white/cyan cross is gone.
- Confirm the floor reads as darker aluminum/gunmetal panels with visible thickness, bevels, lips, inset plates, grooves, and restrained cyan accents.
- Confirm corner pylons no longer look like bright debug dots.
- Confirm the generic old white border frame is not visible over the Blender arena.
- Confirm the player cannot leave the visible arena and the walls/rails match the gameplay clamp.
- Confirm enemies, XP, bullets, event objectives, HUD, and the Phase 37 blue propulsion ripple remain readable.

## Hard Repair 3 - AAA-Style Blender Environment Art Pass

The previous Hard Repair 2 result was rejected because it still read as a regular 7x7 tile board from the gameplay camera. It had better geometry than the original grid, but the macro read was still too flat, too dark, too repetitive, and too much like placeholder generated art.

Role breakdown:

- Environment Art Director: set the target as an authored hard-surface metal power deck, not a literal grid board. Required macro floor hierarchy, recessed service trenches, raised perimeter machinery, and restrained embedded cyan.
- Blender Hard-Surface Environment Artist: identified the missing medium-scale hierarchy. Recommended panel variants, real recessed seams with bridge plates, segmented wall modules, machinery-style corner/mid-wall anchors, stronger bevels, and visible service-deck detail.
- Material / Lighting Artist: kept runtime camera/environment stable and moved the quality gain into material values and geometry. Recommended controlled aluminum/gunmetal values, lower cyan emission, sparse fake sheen, no white seams, no bloom increase, and no dynamic light spam.
- Godot Technical Artist: confirmed Sector 1 already loads the GLB through the official scene, old procedural roots are suppressed, gameplay remains X/Z plane-locked, and bounds/camera should stay unchanged. Recommended disabling imported GI in addition to shadow casting.
- QA / Readability Lead: defined the focused validation checks for GLB load, old visual suppression, no white/debug markers, no collision descendants, geometry detail counts, player clamp, Phase 37 ripple, and duplicate-node prevention.

Blender source updated:

- `art/arenas/sector_1/source/blender/build_sector_1_neon_grid_arena.py`
- `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`
- `art/arenas/sector_1/source/blender/sector_1_environment_art_notes.md`

Runtime GLB exported:

- `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`

Blender modeling improvements:

- Rebuilt the previous repeated panel recipe into a variant map with `service`, `vented`, `standard`, `brace`, `heavy`, `macro`, and `reactor` panels.
- Increased base panel thickness to `0.42` and main panel bevels to `0.185`.
- Increased height variation to roughly `-0.052` through `+0.046`, enough to read from the orthographic camera without implying walkable ramps.
- Added a dark underfloor depth slab so seams/gaps read as construction depth.
- Added macro deck covers and low service details to break the flat board read without creating tall interior obstacles.
- Added readable service hatches, vent wells/slats, diagonal armor braces, heavy access covers, macro ribs, and a central low power-deck panel.
- Rebuilt seam treatment as actual recessed dark trenches with raised chamfer rails and 56 bridge-plate assemblies.
- Replaced continuous floor-grid identity with 12 short dim cyan accent pieces plus restrained rail accents.
- Rebuilt borders as 28 segmented wall machinery modules instead of four long plain wall boxes.
- Added 4 machinery-style corner anchor assemblies and 12 mid-wall pylons.
- Added perimeter service trenches and outer buttresses for background depth.

Imported asset counts after the pass:

- 1,075 imported `GeometryInstance3D` descendants in the Sector 1 GLB model.
- 49 base floor panel variants.
- 16 recessed seam trenches.
- 56 seam bridge-plate assemblies.
- 12 short embedded cyan accents.
- 252 segmented wall machinery pieces.
- 32 corner machinery anchor pieces.
- 36 mid-wall pylon pieces.
- 4 low macro deck covers.
- 16 perimeter service trenches.
- 0 old `Sector1BlenderNeonSeam*` nodes.
- 0 old `Sector1BlenderCornerPylonCyanCap*` nodes.
- 0 `NS_S1_White_Cyan_Hot_Core` material usage.

Material settings:

- `NS_S1_Dark_Brushed_Aluminum_AAA`: base `(0.124, 0.132, 0.138)`, metallic `0.90`, roughness `0.40`, emission strength `0.012`.
- `NS_S1_Raised_Gunmetal_Panel_AAA`: base `(0.164, 0.176, 0.184)`, metallic `0.92`, roughness `0.36`, emission strength `0.016`.
- `NS_S1_Beveled_Edge_Gunmetal_AAA`: base `(0.052, 0.062, 0.076)`, metallic `0.84`, roughness `0.50`, emission strength `0.006`.
- `NS_S1_Recessed_Dark_Depth_Metal_AAA`: base `(0.022, 0.028, 0.038)`, metallic `0.60`, roughness `0.76`, emission strength `0.002`.
- `NS_S1_Dim_Cyan_Embedded_Channel_AAA`: base `(0.000, 0.300, 0.430)`, cyan emission strength `0.72`.
- `NS_S1_Restrained_Cyan_Rail_Core_AAA`: base `(0.020, 0.420, 0.540)`, cyan emission strength `0.94`.
- `NS_S1_Cool_Aluminum_Sheen_AAA`: base `(0.340, 0.430, 0.470)`, metallic `0.82`, roughness `0.22`, emission strength `0.012`.
- `NS_S1_Blackened_Service_Trim_AAA`: base `(0.012, 0.016, 0.022)`, metallic `0.56`, roughness `0.82`, emission strength `0.001`.

How top-down readability was addressed:

- The pass does not rely on tiny bevels alone. It adds medium-scale silhouettes that remain visible from the `Camera3D` orthographic size `47.5`.
- The previous uniform 7x7 read is broken by panel variants, macro covers, vent wells, diagonal braces, heavy access panels, and a central low power-deck detail.
- Seams are darker and recessed instead of bright full-length lines.
- Wall and pylon depth is larger and segmented so the border reads like physical machinery, not a glowing square outline.
- Cyan accents are fewer and dimmer, preserving Phase 37 ripple readability and avoiding a return to the debug-grid look.

Godot integration changes:

- Sector 1 still instances the GLB through `SECTOR1_BLENDER_ARENA_SCENE_PATH` under `Blender3DSector1NeonGridArenaModel`.
- Old Sector 1 HD background and procedural floor/grid/border/depth roots remain suppressed.
- Generic grid and generic border overlays remain hidden for Sector 1.
- Imported `GeometryInstance3D` nodes now have both `cast_shadow = SHADOW_CASTING_SETTING_OFF` and `gi_mode = GI_MODE_DISABLED`.
- No new collision nodes were added.
- No runtime camera, player movement, enemy movement, projectile, XP, event, boss, UI, save, controller, or Phase 37 ripple behavior was changed.

Bounds and screen fit:

- `ARENA_HALF_SIZE` remains `28.0`.
- Player clamp remains inside the visible arena at `+/-27.0`.
- Blender rails/walls remain aligned to the authoritative `+/-28.0` boundary.
- `Camera3D.size` remains `47.5`.

Godot docs/classes referenced:

- Imported 3D scenes / GLB import pipeline.
- `GLTFDocument` / `GLTFState` runtime GLB scene generation.
- `MeshInstance3D` for imported mesh descendants.
- `GeometryInstance3D` for shadow casting and GI mode controls.
- `BaseMaterial3D` / `StandardMaterial3D` for metallic, roughness, albedo, and emission material behavior.
- `Camera3D` for preserving orthographic camera/bounds fit.
- 3D lights and shadows guidance for avoiding dynamic light spam and disabling unnecessary imported shadow/GI cost.

Focused validation for Hard Repair 3:

- `timeout 30s godot --headless --path . --script /tmp/neon_swarm_phase38_hard_repair3_validate.gd`
- The sandboxed run hit a Godot `user://logs` crash before project code ran; the same validation passed when rerun unsandboxed so Godot could access its user log directory.
- Validation confirmed the GLB exists and loads in the official scene.
- Validation confirmed 1,075 imported geometry descendants, no collision descendants, shadow casting disabled, and GI disabled.
- Validation confirmed old procedural roots and old HD Sector 1 background are inactive.
- Validation confirmed generic grid/border overlays are hidden for Sector 1.
- Validation confirmed old white-cross/debug marker names and material are absent.
- Validation confirmed player clamp remains inside the visible arena at `(27.0, 1.05, 27.0)`.
- Validation confirmed Phase 37 propulsion ripple nodes still exist.
- Validation confirmed no duplicate Sector 1 GLB on visual rebuild and correct clear/restore behavior when switching sector identity away/back.

Manual test focus for this repair:

- Start Game in Sector 1.
- Confirm the first read is an authored hard-surface aluminum/gunmetal arena deck, not a flat black tile board.
- Confirm floor depth is visible through panel thickness, inset faces, lips, hatches, vents, braces, recessed trenches, and bridge plates.
- Confirm cyan is restrained and embedded, with no white center cross or giant marker dots.
- Confirm border walls, rails, corner anchors, and mid-wall pylons read as physical machinery.
- Confirm the player cannot leave the visible arena and the border matches the clamp.
- Confirm enemies, XP, bullets, event markers, boss warnings, HUD, and the Phase 37 ripple remain clearer than the floor.
- Confirm pause/restart/return-to-title does not duplicate the arena model.

## Validation Results

Run after implementation:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase38_sector1_glb_validate.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase38_hard_repair2_validate.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase38_hard_repair3_validate.gd`
- `git diff --check`
- `git diff --stat`
- `git status`

Focused validation confirms:

- Sector 1 architecture root initializes safely.
- Sector 1 Blender GLB exists and instances safely.
- Exactly one `Blender3DSector1NeonGridArenaModel` is active in Sector 1.
- The imported GLB has `MeshInstance3D` descendants and no collision descendants.
- Old procedural Phase 38 floor/line/border/depth roots are bypassed.
- Sector 1 architecture is not duplicated after repeated visual-identity rebuilds.
- Sector 1 architecture clears when the runtime sector index changes away from Sector 1.
- The architecture root contains no collision nodes.
- Player gameplay area remains at the existing gameplay height.
- Player/enemy/projectile/XP arrays initialize.
- The Phase 37 propulsion ripple still initializes.
- The Hard Repair 2 focused validation confirms the old full-length Blender seam cross nodes, old white/cyan hot-core material, bright pylon cap markers, generic Sector 1 border overlay, and old procedural roots are not active.
- The Hard Repair 2 focused validation confirms the rebuilt GLB imports with 599 mesh instances, including recessed dark seams, short cyan accents, raised panel lips, brushed grooves, and dark metal pylon caps.
- The Hard Repair 3 focused validation confirms the AAA-style GLB imports with 1,075 geometry descendants, no collision descendants, shadow/GI disabled, old flat/procedural visuals inactive, no white cross/debug markers, player clamp intact, Phase 37 ripple nodes present, and no duplicate GLB nodes after rebuild/sector switch.

## Manual Test Checklist

Run:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Test:

- Start Game.
- Confirm Sector 1 has a Blender-built aluminum/gunmetal 3D arena with modeled floor plates, bevels, seams, raised border walls, rails, pylons, and subtle depth pieces.
- Confirm there is no old flat Sector 1 HD background visible behind the aluminum arena.
- Confirm the arena no longer reads like a flat procedural Godot grid.
- Confirm the aluminum/gunmetal tiles read as individual metal floor panels with cyan seams and restrained reflective sheen.
- Confirm the player cannot leave the visible arena/play area.
- Move to each border and confirm gameplay remains flat and unobstructed.
- Confirm the visual border matches the playable arena edge clearly.
- Confirm enemies, XP, bullets, event markers, and boss warnings remain readable.
- Confirm the Phase 37 blue propulsion ripple remains visible under the player.
- Pause/restart/return to title and confirm no duplicate arena architecture appears.
