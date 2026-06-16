# Neon Swarm Phase 30 Enemy Wave Director / Elite Variety Report

## 1. Executive Summary

Phase 30 adds a first-pass Wave Director and capped elite enemy variant foundation to the official build only: `scenes/Main.tscn`.

The work focuses on combat flow, not new content volume. It keeps existing sectors, enemies, bosses, weapons, Armory/Stash, Weapon Forge, Neon Dust, Core Upgrades, XP, controller support, and the approved visual direction intact.

## 2. Wave Director System

The Wave Director now controls:

- Wave phase state: intro, pressure, peak, warning, boss, and cleanup.
- Spawn interval by sector and wave phase.
- Extra spawn chance by sector and wave phase.
- Sector elapsed-time intensity ramp.
- Boss-active spawn softening.
- Elite spawn eligibility, cooldown, and active elite cap.

The director is intentionally simple and data-driven. It does not replace enemy behavior; it organizes when and how enemy mixes enter the run.

## 3. Sector Enemy Mix

Sector 1: Neon Grid

- Slower intro pacing.
- Mostly readable popcorn pressure.
- Elite access is delayed and capped low.

Sector 2: Prism Rift

- Faster medium pressure.
- More hex, prism, splitter, and angled-movement enemies.
- Elite chance increases after the early wave.

Sector 3: Null Zone

- More shield, pulse, leech, and control pressure.
- Slower/heavier feel than Sector 2.
- Higher elite cap than Sector 1.

Sector 4: Hyper Grid

- Fastest spawn pacing.
- Higher extra-spawn chance.
- Highest elite cap in the current prototype.
- Boss-active pressure remains softened to avoid unfair overlap.

## 4. Elite Enemy Variants

Elite variants use existing enemy families only. No new enemy families were added.

Implemented variants:

| Variant | Behavior Role | Visual Read |
| --- | --- | --- |
| Overcharged | Faster pressure, modest HP increase. | Cyan 3D elite ring marker. |
| Armored | Slower, higher HP. | Gold 3D frame marker. |
| Shielded | Adds shield durability where eligible. | Blue 3D shield ring marker. |
| Volatile | Faster threat with small death pulse. | Red/orange warning ring marker. |
| Splitter Elite | Stronger Triad Splitter with one extra capped fragment. | Magenta splitter frame marker. |

Guardrails:

- No elites during wave 0.
- No elites during active boss fights.
- No elite Triad Fragments.
- Active elite count is capped by sector.
- Elite spawn cooldown prevents flood behavior.

## 5. Visual Readability Notes

- Elite status is marked with small 3D neon rings/frames on top of existing Blender enemy visuals.
- The base enemy silhouette remains visible so elites do not look like bosses.
- Elite marker colors are distinct: cyan, gold, blue, red/orange, and magenta.
- Existing Phase 27 popcorn enemy scale/readability tuning was preserved.

## 6. Reward / Progression Hooks

Elites now provide modest progression pressure:

- Extra XP compared with the base enemy.
- Extra score compared with the base enemy.
- Small chance to grant Neon Dust.

This is not a new loot-drop system. Elites do not drop weapons and do not bypass stash, Forge, or sector reward rules.

## 7. Balance Notes

- Sector 1 remains approachable.
- Later sectors ramp faster through spawn intervals, extra-spawn chance, and higher elite caps.
- Boss overlap is protected by reducing spawn pressure while a boss is active.
- Elite stat bonuses are conservative and bounded.
- Volatile elite death pulse is short-lived and uses existing hazard caps.
- Splitter Elite adds one extra fragment only and still respects enemy caps.

## 8. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/content/NeonContentCatalog.gd`
- `docs/NEON_SWARM_PHASE_30_ENEMY_WAVE_DIRECTOR_ELITE_VARIETY_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

Validation helper used:

- `/tmp/neon_swarm_phase30_wave_director_validation.gd`

## 9. Validation Results

Passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase29_forge_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase30_wave_director_validation.gd`

Save protection:

- Backed up weapon/progression save before UI/Forge validation.
- Restored weapon/progression save after validation.

## 10. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 11. What I Should Test

- Start a normal run and confirm Sector 1 still feels approachable.
- Reach Sector 2 and confirm splitter/prism/hex pressure becomes more common.
- Reach Sector 3 and confirm shield/pulse/control enemies are more prominent.
- Reach Sector 4 and confirm pressure is faster but still readable.
- Watch for elite enemies after early ramp-up.
- Confirm elite markers are readable but not boss-sized.
- Confirm elites give extra XP/score and occasionally Neon Dust.
- Confirm bosses still spawn and clear normally.
- Confirm RUN COMPLETE still works.
- Confirm Armory, Stash, Weapon Forge, Core Upgrades, Options, How To Play, pause, and controller input still work.

## 12. Known Issues

- Elite spawn rates are first-pass values and need real playtest tuning.
- Elite Neon Dust is a small chance reward; it may not appear in every short manual test.
- Elite marker visuals are runtime 3D overlays on existing Blender enemies, not new authored Blender variants.
- No enemy weapon-loot drops were added in this phase.

## 13. Approval Question

Is Phase 30 approved as the enemy Wave Director and elite variety foundation, or should the next pass tune elite frequency, sector pacing, or elite readability before Phase 31?
