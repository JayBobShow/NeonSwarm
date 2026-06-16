# Neon Swarm Phase 2.6A: 3D Neon Readability / Composition Report

## 1. Executive Summary

Phase 2.6A keeps the optimized 3D/hybrid prototype direction, but addresses the rejected visual hierarchy from Phase 2.6.

The pass focuses on readability and composition, not migration. `Main.tscn` was not replaced, the 2D game was not deleted, and no gameplay systems were expanded.

Primary changes:

- Player visual priority increased.
- Common enemy brightness reduced.
- Near/far enemy hierarchy added.
- Tank/square enemy footprint reduced.
- Common enemy wireframe internals simplified.
- XP orb scale and glow reduced so XP reads below enemies.
- Projectile brightness separated from enemy brightness.
- Decorative spark density reduced in swarm mode.
- Existing HUD panels compacted slightly so gameplay remains the focus.

This pass is not approval for full 3D migration.

## 2. Why Phase 2.6 Visual Style Was Not Approved Yet

Phase 2.6 solved the major technical node-count problem, but the visual result still lacked hierarchy.

Rejected issues:

- Too many objects had equal visual importance.
- The screen read as bright wireframe clutter.
- Yellow/orange square tank enemies were too visually large.
- Tank piles created noisy overlapping square frames.
- The player did not dominate the screen enough during heavy action.
- XP and enemy glow competed too strongly.
- Brightness existed, but composition control did not.

Phase 2.6A addresses those issues without reducing the look back to flat icons.

## 3. Player Readability Changes

Changed in `scripts/NeonSwarm3DVisualPrototype.gd`:

- Added player-specific emissive materials:
  - `player_white`
  - `player_cyan`
  - `player_magenta`
  - `player_aura`
- Increased the white-hot player center from the shared small core mesh to a larger `player_core` mesh.
- Increased player tube/core thickness on the diamond frame.
- Kept player cyan/magenta identity unique from common enemy colors.
- Kept a controlled player aura rather than broad uncontrolled glow.
- Kept player trail segments, but retained them as a small fixed count.

Result: the player is designed to be the brightest and most readable object in the optimized 3D prototype.

## 4. Enemy Size/Shape Balance Changes

Changed in `scripts/NeonSwarm3DVisualPrototype.gd`:

- Enemy batches now split into `near` and `far` tiers.
- Far enemies use dimmer materials.
- Far enemies scale slightly down during batch updates.
- Nearby enemies can stay more readable without making the entire swarm equally bright.
- Tank/square enemies were reduced in base scale.
- Tank mesh size was reduced from the larger cube frame.
- Tank internal wireframe was simplified from heavy cube/diagonal overlap to a minimal three-axis core.
- Chaser core geometry was simplified to a sharper leading threat read.
- Shooter core geometry was simplified to an internal axis/muzzle read.
- Enemy grid spacing was widened slightly to reduce visual pileups.

Enemy shape identities remain:

- Chaser: sharp triangular / pyramid-arrow threat.
- Tank: square / cube-frame heavy enemy.
- Shooter: octahedron / diamond ranged enemy.

## 5. Brightness/Hierarchy Changes

New visual hierarchy implemented:

1. Player uses the highest energy material and larger white-hot core.
2. Projectiles use separate bright projectile core/tube materials.
3. Near enemies use brighter outer/core materials.
4. Far/common enemies use dimmed outer/core materials.
5. XP uses smaller scale and lower-emphasis yellow/cyan materials.
6. Grid and border materials were dimmed.
7. Decorative spark VFX uses reduced swarm density.

Specific material changes:

- Player white energy: highest in the prototype.
- Projectile core energy: second-tier brightness.
- Enemy near core/outer: below projectiles.
- Enemy far core/outer: visibly reduced.
- XP halo and ring: reduced alpha/energy and smaller scale.
- Grid lines: reduced alpha/energy.

## 6. Wireframe Clutter Reduction

Clutter reductions:

- Common tanks no longer include dense diagonal cube internals.
- Chaser and shooter core meshes were simplified.
- Tank base footprint was reduced.
- Enemy far tier is dimmed and scaled down.
- Enemy haze is not shown for far enemies in swarm mode.
- XP orbit spark and secondary ring continue to disable in swarm mode.
- Spark pool active count is reduced more aggressively in swarm mode.

The look still uses neon tubes, white-hot cores, and plasma materials. The reduction targets repeated decorative lines, not gameplay shape identity.

## 7. Swarm Mode Visual Rules

Current swarm-mode rules:

