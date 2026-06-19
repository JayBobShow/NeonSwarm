# Neon Swarm Phase 44 Boss Identity Pass Report

## Scope

Phase 44 adds lightweight boss identity presentation for the four current
runtime bosses so they feel like named RPG villains instead of generic large
enemies.

This phase does not start Phase 45, does not build a Memory Shard system, does
not build an ending sequence, does not add Sector 5 gameplay, and does not
change boss attacks, health, rewards, movement, weapons, collision, or gameplay
balance.

## Runtime Location

- Active boss identity data, card state, UI creation, fade logic, Lyra warning
  hooks, intro triggers, and defeat triggers are in
  `scripts/NeonSwarm3DGameplayPrototype.gd`.
- Runtime boss cards use `BOSS_IDENTITY_ACTIVE_DATA`, which contains only the
  four current runtime bosses.
- Future boss names remain in `BOSS_IDENTITY_FUTURE_STORY_LOCK_DATA` for story
  lock reference only. Runtime lookup does not use this future table.
- The boss card node is `BossIdentityTitleCardPanel`.
- The labels are `BossIdentityEyebrowLabel`, `BossIdentityNameLabel`,
  `BossIdentityTitleLabel`, and `BossIdentityQuoteLabel`.
- Boss-specific Lyra warning lines reuse the Phase 42
  `LyraQuillCompanionRadioPanel`.

## UI Placement

- Design-space rect: `Rect2(500, 92, 920, 156)`.
- Placement: top-center, below the top edge and away from the left stat stack,
  right weapon stack, and center player area.
- Cards auto-fade.
- Cancel input can dismiss the card during normal gameplay. Reward, menu, pause,
  Armory, Forge, and option flows keep their existing input ownership.

## Runtime-Active Bosses

The current build has four playable sectors, so these boss identities are active
in runtime:

| Sector | Boss | Runtime Boss Type | Intro Line | Defeat Line |
| --- | --- | --- | --- | --- |
| 1 | Grix the Rail Butcher | `mini_boss` | "Unauthorized light detected. Begin removal." | "Defense protocol... broken." |
| 2 | Veyraxis, Prism Widow | `fractal_crown` | "I have seen every version of you die." | "The mirror... lied..." |
| 3 | Lord Cobalt Hex | `null_octagon` | "You are not a hero. You are outdated hardware." | "Factory command... lost..." |
| 4 | The Hollow Warden | `final_null_octagon` | "The lock must remain. The girl must remain. The king must wake." | "Forgive me, Mira Sol..." |

## Future Story-Locked Bosses

These identities are locked for future story direction but are not current
runtime boss fights. They do not appear in the current boss rotation and do not
trigger boss cards, Lyra warnings, or defeat cards.

| Story Slot | Boss | Intro Line | Defeat Line |
| --- | --- | --- | --- |
| Sector 5 Mid-Boss | The Crown Shard | "Bow, little light. Your shape ends here." | "The crown... still sees..." |
| Final Boss | The Null King, Crown of the Empty Grid | "You mistake motion for life. You mistake color for meaning. I will correct you." | "I am... the final shape..." |

## Active Runtime Lyra Boss Warnings

1. Grix:
   `Nova, that defense unit is running execution code. Do not let it touch you.`

2. Veyraxis:
   `That thing is reading the Rift like a mirror. Keep moving, or it will predict you.`

3. Lord Cobalt Hex:
   `This foundry commander is building weapons out of corrupted Grid metal. Break the factory brain.`

4. The Hollow Warden:
   `Nova... that signal is old. It was built to guard something. Or someone.`

## Future Story-Locked Lyra Warning Text

These lines are story-lock reference only until a future approved Sector 5 /
final boss implementation exists:

- The Crown Shard:
  `That is not a normal commander. It is a piece of the Null King's crown.`
- The Null King:
  `Nova, all Grid channels are failing. Whatever happens now... do not let the light go out.`

## Triggers Implemented

- Boss warning time queues the boss-specific Lyra warning once per active
  runtime boss appearance.
- Boss spawn shows a `BOSS ARRIVAL` title card with the locked boss name, boss
  identity title, and intro quote.
- Boss defeat shows a `BOSS DEFEATED` title card with the locked boss name, boss
  identity title, and defeat quote.
- The existing boss HUD / combat notice path continues to show locked boss names.
- Boss identity seen flags reset per run/title/restart path.
- Crown Shard and Null King lookup intentionally returns no runtime card data in
  the current build.

No requested safe triggers were deferred for the four runtime-active bosses.

## Deferred To Later Approved Phases

- Sector 5 runtime boss encounter.
- The Crown Shard fight.
- The Null King final boss fight.
- Full cinematic boss intros.
- Boss defeat cutscenes.
- Ending sequence.
- Memory Shard system.
- New boss models, new boss attacks, or balance changes.

## Audio Behavior

- Adds a short original procedural SFX key: `boss_identity`.
- The sting uses the existing `_make_tone_sfx()` path.
- No external or copyrighted audio is used.
- Existing `boss_warning` and `boss_death` SFX behavior remains.

## Save Compatibility

- Phase 44 uses local runtime flags only.
- No save/settings keys are added.
- Existing weapon inventory, Neon Dust, Forge, settings, tutorial data,
  movement, collision, hurtboxes, weapon systems, sectors, and official scene
  path are unchanged.

## Manual Test Checklist

- Launch `scenes/Main.tscn`.
- Start a run and confirm Phase 41 intro still appears and remains skippable.
- Confirm Phase 43 sector title cards still appear.
- Wait for the Sector 1 boss warning and confirm Lyra gives the Grix warning.
- Confirm the Grix arrival card shows the boss name, title, and intro quote.
- Defeat Grix and confirm the defeat quote appears.
- Advance to later sectors and confirm Veyraxis, Lord Cobalt Hex, and The Hollow
  Warden use their locked names and lines.
- Confirm boss cards auto-fade and do not permanently cover side HUD stacks.
- Confirm movement, collision, weapons, rewards, Armory, Forge, Evolution/Fusion,
  Neon Dust, Sector 2 arena art, and save data behavior are unchanged.
- Confirm no ending sequence appears.
- Confirm no Memory Shard system appears.
