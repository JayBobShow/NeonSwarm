# Phase 27 Enemy / Boss Art Pipeline Notes

## Purpose

Phase 27 creates HD geometric visual assets for active enemy and boss families without adding enemies, bosses, or balance changes.

## Inkscape Source

- `art/enemies/source/inkscape/enemy_family_hd_art_sheet.svg`

The sheet contains vector-built shape-language silhouettes for:

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
- Prism Warden
- Null Octagon
- Null Octagon Prime
- Fractal Crown

## Krita / Krita-Ready Source

- `art/enemies/source/krita/enemy_family_hd_art_sheet_inkscape_render.png`
- `art/enemies/source/krita/enemy_family_hd_art_sheet_krita_ready.ora`
- `art/enemies/source/krita/enemy_family_hd_art_sheet_krita_export.png`
- `art/enemies/source/krita/enemy_family_hd_art_sheet_krita_ready/`

The `.ora` source contains vector construction, glow polish, and body/core polish layers. Krita CLI exported the final sheet, then it was sliced into per-family PNGs.

## Exported Godot Assets

Exported PNGs live in:

- `art/enemies/exported/`

Required active files:

- `chaser_hd.png`
- `tank_hd.png`
- `shooter_hd.png`
- `exploder_hd.png`
- `spiral_drifter_hd.png`
- `shield_node_hd.png`
- `hex_slicer_hd.png`
- `prism_leech_hd.png`
- `triad_splitter_hd.png`
- `triad_fragment_hd.png`
- `hex_pulser_hd.png`
- `prism_warden_hd.png`
- `null_octagon_hd.png`
- `null_octagon_prime_hd.png`
- `fractal_crown_hd.png`

## Godot Integration

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `_apply_enemy_hd_art()`
- `_enemy_hd_art_id()`
- `_enemy_hd_art_size()`

The exported PNGs are attached to the existing enemy visual roots as billboarded HD art. Enemy collision, HP, damage, movement, spawn mix, and boss behavior were not changed.
