# Neon Swarm Phase 27 Blender 3D Gameplay Asset Hard Reset Report

## 1. Why The Krita/Inkscape Object Pass Failed

The previous Phase 27 pass failed because the in-game player, enemy, boss, and weapon objects were integrated as flat PNG billboards. That did not meet the visual direction for actual gameplay objects.

The corrected direction is Blender-made 3D models for gameplay objects. Krita/Inkscape remain valid for concepts, UI support, icon polish, and source references, but not as flat gameplay-object replacements.

## 2. Flat PNG Gameplay Objects Replaced / Disabled

The following failed runtime path was removed from active gameplay integration:

- `KritaHDPlayerCoreArt`
- `KritaHDEnemyArt_*`
- `KritaHDWeaponProjectile_*`
- `KritaHDWeaponField_*`
- `_load_visual_art_texture()`
- `_add_hd_art_billboard()`
- `_add_hd_art_plane()`
- `_apply_player_hd_art()`
- `_apply_enemy_hd_art()`
- `_apply_weapon_projectile_hd_art()`
- `_add_weapon_field_hd_art()`

The PNG files can remain as historical/source/UI reference material, but the official gameplay script no longer instantiates flat PNG gameplay objects.

## 3. Blender Source Files Created

Player:

- `art/player/source/blender/player_core.blend`

Enemies:

- `art/enemies/source/blender/chaser.blend`
- `art/enemies/source/blender/tank.blend`
- `art/enemies/source/blender/shooter.blend`
- `art/enemies/source/blender/exploder.blend`
- `art/enemies/source/blender/spiral_drifter.blend`
- `art/enemies/source/blender/shield_node.blend`
- `art/enemies/source/blender/hex_slicer.blend`
- `art/enemies/source/blender/prism_leech.blend`
- `art/enemies/source/blender/triad_splitter.blend`
- `art/enemies/source/blender/triad_fragment.blend`
- `art/enemies/source/blender/hex_pulser.blend`

Bosses:

- `art/bosses/source/blender/prism_warden.blend`
- `art/bosses/source/blender/null_octagon.blend`
- `art/bosses/source/blender/null_octagon_prime.blend`
- `art/bosses/source/blender/fractal_crown.blend`

XP:

- `art/xp/source/blender/xp_shard.blend`

Weapons:

- `art/weapons/source/blender/pulse_blaster.blend`
- `art/weapons/source/blender/orbit_spark.blend`
- `art/weapons/source/blender/nova_burst.blend`
- `art/weapons/source/blender/arc_beam.blend`
- `art/weapons/source/blender/gravity_mine.blend`
- `art/weapons/source/blender/prism_lance.blend`
- `art/weapons/source/blender/ring_saw.blend`
- `art/weapons/source/blender/hex_shatter.blend`
- `art/weapons/source/blender/fractal_shard.blend`
- `art/weapons/source/blender/tri_burst_cannon.blend`
- `art/weapons/source/blender/hex_mortar.blend`
- `art/weapons/source/blender/vector_spear.blend`
- `art/weapons/source/blender/orbital_saw_array.blend`
- `art/weapons/source/blender/prism_chain.blend`
- `art/weapons/source/blender/gravity_well.blend`
- `art/weapons/source/blender/nova_needle.blend`
- `art/weapons/source/blender/fractal_bloom.blend`
- `art/weapons/source/blender/shield_breaker.blend`
- `art/weapons/source/blender/star_pulse.blend`

Blender also created source-side `.blend1` backups beside the primary `.blend` files:

- `art/player/source/blender/player_core.blend1`
- `art/enemies/source/blender/chaser.blend1`
- `art/enemies/source/blender/tank.blend1`
- `art/enemies/source/blender/shooter.blend1`
- `art/enemies/source/blender/exploder.blend1`
- `art/enemies/source/blender/spiral_drifter.blend1`
- `art/enemies/source/blender/shield_node.blend1`
- `art/enemies/source/blender/hex_slicer.blend1`
- `art/enemies/source/blender/prism_leech.blend1`
- `art/enemies/source/blender/triad_splitter.blend1`
- `art/enemies/source/blender/triad_fragment.blend1`
- `art/enemies/source/blender/hex_pulser.blend1`
- `art/bosses/source/blender/prism_warden.blend1`
- `art/bosses/source/blender/null_octagon.blend1`
- `art/bosses/source/blender/null_octagon_prime.blend1`
- `art/bosses/source/blender/fractal_crown.blend1`
- `art/weapons/source/blender/pulse_blaster.blend1`
- `art/weapons/source/blender/orbit_spark.blend1`
- `art/weapons/source/blender/nova_burst.blend1`
- `art/weapons/source/blender/arc_beam.blend1`
- `art/weapons/source/blender/gravity_mine.blend1`
- `art/weapons/source/blender/prism_lance.blend1`
- `art/weapons/source/blender/ring_saw.blend1`
- `art/weapons/source/blender/hex_shatter.blend1`
- `art/weapons/source/blender/fractal_shard.blend1`
- `art/weapons/source/blender/tri_burst_cannon.blend1`
- `art/weapons/source/blender/hex_mortar.blend1`
- `art/weapons/source/blender/vector_spear.blend1`
- `art/weapons/source/blender/orbital_saw_array.blend1`
- `art/weapons/source/blender/prism_chain.blend1`
- `art/weapons/source/blender/gravity_well.blend1`
- `art/weapons/source/blender/nova_needle.blend1`
- `art/weapons/source/blender/fractal_bloom.blend1`
- `art/weapons/source/blender/shield_breaker.blend1`
- `art/weapons/source/blender/star_pulse.blend1`

## 4. GLB Files Exported

Player:

- `art/player/exported/3d/player_core.glb`

Enemies:

- `art/enemies/exported/3d/chaser.glb`
- `art/enemies/exported/3d/tank.glb`
- `art/enemies/exported/3d/shooter.glb`
- `art/enemies/exported/3d/exploder.glb`
- `art/enemies/exported/3d/spiral_drifter.glb`
- `art/enemies/exported/3d/shield_node.glb`
- `art/enemies/exported/3d/hex_slicer.glb`
- `art/enemies/exported/3d/prism_leech.glb`
- `art/enemies/exported/3d/triad_splitter.glb`
- `art/enemies/exported/3d/triad_fragment.glb`
- `art/enemies/exported/3d/hex_pulser.glb`

Bosses:

- `art/bosses/exported/3d/prism_warden.glb`
- `art/bosses/exported/3d/null_octagon.glb`
- `art/bosses/exported/3d/null_octagon_prime.glb`
- `art/bosses/exported/3d/fractal_crown.glb`

XP:

- `art/xp/exported/3d/xp_shard.glb`

Weapons:

- `art/weapons/exported/3d/pulse_blaster.glb`
- `art/weapons/exported/3d/orbit_spark.glb`
- `art/weapons/exported/3d/nova_burst.glb`
- `art/weapons/exported/3d/arc_beam.glb`
- `art/weapons/exported/3d/gravity_mine.glb`
- `art/weapons/exported/3d/prism_lance.glb`
- `art/weapons/exported/3d/ring_saw.glb`
- `art/weapons/exported/3d/hex_shatter.glb`
- `art/weapons/exported/3d/fractal_shard.glb`
- `art/weapons/exported/3d/tri_burst_cannon.glb`
- `art/weapons/exported/3d/hex_mortar.glb`
- `art/weapons/exported/3d/vector_spear.glb`
- `art/weapons/exported/3d/orbital_saw_array.glb`
- `art/weapons/exported/3d/prism_chain.glb`
- `art/weapons/exported/3d/gravity_well.glb`
- `art/weapons/exported/3d/nova_needle.glb`
- `art/weapons/exported/3d/fractal_bloom.glb`
- `art/weapons/exported/3d/shield_breaker.glb`
- `art/weapons/exported/3d/star_pulse.glb`

## 5. Player 3D Model Details

`player_core.glb` is a real Blender mesh model with:

- Diamond/hex command-core body.
- Dark glass body faces.
- Cyan neon tube-edge mesh cylinders.
- Magenta delta wings.
- Forward prow.
- White-hot central reactor.
- Orbit-ring accents.

The model is attached to the existing player visual root as `Blender3DPlayerCoreModel`.

## 6. Enemy 3D Model Details

Enemy models preserve existing role reads:

- Chaser: tetra/arrow pursuit shape.
- Tank: cuboid armor body, side tread slabs, siege prow.
- Shooter: hex body and cannon rails.
- Exploder: pressure sphere with warning ring and spikes.
- Spiral Drifter: core with double helix/ring motion language.
- Shield Node: protected core with hex shield plate and ward ring.
- Hex Slicer: hex core with blade teeth.
- Prism Leech: diamond body with tether rings.
- Triad Splitter: three triangular shards around core.
- Triad Fragment: small triangular shard.
- Hex Pulser: hex core with warning/pulse rings.

Enemy gameplay behavior was not changed.

## 7. Boss 3D Model Details

- Prism Warden: prism/octahedron authority body, crown modules, command ring, reactor core.
- Null Octagon: black-glass octagonal body with void cage and cyan/magenta edge hierarchy.
- Null Octagon Prime: larger and stronger octagonal command form.
- Fractal Crown: dark diamond core, stacked triangular crown spikes, broken halo, orange/magenta/cyan edge language.

No boss behavior, timing, HP, or sector placement changed.

## 8. Weapon / Projectile 3D Visual Details

All active weapon families now have Blender `.glb` visual assets. Projectile weapons instantiate `Blender3DWeaponProjectile_*`. Persistent, orbit, beam, mine, and field visuals instantiate `Blender3DWeaponModel_*` or `Blender3DWeaponVisual_*`.

Examples:

- Tri-Burst Cannon: three triangle bolt mesh cluster.
- Hex Mortar: hex shell with burst shard ring.
- Vector Spear: long rail body with spear head.
- Ring Saw: torus blade ring with cutter teeth.
- Prism Chain: linked prism nodes and tubes.
- Gravity Well: singularity core with event horizon rings.
- Star Pulse: radial 3D ray/starburst mesh.
- Fractal Bloom: seed shard plus child shard fan.

Weapon damage, cooldowns, projectile caps, split counts, chain counts, and stat-roll behavior were not changed.

## 9. Icon From 3D Plan / Status

Weapon-family icons were rendered from the Blender weapon models where practical.

Rendered source copies:

- `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`

Active UI exports:

- `art/weapons/icons/exported/*_icon_hd.png`

The fallback unknown icon remains available for future missing families.

## 10. Godot Integration Details

Updated:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonWeaponIcon.gd`

New runtime GLB helpers:

- `_load_blender_asset_scene()`
- `_add_blender_asset_instance()`
- `_apply_player_blender_model()`
- `_apply_enemy_blender_model()`
- `_apply_weapon_projectile_blender_model()`
- `_add_weapon_blender_model()`

Godot uses `GLTFDocument.append_from_file()` and `generate_scene()` to load `.glb` files at runtime. This avoids relying on editor import metadata during headless validation. Generated scenes are packed and cached safely as `PackedScene` resources.

## 11. Geometry Tree Compliance

- Player: diamond/hex command core.
- Chaser/Triad/Fractal content: triangle/shard hierarchy.
- Tank/Shield Breaker/Vector Spear: cuboid, diamond, and rail hierarchy.
- Shooter/Shield Node/Hex Pulser/Hex Mortar: hex hierarchy.
- Null bosses: octagon/black-glass hierarchy.
- Gravity Mine / Gravity Well: ring/lens/singularity hierarchy.
- Ring Saw / Orbit / Star / Nova: radial torus/star hierarchy.

No new gameplay shape families were added.

## 12. Readability Safeguards

- Existing collision shapes remain unchanged.
- Existing behavior scripts remain unchanged.
- GLB meshes are attached to existing gameplay visual roots.
- Enemy/boss/player art sizes are controlled by helper scale mappings.
- If a future GLB is missing, the existing procedural mesh visuals remain as fallback instead of crashing.
- Weapon caps and VFX caps remain active.

## 13. Performance Validation

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
```

The Blender validation confirmed:

- Blender is available: `Blender 4.0.2`
- 36 primary `.blend` source files exist; Blender also created 35 `.blend1` source backups.
- 36 `.glb` runtime exports exist.
- Every GLB parses through Godot `GLTFDocument`.
- `Main.tscn` creates Blender player/enemy/XP/weapon model nodes.
- Old `KritaHD` gameplay nodes are not active.

## 14. Files Changed

