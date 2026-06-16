# Neon Swarm Phase 4 Gameplay Expansion Foundation Report

## 1. Executive Summary

Phase 4 expanded the official `scenes/Main.tscn` build into the beginning of the real game while preserving the approved direction:

TRUE 3D-ON-2D NEON SWARM GAMEPLAY.

Implemented in this pass:

- Controlled 10% asset-local glow/emission boost.
- Full game roadmap.
- Weapon framework.
- Two new weapons: Arc Beam and Gravity Mine.
- Existing weapon set represented: Pulse Blaster, Orbit Spark, Nova Burst.
- Expanded level-up upgrade pool and three-choice controller UI.
- Basic enemy wave director.
- One mini-boss prototype: Prism Warden.
- Major boss plan documented only.
- Performance caps and smoke/stress validation.

No bosses beyond the one mini-boss prototype, no new regular enemy types, no new campaign, no meta progression, and no main-game migration away from `scenes/Main.tscn`.

## 2. 10% Glow Tuning Results

File changed:

- `scripts/visuals/Neon3DVisualKit.gd`

Exact value changed:

- Before: `LOCAL_ASSET_GLOW_TUNE := 1.005`
- After: `LOCAL_ASSET_GLOW_TUNE := 1.1055`

This is a 10% increase over the prior local asset glow multiplier. It affects material emission and shader emission generated through the shared 3D visual kit.

Global bloom/environment values were not increased. The intent was stronger asset visibility without returning to blurry full-screen overglow.

Readability result:

- Headless validation cannot visually judge blur, but no rendering/runtime errors occurred.
- Because the boost is local/material-side and global bloom was untouched, the change is controlled and should preserve the readable 3D forms from Phase 3 Repair 2.
- Manual visual review is still required.

## 3. Roadmap Created

Created:

- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`

The roadmap defines:

- Core game vision
- Official visual direction
- Controls
- Player stats
- Weapon system
- Upgrade system
- Enemy families
- Mini-boss plan
- Major boss plan
- Level/wave structure
- Shape family usage from the geometry bible
- XP/progression loop
- Performance guardrails
- Save/meta progression plan for later
- Phase-by-phase development plan

## 4. Weapons Added

Weapon framework added inside the official gameplay script:

- `pulse_blaster`
- `orbit_spark`
- `nova_burst`
- `arc_beam`
- `gravity_mine`

Existing/retained weapon behavior:

- Pulse Blaster: auto-targeted projectile fire.
- Orbit Spark: rotating damage orbitals around the player.
- Nova Burst: timed radial damage pulse with expanding torus effect.

New Phase 4 weapons:

- Arc Beam: short electric chain beam that hits up to three nearby enemies.
- Gravity Mine: placed torus/sphere mine that pulls enemies briefly and pops for damage.

Performance controls:

- Player projectile cap: `36`
- Beam effect cap: `8`
- Mine cap: `6`
- Burst cap: `18`

## 5. Upgrades Added

Added a three-choice level-up system that pauses gameplay and supports controller/keyboard confirm/selection.

Upgrade categories:

- Damage
- Fire rate
- Projectile count
- Pickup range
- Movement speed
- Max health
- Orbit count
- Nova cooldown
- Beam duration
- Mine radius

Level-up behavior:

- XP collection can trigger level-up.
- Gameplay pauses with `get_tree().paused = true`.
- Level-up overlay remains interactive while paused.
- A / Enter / Space confirms.
- D-pad / left-right movement changes selection.
- Confirming an upgrade applies the stat and resumes unless manual pause is active.

## 6. Wave Director Changes

Replaced the simple spawn timer with a basic wave director:

- `IGNITION`: early chasers and light tank presence.
- `PRESSURE`: tanks and shooters enter.
- `DANGER`: exploders enter the mix.
- `OVERLOAD`: mixed swarm pressure.

Enemy cap remains performance-safe:

- Enemy cap: `54`

Mini-boss scheduling:

- Prism Warden mini-boss is scheduled once at `70.0` seconds.

## 7. Mini-Boss Prototype

Implemented one mini-boss prototype:

- Name: Prism Warden
- Primary shape: Octahedron
- Secondary shape: Torus / annulus reactor rings
- Gameplay role: slow pressure unit with radial projectile bursts
- Visual role: large true 3D geometric neon threat
- Health: `720`
- Score value: `900`
- Bonus XP drop: `18` plus extra small XP drops
- Health bar: shown in HUD while active

Files:

- `scenes/visuals/MiniBoss3D.tscn`
- `scripts/visuals/MiniBoss3D.gd`

## 8. Major Boss Plan

No full major boss was implemented.

Major boss plan is documented in `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`:

- Name: Dodeca Core
- Primary shape: Dodecahedron
- Secondary shapes: torus rings, radial emitters, orbiting pentagonal prisms
- Concept: phase-based arena control boss
- Performance concern: shared meshes/materials, capped VFX, no uncontrolled child-node growth

## 9. Geometry Shape Bible Compliance

Reference used:

- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`

