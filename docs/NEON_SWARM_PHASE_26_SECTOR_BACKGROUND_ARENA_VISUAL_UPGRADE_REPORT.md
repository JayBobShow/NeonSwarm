# Neon Swarm Phase 26 Sector Background / Arena Visual Upgrade Report

## 1. Executive Summary

Phase 26 is still an active-development visual phase for the official build only: `scenes/Main.tscn`.

The previous procedural background direction was rejected. The hard reset replaces the active sector background presentation with HD sector art plates created through an Inkscape -> Krita-ready ORA -> Krita-exported PNG pipeline. Godot now loads those 4096x4096 PNGs directly as sector background plates and only adds a sparse, sector-authored light-runner layer on top.

No gameplay content, combat balance, HUD/menu redesign, weapons, enemies, or bosses were changed.

## 2. Approved Phase 25 Baseline Preserved

Preserved:

- Title screen
- How To Play
- Armory
- Options
- Pause menu
- HUD
- Audio/mute/settings
- Controller and keyboard support
- XP and level-ups
- Sector rewards
- Generated weapon rewards and replacement UI
- Runtime weapon loadouts
- Stash backend
- Bosses and sector flow
- RUN COMPLETE / death / restart
- Weapon icon / preview pipeline
- Neon tube edge style

## 3. Sector 1 Visual Upgrade

Sector 1: Neon Grid uses the new HD art plate:

- `art/sectors/exported/sector_1_neon_grid_hd.png`

Design:

- Square / rectangle arcade floor composition.
- Cyan / blue palette.
- Connected rectangular circuit loops.
- Clean classic neon grid depth.
- Light runners move through square/circuit routes.

## 4. Sector 2 Visual Upgrade

Sector 2: Prism Rift uses the new HD art plate:

- `art/sectors/exported/sector_2_prism_rift_hd.png`

Design:

- Diamond / triangle prism lattice.
- Magenta / purple / cyan palette.
- Fractured but intentional connected routes.
- Angled prism paths for light runners.

## 5. Sector 3 Visual Upgrade

Sector 3: Null Zone uses the new HD art plate:

- `art/sectors/exported/sector_3_null_zone_hd.png`

Design:

- Octagon / hex / dark polygon composition.
- Black-glass void-floor look.
- Purple / cyan edge-light palette.
- Slow ominous light flow around polygon routes.

## 6. Sector 4 Visual Upgrade

Sector 4: Hyper Grid uses the new HD art plate:

- `art/sectors/exported/sector_4_hyper_grid_hd.png`

Design:

- Stretched diamond / rail hyperlane composition.
- Cyan / white / electric blue palette.
- Fast highway/tunnel floor read.
- Fast light runners move backward through rail lanes.

## 7. Sector Transition Effects

The capped scanline sector transition remains:

- `SectorTransitionScanlineRoot`

It does not replace the new HD background plates and does not alter reward flow, sector flow, or gameplay timing.

## 8. Geometry Shape Updates

Updated:

- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

Hard reset geometry compliance:

- Sector 1: square / rectangle.
- Sector 2: diamond / triangle / prism.
- Sector 3: octagon / hex / dark polygon.
- Sector 4: stretched diamond / rail / arrow.

The new art plates are the background identity source. The old procedural floor fragments are not spawned by the active sector background builders.

## 9. Art/Tool Usage

Inkscape was used for vector source design and 4096x4096 vector-render exports.

Krita was used through CLI export from Krita-ready OpenRaster sources into the final PNG assets.

Krita automation note:

- The pipeline creates layered `.ora` files that open in Krita.
- The ORA files contain the Inkscape vector plate, a glow polish layer, and a depth/readability vignette layer.
- Krita CLI flattened/exported the ORA sources into final PNG files.
- No manual Krita brush painting was performed in this automated pass; final hand-painted/polished HD environment art remains future work.

## 10. Performance Results

Performance safety choices:

- Four 4096x4096 PNG sector plates are loaded only for the active sector.
- No unbounded particles were added.
- Old procedural floor-grid fragments are not spawned.
- `_sector_pulse_nodes` and `_sector_sweep_nodes` remain empty for active hard-reset backgrounds.
- HD background opacity is capped and responds to VFX intensity.
- The animated layer is limited to sparse named `HDLightRunner_*` tubes.

