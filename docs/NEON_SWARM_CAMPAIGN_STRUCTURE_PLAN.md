# Neon Swarm Campaign Structure Plan

## Phase 46 Scope

Phase 46 locks the intended campaign structure for expanding Neon Swarm from a
short sector-to-boss run into a longer RPG-style roguelite journey.

This plan does not implement subsector runtime progression, new arenas, Sector
5 runtime content, the Null King stage, a Lore Codex menu, or an ending
sequence. It is a structure and pacing lock for future approved phases.

## Story Impact Rule

The subsector expansion does not rewrite the main story. It adds travel depth,
pacing, buildup, and identity between each sector entry and boss gate.

The intended story rhythm is:

1. Enter a major sector.
2. Push through named subsectors.
3. Learn small hints through Lyra, environment names, enemies, and events.
4. Reach the sector commander.
5. Defeat the boss.
6. Recover the major Memory Shard.
7. Move deeper into the Neon Grid.

Major story reveals remain tied to boss / sector clears and Memory Shards.
Subsectors may carry smaller hints, pressure changes, event flavor, and Lyra
comments, but they should not spam major lore reveals.

## Runtime Scope Lock

Active current sectors:

- Sector 1: Neon Grid
- Sector 2: Prism Rift
- Sector 3: Ember Circuit
- Sector 4: Hyper Grid

Future story-locked only:

- Sector 5: The Black Crown

The Crown Shard, The Null King, Prism Shard V, and Prism Shard VI remain future
story-locked content until a later approved Sector 5 / final boss phase.

## Official Campaign Structure

### Sector 1 - Neon Grid

Main story role: Awakening. Nova wakes, Lyra finds the Aether Core signal, and
the player learns the Grid is broken but alive.

| Step | Name | Purpose |
| --- | --- | --- |
| 1.0 | Awakening Grid | Nova wakes up. First combat survival space. |
| 1A | Relay Yard | Lyra begins tracing the broken Grid signal. |
| 1B | Data Trench | The player pushes through corrupted Grid memory channels. |
| 1C | Capacitor Field | The Aether Core begins adapting and storing weapon memory. |
| 1D | Rail Approach | Final approach to Grix's defense gate. |

Boss: Grix the Rail Butcher

Memory Shard: PRISM SHARD I — THE PILOT

Story reveal: Nova Veyr was not born as the Core. Nova entered it willingly.

### Sector 2 - Prism Rift

Main story role: First memory of Mira. The sector reflects broken memories and
unstable voices.

| Step | Name | Purpose |
| --- | --- | --- |
| 2.0 | Prism Gate | Entry into the fractured mirror dimension. |
| 2A | Mirror Flats | The floor and enemies distort into reflected patterns. |
| 2B | Fracture Hall | Nova begins hearing impossible signal echoes. |
| 2C | Violet Glassway | Mira's voice becomes clearer through Prism Shards. |
| 2D | Rift Lens | Final focus point before Veyraxis. |

Boss: Veyraxis, Prism Widow

Memory Shard: PRISM SHARD II — MIRA’S VOICE

Story reveal: Mira Sol's voice echoes from inside the Prism Shards.

### Sector 3 - Ember Circuit

Main story role: The war begins / old weapon factory. The player learns the
Aether Core was built as part of the first Null invasion war.

| Step | Name | Purpose |
| --- | --- | --- |
| 3.0 | Foundry Gate | Entry into the corrupted weapon foundry. |
| 3A | Molten Busway | The player crosses unstable power channels. |
| 3B | Furnace Grid | Old Grid machinery is burning itself alive. |
| 3C | Weapon Memory Forge | The story connects weapons, Forge, and combat memories. |
| 3D | Cobalt Assembly Line | Final production corridor before Lord Cobalt Hex. |

Boss: Lord Cobalt Hex

Memory Shard: PRISM SHARD III — THE FIRST INVASION

Story reveal: The Aether Core weapon system was built to fight the first Null
invasion.

### Sector 4 - Hyper Grid

Main story role: Truth of the seal. Nova learns Mira became the lock holding
the Null King back.

| Step | Name | Purpose |
| --- | --- | --- |
| 4.0 | Storm Entry | Entry into the central routing storm. |
| 4A | Routing Spine | The player fights through the Grid's main signal bones. |
| 4B | Overclock Field | Enemies and events become faster and more aggressive. |
| 4C | Signal Cyclone | Mira's signal and Null interference collide. |
| 4D | Lockbreaker Gate | Final defense before The Hollow Warden. |

Boss: The Hollow Warden

Memory Shard: PRISM SHARD IV — THE LIVING LOCK

Story reveal: Mira became the living lock that held the Null King in the dark.

### Future Sector 5 - The Black Crown

Status: future story-locked only. Do not activate as current runtime content
until a later approved phase builds real Sector 5 / final boss support.

Main story role: Final assault. Nova enters the dead center of the Grid to save
Mira and confront the Null King.

| Step | Name | Purpose |
| --- | --- | --- |
| 5.0 | Dead Grid | Entry into dead-space Grid territory. |
| 5A | Crown Wound | The first breach inside the Null King's influence. |
| 5B | Silent Starfield | Stars exist here, but no longer emit sound or memory. |
| 5C | Null Cathedral | The final architecture of the Null King's philosophy. |
| 5D | Mira's Prison | Nova reaches the place where Mira's living light holds the lock. |

