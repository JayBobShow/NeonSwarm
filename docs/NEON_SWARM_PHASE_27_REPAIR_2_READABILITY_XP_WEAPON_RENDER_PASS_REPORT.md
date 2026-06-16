# Neon Swarm Phase 27 Repair 2 Readability / XP / Weapon Render Pass Report

## 1. Executive Summary

Phase 27 Repair 2 keeps the approved Blender 3D asset pipeline and fixes the remaining object-art consistency issues:

- Enemies and bosses were regenerated with brighter neon tube materials and object-level readability frames.
- XP pickups now use a real Blender-made 3D GLB asset.
- Weapon UI previews remain family-level PNGs, but the active renders come from Blender weapon models where practical.
- Gameplay balance, combat logic, loot logic, sector flow, menus, and UI structure were not changed.

Official build remains `scenes/Main.tscn`.

## 2. Enemy Readability Repair

Every active enemy and boss GLB was regenerated with:

- stronger emissive neon materials,
- brighter white-hot accent routes,
- clearer per-family silhouette frames,
- preserved dark body faces,
- no screen-wide bloom increase,
- no behavior/stat changes.

Shape-specific readability routes:

- Chaser / Triad: triangle route frames.
- Tank: rectangular armor route frames.
- Shooter / Shield Node / Hex Slicer / Hex Pulser: hex route frames.
- Prism Leech: diamond route frames.
- Spiral Drifter / Exploder: cage/ring route frames.
- Prism Warden / Null Octagon / Fractal Crown: boss-scale route frames.

## 3. Blender XP Pickup

Created:

- `art/xp/source/blender/xp_shard.blend`
- `art/xp/exported/3d/xp_shard.glb`
- `art/xp/source/blender/xp_blender_pipeline_notes.md`

Godot integration:

- `scripts/NeonSwarm3DGameplayPrototype.gd` now attaches `Blender3DXPPickupModel` to XP pickups.
- The old active `XPOrb3D.tscn` visual path was removed from the official gameplay script.
- XP shard visual rotates as a visual-only child.

Unchanged:

- XP value.
- XP cap.
- Pickup collision radius.
- Magnet radius / pull speed.
- Collection behavior.
- XP sound and level-up behavior.

## 4. Weapon Preview / Render Source

Weapon preview PNGs used by Armory, stash, reward cards, replacement UI, comparison panels, and How To Play were regenerated from Blender weapon-family models where practical.

Active paths:

