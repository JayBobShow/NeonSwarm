# Neon Swarm Phase 34 Run Objective / Sector Event Variety Report

## 1. Executive Summary

Phase 34 adds a lightweight Run Event Director to the official build only: `scenes/Main.tscn`.

The system adds readable mid-run sector objectives on top of the existing survival loop. It does not replace sector progression, boss flow, Wave Director pacing, weapon rewards, Armory/Stash, Forge, Evolution/Fusion, Neon Dust, or save compatibility.

Implemented event types:

- Data Cache
- Rift Surge
- Elite Hunt
- Overload Shrine / Power Node

## 2. Event Types Implemented

Data Cache:

- Spawns a glowing square/cube neon cache marker in the arena.
- Player holds near the cache to sync it.
- Progress is shown through combat HUD notices at 25/50/75/100 percent.
- Success grants score, XP burst pickups, and a small Neon Dust chance.
- Timeout safely fails the event.

Rift Surge:

- Spawns a rift marker with a warning phase before danger begins.
- After the warning, short-lived hazard pulses appear near the player and pressure enemies spawn at controlled intervals.
- Surviving the timer grants score, XP burst pickups, and a small Neon Dust chance.
- Run-event hazards are tagged so cleanup can remove only event-owned hazards.

Elite Hunt:

- Spawns a marked elite target using existing enemy families and elite variants.
- Target gets a gold target-ring marker.
- Killing the marked target before timeout grants bonus score, XP pickups, and a small Neon Dust chance.
- Timeout or target loss ends safely without soft-locking the run.

Overload Shrine / Power Node:

- Spawns a stationary hex power node.
- Player holds near it to trigger an overload.
- Overload creates short risk pressure through capped hazard pulses and pressure enemy spawns.
- Surviving overload grants score, XP pickups, and a small Neon Dust chance.

## 3. How Each Event Works

The Run Event Director runs only during active gameplay.

It does not start events when:

- Title menu is active.
- Armory or Forge are open.
- Pause, death, or run-complete state is active.
- Level-up, sector reward, or weapon-reward decision UI is active.
- A boss is active, already spawned, warning, or too close to its scheduled spawn window.

Event cadence:

- Sector 1 starts later and allows fewer events.
- Later sectors allow slightly more event pressure.
- Only one event can be active at a time.
- Cooldowns prevent event spam.
- Events do not block boss spawns or sector progression.

## 4. Reward Behavior

Rewards are intentionally modest.

On event success:

- Score bonus is granted immediately.
- Several XP pickups are spawned in a readable burst around the objective.
- Neon Dust can be awarded through a capped chance.
- HUD notice reports completion and reward.

Reward scaling:

- Later sectors grant slightly larger score, XP, and dust chance.
- Data Cache is the simplest reward event.
- Rift Surge, Elite Hunt, and Overload Shrine grant higher rewards because they add more risk.

No direct weapon drops were added in Phase 34.

## 5. Cleanup Behavior

Events clear safely when:

- A boss spawns.
- Sector reward flow begins.
- Sector transition cleanup runs.
- Player returns to title.
- Player dies.
- Run completes.
- Restart is requested.

Cleanup removes:

- Active event marker nodes.
- Elite Hunt target markers.
- Run-event-owned hazard rings.
- Event timers/progress/target references.

Non-event hazards, boss telegraphs, weapon projectiles, inventory data, progression data, and save files are not cleared by event-only cleanup.

## 6. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_34_RUN_OBJECTIVE_SECTOR_EVENT_VARIETY_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

Focused validation helper:

- `/tmp/neon_swarm_phase34_run_event_validation.gd`

## 7. Validation Results

Passed:

- `godot --headless --path . --script /tmp/neon_swarm_phase34_run_event_validation.gd`

Required validation completed:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`

Focused validation covered:

- Event director does not start events on title.
- Event director does not start events in Armory or Forge.
- Data Cache success reward path.
- Rift Surge warning/surge/hazard cleanup path.
- Elite Hunt target marker and success reward path.
- Overload Shrine trigger, overload, and success reward path.
- Boss spawn clears active event state.
- Return to Title clears active event state.
- Death clears active event state.

## 8. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 9. What I Should Test

- Start a run and watch Sector 1 for a Data Cache or Elite Hunt objective after the early ramp.
- Stand near a Data Cache and confirm the progress notices and reward burst.
- Survive a Rift Surge and confirm warning appears before hazard pressure begins.
- Kill an Elite Hunt target and confirm the marked elite grants the objective reward.
- Hold near an Overload Shrine, survive the overload, and confirm reward.
- Confirm events stop before boss fights.
- Confirm returning to title, dying, restarting, and completing a run leaves no active event markers or hazards behind.
- Confirm Armory, Forge, Evolution/Fusion, Neon Dust, sector rewards, weapon rewards, Wave Director, bosses, and controller support still work.

## 10. Known Issues

- Event frequency and reward values are first-pass tuning and should be manually adjusted after playtesting.
- Objective markers are runtime mesh markers, not Blender-authored final event props yet.
- Events currently reward XP/score/Neon Dust chance only; they do not directly advance weapon reward progress.
- No new event-specific music layer was added.

## 11. Approval Question

Is Phase 34 approved as the Run Objective / Sector Event Variety foundation, or should event frequency, objective readability, or reward values be tuned before Phase 35 is considered?
