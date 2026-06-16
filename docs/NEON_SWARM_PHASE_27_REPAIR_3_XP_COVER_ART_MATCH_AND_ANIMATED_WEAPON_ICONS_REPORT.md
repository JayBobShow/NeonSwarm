# Neon Swarm Phase 27 Repair 3 XP Cover Art Match and Animated Weapon Icons Report

## 1. XP Cover-Art Match Changes

The active XP pickup remains a real Blender-made 3D object and was redesigned to better match the approved cover-art reward pickups.

Changed the existing XP model at:

- `art/xp/source/blender/xp_shard.blend`
- `art/xp/exported/3d/xp_shard.glb`

New XP visual direction:

- large readable 3D `XP` letters as the primary pickup silhouette,
- dark glass letter-depth body,
- cyan neon tube edge around the letter form,
- blue inner glass letter face,
- white readable front glyph layer,
- subtle collector halo behind the letters,
- subtle magenta reward arc,
- small blue side-depth facets.

This replaces the prior gold shard read and the rejected hex-token-first version while preserving the same runtime pickup path: `Blender3DXPPickupModel`.

## 2. XP Brightness Reduction

XP-specific material intensity was reduced by 50% from the previous Repair 2 pickup level.

Current XP-specific emission values:

- XP cyan: `2.65`
- XP white glyph: `2.50`
- XP blue glass: `1.85`
- XP magenta accent: `1.80`

The XP pickup still glows and remains readable, but should no longer blow out against the HD sector backgrounds.

## 3. Animated Weapon Icon System

Updated `scripts/ui/NeonWeaponIcon.gd`.

The shared weapon icon control now animates previews with:

- slow weapon-family-specific spin,
- subtle pulse,
- small looping energy arcs,
- unchanged rarity frame styling,
- unchanged source image mapping.

The animation uses the existing Blender-rendered weapon-family PNGs, which are derived from the actual Blender weapon models where practical.

## 4. Menus Using Animated Icons

Because current weapon UI surfaces use `NeonWeaponIcon`, the animation now applies to:

- Armory equipped weapon rows,
- Armory stash rows,
- Armory selected weapon preview,
- Armory comparison panel,
- generated weapon reward cards,
- reward replacement slot picker,
- reward comparison panel,
- level-up/generated weapon choice icons,
- How To Play weapon examples.

No menu layout or flow was redesigned.

## 5. How Icons Tie To Actual Weapon Visuals

Active weapon preview flow:

