# Neon Swarm Boss Bible

## Phase 40 Boss Lock

This document locks the official boss lineup, intro lines, story role, and
future implementation direction for Neon Swarm. Current runtime boss behaviors
may still use older prototype attack code and assets until future boss content
phases replace them.

Phase 40 may rename safe runtime labels, but it does not add new boss behavior,
new boss models, a final boss fight, or cutscene systems.

Phase 44 adds lightweight runtime boss identity presentation for the current
four-sector build only. It adds boss title cards, intro quotes, defeat quotes,
and boss-specific Lyra warnings for Grix, Veyraxis, Lord Cobalt Hex, and The
Hollow Warden without changing boss behavior, stats, attacks, models, rewards,
Sector 5, the Memory Shard system, or the ending.

## Boss Lineup

| Story Slot | Boss | Intro Line | Story Role |
| --- | --- | --- | --- |
| Sector 1 | Grix the Rail Butcher | "Unauthorized light detected. Begin removal." | First Gridborn execution machine; proves the Grid's defenses are corrupted. |
| Sector 2 | Veyraxis, Prism Widow | "I have seen every version of you die." | Prism Rift memory predator; attacks Nova through Mira echoes and fractured outcomes. |
| Sector 3 | Lord Cobalt Hex | "You are not a hero. You are outdated hardware." | Old weapon-factory commander; reveals Nova helped design the Aether Core weapon system. |
| Sector 4 | The Hollow Warden | "The lock must remain. The girl must remain. The king must wake." | Prison guardian and truth-gate; protects the secret that Mira is the living lock. |
| Sector 5 Mid-Boss | The Crown Shard | "Bow, little light. Your shape ends here." | Fragment of the Null King's crown; last gate before the final breach. |
| Final Boss | The Null King, Crown of the Empty Grid | "You mistake motion for life. You mistake color for meaning. I will correct you." | Main villain and final erasure force. |

## Phase 44 Runtime Identity Data

| Story Slot | Boss | Runtime Status | Identity Title | Defeat Line | Lyra Warning |
| --- | --- | --- | --- | --- | --- |
| Sector 1 | Grix the Rail Butcher | Active in current four-sector run | Gridborn Execution Machine | "Defense protocol... broken." | "Nova, that defense unit is running execution code. Do not let it touch you." |
| Sector 2 | Veyraxis, Prism Widow | Active in current four-sector run | Prism Rift Memory Predator | "The mirror... lied..." | "That thing is reading the Rift like a mirror. Keep moving, or it will predict you." |
| Sector 3 | Lord Cobalt Hex | Active in current four-sector run | Weapon Foundry Commander | "Factory command... lost..." | "This foundry commander is building weapons out of corrupted Grid metal. Break the factory brain." |
| Sector 4 | The Hollow Warden | Active in current four-sector run | Guardian of Mira's Seal | "Forgive me, Mira Sol..." | "Nova... that signal is old. It was built to guard something. Or someone." |
| Sector 5 Mid-Boss | The Crown Shard | Data-ready only | Fragment of the Null King's Crown | "The crown... still sees..." | "That is not a normal commander. It is a piece of the Null King's crown." |
| Final Boss | The Null King, Crown of the Empty Grid | Data-ready only | The Shape That Eats Stars | "I am... the final shape..." | "Nova, all Grid channels are failing. Whatever happens now... do not let the light go out." |

Phase 44 runtime presentation:

- Boss warning time queues the boss-specific Lyra warning once per boss
  appearance.
- Boss spawn shows a short `BOSS ARRIVAL` title card with boss name, identity
  title, and intro quote.
- Boss defeat shows a short `BOSS DEFEATED` title card with boss name, identity
  title, and defeat quote.
- The title card auto-fades and does not pause gameplay.
- The Crown Shard and Null King remain future story-locked / data-ready only
  until later approved Sector 5 / final boss work. They are not in the current
  runtime boss lookup and must not be presented as current gameplay content.

## Grix the Rail Butcher

- Sector: Neon Grid.
- Faction: Gridborn Machines.
- Shape language: rails, clamps, cutting arms, industrial blue/cyan execution hardware.
- Combat fantasy: the first corrupted defense engine tries to delete unauthorized light.
- Story reveal: Nova wakes, Lyra finds the Aether Core signal, and the Grid is no longer safe.

Runtime Phase 40 label mapping: current Sector 1 boss display can use this name
while existing prototype behavior remains unchanged.

## Veyraxis, Prism Widow

- Sector: Prism Rift.
- Faction: Prism Wraiths.
- Shape language: widow-prism body, mirror legs, fractured glass crown.
- Combat fantasy: angled reflection attacks, prism cracks, false outcomes.
- Story reveal: Nova hears Mira for the first time.

Runtime Phase 40 label mapping: current Sector 2 boss display can use this name
while existing prototype behavior remains unchanged.

## Lord Cobalt Hex

- Sector: Ember Circuit.
- Faction: Gridborn Machines / corrupted weapon authority.
- Shape language: hex plates, cobalt command frame, molten orange factory backlight.
- Combat fantasy: old weapon-system authority judging Nova as obsolete hardware.
- Story reveal: Nova helped design the Aether Core weapon system.

Runtime Phase 40 label mapping: current Sector 3 boss display can use this name
while existing prototype behavior remains unchanged.

## The Hollow Warden

- Sector: Hyper Grid.
- Faction: Nullborn / prison guardian.
- Shape language: hollow armor, white cracks, cyan-pink storm rails, lock glyphs.
- Combat fantasy: keeper of the seal, trying to preserve Mira's prison for the Null King.
- Story reveal: Mira is alive in some form and became the lock holding back the Null King.

Runtime Phase 40 label mapping: current Sector 4 boss display can use this name
while existing prototype behavior remains unchanged.

## The Crown Shard

- Sector: The Black Crown.
- Faction: Nullborn.
- Shape language: broken black crown, white eye, dead neon star fragments.
- Combat fantasy: a sentient fragment of the final boss testing Nova before the throne.
- Story reveal: the Null King can speak through its crown fragments.

Implementation status: planned only. Not implemented in Phase 40.

## The Null King, Crown of the Empty Grid

- Sector: The Black Crown.
- Title: The Shape That Eats Stars.
- Faction: source of the Nullborn.
- Shape language: black crowned geometric force, white cracks, dead neon stars.
- Combat fantasy: the final shape that tries to stop motion, color, memory, and meaning.
- Story conflict: Nova must defeat the Null King without destroying Mira's trapped light.

Implementation status: planned only. Not implemented in Phase 40.

## Boss Writing Rules

- Bosses should speak with identity, not generic threat text.
- Boss intro lines should be short enough for in-game presentation.
- Bosses should reinforce sector story reveals.
- Runtime labels may be updated before full boss redesigns, but behavior changes require a future approved phase.
- Do not implement the final boss until The Black Crown sector and ending plan are explicitly approved.