Future boss: The Crown Shard

Future final boss: The Null King, Crown of the Empty Grid

Future Memory Shards:

- PRISM SHARD V — THE BLACK CROWN
- PRISM SHARD VI — THE LAST LIGHT

## Gameplay Pacing Plan

Each major sector should eventually feel like:

1. Entry arena
2. Escalation arena
3. Pressure arena
4. Identity arena
5. Boss approach arena
6. Boss fight

Each subsector should eventually support:

- A distinct arena layout or visual variant.
- Enemy pressure increase.
- Possible event or objective.
- Reward pacing.
- Lyra commentary.
- Story hint.
- Transition to the next subsector.

Bosses should remain major gates, not every-arena interruptions.

Memory Shards should remain major boss / sector-clear rewards, not subsector
collectibles or frequent lore spam.

## Future Runtime / Data Structure Plan

Future runtime work should centralize campaign data before activating expanded
progression. Recommended data fields:

- `sector_id`
- `sector_index`
- `runtime_status`: `active` or `future_story_locked`
- `sector_name`
- `story_role`
- `subsectors`
- `boss_name`
- `memory_shard_id`
- `story_reveal`
- `arena_key` or visual variant key, once arena work exists
- `enemy_profile_key`, once balancing work exists

Recommended future structure names:

- `CAMPAIGN_STRUCTURE_DATA`
- `ACTIVE_CAMPAIGN_SECTORS`
- `FUTURE_CAMPAIGN_SECTORS`

Phase 46 did not add runtime data. Phase 47 adds the first safe runtime
campaign data shape and activates subsector progression with placeholder/current
arena visuals only.

Future runtime rules:

- Keep four active runtime sectors until a real Sector 5 phase is approved.
- Do not make Sector 5 appear in normal runtime progression accidentally.
- Do not break Phase 45 Memory Shard unlocks.
- Do not break Phase 44 four-active-boss scope.
- Do not change save schemas without a migration plan.
- Do not require new playable scenes; the official scene remains
  `scenes/Main.tscn`.

## Phase 47 Runtime Foundation Status

Phase 47 activates the first safe runtime foundation for the active four-sector
campaign route.

Implemented:

- Four active campaign sectors load from centralized runtime campaign data.
- Each active sector has five runtime subsectors plus a boss gate.
- Normal subsectors advance on a simple `18.0` second timer when menus, rewards,
  run events, boss states, game over, and run success are not blocking
  progression.
- Boss warning and boss spawn timers run only after the final approach
  subsector reaches the boss gate.
- Existing sector arena visuals are reused as placeholders across subsectors
  until a sector-specific art pass replaces that sector's placeholders.
- Subsector title cards reuse the existing sector story card style.
- The gameplay HUD includes the current campaign node.
- F11 advances the campaign node only while the existing F6 event test mode is
  enabled.

Phase 48 Sector 1 art status:

- 1.0 Awakening Grid continues to use the approved base Sector 1 arena.
- 1A Relay Yard, 1B Data Trench, 1C Capacitor Field, and 1D Rail Approach now
  load visual-only Sector 1 GLB overlays through the Phase 47 campaign runtime.
- Rail Approach remains the visual approach during the Grix boss gate after 1D.
- Memory Shard I remains tied to Grix defeat, not normal subsector clears.
- No Sector 2, Sector 3, Sector 4, or Sector 5 subsector arena art is added by
  Phase 48.

Still deferred:

- Sector 2, Sector 3, and Sector 4 custom subsector arena art.
- Sector 5 runtime.
- Crown Shard / Null King runtime.
- Ending sequence.
- Lore Codex menu.
- Save-schema changes.

## Future Implementation Roadmap

| Phase | Focus | Goal |
| --- | --- | --- |
| Phase 46 | Sector/Subsector Campaign Structure Expansion Plan | Lock structure, names, pacing, story purpose, and future implementation rules. |
| Phase 47 | Campaign Progression Runtime Foundation | Implemented first runtime subsector progression foundation using placeholder/current arenas. |
| Phase 48 | Sector 1 Subsector Arena Content Pass | Implemented visual-only 1A-1D Neon Grid arena variants safely. |
| Phase 49 | Sector 2 Subsector Arena Content Pass | Build playable 2A-2D variants using Prism Rift art direction and the user reference workflow. |
| Phase 50 | Sector 3 Subsector Arena Content Pass | Build playable Ember Circuit subsector variants. |
| Phase 51 | Sector 4 Subsector Arena Content Pass | Build playable Hyper Grid subsector variants. |
| Future later | Sector 5 / Black Crown foundation | Add future Sector 5 only after active sectors are stable. |
| Future later | Final boss / ending sequence | Add Null King final flow and ending only after Sector 5 exists. |
| Future later | Lore Codex menu | Add persistent lore collection and replayable Memory Shard reading. |
| Future later | Narrative polish pass | Improve pacing, Lyra lines, memory echoes, and boss presentation after runtime structure is proven. |

## Manual Review Checklist

- The campaign plan still preserves the locked Phase 40 story.
- Each active sector has five named pre-boss subsectors.
- Sector 5 is clearly marked future-only.
- Bosses remain major gates.
- Memory Shards remain major boss / sector-clear rewards.
- Phase 48 implements Sector 1 1A-1D visual-only variants only; later sectors
  remain future phases.
