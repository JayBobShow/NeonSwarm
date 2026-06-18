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

## Hard Repair 4 — Material / Lighting / Visibility Pass

Why Hard Repair 3 was rejected:

- User feedback was "no all of it is black."
- The Blender GLB had enough modeled structure, but the runtime read collapsed into a near-black value mass.
- The issue was material/lighting visibility, not another geometry-count problem.

Role/delegation summary:

- Material / Lighting Artist inspected the GLB material table, the Blender material palette, and Sector 1 environment tone. Verdict: high-metallic, very dark albedos plus exported-no-lights and low ambient caused the black read.
- Environment Art Director inspected the arena notes, Blender build script, report, runtime GLB path, and old-background suppression. Verdict: preserve the hard-surface geometry and repair value separation/light catch.
- Godot Technical Artist inspected the Sector 1 load/configuration path and recommended the current integration lane: tune imported `NS_S1_` `StandardMaterial3D` resources after GLB instancing, keep shadows/GI disabled, use one controlled shadowless light, and avoid camera/bounds changes.
- Readability QA was handled in the focused validation script and manual checklist: verify material setup, arena-only lighting, old flat visuals absent, player clamp intact, Phase 37 ripple present, and no duplicate GLB after rebuild.

Cause of the black/invisible look:

- The GLB export intentionally excludes the Blender preview area light (`export_lights=False`).
- Sector 1 previously used very low ambient (`Color(0.020, 0.040, 0.085)` at energy `0.22`).
- Hard Repair 3 metal values were high-metallic and very dark, for example `NS_S1_Dark_Brushed_Aluminum_AAA` at base `(0.124, 0.132, 0.138)`, metallic `0.90`, emission strength `0.012`.
- In Godot, that combination had too little diffuse/value response for the top-down camera to reveal panel faces, bevels, lips, vents, grooves, and borders.

Material changes:

- `NS_S1_Dark_Brushed_Aluminum_AAA`: base `(0.205, 0.218, 0.232)`, metallic `0.62`, roughness `0.54`, emission strength `0.120`.
- `NS_S1_Raised_Gunmetal_Panel_AAA`: base `(0.245, 0.262, 0.274)`, metallic `0.66`, roughness `0.48`, emission strength `0.145`.
- `NS_S1_Beveled_Edge_Gunmetal_AAA`: base `(0.145, 0.165, 0.188)`, metallic `0.62`, roughness `0.58`, emission strength `0.105`.
- `NS_S1_Recessed_Dark_Depth_Metal_AAA`: base `(0.055, 0.066, 0.084)`, metallic `0.40`, roughness `0.78`, emission strength `0.048`.
- `NS_S1_Blackened_Service_Trim_AAA`: base `(0.030, 0.038, 0.052)`, metallic `0.32`, roughness `0.84`, emission strength `0.020`.
- `NS_S1_Cool_Aluminum_Sheen_AAA`: base `(0.500, 0.650, 0.700)`, metallic `0.34`, roughness `0.20`, emission strength `0.160`.
- Cyan accents remain restrained: embedded channels use emission strength `0.68`; rail cores use `0.86`.

Lighting/fake reflection changes:

- Added one runtime `DirectionalLight3D` named `Sector1ArenaMaterialReadabilityKeyLight`.
- Light settings: color `Color(0.62, 0.78, 1.0)`, energy `0.30`, specular `0.42`, rotation `Vector3(-54, -28, 0)`.
- The light is shadowless, has bake mode disabled, indirect energy `0.0`, and volumetric fog energy `0.0`.
- The light cull mask is isolated to `SECTOR1_ARENA_VISUAL_LIGHT_LAYER_MASK = 1 << 19`.
- Imported Sector 1 arena `GeometryInstance3D` nodes are moved to that same visual layer so the key light catches the metal floor without globally lifting enemies, XP, projectiles, HUD, or the Phase 37 ripple.
- Sector 1 ambient tone was lifted only to `Color(0.045, 0.060, 0.090)` at energy `0.34`; camera size, tonemap exposure, glow, and gameplay bounds were not changed.

Runtime material safeguards:

