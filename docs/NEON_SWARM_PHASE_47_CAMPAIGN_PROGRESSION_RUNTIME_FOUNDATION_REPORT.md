# Phase 47 Campaign Progression Runtime Foundation Report

## Scope

Phase 47 implements the first runtime foundation for the expanded Phase 46
campaign structure. The game now understands active subsectors, advances through
them at runtime, and gates each current boss behind the final approach
subsector.

This phase does not build custom 1A-1D arena art, Sector 5 runtime content, a
final boss, a Lore Codex menu, an ending sequence, or Phase 48 content.

## Runtime Campaign Data

Runtime data was added in `scripts/NeonSwarm3DGameplayPrototype.gd`.

Active data:

- `CAMPAIGN_RUNTIME_SUBSECTORS_ENABLED`
- `CAMPAIGN_SUBSECTOR_CLEAR_TIME_SECONDS`
- `CAMPAIGN_BOSS_WARNING_DELAY_SECONDS`
- `CAMPAIGN_BOSS_SPAWN_DELAY_SECONDS`
- `CAMPAIGN_ACTIVE_SECTOR_DATA`
- `CAMPAIGN_FUTURE_SECTOR_DATA`

Runtime state:

- `_campaign_subsector_index`
- `_campaign_is_boss_step`
- `_campaign_node_elapsed`

Future Sector 5 exists only in `CAMPAIGN_FUTURE_SECTOR_DATA` with
`future_story_locked` status. It is not used by runtime progression.

## Active Progression Rules

- Each active sector starts at its `.0` subsector.
- Normal subsectors advance after `18.0` seconds if no boss, reward, menu, run
  event, game over, or run success state is blocking progression.
- Subsector transitions reuse current sector arena visuals and opening waves.
- Subsector title cards reuse the Phase 43 sector story card style.
- The HUD now includes the current campaign node.
- Boss warning and boss spawn timers only run after the campaign reaches a boss
  gate.

Boss gate timing:

- Boss warning delay: `6.0` seconds after boss gate entry.
- Boss spawn delay: `13.0` seconds after boss gate entry.

## Active Runtime Flow

Sector 1:

1. `1.0 Awakening Grid`
2. `1A Relay Yard`
3. `1B Data Trench`
4. `1C Capacitor Field`
5. `1D Rail Approach`
6. Boss gate: Grix the Rail Butcher

Sector 2:

1. `2.0 Prism Gate`
2. `2A Mirror Flats`
3. `2B Fracture Hall`
4. `2C Violet Glassway`
5. `2D Rift Lens`
6. Boss gate: Veyraxis, Prism Widow

Sector 3:

1. `3.0 Foundry Gate`
2. `3A Molten Busway`
3. `3B Furnace Grid`
4. `3C Weapon Memory Forge`
5. `3D Cobalt Assembly Line`
6. Boss gate: Lord Cobalt Hex

Sector 4:

1. `4.0 Storm Entry`
2. `4A Routing Spine`
3. `4B Overclock Field`
4. `4C Signal Cyclone`
5. `4D Lockbreaker Gate`
6. Boss gate: The Hollow Warden

## Boss Gate Behavior

Bosses cannot spawn until the campaign node is the sector boss gate.

Runtime boss gates:

- After `1D Rail Approach`: Grix the Rail Butcher
- After `2D Rift Lens`: Veyraxis, Prism Widow
- After `3D Cobalt Assembly Line`: Lord Cobalt Hex
- After `4D Lockbreaker Gate`: The Hollow Warden

The Crown Shard and The Null King are not active runtime boss gates.

## Memory Shard Behavior

Memory Shards remain major boss / sector-clear rewards only:

- PRISM SHARD I after Grix
- PRISM SHARD II after Veyraxis
- PRISM SHARD III after Lord Cobalt Hex
- PRISM SHARD IV after The Hollow Warden

No Memory Shards are awarded for normal subsector clears.

## Hotfix: Boss-Clear UI Sequencing

Manual review found that boss defeat could stack too many readable panels at
once: the Memory Shard reveal, weapon reward / comparison modal, Lyra dialogue,
boss defeat card, and normal HUD elements could compete for the same attention.

The runtime UI guards now enforce one large readable panel path during boss
clear. The chosen priority order is:

1. Reward / level-up / weapon reward-comparison modal.
2. Boss identity / boss defeat card.
3. Memory Shard reveal.
4. Sector story / subsector title card.
5. Lyra dialogue.

This matches the existing sector-clear reward flow: the reward modal stays
readable first, the boss defeat card waits until reward input is complete, the
Memory Shard remains queued until the reward and boss panels are clear, sector
story waits behind the Memory Shard, and Lyra dialogue waits until major story
or reward panels are no longer active.

## Debug / Test Support

Existing event test mode is preserved:

- `F6`: toggle event test mode
- `F7`: cycle event test type
- `F8`: spawn selected event
- `F9`: clear event
- `F10`: jump to Sector 4 test state

Phase 47 adds:

- `F11`: advance to the next campaign node while event test mode is enabled

This keeps campaign skipping behind the existing test-mode gate.

## Placeholder Behavior

- Existing sector arena visuals are reused across subsectors.
- Existing enemy mixes, current sector visual identities, and current wave
  systems are reused.
- No custom subsector arena layouts or Blender art were created.

## Deferred

- Phase 48: Sector 1 custom subsector arena content.
- Phase 49: Sector 2 custom subsector arena content.
- Phase 50: Sector 3 custom subsector arena content.
- Phase 51: Sector 4 custom subsector arena content.
- Sector 5 / Black Crown runtime.
- Crown Shard and Null King runtime fights.
- Ending sequence.
- Lore Codex menu.

## Manual Test Checklist

- Start a run and confirm `1.0 Awakening Grid` appears.
- Wait for subsector transition or use F6 then F11 to advance test nodes.
- Confirm 1A, 1B, 1C, and 1D title cards appear before Grix.
- Confirm Grix does not warn/spawn before the boss gate.
- Confirm boss defeat still triggers sector reward and Prism Shard I.
- Confirm boss-clear panels are readable in sequence: reward modal, boss defeat
  card, Memory Shard reveal, sector story card, then Lyra dialogue.
- Confirm Memory Shard and Lyra panels do not overlap weapon reward /
  comparison UI.
- Confirm the next sector begins at `2.0 Prism Gate`.
- Confirm Sector 5, Crown Shard, Null King, and ending content do not appear.
