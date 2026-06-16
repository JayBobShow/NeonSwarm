# Neon Swarm Phase 2 Repair 2: Vector Neon Rebuild Report

## 1. Executive Summary

Phase 2 Repair Pass 2 rebuilds Neon Swarm's visual presentation around vector-neon arcade principles instead of filled cardboard shapes.

The pass removes colored filled silhouettes from the player, enemies, XP, projectiles, and orbitals as the primary visual language. Gameplay entities remain collision-backed; particles, trails, sparks, rings, and glow are still visual feedback only.

This is not a gameplay expansion pass. No bosses, new weapons, new enemy types, meta progression, campaign/story, hand-painted sprites, AI sprites, Moonbane assets, or copied Geometry Wars assets were added.

Phase 2 is still not approved until manual review.

## 2. Why Repair Pass 1 Was Rejected

Repair Pass 1 improved readability and performance, but its core shapes still looked like colored paper/cardboard cutouts with glow behind them.

The rejected look came from:

- Filled player/enemy bodies defining silhouettes.
- Filled XP diamonds and projectile dots.
- Flat UI boxes with glow styling.
- Glow halos supporting solid shapes instead of light-tube outlines defining the forms.
- Not enough thin vector linework, white-hot centers, electric fragments, and grid-world intensity.

## 3. Reference Style Principles Used

The pass translates Geometry Wars-style principles without copying assets, enemy designs, layouts, names, or copyrighted material:

- Nearly black void background.
- Blue/purple glowing grid.
- Thin bright vector outlines.
- Mostly transparent/dark interiors.
- White-hot line cores.
- Color-coded neon tubes.
- Sparks and line fragments instead of heavy filled particles.
- Expanding vector rings and radial rays.
- High contrast between gameplay objects and the arena.
- Performance-first visual degradation under heavy load.

## 4. Player Vector Neon Changes

- Rebuilt the player as line-first vector geometry.
- Removed the filled core/body dependency.
- Added cyan/white neon arcs, magenta diamond outline, hex linework, cross-lines, and a white-hot line-cross center.
- Converted aim indicator to neon line/ring geometry.
- Kept a clean cyan/magenta light streak trail.
- Player remains the highest visual priority through z ordering and bright white/cyan linework.

Art-direction answer: the player now reads as neon vector light, not a filled paper shape.

## 5. Enemy Vector Neon Changes

- Enemy silhouettes are now outline/wireframe-first.
- Colored filled bodies are no longer the primary read.
- Interiors are only dark transparent masks for readability, not colored cardboard fills.
- Chaser: sharp arrow/triangle-like neon outline with internal vector lines.
- Tank: heavy square/box outline with internal cross lines and inset vector box.
- Shooter: diamond outline with inner diamond, forward barrel line, and firing direction marker.
- Exploder: pulsing circular warning outline with radial spikes and bright danger rings.
- Hit flash is now a white/color vector ring rather than a filled flash blob.
- Existing collision shapes and enemy logic were not changed.

Art-direction answer: enemies now read as neon outlines/wireframes, not colored cardboard shapes.

## 6. XP Orb Neon Changes

- XP pickups now read as small energy objects.
- Rebuilt visuals around pulsing neon rings, a diamond outline, cross-line energy core, and orbiting spark glint.
- Removed the filled XP diamond and filled center dot.
- Attraction keeps a line trail into the player.
- Collection pop uses capped vector sparks and ring feedback.
- XP cap and merge behavior remain intact.

Art-direction answer: XP now reads as an energy pickup, not a coin or cardboard dot.

## 7. Weapon/VFX Neon Changes

- Pulse Blaster projectiles now draw as laser streaks with white-hot line centers and colored glow trails.
- Projectile filled center dot was replaced with a small white-hot line cross.
- Orbit Spark nodes were rebuilt from filled `Polygon2D` diamonds into `Line2D` neon diamond outlines with internal vector slashes.
- Orbit Spark arc trails now respect visual quality tiers.
- Nova Burst uses expanding vector rings, radial line rays, white-hot center star, and capped line fragments.
- Enemy impacts and explosions now use vector line fragments and sparks instead of relying on dense particle clouds.
- VFX still uses caps and quality scaling; particles/VFX remain visual only.

Art-direction answer: weapons now read more like laser energy and vector arcade feedback.

## 8. Arena/Grid Changes

- Arena background remains a near-black void.
- Grid lines now use blue/purple core lines plus faint glow lines.
- Arena border was tightened into thin electric cyan/magenta line layers instead of thick frame bands.
- Background stars/dust remain low priority and behind gameplay.
- The grid supports the vector arcade feel without hiding player, enemies, bullets, or XP.

Art-direction answer: the arena is closer to a dark neon grid world.

