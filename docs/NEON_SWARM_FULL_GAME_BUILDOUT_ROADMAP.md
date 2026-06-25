# Neon Swarm Full Game Buildout Roadmap

## Phase 56E Current Status Cleanup

This roadmap was updated after Phase 56D so stale planning language does not
imply approval for work that remains gated.

Current locked state:

- Sector 3 Phase 54 is closed for now after the Phase 53 readability work, the
  Phase 54B enemy-mix pacing pass, the Phase 54C hazard gate, and the Phase 54D
  manual QA review.
- Sector 4 Phase 55 is closed for now after the Phase 55B readability polish,
  Phase 55C pressure-headroom tune, and Phase 55D boss-gate / Hollow Warden
  review.
- Sector 5 exists only as inactive/future-locked scaffold data. It is not
  playable and has no title card, entry point, debug jump, gameplay, Crown Shard
  runtime, Null King runtime, or Prism Shard V/VI unlock path.
- `SECTOR_COUNT` remains `4`.
- `ContentCatalog.sector_count()` remains `4`.
- The active campaign remains Sectors 1-4 and still ends after The Hollow
  Warden.
- The Hollow Warden may remain as the current prototype placeholder, but it is
  not production-complete. Any production Hollow Warden work requires separate
  planning and approval.
- The 4A Routing Spine enemy-headroom caveat remains active: low-kill
  auto-advance conditions can still touch `54/54` enemies. Do not add new
  Sector 4 population, boss, event, or hazard pressure until that caveat is
  reviewed again.
- Not approved by this roadmap cleanup: Sector 5 runtime, Crown Shard runtime,
  Null King runtime, Prism Shards V/VI runtime unlocks, new hazards, new
  weapons, boss production, large systems, alternate scenes, or Sector 3/4 visual
  presentation changes.

## Phase 52 Scope

Phase 52 moves Neon Swarm from hotfix work back into locked production planning.
This document audits the current runtime state, defines the remaining buildout
sequence, and locks the first next step: Sector 3 Ember Circuit runtime
foundation only.

This phase does not build the whole game, does not start Sector 4 or Sector 5
production, and does not change weapons, equipment, player movement, HUD,
cursor behavior, or existing Sector 1 / Sector 2 arena art.

Official runtime scene remains:

- `scenes/Main.tscn`

## Current Game Audit

### Sector Progression

Current active runtime sector count is four via `SECTOR_COUNT := 4`.

Active runtime sectors:

| Sector | Name | Runtime status |
| --- | --- | --- |
| 1 | Neon Grid | Active. Base arena and 1A-1D subsector arena variants exist. |
| 2 | Prism Rift | Active. Base arena and 2A-2D subsector arena variants exist. |
| 3 | Ember Circuit | Active. Phase 54 is closed for now after arena readability, enemy projectile readability, enemy-mix pacing, hazard planning, and manual QA closeout. No new Sector 3 hazards are approved. |
| 4 | Hyper Grid | Active. Phase 55 is closed for now after readability, pressure-headroom, and boss-gate review. The 4A `54/54` enemy-headroom caveat remains active. |

Future story-locked sector:

| Sector | Name | Runtime status |
| --- | --- | --- |
| 5 | The Black Crown | Inactive/future-locked scaffold data only. Not playable and not active runtime content. |

Current campaign route:

- Sector 1: 1.0 Awakening Grid, 1A Relay Yard, 1B Data Trench, 1C Capacitor Field, 1D Rail Approach, Grix.
- Sector 2: 2.0 Prism Gate, 2A Mirror Flats, 2B Fracture Hall, 2C Violet Glassway, 2D Rift Lens, Veyraxis.
- Sector 3: 3.0 Foundry Gate, 3A Molten Busway, 3B Furnace Grid, 3C Weapon Memory Forge, 3D Cobalt Assembly Line, Lord Cobalt Hex.
- Sector 4: 4.0 Storm Entry, 4A Routing Spine, 4B Overclock Field, 4C Signal Cyclone, 4D Lockbreaker Gate, The Hollow Warden.

### Current Bosses

Active boss identity data exists for:

- Sector 1: Grix the Rail Butcher, runtime type `mini_boss`.
- Sector 2: Veyraxis, Prism Widow, runtime type `fractal_crown`.
- Sector 3: Lord Cobalt Hex, runtime type `null_octagon`.
- Sector 4: The Hollow Warden, runtime type `final_null_octagon`.

Future story-locked boss data exists for:

- The Crown Shard.
- The Null King, Crown of the Empty Grid.

Current boss lock:

- The Hollow Warden can remain as the current prototype placeholder after the
  Phase 55D review, but it is not production-complete.
- The Crown Shard and The Null King remain future-only. Their runtime behavior,
  rewards, boss cards, and gameplay routes are not approved.

### Current Enemy Families

