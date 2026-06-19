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
- `docs/NEON_SWARM_PHASE_41_OPENING_INTRO_SEQUENCE_REPORT.md`
- `docs/NEON_SWARM_PHASE_42_LYRA_COMPANION_TUTORIAL_LORE_REPORT.md`
- `docs/NEON_SWARM_PHASE_43_SECTOR_STORY_PROGRESSION_REPORT.md`
- `docs/NEON_SWARM_PHASE_44_BOSS_IDENTITY_PASS_REPORT.md`

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

## Phase 41 Opening Intro Foundation

Phase 41 implements the first opening intro foundation before gameplay begins.
It uses the Phase 40 story names and keeps the official scene path at
`scenes/Main.tscn`.

Runtime behavior:

- The intro starts from the existing title `START GAME` path before the first
  gameplay run of the current app session.
- It uses eight readable story panels with fade timing, a dark neon background,
  subtle star/rift motion, and original procedural intro music.
- Keyboard, controller, and mouse input can skip the intro.
- Completing or skipping the intro resumes the existing gameplay start flow.
- The current implementation does not add a save flag; it plays once per app
  session and is always skippable.
- It does not add an ending sequence, cinematic scene, alternate playable scene,
  gameplay balance change, enemy behavior, boss behavior, or Phase 42 work.

Panel text:

1. The Legend: "Long ago, the Neon Grid carried light between the stars."
2. The Fall: "But beneath the Grid, an ancient silence woke."
3. The Null King: "They called it the Null King - the Shape That Eats Stars."
4. The Swarm: "Where its shadow touched, cities became empty geometry. Living light shattered into the Swarm."
5. The Last Core: "One Aether Core still burned in the dark, carrying the lost soul of Nova Veyr."
6. Lyra's Signal: "Across the broken Grid, Lyra Quill found a signal that should have been impossible."
7. Awakening: "Nova... wake up. The universe is not dead yet."
8. Start: "The Aether Core ignites."

## Opening Expansion Notes

The Phase 41 opening foundation is intentionally small and safe. Future approved
opening work can improve it without changing the official scene path.

1. Establish the ruined Neon Grid with minimal, readable visuals.
2. Use Lyra Quill's static call as the first voice.
3. Wake the Aether Core with player-control handoff near the end.
4. Tease Nova Veyr identity without full exposition.
5. Trigger a Swarm breach.
6. Enter gameplay in Sector 1: Neon Grid.

Implementation requirements for future expansion:

- Skippable.
- No save incompatibility.
- No long blocking intro on repeated runs unless the player chooses replay.
- Built on a small, testable presentation path.

## Phase 42 Lyra Companion Tutorial Lore

Phase 42 implements Lyra Quill as a short in-game companion/tutorial radio
voice. It uses local runtime flags only, adds no save schema, does not pause
combat, and does not add a full dialogue or cinematic system.

Runtime behavior:

- Lyra lines appear in a small lower-left radio panel separate from the left
  stat stack, right weapon stack, and top combat notices.
- Lines are short, automatically fade, and can be dismissed with the cancel
  input when no reward/menu flow needs that input.
- First-time system lines use one-shot runtime flags.
- Low-health warnings use a cooldown.
- Boss warnings are one per sector boss warning.
- Death and run-complete/sector-clear lines can appear on their run-end panels.
- The Phase 41 intro, title flow, HUD layout, Armory, Forge, weapon systems,
  save data, and official scene path are preserved.

Implemented Lyra triggers:

1. First gameplay start after intro.
2. First movement/combat start.
3. First XP pickup.
4. First level-up / upgrade choice.
5. First new run weapon activation.
6. First gameplay Neon Dust gain.
7. First Forge / weapon-memory reference after Dust gain.
8. Boss warning, once per sector warning.
9. Sector transition, once per sector transition.
10. Low health warning with cooldown.
11. Death / run failed screen.
12. Sector clear / run victory screen.

## Phase 43 Sector Story Progression

Phase 43 implements the first lightweight sector story progression layer. It
uses the Phase 40 story lock, Phase 41 opening intro, and Phase 42 Lyra panel
without adding a full cutscene system.

Runtime behavior:

- A small top-center sector title card appears on gameplay start and sector
  entry.
