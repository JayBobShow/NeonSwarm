# Phase 27 Player Art Pipeline Notes

## Purpose

Phase 27 replaces the player programmer-art presentation with an HD geometric hero-core asset while preserving the existing player collision, movement, damage flash, weapons, HUD, and run balance.

## Inkscape Source

- `art/player/source/inkscape/player_core_hd.svg`

The SVG defines the player as an angular diamond/hex command core with dark glass faces, cyan neon tube edges, magenta wing geometry, white-hot reactor core, and readable forward prow.

## Krita / Krita-Ready Source

- `art/player/source/krita/player_core_inkscape_render.png`
- `art/player/source/krita/player_core_krita_ready.ora`
- `art/player/source/krita/player_core_krita_export.png`
- `art/player/source/krita/player_core_krita_ready/`

The `.ora` source contains the Inkscape vector render plus Krita-ready glow/body polish layers. Krita CLI exported the final PNG from the `.ora` source.

## Exported Godot Asset

- `art/player/exported/player_core_hd.png`

## Godot Integration

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `_apply_player_hd_art()`
- `_add_hd_art_billboard()`

The exported PNG is loaded at runtime with `Image.load_from_file()` and attached to the existing `Player3DVisualAsset` node. Gameplay collision and player movement were not changed.