Shape identities:

- Player: octahedron / diamond core with torus shield rings
- Chaser: tetrahedron / triangular pyramid
- Tank: cube / cuboid
- Shooter: hexagonal prism / diamond family
- Exploder: sphere / torus / annulus
- XP: sphere plus torus/annulus rings
- Pulse Blaster: cylinder/capsule energy bolt
- Orbit Spark: sphere plus annulus path
- Nova Burst: torus / annulus
- Arc Beam: cylinder/tube energy segment
- Gravity Mine: torus plus sphere core
- Mini-boss Prism Warden: octahedron plus torus rings
- Major boss Dodeca Core: dodecahedron plan only

No random shape additions were made.

## 10. Controller / Pause Regression

Phase 4 smoke validation confirmed:

- Keyboard movement mappings exist.
- Controller left stick mappings exist.
- D-pad mappings exist.
- A confirm mapping exists.
- Start / P / Esc pause mappings exist.
- Manual pause freezes survival time.
- Manual pause freezes enemies.
- Player does not take damage while paused.
- Pause resumes correctly.
- Level-up pause activates and resumes after confirm.

Headless smoke cannot physically test controller feel, so final controller feel still requires manual hardware testing.

## 11. Performance Results

Required launch checks:

- `godot --headless --path . --quit-after 3`
  - Passed.

- `godot --headless --path . --quit-after 3000`
  - Passed.
  - Summary: `time=12.0`, `wave=IGNITION`, `enemies=6/54`, `xp=14/100`, `player_projectiles=1/36`, `enemy_projectiles=0/28`, `mines=1/6`, `beams=1/8`, `bursts=2/18`, `kills=16`, `score=610`, `mini_boss_active=false`.

- `godot --headless --path . scenes/Main.tscn --quit-after 3`
  - Passed.

Phase 4 smoke:

- `godot --headless --path . --script /tmp/neon_swarm_phase4_smoke.gd`
  - Passed.
  - Confirmed controller map, pause, XP level-up, weapon framework, and mini-boss.
  - Output included: `projectiles=3`, `beams=1`, `mines=1`, `level=2`, `score=915`.

Phase 4 stress:

- `godot --headless --path . --script /tmp/neon_swarm_phase4_stress.gd`
  - Passed.
  - `avg_headless_frame_ms=6.827`
  - `nodes=2270`
  - `enemies=54/54`
  - `xp=87/100`
  - `player_projectiles=11/36`
  - `enemy_projectiles=28/28`
  - `mines=6/6`
  - `beams=0/8`
  - `bursts=18/18`
  - `miniboss=true`

No runaway nodes, VFX, projectiles, beams, mines, or bursts were detected in the stress test.

## 12. Files Changed

Changed:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/visuals/Neon3DVisualKit.gd`

Created:

- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PHASE_4_GAMEPLAY_EXPANSION_FOUNDATION_REPORT.md`
- `scenes/visuals/MiniBoss3D.tscn`
- `scripts/visuals/MiniBoss3D.gd`

Official scene remains:

- `scenes/Main.tscn`

## 13. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

F5 in Godot also launches `res://scenes/Main.tscn`.

## 14. What The User Should Test

Manual test checklist:

- Confirm the official HUD label still appears.
- Confirm the 10% glow boost improves visibility without blurring shapes.
- Move with keyboard.
- Move with controller.
- Pause with Start / P / Esc and confirm gameplay freezes.
- Kill enemies with Pulse Blaster.
- Watch Orbit Spark damage enemies near the player.
- Watch Nova Burst fire periodically.
- Watch Arc Beam chain to nearby enemies.
- Watch Gravity Mine pull enemies and pop.
- Collect XP and trigger the level-up choice screen.
- Navigate level-up choices with D-pad/left stick.
- Confirm an upgrade with A.
- Survive long enough to see the Prism Warden mini-boss, or use future debug tooling if needed.
- Confirm mini-boss health bar appears.
- Watch for performance drops or readability loss under high enemy count.

## 15. Known Issues

- The active gameplay script still uses the historical filename `NeonSwarm3DGameplayPrototype.gd`, though it now powers the official `Main.tscn` game build.
- Mini-boss appears at 70 seconds in normal play; manual review may take time unless a debug shortcut is later approved.
- Arc Beam chain targeting is intentionally simple for Phase 4.
- Gravity Mine uses capped node-based visuals and distance checks; future work can pool mine nodes if needed.
- The major boss is planned only, not implemented.
- Manual controller hardware feel still needs user testing.
- Visual approval is not claimed; the user must judge the 10% glow increase in the running build.

## 16. Approval Question

After playing `scenes/Main.tscn`, is Phase 4 approved as the gameplay expansion foundation, or should specific weapons, upgrades, mini-boss behavior, glow intensity, or performance caps be revised before Phase 5?
