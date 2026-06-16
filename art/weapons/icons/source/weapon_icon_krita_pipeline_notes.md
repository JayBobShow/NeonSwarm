# Phase 27 Weapon Icon Krita Pipeline Notes

## Purpose

Phase 25 icons were approved only as functional placeholder family symbols. Phase 27 upgrades those family-level UI symbols through the same Inkscape/Krita pipeline used for gameplay visuals.

## Inkscape Source

- `art/weapons/icons/source/inkscape/weapon_icon_hd_art_sheet.svg`

The sheet contains one family-level icon per active weapon family plus an unknown/fallback weapon icon.

## Krita / Krita-Ready Source

- `art/weapons/icons/source/krita/weapon_icon_hd_art_sheet_inkscape_render.png`
- `art/weapons/icons/source/krita/weapon_icon_hd_art_sheet_krita_ready.ora`
- `art/weapons/icons/source/krita/weapon_icon_hd_art_sheet_krita_export.png`
- `art/weapons/icons/source/krita/weapon_icon_hd_art_sheet_krita_ready/`

The `.ora` source contains the vector construction and Krita-ready polish layers. Krita CLI exported the final sheet, then it was sliced into UI-ready 512x512 PNG icons.

## Exported Godot Assets

Exported PNGs live in:

- `art/weapons/icons/exported/`

Required files include one `*_icon_hd.png` per active weapon family and:

- `unknown_weapon_icon_hd.png`

## Godot Integration

- `scripts/ui/NeonWeaponIcon.gd`

`NeonWeaponIcon.icon_resource_path()` now maps weapon family IDs to the Krita-exported PNG icons under `art/weapons/icons/exported/`. If a future icon is missing, the control falls back to the existing draw-call geometry instead of crashing.
