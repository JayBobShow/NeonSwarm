# Neon Swarm Phase 10 HUD Blueprint, Menu, and Shape Audit Report

## 1. Executive Summary

Phase 10 updated the official build only: `scenes/Main.tscn`.

The rejected HUD direction was replaced with the requested exact 1920x1080 blueprint structure:

- Top-left core vitals wedge
- Top-right run telemetry wedge
- Bottom-center loadout chip rail
- Top-center boss/alert rail
- Center holographic command plates for pause, death, and sector clear
- Title/main menu foundation integrated into the official launch flow

No alternate playable scene was created. The official launch flow is now:

`project.godot` / `scenes/Main.tscn` -> title menu -> Start Game -> gameplay.

Approval status: Phase 10 is not fully approved until the title screen is visually approved by the user.

## 2. Exact HUD Blueprint Implemented

| Blueprint Item | Implementation Status | Notes |
| --- | --- | --- |
| A. Top-left core vitals wedge | Implemented | Design rect `24, 28, 360, 132`; angular left wedge; dark glass; cyan/magenta neon frame; compact level, title, health, XP. |
| B. Top-right run telemetry wedge | Implemented | Design rect `1536, 28, 360, 132`; angular right wedge; largest timer; right-aligned kills, score, hostiles, audio. |
| C. Bottom-center loadout chip rail | Implemented | Design rect `420, 980, 1080, 72`; replaces bottom-left debug block; eight chip modules: DMG, RATE, SPD, PICKUP, ORBIT, LANCE, SAW, MINE. |
| D. Boss bar / alert rail | Implemented | Design rect `560, 24, 800, 48`; hidden until warning/boss; slim segmented rail; warning pulse before Prism Warden. |
| E. Center holographic command plate | Implemented | Design rect `660, 410, 600, 210`; used for pause, death, and sector cleared prompts. |
| F. Title / main menu foundation | Implemented | Cover art background from `art/branding/neonswarm_cover.png`; custom neon-glass menu panel; Start Game, Options, Quit. |

All Phase 10 HUD panels are placed inside a 1920x1080 design root that scales to the current viewport, keeping the exact blueprint positions stable at design scale while adapting to other resolutions.

## 3. Tool Usage: Inkscape/Krita/Blender/Godot

| Tool | Used | Result |
| --- | --- | --- |
| Inkscape | Yes | Created `art/ui/source/phase10_hud_frame_atlas.svg`, `art/ui/source/phase10_chip_icons.svg`, and exported runtime PNG assets in `art/ui/`. |
| Krita | No | Not needed for this pass; the Godot draw code and Inkscape source provided the requested glass/tube HUD direction. |
| Blender | No | Not needed; no specialty 3D emblem render was required. |
| Godot | Yes | Integrated the menu flow, reusable UI scripts, segmented gauges, chip rail, command plates, and validation. |

## 4. HUD Architecture Changes

The HUD was moved away from one-off plain panel construction into reusable UI components:

- `scripts/ui/NeonFramePanel.gd`: reusable angular frame renderer for wedges, rails, command plates, menu panels, and chips.
- `scripts/ui/NeonStatChip.gd`: reusable chip module with icon, stat label, and value.
- `scripts/ui/NeonMenuButton.gd`: custom neon menu button with focus state and selected-state rendering.
- `scripts/ui/NeonSegmentGauge.gd`: updated to draw segmented neon bars instead of a continuous flat fill.
- `art/ui/phase10_chip_icons.png`: integrated into `NeonStatChip` as the runtime icon atlas for chip rail symbols.
- `scripts/NeonSwarm3DGameplayPrototype.gd`: now builds the official HUD from reusable components on a 1920x1080 design root.

The old lower-left paragraph readout was removed from the active HUD. Loadout/weapon data now lives in the bottom-center chip rail.

## 5. Title/Menu Flow

The title menu is part of the official `scenes/Main.tscn` flow.

Menu items:

- START GAME
- OPTIONS
- QUIT

Input support:

- Keyboard up/down navigation
- Controller d-pad / stick navigation
- Enter / Space / controller A selection
- Esc / controller B backs out of Options where appropriate

Options is a foundation placeholder and currently exposes the existing audio/HUD preset state instead of a full options screen.

## Menu Hotfix — Title Screen Composition and Ship Cursor

### 1. What Was Wrong Visually

