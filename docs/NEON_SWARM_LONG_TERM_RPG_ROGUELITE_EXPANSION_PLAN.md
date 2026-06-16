# Neon Swarm Long-Term RPG / Roguelite Expansion Plan

## 1. Updated Game Vision

Neon Swarm is now targeting a larger neon arena survival RPG / roguelite direction.

The current build remains an active-development prototype with a playable sector run, title screen, options, audio, HUD, XP, level-ups, rewards, and boss flow. The long-term goal is to grow from that foundation into a deeper game with loot, RPG progression, sector variety, stronger presentation, story framing, upgraded graphics, and a much larger weapon ecosystem.

This document is planning only. Do not implement these systems until their phases are explicitly approved.

Long-term pillars:

- Fast neon arena survival combat.
- RPG-style weapon loot and progression.
- Large weapon ecosystem with 200+ future weapons or weapon variants.
- Randomized weapon stats and rarity tiers.
- Equipped loadouts, inventory, stash, and weapon comparison.
- Stronger sectors with better backgrounds and visual identity.
- Upgraded player, enemy, and boss graphics.
- Storyline, opening scene, and possible cutscenes.
- Professional audio direction replacing placeholder/procedural-only sound over time.

## 2. Weapon System Architecture For 200+ Future Weapons

The current weapon logic works for a prototype, but 200+ weapons require data-driven architecture.

Target architecture:

- Weapon definition catalog.
- Weapon instance data.
- Runtime weapon controller.
- Projectile/VFX/audio definition references.
- Upgrade/modifier hooks.
- Rarity and random stat generation.
- Comparison/stat summary layer.
- Save/load serialization for owned weapons.

Definitions should describe stable weapon identity:

- Weapon id.
- Display name.
- Weapon family.
- Shape language.
- Base behavior type.
- Base stats.
- Allowed stat rolls.
- Allowed rarity tiers.
- Upgrade hooks.
- VFX profile.
- SFX profile.
- Unlock requirements.

Instances should describe rolled loot:

- Definition id.
- Unique instance id.
- Rarity.
- Rolled stat values.
- Affixes/modifiers.
- Level or power value.
- Equipped/stashed state.
- Lock/favorite state.

Architecture rule:

- Never manually hard-code hundreds of weapon branches into the main gameplay script. Build a definition/instance pipeline first.

## 3. Random Weapon Stat System Plan

Random stats should add replay value without making readability or balance impossible.

Candidate stat rolls:

- Damage.
- Cooldown/fire rate.
- Projectile count.
- Projectile speed.
- Lifetime/range.
- Pierce.
- Bounce/chain count.
- Area size.
- Critical chance or overdrive chance, if later approved.
- Knockback/pull strength.
- Status effect duration, if status effects are added.

Stat roll model:

- Each weapon definition declares allowed stat ranges.
- Rarity tier modifies number of rolled stats and roll quality.
- Weapon family limits which stats can appear.
- Some stats are mutually exclusive.
- Hard caps prevent runaway projectiles, particles, or enemies.

Comparison model:

- Show current equipped weapon vs inspected weapon.
- Highlight increased/decreased stats.
- Separate base stats from rolled modifiers.
- Show behavior-changing affixes in plain language.

Safety rules:

- Random stats must never bypass projectile, enemy, VFX, audio, or hazard caps.
- Random stats must not make weapon visuals unreadable.
- Stat generation should be seedable for testing.

## 4. Weapon Rarity Plan

Candidate rarity tiers:

| Tier | Role | Stat Behavior | Visual Treatment |
| --- | --- | --- | --- |
| Common | Reliable baseline loot. | Base stats plus small variance. | Clean cyan/white accents. |
| Uncommon | Better rolls or one minor affix. | Slightly higher stat budget. | Cyan/green secondary edge. |
| Rare | Stronger roll spread and clearer identity. | One to two affixes. | Blue/magenta accent. |
| Epic | Build-defining modifiers. | Multiple stronger rolls. | Violet/gold accent. |
| Legendary | Unique behavior modifier. | Curated special affix plus high rolls. | Gold/white-hot accent. |
| Anomaly | High-risk experimental loot. | Powerful but constrained tradeoff. | Red/orange warning accent. |

