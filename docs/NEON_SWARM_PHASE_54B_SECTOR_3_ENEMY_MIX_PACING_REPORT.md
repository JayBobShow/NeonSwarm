# Neon Swarm Phase 54B Sector 3 Enemy Mix Pacing Report

## Scope

Phase 54B applies a narrow, data-only Sector 3 enemy mix pacing polish.

The goal is to make Sector 3 / Ember Circuit / Foundry Gate combat feel less
samey and more factory/Gridborn-adjacent while preserving the Phase 53
arena/background/projectile readability lock.

This pass uses existing enemies only. It does not add hazards, new enemies,
enemy behavior, enemy stats, projectile behavior, weapon tuning, XP/reward
tuning, collision, bosses, Sector 4, Sector 5, scenes, project settings, or
alternate scenes.

## Files Changed

- `scripts/content/NeonContentCatalog.gd`
- `docs/NEON_SWARM_PHASE_54B_SECTOR_3_ENEMY_MIX_PACING_REPORT.md`

## References Reviewed

- `AGENTS.md`
- `STUDIO.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_REFERENCE_IMAGE_RULES.md`
- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_FULL_GAME_BUILDOUT_ROADMAP.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PHASE_52_REPORT.md`
- `docs/NEON_SWARM_ENEMY_FACTION_BIBLE.md`
- `docs/NEON_SWARM_PHASE_53_SECTOR_3_EMBER_CIRCUIT_ARENA_FOUNDATION_REPORT.md`
- `docs/NEON_SWARM_PHASE_53_SECTOR_3_ARENA_READABILITY_POLISH_REPORT.md`
- `docs/NEON_SWARM_PHASE_53_SECTOR_3_ENEMY_PROJECTILE_READABILITY_POLISH_REPORT.md`

Official Godot documentation was not required for this pass because no engine
API, node, scene, import, rendering, physics, input, or runtime system behavior
was changed. The existing local wave director behavior was inspected directly.

## Implementation

Only `_sector_3_enemy_mixes()` in `scripts/content/NeonContentCatalog.gd` was
changed.

The pass adds a modest existing Gridborn/factory-adjacent presence:

- `rail_skimmer`
- `grid_splitter`

The pass trims repeated Prism/Null-style pressure primarily by reducing:

- `prism_leech`
- `spiral_drifter`
- some repeated `triad_splitter` / `exploder` pressure in later phases

The total weight for every Sector 3 phase remains `1.0`.

## Exact Enemy Mix Changes

Phase 0 / intro:

- Added `rail_skimmer`: `0.04`.
- Added `grid_splitter`: `0.02`.
- Reduced `prism_leech`: `0.17 -> 0.14`.
- Reduced `spiral_drifter`: `0.08 -> 0.06`.
- Reduced `tank`: `0.03 -> 0.02`.

Phase 1 / pressure:

- Added `rail_skimmer`: `0.05`.
- Added `grid_splitter`: `0.03`.
- Reduced `prism_leech`: `0.20 -> 0.16`.
- Reduced `hex_slicer`: `0.19 -> 0.18`.
- Reduced `triad_splitter`: `0.12 -> 0.11`.
- Reduced `exploder`: `0.10 -> 0.08`.

Phase 2 / peak:

- Added `rail_skimmer`: `0.06`.
- Added `grid_splitter`: `0.04`.
- Reduced `prism_leech`: `0.19 -> 0.15`.
- Reduced `hex_slicer`: `0.18 -> 0.17`.
- Reduced `triad_splitter`: `0.13 -> 0.11`.
- Reduced `exploder`: `0.12 -> 0.10`.
- Reduced `spiral_drifter`: `0.02 -> 0.01`.

Phase 3 / warning:

- Added `rail_skimmer`: `0.06`.
- Added `grid_splitter`: `0.04`.
- Reduced `prism_leech`: `0.19 -> 0.15`.
- Reduced `hex_slicer`: `0.18 -> 0.17`.
- Increased `hex_pulser`: `0.15 -> 0.16`.
- Reduced `triad_splitter`: `0.13 -> 0.11`.
- Reduced `exploder`: `0.12 -> 0.09`.
- Reduced `spiral_drifter`: `0.02 -> 0.01`.

Phase 4 / boss wave:

- Added `rail_skimmer`: `0.04`.
- Added `grid_splitter`: `0.03`.
- Reduced `prism_leech`: `0.18 -> 0.15`.
- Increased `hex_pulser`: `0.15 -> 0.16`.
- Reduced `triad_splitter`: `0.13 -> 0.11`.
- Reduced `exploder`: `0.12 -> 0.10`.
- Reduced `spiral_drifter`: `0.03 -> 0.02`.

Phase 5 / cleanup:

- Added `rail_skimmer`: `0.05`.
- Added `grid_splitter`: `0.04`.
- Reduced `prism_leech`: `0.18 -> 0.15`.
- Reduced `hex_slicer`: `0.18 -> 0.17`.
- Reduced `triad_splitter`: `0.13 -> 0.11`.
- Reduced `exploder`: `0.12 -> 0.10`.
- Reduced `spiral_drifter`: `0.03 -> 0.02`.

## Validation

Passed:

- `godot --headless --path . --script /tmp/neon_swarm_phase54b_sector3_validation.gd`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --scene scenes/Main.tscn --quit-after 3`

