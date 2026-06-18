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
- `Camera3D`: `https://docs.godotengine.org/en/stable/classes/class_camera3d.html`
- `DirectionalLight3D`: `https://docs.godotengine.org/en/stable/classes/class_directionallight3d.html`
- 3D lights and shadows / light-count performance guidance: `https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html`

Why these were chosen:

- `Node3D` is the documented base for 3D scene-space hierarchy and transforms, so the arena architecture is organized as Sector 1-only `Node3D` roots under the existing `SectorGeometryIdentityRoot`.
- `MeshInstance3D` is the documented 3D mesh instance node, so floor panels, walls, rails, and depth pieces are persistent mesh instances rather than spawned VFX.
- `StandardMaterial3D` and `BaseMaterial3D` provide the documented material properties used for opaque aluminum/gunmetal panel faces: albedo, metallic, roughness, specular strength, and restrained emission.
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

## 3D Arena Architecture Added

Added a Sector 1-only visual root:

- `Sector1NeonGrid3DArenaArchitectureRoot`

Children:

- `Sector1DarkFloorPanelFoundationRoot`
- `Sector1CyanGridLineRoot`
- `Sector1RaisedBorderWallRailRoot`
- `Sector1SubtleBackgroundDepthRoot`

Level 1 / Sector 1 visual elements:

- 49 dark aluminum/gunmetal 3D floor plate meshes arranged as a 7x7 cyber-grid foundation after the hotfix.
- Cyan grid tube linework and square circuit loops over the plates.
- Raised dark border wall meshes aligned to the existing arena boundary.
- Cyan/white neon top rails and lower safety rail loops to clarify the playable border.
- Corner power pylons with dark faces and neon tube edges.
- Subtle out-of-bounds depth plates and horizon rails to make the arena feel like a 3D environment.

## Gameplay Plane Preservation

Gameplay remains locked to the existing 2D X/Z movement plane:

- `ARENA_HALF_SIZE` was not changed.
- Player movement and enemy chase logic were not changed.
- No `Area3D`, `StaticBody3D`, `CollisionShape3D`, or other collision nodes were added for the arena architecture.
- Raised walls and depth pieces are visual-only `Node3D` / `MeshInstance3D` nodes.
- The player, enemies, bullets, XP, and events continue using the existing gameplay systems.

## Floor Panel Foundation

The new floor panel system is built in code:

- `SECTOR1_ARENA_PANEL_COUNT = 7`
- `SECTOR1_ARENA_PANEL_STEP = 8.0`
- `SECTOR1_ARENA_PANEL_SIZE = 7.36`
- `SECTOR1_ARENA_PANEL_THICKNESS = 0.16`
- `SECTOR1_ARENA_PANEL_BASE_Y = -0.096`

Selected panels are registered in `_sector1_arena_panel_motion` and pulse vertically by only `0.0035` units during active gameplay. This is a future-ready foundation for animated/changing floor panels while keeping Level 1 readable and non-blocking.

## Future Darker Arena Support

The architecture is separated from gameplay and tied to Sector 1 identity only. Future sectors can use the same pattern:

- sector-specific materials
- sector-specific floor plate layouts
- sector-specific border architecture
- sector-specific brightness and background depth
- no gameplay collision unless explicitly approved

For Level 1, the floor remains readable: opaque aluminum/gunmetal plate faces are paired with cyan/white emissive tube seams and sparse sheen strips. The older flat Sector 1 HD plate and low-alpha floor underlay are disabled so the Phase 37 blue propulsion ripple reads on top of actual 3D tile geometry.

## Collision / Readability Safeguards

- Visual walls align to the authoritative `ARENA_HALF_SIZE` arena boundary while the player center remains clamped inside that boundary.
- The `Camera3D` orthographic size is now `47.5`, so the existing `ARENA_HALF_SIZE` playfield and Sector 1 visual border fit inside a 1280x720 gameplay viewport.
- Decorative depth pieces sit beyond the walls.
- No ramps or raised platforms were added inside the gameplay area.
- Floor panel motion is subtle and does not imply playable height changes.
- No HUD/menu/title UI was changed.
- The Phase 37 player ripple was not redesigned or removed.

## Performance Safeguards

- All arena nodes are persistent.
- No per-frame node creation.
- No dynamic lights added.
- Shared simple mesh resources are used for floor panels where practical.
- Panel motion updates only a small list of selected floor panel transforms.
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
- 49 aluminum floor panels initialize.
- Sample floor panel uses `StandardMaterial3D` with metallic/roughness settings.
- Player clamp corners and visible arena bounds fit the 1280x720 `Camera3D` frustum.
- No collision nodes exist under the Sector 1 architecture root.
- Phase 37 propulsion ripple root remains present.
- Enemy, projectile, and XP arrays initialize.
- Reapplying sector visual identity does not duplicate arena nodes or restore the old Sector 1 HD plate.

## Validation Results

Run after implementation:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase38_arena_validate.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase38_hotfix_bounds_floor_validate.gd`
- `git diff --check`
- `git diff --stat`
- `git status`

Focused validation confirms:

- Sector 1 architecture root initializes safely.
- Sector 1 architecture is not duplicated after repeated visual-identity rebuilds.
- Sector 1 architecture clears when the runtime sector index changes away from Sector 1.
- The architecture root contains no collision nodes.
- Player gameplay area remains at the existing gameplay height.
- Player/enemy/projectile/XP arrays initialize.
- The Phase 37 propulsion ripple still initializes.

## Manual Test Checklist

Run:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Test:

- Start Game.
- Confirm Sector 1 has dark 3D floor plates, cyan grid lines, raised border walls, rails, and subtle depth pieces.
- Confirm there is no old flat Sector 1 HD background visible behind the aluminum arena.
- Confirm the aluminum/gunmetal tiles read as individual metal floor panels with cyan seams.
- Confirm the player cannot leave the visible arena/play area.
- Move to each border and confirm gameplay remains flat and unobstructed.
- Confirm the visual border matches the playable arena edge clearly.
- Confirm enemies, XP, bullets, event markers, and boss warnings remain readable.
- Confirm the Phase 37 blue propulsion ripple remains visible under the player.
- Pause/restart/return to title and confirm no duplicate arena architecture appears.