Code:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonWeaponIcon.gd`

New Blender art/source/export folders:

- `art/player/source/blender/`
- `art/player/exported/3d/`
- `art/enemies/source/blender/`
- `art/enemies/exported/3d/`
- `art/bosses/source/blender/`
- `art/bosses/exported/3d/`
- `art/xp/source/blender/`
- `art/xp/exported/3d/`
- `art/weapons/source/blender/`
- `art/weapons/exported/3d/`
- `art/weapons/icons/source/rendered_from_3d/`
- `art/weapons/icons/exported/`

Docs:

- `docs/NEON_SWARM_PHASE_27_FULL_KRITA_VISUAL_ASSET_HARD_RESET_REPORT.md`
- `docs/NEON_SWARM_PHASE_27_BLENDER_3D_GAMEPLAY_ASSET_HARD_RESET_REPORT.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_PHASE_27_REPAIR_2_READABILITY_XP_WEAPON_RENDER_PASS_REPORT.md`
- `art/player/source/blender/player_blender_pipeline_notes.md`
- `art/enemies/source/blender/enemy_blender_pipeline_notes.md`
- `art/bosses/source/blender/boss_blender_pipeline_notes.md`
- `art/weapons/source/blender/weapon_blender_pipeline_notes.md`

## 15. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 16. What I Should Test Visually

- Start Game and confirm the player is a real 3D model, not a flat sprite.
- Confirm early enemies are 3D shapes with dark bodies and neon tube edges.
- Confirm Prism Warden, Null Octagon, Null Octagon Prime, and Fractal Crown are 3D boss objects.
- Equip or receive different weapons and watch projectile/field/orbit visuals.
- Check Vector Spear, Hex Mortar, Prism Chain, Gravity Well, Ring Saw, Star Pulse, and Fractal Bloom for distinct 3D reads.
- Open Armory/reward screens and confirm icons match the 3D weapon family direction.
- Watch scale/readability against the Phase 26 HD backgrounds.

## 17. Known Issues

- Blender reported a non-blocking PulseAudio wake warning in background mode.
- Blender reported optional Draco compression library missing; GLBs exported successfully without Draco.
- The models are first-pass 3D art assets and still need subjective visual review for scale, silhouette strength, glow strength, and camera-distance readability.
- The old procedural visual scenes remain as fallback; they are hidden/replaced where Blender assets load.

## Phase 27 Repair 2 — Readability / XP / Weapon Render Pass

Repair 2 keeps the Blender 3D gameplay-object pipeline and fixes the readability/object-consistency issues found after the first Blender pass.

Changes:

- Enemy and boss Blender assets were regenerated with stronger neon material emission, clearer white-hot core routes, and object-level readability frames.
- The active XP pickup is now a Blender-made 3D asset:
  - Source: `art/xp/source/blender/xp_shard.blend`
  - Runtime: `art/xp/exported/3d/xp_shard.glb`
  - Godot node: `Blender3DXPPickupModel`
- The old active `XPOrb3D.tscn` visual path was removed from the official gameplay script.
- Weapon-family preview icons in Armory, stash, reward cards, replacement UI, comparison panels, and How To Play were regenerated from Blender weapon models where practical.
- The Blender asset validation now checks the XP source/export and forces an XP drop in `Main.tscn` to confirm the active Blender XP node is created.

Gameplay safety:

- Enemy behavior, HP, speed, damage, spawn pacing, and sector flow were not changed.
- Weapon damage, cooldowns, stat rolls, projectile caps, and loot behavior were not changed.
- XP value, collision radius, attract radius, pull speed, and collection behavior were not changed.

Repair 2 validation passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
```

## Blender Asset Readability Hotfix — Dark Neon Body Materials and Silhouette Scaling

This hotfix addresses the remaining gameplay-object readability problem without starting Phase 28 and without changing gameplay balance, enemy behavior, weapon behavior, collisions, loot, menus, or sector progression.

Assets that were too dark:

- Player core body faces still used near-black depth material.
- Active enemy families still lost readability when the neon edge was not facing the camera: Chaser, Tank, Shooter, Exploder, Spiral Drifter, Shield Node, Hex Slicer, Prism Leech, Triad Splitter, Triad Fragment, and Hex Pulser.
- Boss and miniboss bodies still had near-black depth faces: Prism Warden, Null Octagon, Null Octagon Prime, and Fractal Crown.
- Weapon/projectile/field Blender visuals that used dark body material, especially Fractal Shard, Gravity Well, and Shield Breaker, could disappear against the HD floor plates.

