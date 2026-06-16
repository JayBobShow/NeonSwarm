# Phase 27 Weapon Visual Art Pipeline Notes

## Purpose

Phase 27 gives current weapon families visible HD geometric VFX assets without adding weapons or changing damage, cooldowns, projectile caps, or runtime loadout rules.

## Inkscape Source

- `art/weapons/source/inkscape/weapon_visual_hd_art_sheet.svg`

The sheet contains vector-built gameplay visual designs for:

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

## Krita / Krita-Ready Source

- `art/weapons/source/krita/weapon_visual_hd_art_sheet_inkscape_render.png`
- `art/weapons/source/krita/weapon_visual_hd_art_sheet_krita_ready.ora`
- `art/weapons/source/krita/weapon_visual_hd_art_sheet_krita_export.png`
- `art/weapons/source/krita/weapon_visual_hd_art_sheet_krita_ready/`

The `.ora` source contains vector construction, glow polish, and body/core polish layers. Krita CLI exported the final sheet, then it was sliced into per-family gameplay PNGs.

## Exported Godot Assets

Exported PNGs live in:

- `art/weapons/exported/`

Each active weapon family has a `*_visual_hd.png` asset.

## Godot Integration

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `_apply_weapon_projectile_hd_art()`
- `_add_weapon_field_hd_art()`
- `_weapon_hd_art_path()`
- `_weapon_projectile_hd_art_size()`

Projectile families receive HD art billboards. Mine/well/nova/star/ring/beam visuals receive flat HD overlays. Existing weapon hit logic and caps remain unchanged.
