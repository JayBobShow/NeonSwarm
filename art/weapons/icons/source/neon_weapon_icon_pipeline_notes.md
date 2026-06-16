# Neon Swarm Weapon Icon Source Notes

Phase 25 added one family-level preview icon per active weapon family, plus a fallback unknown weapon glyph.

Phase 27 upgrades the active playable UI path to Krita-exported PNG icons under `art/weapons/icons/exported/`. `scripts/ui/NeonWeaponIcon.gd` still owns the family-id mapping and falls back to the draw-call geometry if a future PNG is missing.

The Phase 25 SVG/procedural symbols remain historical source/reference material. The current active icons are Phase 27 Krita-exported family-level icons, still one icon per weapon family rather than per random weapon instance.

Future final weapon art/previews should continue to better match the actual in-game weapon visual/VFX while preserving the one-preview-per-family mapping system for Armory, reward cards, stash rows, comparison panels, and How To Play.

When adding a new weapon family:

1. Add the family id to `NeonWeaponIcon.icon_ids()`.
2. Add a family-specific branch in `_draw_family_icon()` as a fallback.
3. Add Inkscape/Krita source art under `art/weapons/icons/source/`.
4. Export a matching PNG to `art/weapons/icons/exported/{family_id}_icon_hd.png`.
5. Keep the icon readable at 30x30, 54x54, and 78x78 UI sizes.
6. Use dark geometric faces, neon tube strokes, and a silhouette that communicates behavior.

Do not create separate icons for every random weapon instance. Random stats, modifiers, and rarity remain text/card data layered around the family preview icon.

Future 200+ weapon scaling should reuse this system instead of requiring hand-made art for every generated weapon roll.
