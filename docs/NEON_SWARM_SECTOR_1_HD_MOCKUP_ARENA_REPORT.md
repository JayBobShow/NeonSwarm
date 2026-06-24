# Neon Swarm Sector 1 HD Mockup Arena Report

## Scope

Rejected the prior simplified HD arena pass and rebuilt the Sector 1 base arena as a denser Blender-made 3D asset based on the user mockup.

No Sector 3 work was started. Weapon mechanics, equipment mechanics, player movement, HUD layout, story content, and `scenes/Main.tscn` were not replaced.

## Reference

Primary reference:

- `art/reference/sector_1_neon_grid/sector_1_neon_grid_hd_mockup.png`

The reference was used as a top-down Blender blueprint and style target for:

- Square hard-surface arena composition.
- Four large perimeter enemy doors.
- Four tall angled/obelisk interior pillars.
- Four low rectangular interior wall/cover blocks.
- Central white/cyan H-style routing lanes.
- Cyan perimeter and side routing channels.
- Dark sci-fi metal floor panels, seams, vents, scratches, and service trenches.
- Cyan/yellow emissive accents and dark dramatic contrast.

The reference image is not used as a final floor texture.

## Blender Assets

Created or rebuilt:

- `art/arenas/sector_1/source/blender/build_sector_1_hd_mockup_arena.py`
- `art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena.blend`
- `art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena_notes.md`
- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`
- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png`
- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_godot_gameplay.png`
- `art/arenas/sector_1/review/sector_1_hd_mockup_blender_proof.png`

The `.blend` contains a hidden reference-only plane named `ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_hidden_from_export`. It is hidden from render, excluded from the selected export hierarchy, and not present in the GLB.

## Match Checklist

Reference match checklist:

- Outer frame shape: PASS
- Top/bottom/left/right doors: PASS
- Door material/detail: PASS
- Pillar positions: PASS
- Pillar shape/material: PASS
- Wall/cover positions: PASS
- Wall/cover shape/material: PASS
- Central white/cyan lane pattern: PASS
- Cyan floor grid/perimeter routes: PASS
- Floor panel texture/detail: PASS
- Yellow accent lighting: PASS
- Shadows/depth: PASS
- Top-down composition: PASS
- Gameplay readability: PASS

The rebuild is not a pixel-perfect copy of the reference image, but the proof render now follows the same major composition, object placement, central routing, dark metal material language, cyan/yellow accent scheme, and raised/shadowed 3D forms much more closely than the rejected pass.

## Layout Mapping

Door objects:

- `enemy_door_top`: top perimeter center.
- `enemy_door_bottom`: bottom perimeter center.
- `enemy_door_left`: left perimeter center.
- `enemy_door_right`: right perimeter center.

Spawn marker empties:

- `enemy_spawn_door_top`
- `enemy_spawn_door_bottom`
- `enemy_spawn_door_left`
- `enemy_spawn_door_right`

Pillars:

- `pillar_northwest`: upper-left interior diagonal pillar.
- `pillar_northeast`: upper-right interior diagonal pillar.
- `pillar_southwest`: lower-left interior diagonal pillar.
- `pillar_southeast`: lower-right interior diagonal pillar.

Cover blocks:

- `cover_wall_northwest`: left upper interior cover block.
- `cover_wall_northeast`: right upper interior cover block.
- `cover_wall_southwest`: left lower interior cover block.
- `cover_wall_southeast`: right lower interior cover block.

Floor/routing:

- Built 8x8 layered metal floor panels with bevels, lips, seams, vents, hatches, scratch marks, dark service stamps, and central/side cable trenches.
- Built recessed/raised cyan neon channels for the outer square, inner square, left/right lane routes, and perimeter routes.
- Built white central double-lane energy channels with stepped bridge segments matching the reference's main H-shaped route.

## Materials

Required material names in the Blender asset and GLB:

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

The Blender materials use Principled BSDF settings with tuned metallic/roughness values. The floor/wall/door materials include procedural noise and bump for proof-render depth; neon, white energy, and yellow accents use emissive materials. Godot's Sector 1 material visibility pass now recognizes these new material names.

## Lighting And Proof Render

Proof render:

- `art/arenas/sector_1/review/sector_1_hd_mockup_blender_proof.png`

Lighting approach:

- Orthographic proof camera at 2048x2048.
- Slightly offset top-down camera to show height and shadows while preserving the square reference composition.
- Eevee/Filmic render with ambient occlusion, restrained bloom, dark world color, large soft key light, cyan ambience, and yellow/cyan accent lights.

Gameplay-view screenshot:

- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_godot_gameplay.png`