1. Preserve player center, player aura, player silhouette, and player trail.
2. Preserve projectile outer/core readability.
3. Preserve enemy outer tube silhouette and enemy core.
4. Dim far/common enemies.
5. Hide far enemy haze.
6. Hide XP orbit spark.
7. Hide XP secondary cyan ring.
8. Reduce active pooled sparks to one quarter of the pool.
9. Keep grid/background dim.

This follows the required visual priority:

1. Player
2. Immediate threats near player
3. Enemy bullets/projectiles
4. Enemies
5. XP orbs
6. Background/grid
7. Decorative VFX

## 8. HUD Notes

Changed in `scripts/HUD.gd`:

- Reduced top HUD vertical footprint.
- Reduced panel minimum heights.
- Reduced panel spacing and margins.
- Reduced timer/stat text sizes slightly.
- Reduced HP/XP bar height.
- Reduced panel shadow size.

The HUD remains readable and neon-styled, but is less visually bulky and leaves the gameplay area as the dominant view.

## 9. Performance Results

Validation commands run:

- `godot --headless --path . scenes/NeonSwarm3DVisualPrototype.tscn --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_phase26_3d_architecture_stress.gd`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_true_pause_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_xp_collection_smoke.gd`

Optimized 3D prototype stress result:

- Enemies: `150`
- XP orbs: `240`
- Projectiles: `60`
- Spark pool: `96`
- Total visual nodes: `52`
- Player visual nodes: `9`
- Enemy visual nodes: `18`
- XP visual nodes: `5`
- Projectile visual nodes: `3`
- Spark/VFX nodes: `1`
- Arena/grid nodes: `6`
- Quality mode: `swarm`
- 480-frame headless window: `3305 ms`
- Approximate headless ms/frame: `6.89`
- Result: passed

Main-game regression:

- Short launch passed.
- Long launch passed.
- Controller smoke passed.
- True pause smoke passed.
- XP collection smoke passed.

## 10. Files Changed

- `scripts/NeonSwarm3DVisualPrototype.gd`
- `scripts/HUD.gd`
- `docs/NEON_SWARM_PHASE_2_6A_3D_NEON_READABILITY_COMPOSITION_REPORT.md`

Existing prototype scene still used:

- `scenes/NeonSwarm3DVisualPrototype.tscn`

Stress helper used:

- `/tmp/neon_swarm_phase26_3d_architecture_stress.gd`

## 11. How The User Should Test It

1. Open `scenes/NeonSwarm3DVisualPrototype.tscn`.
2. Run the scene directly in Godot.
3. Confirm the player is the clearest object on screen.
4. Confirm common tank/square enemies are no longer oversized visual piles.
5. Confirm chasers, tanks, shooters, XP, projectiles, and player separate at a glance.
6. Confirm projectiles read brighter than common enemies.
7. Confirm XP reads as lower-priority collectible energy, not a dominant threat.
8. Confirm the grid stays behind gameplay visually.
9. Run the main game and confirm HUD is still readable but less bulky.
10. Confirm controller, pause, level-up, and XP collection still behave normally.

Manual art-direction checklist:

1. Is the player always the clearest object?
   - Code-side answer: yes, player now has unique highest-priority materials and larger white-hot center. Manual live review still required.
2. Are yellow square/tank enemies no longer creating messy piles?
   - Code-side answer: yes, tank scale and internals were reduced. Manual live review still required.
3. Can the user distinguish chasers, tanks, shooters, XP, bullets, and player at a glance?
   - Code-side answer: yes, separate materials, scale hierarchy, and simplified meshes support this. Manual live review still required.
4. Does the game look like controlled neon plasma, not random wireframe clutter?
   - Code-side answer: yes, repeated internal lines and swarm decoration were reduced. Manual live review still required.
5. Does the game stay smooth under swarm load?
   - Automated answer: yes, the stress test passed with 52 visual nodes and 480 frames in 3305 ms headless.
6. Does the screen feel closer to a professional neon arcade game?
   - Headless tests cannot prove this. Manual visual approval is still required.

## 12. Known Issues

- This is still a visual prototype, not migrated gameplay.
- Headless validation cannot prove subjective composition quality on a real display.
- MultiMesh batching still limits per-instance material nuance.
- Near/far enemy brightness tiers are prototype-side, not yet driven by real gameplay threat logic.
- The HUD restraint pass touched current HUD visuals, but no gameplay logic was changed.
- Full 3D migration remains unapproved.

## 13. Approval Question

Does Phase 2.6A now establish enough visual hierarchy and composition control in the optimized 3D prototype to justify a hybrid branch test, or should another readability pass focus specifically on player dominance, tank sizing, XP priority, projectile clarity, or HUD restraint?
