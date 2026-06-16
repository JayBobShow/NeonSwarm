# Neon Swarm Phase 1 Prototype Report

## 1. Executive Summary

Neon Swarm is a new Godot 4.6.3 arena survival auto-shooter prototype inspired by Brotato and Vampire Survivors, with Geometry Wars-style procedural neon visuals. Phase 1 uses simple geometric entities, real collision shapes, auto-firing weapons, enemy spawning, XP pickup, level-up choices, survival scoring, and particle-based visual feedback.

No Moonbane, NES_Rebuild_Project, hand-drawn sprite sheets, reused assets, AI-generated character frames, or painted character art are used. All visuals are generated with Godot primitives, particles, lines, and code-driven shapes.

## 2. Controls

- WASD or arrow keys: move
- Left controller stick: move
- Mouse: select level-up upgrades
- Keyboard/controller UI accept can activate focused upgrade buttons

## 3. Gameplay Systems Implemented

- One large neon grid arena
- One geometric player combat core
- Real player collision body
- Real enemy, projectile, orbital, nova, and XP pickup collision shapes
- Survival timer
- Score counter
- Kill counter
- Health and XP gauges
- Enemy spawn escalation over time
- XP orbs that magnetize inside the player pickup radius
- Level-up pause flow with three upgrade choices

## 4. Weapons Implemented

- Pulse Blaster: automatically targets the nearest enemy and fires collision-backed projectiles.
- Orbit Spark: rotating collision-backed orbitals that damage enemies on contact.
- Nova Burst: timed radial collision-backed pulse that damages enemies inside the burst radius.

## 5. Enemies Implemented

- Chaser: fast triangular enemy that moves directly toward the player.
- Tank: slower hexagonal enemy with higher health and contact damage.
- Shooter: diamond enemy that keeps range and fires collision-backed projectiles.
- Exploder: fast pentagonal enemy that detonates through a real radial hitbox on contact or death.

## 6. Upgrade System

Ten upgrades are implemented:

- Amplified Core: increases damage
- Rapid Capacitor: increases fire rate
- Vector Boots: increases speed
- Split Pulse: adds Pulse Blaster projectile count
- Magnet Grid: increases pickup radius
- Twin Orbit: adds Orbit Spark orbital count
- Nova Battery: reduces Nova Burst cooldown
- Dense Core: increases max health and heals
- Hot Orbit: increases Orbit Spark damage
- Piercing Beam: adds Pulse Blaster pierce

Level-up pauses the game and presents three random upgrade choices.

## 7. Particle/VFX Systems

- Enemy death particle explosions
- Projectile impact sparks
- Nova Burst ring and particle burst
- Procedural glow layers drawn behind player, enemies, XP, and projectiles
- No gameplay logic depends on particles

## 8. Files Created

- `project.godot`
- `scenes/Main.tscn`
- `scenes/Player.tscn`
- `scenes/Enemy.tscn`
- `scenes/XPOrb.tscn`
- `scripts/Main.gd`
- `scripts/Player.gd`
- `scripts/Enemy.gd`
- `scripts/XPOrb.gd`
- `scripts/WeaponController.gd`
- `scripts/Projectile.gd`
- `scripts/EnemySpawner.gd`
- `scripts/UpgradeSystem.gd`
- `scripts/ParticleFX.gd`
- `scripts/HUD.gd`
- `docs/NEON_SWARM_PHASE_1_PROTOTYPE_REPORT.md`

## 9. How To Run

Open this folder in Godot 4.6.3 and run the main scene.

Command line:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm
```

## 10. Known Issues

- There is no restart flow after player death.
- Upgrade choice UI is intentionally minimal.
- No mouse/right-stick aiming mode is implemented because Phase 1 uses nearest-enemy auto-targeting.

## 11. Next Recommended Step

Tune enemy spawn curves and weapon upgrade balance using short two-to-five-minute survival test runs.
