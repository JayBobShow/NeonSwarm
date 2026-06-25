# Neon Swarm Phase 55C Sector 4 Pressure/Cap Audit Report

## 1. Summary

Phase 55C completed a narrow Sector 4 Hyper Grid enemy population headroom tune.

The pass reduces Sector 4 extra-spawn pressure only. It keeps Rail Skimmer and
Grid Splitter enemy mix weights unchanged, does not raise `ENEMY_CAP`, and does
not change enemy behavior, enemy stats, projectiles, XP, hazards, weapons,
bosses, scenes, project settings, Sector 3, Sector 5, or arena/background
readability.

Result: pass with one documented pressure caveat. Forced Rift Surge and Overload
stress now stay below the hard enemy cap more consistently. The existing natural
pressure helper can still touch `54/54` once in the 4A auto-advance window when
very few enemies are killed, so Sector 4 should not receive new enemy, hazard,
or boss pressure until that headroom is reviewed again.

## 2. Official Build

- Official scene: `scenes/Main.tscn`
- Official launch command: `godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`
- `project.godot` remains the official project configuration path and was not changed.
- No alternate playable scene was created.

## 3. Docs Consulted

- `AGENTS.md`
- `STUDIO.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_PHASE_55B_SECTOR_4_HYPER_GRID_READABILITY_POLISH_REPORT.md`

No external Godot API documentation was required because this was a data-only
catalog tuning pass using existing runtime fields, not an engine/API behavior
change.

## 4. Data Tuning

Changed `scripts/content/NeonContentCatalog.gd` only.

Sector 4 Hyper Grid tuning:

- `spawn_extra_chance`: `[0.18, 0.48, 0.60, 0.46, 0.14, 0.52]` -> `[0.18, 0.36, 0.46, 0.34, 0.14, 0.40]`
- `surge_extra_chance`: `0.12` -> `0.08`

Preserved:

- `ENEMY_CAP`
- `spawn_profile`
- Rail Skimmer/Grid Splitter mix weights
- Enemy stats
- Enemy behavior
- Enemy projectile behavior
- XP/reward tuning
- Hazard behavior
- Weapon behavior
- Boss behavior
- Sector 4 background/readability tuning from Phase 55B

## 5. Pre-Tune Pressure Evidence

Phase 55C audit evidence before implementation showed repeated near-cap Sector 4
pressure:

| Sample | Max Enemies | Notes |
| --- | ---: | --- |
| Natural 4A | `54/54` | Natural pressure helper touched the hard cap. |
| Natural 4D | `49/54` | Late pressure remained high. |
| Forced Rift Surge | `51/54` | Forced event stress neared cap. |
| Forced Overload | `53/54` | Forced event stress nearly capped. |
| Phase 55B dense 4B sample | `52/54` | Existing near-cap pressure noted in Phase 55B. |

Projectile, XP, hazard, beam, burst, and mine caps did not show comparable
pressure.

## 6. Post-Tune Natural Pressure Audit

Command:

```bash
timeout 60s godot --headless --path . --script /tmp/neon_swarm_phase55c_natural_pressure.gd
```

Representative post-tune result:

| Sample | Enemies | Player Proj | Enemy Proj | XP | Hazards | Beams | Bursts | Mines | Rail Skimmer | Grid Splitter |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 4.0 Storm Entry | `44/54` | `3/36` | `1/28` | `0/100` | `4/10` | `3/8` | `0/18` | `0/6` | `10` | `14` |
| 4A Routing Spine | `54/54` | `3/36` | `0/28` | `0/100` | `3/10` | `4/8` | `0/18` | `0/6` | `12` | `10` |
| 4B Overclock Field | `43/54` | `3/36` | `2/28` | `0/100` | `1/10` | `4/8` | `0/18` | `0/6` | `11` | `8` |
| 4C Signal Cyclone | `40/54` | `3/36` | `12/28` | `0/100` | `7/10` | `4/8` | `1/18` | `0/6` | `9` | `11` |
| 4D Lockbreaker Gate | `46/54` | `3/36` | `12/28` | `1/100` | `8/10` | `5/8` | `0/18` | `0/6` | `7` | `12` |