Runtime enemy families currently include:

- Chaser
- Tank
- Shooter
- Exploder
- Spiral Drifter
- Shield Node
- Hex Slicer
- Prism Leech
- Triad Splitter and Triad Fragment
- Hex Pulser
- Rail Skimmer
- Grid Splitter and Grid Fragment
- Current boss families

Sector enemy mixes are already weighted per sector in `NeonContentCatalog.gd`.
Sector 3 currently reuses existing families with heavier pressure instead of
shipping a final Ember-specific enemy set.

### Current Weapon System

Current approved weapon behavior:

- Automatic firing is restored.
- Active weapons fire without held mouse/controller buttons.
- Shots follow manual mouse/right-stick aim direction.
- No nearest-enemy auto-aim for normal player shots.
- Passive weapons trigger automatically from their own cooldowns.
- Empty slots do not fire.
- Locked slots do not fire.

Existing weapon framework includes multiple active/passive families, cooldowns,
projectile logic, damage/rate/range modifiers, temporary run weapons, rarity and
stat-roll support, weapon stash support, and forge/evolution foundations.

### Current Equipment And Armory

The equipment system currently supports:

- Active/passive equipment classification.
- Up to eight equipment slots.
- Locked and empty slot states.
- Active fire binding labels even though auto-fire is now the default.
- Equipment HUD display.
- Title Armory.
- Pause Armory / in-run equipment management.
- Stash and swap flows.
- Neon Dust and forge/evolution support.

Phase 52 does not alter equipment mechanics or UI layout.

### Save And Progression Support

Current save/progression support includes:

- Settings saved through `user://neon_swarm_settings.cfg`.
- Weapon inventory/loadout/stash saved through `user://neon_swarm_weapon_inventory.cfg`.
- Neon Dust support.
- Core upgrade/meta-progression foundations.
- Memory Shard runtime unlock presentation for the four active bosses.

Remaining save/meta work is deeper persistence, completion tracking, unlock
review UI, profile polish, and migration-safe expansion for future systems.

### Story And Dialogue Support

Implemented story/dialogue foundations include:

- Opening intro sequence.
- Lyra companion/tutorial lines.
- Sector story cards.
- Boss identity cards.
- Boss warning/defeat flavor.
- Memory Shard reveal panel for active sectors.
- Future story-locked notes for Sector 5 and the Null King path.

Remaining story work is a stronger intro pass, deeper NPC/guide dialogue,
sector-specific barks, Lore Codex/review support, Sector 5 story runtime, and
ending/final boss presentation.

### Audio And VFX Support

Current audio/VFX foundations include:

- Procedural sound and music state support.
- Options/audio mute and volume handling.
- Combat VFX for weapons, projectiles, bursts, XP, hazards, and boss telegraphs.
- Sector environment tinting and glow support.
- Readability/vibrance passes for Sector 1 and Sector 2.

Remaining work is authored music/SFX direction, sector-specific ambience,
boss audio identity, VFX polish, performance budgets, and final mix.

### Known Missing Systems

High-priority missing or incomplete systems that still require separate approval:

- Optional future Sector 3 production polish only if new evidence shows a need.
  Phase 54 is closed for now, and new Sector 3 hazards remain blocked by the
  Phase 54C/54D hazard gate.
- Optional future Sector 4 pressure or production work only after the 4A `54/54`
  enemy-headroom caveat is reviewed again.
- Hollow Warden production boss planning. The current Hollow Warden remains a
  prototype placeholder, not a finished production boss.
- Sector 5 Black Crown runtime foundation. The current Sector 5 scaffold is
  inactive/future-locked data only.
- Crown Shard and Null King runtime paths. These remain blocked until a separate
  approved Sector 5 runtime route exists.
- Expanded weapon families and stronger build synergies.
- Stronger meta progression and save/profile UX.
- Deeper story/NPC/Lyra pass.
- Professional audio/VFX polish.
- Full balance and performance pass.
- Release cleanup/export QA.

## Production Roadmap

### Phase 52 - Full-game Roadmap And Production Locks

Goal: Audit current state, lock the rest of the production roadmap, and add only
the safe Sector 3 Ember Circuit runtime foundation.

Deliverables:

- Full-game buildout roadmap.
- Phase 52 report.
- Sector 3 identity constants/status.
- Sector 3 Ember foundation visual routing.
- Sector 3 debug/test access.

### Phase 53 - Sector 3 Ember Circuit Arena Foundation And Readability

Status: Complete and locked unless new evidence shows a readability failure.

Completed work:

- Replaced the temporary Sector 3 legacy foundation plate with authored Ember
  Circuit / Foundry Gate arena art.
- Completed arena readability polish.
- Completed dense combat readability review.
- Completed enemy projectile readability polish.

Locks:

- No Sector 4/5 work.
- No weapon mechanic changes.
- Visual-only collision decisions documented.

