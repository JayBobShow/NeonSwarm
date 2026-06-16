# Neon Swarm Phase 2 Repair 4: Ghost Plasma and Performance Report

## 1. Executive Summary

Phase 2 Repair 4 was run as a delegated department pass. Codex acted as producer: department leads were assigned, their findings were collected, validation was rerun, and this report organizes the result.

The active art-direction constraint for this pass was [NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md](/home/jason/GodotProjects/NeonSwarm/docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md:1). Future enemies, bosses, hazards, pickups, weapons, levels, and visual passes must continue to use that document before implementation.

Goal of this pass:

- Push the build harder toward ghostly gas-light neon plasma.
- Keep the current gameplay loop unchanged.
- Improve heavy-swarm performance through smarter scaling, caps, and throttles.

No new weapons, enemy types, bosses, meta progression, game modes, gameplay redesigns, Moonbane assets, or copied Geometry Wars assets were added.

Phase 2 is still not approved until manual review.

## 2. Departments Used

Art Direction:

- Worker 1: shape-language audit.
- Worker 2: ghost-plasma read audit.
- Worker 3: acceptance/rejection checklist.

Technical Art:

- Worker 1: player and XP ghost-plasma construction.
- Worker 2: enemy luminous geometry, hit glow, and motion smears.
- Worker 3: overdraw controls and validation coordination.

VFX:

- Worker 1: `ParticleFX.gd` ghost-plasma bursts, caps, throttles, and helper repair.
- Worker 2: `Projectile.gd` hotter projectile cores, cheaper trails, and impact guardrails.
- Worker 3: `WeaponController.gd` orbit VFX throttling and cheaper orbit arc drawing.

Performance / Optimization:

- Worker 1: projectile/root pressure and transient hitbox accounting.
- Worker 2: VFX cap and LOD verification.
- Worker 3: enemy, XP, nearest-scan, and collision cost review.

QA:

- Worker 1: runtime regression for headless boot, controller, pause, and XP collection.
- Worker 2: performance/VFX regression through stress tests.
- Worker 3: shape-language/readability review against the geometry bible.

## 3. Art Direction Findings

What still read too flat:

- Current shapes were readable but often looked like perfect closed outlines with even glow.
- Player, enemies, and XP still risked reading as UI symbols rather than energy objects.
- Dead-black interiors and symmetrical outlines made the plasma feel too clean.
- XP still had a risk of reading as a reticle or token instead of collectible energy.
- Arena and HUD styling could compete with gameplay if made too bright.

What makes the shapes read as gas-light plasma:

- Keep each primary geometry identity from the bible, but make the light feel emitted from the object.
- Use uneven hot segments instead of uniform icon strokes.
- Use near-white cores, thicker colored tube lines, localized corner/node burn, soft plasma haze, and edge breakup.
- Tie sparks to silhouettes and motion direction so particles feel like part of the shape.
- Use movement smears and hit flares to make objects feel alive.

Acceptance/rejection rules from Art Direction:

- Reject any shape that becomes a flat polygon plus glow.
- Reject any pass that collapses swarm mode back to weak outline icons.
- Reject any change that breaks the current player, enemy, XP, weapon, or arena geometry identities.
- Reject any VFX solution that uses unlimited particles instead of capped plasma/line work.

## 4. Technical Art Changes

Files changed:

- `scripts/Player.gd`
- `scripts/Enemy.gd`
- `scripts/XPOrb.gd`
- `scripts/Main.gd`

Technical construction changes:

- Player, enemies, and XP now use thicker layered luminous geometry: soft outer glow, saturated colored tube stroke, and near-white inner core stroke.
- Player construction now emphasizes cached diamond geometry, rotating hex/ring energy, velocity smears, plasma haze, vapor breakup arcs, orbit sparks, and stronger red/white hit flash.
- Enemies preserve the geometry bible identities:
  - Chaser: acute triangle / arrow.
  - Tank: square / box-ring.
  - Shooter: diamond / rhombus.
  - Exploder: annulus / warning ring.