- Sector-specific Lyra mission callouts reuse the Phase 42 radio panel.
- Clearing a sector shows a short `MEMORY RESTORED` reveal card.
- Story intro and memory reveal seen flags are runtime-session scoped.
- The current build remains a four-playable-sector run; The Black Crown text is
  locked in data for future Sector 5 work only.
- No save schema, gameplay balance, enemy behavior, boss behavior, Sector 2 art,
  final-boss flow, ending sequence, or Phase 44 boss pass is added.

Implemented sector intros:

| Sector | Title | Subtitle | Lyra Intro |
| --- | --- | --- | --- |
| 1 | NEON GRID | Awakening Zone | "Nova, this is the outer Grid. If you can survive here, I can trace the breach." |
| 2 | PRISM RIFT | Broken Mirror Sector | "The Rift is reflecting old memories. If you hear a voice that is not mine... follow it carefully." |
| 3 | EMBER CIRCUIT | Weapon Foundry Sector | "This foundry built Aether weapons before the collapse. Try not to let it build your coffin." |
| 4 | HYPER GRID | Central Routing Storm | "The Hyper Grid is still alive. Fast, angry, and very bad at welcoming guests." |
| 5 | THE BLACK CROWN | Dead Center of the Grid | "That is where the light stops. Nova... if Mira is anywhere, she is inside that darkness." |

Implemented memory reveals:

1. Neon Grid: "Memory restored: Nova Veyr was not born as the Core. Nova entered it willingly."
2. Prism Rift: "Memory restored: Mira Sol's voice echoes from inside the Prism Shards."
3. Ember Circuit: "Memory restored: the Aether Core weapon system was built to fight the first Null invasion."
4. Hyper Grid: "Memory restored: Mira became the living lock that held the Null King in the dark."
5. The Black Crown: "The Black Crown trembles. The final shape is waking."

## Phase 44 Boss Identity Pass

Phase 44 implements lightweight boss identity presentation for the four current
runtime bosses only and separately data-locks the future Sector 5 / final boss
identity records.

Runtime behavior:

- Boss warning time queues a boss-specific Lyra warning line for active runtime
  bosses only.
- Boss spawn shows a top-center `BOSS ARRIVAL` card with name, identity title,
  and intro quote.
- Boss defeat shows a top-center `BOSS DEFEATED` card with name, identity title,
  and defeat quote.
- Boss identity flags reset per run/title/restart path.
- A short procedural `boss_identity` sting plays on boss arrival.
- Crown Shard and Null King story records are future/data-ready only and are not
  used by current runtime boss-card lookup.
- No save schema, gameplay balance, enemy behavior, boss behavior, boss models,
  Sector 2 art, Sector 5 gameplay, Memory Shard system, Null King stage,
  final-boss flow, ending sequence, or Phase 45 work is added.

Runtime-active boss lines:

| Sector | Boss | Intro Line | Defeat Line |
| --- | --- | --- | --- |
| 1 | Grix the Rail Butcher | "Unauthorized light detected. Begin removal." | "Defense protocol... broken." |
| 2 | Veyraxis, Prism Widow | "I have seen every version of you die." | "The mirror... lied..." |
| 3 | Lord Cobalt Hex | "You are not a hero. You are outdated hardware." | "Factory command... lost..." |
| 4 | The Hollow Warden | "The lock must remain. The girl must remain. The king must wake." | "Forgive me, Mira Sol..." |

Future story-locked boss lines:

| Story Slot | Boss | Intro Line | Defeat Line |
| --- | --- | --- | --- |
| Sector 5 Mid-Boss | The Crown Shard | "Bow, little light. Your shape ends here." | "The crown... still sees..." |
| Final Boss | The Null King, Crown of the Empty Grid | "You mistake motion for life. You mistake color for meaning. I will correct you." | "I am... the final shape..." |

These future story-locked boss lines must remain out of current runtime
presentation until a later approved phase adds a real Sector 5 / final boss
system.

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
2. Keep the Phase 43 sector intro / memory reveal foundation small until manual
   readability is approved.
3. Keep the Phase 44 boss identity cards and Lyra warnings lightweight until
   manual readability is approved.
4. Expand Lyra companion barks only after the Phase 42 / Phase 43 panel pacing
   and Phase 44 boss-card readability are manually approved.
5. Expand the Phase 41 opening only after manual review approves pacing, text
   readability, and skip behavior.
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