- `_configure_sector1_blender_arena_visuals()` still disables imported shadows and GI.
- `_boost_sector1_imported_arena_materials()` now duplicates each matched imported `NS_S1_` `StandardMaterial3D` and assigns it as a surface override before tuning values.
- This preserves the GLB's material slot separation and avoids mutating cached PackedScene material resources globally.

Visibility/readability changes:

- Panel faces, bevels, raised lips, inset plates, vents, grooves, border walls, pylons, and sheen strips now have enough value separation to read from the orthographic gameplay camera.
- The pass does not reintroduce white center cross lines, full-floor cyan debug grid lines, giant marker dots, old procedural Sector 1 floor visuals, or the old HD background plate.
- The Phase 37 blue propulsion ripple remains active and should stay visible on the brighter floor because cyan seam/rail emissions were kept restrained.

Files changed for Hard Repair 4:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `art/arenas/sector_1/source/blender/build_sector_1_neon_grid_arena.py`
- `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`
- `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`
- `art/arenas/sector_1/source/blender/sector_1_environment_art_notes.md`
- `docs/NEON_SWARM_PHASE_38_LEVEL_1_3D_ARENA_MAP_ARCHITECTURE_REPORT.md`

Godot docs/classes referenced:

- `StandardMaterial3D`: used because Godot documents it as the PBR 3D material for albedo/metallic/roughness/emission-driven 3D objects.
- `BaseMaterial3D`: used for roughness, metallic/specular, emission, and texture filtering behavior.
- `MeshInstance3D`: used because imported GLB descendants render mesh resources and can receive per-surface material overrides.
- `GLTFDocument` / `GLTFState`: used by the existing runtime GLB loading path to append the file and generate the scene.
- `DirectionalLight3D` / `Light3D`: used for one controlled arena-only material key light; shadows are disabled because Godot documents real-time shadows as a significant performance cost.
- 3D lights and shadows guidance: followed by using one persistent light, disabling shadows, and avoiding dynamic light spam.
- `Camera3D`: reviewed but not changed; orthographic camera size remains `47.5`.

Focused validation for Hard Repair 4:

- `timeout 30s godot --headless --path . --script /tmp/neon_swarm_phase38_hard_repair4_validate.gd`
- Confirms Sector 1 GLB exists and loads.
- Confirms one `Sector1ArenaMaterialReadabilityKeyLight` exists, is shadowless, uses the arena-only light cull mask, and has energy `0.30`.
- Confirms imported Sector 1 geometry remains shadow/GI disabled and is assigned to the arena visual light layer.
- Confirms imported `NS_S1_` material overrides are applied and expected visible metal materials are present.
- Confirms old procedural Sector 1 floor/grid roots and old HD background plate are absent.
- Confirms generic grid/border overlays remain hidden in Sector 1.
- Confirms Phase 37 propulsion ripple disk exists.
- Confirms the player clamp still keeps the player inside the `+/-27.0` playable area.
- Confirms repeated visual identity rebuild does not duplicate the Sector 1 GLB.

Hard Repair 4 validation results:

- `git status`: working tree contained only the intended Hard Repair 4 files before commit.
- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed.
- `timeout 30s godot --headless --path . --script /tmp/neon_swarm_phase38_hard_repair4_validate.gd`: passed with `PHASE38_HARD_REPAIR4_VALIDATION_PASS`.
- No gameplay, camera, bounds, collision, save, UI, weapon, enemy, XP, event, boss, controller, or Phase 37 ripple behavior was intentionally changed.

Manual test focus for this repair:

- Start Game in Sector 1.
- Confirm the floor no longer reads as all black.
- Confirm metal panels, bevels, raised lips, inset panels, grooves, vents, border walls, rails, and pylons are visible at normal gameplay zoom.
- Confirm the floor reads as dark aluminum/gunmetal, not black squares or gray plastic.
- Confirm cyan seams/rails are accents, not a flat debug grid.
- Confirm no white cross, giant corner dots, old HD background plate, or procedural floor overlay is visible.
- Confirm enemies, XP, bullets, player core, HUD, event markers, and Phase 37 ripple remain clearer than the floor.
- Confirm the player cannot leave the visible arena and no duplicate arena appears after pause/restart/return-to-title.

## Hotfix 5 — Floor Accent Cleanup, Ripple Visibility, and Non-Scrolling Loadout HUD Audit

User feedback:

- The Level 1 arena is improving, but the short scattered cyan floor dashes read as weak/random accents.
- The metal floor presentation was covering or weakening the Phase 37 blue propulsion ripple.
- The bottom in-game HUD needed an audit because Neon Swarm supports `8` equipped weapons and the gameplay HUD must not scroll.

Role/delegation summary:

- Environment Material/VFX Lead confirmed the random cyan dash accents were generated by the Blender GLB, not the old procedural grid. They recommended removing floor-level dash accents rather than globally dimming the shared cyan material, because wall/perimeter cyan accents still support arena readability.
- HUD/UX Lead confirmed the gameplay HUD itself did not use a `ScrollContainer`, but the bottom rail mixed `4` stat chips with only `4` weapon-family chips. That did not represent all `8` equipped weapon slots.
- Godot Technical QA Lead confirmed the Sector 1 GLB path is active, old procedural roots are hidden for Sector 1, player clamp remains `+/-27.0`, and focused validation should cover GLB, ripple material, player bounds, and fixed gameplay HUD slot count.

Floor accent fix:

- Removed the floor-level short cyan dash meshes from `art/arenas/sector_1/source/blender/build_sector_1_neon_grid_arena.py`.
- Removed generated service/vent/heavy/reactor panel dash nodes named `ShortCyanHatchStatus`, `TinyEmbeddedCyanVentCue`, `CyanAccessTag`, `NorthCyanPowerInset`, and `SouthCyanPowerInset`.
- Removed the scattered seam accent loop that generated `Sector1AAAEmbeddedCyanAccentX*` and `Sector1AAAEmbeddedCyanAccentY*`.
- Regenerated `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`.
- Re-exported `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`.
- Kept perimeter/wall cyan rails and slit accents so the arena boundary still reads as intentional neon machinery.

Ripple visibility diagnosis and fix:

- The ripple was a transparent additive `ShaderMaterial` plane at approximately world `Y = 0.120`, while the raised opaque GLB floor details could still depth-test in front of it.
- `depth_draw_never` prevented the ripple from writing depth, but it did not prevent opaque floor depth from rejecting ripple pixels.
- The ripple shader now uses `render_mode unshaded, blend_add, depth_draw_never, depth_test_disabled, cull_disabled`.
- The ripple material now uses `render_priority = 80`.
- The ripple follow root was raised from `PLAYER_PRESENTATION_FLOOR_Y = 0.092` to `0.132`, and the disk local lift moved from `0.028` to `0.045`, putting the ripple at roughly world `Y = 0.177`.
- The ripple alpha/emission was modestly strengthened: ripple color alpha `0.88`, core alpha `0.58`, max alpha `0.82`, and stronger emission multipliers.
- The ripple remains centered under the player, remains a small floor-bound propulsion ripple, and no gameplay movement/collision was changed.

Bottom HUD/loadout audit result:

- Before Hotfix 5, the bottom gameplay rail showed `DMG`, `RATE`, `SPD`, `PICKUP`, `ORBIT`, `LANCE`, `SAW`, and `MINE`.
- `DMG`, `RATE`, `SPD`, and `PICKUP` were player/stat chips.
- `ORBIT`, `LANCE`, `SAW`, and `MINE` were hard-coded weapon-family status chips.
- This meant the bottom gameplay HUD represented only four weapon families, not all `8` equipped slots.
- The gameplay HUD itself was already non-scrolling; scroll containers remain limited to menus such as Help, Armory, and weapon reward UI.

HUD change made:

- Replaced the mixed bottom chip rail with a fixed `GameplayLoadoutEightSlotRail`.
- Added exactly `8` fixed gameplay weapon slot cells named `GameplayLoadoutSlot01` through `GameplayLoadoutSlot08`.
- Each slot shows a small `NeonWeaponIcon`, slot number, rarity code, and compact weapon name; empty slots render as dim `EMPTY` cells.
- Moved the stat telemetry into a compact `GameplayStatTelemetryInline` readout in the core vitals panel.
- The in-game combat HUD still does not scroll.
- No weapon damage, cooldown, target count, progression, save data, Armory, Forge, or controller behavior was changed.

Godot docs/classes referenced:

- `ShaderMaterial`: used for the Phase 37 propulsion ripple material and updated with shader parameters and render priority behavior.
- Spatial shaders / shading language: used for `TIME`/uniform-driven radial ripple behavior and render modes including additive blending, disabled depth writing, disabled depth testing, and disabled culling.
- `Material.render_priority`: used because Godot documents render priority for 3D material sorting, allowing the transparent ripple to draw above lower-priority floor materials.
- `MeshInstance3D` / `PlaneMesh`: used for the persistent ripple mesh and imported GLB mesh validation.
- `BaseMaterial3D` / `StandardMaterial3D`: reviewed for the opaque metal floor and transparent material interaction; floor materials remain opaque.
- `HBoxContainer`: used for the fixed, non-scrolling bottom weapon rail.
- `ScrollContainer`: reviewed to confirm the gameplay HUD should not use one; menu scroll containers remain separate.

Hotfix 5 validation results:

- `timeout 30s godot --headless --path . --script /tmp/neon_swarm_phase38_hotfix5_validate.gd`: passed with `PHASE38_HOTFIX5_VALIDATION_PASS`.
- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed.
- `git diff --check`: passed with no whitespace errors.
- `git diff --stat`: confirmed the intended `7` changed files before commit.
- `git status`: confirmed only the intended Hotfix 5 files were modified before commit.
- Focused validation confirms the Sector 1 GLB exists and loads, removed floor dash node names are absent from imported GLB meshes, the ripple shader includes `blend_add`, `depth_draw_never`, `depth_test_disabled`, and `cull_disabled`, ripple `render_priority` is `80`, ripple color alpha is strengthened, the ripple disk sits above the raised floor details, player clamp still holds inside `+/-27.0`, gameplay HUD has exactly `8` fixed slot cells/icons/labels, and no `ScrollContainer` exists under `GameplayBlueprintReadoutRoot`.

Manual test focus:

- Start Game in Sector 1.
- Confirm the random little cyan floor dash accents are gone.
- Confirm wall/perimeter cyan accents still help the arena boundary read.
- Confirm the blue propulsion ripple is visible above the metal floor, centered under the player, and expanding outward repeatedly.
- Confirm the ripple is not huge, not above the player, and not hidden by the floor.
- Confirm the bottom gameplay HUD shows all `8` equipped weapon slots without scrolling.
- Confirm stat telemetry is visually separate from the weapon slots.
- Confirm enemies, XP, bullets, event markers, player core, HUD, and the metal arena remain readable.
- Confirm the player cannot leave the visible arena.

## Hotfix 6 — Outer Rail Cleanup and Non-Scrolling Vertical HUD Layout

User feedback:

- Remove the running vertical decorative rails/lines outside the arena/play area.
- Keep top-left and top-right HUD panels outside or at the edge of the playable action area.
- Keep top-center notification/objective panels as temporary notification space.
- Replace the bottom loadout rail with a clearer non-scrolling layout that shows all `8` equipped weapons.

Outer rail cleanup:

- The unnecessary outer clutter was baked into the Sector 1 Blender GLB by `create_depth_and_detail()` in `art/arenas/sector_1/source/blender/build_sector_1_neon_grid_arena.py`.
- Removed generated outer service buttress meshes:
  - `Sector1AAAOuterNorthServiceButtress0..2`
  - `Sector1AAAOuterSouthServiceButtress0..2`
  - `Sector1AAAOuterWestServiceButtress0..2`
  - `Sector1AAAOuterEastServiceButtress0..2`
- Removed generated far restrained cyan rail meshes:
  - `Sector1AAAFarNorthRestrainedCyanRail`
  - `Sector1AAAFarSouthRestrainedCyanRail`
  - `Sector1AAAFarWestRestrainedCyanRail`
  - `Sector1AAAFarEastRestrainedCyanRail`
- Preserved actual arena boundary geometry:
  - `Sector1AAASegmentedWall_*_*`
  - `Sector1AAASegmentedWall_*_*_SegmentedCyanTopRail`
  - `Sector1AAACornerMachineryAnchor*`
  - `Sector1AAAMidWallPylon_*_*`
- Regenerated `art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend`.
- Re-exported `art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb`.

HUD audit result:

- The gameplay HUD is procedural in `scripts/NeonSwarm3DGameplayPrototype.gd`.
- `EQUIPPED_WEAPON_SLOT_CAP` remains `8`.
- Before Hotfix 5, the bottom rail was effectively `4` stat chips plus `4` weapon-family chips, so it did not show all `8` equipped weapon slots.
- Hotfix 5 fixed the count but kept the display as a horizontal bottom rail.
- The gameplay HUD itself was already non-scrolling; `ScrollContainer` remains limited to menu contexts such as Help, Armory, and weapon reward UI.

Final non-scrolling HUD layout:

- Top-left `GameplayCoreVitalsPanel` remains at the screen edge for health/XP/level.
- Top-right `GameplayRunTelemetryPanel` remains at the screen edge for timer/sector/kills/score/hostiles/audio.
- Top-center boss, combat notice, and run-event objective panels remain temporary notification/objective panels.
- Added left-side vertical `GameplayStatsReadoutPanel` under core vitals with stat chips:
  - `DMG`
  - `RATE`
  - `SPD`
  - `PICKUP`
- Replaced the bottom loadout rail with right-side `GameplayEquippedWeaponVerticalPanel`.
- Added `GameplayLoadoutEightSlotColumn`, a fixed `VBoxContainer` with `8` visible weapon rows:
  - `GameplayLoadoutSlot01`
  - `GameplayLoadoutSlot02`
  - `GameplayLoadoutSlot03`
  - `GameplayLoadoutSlot04`
  - `GameplayLoadoutSlot05`
  - `GameplayLoadoutSlot06`
  - `GameplayLoadoutSlot07`
  - `GameplayLoadoutSlot08`
- Each weapon row shows a `NeonWeaponIcon`, slot number, rarity code, and compact weapon name.
- Empty slots render as dim `EMPTY` rows.
- No gameplay weapon/stat HUD uses scrolling.

Godot docs/classes referenced:

- `Control`: used for fixed HUD positioning in the 1920x1080 design root.
- `VBoxContainer`: used for the vertical stat stack and vertical 8-slot weapon stack.
- `HBoxContainer`: used only inside each fixed weapon row to align icon/text.
- `ScrollContainer`: reviewed and intentionally not used in the gameplay HUD; menu scroll behavior remains separate.
- `MeshInstance3D`: used for imported GLB mesh validation and to verify removed outer rails/buttresses while preserving boundary meshes.
- Imported 3D scene/GLB workflow: preserved by regenerating the Blender source and exported GLB, then continuing to load the GLB through the existing Sector 1 runtime path.

Hotfix 6 validation results:

- `git status`: confirmed the intended Hotfix 6 files were modified before commit.
- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed.
- `timeout 30s godot --headless --path . --script /tmp/neon_swarm_phase38_hotfix6_validate.gd`: passed with `PHASE38_HOTFIX6_VALIDATION_PASS`.
- `git diff --check`: passed with no whitespace errors.
- `git diff --stat`: reviewed the intended Hotfix 6 file set before commit.
- Focused validation confirms removed far cyan rails and outer service buttresses are absent from the imported GLB.
- Focused validation confirms actual segmented boundary rails, corner machinery cores, and mid-wall pylon cores remain present.
- Focused validation confirms the old bottom rail nodes are absent, `GameplayLoadoutEightSlotColumn` exists, exactly `8` weapon slot rows/icons/labels exist, stat chips are separated in `GameplayStatsReadoutPanel`, no `ScrollContainer` exists under `GameplayBlueprintReadoutRoot`, player clamp still holds inside `+/-27.0`, and the Phase 37 propulsion ripple still initializes.

Manual test focus:

- Start Game in Sector 1.
- Confirm the outside running vertical decorative rails/streaks are gone.
- Confirm the actual raised arena border/walls/rails still clearly show the playable boundary.
- Confirm top-left and top-right HUD panels sit at the screen edges and do not cover central action.
- Confirm the bottom loadout rail is gone.
- Confirm the left side shows vertical run stat chips.
- Confirm the right side shows all `8` equipped weapon slots without scrolling.
- Confirm weapon slot names/icons remain readable during movement/combat.
- Confirm top-center notification/objective panels still appear only as temporary notifications.
- Confirm enemies, XP, bullets, event objectives, player core, Phase 37 ripple, and arena bounds remain readable.

## Hotfix 7 — HUD Panel Spacing and Play-Area Protection

