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

## Phase 34 Hotfix — Event Testability / Readability Pass

This is a Phase 34 hotfix only. Phase 35 was not started.

### Event Test Mode Controls

Temporary developer event test mode now works during an active run only.

Controls:

- `F6`: Toggle `EVENT TEST MODE` on/off.
- `F7`: Cycle selected test event.
- `F8`: Force-spawn selected test event.
- `F9`: Clear the active event safely.

Cycle order:

1. Data Cache
2. Rift Surge
3. Elite Hunt
4. Overload Shrine / Power Node

Guardrails:

- Hotkeys do not work on the title menu.
- Hotkeys do not work in Armory, Forge, Options, How To Play, pause, reward screens, game over, or run complete.
- Test mode does not replace normal random event spawning.
- Test mode does not increase event frequency unless the player explicitly uses it.
- Force-spawn is blocked during boss windows.

### Test HUD

When enabled, the gameplay HUD shows:

- `EVENT TEST MODE`
- Selected event name
- `F7 CYCLE | F8 SPAWN | F9 CLEAR`
- Active event state and timer

The test HUD is hidden outside active gameplay.

### Event Readability Changes

Data Cache:

- Larger dark cube/cache body.
- Brighter cyan square route rings.
- Brighter gold core.
- Floating `DATA CACHE` label.
- HUD text now says `DATA CACHE // SYNCING: HOLD NEAR CACHE`.
- Progress text says `DATA CACHE SYNCING`.
- Completion notice says `DATA CACHE COMPLETE`.

Rift Surge:

- Larger magenta warning annulus.
- Added visible warning-zone ring before pressure begins.
- Larger cyan inner prism ring and dark anchor.
- Floating `RIFT SURGE` label.
- HUD text now shows a short warning countdown before danger starts.
- Active text says `RIFT SURGE // SURVIVE`.
- Completion notice says `RIFT SURGE COMPLETE`.

Elite Hunt:

- Target marker rings are larger and brighter.
- Added floating `ELITE HUNT` label on the marked target.
- HUD text says `ELITE HUNT // TARGET MARKED`.
- Kill notice says `ELITE HUNT // TARGET DOWN`.
- Failure notices say target escaped or target lost.

Overload Shrine / Power Node:

- Larger dark hex node body.
- Larger magenta trigger ring.
- Added large proximity ring.
- Brighter white/cyan core.
- Floating `OVERLOAD NODE` label.
- HUD text says `OVERLOAD NODE // APPROACH NODE TO TRIGGER`.
- Active text says `OVERLOAD NODE // OVERLOAD ACTIVE`.
- Completion notice says `OVERLOAD NODE COMPLETE`.

### What The User Should Test

- Start a run.
- Press `F6` to enable Event Test Mode.
- Press `F7` until `DATA CACHE` is selected, then `F8` to spawn it.
- Press `F9` to clear it.
- Repeat for `RIFT SURGE`, `ELITE HUNT`, and `OVERLOAD NODE`.
- Confirm each event is visually obvious before interacting with it.
- Confirm Rift Surge gives warning text/countdown before hazard pressure starts.
- Confirm Overload Node is easy to see and says to approach it.
- Confirm F6/F7/F8/F9 do nothing in title/menu/Armory/Forge/reward/game-over states.
- Confirm normal random event spawning still works when test mode is not used.

## Repair 2 — Event Object Identity and Player Instruction Clarity

This is still Phase 34 repair work. Phase 35 was not started.

Repair 2 changes the events from bright generic markers into clearer objective props with a persistent objective instruction panel. The goal is that each event answers what it is, whether it is safe or dangerous, what to do, and what progress/time remains within two seconds.

### Shared Objective Panel

Added a large event objective panel near the top-center of the gameplay HUD.

The panel is visible while an event is active and hidden in title/menu/Armory/Forge/pause/reward/game-over/run-complete states.

It uses plain action text:

- `STAND INSIDE THE RING`
- `LEAVE THE RED RIFT ZONE`
- `DESTROY THE MARKED TARGET`
- `OPTIONAL: ENTER THE RING TO START CHALLENGE`

### Data Cache Identity

Visual identity:

- Low futuristic data terminal/cache body.
- Solid dark 3D terminal box.
- Cyan/blue neon circuit panels.
- Neon tube edge framing.
- Vertical cyan data beam.
- Large floor capture/sync ring.
- Four visible progress segments around the object.
- Floating label: `DATA CACHE / STAND IN RING`.

Instruction text:

- `DATA CACHE FOUND`
- `STAND INSIDE THE RING TO SYNC`
- `SYNCING: XX%`
- `RETURN TO THE CACHE RING`
- `CACHE COMPLETE: XP + SCORE`

Player meaning:

- Stand inside the ring until the sync reaches 100 percent.
- Leaving the ring stops forward progress and asks the player to return.

### Rift Surge Identity

Visual identity:

- Large magenta/red/purple rift danger zone.
- Red floor warning zone ring.
- Pulsing danger stripes around the zone.
- Vertical cracked portal/tear shape.
- Cyan inner prism ring and dark cracked anchor.
- Floating label: `RIFT SURGE / LEAVE RED ZONE`.

Instruction text:

- `RIFT SURGE WARNING`
- `LEAVE THE RED RIFT ZONE`
- `SURGE IN: X.X`
- `RIFT SURGE ACTIVE`
- `DODGE THE PULSES`
- `RIFT SURGE SURVIVED: BONUS XP`

Player meaning:

- Red/purple rift area is dangerous.
- Leave the zone during the countdown.
- Dodge pulse hazards during the active surge.

### Elite Hunt Identity

Visual identity:

- Existing marked moving elite target preserved.
- Larger/brighter gold horizontal and vertical target rings.
- White-hot target dot.
- Floating label: `ELITE HUNT`.

Instruction text:

- `ELITE HUNT`
- `DESTROY THE MARKED TARGET`
- `TIME LEFT: XX`
- `ELITE DESTROYED: BONUS REWARD`
- `ELITE ESCAPED`

Player meaning:

- Chase and kill the marked elite before time runs out.

### Overload Node Identity

Visual identity:

- Tall stationary 3D power pylon/shrine.
- Dark hex pylon body.
- Bright yellow/orange/white core.
- Neon pylon edge framing.
- Large optional challenge activation radius.
- Hex activation ring.
- Power conduits from pylon to ring.
- Floating label: `OVERLOAD NODE / OPTIONAL CHALLENGE`.

Instruction text:

- `OVERLOAD NODE`
- `OPTIONAL: ENTER THE RING TO START CHALLENGE`
- `OVERLOAD STARTED`
- `SURVIVE UNTIL THE NODE DISCHARGES`
- `PRESSURE BUILDING: XX%`
- `OVERLOAD ACTIVE: SURVIVE`
- `TIME LEFT: XX`
- `OVERLOAD COMPLETE: NEON DUST CHANCE`
- `OVERLOAD ENDED`

Player meaning:

- This is optional.
- Enter the ring to start the challenge.
- Survive until the node discharges for a reward chance.

### What The User Should Test For Repair 2

- Use `F6` to enable Event Test Mode during an active run.
- Use `F7` and `F8` to force each event.
- Confirm the objective panel is large enough to read during combat.
- Confirm Data Cache looks like a terminal/cache and clearly says to stand inside the ring.
- Confirm Rift Surge looks dangerous before it becomes active and clearly says to leave the red zone.
- Confirm Overload Node looks like a tall power shrine and clearly says the challenge is optional.
- Confirm Elite Hunt remains readable and clearly tells the player to destroy the marked target.
- Confirm `F9` clears each event safely.
- Confirm no event persists into title/menu/Armory/Forge/death/restart/boss/reward states.
