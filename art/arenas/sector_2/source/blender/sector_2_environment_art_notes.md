# Sector 2 Prism Rift Arena Art Notes

Phase 39 adds the Sector 2 Prism Rift Blender arena source and runtime GLB.

Source:

- `build_sector_2_prism_rift_arena.py`
- `sector_2_prism_rift_arena.blend`

Runtime export:

- `../../exported/sector_2_prism_rift_arena.glb`

Art direction:

- Darker Prism Rift identity for Sector 2 only.
- Fractured floor-first deck with triangular and diagonal panel splits.
- Purple, magenta, and violet neon language with controlled cyan refraction accents.
- Glassy prism structures and darker rift boundary treatment outside the playable edge.
- No gameplay collision geometry is authored or exported.
- Floor detail is intentionally restrained so player, enemies, XP, projectiles, and the Phase 37 ripple stay readable.

Regeneration:

```bash
blender --background --python art/arenas/sector_2/source/blender/build_sector_2_prism_rift_arena.py
```