## 11. Files Changed

Code:

- `scripts/NeonSwarm3DGameplayPrototype.gd`

Inkscape source files:

- `art/sectors/source/inkscape/sector_1_neon_grid.svg`
- `art/sectors/source/inkscape/sector_2_prism_rift.svg`
- `art/sectors/source/inkscape/sector_3_null_zone.svg`
- `art/sectors/source/inkscape/sector_4_hyper_grid.svg`

Krita-ready source files:

- `art/sectors/source/krita/sector_1_neon_grid_krita_ready.ora`
- `art/sectors/source/krita/sector_2_prism_rift_krita_ready.ora`
- `art/sectors/source/krita/sector_3_null_zone_krita_ready.ora`
- `art/sectors/source/krita/sector_4_hyper_grid_krita_ready.ora`

Exported HD PNG assets:

- `art/sectors/exported/sector_1_neon_grid_hd.png`
- `art/sectors/exported/sector_2_prism_rift_hd.png`
- `art/sectors/exported/sector_3_null_zone_hd.png`
- `art/sectors/exported/sector_4_hyper_grid_hd.png`

Docs/source notes:

- `docs/NEON_SWARM_PHASE_26_SECTOR_BACKGROUND_ARENA_VISUAL_UPGRADE_REPORT.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `art/sectors/source/phase26_sector_background_pipeline_notes.md`

## 12. Validation Results

Required commands:

- PASS: `godot --headless --path . --quit-after 3`
- PASS: `godot --headless --path . --quit-after 3000`
- PASS: `godot --headless --path . scenes/Main.tscn --quit-after 3`

Additional hard-reset validation:

- PASS: `/tmp/neon_swarm_phase26_hard_reset_validation.gd`

Focused validation confirmed:

- All four final HD PNG assets exist.
- All four Inkscape SVG source files exist.
- All four Krita-ready ORA source files exist.
- Final PNGs load through `Image.load_from_file()`.
- Final PNGs are 4096x4096.
- Each sector builds an `HDArtSectorBackgroundPlate_*`.
- Each sector builds sector-specific `HDLightRunner_*` nodes.
- Old procedural floor fragments are not spawned.
- Legacy loose geometry overlay root remains empty.
- VFX intensity affects HD background opacity.
- Title, Armory, and How To Play roots still load.

## Phase 26 Hard Reset — Complete HD Sector Background Redesign

### 1. Why Repair 3 was rejected

Repair 3 still looked like programmer art: random-looking neon lines over a flat board, not a polished HD sector environment. The direction did not feel visually appealing enough and still resembled the earlier procedural background revamps.

### 2. What old background system was removed/disabled

Disabled from the active background path:

- `_build_sector_arena_floor()` calls.
- Sector-specific procedural floor builders for active background generation.
- Legacy loose sector marker overlays.
- Old procedural fragments such as `NeonGridSquareRow`, `PrismRiftDiamondCell`, `NullZoneOctagonCell`, and `HyperGridRailLane`.
- Random ring/glyph/sweep/floating-clutter arrays for active backgrounds.

The helper functions remain in the script as inert utilities, but the active sector background path now uses HD art plates plus sparse HD light runners.

### 3. Inkscape files created

- `art/sectors/source/inkscape/sector_1_neon_grid.svg`
- `art/sectors/source/inkscape/sector_2_prism_rift.svg`
- `art/sectors/source/inkscape/sector_3_null_zone.svg`
- `art/sectors/source/inkscape/sector_4_hyper_grid.svg`

### 4. Krita files or Krita-ready assets created

- `art/sectors/source/krita/sector_1_neon_grid_krita_ready.ora`
- `art/sectors/source/krita/sector_2_prism_rift_krita_ready.ora`
- `art/sectors/source/krita/sector_3_null_zone_krita_ready.ora`
- `art/sectors/source/krita/sector_4_hyper_grid_krita_ready.ora`

Each ORA source contains layered raster data for Krita: vector plate, glow polish, and depth/readability vignette.

### 5. Exported HD PNG assets

- `art/sectors/exported/sector_1_neon_grid_hd.png`
- `art/sectors/exported/sector_2_prism_rift_hd.png`
- `art/sectors/exported/sector_3_null_zone_hd.png`
- `art/sectors/exported/sector_4_hyper_grid_hd.png`

All four are 4096x4096 RGBA PNGs.

### 6. Sector 1 final background design

Neon Grid:

- Square/rectangle HD arena plate.
- Cyan/blue grid and circuit hierarchy.
- Clean connected paths.
- Sparse square-path light runners.

### 7. Sector 2 final background design

Prism Rift:

- Diamond/triangle prism HD arena plate.
- Magenta/purple/cyan fractured route language.
- Connected angular paths.
- Prism route light runners.

### 8. Sector 3 final background design

Null Zone:

- Octagon/hex black-glass HD arena plate.
- Darker void-floor composition.
- Slow polygon-edge light runners.
- Controlled ominous contrast.

### 9. Sector 4 final background design

Hyper Grid:

- Rail/stretched-diamond HD arena plate.
- Cyan/white/electric-blue high-speed floor.
- Fast lane light runners.
- Strongest backward motion identity.

### 10. Geometry tree compliance

The background assets follow the shape tree:

- Neon Grid: square / rectangle.
- Prism Rift: diamond / triangle / prism.
- Null Zone: octagon / hex / dark polygon.
- Hyper Grid: stretched diamond / rail / arrow.

No sector uses unrelated random shapes as its identity source.

### 11. Animation/light-runner integration

Godot integration:

- `_sector_hd_background_design()` maps each sector to its PNG asset and runner routes.
- `_build_hd_sector_background()` creates the HD art plate.
- `_add_hd_background_light_runner()` creates sparse named runner segments.
- `_update_sector_background_motion()` animates the runner segments and capped opacity reaction.

### 12. Readability safeguards

Safeguards:

- HD background opacity is capped.
- VFX intensity affects background opacity.
- Light runner count is low and sector-authored.
- No random particles were added.
- Background plate sits below gameplay.
- Player, enemies, XP, bullets, boss attacks, HUD, reward panels, and menus remain above the background.

### 13. Performance validation

Performance validation passed:

- Short headless launch passed.
- 3000-frame headless stress passed.
- Official scene headless launch passed.
- Focused HD background asset/integration validation passed.

### 14. Files changed

See `## 11. Files Changed`.

