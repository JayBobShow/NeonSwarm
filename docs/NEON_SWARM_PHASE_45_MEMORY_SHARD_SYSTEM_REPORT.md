# Neon Swarm Phase 45 Memory Shard System Report

## Scope

Phase 45 adds a lightweight Memory Shard reward system for the four current
runtime bosses / sectors.

This phase does not start Phase 46, does not build the Lore Codex menu, does
not add Sector 5, does not add the Null King stage, does not build an ending,
and does not change gameplay balance, weapons, movement, collision, boss
behavior, arenas, saves, or the official scene path.

## Runtime Location

- Memory Shard data, queue state, panel state, UI creation, fade logic, and
  sector-clear triggers are in `scripts/NeonSwarm3DGameplayPrototype.gd`.
- Runtime unlockable shards use `MEMORY_SHARD_ACTIVE_DATA`.
- Future-only shards use `MEMORY_SHARD_FUTURE_STORY_LOCK_DATA` and are not
  returned by runtime unlock lookup.
- The reveal panel node is `MemoryShardRevealPanel`.
- Reveal labels are `MemoryShardRevealEyebrowLabel`,
  `MemoryShardRevealNameLabel`, and `MemoryShardRevealBodyLabel`.
- Lyra reaction lines reuse the Phase 42 `LyraQuillCompanionRadioPanel`.

## UI Placement

- Design-space rect: `Rect2(500, 212, 920, 154)`.
- Placement: upper-center, below the Phase 44 boss title card area and above the
  sector reward panel.
- The panel shows `MEMORY SHARD RECOVERED`, the shard name, and the reveal text.
- The panel waits until an active boss identity card clears before showing.
- The panel auto-fades and can be dismissed with cancel outside reward/menu
  flows.

## Active Runtime Memory Shards

| Shard | Unlock Source | Reveal Text | Lyra Reaction |
| --- | --- | --- | --- |
| PRISM SHARD I — THE PILOT | Grix the Rail Butcher / Sector 1 clear | "Memory restored: Nova Veyr was not born as the Core. Nova entered it willingly." | "Nova... that was not weapon data. That was you." |
| PRISM SHARD II — MIRA’S VOICE | Veyraxis, Prism Widow / Sector 2 clear | "Memory restored: Mira Sol’s voice echoes from inside the Prism Shards." | "I heard her too. That signal should not exist." |
| PRISM SHARD III — THE FIRST INVASION | Lord Cobalt Hex / Sector 3 clear | "Memory restored: the Aether Core weapon system was built to fight the first Null invasion." | "So the Core was not just a weapon. It was a promise." |
| PRISM SHARD IV — THE LIVING LOCK | The Hollow Warden / Sector 4 clear / current run complete | "Memory restored: Mira became the living lock that held the Null King in the dark." | "Nova... if Mira is the lock, then breaking the King means saving her first." |

## Future Story-Locked Shards

These are story direction only. They do not unlock in the current runtime:

| Shard | Status | Future Reveal |
| --- | --- | --- |
| PRISM SHARD V — THE BLACK CROWN | Future story-locked only | "The Black Crown trembles. The final shape is waking." |
| PRISM SHARD VI — THE LAST LIGHT | Future ending / final boss content only | "The Aether Core was never meant to destroy the Grid. It was meant to remember it." |

## Triggers Implemented

- Sector 1 clear queues Prism Shard I.
- Sector 2 clear queues Prism Shard II.
- Sector 3 clear queues Prism Shard III.
- Current run complete / Sector 4 boss clear queues Prism Shard IV.
- Shards unlock once per current run.
- Shard reveals wait for the Phase 44 boss defeat card before displaying.
- Phase 43 sector completion memory text is now routed through the Memory Shard
  reveal panel to avoid duplicate story panels.

No active-runtime Memory Shard triggers were deferred.

## Deferred To Phase 46 Or Later

- Full Lore Codex menu.
- Persistent Memory Shard collection tracking.
- Replayable lore archive.
- Sector 5 shard unlock.
- Final boss / ending shard unlock.
- Voice acting or cinematic memory scenes.

## Save Compatibility

- Phase 45 uses local runtime flags only.
- No save/settings keys are added.
- Existing weapon inventory, Neon Dust, Forge, settings, tutorial data,
  movement, collision, hurtboxes, weapon systems, sectors, and official scene
  path are unchanged.

## Manual Test Checklist

- Launch `scenes/Main.tscn`.
- Start a run and confirm Phase 41 intro still appears.
- Clear Sector 1 and confirm Prism Shard I appears after the boss defeat card.
- Confirm the Lyra reaction line appears through the existing radio panel.
- Confirm the sector reward choices remain usable.
- Confirm the same shard does not spam repeatedly in the same run.
- Advance to Sectors 2 and 3 and confirm Prism Shards II and III.
- Complete the current run and confirm Prism Shard IV.
- Confirm Crown Shard / Null King shards do not appear in current runtime.
- Confirm no Lore Codex menu appears.
- Confirm no Sector 5, Null King stage, or ending sequence appears.
