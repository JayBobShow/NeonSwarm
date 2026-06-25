# Neon Swarm Phase 54C Sector 3 Hazard Planning Report

## Scope

Phase 54C is a docs-only / plan-only Sector 3 hazard planning and QA gate
report.

This report defines one tiny future Sector 3 hazard candidate, the molten busway
warning lane, and the conditions that must be true before any later
implementation is allowed.

This report does not implement hazards. It does not change scripts, scenes,
project settings, art assets, Blender files, GLB files, player behavior,
enemies, projectiles, XP, pickups, HUD, weapons, rewards, collision, bosses,
Sector 4, Sector 5, or alternate scenes.

## Current Sector 3 Status

Phase 53 Sector 3 readability is locked:

- Sector 3 Ember Circuit / Foundry Gate authored arena foundation is complete.
- Sector 3 arena/background readability polish is complete.
- Dense Sector 3 combat readability review is complete.
- Sector 3 hostile projectile readability polish is complete.
- Sector 3 arena, background, player, enemy, projectile, XP, pickup, and HUD
  readability are stable enough for Phase 54 work.

Phase 53 rule carried forward:

- Do not retune Sector 3 arena/background/projectile readability again unless
  new runtime evidence shows a specific readability regression or gameplay
  clarity failure.

Phase 54B Sector 3 pacing status:

- Existing-enemy mix polish is complete.
- Sector 3 now has modest `rail_skimmer` and `grid_splitter` presence in every
  enemy-mix phase.
- Repeated Prism/Null-style pressure was reduced.
- Enemy, projectile, XP, and hazard caps remained respected in validation from
  3.0 Foundry Gate through 3D Cobalt Assembly Line.
- Phase 54B validation observed current hazard pressure as high as `7/10` in
  3C and `6/10` in 3D, so any future hazard must be rare, capped, and gated
  against existing hazard density.

## Why Hazards Are Not Implemented Yet

Hazards are not being implemented in Phase 54C because Sector 3 has only just
received its readability lock and first enemy-mix pacing polish.

A hazard implementation would need runtime scheduling, warning presentation,
damage timing, cap behavior, spawn safety, readability review, and dense combat
QA. Adding that now without a written gate risks:

- Orange-on-orange clutter over the Ember Circuit floor.
- Confusion between hazard warnings and hostile red/orange projectiles.
- Damage appearing under or across the player without a clear warning.
- Hazard stacking during dense projectile pressure.
- Sector 3 drifting toward Sector 4 / Hyper Grid identity instead of Foundry
  Gate identity.
- Reopening Phase 53 arena or projectile readability tuning without new
  evidence.

This report is the QA gate before any future hazard implementation.

## Proposed Future Hazard Candidate

Candidate:

- Molten busway warning lane.

Concept:

- A short, straight, low-profile foundry lane on the X/Z gameplay plane.
- The lane first appears as a readable warning strip.
- After the warning window, it briefly becomes a damaging molten busway pulse.
- It is visual and damage logic only; it must not add gameplay collision or
  imply a raised wall, ramp, or new playable route.

Recommended first implementation shape:

- A narrow rectangular lane segment aligned with Sector 3 busway language.
- No chaining, branching, tracking, maze pattern, or large hazard scheduler in
  the first implementation.
- One active molten busway lane at a time unless later QA proves more is safe.

## Hazard Design Goal

The molten busway warning lane should add a small amount of positional pressure
and Ember Circuit / Foundry Gate identity without becoming a major new system.

It should make Sector 3 feel more industrial, hot, and factory-adjacent while
preserving these priorities:

1. Player readability.
2. Enemy danger readability.
3. Enemy projectile readability.
4. Player projectile readability.
5. XP, pickups, and rewards.
6. HUD readability.
7. Arena/background identity.

## Readability Rules

Any future molten busway lane must:

- Be readable at the official gameplay camera distance before damage begins.
- Stay below player, enemy, projectile, XP, pickup, VFX, and HUD priority.
- Avoid filling the screen with glow, haze, sparks, or wide bloom.
- Use a simple lane silhouette that reads instantly as a floor hazard.
- Keep the lane low-profile and visual-only.
- Avoid visual similarity to player shots, hostile bolts, XP, pickups, boss
  tells, or Sector 4 rail/routing effects.
