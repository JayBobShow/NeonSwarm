# Sector 1 HD Mockup Arena Notes

Source reference:

- `art/reference/sector_1_neon_grid/sector_1_neon_grid_hd_mockup.png`

Blender source/export:

- Builder: `art/arenas/sector_1/source/blender/build_sector_1_hd_mockup_arena.py`
- Source blend: `art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena.blend`
- Exported GLB: `art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`
- Required proof render: `art/arenas/sector_1/review/sector_1_hd_mockup_blender_proof.png`
- Legacy top-down copy: `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png`

Reference mapping:

- Top, bottom, left, and right perimeter door blocks are modeled as `enemy_door_top`, `enemy_door_bottom`, `enemy_door_left`, and `enemy_door_right`.
- Four spawn marker empties are exported as `enemy_spawn_door_top`, `enemy_spawn_door_bottom`, `enemy_spawn_door_left`, and `enemy_spawn_door_right`.
- The four diagonal interior pillars are modeled as `pillar_northwest`, `pillar_northeast`, `pillar_southwest`, and `pillar_southeast`.
- The four low interior cover blocks are modeled as `cover_wall_northwest`, `cover_wall_northeast`, `cover_wall_southwest`, and `cover_wall_southeast`.
- The central white/cyan routing structure is modeled as recessed/raised neon channel geometry with a double vertical spine and stepped center bridges.
- The cyan perimeter grid is modeled as outer/inner square loops plus side routing lanes, all using real channel geometry with dark recessed beds.
- The floor is built from individual beveled panels, varied metal plates, seams, hatches, vents, scratches, stamps, and dark service trenches.

Reference plane:

- The mockup image is included in the `.blend` as `ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_hidden_from_export`.
- It is used only as a top-down layout/style blueprint.
- It is hidden from render, not parented under the export root, and excluded from the GLB.
- The final floor does not use the reference image as a texture.

Modeled detail pass:

- Doors are chunky separate animation-ready objects with segmented leaf plates, hinge towers, locking spines, dark sockets, yellow warning strips, cyan status lights, and chevron/header details.
- Pillars are taller tapered/obelisk forms on stepped plinths with top access panels, cyan lenses, yellow strips, and contact-shadow plates.
- Cover blocks are low sci-fi walls with base sockets, raised armor plates, removable top panels, dark lock slots, cyan rails, and yellow light bars.
- The outer frame is a segmented raised wall system with corner power housings, top inset panels, cyan wall glows, and dark mechanical recesses.

Materials:

- `mat_floor_dark_brushed_metal`
- `mat_floor_panel_variant`
- `mat_outer_wall_dark_metal`
- `mat_door_dark_metal`
- `mat_pillar_dark_metal`
- `mat_cover_dark_metal`
- `mat_cyan_neon_emissive`
- `mat_white_energy_emissive`
- `mat_yellow_accent_emissive`
- `mat_black_recess_shadow`
- `mat_edge_trim_metal`
- `mat_floor_bright_worn_scratches`

Lighting/render:

- The `.blend` contains an orthographic proof camera named `TopDownOrthographicReferenceProofCamera`.
- The proof render is square 2048x2048.
- The camera is slightly offset while remaining orthographic so raised doors, walls, pillars, and covers show height and shadow.
- The render uses Eevee/Filmic, ambient occlusion, restrained bloom, a large soft key light, cyan ambience, and small yellow/cyan accent lights.

Collision:

- This pass is visual-only.
- No collision is exported for doors, pillars, or cover blocks.
- The player spawn center and door spawn marker positions remain clear.
- A later gameplay pass can add simple explicit collision after obstacle behavior/pathing rules are approved.
