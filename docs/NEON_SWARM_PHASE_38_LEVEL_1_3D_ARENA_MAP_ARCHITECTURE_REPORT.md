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
- 3D lights and shadows / light-count performance guidance: `https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html`

Why these were chosen:

- `Node3D` is the documented base for 3D scene-space hierarchy and transforms, so the arena architecture is organized as Sector 1-only `Node3D` roots under the existing `SectorGeometryIdentityRoot`.
- `MeshInstance3D` is the documented 3D mesh instance node, so floor panels, walls, rails, and depth pieces are persistent mesh instances rather than spawned VFX.
- `StandardMaterial3D` and the existing project shader materials provide dark face materials and controlled emissive neon rails without changing global bloom.
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

- 25 dark 3D floor plate meshes arranged as a 5x5 cyber-grid foundation.
- Cyan grid tube linework and square circuit loops over the plates.
- Raised dark border wall meshes just outside the existing arena boundary.
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

- `SECTOR1_ARENA_PANEL_COUNT = 5`
- `SECTOR1_ARENA_PANEL_STEP = 10.8`
- `SECTOR1_ARENA_PANEL_SIZE = 9.96`
- `SECTOR1_ARENA_PANEL_THICKNESS = 0.12`
- `SECTOR1_ARENA_PANEL_BASE_Y = -0.072`

Selected panels are registered in `_sector1_arena_panel_motion` and pulse vertically by only `0.010` units during active gameplay. This is a future-ready foundation for animated/changing floor panels while keeping Level 1 readable and non-blocking.

## Future Darker Arena Support

The architecture is separated from gameplay and tied to Sector 1 identity only. Future sectors can use the same pattern:

- sector-specific materials
- sector-specific floor plate layouts
- sector-specific border architecture
- sector-specific brightness and background depth
- no gameplay collision unless explicitly approved

For Level 1, the floor remains readable: dark plate faces are paired with cyan/white emissive tubes and a low-alpha cyan floor underlay so the Phase 37 blue propulsion ripple still reads on top.

## Collision / Readability Safeguards

- Visual walls sit outside the authoritative arena clamp.
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

## Validation Results

Run after implementation:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase38_arena_validate.gd`
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
- Move to each border and confirm gameplay remains flat and unobstructed.
- Confirm the visual border matches the playable arena edge clearly.
- Confirm enemies, XP, bullets, event markers, and boss warnings remain readable.
- Confirm the Phase 37 blue propulsion ripple remains visible under the player.
- Pause/restart/return to title and confirm no duplicate arena architecture appears.