### Phase 54 - Sector 3 Enemy Mix, Hazard Gate, And Closeout

Status: Complete and closed for now.

Completed work:

- Phase 54B accepted the narrow existing-enemy mix pacing pass.
- Phase 54C created a planning-only molten busway warning-lane hazard gate.
- Phase 54D manual playtest / QA gate passed.
- Molten busway hazard implementation is delayed and not approved.
- Late Sector 3 hazard pressure can already hit `10/10`; no new Sector 3 hazard
  should be added without stronger hazard-cap gating and separate approval.

### Phase 55 - Sector 4 Readability, Pressure, And Boss-Gate Closeout

Status: Complete and closed for now.

Completed work:

- Phase 55B Sector 4 Hyper Grid readability polish passed.
- Phase 55C pressure-headroom tune passed.
- Phase 55D boss-gate / Hollow Warden review passed.
- Known caveat: 4A Routing Spine can still touch `54/54` enemies under low-kill
  auto-advance conditions.
- Do not add new Sector 4 population pressure, boss pressure, event pressure, or
  hazard pressure until the 4A caveat is reviewed again.
- Hollow Warden can remain as the current prototype placeholder, but it is not
  production-complete.

### Phase 56 - Sector 5 Planning Gate And Inactive Scaffold

Status: Current Sector 5 work is planning/scaffold only; runtime remains locked.

Completed work:

- Phase 56A reviewed four-sector readiness before Sector 5 planning.
- Phase 56B created the Sector 5 Black Crown planning gate.
- Phase 56C added inactive/future-locked Sector 5 scaffold data while keeping
  `SECTOR_COUNT := 4` and `ContentCatalog.sector_count() == 4`.
- Phase 56D four-sector regression QA passed and confirmed no Sector 5 runtime
  leak.

Current locks:

- Sector 5 is not playable.
- The active campaign remains Sectors 1-4.
- Hollow Warden still ends the run.
- Prism Shards V/VI, Crown Shard, and Null King remain future-only.
- No Sector 5 runtime implementation is approved.

### Future Approved Phase - Sector 5 Black Crown Runtime Foundation

Goal: Add The Black Crown runtime foundation only after Sectors 3 and 4 are
stable, the Phase 56 planning gates are satisfied, and a separate implementation
phase is approved.

Locks:

- Keep `SECTOR_COUNT` at `4` until runtime activation is separately approved.
- Do not unlock Prism Shards V/VI until their runtime path is separately
  approved.
- No Crown Shard or Null King gameplay in the first runtime foundation unless a
  later phase explicitly scopes it.
- No ending sequence until the Sector 5 route exists.

### Future Approved Phase - Hollow Warden Production Planning

Goal: Plan production-quality Hollow Warden work without changing runtime boss
behavior until separately approved.

Locks:

- The current Hollow Warden remains a prototype placeholder.
- Do not add new boss pressure while the 4A enemy-headroom caveat remains active.

### Future Approved Phase - Null King Final Boss Path

Goal: Add Crown Shard / Null King final path, final combat structure, and ending
presentation foundation.

### Phase 61 - Weapon Stash And Randomized Stats Hardening

Goal: Polish the existing stash/random-stat systems into production quality.

Work areas:

- Comparison clarity.
- Loot routing.
- Stash capacity UX.
- Stat roll readability.
- Save migration safety.

### Phase 62 - Expanded Weapon Families

Goal: Add new weapon families and build synergies without breaking the approved
auto-fire/manual-aim behavior.

### Phase 63 - Story Intro And NPC Dialogue Pass

Goal: Polish opening story, Lyra guidance, sector story pacing, and NPC/guide
dialogue foundations.

### Phase 64 - Save And Meta Progression

Goal: Build stronger persistent progression around Neon Dust, core upgrades,
weapon memory, shard unlocks, and future profile UI.

### Phase 65 - Audio And VFX Polish

Goal: Replace placeholder-feeling audio/VFX with sector-appropriate presentation
while preserving gameplay readability.

### Phase 66 - Balance And Performance Pass

Goal: Tune enemy scaling, weapons, bosses, spawn caps, reward pacing, and
performance budgets across the whole campaign.

### Phase 67 - Release Cleanup

Goal: Final export QA, settings polish, crash/error cleanup, documentation
cleanup, credits/legal checks, and release candidate validation.

## Phase Locks

- Build only one approved phase at a time.
- Keep `scenes/Main.tscn` as the official scene.
- Do not activate Sector 5 until a dedicated approved phase.
- Do not build Null King content before Sector 5 exists.
- Do not rewrite working systems for unrelated goals.
- Preserve approved auto-fire/manual-aim behavior.
- Preserve equipment slots, Armory, pause Armory, custom cursor, HUD layout, and
  player movement unless a future phase explicitly approves changes.
