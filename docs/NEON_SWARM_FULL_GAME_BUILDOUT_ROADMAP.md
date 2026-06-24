# Neon Swarm Full Game Buildout Roadmap

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
| 3 | Ember Circuit | Active in campaign/content data. Phase 52 adds a runtime-loadable Ember foundation visual/debug path. |
| 4 | Hyper Grid | Active prior work. Not expanded in Phase 52. |

Future story-locked sector:

| Sector | Name | Runtime status |
| --- | --- | --- |
| 5 | The Black Crown | Data/planning only. Not active runtime content. |

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

Phase 52 does not add or redesign boss attacks.

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

High-priority missing or incomplete systems:

- Final Sector 3 authored arena art and subsector variants.
- Sector 3 Ember-specific enemies and hazards.
- Sector 3 boss production pass.
- Sector 4 production review and finalization after Sector 3 is stable.
- Sector 5 Black Crown runtime foundation.
- Null King final boss path.
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

### Phase 53 - Sector 3 Ember Circuit Arena Foundation Art

Goal: Replace the temporary Sector 3 legacy HD plate with authored Ember Circuit
base arena art and Blender/GLB layout as approved.

Locks:

- No Sector 4/5 work.
- No weapon mechanic changes.
- Visual-only collision decisions documented.

### Phase 54 - Sector 3 Enemies And Hazards

Goal: Add Ember-specific enemy pressure and industrial heat/circuit hazards with
clear silhouettes and strict caps.

Candidate enemy/hazard directions:

- Forge drone
- Heat runner
- Furnace pulse node
- Molten busway warning lanes

### Phase 55 - Sector 3 Boss Production Pass

Goal: Produce Lord Cobalt Hex as a distinct Sector 3 boss encounter instead of a
placeholder runtime boss mapping.

Scope:

- Boss model/presentation.
- Readable attack kit.
- Sector 3 boss gate polish.
- No final boss work.

### Phase 56 - Sector 4 Hyper Grid Foundation Review

Goal: Review existing Hyper Grid content, lock what remains approved, and define
only the missing foundation gaps before deeper Sector 4 production.

### Phase 57 - Sector 4 Enemies And Hazards

Goal: Expand Hyper Grid with speed/rail/routing enemies and hazards while
preserving performance and readability.

### Phase 58 - Sector 4 Boss Production Pass

Goal: Build The Hollow Warden into a production-quality Sector 4 boss path.

### Phase 59 - Sector 5 Black Crown Foundation

Goal: Add The Black Crown runtime foundation only after Sectors 3 and 4 are
stable and approved.

Locks:

- No Null King final fight until Phase 60.
- No ending sequence until the Sector 5 route exists.

### Phase 60 - Null King Final Boss Path

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