User feedback:

- The Phase 38 Hotfix 6 HUD direction was close: left vertical stat stack and right vertical `8`-slot equipped weapon stack.
- The remaining issue was panel spacing. The side HUD panels were too wide and the side stacks started too close under the top panels, making the HUD read as overlapping and too far into the playable field.
- This pass kept the approved HUD direction and only tightened spacing, sizing, and side placement.

Godot docs/classes referenced:

- `Control`: reviewed for fixed panel placement, `PRESET_TOP_LEFT`, full-rect HUD roots, size/position, and mouse filtering. The gameplay HUD still uses a 1920x1080 design-space `Control` root scaled to the viewport.
- `VBoxContainer`: reviewed because the stat and weapon stacks should stay as vertical automatic layouts, with explicit row spacing and minimum sizes.
- `ScrollContainer`: reviewed to confirm the gameplay HUD should not use scrolling. Scrolling remains menu-only.

Delegation summary:

- HUD/UX Layout Lead confirmed the concept should remain unchanged and identified side panel width and vertical stack starts as the main play-area intrusion.
- Godot UI Technical Lead confirmed the correct fix was fixed `Control` rect adjustment plus compact `VBoxContainer` row sizing, not a new menu/scrolling system.
- Readability QA confirmed top-center notification rails were not hard-overlapping side panels, but their tight vertical gaps could read crowded because of the neon frame glow.

Final spacing solution:

- `GameplayCoreVitalsPanel` moved from `Rect2(24, 28, 360, 132)` to `Rect2(18, 28, 300, 132)`.
- Core health and XP bars were reduced from `314px` to `252px` so they fit the narrower vitals panel.
- `GameplayStatsReadoutPanel` moved from `Rect2(24, 176, 236, 226)` to `Rect2(18, 198, 226, 224)`, leaving a clean vertical gap below Core Vitals even after Godot container minimum-size expansion.
- `GameplayRunTelemetryPanel` moved from `Rect2(1536, 28, 360, 132)` to `Rect2(1602, 28, 300, 132)`.
- Telemetry typography was compacted: timer font `36 -> 28`, telemetry row font `12 -> 10`, and telemetry column separation `4px -> 1px`.
- `GameplayEquippedWeaponVerticalPanel` moved from `Rect2(1536, 176, 360, 542)` to `Rect2(1602, 190, 300, 438)`, leaving a clean `30px` vertical gap below telemetry and reducing bottom footprint.
- The right stack still creates exactly `8` equipped weapon rows with no scroll.
- Weapon row minimum size changed from `318x50` to `268x46`, icon size from `38x38` to `34x34`, and row separation from `5px` to `4px`.

Top-center notification spacing:

- Boss rail remained centered.
- Combat notice moved from `Rect2(560, 76, 800, 44)` to `Rect2(560, 82, 800, 40)`.
- Run-event objective panel moved from `Rect2(520, 124, 880, 104)` to `Rect2(540, 132, 840, 88)`.
- Event test rail moved from `Rect2(610, 238, 700, 72)` to `Rect2(640, 230, 640, 60)`.
- These changes add visible breathing room between temporary top-center rails while keeping them away from the left/right HUD columns.

Play-area protection:

- Side panels are now narrower and pushed outward toward the screen edges.
- The central gameplay arena has more horizontal breathing room.
- The stat and weapon stacks no longer begin immediately below the top panels.
- All `8` equipped weapon slots remain visible and represented.
- The gameplay HUD still does not use `ScrollContainer`.
- No weapon behavior, progression, arena bounds, ripple, player controls, save format, Armory, Forge, Evolution/Fusion, Neon Dust, events, bosses, Wave Director, or enemy systems were changed.

Manual test focus:

- Start Game in Sector 1.
- Confirm the Core Vitals panel and left stat stack do not overlap.
- Confirm the telemetry panel and right equipped weapon stack do not overlap.
- Confirm all `8` equipped weapon slots are visible on the right side without scrolling.
- Confirm the left and right side HUD panels frame the central arena instead of sitting heavily on top of it.
- Confirm top-center notifications/objectives still appear centered and do not collide visually with side panels.
- Confirm enemies, XP, bullets, event objectives, player core, Phase 37 ripple, and arena bounds remain readable.

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
