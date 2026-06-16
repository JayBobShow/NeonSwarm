# Neon Swarm Phase 3 Repair 1 Sharp 3D Form / Controlled Glow Report

## 1. Executive Summary

Phase 3 Repair 1 keeps the playable true 3D-on-2D gameplay prototype and repairs the visual readability problem.

The repair target was:

- readable 3D shape first
- neon edge/emission second
- soft glow/bloom third

No main-game migration was performed. No bosses, weapons, enemy types, meta progression, or campaign content were added.

## 2. Correct Scene Reviewed

Correct scene:

```text
scenes/NeonSwarm3DGameplayPrototype.tscn
```

Exact run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/NeonSwarm3DGameplayPrototype.tscn
```

## 3. Why The Previous Visual Was Rejected

The gameplay direction was more correct than previous proof boards, but the visual balance was wrong.

Rejected issues:

- bloom/glow was too strong
- transparent additive shells were hiding the 3D forms
- white-hot cores and emission values were too high
- objects read as blurry glowing blobs instead of geometric assets
- XP and projectiles smeared too much
- arena/grid/border glow added extra wash

## 4. Bloom/Glow Changes

Gameplay environment glow was reduced:

- glow intensity reduced from `1.55` to `0.58`
- glow strength reduced from `1.95` to `0.86`
- glow bloom reduced from `0.42` to `0.12`
- HDR glow threshold raised from `0.10` to `0.34`
- tonemap exposure reduced from `1.10` to `0.96`

Shared material behavior changed:

- transparent emissive materials no longer disable depth testing
- plasma shell shader changed from additive double-sided haze to controlled mixed transparency
- plasma shell rim intensity lowered
- new opaque neon body material added for readable 3D forms

## 5. Shape Readability Changes

The shared 3D visual kit now supports opaque neon body material so each object can show actual geometry before glow.

Objects were tuned toward:

- smaller white-hot cores
- lower emission multipliers
- weaker outer haze
- fewer large transparent shells
- thinner edge tubes where bloom was hiding shape
- fewer or smaller trails/sparks where they blurred silhouettes

## 6. Player Changes

Player3D changes:

- added opaque readable octahedron body material
- reduced white-hot core size and intensity
- reduced cyan/magenta shell opacity and energy
- reduced torus thickness and emission
- reduced trail count from 5 to 3
- reduced spark count from 18 to 12

Goal: player remains dominant but no longer becomes a blown-out blob.

## 7. Enemy Changes

Chaser3D:

- added opaque tetrahedron body
- reduced green shell opacity and trail count
- reduced nose core size
- reduced spark count

Tank3D:

- added opaque cuboid body
- reduced rectangular haze shell size and opacity
- reduced corner tube thickness
- reduced internal crossbar glow
- reduced pylon/core sizes

Shooter3D:

- added opaque hexagonal prism body
- reduced muzzle shell size and glow
- reduced aim spine thickness
- reduced spark count

Exploder3D:

- added opaque red sphere body
- reduced warning ring thickness and emission
- reduced core size
- reduced spark count
- reduced plasma shell opacity

## 8. XP/Projectile Changes

XPOrb3D:

- added readable opaque gold energy body
- reduced yellow halo opacity and emission
- reduced white reward core size
- reduced ring thickness
- reduced spark count

Projectile3D:

- reduced bolt haze opacity and size
- reduced white-hot core intensity
- reduced trail count from 4 to 2
- reduced trail thickness
- reduced projectile capsule sizes

Enemy projectiles and impact bursts:

- reduced enemy projectile body/core sizes
- lowered enemy projectile emission
- reduced impact pop size
- reduced burst ring glow
- reduced spark fragment size

## 9. Arena/Grid Changes

Arena changes:

- grid minor/major/axis materials dimmed
- arena border emission reduced
- arena border tube radius reduced
- white-hot border core reduced

The grid remains visible as the 2D gameplay plane but should stay behind player/enemies/projectiles.

## 10. Performance Results

Validation commands run:

```bash
godot --headless --path . scenes/NeonSwarm3DGameplayPrototype.tscn --quit-after 3
godot --headless --path . scenes/NeonSwarm3DGameplayPrototype.tscn --quit-after 3000
godot --headless --path . --script /tmp/neon_swarm_real_3d_gameplay_smoke.gd
godot --headless --path . --script /tmp/neon_swarm_real_3d_gameplay_stress.gd
godot --headless --path . --quit-after 3
```

Standalone visual scenes also launched successfully:

- Player3D
- Chaser3D
- Tank3D
- Shooter3D
- Exploder3D
- XPOrb3D
- Projectile3D

Long gameplay run result:

```text
Real 3D gameplay review summary: time=12.0 enemies=10/54 xp=6/100 player_projectiles=0/36 enemy_projectiles=0/28 bursts=1/18 kills=12 score=480
```

Pause/controller smoke:

```text
Real 3D gameplay smoke passed: input actions present, Start pause mapped, true pause freezes survival timer.
```

Stress initial load:

```text
enemies=54/54 xp=100/100 player_projectiles=36/36 enemy_projectiles=28/28 bursts=18/18
```

Stress result after simulation:

```text
enemies=52/54 xp=100/100 player_projectiles=1/36 enemy_projectiles=14/28 bursts=4/18 kills=2 score=70 avg_headless_frame_ms=6.859
```

Performance guardrails preserved:

- enemy cap: 54
- XP cap: 100
- player projectile cap: 36
- enemy projectile cap: 28
- burst cap: 18
- pooled/small spark batches remain capped

## 11. Files Changed

- `scripts/visuals/Neon3DVisualKit.gd`
- `scripts/visuals/Player3D.gd`
- `scripts/visuals/Chaser3D.gd`
- `scripts/visuals/Tank3D.gd`
- `scripts/visuals/Shooter3D.gd`
- `scripts/visuals/Exploder3D.gd`
- `scripts/visuals/XPOrb3D.gd`
- `scripts/visuals/Projectile3D.gd`
- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_3_REPAIR_1_SHARP_3D_FORM_CONTROLLED_GLOW_REPORT.md`

## 12. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/NeonSwarm3DGameplayPrototype.tscn
```

Manual test checklist:

1. Can you instantly identify the player?
2. Can you identify the chaser as triangular/pyramid-like?
3. Can you identify the tank as cuboid/block-like?
4. Can you identify the shooter as a distinct ranged geometric enemy?
5. Can you identify the exploder as a sphere/torus/unstable orb?
6. Can you identify XP pickups as small 3D energy objects?
7. Can you identify projectiles as energy bolts?
8. Does bloom support the forms instead of hiding them?

## 13. Known Issues

- This is still a review prototype, not full migration.
- Visual approval is not claimed.
- The assets are still procedural Godot 3D visual definitions, not Blender-authored meshes.
- Balance remains rough.
- There is still no level-up choice UI in the 3D gameplay scene.
- Manual play is required to judge whether the new glow balance is sharp enough.

## 14. Approval Question

After launching `scenes/NeonSwarm3DGameplayPrototype.tscn`, are the 3D forms now readable enough to continue the true 3D-on-2D direction, or should any specific object still be rejected for blur/shape unreadability?