The first Phase 10 title screen used the portrait cover art as a full-screen `KEEP_ASPECT_COVERED` texture. On a 1920x1080 screen that forced a large vertical crop, which cut the logo/title area badly and made the cover feel like a background crop instead of the official key art. The menu panel was also too large, too high, and too detached from the image composition.

### 2. How Cover Art Centering Was Fixed

The title screen now uses two cover layers:

- A darkened full-screen atmosphere layer using `STRETCH_KEEP_ASPECT_COVERED`.
- A centered readable cover layer using `STRETCH_KEEP_ASPECT_CENTERED`.

The centered cover layer preserves the original portrait aspect ratio, keeps the `NEON SWARM` branding readable, keeps the central action visible, and avoids destructive edits to `art/branding/neonswarm_cover.png`.

### 3. How Blur / Import / Scaling Was Fixed

The cover import settings were inspected:

- Source image: `1055x1491` PNG.
- Import mode: texture, no size limit, no mipmaps, no lossy scaled copy.

The blur issue came from composition/scaling, not a destructive asset copy. The readable foreground cover now scales down into the 1920x1080 design frame instead of being enlarged/cropped to fill 16:9. Both cover `TextureRect` layers use explicit `CanvasItem.TEXTURE_FILTER_LINEAR`; the full-screen layer is darkened atmospheric support, while the contained foreground layer is the sharp readable title art.

### 4. How Menu Composition Was Improved

The title menu panel was reduced and later moved into the left-side composition zone, docked below the centered cover logo instead of covering the main logo/title area. A subtle vignette/composition rail overlay now frames the centered cover and visually ties the menu panel into the cover art direction.

The panel now reads as a compact command module:

- RUN CONTROL
- OFFICIAL BUILD // MAIN.TSCN
- NEON-GLASS START VECTOR
- START GAME
- OPTIONS
- QUIT

### 5. How Ship/Core Cursor Was Implemented

Added `scripts/ui/NeonSelectionCursor.gd`.

The cursor is a small drawn Neon Swarm ship/core icon:

- Cyan/magenta neon tube outline.
- Diamond core.
- Points toward the selected option.
- Pulses subtly.
- Tracks the focused menu button.

Keyboard and controller navigation both update `_title_menu_selected_index`, focus the selected `NeonMenuButton`, and move the cursor beside the active option. The active button also renders with a brighter border/glow and sharper selected text.

### 6. Files Changed

Hotfix code:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonMenuButton.gd`
- `scripts/ui/NeonSelectionCursor.gd`
- `scripts/ui/NeonTitleVignette.gd`

Documentation:

- `docs/NEON_SWARM_PHASE_10_HUD_BLUEPRINT_MENU_SHAPE_AUDIT_REPORT.md`

### 7. Validation Results

Required launch validation:

- `godot --headless --path . --quit-after 3` -> PASS
- `godot --headless --path . scenes/Main.tscn --quit-after 3` -> PASS

Menu hotfix validation:

Command:

`timeout 35s godot --headless --path . --script /tmp/neon_swarm_phase10_menu_hotfix_validation.gd`

Result:

`PHASE10_MENU_HOTFIX_VALIDATION_PASS`

Covered:

- Official build launches into title/menu.
- Title/menu pauses gameplay on launch.
- Centered cover layer exists.
- Cover art uses centered aspect-preserving layout.
- Cover art uses explicit UI filtering.
- Darkened full-screen cover background exists.
- Background cover fills screen separately from readable cover.
- Ship/core cursor exists and is visible.
- Menu keeps three commands.
- Keyboard navigation moves selection and cursor.
- Controller navigation moves selection and cursor.
- Start Game enters gameplay.
- Gameplay HUD still works.
- Pause/death/success overlays still work.

Visual capture:

Command:

`timeout 20s godot --path . --script /tmp/neon_swarm_phase10_capture.gd`

Result:

`PHASE10_CAPTURE_PASS`

Reviewed:

- `/tmp/neon_swarm_phase10_menu.png`
- `/tmp/neon_swarm_phase10_gameplay.png`
- `/tmp/neon_swarm_phase10_success.png`

### 8. Exact Run Command

`godot --path . scenes/Main.tscn`

### 9. What the User Should Review

The title screen still requires user visual approval. Review:

- Whether the centered portrait cover placement is the approved composition.
- Whether the left-shifted menu panel feels integrated enough.
- Whether the ship/core cursor has the right size, brightness, and movement.
- Whether the panel should move slightly farther left/right/up/down after visual review.
- Whether the centered cover should be framed more aggressively or left clean.

## Menu Hotfix 2 — Left Shifted Menu Composition

### What Was Wrong

The first menu hotfix preserved the cover art correctly, but the command panel still sat too far right in the 1920x1080 title composition. It visually collided with the `NEON SWARM` title/logo area and made the menu feel like it was floating over the key art instead of sitting in a deliberate composition zone.

### Exact Reposition Change

The title command panel was moved from:

`Rect2(1238, 564, 506, 398)`

to:

`Rect2(176, 576, 506, 398)`

The panel is now left-shifted and sits below the main title/logo band, keeping the `NEON SWARM` letters readable while preserving the centered cover art layer.

### Cursor Left-Side Adjustment

The ship/core selection cursor remains on the left side of the active option. Its horizontal offset was pushed farther left:

`-64 px` -> `-88 px`

This gives the cursor more breathing room so it reads as a separate ship/core selector and does not crowd the button border.

### Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_10_HUD_BLUEPRINT_MENU_SHAPE_AUDIT_REPORT.md`

