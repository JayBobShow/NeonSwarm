# Neon Swarm Phase 5 Repair 1 Neon Tube Edge Material Report

## 1. Executive Summary

Phase 5 Repair 1 is approved as the official Neon Swarm visual baseline.

Phase 5 Repair 1 applied the clarified neon art direction to the official playable scene only:

`scenes/Main.tscn`

The pass shifts gameplay assets away from “colored body plus glow aura” and toward “dark readable 3D body with hot neon tube edges.” No gameplay, weapons, enemies, bosses, scene paths, or progression systems were changed.

## 2. User Visual Clarification

The clarified target is:

- Real 3D bodies.
- Darker readable face/facet materials.
- Much brighter neon tube edges.
- White-hot corner/core accents.
- Controlled local glow around the tubes.
- No blurry bloom blob return.
- No flat wireframe icon look.

## 3. Neon Tube Edge Approach

The project already had real tube geometry through `Kit.add_glowing_edges()`. This pass made that structure the visual priority:

- Body shader emission was reduced so faces read darker.
- Plasma haze was reduced so it supports, rather than hides, shape edges.
- Edge tube radii were increased on player, enemies, mini-boss, arena border, beams, mines, nova, orbitals, XP rings, and burst rings.
- Edge and core materials were made brighter than body materials.
- Global bloom was not increased.

Global environment glow stayed controlled:

- `glow_intensity = 0.74`
- `glow_strength = 1.02`
- `glow_bloom = 0.16`

## 4. Face Material Changes

Shared body material changes in `scripts/visuals/Neon3DVisualKit.gd`:

- Added `BODY_FACE_EMISSION_BIAS = 0.68`
- Body base contribution changed from `0.40 + rim * 0.28` to `0.18 + rim * 0.12`
- Body emission contribution changed from `0.54 + rim * rim_strength` to `0.12 + rim * rim_strength`
- Plasma haze emission now uses `PLASMA_HAZE_EMISSION_BIAS = 0.84`
- Plasma shell intensity changed from `0.085 + fresnel * 0.76` to `0.052 + fresnel * 0.64`

Result: faces remain visible and 3D, but they no longer compete with the neon edge tubes.

## 5. Edge/Vertex Glow Changes

The edge layer was strengthened through existing 3D tube geometry:

- Player octahedron edge tubes increased from `0.104 / 0.025` to `0.132 / 0.034`.
- Chaser tetrahedron edge tubes increased from `0.086 / 0.021` to `0.108 / 0.028`.
- Tank cube/cuboid corner tubes increased from `0.100 / 0.024` to `0.122 / 0.032`.
- Shooter hex-prism edge tubes increased from `0.078 / 0.020` to `0.100 / 0.027`.
- Exploder warning spike tubes increased from `0.046 / 0.014` to `0.058 / 0.020`.
- Prism Warden octahedron tubes increased from `0.112 / 0.027` to `0.148 / 0.040`.
- Arena border tubes increased from `0.096 / 0.026` to `0.116 / 0.034`.

White-hot accent materials were also raised on player, enemy cores, projectile cores, and mini-boss vertex beacons.

## 6. Player Changes

The player now has the strongest edge-tube priority:

- Darker cyan/magenta body faces.
- Brighter cyan and magenta tube materials.
- Thicker octahedron neon edge tubes.
- Stronger white-hot reactor core.
- Thicker rotating torus light-pipe rings.
- Haze toned down so the player reads as a 3D neon object, not a glow blob.

## 7. Enemy Changes

Chaser:

- Darker tetrahedron body.
- Brighter green neon tubes.
- Thicker white-hot core edge lines.
- Sharper white-hot nose accent.

Tank:

- Darker amber cuboid body.
- Brighter gold/orange corner tubes.
- White-hot corner/pylon accents strengthened.
- Internal cross remains modest to avoid swarm clutter.

Shooter:

- Darker violet hex-prism body.
- Brighter violet edge tubes.
- Stronger white-hot aim spine.
- Thicker cyan muzzle ring.

Exploder:

- Darker red spherical body.
- Stronger red/orange warning torus tubes.
- Thicker radial warning spikes.
- Plasma shell reduced so the danger rings read clearly.

## 8. XP/Projectile Changes

XP orb:

- Darker gold core body.
- Brighter yellow/green/cyan orbit rings.
- Ring tube radii increased.
- Sparkle remains lightweight.

Projectiles:

- White-hot projectile core increased.
- Cyan bolt material strengthened.
- Haze reduced to prevent smearing.
- Enemy projectile core and body became brighter tube-like bolts.

XP attraction trail:

- Trail tube radius increased from `0.018` to `0.022`.
- Active pull trail radius now scales from `0.020` upward.

## 9. Mini-Boss Changes

Prism Warden received the strongest non-player neon edge treatment:

- Darker octahedron body.
- Brighter violet edge tubes.
- Edge tube radii increased to `0.148 / 0.040`.
- White-hot vertex beacons increased from `0.075` to `0.090`.
- Reactor torus tube radius increased from `0.046` to `0.058`.
- Plasma shell reduced so the real 3D octahedron volume remains readable.

## 10. Performance Safeguards

Preserved:

- Enemy cap.
- Projectile caps.
- XP cap.
- Mine cap.
- Beam cap.
- Burst/VFX cap.
- Existing self-cleaning VFX lifetimes.
- Shared material construction.
- Existing scene path and official launch scene.

No new object types or alternate scenes were created. The pass increased radii and material tuning on existing meshes rather than adding uncontrolled extra node trees.

## 11. Validation Results

Passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- Controller/input, pause, XP/level-up, weapons, and mini-boss smoke
- Death/restart smoke
- Gameplay stress test

3000-frame run summary:

- Time: `12.0`
- Wave: `IGNITION`
- Enemies: `7/54`
- XP: `10/100`
- Player projectiles: `0/36`
- Enemy projectiles: `0/28`
- Mines: `1/6`
- Beams: `1/8`
- Bursts: `3/18`
- Kills: `15`
- Score: `575`
- Mini-boss active: `false`

Smoke test:

- Controller map: passed
- Pause: passed
- XP/level-up: passed
- Weapons: passed
- Mini-boss: passed
- Projectiles: `3`
- Beams: `1`
- Mines: `1`
- Level: `2`
- Score: `915`

Restart smoke:

- Restart resets run state: passed
- Esc ignored during death flow: passed
- Enter restart: passed
- Start supported: passed

Stress test:

- Average headless frame time: `6.827 ms`
- Nodes: `2315`
- Enemies: `53/54`
- XP: `90/100`
- Player projectiles: `8/36`
- Enemy projectiles: `28/28`
- Mines: `6/6`
- Bursts: `18/18`
- Mini-boss active: `true`

## 12. Files Changed

- `scripts/visuals/Neon3DVisualKit.gd`
- `scripts/visuals/Player3D.gd`
- `scripts/visuals/Chaser3D.gd`
- `scripts/visuals/Tank3D.gd`
- `scripts/visuals/Shooter3D.gd`
- `scripts/visuals/Exploder3D.gd`
- `scripts/visuals/XPOrb3D.gd`
- `scripts/visuals/Projectile3D.gd`
- `scripts/visuals/MiniBoss3D.gd`
- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_5_REPAIR_1_NEON_TUBE_EDGE_MATERIAL_REPORT.md`

## 13. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 14. What The User Should Test

Manual visual checks:

- Player reads as dark 3D core plus bright cyan/magenta neon tube edges.
- Chasers, tanks, shooters, and exploders have darker bodies and brighter edge seams.
- Tank enemies no longer look like flat yellow boxes; they should read as heavy neon-edged cuboids.
- XP reads as a small premium energy pickup with bright rings, not a yellow blob.
- Projectiles read as hot energy bolts.
- Prism Warden reads as a dark octahedron with strong violet/white neon tube edges.
- Explosions and bursts look brighter but still disappear quickly.
- The game does not return to blurry over-bloom.

Gameplay checks:

- Controller movement.
- Keyboard movement.
- Pause/unpause.
- Death/restart.
- XP collection and level-up.
- Pulse Blaster, Orbit Spark, Nova Burst, Arc Beam, and Gravity Mine.
- Mini-boss spawn/fight/death.
- Heavy swarm readability and performance.

## 15. Known Issues

- Final visual approval still requires live manual review; headless validation cannot verify subjective neon-tube quality.
- The official scene still uses the historical implementation script name `NeonSwarm3DGameplayPrototype.gd`.
- This pass improves edge-tube material hierarchy but does not add audio, advanced post-processing, or new asset models.

## 16. Approval Status

Approved.

This pass is now the locked visual baseline for Neon Swarm: dark 3D body faces plus bright neon tube edges in the official `scenes/Main.tscn` build.