Rarity should affect:

- Number of random stat rolls.
- Roll range quality.
- Affix count.
- Visual frame/accent.
- Loot sound.
- Comparison emphasis.

Rarity should not:

- Replace skill and build choice.
- Force constant power creep.
- Create unreadable VFX.
- Make lower-tier weapons useless early.

## 5. Stash / Inventory Plan

Long-term inventory pieces:

- Equipped weapon loadout.
- Backpack/in-run loot list.
- Stash box between runs.
- Weapon detail panel.
- Weapon comparison panel.
- Sort/filter controls.
- Favorite/lock controls.
- Sell/salvage/dismantle if economy is later approved.

Loadout plan:

- Start with a small number of equipped weapon slots.
- Decide whether slots are fixed by weapon family or fully flexible.
- Keep controller navigation first-class.
- Do not block arena readability with inventory UI during combat unless the game is paused.

Stash plan:

- Persistent stored weapon instances.
- Capacity limit only after UX is proven.
- Filters by rarity, family, level, damage type, and equipped status.
- Clear warnings before destroying or replacing items.

Save data:

- Separate settings save from progression/loot save.
- Store weapon instances by id, definition id, rarity, rolls, affixes, and flags.
- Include schema version for future migration.

## 6. RPG Progression Plan

RPG progression should add depth without turning the core loop into menu grind.

Candidate progression layers:

- Player core unlocks.
- Player core levels.
- Weapon unlocks.
- Weapon mastery.
- Sector unlocks.
- Difficulty tiers.
- Challenge modifiers.
- Achievement-style goals.
- Score/rank milestones.
- Boss trophies or codex entries.

Possible player stats:

- Max health.
- Move speed.
- Pickup range.
- Weapon damage.
- Weapon cooldown.
- Shield/armor.
- Luck/loot quality.
- Reroll count.
- Stash capacity.

Rules:

- Permanent progression should unlock options more than raw mandatory power.
- New players should still have a strong baseline.
- Progression should support replayability, not replace run skill.
- Save data must be clean and recoverable.

## 7. Sector / Background Expansion Plan

Current sectors happen inside one arena with sector-specific grid tint and floor motifs. Long-term sectors need stronger backgrounds and environmental identity.

Planned direction:

- Keep official scene flow until new level architecture is approved.
- Add sector background systems before building many bespoke scenes.
- Separate sector visual data from gameplay data.
- Support background layers, sky/void treatment, grid style, border style, motif density, and lighting profile.

Future sector visual goals:

- Neon Grid: clean tutorial grid, readable and iconic.
- Prism Rift: fractured glass planes, hex cracks, shard parallax.
- Null Zone: darker contrast, void depth, sparse octagonal threat language.
- Hyper Grid: speed lines, rail lanes, sharper blue/white energy.
- Fractal Core: recursive triangle architecture, animated shard lattice.
- Singularity Swarm: ring cages, lens distortion, gravity arcs.

Rules:

- Backgrounds must not hide enemies, pickups, projectiles, or boss warnings.
- Sector identity should increase polish without hurting performance.
- New sector backgrounds should be data-driven where possible.

## 8. Player / Enemy / Boss Graphics Upgrade Plan

The current neon tube edge style remains the visual baseline, but graphics should become more professional over time.

Player upgrade goals:

- Stronger player core silhouette.
- More readable facing direction.
- Loadout/player-core visual variants.
- Better damage and shield feedback.
- More premium movement trails without visual mud.

Enemy upgrade goals:

- More distinct silhouettes per enemy family.
- Higher-quality dark body faces.
- Cleaner edge-tube accents.
- Better telegraphs.
- Animation passes for movement, windups, attacks, and deaths.

