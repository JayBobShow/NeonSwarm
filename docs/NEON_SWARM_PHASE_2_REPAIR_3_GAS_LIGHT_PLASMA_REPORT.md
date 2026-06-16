# Neon Swarm Phase 2 Repair 3: Gas-Light / Plasma Neon Report

## 1. Executive Summary

Phase 2 Repair Pass 3 rebuilds the visual skin around gas-light and plasma principles instead of clean outline-icon drawing.

The target correction was specific: Neon Swarm had moved closer to vector neon, but still looked like thin UI symbols on a dark grid. This pass pushes important gameplay objects toward layered energy construction: white-hot cores, colored neon strokes, soft plasma glow, sparks shedding from silhouettes, motion smears, hit flashes, and capped explosive particle/line feedback.

`docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md` is now the official geometry-shape reference for Neon Swarm. Future regular enemies, elite enemies, mini-bosses, major bosses, weapons, pickups, hazards, level themes, and visual style passes must be checked against that document before implementation.

Departments used:

- Game Direction
- Art Direction
- Technical Art
- VFX
- Godot Engineering
- Performance/Optimization
- UI/HUD
- QA

No bosses, new weapons, new enemy types, meta progression, campaign/story, hand-painted sprites, AI sprite sheets, Moonbane assets, or copied Geometry Wars assets were added. Gameplay collision remains based on real collision shapes; particles and glow are visual feedback only.

Phase 2 is still not approved until manual review.

## 2. Why Repair Pass 2 Was Rejected

Repair Pass 2 improved the project from cardboard-like filled shapes to vector outlines, but the result was still too clean and icon-like.

The rejected look came from:

- Player, enemies, and XP reading as drawn symbols instead of light-energy objects.
- Outlines that were too even and too clean.
- Interiors that felt empty rather than charged with energy.
- Glow that behaved like a halo behind geometry instead of bloom from hot gas/light.
- Particles that felt added after the shape instead of forming and shedding from it.
- Impacts and deaths that were not spectacular enough for the locked neon arcade target.

## 3. Gas-Light / Plasma Visual Principles Used

This pass uses the following style rules:

- White-hot inner strokes carry the highest intensity.
- Colored cyan, magenta, orange, green, red, and yellow strokes wrap the hot cores.
- Soft glow layers extend outward from important objects.
- Small sparks and hot points sit along edges and corners.
- Motion trails use light smears rather than plain single lines.
- Hit feedback uses white flashes, glow pulses, and colored spark spray.
- Death and collection effects use short-lived hot centers, line fragments, sparks, and fading rings.
- Background energy stays behind gameplay priority objects.
- Decorative VFX is capped and degrades before gameplay readability or performance are harmed.

Visual priority remains:

1. Player
2. Enemy danger
3. Enemy bullets/projectiles
4. XP orbs
5. Background

## 4. Player Plasma Core Changes

- Rebuilt the player draw stack with a brighter plasma haze and layered glow shell.
- Added white-hot center strokes and hot center points.
- Added cyan/magenta energy arcs and angular internal line details.
- Added small orbiting sparks and silhouette spark points.
- Expanded movement trail into a wider light smear with multiple fading strokes.
- Strengthened hit flash with outward bloom, white-hot center response, and red plasma haze.
- Preserved player movement, collision, stats, input, weapons, and pause behavior.

Art-direction self-check: the player now targets a plasma core/light-machine read rather than a flat filled shape or simple outline icon. Manual live review is still required.

## 5. Enemy Energy Shape Changes

Enemies remain the same gameplay types and collision-backed entities, but their skins were pushed toward gas-light shapes:

- Chaser: sharper cyan/green energy arrow with a hot leading edge, internal vector strokes, and trailing sparks.
- Tank: heavier orange/yellow box/ring structure with hot corner nodes, internal crossbars, and thicker glow.
- Shooter: magenta/purple diamond energy frame with a brighter charged muzzle point and directional marker.
- Exploder: unstable red/orange plasma ring with warning flicker, radial spokes, hot center, and spark leakage.

Shared enemy changes:

- Stronger white-hot core sections.
- Colored neon outline layers.
- Soft bloom haze around the form.
- Edge/corner spark shedding.
- Faint internal energy strokes.
- Stronger hit flash.
- Death handoff to brighter spark/line-fragment VFX.

Art-direction self-check: enemies now target dangerous energy-object reads instead of empty wireframe icons. Manual live review is still required.

## 6. XP Energy Pickup Changes

- Rebuilt XP pickups around a white-hot center point.
- Added brighter cyan/yellow plasma halo treatment.
- Added pulsing outer rings and diagonal energy strokes.
- Added tiny orbiting spark/glint points.
- Strengthened collection trail and energy-pop feedback.
- Kept XP cap, pickup radius behavior, attraction behavior, collection logic, and level-up logic intact.

The intended read is a field of collectible neon energy, not coins, cardboard dots, or plain outlined tokens.

## 7. Particle Shape/Forming Changes

- Added spark points along object silhouettes so particles visually belong to the shape.
- Added edge/corner spark shedding to enemies.
- Added orbiting sparks around the player and XP orbs.
- Reworked VFX toward paired glow/core line fragments so bursts feel like light breaking apart.
- Added muzzle and impact VFX hooks so weapon fire has source and contact energy.
- Kept all particles and line fragments visual-only; they do not drive gameplay collision.