- Source renders: `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
- UI exports: `art/weapons/icons/exported/*_icon_hd.png`
- Runtime weapon GLBs: `art/weapons/exported/3d/*.glb`

The fallback unknown icon remains for missing future families, but it is not a final art solution.

## 5. Gameplay Object Audit

Blender-based active gameplay objects:

- Player core: `art/player/exported/3d/player_core.glb`
- Active enemy families: `art/enemies/exported/3d/*.glb`
- Active bosses: `art/bosses/exported/3d/*.glb`
- XP pickup: `art/xp/exported/3d/xp_shard.glb`
- Weapon projectiles / orbitals / mines / fields where practical: `art/weapons/exported/3d/*.glb`
- Weapon UI previews where practical: Blender-rendered PNGs under `art/weapons/icons/exported/`

Remaining procedural/fallback/support visuals:

- Collision shapes.
- XP attraction trail tube.
- Burst rings, spark fragments, and short-lived VFX helpers.
- Sector HD background planes and authored light runners.
- HUD/menu UI geometry.
- Existing procedural gameplay visuals as fallback if a future GLB is missing.

Future replacement candidates:

- Enemy projectile visuals remain simple procedural hostile bolts.
- Some short-lived burst/spark VFX remain procedural for performance and caps.
- Future final art can refine model detail, scale, and glow strength after real-play review.

## 6. Files Changed

Code:

- `scripts/NeonSwarm3DGameplayPrototype.gd`

New/updated Blender assets:

- `art/xp/source/blender/xp_shard.blend`
- `art/xp/exported/3d/xp_shard.glb`
- Regenerated `art/enemies/source/blender/*.blend`
- Regenerated `art/enemies/exported/3d/*.glb`
- Regenerated `art/bosses/source/blender/*.blend`
- Regenerated `art/bosses/exported/3d/*.glb`
- Regenerated `art/weapons/icons/source/rendered_from_3d/*.png`
- Regenerated `art/weapons/icons/exported/*_icon_hd.png`

Docs / notes:

- `docs/NEON_SWARM_PHASE_27_REPAIR_2_READABILITY_XP_WEAPON_RENDER_PASS_REPORT.md`
- `docs/NEON_SWARM_PHASE_27_BLENDER_3D_GAMEPLAY_ASSET_HARD_RESET_REPORT.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `art/xp/source/blender/xp_blender_pipeline_notes.md`
- `art/enemies/source/blender/enemy_blender_pipeline_notes.md`
- `art/bosses/source/blender/boss_blender_pipeline_notes.md`
- `art/weapons/source/blender/weapon_blender_pipeline_notes.md`

Validation helper:

- `/tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd`

## 7. Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
```

Validation confirmed:

- Official scene launches.
- Long headless stress exits cleanly.
- 36 primary `.blend` source files exist.
- 36 `.glb` runtime exports exist.
- XP `.blend` and `.glb` exist.
- Every GLB parses through Godot `GLTFDocument`.
- `Main.tscn` creates Blender player, enemy, XP, and weapon model nodes.
- Old `KritaHD` gameplay nodes are not active.

## Brightness Hotfix — Object Intensity Reduced 50%

The Phase 27 Repair 2 Blender object pass was too bright, so active Blender object material emission was reduced by 50% and the existing assets were regenerated.

Applied to:

- player model,
- enemies,
- bosses,
- XP pickup,
- weapon/projectile models,
- orbitals,
- mines,
- fields,
- Blender-derived weapon preview/icon renders.

Emission changes:

- Dark/glass body emission reduced from `0.12 / 0.18` to `0.06 / 0.09`.
- Neon edge/readability materials reduced from `7.4-10.6` range to `3.7-5.3` range.
- White-hot core material reduced from `10.0` to `5.0`.
- XP gold-white material reduced from `10.6` to `5.3`.

Gameplay safety:

- No combat balance changed.
- No enemy/projectile/weapon behavior changed.
- No new assets or gameplay content were added.
- Existing readability frames remain in place, but no longer use the overbright Repair 2 intensity.

Brightness hotfix validation passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
```

## Phase 27 Repair 3 Follow-Up — XP Cover-Art Match / Animated Weapon Icons

Phase 27 Repair 3 further updates the same Blender/UI pipeline:

- Existing XP asset path was redesigned again in the Repair 3 hotfix into a readable Blender 3D `XP` letter pickup.
- XP-specific emission was reduced another 50% from the post-hotfix pickup intensity.
- `NeonWeaponIcon` now animates Blender-derived weapon-family previews with subtle spin, pulse, and energy arcs.
- Armory, stash, reward cards, replacement UI, comparison panels, and How To Play inherit the animation through the shared icon control.

Full report:

- `docs/NEON_SWARM_PHASE_27_REPAIR_3_XP_COVER_ART_MATCH_AND_ANIMATED_WEAPON_ICONS_REPORT.md`

## 8. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 9. What The User Should Test Visually

- Start a run and confirm enemies read brighter against all current sector backgrounds.
- Kill enemies and confirm XP pickups are readable Blender 3D `XP` letter pickups.
- Confirm XP still attracts, collects, and fills the level bar.
- Open Armory and inspect weapon family previews.
- Trigger generated weapon reward cards and replacement UI; confirm previews still appear.
- Watch projectile/orbit/mine/field weapons and confirm gameplay remains readable.
- Confirm no combat balance changed.

## 10. Known Issues

- Blender still reports a non-blocking PulseAudio wake warning in background mode.
- Blender still reports optional Draco compression missing; GLBs export successfully without Draco.
- Enemy/projectile/boss final artistic quality still needs subjective visual review in the official playable build.
- Procedural fallback/support visuals remain for trails, bursts, UI, collision helpers, and missing future GLBs.

## Blender Asset Readability Hotfix — Dark Neon Body Materials and Silhouette Scaling

The next Phase 27-only readability hotfix corrected the remaining dark-face problem in active Blender gameplay objects. XP was preserved because the current Blender `XP` letter pickup already reads better than the other gameplay objects.

Assets that were too dark:

- Player core dark hull and inner glass depth.
- Enemy dark bodies for Chaser, Tank, Shooter, Exploder, Spiral Drifter, Shield Node, Hex Slicer, Prism Leech, Triad Splitter, Triad Fragment, and Hex Pulser.
- Boss dark bodies for Prism Warden, Null Octagon, Null Octagon Prime, and Fractal Crown.
- Weapon/projectile dark body pieces for the Blender weapon visuals, especially Fractal Shard, Gravity Well, and Shield Breaker.

Dark neon body materials added:

- Black/near-black body faces now regenerate as darker neon-tinted versions of the object family accent.
- Cyan/blue families use dark blue/cyan bodies.
- Magenta/violet families use dark purple/magenta bodies.
- Orange/gold families use dark amber/gold bodies.
- Green families use dark teal/green bodies.
- Red families use dark red bodies.
- Player uses a dark blue command-core body.
- Tinted secondary glass material was also raised into the matching dark neon family.

Slightly enlarged or reshaped:

- Visual-only mesh scale was applied in Blender/exported GLBs:
  - Player: `1.05x`
  - Standard enemies: `1.08x`
  - Chaser, Spiral Drifter, Triad Fragment: `1.12x`
  - Shooter, Exploder, Hex Slicer, Triad Splitter: `1.10x`
  - Bosses: `1.06x`
  - Weapon/projectile visuals: `1.06x` baseline, with small/fast weapons at `1.12x` and spear/mortar/breaker shapes at `1.08x`
- Collision, hit radius, enemy behavior, weapon damage, cooldowns, projectile caps, sector flow, and balance were not changed.

XP preserved:

- `art/xp/source/blender/xp_shard.blend` was not regenerated.
- `art/xp/exported/3d/xp_shard.glb` was not regenerated.
- The active runtime XP pickup remains the readable Blender 3D `XP` letter object.

Files changed:

- `art/player/source/blender/player_core.blend`
- `art/player/exported/3d/player_core.glb`
- `art/enemies/source/blender/*.blend`
- `art/enemies/exported/3d/*.glb`
- `art/bosses/source/blender/*.blend`
- `art/bosses/exported/3d/*.glb`
- `art/weapons/source/blender/*.blend`
- `art/weapons/exported/3d/*.glb`
- `art/weapons/icons/exported/*_icon_hd.png`
- `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
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

What the user should test visually:

- Check player, enemies, bosses, and weapon/projectile visuals against every current sector background.
- Confirm body faces read as dark neon-tinted material instead of black.
- Confirm XP still uses the approved Blender 3D `XP` letter pickup.
- Confirm objects are easier to find but not overbright or washed out.

Known issues:

- Blender background mode still prints a non-blocking PulseAudio wake warning.
- Blender still reports optional Draco compression missing; GLBs export and validate successfully without Draco.
- Final approval still depends on subjective visual review in the official playable build.

## Visual Tuning Hotfix — Richer Dark Neon Bodies, Popcorn Enemy Scale, XP Pulse Animation

This follow-up hotfix keeps the work in Phase 27 and changes only visual readability.

Richer dark body colors:

- The previous dark body materials were still too dull, so non-XP Blender gameplay assets were regenerated with richer neon-tinted body colors.
- Cyan/blue families received brighter deep blue/cyan bodies.
- Magenta/violet families received richer dark purple/magenta bodies.
- Orange/gold families received richer dark amber/gold bodies.
- Green families received richer dark teal/green bodies.
- Red families received clearer dark red bodies.
- Body colors remain darker than neon tube edges and white-hot cores.

Popcorn enemy scale:

- Runtime visual-only scale now gives regular non-boss enemies a larger readable size class.
- Chaser, Tank, Shooter, Exploder, Spiral Drifter, Shield Node, Hex Slicer, Prism Leech, Triad Splitter, and Hex Pulser clamp to at least `0.88` visual scale.
- Triad Fragment clamps to at least `0.68`, preserving its smaller fragment role while making it easier to see.
- Boss and mini-boss visual sizes were preserved.
- Collision, HP, speed, damage, XP value, sector pacing, and weapon behavior were not changed.

XP pulse animation:

- XP no longer rotates/spins in `_update_xp_orbs()`.
- XP keeps a stable readable orientation so the `XP` letters stay visible.
- Each XP pickup duplicates its StandardMaterial3D surfaces locally and pulses emission from `0.78x` to `1.0x`.
- The approved XP Blender source/export files were preserved unchanged:
  - `art/xp/source/blender/xp_shard.blend`
  - `art/xp/exported/3d/xp_shard.glb`

Files changed:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `art/player/source/blender/player_core.blend`
- `art/player/exported/3d/player_core.glb`
- `art/enemies/source/blender/*.blend`
- `art/enemies/exported/3d/*.glb`
- `art/bosses/source/blender/*.blend`
- `art/bosses/exported/3d/*.glb`
- `art/weapons/source/blender/*.blend`
- `art/weapons/exported/3d/*.glb`
- `art/weapons/icons/exported/*_icon_hd.png`
- `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
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

What the user should test visually:

- Confirm regular enemies are larger and easier to see.
- Confirm bosses and mini-bosses did not visually enlarge.
- Confirm dark faces look richer and more saturated without becoming brighter than the neon edges.
- Confirm XP letters stay readable and no longer spin.
- Confirm XP brightness pulses smoothly and does not overexpose.

Known issues:

- Blender background mode still prints a non-blocking PulseAudio wake warning.
- Blender still reports optional Draco compression missing; GLBs export and validate successfully without Draco.
- Final subjective approval still requires manual review in the official build.

## 11. Approval Question

Do you approve the Visual Tuning Hotfix as the active Phase 27 gameplay-object visual baseline, or should the next work remain a Phase 27-only visual repair focused on body color richness, popcorn enemy scale, or XP pulse readability?
