# Neon Swarm Sector 1 HD Mockup Arena Report

## Scope

Built a real Blender-modeled Sector 1 arena from the user reference and integrated it as the Sector 1 / 1.0 Awakening Grid base visual.

No Sector 3 work was started. Weapon mechanics, equipment mechanics, player movement, HUD layout, story content, and `scenes/Main.tscn` were not replaced.

## Reference

Primary reference:

- `art/reference/sector_1_neon_grid/sector_1_neon_grid_hd_mockup.png`

The image was used as the blueprint for:

- Square hard-surface arena frame.
- Four perimeter enemy-entry doors.
- Four tall obelisk-like interior pillars.
- Four low rectangular interior cover blocks.
- Central vertical routing lane.
- Cyan neon grid/routing channels with yellow accent lights.
- Dark metal floor panels and high-tech seams.

The reference image is not used as a final floor texture.

## Blender Assets

Created:

- `art/arenas/sector_1/source/blender/build_sector_1_hd_mockup_arena.py`
- `art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena.blend`
- `art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena_notes.md`
- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`
- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png`
- `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_godot_gameplay.png`

The `.blend` contains the mockup as a temporary reference plane named `ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_hidden_from_export`. It is hidden from render and excluded from GLB export.

## Layout Mapping

Doors:

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

- Modeled 7x7 beveled metal panel base with service hatches, seams, lips, dark recesses, and material variation.
- Modeled outer/inner cyan route loops and left/right lane routes.
- Modeled a bright central vertical corridor with stepped center connections to match the mockup's main routing lane.

## Materials

Required materials created in Blender and recognized by the Godot Sector 1 arena material visibility pass:

- `mat_dark_metal_floor`
- `mat_dark_metal_wall`
- `mat_cyan_neon`
- `mat_yellow_accent`
- `mat_pillar_metal`
- `mat_door_metal`
- `mat_cover_metal`

Supporting materials:

- `mat_black_recess`
- `mat_cool_worn_edge_metal`
- `mat_cool_white_neon_core`
- `mat_smoked_glass_plastic_accent`

## Lighting And Readability

The GLB relies on emissive cyan/yellow material accents plus the existing Sector 1 runtime arena readability light. The Godot material visibility pass now supports the new `mat_*` material names.

Visual comparison artifacts:

- Blender top-down render: `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png`
- Godot gameplay-view screenshot: `art/arenas/sector_1/exported/sector_1_hd_mockup_arena_godot_gameplay.png`

The gameplay-view screenshot confirms the player, enemies, projectiles, HUD, doors, cover blocks, neon routing, and floor remain readable. Pillars are visible as dark diagonal/obelisk structures with cyan/yellow accents near the interior corner lanes.

## Collision

This pass is visual-only.

No collision was added to the doors, pillars, or cover blocks. This avoids unfair invisible collision, avoids player/enemy spawn conflicts, and avoids projectile/pathing behavior changes. A later pass can add simple explicit collision after obstacle gameplay rules are approved.

## Godot Integration

Changed `scripts/NeonSwarm3DGameplayPrototype.gd` only.

Added:

- `SECTOR_1_HD_MOCKUP_ARENA_ENABLED = true`
- `SECTOR1_HD_MOCKUP_ARENA_SCENE_PATH = "res://art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb"`

Sector 1 base arena load now uses the HD mockup GLB when the flag is true and falls back to `sector_1_neon_grid_arena.glb` if the new asset fails to load.

Subsector overlays remain unchanged:

- 1A Relay Yard
- 1B Data Trench
- 1C Capacitor Field
- 1D Rail Approach

Sector 2 loading remains unchanged and was validated with the runtime harness.

## Validation

Reference and asset checks:

- Reference exists: PASS.
- Blender source exists: PASS.
- GLB exists: PASS.
- Top-down Blender render generated: PASS.
- Godot gameplay-view screenshot generated: PASS.
- GLB object inventory: PASS.
- Required door objects: PASS.
- Required spawn marker empties: PASS.
- Pillars: PASS.
- Walls/cover: PASS.
- Required materials: PASS.
- Reference plane excluded from GLB: PASS.

Runtime validation:

- `godot --headless --path . --quit-after 3`: PASS.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: PASS.
- Temporary runtime harness loaded Sector 1 base arena path `res://art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb`: PASS.
- Player spawned at arena center: PASS.
- Enemies spawned and continued running: PASS (`enemies_before=9`, `enemies_after=10`).
- Weapons fired under held fire input: PASS (`projectiles=9`).
- Equipment system accessible: PASS (`equipped_count=2`).
- Sector 2 Prism Rift arena still loaded in-memory: PASS.
- No Sector 3 files or content were added.
- No push was performed.

Git validation:

- `git diff --check`: PASS.

## Remaining Improvements

- Add simple explicit collision for visual cover/pillars only after gameplay obstacle rules are approved.
- Add future door open/close animation using the separate `enemy_door_*` objects.
- Tune pillar contrast if later gameplay feedback says the obelisk bodies need to read brighter under the live camera.