- Enemy visuals now use cached body/outer/inner point arrays, thicker colored outlines, hot cores, internal energy strokes, motion smears, edge-breakup sparks, hot nodes, and stronger hit flash.
- XP orbs preserve circle/annulus pickup identity with stronger yellow/cyan tubes, hot centers, plasma halo, vapor wisps, and capped spark glints.
- Arena grid treatment now uses cached grid geometry and quality-aware background detail.

Overdraw controls:

- Swarm mode reduces transparent layers without removing the core shape read.
- Enemy trails draw only at full quality.
- Enemy redraw intervals now separate full, medium, and swarm modes.
- Enemy spark counts reduce by visual quality.
- Enemy and XP helper functions collapse multi-layer glow into cheaper tube/core strokes in swarm mode.
- XP idle redraw slows at medium quality and skips expensive idle work in swarm mode.
- XP secondary diagonals, vapor, and ring sparks degrade before the main annulus/energy read.
- Swarm arena skips minor grid lines, dust, grid nodes, extra border layers, and every other star.
- Visual quality thresholds now include XP pickup count so large XP fields trigger degradation earlier.

## 5. VFX Changes

Files changed:

- `scripts/ParticleFX.gd`
- `scripts/Projectile.gd`
- `scripts/WeaponController.gd`

VFX behavior changes:

- VFX now favors hotter white cores, thicker colored plasma streaks, soft vapor rings, and short spark breakup.
- Projectile impacts use spatial throttling so clustered hits do not produce unbounded effects.
- Enemy hit effects use quick hot flashes and small capped spark fragments.
- Pickup pops use capped spatial buckets to avoid XP collection spam.
- Weapon muzzle effects use global throttling and are skipped in swarm mode.
- Nova and explosion effects retain hot centers and ring/ray language, but reduce secondary fragments by quality tier.
- Orbit Spark visuals use cheaper arc drawing and throttled hit VFX.

Performance/clutter controls:

- VFX caps were tightened to:
  - Full quality: 72 effect nodes
  - Medium quality: 46 effect nodes
  - Swarm quality: 24 effect nodes
- Secondary VFX reserve keeps readable core flashes from being starved by decorative fragments.
- Swarm mode shortens durations and reduces ring points/fragments.
- Spatial buckets throttle projectile impacts, enemy hits, and pickup pops.
- Global throttles reduce repeated muzzle effects.
- Helper repair completed for `_trim_throttle_buckets`, `_vapor_puff`, `_allow_spatial_effect`, `_allow_global_effect`, `_can_spawn_secondary_effect`, and interval helpers.

## 6. Performance Findings

Current performance guardrails confirmed:

- `MAX_ENEMIES = 180`
- `MAX_PROJECTILES = 260`
- `MAX_XP_ORBS = 240`
- VFX caps: `72 / 46 / 24`
- Dynamic visual quality degradation still active.
- Nearest-enemy target caching remains important and effective.
- Decorative VFX degrades before gameplay readability.

Performance stress findings:

- Main remaining slowdown pressure is projectile/root churn plus collision-backed projectile processing.
- Transient blast/hitbox nodes share `projectiles_root`, so the observed root count can briefly exceed the nominal `MAX_PROJECTILES = 260`.
- In stress, `max_projectiles_observed = 267`, which is above the intended projectile cap because transient collision/hitbox nodes are counted in the same root.
- Recommendation: in a future optimization pass, separate transient hitbox nodes from projectile root accounting or enforce one combined root budget.
- VFX caps now behave correctly: swarm peak held at `24`, and secondary effects degraded first.
- Nearest-enemy caching is effective:
  - `12000` cached calls: `5 ms`
  - `3000` uncached scans: `197 ms`
- XP cap/merge pressure is acceptable but non-trivial:
  - `1200` capped XP merge pressure: `69 ms`
  - Keep the `240` XP cap.

The solution did not reduce the whole game back to weak outlines. It keeps stronger plasma treatment at high priority while reducing secondary haze, sparks, trails, grid detail, and VFX density under heavy load.

