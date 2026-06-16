# Neon Swarm Phase 2 Repair 1: Neon Identity + Performance Report

## 1. Executive Summary

Phase 2 Repair Pass 1 addresses the rejected visual identity pass by pushing Neon Swarm harder toward a procedural neon arcade survival shooter while adding performance guardrails for heavy enemy counts.

This was a repair pass only. No bosses, new weapons, new enemy types, meta progression, campaign systems, inventory systems, imported art, hand-painted sprites, AI sprite sheets, Moonbane assets, NES_Rebuild_Project assets, or copyrighted Geometry Wars assets were added.

The pass keeps gameplay collision-backed. Particles, glow rings, trails, and sparks remain presentation only.

## 2. User Feedback Addressed

- "This is not a neon arcade game": increased black-background contrast, electric outlines, brighter vector shapes, layered glow, sharper player/enemy silhouettes, and stronger neon arena border.
- "It is easy to read, but not neon looking": replaced much of the flat-feeling presentation with procedural glow layers, additive-style VFX, brighter white/cyan/magenta/gold accents, and more explicit light-object styling.
- "XP orbs need to be more neon-ish": rebuilt XP visuals as glowing collectible crystals with halo, rings, pulse, attraction trail, and collection burst.
- "The screen gets cluttered when it fills up with enemies": added visual priority rules, explicit z layers, enemy redraw throttling, lower background intensity, and reduced decorative effects under load.
- "It slows way down": added entity and VFX caps, nearest-target caching, idle XP sleep behavior, projectile spawn guardrails, VFX quality tiers, cached materials, cached shape points, and a heavy-count stress test.
- "It does not feel like Geometry Wars": moved presentation closer to intense abstract neon vector arcade energy without copying assets, names, exact silhouettes, or copyrighted material.

## 3. Why Phase 2 Was Rejected

The rejected Phase 2 pass improved readability but did not push the visual identity far enough. The playfield still read as a clean prototype with glow rather than a premium neon arcade game.

The main failures were:

- Neon intensity was too restrained.
- XP collectibles did not feel premium or energetic.
- Decorative effects and enemy visuals competed when the arena filled.
- Enemy, projectile, XP, and VFX counts had too few guardrails.
- Heavy enemy counts could overwhelm CPU/draw work.

## 4. Neon Visual Changes

- Added stronger procedural glow and electric outlines to player, enemies, projectiles, XP, and arena borders.
- Shifted the background toward a darker black/blue void so neon silhouettes read brighter.
- Reduced background dust intensity and made the grid colder and dimmer so it supports the arcade feel without fighting gameplay objects.
- Added explicit visual priority layers:
  - Background/grid: low priority.
  - XP: below bullets and enemies.
  - Projectiles: above XP.
  - Enemies: above projectiles.
  - Player: highest gameplay readability.
  - VFX: capped and quality-scaled.
- Kept visual work procedural: CanvasItem draw calls, Line2D rings, CPUParticles2D bursts, and additive CanvasItem material.

## 5. XP Orb Changes

- XP orbs now draw as faceted neon collectibles instead of plain pickups.
- Added glowing core, outer halo, rotating ring arcs, white/gold glint, and cyan accent line.
- Added pulsing brightness for idle state.
- Added attraction trail when pulled into the player.
- Added collection pop through the capped VFX system.
- Added XP value merging when the XP cap is reached so heavy combat does not spawn unlimited pickup nodes.
- Disabled idle physics processing for XP orbs until they are attracted to the player.

## 6. Enemy Clutter Fixes

- Enemy bodies now use cached geometric point arrays instead of rebuilding shape points every draw.
- Enemy visuals switch to lower-cost, simpler glow behavior in swarm mode.
- Enemy movement trails are disabled under heavy load.
- Enemy redraws are throttled in swarm mode.
- Contact damage checks now distance-gate before asking physics for overlapping bodies.
- Enemy danger colors and silhouettes stay distinct:
  - Chaser: fast green vector threat.
  - Tank: heavy yellow/orange outline and mass.
  - Shooter: magenta ranged shape and muzzle read.
  - Exploder: red pulsing danger ring and core.
- Background intensity was reduced so enemies remain the second visual priority after the player.

## 7. Performance Investigation

The slowdown risk came from several scaling paths:

- Enemy spawner could keep adding enemy packs with no hard enemy cap.
- Player projectiles had a cap helper, but the Pulse Blaster path did not enforce it.
- Auto-targeting could scan all enemies too often.
- Every enemy redrew every physics tick, including glow and trail work.
- Contact damage could ask for overlaps per enemy without a cheap distance filter.
- Idle XP orbs processed every frame even when not moving.
- VFX created new particle and line nodes freely, with no quality degradation under load.
- Additive CanvasItem materials were being allocated per effect instead of reused.
- XP drops could accumulate into too many pickup nodes during high-kill stress.