## 9. HUD/UI Changes

- HUD panels use transparent dark interiors with thin neon borders.
- Health and XP bars read more like glowing light tubes.
- Pause and game-over overlays use intentional arcade-line styling.
- Level-up overlay uses transparent neon panels.
- Selected upgrade focus is a strong gold neon outline for controller selection.
- Input semantics and level-up behavior were not changed.

## 10. Performance Optimizations Preserved/Added

Preserved from Repair Pass 1:

- `MAX_ENEMIES = 180`
- `MAX_PROJECTILES = 260`
- `MAX_XP_ORBS = 240`
- VFX caps: full 86, medium 58, swarm 34 effect nodes.
- Dynamic visual quality degradation.
- Nearest-enemy target caching.
- XP merge behavior at cap.
- Idle XP sleep until attraction.
- Enemy redraw throttling.
- Contact damage distance gate.

Added or tightened in Repair Pass 2:

- VFX now favors capped `Line2D` fragments/rings over dense particle spam.
- Orbit Spark visual arcs reduce segment counts by visual quality tier.
- Projectile, XP, enemy, and player visuals remain line-based under normal mode and simplify under swarm mode.
- Stress test now floods enemies, XP, projectiles, and VFX at the same time.

## 11. Stress Test Results

Added and ran:

- `godot --headless --path . --script /tmp/neon_swarm_phase2_repair2_stress.gd`

Stress setup:

- Attempted to spawn 220 enemies.
- Attempted to spawn 320 XP orbs.
- Attempted to spawn 340 projectiles.
- Attempted to spawn 160 explosion/VFX events.
- Ran 420 physics/process frames.

Immediate cap results:

- Enemies: 180
- XP orbs: 240
- Projectiles: 260
- VFX nodes: 86

Post-simulation results:

- Enemies: 135
- XP orbs: 240
- Projectiles: 19
- VFX nodes: 33
- Visual quality: 0 / swarm mode
- Elapsed headless stress time: 7005 ms
- Result: passed

Interpretation: the build hit all caps immediately, then degraded decorative visuals to swarm mode and cleaned up projectiles/VFX without runaway nodes or severe headless slowdown.

## 12. Controller/Pause Regression Results

Passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_true_pause_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_xp_collection_smoke.gd`

Regression coverage:

- Controller smoke test passed.
- True pause smoke test passed.
- Keyboard/controller movement paths still load cleanly.
- Level-up UI remains controller-navigable.
- XP attraction/collection passed: XP moved from 0 to 5 and the collected orb was freed.
- Headless short and long launches exit cleanly.

## 13. Files Changed

- `scripts/Player.gd`
- `scripts/Enemy.gd`
- `scripts/XPOrb.gd`
- `scripts/Projectile.gd`
- `scripts/WeaponController.gd`
- `scripts/ParticleFX.gd`
- `scripts/Main.gd`
- `scripts/HUD.gd`
- `scripts/UpgradeSystem.gd`
- `docs/NEON_SWARM_PHASE_2_REPAIR_2_VECTOR_NEON_REBUILD_REPORT.md`

Validation helper:

- `/tmp/neon_swarm_phase2_repair2_stress.gd`

## 14. How I Should Test It

1. Open the project in Godot 4.6.3.
2. Run `Main.tscn`.
3. Confirm the player is line-based neon, not a filled body.
4. Confirm chaser, tank, shooter, and exploder are mostly outlines/wireframes.
5. Confirm XP orbs look like energy pickups with rings/glints.
6. Confirm Pulse Blaster shots look like laser streaks.
7. Confirm Orbit Spark nodes are light outlines with arc trails.
8. Trigger Nova and confirm it reads as vector rings, rays, and sparks.
9. Let the enemy count rise and confirm visuals degrade gracefully instead of tanking performance.
10. Press Start/P/Esc and confirm true pause still freezes gameplay.
11. Level up and confirm controller selection/confirm still work.
12. Decide manually whether the look is close enough to the locked vector-neon target.

## 15. Known Issues

- Headless Godot cannot validate the subjective neon/vector look because it uses a dummy renderer.
- Manual live visual review is still required before approval.
- Engine bloom remains off; glow is simulated with draw layers and additive-style line/VFX materials to preserve readability.
- Some dark transparent enemy interiors remain intentionally to preserve readability, but they are not colored silhouettes.
- The HUD is still prototype-dense, though it is now styled as thin neon panels rather than flat boxes.

## 16. Approval Question

Phase 2 Repair Pass 2 is ready for manual review.

Does this build now meet the locked vector-neon arcade target closely enough to approve Phase 2 visual identity, or should it receive another focused repair pass?

This report does not mark Phase 2 approved.