### 15. Exact run command

`godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`

### 16. What I should test visually

Manual visual checklist:

- Sector 1 feels like a clean HD cyan/blue square arcade arena.
- Sector 2 feels like a magenta/purple/cyan prism rift, not random scratches.
- Sector 3 feels like a black-glass octagon/hex void floor.
- Sector 4 feels like a fast cyan/white rail hyperlane.
- The four sectors feel like a new direction, not the old procedural grid revamps.
- Light runners visibly move along sector paths.
- Gameplay objects remain more readable than the background.
- Menus, Armory, How To Play, rewards, pause, and restart still work.

### 17. Known issues

- The Krita step was automated through CLI export from `.ora`; no manual Krita brush painting was performed.
- Krita CLI printed non-blocking ICC/resource/tile cleanup warnings during export, but all final PNGs were written and validated.
- Final visual approval still requires manual review in the playable build; headless tests validate structure, files, loading, and regressions, not taste.

### 18. Approval question

Is Phase 26 approved with the hard-reset HD sector background direction?

## 13. Exact Run Command

`godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`

## 14. What The User Should Test

Manual review checklist:

- Start from the title screen and begin a run.
- Confirm Sector 1 uses the new HD Neon Grid plate.
- Clear Sector 1 and confirm Sector 2 uses the new HD Prism Rift plate.
- Clear Sector 2 and confirm Sector 3 uses the new HD Null Zone plate.
- Clear Sector 3 and confirm Sector 4 uses the new HD Hyper Grid plate.
- Confirm the old random/procedural background look is gone.
- Confirm enemies, XP, projectiles, boss warnings, and HUD remain readable.
- Confirm reward screens, Armory, How To Play, Options, pause, Return to Title, and weapon icons still work.

## 15. Known Issues

- The new backgrounds are HD source/raster plates, but still first-pass authored sector art.
- Manual review is required for taste, contrast, and readability in a real playable window.
- Krita CLI warnings were non-blocking and did not prevent asset export.

## 16. Approval Question

Is Phase 26 approved as the Complete HD Sector Background Redesign direction for the current active-development build?
