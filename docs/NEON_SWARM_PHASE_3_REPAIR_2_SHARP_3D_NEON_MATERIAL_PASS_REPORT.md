# Neon Swarm Phase 3 Repair 2 Sharp 3D Neon Material Pass Report

## 1. Executive Summary

Phase 3 Repair 2 keeps the direction approved in Repair 1 and restores controlled neon/plasma energy to the playable 3D-on-2D gameplay scene.

The pass does not restart the direction, does not return to flat wireframes, and does not return to blurry bloom blobs. It strengthens neon material, rim/edge light, white-hot accents, XP/projectile energy, impact sparks, and arena atmosphere while preserving readable 3D geometry.

No main-game migration, bosses, new enemies, new weapons, meta progression, or campaign content were added.

## 2. Why Phase 3 Repair 1 Was Directionally Approved

Repair 1 established the correct foundation:

- actual 3D geometric gameplay assets
- readable player and enemy silhouettes
- clear chaser/tank/shooter/exploder forms
- controlled blur
- real depth on a 2D gameplay plane
- playable 3D-on-2D gameplay scene

That foundation remains intact.

## 3. What Neon Was Missing

The Repair 1 version became readable, but some arcade energy was reduced too far:

- opaque forms were readable but not energetic enough
- edge glow was too conservative
- XP felt less premium
- projectiles were readable but underpowered visually
- hit/death feedback needed more spark pop
- arena atmosphere was too quiet

The fix was local material/VFX restoration, not global bloom.

## 4. Material Changes

Shared material changes in `scripts/visuals/Neon3DVisualKit.gd`:

- `make_neon_body_material()` now uses an opaque shader material with controlled rim emission.
- Custom procedural meshes now generate flat normals so facets and 3D volume read under rim lighting.
- Body materials remain opaque and depth-tested.
- Transparent emissive materials continue using depth testing rather than drawing over everything.
- Plasma shells remain mixed/translucent rather than heavy additive blobs.

Object material tuning:

- Player: stronger cyan/magenta rim body emission and controlled shield ring energy.
- Chaser: stronger green neon rim and sharper white-hot nose.
- Tank: stronger gold/orange body edge energy while preserving block silhouette.
- Shooter: stronger violet body rim and clearer cyan muzzle charge.
- Exploder: stronger red/orange warning material without increasing shell size.
- XP: stronger gold body/ring emission and small green value glint.
- Projectile: brighter white-hot core and cyan bolt body with short controlled trail.

## 5. Edge/Rim Glow Changes

Rim/edge glow now comes primarily from:

- opaque body shader rim emission
- moderate tube-edge emission
- small white-hot edge/core accents

This keeps internal surfaces visible while making silhouettes feel neon-lit.

The player and immediate threats received stronger local edge material than background/arena elements. Arena glow remains lower priority.

## 6. XP/Projectile/VFX Changes

XP:

- stronger gold neon body
- brighter but small white-hot reward point
- cyan/gold ring treatment strengthened
- added small green value glint ring
- added capped XP attraction trails during collection
- XP trail visibility capped at 20 active trails

Projectiles:

- brighter white-hot projectile core
- stronger cyan energy bolt body
- short trail restored without broad smear
- enemy projectile material strengthened but kept small

Hit/death feedback:

- enemies now get a quick visual scale flash on hit
- impact/death bursts use color-matched spark materials
- spark fragments remain short-lived and capped
- player damage burst uses red spark material
- XP collection pop uses yellow XP spark material

## 7. Arena Atmosphere Changes

Arena:

- grid glow increased slightly but remains below gameplay priority
- border glow increased slightly without returning to bright wash
- added one batched low-priority neon dust field
- dust uses one `MultiMeshInstance3D` with 64 tiny particles

The arena remains behind player, enemies, projectiles, and XP.

## 8. Performance Results

Validation commands run:

```bash
godot --headless --path . scenes/NeonSwarm3DGameplayPrototype.tscn --quit-after 3
godot --headless --path . scenes/NeonSwarm3DGameplayPrototype.tscn --quit-after 3000
godot --headless --path . --script /tmp/neon_swarm_real_3d_gameplay_smoke.gd
godot --headless --path . --script /tmp/neon_swarm_real_3d_gameplay_stress.gd
godot --headless --path . --quit-after 3
```

All seven standalone visual assets also launched successfully:

- Player3D
- Chaser3D
- Tank3D
- Shooter3D
- Exploder3D
- XPOrb3D
- Projectile3D

Long gameplay result:

```text
Real 3D gameplay review summary: time=12.0 enemies=11/54 xp=7/100 player_projectiles=0/36 enemy_projectiles=0/28 bursts=1/18 kills=11 score=425
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
enemies=53/54 xp=100/100 player_projectiles=3/36 enemy_projectiles=9/28 bursts=0/18 kills=1 score=35 avg_headless_frame_ms=6.852
```

Performance guardrails preserved:

- enemy cap: 54
- XP cap: 100
- player projectile cap: 36
- enemy projectile cap: 28
- burst cap: 18
- active XP collection trail cap: 20
- batched atmosphere dust: 64 instances in one MultiMesh
- no runaway particles

## 9. Files Changed

- `scripts/visuals/Neon3DVisualKit.gd`
- `scripts/visuals/Player3D.gd`
- `scripts/visuals/Chaser3D.gd`
- `scripts/visuals/Tank3D.gd`
- `scripts/visuals/Shooter3D.gd`
- `scripts/visuals/Exploder3D.gd`
- `scripts/visuals/XPOrb3D.gd`
- `scripts/visuals/Projectile3D.gd`
- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_3_REPAIR_2_SHARP_3D_NEON_MATERIAL_PASS_REPORT.md`

## 10. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/NeonSwarm3DGameplayPrototype.tscn
```

## 11. What I Should Test

Manual review checklist:

1. Player remains instantly identifiable and does not become a blob.
2. Chaser still reads as triangular/pyramid-like.
3. Tank still reads as cuboid/block-like.
4. Shooter still reads as a distinct ranged geometric enemy.
5. Exploder still reads as sphere/torus/unstable orb.
6. XP feels more valuable without becoming a yellow blur.
7. Projectiles feel more energetic without becoming giant streaks.
8. Hit/death sparks feel more arcade but do not clutter the screen.
9. Arena atmosphere supports the neon feel without competing with gameplay.
10. Controller movement and Start pause still work.

## 12. Known Issues

- This is still an isolated 3D gameplay review prototype, not main-game migration.
- Visual approval is not claimed.
- Assets are still procedural Godot 3D visual definitions, not Blender-authored mesh assets.
- Gameplay balance remains prototype-level.
- The 3D scene still does not have the full 2D level-up choice UI.
- Manual play is required to judge whether neon energy is now strong enough while preserving readability.

## 13. Approval Question

After playing `scenes/NeonSwarm3DGameplayPrototype.tscn`, does this pass restore enough neon/plasma energy while preserving the readable 3D shapes from Repair 1, or should specific objects be locally tuned further?
