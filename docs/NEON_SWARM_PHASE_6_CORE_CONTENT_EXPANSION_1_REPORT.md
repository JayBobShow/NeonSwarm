# Neon Swarm Phase 6 Core Content Expansion 1 Report

## 1. Executive Summary

Phase 6 expands the official playable build carefully after the Phase 5 Repair 1 visual style approval.

Official scene remains:

`scenes/Main.tscn`

This pass adds two regular enemies, two weapons, upgrade hooks, wave pacing improvements, mini-boss warning/reward polish, and a basic run success state. It does not create alternate scenes, add bosses beyond Prism Warden, add meta progression, add a shop, add save systems, or change the approved neon tube edge style.

## 2. Visual Style Lock Confirmation

Created:

`docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`

Updated:

- `docs/NEON_SWARM_PHASE_5_REPAIR_1_NEON_TUBE_EDGE_MATERIAL_REPORT.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`

Phase 5 Repair 1 is now recorded as the official visual baseline:

- True 3D-on-2D gameplay.
- Dark 3D body faces.
- Bright neon tube edges.
- Local edge glow, not blurry global bloom.
- `scenes/Main.tscn` is the official playable scene.

## 3. New Enemies

Spiral Drifter:

- Primary shape: Helix.
- Secondary shape: spheroid core and annulus stabilizer rings.
- Gameplay role: weaving pursuit enemy that drifts laterally while moving toward the player.
- Visual style: dark body core plus bright cyan/violet double-helix neon tube edges.
- Performance: one separate visual scene with batched spark points; no unbounded VFX.

Shield Node:

- Primary shape: Annulus / torus.
- Secondary shape: spheroid core and radial spoke tubes.
- Gameplay role: slower shielded enemy; first damage layer breaks its shield before health damage applies.
- Visual style: dark core, bright blue/cyan annulus tubes, white-hot ring core accents.
- Performance: one separate visual scene; shield behavior uses existing enemy dictionary state.

## 4. New Weapons

Prism Lance:

- Primary shape: triangular prism / lance tube.
- Behavior: auto-fires a piercing neon lance at the current aim direction or nearest enemy.
- Visual style: violet neon tube with white-hot core and a stabilizer annulus.
- Performance: uses existing player projectile cap.
- Upgrade hooks: damage multiplier and pierce count.

Ring Saw:

- Primary shape: torus / annulus.
- Behavior: persistent rotating ring around the player that damages enemies near its radius.
- Visual style: cyan/white torus light-pipe with violet cutter offset.
- Performance: persistent visual node, timed damage tick, no projectile spam.
- Upgrade hooks: radius and spin speed.

Existing weapons remain:

- Pulse Blaster
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine

## 5. Upgrade Additions

Added upgrades:

- `Lance Refraction`: Prism Lance damage.
- `Lance Aperture`: Prism Lance pierce count.
- `Saw Annulus`: Ring Saw radius.
- `Saw Gyro`: Ring Saw spin speed.
- `Magnet Helix`: XP magnet pull strength.
- `Vital Cuboid`: max health and heal.
- `Reward Sieve`: regular enemy XP reward bonus.
- `Warden Cache`: mini-boss reward bonus.

All upgrades include shape identities in the upgrade pool.

## 6. Wave Director Changes

Wave pacing now supports:

- Early wave: initial chasers, tanks, and small Spiral Drifter introduction.
- Pressure wave: tanks, shooters, Spiral Drifters, and chasers.
- XP recovery wave: lighter pressure with more manageable spawn pacing.
- Mini-boss warning: `WARNING: PRISM WARDEN INBOUND` appears in the boss HUD area.
- Mini-boss wave: Prism Warden active with controlled support spawns.
- Reward flow: post-mini-boss state label after the boss is no longer active.

Enemy cap remains `54`.

## 7. Mini-Boss Changes

Prism Warden remains the only mini-boss.

Changes:

- Spawn timing adjusted to `90s`.
- Warning begins at `75s`.
- Defeating Prism Warden triggers `SECTOR CLEARED`.
- Mini-boss reward drops scale with the new `Warden Cache` upgrade.
- No second mini-boss was added.