Boss upgrade goals:

- Larger authored boss forms.
- More readable phase transitions.
- Distinct boss arenas/background accents where safe.
- Better boss entry presentation.
- Premium death bursts with capped VFX.

Graphics rules:

- Dark body faces.
- Bright neon tube edges.
- Clean geometry silhouettes.
- No blurry blob replacements.
- No uncontrolled particle spam.

## 9. Story / Opening / Cutscene Plan

Story should add identity without interrupting arcade flow.

Possible story direction:

- The player is a neon core pilot or rogue signal inside a hostile geometric network.
- Sectors are corrupted simulation layers or city-grid defense systems.
- Bosses are guardian programs, fracture monarchs, or singularity entities.
- Weapon loot represents recovered geometry code or unstable combat modules.

Opening scene plan:

- Short, skippable opening.
- Establish player/core identity.
- Establish Neon Swarm threat.
- Transition into title screen or first run.
- Controller/keyboard skip support.

Cutscene plan:

- Use sparingly.
- Keep scenes short and skippable.
- Prefer stylized in-engine neon geometry over expensive one-off video.
- Avoid blocking repeat runs.

Story systems should wait until core gameplay, loot, and progression are more stable.

## 10. Audio Replacement Plan

Current procedural audio is a placeholder foundation. Long-term audio should become a professional neon arcade/sci-fi mix.

Target audio work:

- Replace placeholder procedural SFX with authored original SFX.
- Add stronger weapon sounds per weapon family.
- Add enemy and boss-specific sounds.
- Add sector-specific music or layers.
- Add title, gameplay, boss, death, and run-complete music with better production.
- Add UI sounds for inventory, comparison, stash, rarity drops, and confirmation.

Audio requirements:

- No copyrighted audio.
- No ripped assets.
- No unapproved external licensed tracks.
- Master, SFX, Music, and Mute settings must continue to work.
- No painful volume spikes.
- No sound spam under swarm chaos.

Future audio implementation plan:

- Define audio event names.
- Add audio bus/mixer categories.
- Add SFX cooldown/priority system for crowded combat.
- Replace procedural sounds incrementally.
- Keep procedural fallback only if useful for missing development sounds.

## 11. Future Phase Roadmap

Likely future phases:

| Phase | Focus | Implementation Rule |
| --- | --- | --- |
| Phase 19 | Weapon System Architecture + Random Stat Foundation | Build data/instance architecture first; do not manually create hundreds of weapons. |
| Phase 20 | Inventory/Stash UI Prototype | Implemented first Armory/Stash UI prototype with equipped list, stash list, details, comparison, and matching-family swap/save. |
| Phase 21 | Weapon Loot / Rarity / Comparison | Add loot drops, rarity tiers, and comparison flow safely. |
| Phase 22 | Sector Background Upgrade | Improve backgrounds and sector identity without hurting readability. |
| Phase 23 | Player/Enemy Graphics Upgrade | Upgrade graphics while preserving neon tube edge style. |
| Phase 24 | Story / Opening Scene Prototype | Add skippable opening/story prototype only after approval. |
| Phase 25 | Real Audio Replacement Pass | Replace placeholder procedural SFX/music with original professional audio direction. |

Phase 19 is now implemented as the weapon architecture/random-stat foundation.

Phase 20 is now implemented as the first Armory/Stash UI prototype.

Do not start Phase 21 until explicitly approved.

## 12. Immediate Non-Implementation Notes

Do not do these now:

- Do not create 200 weapons manually.
- Do not add inventory/stash UI in this planning pass.
- Do not implement random loot yet.
- Do not redesign the HUD/title screen.
- Do not replace audio yet.
- Do not add story scenes or cutscenes yet.
- Do not add alternate playable scenes.

Next engineering priority, once approved, should be architecture: weapon definitions, weapon instances, random stat rolls, and comparison-ready stat summaries.