### Validation Results

Required launch validation:

- `godot --headless --path . --quit-after 3` -> PASS
- `godot --headless --path . scenes/Main.tscn --quit-after 3` -> PASS

Menu Hotfix 2 validation:

Command:

`timeout 35s godot --headless --path . --script /tmp/neon_swarm_phase10_menu_hotfix2_validation.gd`

Result:

`PHASE10_MENU_HOTFIX2_VALIDATION_PASS`

Covered:

- Official build launches into title/menu.
- Left-shifted menu command panel exists.
- Menu panel is left-shifted away from the `NEON SWARM` logo.
- Menu panel remains below the title/logo band.
- Centered cover layer still exists.
- Cover art remains aspect-centered.
- Ship/core cursor exists and is visible.
- Menu keeps `START GAME`, `OPTIONS`, `QUIT`.
- Cursor sits clearly left of the selected option.
- Keyboard navigation moves selection and cursor.
- Controller navigation moves selection and cursor.
- Start Game enters gameplay.
- Gameplay HUD still appears.

Regression validation:

- `timeout 35s godot --headless --path . --script /tmp/neon_swarm_phase10_validation.gd` -> `PHASE10_VALIDATION_PASS`
- `timeout 45s godot --headless --path . --script /tmp/neon_swarm_phase10_stress.gd` -> `PHASE10_STRESS_PASS`
- `timeout 20s godot --path . --script /tmp/neon_swarm_phase10_capture.gd` -> `PHASE10_CAPTURE_PASS`

Visual capture reviewed:

- `/tmp/neon_swarm_phase10_menu.png`

### What I Should Review

- Whether the left-side menu placement is now far enough from the logo.
- Whether the panel should move slightly farther left, right, up, or down.
- Whether the cursor offset feels readable without feeling disconnected from the selected option.
- Whether the cover art still feels like the hero element behind the menu.

## Menu Hotfix 3 — Final Title Screen Composition Polish

### 1. What Was Improved

The title menu was polished to read less like a UI box on top of cover art and more like an integrated game start screen. The cover/logo remains the hero, the menu stays in the left-side clean zone, the menu hierarchy now prioritizes `START GAME`, and the panel/button treatment has more neon-glass depth without adding visual clutter.

### 2. Final Menu Position

Final title command panel position:

`Rect2(150, 620, 520, 340)`

This keeps the menu below the `NEON SWARM` logo/title band, avoids covering the logo letters, preserves the cube/core as a hero visual, and leaves breathing room around the left-side panel.

### 3. Cover Art Scaling / Cropping Settings

The original cover art was not destructively modified.

Current title art layers:

- Atmosphere/background layer: `STRETCH_KEEP_ASPECT_COVERED`, darkened duplicate for full-screen mood.
- Main readable cover layer: `STRETCH_KEEP_ASPECT_CENTERED`, `CanvasItem.TEXTURE_FILTER_LINEAR`, `modulate.a = 0.98`.

The main cover layer stays sharp, centered, and aspect-preserved. The title/logo is not stretched and is not cropped awkwardly.

### 4. Cursor Behavior

The ship/core cursor remains a custom `NeonSelectionCursor`:

- Appears to the left of the active option.
- Points toward the selected option.
- Uses cyan/magenta neon tube edges and a diamond core.
- Pulses subtly.
- Moves with keyboard and controller selection.
- Keeps a clear gap from the selected button border.

### 5. Button Polish

The menu buttons now use:

- Angular neon frames.
- Dimmer unselected state.
- Brighter selected border/glow.
- Subtle selected-state pulse.
- Center-aligned text.
- Increased button height and padding.
- Consistent spacing.

The small build/status label was moved below the commands so it does not compete with the cover logo or the `START GAME` action.

### 6. Options Placeholder Behavior

Selecting `OPTIONS` now opens a clean small command-plate overlay:

`OPTIONS COMING SOON`

Controls:

- `A / Enter` closes it.
- `B / Esc` closes it.
- It does not start gameplay while open.
- It uses the same neon command-plate language as the rest of the title UI.

Options overlay rect:

`Rect2(186, 730, 448, 126)`

### 7. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonFramePanel.gd`
- `scripts/ui/NeonMenuButton.gd`
- `docs/NEON_SWARM_PHASE_10_HUD_BLUEPRINT_MENU_SHAPE_AUDIT_REPORT.md`

### 8. Validation Results

Required launch validation:

- `godot --headless --path . --quit-after 3` -> PASS
- `godot --headless --path . scenes/Main.tscn --quit-after 3` -> PASS

Menu Hotfix 3 validation:

Command:

`timeout 35s godot --headless --path . --script /tmp/neon_swarm_phase10_menu_hotfix3_validation.gd`

Result:

`PHASE10_MENU_HOTFIX3_VALIDATION_PASS`

Covered:

- Official build launches into title/menu.
- Final menu command panel exists at the left-side clean zone.
- Cover art remains centered without stretching.
- Main cover layer remains bright/readable.
- Ship/core cursor exists and stays left of the selected option.
- Keyboard navigation moves selection and cursor.
- Controller navigation moves selection and cursor.
- Options placeholder opens.
- `Enter/A` closes Options.
- `Esc/B` closes Options.
- Start Game enters gameplay.
- HUD loads after Start Game.
- Pause/death/success overlays still work.

Quit smoke check:

`timeout 10s godot --headless --path . --script /tmp/neon_swarm_phase10_menu_quit_validation.gd` -> PASS

Regression validation:

- `timeout 35s godot --headless --path . --script /tmp/neon_swarm_phase10_validation.gd` -> `PHASE10_VALIDATION_PASS`
- `timeout 45s godot --headless --path . --script /tmp/neon_swarm_phase10_stress.gd` -> `PHASE10_STRESS_PASS`
- `timeout 20s godot --path . --script /tmp/neon_swarm_phase10_capture.gd` -> `PHASE10_CAPTURE_PASS`
- `timeout 20s godot --path . --script /tmp/neon_swarm_phase10_hotfix3_options_capture.gd` -> `PHASE10_HOTFIX3_OPTIONS_CAPTURE_PASS`

### 9. What I Should Review

- Whether the final left menu position feels approved.
- Whether the panel glass/depth treatment is premium enough without being busy.
- Whether the selected button glow has the right intensity.
- Whether the ship/core cursor size and offset feel right.
- Whether the Options Coming Soon plate is acceptable as a temporary placeholder.

## 6. Geometry Shape Audit Summary

Created:

`docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

The audit lists the required player, enemy, pickup, weapon/projectile, VFX, HUD, and menu motifs with:

- Asset/game object
- Gameplay role
- Current geometry shape
- Current readability
- Keep / revise / replace recommendation
- Notes

Summary of recommendations:

- Keep current identity for player, Chaser, Tank, Shooter, Exploder, Spiral Drifter, Shield Node, Prism Warden, XP pickup, Orbit Spark, Nova Burst, Arc Beam, Gravity Mine, Ring Saw, major VFX, HUD motifs, and menu motifs.
- Revise Pulse Blaster projectile later so it becomes less generic and more player-owned/faceted.
- Revise Prism Lance later so the shape better matches the prism name.
- Watch repeated hex and torus usage so future objects do not collapse into the same silhouette family.

## 7. Files Changed

Core official build script:

- `scripts/NeonSwarm3DGameplayPrototype.gd`

Reusable UI scripts:

- `scripts/ui/NeonFramePanel.gd`
- `scripts/ui/NeonStatChip.gd`
- `scripts/ui/NeonMenuButton.gd`
- `scripts/ui/NeonSelectionCursor.gd`
- `scripts/ui/NeonTitleVignette.gd`
- `scripts/ui/NeonSegmentGauge.gd`

UI art/source assets:

- `art/ui/source/phase10_hud_frame_atlas.svg`
- `art/ui/phase10_hud_frame_atlas.png`
- `art/ui/source/phase10_chip_icons.svg`
- `art/ui/phase10_chip_icons.png`

Documentation:

- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `docs/NEON_SWARM_PHASE_10_HUD_BLUEPRINT_MENU_SHAPE_AUDIT_REPORT.md`

## 8. Validation Results

Required official launch commands:

| Command | Result |
| --- | --- |
| `godot --headless --path . --quit-after 3` | PASS |
| `godot --headless --path . --quit-after 3000` | PASS |
| `godot --headless --path . scenes/Main.tscn --quit-after 3` | PASS |

Phase 10 smoke validation:

Command:

`timeout 35s godot --headless --path . --script /tmp/neon_swarm_phase10_validation.gd`

Result:

`PHASE10_VALIDATION_PASS`

Covered:

- Official flow starts in title/menu
- Title/menu pauses gameplay
- Menu panel visible
- Gameplay HUD hidden behind menu
- Menu has three commands
- Keyboard navigation works
- Options placeholder opens
- Cancel closes Options
- Controller d-pad navigation works
- Controller A starts game
- Start Game unpauses gameplay
- HUD appears after start
- Bottom chip rail has eight chips
- Gameplay simulation advances
- XP pickup can spawn
- Level-up overlay opens and closes
- Pause command plate appears and hides
- Boss warning rail appears
- Boss health rail appears
- Boss segmented bar appears
- Death state activates
- Death command plate appears
- Success state activates
- Success command plate appears

Stress validation:

Command:

`timeout 45s godot --headless --path . --script /tmp/neon_swarm_phase10_stress.gd`

Result:

`PHASE10_STRESS_PASS`

Stress summaries reached:

- `time=12.0 wave=IGNITION enemies=5/54 xp=17/100 player_projectiles=2/36 enemy_projectiles=0/28 mines=1/6 beams=2/8 bursts=6/18 kills=17 score=670 mini_boss_active=false`
- `time=22.0 wave=IGNITION enemies=2/54 xp=29/100 player_projectiles=2/36 enemy_projectiles=0/28 mines=1/6 beams=0/8 bursts=3/18 kills=29 score=1165 mini_boss_active=false`

Render capture validation:

Command:

`timeout 20s godot --path . --script /tmp/neon_swarm_phase10_capture.gd`

Result:

`PHASE10_CAPTURE_PASS`

Screenshots reviewed:

- `/tmp/neon_swarm_phase10_menu.png`
- `/tmp/neon_swarm_phase10_gameplay.png`
- `/tmp/neon_swarm_phase10_boss_warning.png`
- `/tmp/neon_swarm_phase10_success.png`

Visual checks:

- Menu loads first and uses the cover art mood.
- Start/menu panel uses custom neon-glass art, not default Godot buttons.
- Top-left and top-right HUD wedges align to the arena frame.
- Bottom chip rail replaces the old bottom-left debug text block.
- Bottom chip rail renders the integrated Inkscape-exported icon atlas.
- Center gameplay area is clearer than the rejected HUD.
- Boss rail is slim and top-centered.
- Success command plate is smaller and matches the HUD frame language.

## 9. Exact Run Command

Run the official build with:

`godot --path . scenes/Main.tscn`

The project main scene also points to:

`res://scenes/Main.tscn`

## 10. What I Should Review Manually

Review these in the running build:

- Whether the title menu panel position over the cover art feels approved.
- Whether the hotfixed centered cover and ship/core cursor are visually approved.
- Whether the top-left/top-right wedges are the right size at your target resolution.
- Whether the bottom chip rail is low enough for combat readability without feeling detached.
- Whether the center command plate is the right amount of visual weight.
- Whether the boss warning rail should use `WARNING: PRISM WARDEN INBOUND` or the shorter `PRISM WARDEN` label during the warning window.
- Whether the Options placeholder should remain in Phase 10 or be promoted into a real settings screen in a later approved pass.

## 11. Known Issues

- Options is intentionally still a placeholder foundation.
- Phase 10 is not fully approved until the user visually approves the title screen hotfix.
- The existing level-up choice panel still uses the prior neon panel component. It passed open/close validation, but it was not rebuilt as part of the exact Phase 10 HUD blueprint.
- The normal renderer screenshot capture completed successfully, but Godot emitted an `ObjectDB instances leaked at exit` warning after `PHASE10_CAPTURE_PASS`. The required headless launch commands, smoke validation, and stress validation all exited cleanly.

## 12. Approval Question

Do not mark Phase 10 approved yet. Visual approval is still required for the title screen hotfix.