Natural pressure result: pass with caveat. The late-sector samples improved, but
the helper can still touch `54/54` in 4A. This appears tied to low-kill,
auto-advance helper conditions rather than a broad cap failure, because the
official forced stress review no longer reaches the hard cap.

## 7. Post-Tune Forced Stress Audit

Command:

```bash
timeout 60s godot --headless --path . --script /tmp/neon_swarm_phase55a_sector4_review.gd
```

Result:

| Sample | Enemies | Enemy Proj | XP | Hazards | Beams | Bursts | Mines | Result |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| Baseline 4.0 | `45/54` | `4/28` | `0/100` | `1/10` | `3/8` | `0/18` | `0/6` | Pass |
| Baseline 4A | `46/54` | `4/28` | `0/100` | `5/10` | `4/8` | `0/18` | `0/6` | Pass |
| Baseline 4B | `45/54` | `2/28` | `0/100` | `1/10` | `3/8` | `0/18` | `0/6` | Pass |
| Baseline 4C | `48/54` | `5/28` | `0/100` | `1/10` | `4/8` | `0/18` | `0/6` | Pass |
| Baseline 4D | `48/54` | `5/28` | `0/100` | `2/10` | `4/8` | `0/18` | `0/6` | Pass |
| Forced 4C Rift Surge | `46/54` | `3/28` | `11/100` | `3/10` | `4/8` | `0/18` | `0/6` | Pass |
| Forced 4D Overload | `49/54` | `2/28` | `24/100` | `1/10` | `3/8` | `0/18` | `0/6` | Pass |
| Boss-gate transition review | `30/54` | `0/28` | `18/100` | `3/10` | `3/8` | `0/18` | `0/6` | Pass |

Forced stress result: pass. Forced Rift Surge dropped from `51/54` to `46/54`,
and forced Overload dropped from `53/54` to `49/54`.

## 8. Readability QA

Command:

```bash
timeout 45s godot --path . --script /tmp/neon_swarm_phase55a_sector4_capture.gd
```

Capture coverage:

- 4.0 Storm Entry low-density review.
- 4B Overclock Field medium-density review.
- 4D Lockbreaker Gate high-density Rift Surge review.
- Boss-gate transition review only.

Readability result: pass.

- Sector 4 still reads as Hyper Grid.
- Rail Skimmer presence remains visible.
- Grid Splitter presence remains visible.
- Player remains readable.
- Enemies remain readable.
- Player projectiles remain readable.
- Enemy projectiles remain readable.
- XP remains readable.
- HUD remains readable.
- Phase 55B arena/background readability remains stable.

No separate pickup object path was observed in the current runtime beyond XP
reward pickups.

## 9. Validation

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
timeout 60s godot --headless --path . --script /tmp/neon_swarm_phase55c_natural_pressure.gd
timeout 60s godot --headless --path . --script /tmp/neon_swarm_phase55a_sector4_review.gd
timeout 45s godot --path . --script /tmp/neon_swarm_phase55a_sector4_capture.gd
```

## 10. Non-Changes Confirmed

Not changed:

- `scenes/Main.tscn`
- `project.godot`
- Enemy behavior
- Enemy stats
- Rail Skimmer/Grid Splitter mix weights
- Projectiles
- XP/rewards
- Hazards
- Weapons
- Bosses
- Sector 3
- Sector 5
- Arena/background readability
- Gameplay systems
- Alternate scenes

## 11. Known Risks

- The natural pressure helper can still touch `54/54` in 4A under low-kill,
  auto-advance conditions. Do not add new Sector 4 population pressure until
  this is reviewed again.
- Over-reducing Sector 4 spawn pressure would weaken the Hyper Grid identity, so
  this pass stops at extra-spawn pressure instead of changing spawn intervals,
  enemy mix, behavior, or caps.
- Forced events are now safer, but late Sector 4 is still intentionally intense.

## 12. Recommendation

Phase 55C is complete as a narrow pressure-cap tune.

Do not raise `ENEMY_CAP`. Do not add new Sector 4 hazards, enemies, boss pressure,
or event pressure until a later approved review confirms the 4A natural helper
cap touch is acceptable or resolved.
