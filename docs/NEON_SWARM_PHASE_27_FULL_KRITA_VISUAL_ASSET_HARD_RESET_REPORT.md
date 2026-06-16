# Neon Swarm Phase 27 Full Krita Visual Asset Hard Reset Report

## Superseded / Not Approved

This report is preserved as historical context only.

The Phase 27 Krita/Inkscape gameplay-object pass was not approved because it used flat 2D PNG gameplay objects for the player, enemies, bosses, and weapon visuals. That direction is rejected for gameplay objects.

The active Phase 27 repair is documented in:

- `docs/NEON_SWARM_PHASE_27_BLENDER_3D_GAMEPLAY_ASSET_HARD_RESET_REPORT.md`

Current status:

- Flat PNG gameplay object nodes were disabled/replaced.
- Player/enemy/boss/weapon gameplay visuals now use Blender-made `.glb` 3D assets.
- Krita/Inkscape assets may remain as historical source, UI/icon support, or concept/reference material, but they are not the approved gameplay-object pipeline.

Everything below this notice describes the rejected first pass for archive/reference only. It is not the active Phase 27 gameplay-object implementation.

## 1. Executive Summary

The rejected first pass attempted to add an Inkscape/Krita visual asset pipeline for the player, active enemies, bosses, weapon gameplay visuals, and weapon-family UI icons. That pass is no longer the active implementation for gameplay objects because those assets were flat PNGs instead of real 3D objects.

## 2. Why This Phase Exists

The project still had visible programmer-art/procedural-looking gameplay objects after the Phase 26 HD sector background reset. The rejected first pass attempted to upgrade those remaining gameplay and UI weapon visuals with Krita/Inkscape PNG assets, but that approach is no longer active for gameplay objects.

## 3. Inkscape Files Created

- `art/player/source/inkscape/player_core_hd.svg`
- `art/enemies/source/inkscape/enemy_family_hd_art_sheet.svg`
- `art/weapons/source/inkscape/weapon_visual_hd_art_sheet.svg`
- `art/weapons/icons/source/inkscape/weapon_icon_hd_art_sheet.svg`

## 4. Krita / Krita-Ready Files Created

- `art/player/source/krita/player_core_krita_ready.ora`
- `art/enemies/source/krita/enemy_family_hd_art_sheet_krita_ready.ora`
- `art/weapons/source/krita/weapon_visual_hd_art_sheet_krita_ready.ora`
- `art/weapons/icons/source/krita/weapon_icon_hd_art_sheet_krita_ready.ora`
- Matching `*_inkscape_render.png` and `*_krita_export.png` files were created beside each `.ora`.
- Layer-source folders such as `*_krita_ready/` were also kept as unpacked Krita-ready layer references.

Krita CLI exported the final PNG sheets from the `.ora` files. Krita printed ICC profile and tile-leak warnings during command-line export, but all exports completed with exit code 0 and the PNGs loaded in Godot validation.

## 5. Exported PNG Assets

55 exported runtime/UI PNGs were created:

- `art/player/exported/player_core_hd.png`
- 15 enemy/boss PNGs under `art/enemies/exported/`
- 19 weapon gameplay visual PNGs under `art/weapons/exported/`
- 20 weapon icon PNGs under `art/weapons/icons/exported/`, including `unknown_weapon_icon_hd.png`

## 6. Player Art Changes

The player now uses `player_core_hd.png`, a Krita-exported diamond/hex command core with dark glass faces, cyan neon tube edges, magenta delta wings, a white-hot center reactor, and a forward prow. Existing movement, collision, health, weapon firing, and damage flash behavior were preserved.

## 7. Enemy Art Changes

HD enemy assets were created and integrated for:

- Chaser
- Tank
- Shooter
- Exploder
- Spiral Drifter
- Shield Node
- Hex Slicer
- Prism Leech
- Triad Splitter
- Triad Fragment
- Hex Pulser

Each enemy keeps its geometry-tree identity and existing behavior. The new texture-backed art is attached to the existing enemy visual root during `_spawn_enemy()`.

## 8. Boss Art Changes

HD boss/major-threat assets were created and integrated for:

- Prism Warden
- Null Octagon
- Null Octagon Prime
- Fractal Crown

Boss logic, sector placement, HP, attacks, rewards, and win conditions were not changed.

## 9. Weapon Visual Changes

HD weapon gameplay visuals were created for all active weapon families:

- Pulse Blaster
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine
- Prism Lance
- Ring Saw
- Hex Shatter
- Fractal Shard
- Tri-Burst Cannon
- Hex Mortar
- Vector Spear
- Orbital Saw Array
- Prism Chain
- Gravity Well
- Nova Needle
- Fractal Bloom
- Shield Breaker
- Star Pulse