- Preserve the current darker-faced Ember Circuit floor and controlled neon
  edge language.

If the lane reduces projectile or enemy readability in dense combat, the hazard
must be reduced, delayed, disabled, or rejected before any arena/projectile
retune is considered.

## Warning Timing Rules

Any future implementation must include a clear warning before damage.

Planning rules:

- Warning starts before the damage lane becomes active.
- Warning duration should begin conservatively, with enough time for normal
  movement response at Sector 3 combat speed.
- A future first implementation should test a warning window around `0.75` to
  `1.0` seconds before damage, then tune only if QA proves it is too slow or too
  punishing.
- Damage duration should be short and readable, not a persistent area denial
  field.
- Warning and damage phases must be visually distinct.
- The lane must never become damaging on the same frame it appears.
- The lane must clean up promptly after its active phase.

No final timing values are approved by this report. Timing must be validated in
the later implementation pass if one is separately approved.

## Color Rules

The warning must not be orange-on-orange clutter.

Planning rules:

- Warning should use a darker lane bed with a contrasting readable edge.
- Warning should avoid matching the hostile red/orange projectile core.
- Warning may use white-hot pin lines, pale yellow-white heat ticks, or a
  controlled cobalt/blue safety edge if needed for contrast.
- Damage can lean ember/molten, but it must keep a readable non-orange edge or
  core separation so it does not disappear into the Ember Circuit floor.
- Emission should stay local and controlled.
- Do not brighten the Sector 3 floor to make the hazard work.
- Do not retune Phase 53 hostile projectile materials to make the hazard work.

## Spawn Safety Rules

Any future molten busway lane must:

- Not spawn under the player as active damage.
- Not cross the player as active damage without a readable prior warning.
- Not appear during sector transition safety windows.
- Not appear during reward, level-up, pause, title, intro, or non-combat UI
  states.
- Not trap the player against boundaries, dense enemy bodies, or existing
  hazards without a clear escape route.
- Clear or expire safely on subsector transitions, boss gates, run end, death,
  restart, or scene teardown.
- Respect the established X/Z gameplay plane.
- Avoid adding collision or changing player pathing.

## Density And Cap Rules

The first future implementation must be rare and capped.

Planning rules:

- Start with no more than one active molten busway lane at a time.
- Do not spawn if current hazard pressure is near the existing hazard cap.
- Do not stack during dense enemy projectile pressure.
- Do not stack during boss warning, boss attacks, or heavy run-event pressure.
- Do not create persistent objects that bypass cleanup or existing cap logic.
- Preserve enemy caps, projectile caps, XP caps, hazard caps, VFX caps, and
  performance guardrails.
- Prefer reuse of existing short-lived hazard infrastructure if it can support
  the lane safely without a large new system.

Because Phase 54B validation already saw hazards at `7/10` in 3C, a future
implementation should initially refuse to spawn molten busway lanes when hazard
density is already high.

## When The Hazard Must Not Appear

The molten busway warning lane must not appear:

- In Sector 1, Sector 2, Sector 4, or Sector 5.
- Outside Sector 3 / Ember Circuit content.
- During title, pause, reward, level-up, Armory, story card, memory shard, or
  other non-combat presentation states.
- During boss intro, boss gate warning, or boss active combat until a separate
  boss-hazard pass approves it.
- During subsector transition safety windows.
- Under the player without warning.
- When no safe dodge route exists.
- When enemy projectile count, hazard count, or VFX density is already high.
- When the lane would visually merge with the central bus, diagonal ember
  traces, hostile projectiles, XP, pickups, or HUD.

## Avoiding Enemy Projectile Competition

Enemy projectile readability has priority over the molten busway lane.

Future implementation must:

- Keep hostile bolts clearly hostile and distinct.
- Avoid using the same red/orange core read as hostile projectiles for the
  warning phase.
- Keep the hazard visually floor-bound while hostile bolts remain elevated,
  directional, and projectile-like.
- Avoid bright moving dots, bolt trails, or projectile-shaped warning marks.
- Avoid spawning molten busway lanes during shooter/projectile spikes unless the
  hazard is capped low enough that dense combat remains readable.
- Re-run dense Sector 3 combat capture review before accepting the hazard.

If hostile bolts become harder to read, the hazard implementation fails QA.