Performance tiers reduce decorative spark/trail density first. Player readability and enemy danger readability are not intentionally degraded.

## 8. Impact/Death VFX Changes

Enemy hit feedback:

- Quick white flash.
- Small colored spark spray.
- Brief light pulse.
- Optional hot plasma center in higher visual quality modes.

Enemy death feedback:

- White-hot center pop.
- Colored spark explosion.
- Short-lived line fragments.
- Fading glow rings.
- Capped duration debris.

Weapon and pickup feedback:

- Pulse Blaster impacts now use directional projectile-impact sparks.
- Weapon muzzle points can emit a short plasma pop.
- Nova keeps an expanding vector ring, radial rays, center flash, and outward sparks.
- XP collection produces a small energy pop with collection-trail timing.

## 9. Bloom/Glow/Light Intensity Changes

- Increased contrast by keeping the arena background closer to black.
- Increased white-hot centers on player, enemies, XP, projectiles, impacts, and bursts.
- Strengthened colored glow falloff around important objects.
- Kept the grid blue/purple and below gameplay brightness.
- Reworked HUD and upgrade panels toward transparent interiors with thin neon borders.
- Avoided relying on unlimited engine particles or expensive blur to fake bloom.

The glow is primarily draw-layer and line/VFX based so it remains controllable under load.

## 10. Performance Guardrails

Preserved gameplay/entity caps:

- `MAX_ENEMIES = 180`
- `MAX_PROJECTILES = 260`
- `MAX_XP_ORBS = 240`

Preserved VFX caps:

- Full quality: 86 VFX nodes
- Medium quality: 58 VFX nodes
- Swarm quality: 34 VFX nodes

Preserved or added guardrails:

- Dynamic visual quality degradation.
- Decorative spark/trail reduction under heavy load.
- Capped effect spawning with reserve for high-priority effects.
- Paired glow/core line fragments are counted against VFX budget.
- Short VFX durations in swarm mode.
- Orbit Spark arc segment reduction by visual quality.
- XP cap and merge behavior.
- Projectile cap.
- Enemy cap.
- Nearest-enemy targeting cache.
- Idle XP sleep until attraction.
- Enemy redraw throttling.
- No unbounded decorative particle emission.

## 11. Stress Test Results

Repair 3 stress script:

- `godot --headless --path . --script /tmp/neon_swarm_phase2_repair3_stress.gd`

Stress setup:

- Heavy enemy flood.
- High XP count.
- High projectile count.
- Active VFX flood.
- Quality degradation allowed.

Immediate cap results:

- Enemies: 180
- XP orbs: 240
- Projectiles: 260
- VFX nodes: 84

Post-simulation results:

- Enemies: 135
- XP orbs: 240
- Projectiles: 24
- VFX nodes: 13
- Visual quality: 0 / swarm mode
- Elapsed headless stress time: 7017 ms
- Result: passed

Interpretation: the stress run hit heavy caps, activated swarm visual quality, cleaned up VFX/projectiles, and did not produce runaway nodes.

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
- XP collection smoke test passed.
- Short and long headless launches passed.
- Keyboard/controller movement code paths still load.
- Level-up UI remains controller navigable.
- Manual live controller testing is still recommended because headless tests cannot exercise a physical gamepad feel.

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
- `docs/NEON_SWARM_PHASE_2_REPAIR_3_GAS_LIGHT_PLASMA_REPORT.md`

Validation helper:

- `/tmp/neon_swarm_phase2_repair3_stress.gd`

## 14. How I Should Test It

1. Open the project in Godot 4.6.3.
2. Run `Main.tscn`.
3. Confirm the player reads as a bright plasma core with hot strokes, glow shell, sparks, and light-smear trail.
4. Confirm chaser, tank, shooter, and exploder look like dangerous energy shapes, not flat icons.
5. Confirm XP orbs look like collectible energy pickups with hot centers, halos, pulsing rings, and spark glints.
6. Let enemies build up and confirm the screen stays readable.
7. Watch enemy hits and deaths for white flashes, spark sprays, line fragments, and short glow rings.
8. Trigger Nova and confirm it has a stronger plasma shockwave and spark burst.
9. Confirm Pulse Blaster shots and impacts feel like laser energy.
10. Confirm HUD and level-up UI read as neon arcade UI without becoming flat boxes.
11. Press Start/P/Esc and confirm true pause freezes enemies, spawns, timers, weapons, and damage.
12. Use controller left stick/D-pad and A button on level-up choices.
13. Confirm performance remains smooth as enemy, XP, projectile, and VFX counts rise.

## 15. Known Issues

- Headless Godot cannot judge the subjective gas-light/plasma feel because it does not provide a live visual review.
- Engine-level bloom is still not the primary solution; glow is simulated with layered draw calls and capped line/VFX nodes.
- The pass intentionally keeps gameplay content unchanged, so any desired content additions remain future work.
- Under swarm load, decorative spark/trail density is reduced to protect performance.
- Final approval depends on manual testing against the locked Geometry Wars-style neon energy target.

## 16. Approval Question

Does Repair Pass 3 now meet the required gas-light/plasma neon arcade direction closely enough to continue Phase 2, or should another visual repair pass focus on a narrower target area such as player, enemies, XP, VFX, arena, or HUD?