## 8. Performance Optimizations Made

- Added hard gameplay object guardrails:
  - `MAX_ENEMIES = 180`
  - `MAX_PROJECTILES = 260`
  - `MAX_XP_ORBS = 240`
- Added VFX node caps by visual quality tier:
  - Full: 86 effect nodes.
  - Medium: 58 effect nodes.
  - Swarm: 34 effect nodes.
- Added dynamic visual quality tiers based on enemy count, projectile count, and active VFX count.
- Added `can_spawn_enemy()` and used it from the spawner.
- Added `can_spawn_player_projectile()` and used it from Pulse Blaster spawning.
- Added nearest-enemy target caching with a 0.10 second refresh for normal player auto-targeting.
- Added cached enemy and XP shape point arrays.
- Added idle XP sleep behavior and only enables XP physics after attraction starts.
- Added XP merge behavior when the pickup cap is reached.
- Added cached additive material in `ParticleFX.gd`.
- Scaled particle amounts, ring point counts, and effect durations down in lower visual quality modes.
- Disabled small enemy-hit spark spam in swarm mode.
- Reduced screen shake intensity in swarm mode.

## 9. Stress Test Results

Added and ran `/tmp/neon_swarm_phase2_repair1_stress.gd`.

Stress setup:

- Attempted to spawn 220 enemies.
- Attempted to spawn 320 XP orbs.
- Attempted to spawn 140 decorative explosion bursts.
- Ran 420 physics/process frames in headless mode.

Observed result:

- Enemies after simulation: 128
- XP orbs after simulation: 239
- Projectiles after simulation: 26
- Active VFX nodes after simulation: 9
- Visual quality tier: 0 / swarm mode
- Elapsed headless stress time: 6995 ms
- Result: passed

The enemy count dropped below the 180 cap during the stress run because combat continued and enemies died while the scenario was running. The important result is that attempted overspawn did not create runaway entities, XP stayed under the 240 cap, VFX stayed capped, and the system degraded to swarm mode instead of continuing full-cost visuals.

## 10. Controller/Pause Regression Results

Passed:

- `godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_true_pause_smoke.gd`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_xp_collection_smoke.gd`

Regression coverage:

- Controller smoke test passed.
- True pause smoke test passed.
- Start/P/Esc pause behavior remains backed by `get_tree().paused`.
- Level-up screen remains navigable while the tree is paused.
- Manual pause and level-up pause remain separate.
- No mouse is required for normal controller play.
- XP attraction and collection passed: final XP moved from 0 to 5 and the collected orb was freed.
- Headless project launch and longer headless run exit cleanly.

## 11. Files Changed

- `scripts/Main.gd`
- `scripts/EnemySpawner.gd`
- `scripts/WeaponController.gd`
- `scripts/ParticleFX.gd`
- `scripts/Enemy.gd`
- `scripts/XPOrb.gd`
- `scripts/Projectile.gd`
- `scripts/Player.gd`
- `scripts/HUD.gd`
- `scripts/UpgradeSystem.gd`
- `docs/NEON_SWARM_PHASE_2_REPAIR_1_NEON_PERFORMANCE_REPORT.md`

Validation helper:

- `/tmp/neon_swarm_phase2_repair1_stress.gd`
- `/tmp/neon_swarm_xp_collection_smoke.gd`

## 12. How I Should Test It

1. Open the project in Godot 4.6.3.
2. Run `Main.tscn`.
3. Play with keyboard for at least two minutes.
4. Play with an Xbox-style controller for at least two minutes.
5. Confirm the player is always the brightest/readable object.
6. Confirm enemies stay readable when the arena fills.
7. Confirm Pulse Blaster, Orbit Spark, and Nova Burst still work as before.
8. Confirm XP orbs read as glowing neon collectibles.
9. Confirm XP attraction feels like energy being pulled into the player.
10. Press Start/P/Esc and confirm enemies, spawners, weapons, XP, and timer freeze.
11. Level up and confirm controller selection and A confirm still work.
12. Let enemy count rise and watch for graceful visual degradation instead of severe slowdown.

## 13. Known Issues

- Headless Godot uses a dummy renderer in this environment, so it cannot validate the final subjective neon look with screenshots.
- The stress test is synthetic and headless; final acceptance still needs live visual inspection in the Godot window.
- The enemy cap is a deliberate Phase 2 repair guardrail, not final balance.
- Engine-level bloom remains off; this repair uses procedural glow and additive-style materials to avoid washing out gameplay.
- The HUD is improved but still prototype-dense. A later approved UI pass can refine layout hierarchy further.

## 14. Approval Question

Phase 2 Repair Pass 1 is ready for manual review. Please test the live Godot build and decide whether the neon identity and heavy-count performance now meet the Phase 2 bar.

This report does not mark Phase 2 approved.
