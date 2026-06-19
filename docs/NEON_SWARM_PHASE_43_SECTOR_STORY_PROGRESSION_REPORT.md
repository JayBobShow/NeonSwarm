# Neon Swarm Phase 43 Sector Story Progression Report

## Scope

Phase 43 adds a lightweight sector story progression layer so each major story
sector has a readable identity, intro beat, Lyra mission callout, completion
memory reveal, and locked boss-name reference.

This phase does not start Phase 44, does not build the full boss identity pass,
does not build an ending sequence, and does not change gameplay balance.

## Runtime Location

- Sector story constants, runtime state, UI creation, trigger logic, and fade /
  skip behavior are in `scripts/NeonSwarm3DGameplayPrototype.gd`.
- The title-card panel node is `SectorStoryProgressionCardPanel`.
- The title label is `SectorStoryCardTitleLabel`.
- The subtitle label is `SectorStoryCardSubtitleLabel`.
- The memory body label is `SectorStoryCardBodyLabel`.
- Sector-specific Lyra lines reuse the Phase 42 `LyraQuillCompanionRadioPanel`
  through a small custom-line queue path.

## UI Placement

- Design-space rect: `Rect2(560, 230, 800, 132)`.
- Placement: near top-center, below the top notices and away from the player.
- Intro cards show sector title and subtitle.
- Completion cards show `MEMORY RESTORED`, the sector title, and one short memory
  reveal line.
- Cards auto-fade and can be dismissed with cancel when no reward/menu flow needs
  that input.
- Lyra mission callouts remain in the existing lower-left / lower-center radio
  panel.

## Sector Intro Text

1. `NEON GRID`
   `Awakening Zone`
   `Nova, this is the outer Grid. If you can survive here, I can trace the breach.`

2. `PRISM RIFT`
   `Broken Mirror Sector`
   `The Rift is reflecting old memories. If you hear a voice that is not mine... follow it carefully.`

3. `EMBER CIRCUIT`
   `Weapon Foundry Sector`
   `This foundry built Aether weapons before the collapse. Try not to let it build your coffin.`

4. `HYPER GRID`
   `Central Routing Storm`
   `The Hyper Grid is still alive. Fast, angry, and very bad at welcoming guests.`

5. `THE BLACK CROWN`
   `Dead Center of the Grid`
   `That is where the light stops. Nova... if Mira is anywhere, she is inside that darkness.`

## Completion And Memory Text

1. Neon Grid:
   `Memory restored: Nova Veyr was not born as the Core. Nova entered it willingly.`

2. Prism Rift:
   `Memory restored: Mira Sol's voice echoes from inside the Prism Shards.`

3. Ember Circuit:
   `Memory restored: the Aether Core weapon system was built to fight the first Null invasion.`

4. Hyper Grid:
   `Memory restored: Mira became the living lock that held the Null King in the dark.`

5. The Black Crown:
   `The Black Crown trembles. The final shape is waking.`

The current runtime still has four playable sectors. The Black Crown text is
locked in the data table for future Sector 5 work only; Phase 43 does not add
Sector 5 gameplay, final-boss flow, or an ending.

## Triggers Implemented

- Starting gameplay after the Phase 41 intro or intro skip shows the current
  sector title card and queues that sector's Lyra intro line.
- Advancing to the next sector shows that sector's title card and queues its
  sector-specific Lyra intro line.
- Clearing a sector shows that sector's memory reveal.
- Completing the current final run shows the Hyper Grid memory reveal before
  the normal run-complete result.
- Sector intro and memory reveal seen flags are runtime-session scoped so repeat
  restarts do not spam full lore beats.
- The Phase 42 generic sector-clear Lyra line is preserved for sector clear and
  run-complete result panels.

No requested safe triggers were deferred.

## Boss Name Support

Phase 43 keeps boss-name support lightweight:

- The sector story data includes the locked boss names for all five planned
  story sectors.
- The existing boss HUD / warning name path already uses the Phase 40
  `ContentCatalog` boss labels for the four playable sectors.
- No new boss intro, defeat, behavior, attack, or Phase 44 boss identity system
  is built.

## Save Compatibility

- Phase 43 uses local runtime seen flags only.
- No save/settings keys are added.
- Existing weapon inventory, Neon Dust, Forge, settings, tutorial data, movement,
  collision, hurtboxes, weapons, sectors, and official scene path are unchanged.

## Deferred To Later Approved Phases

- Full boss intro / defeat dialogue pass.
- Sector 5 runtime implementation.
- Crown Shard / Null King final encounter flow.
- Ending sequence.
- Persistent story-progress save flags.
- Voice acting or cinematic camera work.

## Manual Test Checklist

- Launch `scenes/Main.tscn`.
- Select `START GAME`.
- Confirm the Phase 41 intro still appears and remains skippable.
- Skip or complete the intro and confirm gameplay starts.
- Confirm the Sector 1 `NEON GRID` title card appears.
- Confirm the Sector 1 Lyra intro line appears after gameplay starts.
- Clear Sector 1 and confirm the Neon Grid memory reveal appears.
- Advance to Sector 2 and confirm the `PRISM RIFT` title card and Lyra intro
  line appear.
- Confirm story cards auto-fade and cancel can dismiss them outside menu/reward
  flows.
- Confirm Lyra dialogue still fades and does not pause gameplay.
- Confirm boss labels still use locked boss names.
- Confirm Sector 2 arena art is unchanged.
- Confirm player movement, collision, hurtboxes, weapons, HUD, Armory, Forge,
  Evolution/Fusion, Neon Dust, and save data behavior are unchanged.
- Confirm no ending sequence appears.