Dark neon body materials added:

- Pure black/near-black `DarkGlassBody` usage was replaced by asset-specific dark neon body materials generated from each object family accent.
- Player now uses a dark blue command-core body.
- Cyan/blue objects use dark blue/cyan bodies.
- Magenta/violet objects use dark purple/magenta bodies.
- Orange/gold objects use dark amber/gold bodies.
- Green objects use dark teal/green bodies.
- Red objects use dark red body material.
- Tinted glass support material was also raised from black-blue to the same per-object color family so secondary slabs and inner cores no longer vanish.
- Bright neon tube edges and white-hot readable cores remain in place; this pass changed body readability rather than adding stronger bloom.

Slightly enlarged or reshaped:

- Player model was visually scaled `1.05x`.
- Standard enemies were visually scaled `1.08x`.
- Chaser, Spiral Drifter, and Triad Fragment were visually scaled `1.12x`.
- Shooter, Exploder, Hex Slicer, and Triad Splitter were visually scaled `1.10x`.
- Bosses were visually scaled `1.06x`.
- Weapon/projectile visual meshes were visually scaled `1.06x` by default, with smaller fast weapons at `1.12x` and spear/mortar/breaker forms at `1.08x`.
- These are mesh/source/export visual scale changes only. Runtime collision, hit radius, movement, damage, cooldowns, and gameplay balance were not changed.

XP preservation:

- The approved Blender XP-letter pickup was not regenerated in this hotfix.
- Existing files remained active:
  - `art/xp/source/blender/xp_shard.blend`
  - `art/xp/exported/3d/xp_shard.glb`

Files changed:

- Regenerated player Blender source/export:
  - `art/player/source/blender/player_core.blend`
  - `art/player/exported/3d/player_core.glb`
- Regenerated active enemy Blender source/export:
  - `art/enemies/source/blender/*.blend`
  - `art/enemies/exported/3d/*.glb`
- Regenerated boss Blender source/export:
  - `art/bosses/source/blender/*.blend`
  - `art/bosses/exported/3d/*.glb`
- Regenerated weapon Blender source/export:
  - `art/weapons/source/blender/*.blend`
  - `art/weapons/exported/3d/*.glb`
- Refreshed Blender-derived weapon preview renders from the updated weapon models:
  - `art/weapons/icons/exported/*_icon_hd.png`
  - `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
- Updated documentation:
  - `docs/NEON_SWARM_PHASE_27_BLENDER_3D_GAMEPLAY_ASSET_HARD_RESET_REPORT.md`
  - `docs/NEON_SWARM_PHASE_27_REPAIR_2_READABILITY_XP_WEAPON_RENDER_PASS_REPORT.md`
  - `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

Validation results:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

All five commands passed. The Blender validation confirmed `.blend` sources and `.glb` runtime exports still exist, all GLBs parse through Godot, and the official scene still creates Blender player/enemy/XP/weapon nodes. The UI validation still passed after this visual-only asset rebuild.

Exact run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

What to test visually:

- Start a run and confirm the player core remains visible against each sector floor.
- Check Chaser, Tank, Shooter, Exploder, Spiral Drifter, Shield Node, Hex Slicer, Prism Leech, Triad Splitter, Triad Fragment, and Hex Pulser against Sectors 1-4.
- Confirm Prism Warden, Null Octagon, Null Octagon Prime, and Fractal Crown bodies no longer disappear when their neon edges angle away.
- Confirm weapon/projectile/orbit/mine/field visuals remain readable without becoming overbright.
- Confirm the XP pickup still reads as the approved Blender 3D `XP` letter pickup.

Known issues:

- Blender still reports a non-blocking PulseAudio wake warning in background mode.
- Blender still reports optional Draco compression missing; GLBs export and validate successfully without Draco.
- Final subjective readability must still be reviewed in the playable build on a normal display across all four HD sector backgrounds.

## Visual Tuning Hotfix — Richer Dark Neon Bodies, Popcorn Enemy Scale, XP Pulse Animation