Projectile weapons use HD billboards. Mine/well/nova/star/ring/beam effects use flat HD overlays. Existing weapon damage, cooldowns, projectile caps, stat rolls, runtime loadout routing, and collision logic were preserved.

## 10. Weapon Icon Changes

`scripts/ui/NeonWeaponIcon.gd` now maps weapon-family IDs to Krita-exported PNGs under `art/weapons/icons/exported/`. If a future PNG is missing, the control falls back to the existing draw-call family icon instead of crashing.

These icons replace the active Phase 25 placeholder UI path, but they remain one icon per weapon family rather than per random weapon instance.

## 11. Geometry Tree Compliance

The new art follows the existing geometry bible:

- Player: diamond/hex command core.
- Chaser/Triad/Fractal content: triangle and shard language.
- Tank/Shield Breaker/Vector rail content: square, diamond, and rail language.
- Shooter/Shield Node/Hex Pulser/Hex Mortar: hex language.
- Null bosses: octagon/black-glass language.
- Gravity content: ring/lens/singularity language.
- Star Pulse/Nova/Ring Saw: radial ring/star language.

No random shape families were added.

## 12. Godot Integration

Updated:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonWeaponIcon.gd`

Added runtime helpers:

- `_load_visual_art_texture()`
- `_make_visual_art_material()`
- `_add_hd_art_billboard()`
- `_add_hd_art_plane()`
- `_apply_player_hd_art()`
- `_apply_enemy_hd_art()`
- `_apply_weapon_projectile_hd_art()`
- `_add_weapon_field_hd_art()`

These load PNGs at runtime with `Image.load_from_file()` and attach art to existing official gameplay nodes.

## 13. Readability Safeguards

- Existing gameplay collisions and caps were not changed.
- Player/enemy/boss art is sized per family.
- Weapon field overlays use partial alpha so they do not fully cover enemies or XP.
- Missing art returns safely instead of throwing missing-texture crashes.
- UI icons retain the existing rarity frame and control sizing.

## 14. Performance Validation

Validation passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- Additional asset validation script: `godot --headless --path . --script /tmp/neon_swarm_phase27/phase27_asset_validation.gd`

The long headless stress command completed with exit code 0. The asset validation loaded all new player, enemy, boss, weapon visual, and icon PNGs and confirmed Krita-backed art nodes were created in `Main.tscn`.

## 15. Files Changed

Code:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonWeaponIcon.gd`

Art/source/export:

- `art/player/source/`
- `art/player/exported/`
- `art/enemies/source/`
- `art/enemies/exported/`
- `art/weapons/source/`
- `art/weapons/exported/`
- `art/weapons/icons/source/`
- `art/weapons/icons/exported/`

Docs:

- `docs/NEON_SWARM_PHASE_27_FULL_KRITA_VISUAL_ASSET_HARD_RESET_REPORT.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `art/player/source/player_art_pipeline_notes.md`
- `art/enemies/source/enemy_art_pipeline_notes.md`
- `art/weapons/source/weapon_visual_art_pipeline_notes.md`
- `art/weapons/icons/source/weapon_icon_krita_pipeline_notes.md`

## 16. Exact Run Command

Official editor run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 17. What I Should Test Visually

- Start Game and confirm the player core looks like the new HD neon command object.
- Confirm chasers and early enemies use new readable silhouettes.
- Reach boss events and confirm Prism Warden, Null Octagon / Prime, and Fractal Crown appear larger and more intentional.
- Equip or receive different weapons and confirm spear, mortar, chain, well, saw, star pulse, shard, and needle visuals are distinguishable.
- Open Armory and check equipped/stash icons.
- Trigger sector reward weapon cards and replacement UI to confirm icons display.
- Open How To Play and confirm weapon icons still appear.
- Watch readability against the Phase 26 HD backgrounds during heavy action.

## 18. Known Issues

- Krita CLI export printed non-blocking ICC profile, resource database, and tile-leak warnings. The exported PNGs were created and validated in Godot.
- Inkscape CLI printed a non-blocking warning about writing an extension error log under the home config path. The PNG render inputs were created.
- The art pass is source-backed and integrated, but final subjective quality/readability still needs manual review in motion on a normal display.
- The visual layer hides many older procedural child meshes where HD art exists, but the old scripts/scenes remain as fallback and for future comparison.

## 19. Approval Question

Do you approve Phase 27 as the full Krita visual asset hard reset baseline, or should the next work be a Phase 27 visual repair pass focused on scale, brightness, and readability before any Phase 28 work?
