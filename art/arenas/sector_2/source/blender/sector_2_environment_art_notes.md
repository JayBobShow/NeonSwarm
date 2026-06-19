# Sector 2 Prism Rift Arena Art Notes

Phase 39 adds the Sector 2 Prism Rift Blender arena source and runtime GLB. Hard Repair 3 rebuilds the rejected line-grid candidates from the user-owned original floor reference.

Source:

- `build_sector_2_prism_rift_arena.py`
- `sector_2_prism_rift_arena.blend`

Runtime export:

- `../../exported/sector_2_prism_rift_arena.glb`

Hard Repair 3 art direction:

- Primary target: `art/reference/user_original_art/sector2_user_original_floor_reference.jpg`.
- This image is user-owned original art and is allowed as the close Sector 2 floor direction.
- Do not paste the reference as a flat floor plane; rebuild it as authored Blender geometry.
- The floor is the star: dark machined gunmetal grid, large beveled octagonal prism/glass bays, raised magenta/violet rims, visible faces, contained fracture cracks, corner armor plates, and short embedded accent channels.
- Neon is controlled and purposeful; avoid random route lines, long diagonal spaghetti strips, and black unreadable floor zones.
- No gameplay collision geometry is authored or exported.
- Floor detail is intentionally restrained so player, enemies, XP, projectiles, and the Phase 37 ripple stay readable.
- The asset is a user-review candidate, not a claimed visual approval until checked in the official gameplay camera.

Regeneration:

```bash
blender --background --python art/arenas/sector_2/source/blender/build_sector_2_prism_rift_arena.py
```

## Phase 49 Subsector Variants

Phase 49 keeps the approved base arena above as `2.0 Prism Gate` and adds
visual-only full arena-layout variants for:

- `2A Mirror Flats`
- `2B Fracture Hall`
- `2C Violet Glassway`
- `2D Rift Lens`

Primary reference:

- `art/reference/sector_2_prism_rift/sector_2_reference_sheet.png`

Subsector source:

- `build_sector_2_subsector_arena_kit.py`
- `sector_2_subsector_arena_kit.blend`
- `sector_2_subsector_art_notes.md`

Runtime exports:

- `../../exported/sector_2_mirror_flats.glb`
- `../../exported/sector_2_fracture_hall.glb`
- `../../exported/sector_2_violet_glassway.glb`
- `../../exported/sector_2_rift_lens.glb`

These variants are not random line overlays or flipped versions of the same
room. They are separate modeled layouts using plates, glass inserts, ribs,
route structures, focal rings, prism shards, and boundary architecture. They
add no gameplay collision and do not alter the approved 2.0 base arena.