## 8. Run Goal / Success Condition

Added a simple prototype run goal:

- Survive `5:00`, or
- Defeat Prism Warden.

On success:

- Shows `SECTOR CLEARED`.
- Pauses gameplay.
- A / Start / Enter / Space restart the run.
- Restart reloads the official scene and resets run state.

## 9. Geometry Shape Bible Compliance

New Phase 6 elements:

- Spiral Drifter: Helix, spheroid, annulus.
- Shield Node: annulus / torus, spheroid, radial spoke tubes.
- Prism Lance: triangular prism / cylinder-like neon lance tube.
- Ring Saw: torus / annulus.
- Magnet Helix upgrade: helix.
- Reward Sieve upgrade: pentagonal prism.
- Warden Cache upgrade: dodecahedron.

All new enemies and weapons keep gameplay collision separate from VFX and use the approved dark-face / bright-neon-edge style.

## 10. Controller/Pause/Restart Results

Passed:

- Controller map smoke.
- Keyboard input mapping smoke.
- True pause smoke.
- Level-up pause/confirm smoke.
- Death/restart smoke.
- Success/restart smoke.

Restart behavior resets the run after both death and success.

## 11. Performance Results

Standard 3000-frame run:

- Time: `12.0`
- Wave: `IGNITION`
- Enemies: `4/54`
- XP: `14/100`
- Player projectiles: `3/36`
- Enemy projectiles: `0/28`
- Mines: `1/6`
- Beams: `1/8`
- Bursts: `3/18`
- Kills: `18`
- Score: `730`

Existing stress test:

- Average headless frame time: `6.827 ms`
- Nodes: `2313`
- Enemies: `53/54`
- XP: `90/100`
- Player projectiles: `8/36`
- Enemy projectiles: `28/28`
- Mines: `6/6`
- Bursts: `18/18`
- Mini-boss active: `true`

Phase 6 stress test:

- Average headless frame time: `6.827 ms`
- Nodes: `1730`
- Enemies: `23/54`
- XP: `100/100`
- Player projectiles: `1/36`
- Enemy projectiles: `0/28`
- Mines: `6/6`
- Bursts: `9/18`
- Kills: `32`

Caps remained active.

## 12. Files Changed

Created:

- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_PHASE_6_CORE_CONTENT_EXPANSION_1_REPORT.md`
- `scripts/visuals/SpiralDrifter3D.gd`
- `scripts/visuals/ShieldNode3D.gd`
- `scenes/visuals/SpiralDrifter3D.tscn`
- `scenes/visuals/ShieldNode3D.tscn`

Updated:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_5_REPAIR_1_NEON_TUBE_EDGE_MATERIAL_REPORT.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`

## 13. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 14. What The User Should Test

Manual test targets:

- Confirm the approved dark-face / neon-tube-edge style is preserved.
- Look for Spiral Drifters: cyan/violet helix enemies with drifting movement.
- Look for Shield Nodes: blue annulus enemies that absorb an initial hit layer.
- Verify Prism Lance fires as a piercing violet/white neon lance.
- Verify Ring Saw appears as a rotating torus weapon around the player.
- Play through the warning and Prism Warden spawn around `75s` to `90s`.
- Defeat Prism Warden and verify `SECTOR CLEARED`.
- Survive to `5:00` and verify `SECTOR CLEARED`.
- Restart after death and success with controller and keyboard.
- Confirm the screen remains readable under pressure.

## 15. Known Issues

- `SECTOR CLEARED` is a prototype run-complete state, not a campaign or progression system.
- The official implementation script still has the historical name `NeonSwarm3DGameplayPrototype.gd`.
- The Phase 6 stress test can kill many enemies quickly because all weapons and dense enemies are active together; caps still held.
- No audio, save system, shop, campaign, or meta progression was added.

## 16. Approval Question

Is Phase 6 Core Content Expansion Pass 1 approved as the next playable baseline, or should specific new enemies, weapons, wave pacing, or success flow be tuned before Phase 7?
