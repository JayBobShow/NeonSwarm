# Neon Swarm Story Implementation Plan

## Phase 40 Scope

Phase 40 locks names, story direction, and implementation order. It does not
implement the opening cutscene, ending cutscene, cinematic system, new dialogue
system, new boss behavior, new enemy behavior, new gameplay systems, or Phase 41.

## Source Of Truth Documents

- `docs/NEON_SWARM_STORY_BIBLE.md`
- `docs/NEON_SWARM_CHARACTER_BIBLE.md`
- `docs/NEON_SWARM_ENEMY_FACTION_BIBLE.md`
- `docs/NEON_SWARM_BOSS_BIBLE.md`
- `docs/NEON_SWARM_STORY_IMPLEMENTATION_PLAN.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`

## Phase 40 Runtime Integration

Allowed and safe:

- Label-only sector naming.
- Label-only boss naming.
- Tagline or menu text only if it does not require UI redesign.

Not allowed in Phase 40:

- Opening cutscene.
- Ending cutscene.
- New cinematic system.
- New dialogue system.
- New enemy behavior.
- New boss behavior.
- New sectors.
- Gameplay balance changes.

## Current Runtime Label Mapping

The current build has four playable sectors. The full story plan has five. Until
The Black Crown is implemented, runtime labels should map the current four-sector
run to the first four story sectors only.

| Runtime Sector | Story Name | Runtime Label Goal | Notes |
| --- | --- | --- | --- |
| 1 | Neon Grid | Neon Grid / Grix the Rail Butcher | Label-only replacement for the old Prism Warden name. |
| 2 | Prism Rift | Prism Rift / Veyraxis, Prism Widow | Preserve the Phase 39 Sector 2 arena. |
| 3 | Ember Circuit | Ember Circuit / Lord Cobalt Hex | Label-only story rename for the old Null Zone slot. |
| 4 | Hyper Grid | Hyper Grid / The Hollow Warden | Label-only story rename for the current final prototype slot. |

The Black Crown, The Crown Shard, and The Null King remain planned story content
until a future approved phase adds Sector 5 and final-boss work.

## Future Opening Implementation Outline

Do not build until explicitly approved.

1. Establish the ruined Neon Grid with minimal, readable visuals.
2. Use Lyra Quill's static call as the first voice.
3. Wake the Aether Core with player-control handoff near the end.
4. Tease Nova Veyr identity without full exposition.
5. Trigger a Swarm breach.
6. Enter gameplay in Sector 1: Neon Grid.

Implementation requirements for a future phase:

- Skippable.
- No save incompatibility.
- No long blocking intro on repeated runs unless the player chooses replay.
- Built on a small, testable presentation path.

## Future Ending Implementation Outline

Do not build until explicitly approved.

1. Null King defeated.
2. Grid begins collapsing.
3. Mira appears inside the Aether Core.
4. Nova uses Prism Shards to rebuild the Grid.
5. Sectors light back up.
6. Lyra finds Nova's signal.
7. Rook-7 says: "Combat odds revised. Hope remains operational."
8. Nova says: "The Swarm will return someday. Darkness always does. But next time, it will find us ready."
9. Credits.
10. Post-credit tease with a small black crown fragment opening one white eye.

## Dialogue Implementation Order

1. Replace generic labels where safe.
2. Add short sector intro text after labels are stable.
3. Add boss intro lines as timed combat notices only after manual review approves label readability.
4. Add companion barks only after the core combat HUD remains readable.
5. Add opening cinematic only after a future phase explicitly approves it.
6. Add ending cinematic only after final sector and final boss are implemented.

## System Lore Hooks

- XP shards should be described as broken Grid memory.
- Weapons should be described as recovered combat memories.
- Random stats should be described as unstable Core weapon memory variation.
- Forge should be Lyra repairing and refining weapon memory code.
- Neon Dust should be purified Swarm residue.
- Run Weapons should be temporary combat routines active during the current run.
- Evolution / Fusion should be Nova combining weapon memories into stronger forms.
- Sector Events should be broken Grid systems trying to reconnect.

## Save Compatibility Rule

Story naming should not alter saved weapon instances, upgrade keys, inventory
schema, Neon Dust values, Forge state, equipped loadouts, settings, or run weapon
logic. Data-key changes require a separate migration plan.

## Acceptance Gates For Future Story Work

- Story text must not hide bullets, XP, enemies, bosses, or the player ripple.
- Voice lines must be short enough for combat readability.
- Companion dialogue must be optional or nonblocking in combat.
- Cinematics must be skippable and must not replace the official scene path.
- Boss names and sector names must stay consistent with the Phase 40 bible.