- Blender source models: `art/weapons/source/blender/*.blend`
- Runtime weapon models: `art/weapons/exported/3d/*.glb`
- Blender-rendered icon sources: `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
- UI icon exports: `art/weapons/icons/exported/*_icon_hd.png`
- UI control: `scripts/ui/NeonWeaponIcon.gd`

The icons are still family-level previews, not separate art for every random weapon instance.

## 6. Files Changed

Code:

- `scripts/ui/NeonWeaponIcon.gd`
- `scripts/NeonSwarm3DGameplayPrototype.gd`

Regenerated existing assets:

- `art/xp/source/blender/xp_shard.blend`
- `art/xp/exported/3d/xp_shard.glb`
- `art/weapons/icons/source/rendered_from_3d/*.png`
- `art/weapons/icons/exported/*_icon_hd.png`

Docs:

- `docs/NEON_SWARM_PHASE_27_REPAIR_3_XP_COVER_ART_MATCH_AND_ANIMATED_WEAPON_ICONS_REPORT.md`
- `docs/NEON_SWARM_PHASE_27_REPAIR_2_READABILITY_XP_WEAPON_RENDER_PASS_REPORT.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `art/xp/source/blender/xp_blender_pipeline_notes.md`

Validation helper:

- `/tmp/neon_swarm_phase27_blender/phase27_repair3_icon_validation.gd`

## 7. Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_repair3_icon_validation.gd
```

Validation confirmed:

- official scene launches,
- long headless stress exits cleanly,
- XP Blender GLB loads through the existing XP pickup path,
- weapon-family icon exports exist,
- Blender-rendered icon source files exist,
- matching weapon-family GLBs exist,
- `NeonWeaponIcon` animation processing is enabled,
- no missing asset/import/runtime errors appeared in the validation output.

## 8. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 9. What I Should Test Visually

- Kill enemies and confirm XP pickups read as large cyan/white `XP` letter pickups.
- Confirm XP still glows without looking blown out.
- Open Armory and confirm equipped/stash weapon icons animate subtly.
- Open generated weapon reward cards and replacement UI; confirm weapon icons animate there too.
- Open How To Play and confirm weapon example icons animate.
- Confirm icons still match the actual weapon family they represent.
- Confirm controller/keyboard menu navigation is unchanged.

## 10. Known Issues

- Animated UI previews are 2D animated renders from Blender weapon models, not embedded real-time 3D viewport controls.
- The unknown fallback icon remains static/fallback-style and is not final art.
- Blender still reports non-blocking PulseAudio and optional Draco warnings during export.
- Final subjective XP cover-art match should be reviewed in the playable build.

## Repair 3 Hotfix — XP Letter Pickup and Larger Weapon Icon Cells

### 1. XP was changed from hex token to readable 3D XP letters

The rejected cyan/blue hex-token-first XP pickup was replaced with a letter-first Blender object. The active source/export paths are:

- `art/xp/source/blender/xp_shard.blend`
- `art/xp/exported/3d/xp_shard.glb`

The GLB now contains `XPLettersDarkGlassDepthBody`, `XPLettersCyanNeonTubeEdge`, `XPLettersBlueInnerGlassFace`, and `XPLettersWhiteReadableFrontGlyph` as the main pickup meshes. The active runtime XP pickup still loads this GLB through `Blender3DXPPickupModel`.

### 2. XP brightness/intensity setting

XP remains at the post-brightness-hotfix half-intensity material values:

- dark blue letter-depth body: base color `(0.018, 0.080, 0.240, 1.0)`, emission `0.24`
- cyan neon letter edge: `2.65`
- white readable glyph: `2.50`
- blue glass letter face: `1.85`
- magenta reward arc: `1.80`

The intent is readable collectible glow without the overexposed Repair 2 brightness. The dark/base side is now deep blue rather than black, so it should separate better from the arena while preserving depth.

### 3. Icon cell sizes changed

The shared animated icon control now defaults to `48x48` instead of `36x36`, and rendered weapon art uses a smaller internal inset so the preview fills more of the cell.

Menu-specific cell increases:

- Armory equipped/stash rows: `30x30` to `42x42`
- Armory selected weapon preview: `78x78` to `96x96`
- Armory comparison icons: `54x54` to `68x68`
- How To Play examples: `54x54` to `74x74`
- Level-up/generated weapon choice icons: `42x42` to `54x54`
- Weapon reward preview: `64x64` to `82x82`
- Weapon reward comparison icons: `52x52` to `68x68`
- Replacement slot picker icons: `34x34` to `46x46`

Supporting row/panel heights were adjusted where needed so the larger previews do not crush the surrounding text.

### 4. Which menus were updated

Updated icon sizing applies to:

- Armory equipped list
- Armory stash list
- Armory selected weapon preview
- Armory comparison panel
- sector/generated weapon reward cards
- reward replacement slot picker
- reward comparison panel
- level-up/generated weapon icon area
- How To Play weapon pages

### 5. Validation results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_blender_asset_validation.gd
godot --headless --path . --script /tmp/neon_swarm_phase27_blender/phase27_repair3_icon_validation.gd
```

Additional check: `strings art/xp/exported/3d/xp_shard.glb | rg "XPLetters|XPCoverArt"` confirmed the runtime XP GLB contains the `XPLetters...` meshes and no longer exposes the rejected `XPCoverArt...` token mesh names.

### 6. Exact run command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

### 7. What I should test visually

- Kill enemies and confirm XP pickups read as the letters `XP` at gameplay distance.
- Confirm XP is bright enough to collect but no longer blown out.
- Open Armory and confirm equipped/stash icons are larger and animated.
- Open reward cards, replacement UI, comparison panels, level-up weapon choices, and How To Play weapon pages; confirm previews are large enough to identify without squinting.
- Confirm controller/keyboard selection remains stable in every updated menu.

## 11. Approval Question

Do you approve Phase 27 Repair 3 as the active XP pickup and animated weapon icon baseline, or should the next work remain a Phase 27-only visual repair focused on XP/token/icon presentation?
