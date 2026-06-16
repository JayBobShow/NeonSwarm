# Neon Swarm Real 3D Gameplay Review Build Report

## 1. What Scene I Should Run

Run the playable 3D-on-2D gameplay review scene:

```text
scenes/NeonSwarm3DGameplayPrototype.tscn
```

This is a playable review build, not a proof board. It does not replace `scenes/Main.tscn` and does not delete or migrate the 2D version.

## 2. Exact Terminal Command To Run It

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/NeonSwarm3DGameplayPrototype.tscn
```

## 3. Controls

Keyboard:

- WASD / arrow keys: move
- P / Esc: pause and resume
- Right-stick equivalent keyboard aim keys from the existing input map: I/J/K/L

Controller:

- Left stick: move
- D-pad: move
- Right stick: optional aim direction for auto-fire
- Start: pause and resume

No mouse is required for normal play.

## 4. What Real 3D Assets Are In Gameplay

The playable scene uses actual 3D visual scene instances during gameplay:

- `scenes/visuals/Player3D.tscn`
- `scenes/visuals/Chaser3D.tscn`
- `scenes/visuals/Tank3D.tscn`
- `scenes/visuals/Shooter3D.tscn`
- `scenes/visuals/Exploder3D.tscn`
- `scenes/visuals/XPOrb3D.tscn`
- `scenes/visuals/Projectile3D.tscn`

Gameplay entities also use `Area3D` nodes with real `CollisionShape3D` sphere shapes. Gameplay remains locked to the X/Z plane.

The arena is a 3D neon grid floor with tube-geometry border and bloom/glow environment settings.

## 5. What Gameplay Loop Is Implemented

Implemented loop:

- player movement on X/Z plane
- enemy spawning
- chaser/tank/shooter/exploder enemies in actual gameplay
- enemy chase/contact attacks
- shooter enemy projectiles
- exploder proximity detonation
- Pulse Blaster-style auto-fire
- optional right-stick aim override
- projectile damage
- enemy death
- XP drops
- XP attraction and collection
- level count / XP threshold
- survival timer
- kills
- score
- health
- pause overlay
- game-over overlay

No bosses, new weapons, meta progression, campaign, or main-game migration were added.

## 6. Performance / Stress Result

Validation commands run:

```bash
godot --headless --path . scenes/NeonSwarm3DGameplayPrototype.tscn --quit-after 3
godot --headless --path . scenes/NeonSwarm3DGameplayPrototype.tscn --quit-after 3000
godot --headless --path . --script /tmp/neon_swarm_real_3d_gameplay_smoke.gd
godot --headless --path . --script /tmp/neon_swarm_real_3d_gameplay_stress.gd
godot --headless --path . --quit-after 3
```

Headless gameplay run result:

```text
Real 3D gameplay review summary: time=12.0 enemies=10/54 xp=8/100 player_projectiles=0/36 enemy_projectiles=0/28 bursts=1/18 kills=12 score=460
```

Input/pause smoke result:

```text
Real 3D gameplay smoke passed: input actions present, Start pause mapped, true pause freezes survival timer.
```

Stress initial load:

```text
enemies=54/54 xp=100/100 player_projectiles=36/36 enemy_projectiles=28/28 bursts=18/18
```

Stress after 180 simulated frames:

```text
enemies=53/54 xp=100/100 player_projectiles=2/36 enemy_projectiles=9/28 bursts=2/18 kills=1 score=35 avg_headless_frame_ms=6.859
```

Performance guardrails in the scene:

- enemy cap: 54
- XP cap: 100
- player projectile cap: 36
- enemy projectile cap: 28
- burst/VFX cap: 18
- no unbounded projectile, XP, enemy, or burst spawning
- pause freezes gameplay timer and gameplay updates

## 7. Known Issues

- This is a review build, not a full migration.
- The 3D visuals are still procedural Godot visual scenes, not Blender-authored mesh assets.
- Enemy/projectile balance is rough and tuned only enough to make the loop playable.
- The player can die unattended in headless runs because no movement input is provided.
- There is no level-up choice menu in this review scene.
- The current 3D assets are intentionally separate definitions, but they still need manual visual approval in real play.

## 8. Approval Question

After playing `scenes/NeonSwarm3DGameplayPrototype.tscn`, is this real 3D-on-2D gameplay direction worth continuing, or should the project stay with the 2D version / revise the 3D asset direction before any migration?
