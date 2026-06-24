# Sector 1 HD Mockup Arena Notes

Source reference:

- `art/reference/sector_1_neon_grid/sector_1_neon_grid_hd_mockup.png`

Blender source/export:

- Source: `art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena.blend`
- Builder: `art/arenas/sector_1/source/blender/build_sector_1_hd_mockup_arena.py`
- Export: `art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`
- Top-down render: `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png`

Reference mapping:

- The mockup's top, bottom, left, and right perimeter door blocks are modeled as `enemy_door_top`, `enemy_door_bottom`, `enemy_door_left`, and `enemy_door_right`.
- The reference's four diagonal interior pillars are modeled as `pillar_northwest`, `pillar_northeast`, `pillar_southwest`, and `pillar_southeast`.
- The reference's four low interior cover blocks are modeled as `cover_wall_northwest`, `cover_wall_northeast`, `cover_wall_southwest`, and `cover_wall_southeast`.
- The cyan routing lines are modeled as raised/recessed neon channel geometry, including an outer square loop, inner square loop, left/right lane loops, and a central vertical corridor with stepped connections.
- The floor is modeled from individual beveled metal panels, dark seams, service hatches, lips, and recesses. The reference image is not used as the final floor texture.

Reference plane:

- The mockup image is included in the `.blend` as `ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_hidden_from_export`.
- It is marked reference-only, hidden from render, and excluded from the selected GLB export hierarchy.

Door and spawn marker nodes:

- Door meshes: `enemy_door_top`, `enemy_door_bottom`, `enemy_door_left`, `enemy_door_right`.
- Spawn marker empties: `enemy_spawn_door_top`, `enemy_spawn_door_bottom`, `enemy_spawn_door_left`, `enemy_spawn_door_right`.
- Doors are separate named objects with segmented panels, hinge towers, cyan status strips, and yellow header/chevron lights. They are animation-ready but not animated in this pass.

Materials:

- `mat_dark_metal_floor`
- `mat_dark_metal_wall`
- `mat_cyan_neon`
- `mat_yellow_accent`
- `mat_pillar_metal`
- `mat_door_metal`
- `mat_cover_metal`
- Supporting materials: `mat_black_recess`, `mat_cool_worn_edge_metal`, `mat_cool_white_neon_core`, `mat_smoked_glass_plastic_accent`

Collision:

- This pass is visual-only. No collision is exported for the doors, pillars, or cover.
- The visible obstacles are intentionally kept out of the player spawn center and enemy door marker positions.
- A later gameplay pass can add simple explicit collision once obstacle behavior and pathing rules are approved.
