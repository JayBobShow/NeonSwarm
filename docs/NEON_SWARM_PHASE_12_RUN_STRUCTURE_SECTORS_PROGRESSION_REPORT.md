# Neon Swarm Phase 12 Run Structure, Sectors, and Progression Report

## 1. Executive Summary

Phase 12 adds a short complete arcade survival-run structure to the official build only: `scenes/Main.tscn`.

The run now progresses through three sectors in the existing arena:

- Sector 1: Neon Grid
- Sector 2: Prism Rift
- Sector 3: Null Zone

Boss defeat no longer always ends the run. Sector 1 and Sector 2 boss clears open a sector-clear reward choice, then advance to the next sector. The run completes only after the final Sector 3 boss is defeated.

## 2. Sector System

The sector system is implemented inside `scripts/NeonSwarm3DGameplayPrototype.gd`.

Each sector has:

- Name
- Sector-local wave timing
- Weighted enemy mix
- Boss event
- Clear condition
- Transition message
- Runtime geometry identity

Sector definitions:

| Sector | Name | Pacing Profile | Enemy Mix Direction | Boss Event | Clear Condition | Transition Message |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | Neon Grid | Manageable intro, moderate ramp, Prism pressure | Chasers, Tanks, Spiral Drifters, light Shooters/Hex Slicers | Prism Warden | Defeat Prism Warden | Prism Rift Vector Open |
| 2 | Prism Rift | Faster middle pressure with more mixed threats | Hex Slicers, Prism Leeches, Shooters, Shield Nodes, Exploders | Null Octagon | Defeat Null Octagon | Null Zone Gate Unsealed |
| 3 | Null Zone | Intense but capped final pressure | Prism Leeches, Hex Slicers, Shield Nodes, Exploders, Shooters | Null Octagon Prime | Defeat Null Octagon Prime | Run Complete Vector |

## 3. Sector Clear / Transition Flow

When a non-final sector boss dies:

- The boss drops XP rewards.
- A sector-clear command plate appears using the approved neon HUD upgrade panel style.
- Enemy projectiles and hazards are cleared safely.
- Non-boss enemies and player projectiles are cleaned up on the next paused frame to avoid mutating combat arrays mid-damage-loop.
- The player chooses one reward.
- The run advances to the next sector in the same arena.

Sector 1 and Sector 2 no longer end the whole run.

## 4. Reward Flow

Sector rewards are separate from normal level-up rewards and are stronger run-shaping choices.

Examples:

- Overclock Core: damage plus fire rate
- Rebuild Cell: max health plus strong heal
- Magnet Geometry: pickup range plus XP pull
- Prism Splitter: extra Pulse shot plus Prism Lance damage
- Fracture Saw: Ring Saw spin plus Hex Shatter shards
- Null Buffer: max health plus Mine radius
- Cache Sieve: enemy XP and boss bonus XP

The reward UI remains controller-friendly:

- D-Pad / left stick selects
- A / Enter confirms
- Existing styled neon buttons are reused
- No default Godot button visuals were introduced

## 5. Boss Placement

Boss placement:

- Sector 1: Prism Warden (`mini_boss`)
- Sector 2: Null Octagon (`null_octagon`)
- Sector 3: Null Octagon Prime (`final_null_octagon`)

Null Octagon Prime reuses the existing Null Octagon scene and behavior with modest stat and cadence changes. No new playable scene or hidden test scene was created.

## 6. Win Condition

Prototype run win condition:

1. Clear Sector 1 by defeating Prism Warden.
2. Choose a sector reward.
3. Clear Sector 2 by defeating Null Octagon.
4. Choose a sector reward.
5. Clear Sector 3 by defeating Null Octagon Prime.
6. Show `RUN COMPLETE`.

Death/restart and success/restart still reload the official scene.

## 7. Difficulty/Pacing Notes

Target run length remains approximately 6-8 minutes depending on player damage output, reward choices, and boss clear speed.

Pacing changes:

- Sector 1 uses slower spawn intervals and lighter enemy combinations.
- Sector 2 increases Hex Slicer, Prism Leech, Shooter, Shield Node, and Exploder pressure.
- Sector 3 increases spawn count chance and uses darker Null pressure, but boss phases add spawn relief to avoid unfair overlap.
- Boss spawns trim excess non-boss enemies and clear enemy projectiles/hazards before the boss enters.

Performance caps were preserved:

- Enemy cap: 54
- XP cap: 100
- Player projectile cap: 36
- Enemy projectile cap: 28
- Burst, beam, mine, hazard caps unchanged

## 8. Geometry Shape Updates

Updated `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`.

Runtime sector identity:

- Sector 1: triangular/prism floor markers, clean cyan/magenta/gold grid read
- Sector 2: hex floor glyphs and diagonal fracture rails
- Sector 3: octagonal void markers, darker violet/cyan contrast, crossed null rails

These identities are overlays in the existing official arena, not new levels.

## 9. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`
- `docs/NEON_SWARM_PHASE_12_RUN_STRUCTURE_SECTORS_PROGRESSION_REPORT.md`

Temporary validation only:

- `/tmp/neon_swarm_phase12_smoke_validation.gd`

## 10. Validation Results

Required commands:

- `godot --headless --path . --quit-after 3` passed.
- `godot --headless --path . --quit-after 3000` passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3` passed.

Smoke validation:

- Title menu launches: passed.
- Start Game works: passed.
- Sector 1 starts: passed.
- Sector 1 clears correctly: passed.
- Transition/reward appears: passed.
- Sector 2 starts: passed.
- Sector 2 clears correctly: passed.
- Transition/reward appears: passed.
- Sector 3 starts: passed.
- Final win condition triggers: passed.
- Death/restart works: passed.
- Success/restart works: passed.
- Pause works: passed.
- Controller bindings exist for confirm, pause, and movement: passed.
- XP still works: passed.
- Level-up still works: passed.
- HUD remains readable in headless structural checks: passed.
- Stress check via `--quit-after 3000`: passed.

## 11. Exact Run Command

Official run command:

```sh
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 12. What The User Should Test

Play the official scene and verify:

- Sector 1 feels manageable.
- Prism Warden clear opens the sector reward plate instead of ending the run.
- Reward selection works on keyboard and controller.
- Sector 2 starts with a distinct Prism Rift identity.
- Null Octagon clear opens the second reward plate.
- Sector 3 starts with a darker Null Zone identity.
- Null Octagon Prime defeat shows `RUN COMPLETE`.
- Death/restart and success/restart still feel correct.

## 13. Known Issues

- The smoke validation prints an existing Godot export warning from `NeonStatChip.gd` loading `res://art/ui/phase10_chip_icons.png` as an image file. It did not block execution and was not introduced by Phase 12.
- Sector geometry identity is intentionally subtle. It is not a full level art pass yet.
- Run length is tuned for a short prototype target, but exact duration depends heavily on reward rolls and player weapon use.

## 14. Approval Question

Is Phase 12 approved as the run-structure and sector-progression foundation for the official `scenes/Main.tscn` build?