## 7. Validation

Producer validation after all department changes:

- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . --quit-after 3000`: passed.
- `godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd`: passed.
- `godot --headless --path . --script /tmp/neon_swarm_true_pause_smoke.gd`: passed.
- `godot --headless --path . --script /tmp/neon_swarm_xp_collection_smoke.gd`: passed.

XP collection smoke result:

- Initial XP: `0`
- Final XP: `5`
- Remaining XP orbs: `0`

Repair 4 performance stress:

- Command: `godot --headless --path . --script /tmp/neon_swarm_phase2_repair4_perf_stress.gd`
- Attempted enemies: `260`
- Attempted XP pressure: `520 + 1200 cap-merge pressure`
- Attempted enemy projectiles: `420`
- Attempted player collision projectiles: `260`
- Attempted mixed VFX events: `240 + nova`
- Peak enemies: `180`
- Peak XP orbs: `240`
- Peak projectiles: `260`
- Peak FX nodes: `24`
- Final enemies: `96`
- Final XP orbs: `240`
- Final projectiles: `26`
- Final FX nodes: `11`
- Final visual quality: `0 / swarm`
- Max enemies observed: `180`
- Max XP orbs observed: `240`
- Max projectiles observed: `267`
- Max FX nodes observed: `24`
- Nearest cached `12000` calls: `5 ms`
- Nearest uncached `3000` calls: `197 ms`
- XP merge pressure `1200`: `69 ms`
- Sustain `480` frames: `7992 ms`
- Collision `150` frames: `2494 ms`
- Result: passed.

Repair 4 ghost plasma/performance stress:

- Command: `godot --headless --path . --script /tmp/neon_swarm_phase2_repair4_ghost_plasma_performance_stress.gd`
- Enemies: `135`
- XP orbs: `239`
- Projectiles: `260`
- Peak FX nodes: `24`
- Final FX nodes: `19`
- Visual quality: `0 / swarm`
- Elapsed: `5996 ms`
- Result: passed.

## 8. Known Issues

- Headless Godot cannot prove the subjective ghostly neon plasma look on a real display.
- Real controller hardware was not physically tested during this pass, though the controller smoke passed.
- Transient projectile/hitbox nodes can still push `projectiles_root` above the nominal projectile cap; observed maximum was `267`.
- XP orbs now retain annulus/circle identity with diamond/crystal energy framing, but manual review should confirm the orb/annulus read dominates at gameplay scale.
- Swarm mode intentionally reduces secondary vapor, sparks, trails, and grid detail to protect performance.
- This pass does not claim Phase 2 approval.

## 9. What The User Should Test

1. Run `Main.tscn` in Godot 4.6.3.
2. Confirm the player reads as the clearest object on screen under both low and high enemy counts.
3. Confirm player, enemies, projectiles, and XP look like thick ghostly gas-light/plasma objects, not clean UI icons.
4. Confirm enemies still read by primary geometry:
   - Chaser: acute arrow/triangle.
   - Tank: square/box-ring.
   - Shooter: diamond/rhombus.
   - Exploder: annulus/warning ring.
5. Confirm XP orbs read as collectible glowing energy rewards, not flat pickups.
6. Let enemy and XP counts rise for several minutes and watch for FPS drops, overdraw haze, or visual clutter.
7. Confirm the arena grid supports the plasma look without overpowering gameplay.
8. Confirm Pulse Blaster, Orbit Spark, Nova, impacts, deaths, and pickup pops feel hotter and more energetic.
9. Pause with Start/P/Esc and confirm true pause still freezes gameplay.
10. Level up with controller and confirm selection/highlight/confirm still work.
11. Decide whether the stronger plasma treatment is now closer to the locked target, or whether another focused repair should target one area only.

## 10. Approval Question

Does Phase 2 Repair 4 now hit the required ghostly gas-light plasma neon direction strongly enough to continue, while keeping heavy-swarm performance acceptable, or should the next repair focus narrowly on one remaining weak area: player, enemies, XP, VFX, arena, HUD, or projectile/root performance?