This follow-up hotfix keeps Phase 27 focused on visual readability only. No Phase 28 work was started, no new gameplay content was added, and combat balance was not changed.

Dark body tuning:

- The previous dark neon body materials were still too dull against the HD sector floors.
- Blender body palettes were raised into richer saturated dark neon tones:
  - Cyan/blue objects now use deeper, brighter blue/cyan bodies.
  - Magenta/violet objects now use richer dark purple/magenta bodies.
  - Orange/gold objects now use richer dark amber/gold bodies.
  - Green objects now use richer dark teal/green bodies.
  - Red objects now use a clearer dark red body.
  - Player body depth now uses a brighter dark blue command-core material.
- Body materials remain darker than neon edge tubes and white-hot cores.
- Pure black and muddy gray body colors remain avoided.

Popcorn enemy scale:

- Regular non-boss enemy visuals now use a larger readable visual floor in the official runtime.
- Chaser, Tank, Shooter, Exploder, Spiral Drifter, Shield Node, Hex Slicer, Prism Leech, Triad Splitter, and Hex Pulser now clamp to at least `0.88` visual scale.
- Triad Fragment now clamps to at least `0.68`, keeping it smaller than full enemies while no longer disappearing.
- Bosses and mini-bosses were not enlarged. Prism Warden, Null Octagon, Null Octagon Prime, Fractal Crown, and `mini_boss` keep their existing visual scale behavior.
- Collision radius, HP, movement speed, damage, score, XP value, spawn pacing, and combat behavior were not changed.

XP pulse animation:

- Removed the XP visual's frame-by-frame Y/Z rotation.
- XP now keeps a stable readable orientation so the `XP` letters do not spin away from the camera.
- XP pickup materials are duplicated per pickup instance and receive a gentle emission pulse from `0.78x` to `1.0x`.
- XP `.blend` and `.glb` files were preserved unchanged:
  - `art/xp/source/blender/xp_shard.blend`
  - `art/xp/exported/3d/xp_shard.glb`
- XP value, attract radius, collection radius, pull speed, collision, and level-up behavior were not changed.

Files changed:

- Runtime:
  - `scripts/NeonSwarm3DGameplayPrototype.gd`
- Regenerated player Blender source/export:
  - `art/player/source/blender/player_core.blend`
  - `art/player/exported/3d/player_core.glb`
- Regenerated active enemy Blender source/export:
  - `art/enemies/source/blender/*.blend`
  - `art/enemies/exported/3d/*.glb`
- Regenerated boss Blender source/export:
  - `art/bosses/source/blender/*.blend`
  - `art/bosses/exported/3d/*.glb`
- Regenerated weapon Blender source/export and Blender-derived previews:
  - `art/weapons/source/blender/*.blend`
  - `art/weapons/exported/3d/*.glb`
  - `art/weapons/icons/exported/*_icon_hd.png`
  - `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
- Updated documentation:
  - `docs/NEON_SWARM_PHASE_27_BLENDER_3D_GAMEPLAY_ASSET_HARD_RESET_REPORT.md`
  - `docs/NEON_SWARM_PHASE_27_REPAIR_2_READABILITY_XP_WEAPON_RENDER_PASS_REPORT.md`
  - `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

Validation results:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

All required validation commands passed.

Exact run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

What to test visually:

- Confirm regular popcorn enemies are easier to see and feel slightly larger without crowding the arena.
- Confirm bosses and mini-bosses did not visually enlarge.
- Confirm body faces read as richer dark neon color, not dull black/gray.
- Confirm XP letters stay visible, no longer spin, and gently pulse in brightness.
- Confirm gameplay, rewards, Armory/Stash, right-stick scrolling, rarity UI, sector backgrounds, and weapon icons still work.

Known issues:

- Blender still reports a non-blocking PulseAudio wake warning in background mode.
- Blender still reports optional Draco compression missing; GLBs export and validate successfully without Draco.
- Final approval still depends on manual visual review in the official playable build.

## 18. Approval Question

Do you approve the Visual Tuning Hotfix as the active Phase 27 gameplay-object visual baseline, or should the next work remain a Phase 27-only visual repair focused on body color richness, popcorn enemy scale, or XP pulse readability?
