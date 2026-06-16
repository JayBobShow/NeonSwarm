# Neon Swarm Phase 4 Repair / Polish Pass - Tokyo Neon Intensity + HUD Redesign Report

## 1. Executive Summary

This pass polished the official playable scene only:

`scenes/Main.tscn`

The pass focused on Tokyo night neon intensity, brighter capped VFX, and a smaller cleaner HUD. No new gameplay content, enemies, weapons, bosses, meta progression, save system, campaign, or scene variants were added.

The official direction remains:

TRUE 3D-ON-2D NEON SWARM GAMEPLAY.

## 2. Neon Intensity Changes

Shared local asset glow was increased in `scripts/visuals/Neon3DVisualKit.gd`:

- `LOCAL_ASSET_GLOW_TUNE`: `1.1055 -> 1.24`

Neon body shader changes:

- `rim_strength`: `1.35 -> 1.50`
- `rim_power`: `2.35 -> 2.25`
- body base visibility increased from `0.34` to `0.38`
- edge emission base increased from `0.42` to `0.48`

Plasma shell shader change:

- plasma floor/fresnel mix changed from `0.06 + fresnel * 0.64` to `0.075 + fresnel * 0.70`

Selected material boosts in `scripts/NeonSwarm3DGameplayPrototype.gd`:

- white-hot material: `4.2 -> 4.8`
- soft white: `1.8 -> 2.2`
- arena border: `1.0 -> 1.25`
- enemy projectile core: `4.9 -> 5.8`
- Arc Beam: `3.8 -> 4.5`
- Arc Beam core: `5.4 -> 6.2`
- Gravity Mine core: `5.0 -> 5.9`
- Orbit Spark: `4.1 -> 4.9`
- Nova: `2.6 -> 3.4`
- burst materials raised from roughly `2.9-3.1` to `3.6-3.8`
- XP trail: `1.5 -> 2.0`

Global bloom was not increased:

- `environment.glow_intensity` remains `0.74`
- `environment.glow_strength` remains `1.02`

## 3. VFX / Explosion Changes

Enemy hit/death bursts were made brighter and more layered while keeping the existing `BURST_CAP`.

Burst changes:

- Added a larger white-hot center pop.
- Added a white-hot snap ring.
- Added a color-matched flash ring.
- Increased spark fragments from `10` to `12`.
- Increased spark capsule size.
- Shortened burst duration from `0.42s` to `0.38s` so the effect hits harder and clears faster.
- Increased burst expansion speed.

Weapon/VFX changes:

- Arc Beam outer tube radius: `0.060 -> 0.075`
- Arc Beam core radius: `0.018 -> 0.024`
- Nova torus tube radius: `0.028 -> 0.038`
- Nova life: `0.42s -> 0.48s`
- Nova expansion scale increased from `NOVA_RADIUS * 1.45` to `NOVA_RADIUS * 1.55`
- XP attraction trail radius increased from `0.014 + strength * 0.012` to `0.017 + strength * 0.017`

No uncapped particle system was added.

## 4. HUD Redesign Changes

The HUD was redesigned from one large vertical block into smaller neon-glass modules:

- Top-left compact core module:
  - official build label
  - level
  - health text/bar
  - XP text/bar

- Top-right compact match module:
  - timer
  - kills
  - score
  - enemy count

- Bottom-left compact weapon/stat module:
  - damage
  - fire rate
  - speed
  - pickup range
  - orbit count
  - nova cooldown
  - beam duration
  - mine radius

- Top-center mini-boss module:
  - hidden until the mini-boss is active
  - smaller boss label and health bar

HUD footprint reductions:

- Health/XP bars: `320x22 -> 236x12`
- Level-up panel: `980x310 -> 860x268`
- Level-up cards: `292x132 -> 252x112`
- Pause panel: `440x145 -> 360x104`
- Default HUD label size: `18 -> 13`
- Official label size: `16 -> 11`

The level-up UI remains controller-friendly and uses a stronger neon focus outline.

## 5. Readability Improvements

Readability was protected by:

- keeping global bloom unchanged
- preserving camera, enemy sizes, collision, and gameplay scale
- increasing local rim/emission instead of full-screen blur
- keeping background/grid lower intensity than gameplay assets
- shortening burst lifetime so VFX clears faster
- compacting HUD modules away from the central playfield
- keeping boss HUD hidden unless needed

