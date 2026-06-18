# Sector 2 Prism Rift Arena Art Notes

Phase 39 adds the Sector 2 Prism Rift Blender arena source and runtime GLB. Hard Repair 2 rebuilds the rejected line-grid candidate with a documentation-first hard-surface pass.

Source:

- `build_sector_2_prism_rift_arena.py`
- `sector_2_prism_rift_arena.blend`

Runtime export:

- `../../exported/sector_2_prism_rift_arena.glb`

Hard Repair 2 art direction:

- Darker Prism Rift identity for Sector 2 only.
- Broken prism/glass sci-fi deck inside a neon rift.
- Thick gunmetal support panels with real side faces and bevels.
- Raised violet/amethyst glass floor insets over the support deck.
- Recessed mechanical seams and short embedded neon channels.
- Raised angular boundary rails and corner prism anchors.
- Purple, magenta, and violet identity with controlled cyan refraction accents.
- No gameplay collision geometry is authored or exported.
- Floor detail is intentionally restrained so player, enemies, XP, projectiles, and the Phase 37 ripple stay readable.
- The asset is a user-review candidate, not a claimed visual approval.

Regeneration:

```bash
blender --background --python art/arenas/sector_2/source/blender/build_sector_2_prism_rift_arena.py
```
