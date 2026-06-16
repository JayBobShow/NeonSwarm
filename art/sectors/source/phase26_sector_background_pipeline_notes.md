# Neon Swarm Phase 26 Hard Reset Sector Background Pipeline Notes

Phase 26 Hard Reset replaces the rejected procedural background direction with an asset-backed HD sector background pipeline.

This pass uses:

- Inkscape for clean vector sector compositions.
- Krita-ready OpenRaster sources for layered raster/glow/depth polish.
- Krita CLI export for final flattened PNG plates.
- Godot texture-backed floor planes for runtime integration.

No alternate playable scenes were created.

## Geometry Tree Compliance

Use the geometry shape language docs as the source of truth:

- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`

Current sector hierarchy:

- Neon Grid: square / rectangle.
- Prism Rift: diamond / triangle / prism.
- Null Zone: octagon / hex / dark polygon.
- Hyper Grid: stretched diamond / rail / arrow.

## Inkscape Source Files

- `art/sectors/source/inkscape/sector_1_neon_grid.svg`
- `art/sectors/source/inkscape/sector_2_prism_rift.svg`
- `art/sectors/source/inkscape/sector_3_null_zone.svg`
- `art/sectors/source/inkscape/sector_4_hyper_grid.svg`

Each SVG is authored at 4096x4096 and contains the planned sector geometry composition, neon paths, and base plate color identity.

## Krita-Ready Source Files

- `art/sectors/source/krita/sector_1_neon_grid_krita_ready.ora`
- `art/sectors/source/krita/sector_2_prism_rift_krita_ready.ora`
- `art/sectors/source/krita/sector_3_null_zone_krita_ready.ora`
- `art/sectors/source/krita/sector_4_hyper_grid_krita_ready.ora`

Each ORA contains:

- Inkscape vector plate layer.
- Glow polish layer.
- Depth/readability vignette layer.
- Merged preview image.

Krita CLI exported these ORA files into final PNGs. No manual Krita brush painting was performed in this automated pass.

## Exported Runtime PNG Files

- `art/sectors/exported/sector_1_neon_grid_hd.png`
- `art/sectors/exported/sector_2_prism_rift_hd.png`
- `art/sectors/exported/sector_3_null_zone_hd.png`
- `art/sectors/exported/sector_4_hyper_grid_hd.png`

All exported runtime PNGs are 4096x4096 RGBA.

## Godot Runtime Integration

Runtime background path:

- `_sector_hd_background_design()` maps sector index to PNG path, shape identity, and runner routes.
- `_build_hd_sector_background()` loads PNG assets with `Image.load_from_file()` and `ImageTexture.create_from_image()`.
- `HDArtSectorBackgroundPlate_*` is the base art plate for the active sector.
- `_add_hd_background_light_runner()` adds sparse sector-authored light runners.
- `_update_hd_sector_background_intensity()` caps background opacity and responds to VFX intensity.

The old procedural floor-grid builders are no longer called by the active sector background path.

## Sector Motifs

Neon Grid:

- HD cyan/blue square/rectangle arcade plate.
- Connected rectangular circuits.
- Sparse square-path light runners.

Prism Rift:

- HD magenta/purple/cyan diamond/triangle prism plate.
- Intentional fractured route language.
- Sparse angular prism light runners.

Null Zone:

- HD black-glass octagon/hex void plate.
- Controlled dark polygon composition.
- Slow polygon-edge light runners.

Hyper Grid:

- HD cyan/white/electric-blue rail/stretched-diamond plate.
- High-speed highway/tunnel floor read.
- Fast sparse rail light runners.

## Removed / Disabled Rejected Direction

Disabled from active backgrounds:

- Random diagonal scratches.
- Disconnected line fragments.
- Floating shard trails.
- Ripple rings.
- Void rings.
- Warp rings.
- Breathing glyph spam.
- Rotating diamond stickers.
- Monoliths.
- Pylons.
- Gate props.
- Generic procedural grid fragments.
- Legacy loose sector marker overlays.

## Readability Rules

- Keep background plates below gameplay.
- Keep background opacity capped.
- Let VFX intensity scale background opacity safely.
- Keep animated runner count low.
- Do not cover the player, enemies, XP, projectiles, boss attacks, HUD, or reward UI.
- Improve future background art through the source files, not by adding random runtime clutter.

Future final sector art should continue from this Inkscape/Krita/Godot pipeline.