Implementation-side readability improved through stronger color separation, clearer neon rims, hotter projectile/VFX cores, and reduced HUD obstruction. Manual visual approval is still required because headless validation cannot judge final visual taste.

## 6. Performance Safeguards

Preserved caps:

- Enemy cap: `54`
- XP cap: `100`
- Player projectile cap: `36`
- Enemy projectile cap: `28`
- Beam effect cap: `8`
- Mine cap: `6`
- Burst cap: `18`

Performance-safe choices:

- no new uncapped particles
- no new scene variants
- no global bloom increase
- no extra enemy/weapon content
- bursts still self-clean
- beam/Nova effects still self-clean
- mines still capped
- XP attraction trails still capped

Stress validation passed after the VFX changes.

## 7. Files Changed

Changed:

- `scripts/visuals/Neon3DVisualKit.gd`
- `scripts/NeonSwarm3DGameplayPrototype.gd`

Created:

- `docs/NEON_SWARM_PHASE_4_REPAIR_TOKYO_NEON_UI_POLISH_REPORT.md`

Official scene remains:

- `scenes/Main.tscn`

## 8. Validation Results

Required launch validation:

- `godot --headless --path . --quit-after 3`
  - Passed.

- `godot --headless --path . --quit-after 3000`
  - Passed.
  - Summary included: `time=12.0`, `wave=IGNITION`, `enemies=6/54`, `xp=12/100`, `player_projectiles=1/36`, `enemy_projectiles=0/28`, `mines=1/6`, `beams=1/8`, `bursts=2/18`, `kills=16`, `score=630`.

- `godot --headless --path . scenes/Main.tscn --quit-after 3`
  - Passed.

Controller / true pause / XP / weapon smoke:

- `godot --headless --path . --script /tmp/neon_swarm_phase4_smoke.gd`
  - Passed.
  - Confirmed controller mappings.
  - Confirmed true pause.
  - Confirmed XP collection and level-up.
  - Confirmed weapon framework.
  - Confirmed mini-boss activation/death.

Gameplay stress:

- `godot --headless --path . --script /tmp/neon_swarm_phase4_stress.gd`
  - Passed.
  - `avg_headless_frame_ms=6.827`
  - `nodes=2344`
  - `enemies=53/54`
  - `xp=90/100`
  - `player_projectiles=11/36`
  - `enemy_projectiles=28/28`
  - `mines=6/6`
  - `beams=0/8`
  - `bursts=18/18`
  - `miniboss=true`

Explicit status:

- Gameplay readability was protected by local glow increases, preserved shape scale, and no global bloom increase.
- HUD footprint was reduced materially.
- Performance stayed within guardrails in the stress test.

## 9. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

F5 also launches `res://scenes/Main.tscn`.

## 10. What The User Should Test

Manual test checklist:

- Confirm the game still launches the official `scenes/Main.tscn`.
- Confirm the new HUD is smaller and less intrusive.
- Confirm health/XP/timer/kills/score/enemy count are still readable.
- Confirm level-up choices are cleaner and still controller navigable.
- Confirm player/enemy/projectile/XP silhouettes remain readable.
- Confirm the neon intensity is noticeably stronger.
- Confirm explosions and hit/death effects feel brighter and more satisfying.
- Confirm Nova, Arc Beam, Gravity Mine, and XP collection effects are more energetic.
- Confirm no return to blurry glow blobs.
- Confirm controller movement, pause, and upgrade confirm still work.
- Confirm performance under heavy swarms feels acceptable.

## 11. Known Issues

- Headless validation cannot prove subjective visual quality; manual play review is still required.
- The active gameplay script still carries its historical prototype filename, but it powers the official `scenes/Main.tscn`.
- The mini-boss appears at its scheduled time in normal play; debug spawning was not added in this polish pass.
- HUD layout should be checked on the user’s actual display resolution for final spacing approval.

## 12. Approval Question

After playing `scenes/Main.tscn`, is this Tokyo neon intensity and HUD redesign pass approved, or should specific assets, VFX, or HUD modules be tuned before any Phase 5 work?