The temporary validation script was outside the repo under `/tmp` and did not
create an alternate scene. It loaded the official `scenes/Main.tscn`, started a
run, jumped to Sector 3, and sampled 3.0 through 3D before the boss gate.

Validation confirmed:

- Every Sector 3 enemy-mix phase totals `1.0`.
- Every Sector 3 enemy-mix phase includes modest `rail_skimmer` and
  `grid_splitter` presence.
- 3.0 Foundry Gate remained in Sector 3 and stayed below caps:
  enemies `37/54`, XP `1/100`, enemy projectiles `4/28`, hazards `5/10`.
- 3A Molten Busway remained in Sector 3 and stayed below caps:
  enemies `34/54`, XP `5/100`, enemy projectiles `2/28`, hazards `1/10`.
- 3B Furnace Grid remained in Sector 3 and stayed below caps:
  enemies `35/54`, XP `6/100`, enemy projectiles `5/28`, hazards `5/10`.
- 3C Weapon Memory Forge remained in Sector 3 and stayed below caps:
  enemies `35/54`, XP `6/100`, enemy projectiles `3/28`, hazards `7/10`.
- 3D Cobalt Assembly Line remained in Sector 3 and stayed below caps:
  enemies `35/54`, XP `7/100`, enemy projectiles `3/28`, hazards `6/10`.

## QA Result

Pass.

- Enemy mix should feel less samey because every Sector 3 phase now has a small
  Rail Skimmer / Grid Splitter factory-system presence.
- Sector 3 should still not become Sector 4 because Rail Skimmer and Grid
  Splitter combined weights stay modest, topping out at `0.10` in normal peak
  and warning phases.
- Player, enemy, projectile, XP, pickup, and HUD readability should remain
  stable because no visuals, materials, projectile behavior, HUD, arena art, XP,
  pickup behavior, spawn caps, or object caps were changed.
- Existing cap validation stayed below enemy, projectile, XP, and hazard caps.
- Phase 53 arena/background/projectile readability was not retuned.

## Code Review

- Data-only pass: yes.
- Gameplay systems changed: no.
- Enemy stats changed: no.
- Enemy behavior changed: no.
- Enemy projectile behavior changed: no.
- Player weapons changed: no.
- Weapon tuning changed: no.
- Rewards or XP tuning changed: no.
- Hazards changed: no.
- Bosses changed: no.
- Collision changed: no.
- Sector 3 arena/background readability changed: no.
- Sector 3 projectile readability changed: no.
- Sector 4 changed: no.
- Sector 5 changed: no.
- Alternate scenes created: no.
- `scenes/Main.tscn` changed: no.
- `project.godot` changed: no.

Official build remains:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

`project.godot` remains expected to launch:

```ini
run/main_scene="res://scenes/Main.tscn"
```

## Known Limitations

This is not final Sector 3 enemy production. It uses existing enemies only and
does not add authored Ember-specific enemies or industrial hazards. A future
Phase 54C should review whether the data-only mix polish is enough before any
new hazard or enemy implementation is approved.