## Avoiding Ember Circuit Floor Competition

The hazard must support the Ember Circuit floor without competing with it.

Future implementation must:

- Use the existing darker-faced foundry floor as the base read.
- Keep the warning lane distinct from the central yellow/orange bus and long
  diagonal ember traces.
- Avoid large orange washes or wide glowing strips.
- Prefer a narrow, controlled warning outline over a filled bright lane.
- Keep damage phase short so the arena does not become molten visual noise.
- Avoid changing the authored Sector 3 GLB, Blender source, or Phase 53 material
  overrides unless future evidence shows the floor itself has regressed.

If the lane only works by making the floor darker, brighter, or less Ember-like,
the hazard is not ready.

## Required QA Before Future Implementation Approval

Before any later molten busway implementation can be accepted, QA must cover:

- Official scene only: `scenes/Main.tscn`.
- Official build command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

- Headless boot:

```bash
godot --headless --path . --quit-after 3
```

- Official scene headless validation:

```bash
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
```

- Sector 3 review from 3.0 Foundry Gate through 3D Cobalt Assembly Line.
- Low, medium, and high combat-density review.
- Player readability.
- Enemy readability.
- Enemy projectile readability.
- Player projectile readability.
- XP readability.
- Pickup readability if pickups are present.
- HUD readability.
- Warning readability before damage.
- Proof that damage never begins without warning.
- Proof that the lane does not spawn as active damage under the player.
- Proof that spawn safety windows and transition cleanup are respected.
- Proof that enemy, projectile, XP, hazard, and VFX caps remain respected.
- Proof that Sector 3 still reads as Ember Circuit / Foundry Gate.
- Proof that Sector 3 does not become Sector 4 / Hyper Grid.
- Proof that no gameplay collision was added.
- Proof that no scenes, project settings, Sector 4, Sector 5, bosses, weapons,
  rewards, player visuals, enemy behavior, projectile behavior, XP, pickups, or
  HUD were changed outside the approved scope.
- Git review confirming no alternate scene was created.

Visual QA should include capture review if the future implementation changes
runtime visuals.

## Files Likely To Change If Later Approved

If a later implementation is separately approved, likely files are:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- A future implementation report under `docs/`

Possible only if future scope specifically requires scheduling data:

- `scripts/content/NeonContentCatalog.gd`

Not expected for the first tiny implementation:

- `scenes/Main.tscn`
- `project.godot`
- Sector 3 Blender files
- Sector 3 GLB files
- Art review assets
- Player, enemy, projectile, XP, pickup, HUD, weapon, reward, boss, Sector 4,
  or Sector 5 files

## Approval Gate

This report is not approval to implement hazards.

No molten busway warning lane, Sector 3 hazard, hazard scheduler, hazard visual,
hazard damage behavior, cap change, scene change, art change, or gameplay change
may be implemented without a separate explicit approval.

The next implementation request, if approved, must restate its allowed files,
scope, validation requirements, and QA gates.

## Validation For This Report

This report is docs-only. No Godot runtime validation is required because no
engine, script, scene, project, art, or gameplay file is changed.

Required validation:

- Read back this report after writing.
- Run `git status --short --branch`.
- Confirm no scripts changed.
- Confirm `scenes/Main.tscn` remains untouched.
- Confirm `project.godot` remains untouched.
- Confirm no art, Blender, or GLB files changed.

Official build remains:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

`project.godot` remains expected to launch:

```ini
run/main_scene="res://scenes/Main.tscn"
```

## Code Review

This Phase 54C report changes documentation only.

- Gameplay systems changed: no.
- Scripts changed: no.
- Player changed: no.
- Enemies changed: no.
- Projectiles changed: no.
- XP or pickups changed: no.
- HUD changed: no.
- Weapons changed: no.
- Rewards changed: no.
- Hazards or bosses changed: no.
- Collision changed: no.
- Art, Blender, or GLB files changed: no.
- Sector 4 or Sector 5 changed: no.
- Alternate scenes created: no.
- `scenes/Main.tscn` changed: no.
- `project.godot` changed: no.

## Known Limitations

This report only defines a future hazard candidate and approval gate. It does
not prove the molten busway warning lane will be fun, fair, readable, or worth
shipping. Those questions require a separately approved implementation and QA
pass.