The gameplay screenshot confirms player, enemies, XP, bullets, weapon effects, HUD, doors, pillars, cover blocks, floor routes, and central lanes remain readable.

## Collision

Collision behavior:

- Visual-only for this pass.
- No collision was added to doors, pillars, or cover blocks.
- This avoids unfair invisible collision, spawn conflicts, projectile inconsistencies, and enemy pathing regressions.
- Player spawn remains clear at the center.
- Enemy door spawn marker positions remain clear.

A later pass can add simple explicit collision once obstacle gameplay rules and pathing behavior are approved.

## Godot Integration

Integration method:

- `scripts/NeonSwarm3DGameplayPrototype.gd` uses `SECTOR_1_HD_MOCKUP_ARENA_ENABLED := true`.
- Sector 1 base arena path is `res://art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`.
- Fallback remains `res://art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb` if the HD GLB fails to load.
- The new arena is used for Sector 1 / 1.0 Awakening Grid.

Subsector and Sector 2 safety:

- 1A Relay Yard unchanged.
- 1B Data Trench unchanged.
- 1C Capacitor Field unchanged.
- 1D Rail Approach unchanged.
- Sector 2 Prism Rift still loads in the focused runtime harness.

## Validation

Reference and asset checks:

- Reference image exists: PASS.
- Blender source file exists: PASS.
- Blender proof render exists: PASS.
- Exported GLB exists: PASS.
- GLB object inventory: PASS.
- Four door objects with required names: PASS.
- Four spawn marker empties with required names: PASS.
- Four pillar objects: PASS.
- Four wall/cover objects: PASS.
- Required material names: PASS.
- Reference plane excluded from GLB: PASS.

Command validation:

- `python3 -m py_compile art/arenas/sector_1/source/blender/build_sector_1_hd_mockup_arena.py`: PASS.
- `blender --background --python art/arenas/sector_1/source/blender/build_sector_1_hd_mockup_arena.py`: PASS.
- `blender --background --python /tmp/check_sector1_hd_mockup_glb.py`: PASS.
- `godot --headless --path . --quit-after 3`: PASS.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: PASS.
- `timeout 25s godot --path . --script /tmp/neon_swarm_sector1_hd_mockup_validation.gd`: PASS.

Focused runtime harness results:

- Sector 1 base arena path loaded as `res://art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`: PASS.
- Player spawned safely near arena center: PASS.
- Enemies spawned and continued running: PASS (`enemies_before=9`, `enemies_after=10`).
- Weapons fired under held fire input: PASS (`projectiles=10`).
- Equipment system accessible: PASS (`equipped_count=2`).
- Godot gameplay screenshot saved: PASS.
- Sector 2 Prism Rift arena loaded after sector switch: PASS.
- Harness failures: `[]`.

## Remaining Improvements

- Add simple explicit collision for visible cover/pillars/door housings only after gameplay obstacle rules are approved.
- Add future door open/close animation using the separate `enemy_door_*` objects.
- Add baked texture maps or hand-authored grunge masks if the next art pass needs even closer AAA material breakup.

## Status

- No Sector 3 work started.
- No push performed.
- Commit hash: recorded after commit in the final response.
- Final git status: recorded after commit in the final response.
