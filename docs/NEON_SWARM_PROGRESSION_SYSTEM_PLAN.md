# Neon Swarm Progression System Plan

## 1. Purpose

This document plans future progression systems for Neon Swarm. It now supports the long-term direction of a larger neon arena survival RPG / roguelite.

The goal is to avoid bolting on progression randomly. Progression should support replay value, build variety, loot goals, RPG growth, and player expression without damaging the clean arcade survival loop.

## 2. Current Progression Baseline

Already implemented:

- XP drops from enemies.
- XP pickup and magnet behavior.
- Level-up choices.
- Sector-clear reward choices.
- Three-sector baseline expanded to a four-sector prototype foundation.
- Death/restart and success/restart.
- Saved player settings, not gameplay progression.
- Phase 19 weapon definition and instance foundation.
- Phase 19 rarity/stat-roll foundation.
- Phase 19 generated sector weapon reward cards.
- Phase 19 backend equipped weapon and stash save data.
- Phase 20 player-facing Armory/Stash UI.
- Phase 21 runtime weapon loadout routing from equipped weapon instances.
- Phase 21 cross-family Armory equip/swap into selected equipped slots.
- Phase 22 in-run weapon reward decision flow.
- Phase 22 in-run equipped slot replacement UI for generated weapon rewards.
- Phase 28 Neon Dust currency, stash scrap economy, Core Upgrade terminal, and post-run economy summary.
- Phase 29 Weapon Forge foundation for spending Neon Dust on owned weapon progression.
- Phase 30 Wave Director foundation, sector enemy pacing profiles, and capped elite variants with modest XP/score/Neon Dust reward hooks.
- Phase 31 Boss Telegraph foundation for readable delayed boss attacks, boss phase feedback, and preserved boss reward flow.
- Phase 32 Weapon Evolution/Fusion foundation for spending Neon Dust and compatible stash material weapons to add saved evolution ranks.

Not implemented yet:

- Permanent unlocks.
- Manual weapon equip/unequip.
- Loot drops from enemies.
- Deep behavior-changing affixes.
- Character/core roster.
- Challenge modes.
- Score ranks.
- Achievement-style goals.

## 3. Unlockable Weapons

Planned direction:

- Keep a reliable starter pool.
- Unlock advanced weapons through run achievements, sector clears, or challenge goals.
- Use unlocks to broaden build variety, not to create mandatory power creep.
- Support a long-term catalog of 200+ weapons or weapon variants through definitions and generated instances.

Candidate unlock structure:

| Weapon | Unlock Idea | Reason |
| --- | --- | --- |
| Fractal Shard | Clear Prism Rift or defeat Fractal Crown. | Ties weapon identity to fractal content. |
| Rail Cutter | Clear Hyper Grid. | Matches rail/speed-line sector identity. |
| Singularity Well | Reach Singularity Swarm. | Keeps gravity-heavy weapon language late-game. |
| Mirror Fan | Defeat a planned mirror/fracture boss. | Supports shard/angle builds. |

Rules:

- Locked weapons should not appear in level-up pools until unlocked.
- Unlocks should be visible in a future collection/progression screen.
- Starter build should remain fun without unlock grinding.
- Weapon definitions and owned weapon instances should be separate data concepts.

## 4. Random Weapon Stats

Future weapon loot should generate weapon instances from stable definitions.

Definition data:

- Weapon id.
- Weapon family.
- Base behavior.
- Base stat ranges.
- Allowed random stats.
- Allowed rarity tiers.
- Shape/VFX/audio profile.
- Unlock requirements.

Instance data:

- Unique instance id.
- Definition id.
- Rarity tier.
- Rolled stat values.
- Affixes/modifiers.
- Equipped/stashed state.
- Favorite/locked state.

Candidate random stats:

- Damage.
- Cooldown/fire rate.
- Projectile speed.
- Projectile lifetime/range.
- Projectile count.
- Pierce.
- Bounce/chain count.
- Area size.
- Pull strength.
- Critical/overdrive chance, if later approved.

Rules:

- Random stat rolls must respect projectile, VFX, enemy, audio, and hazard caps.
- Stat generation should be testable and seedable.
- Behavior-changing rolls should be explicit affixes, not hidden stat noise.

## 5. Weapon Rarity

Candidate rarity tiers:

| Tier | Role |
| --- | --- |
| Common | Stable baseline loot with light variance. |
| Uncommon | Slightly stronger rolls or one minor modifier. |
| Rare | Stronger rolls and clearer build identity. |
| Epic | Build-defining modifiers. |
| Legendary | Curated unique behavior modifier. |
| Anomaly | High-risk, high-reward experimental item. |

Rarity should influence:

- Number of rolled stats.
- Roll quality.
- Affix count.
- Visual accent/frame.
- Loot sound.
- Comparison emphasis.

Rarity should not:

- Create unreadable projectile spam.
- Make lower-tier loot useless immediately.
- Bypass performance caps.

## 6. Equipped Loadout / Stash Plan

Current loadout foundation:

- A limited number of equipped weapon slots.
- Clear equipped/unequipped state.
- Weapon family and rarity display.
- Controller-friendly comparison and swap flow.
- Equipped weapon instances enable their runtime weapon family behavior.
- A stashed weapon can replace the selected equipped slot across families from the Armory.
- Generated weapon rewards can equip into open slots, replace selected equipped slots, go to stash, or be scrapped/skipped during a run.
- Replacement affects the active runtime loadout immediately and saves weapon inventory data.

Future loadout:

- Better slot category rules if flexible weapon-system slots become too loose.
- Manual unequip if empty slots are approved.
- Better duplicate-family handling and display.

Future stash:

- Persistent weapon storage.
- Sort/filter by rarity, family, level, equipped state, and favorite state.
- Weapon detail and comparison views.
- Safe destroy/sell/salvage flow now begins with Phase 28 stash scrap into Neon Dust.
- Weapon Forge progression now begins with Phase 29 per-weapon Neon Dust spending.

Inventory rules:

- Inventory/stash UI should pause gameplay.
- UI must use approved neon-glass/command-plate visual language.
- No default Godot UI.
- Stash and loadout expansion should remain phase-gated and focused.
- Stash-full cases must block unsafe replacement/stash actions instead of deleting old weapons.

## 7. Unlockable Player Cores

Planned player cores:

| Core | Shape Identity | Gameplay Lean |
| --- | --- | --- |
| Prism Core | Octahedron/diamond | Balanced baseline. |
| Rail Core | Long diamond/arrow fins | Movement speed and straight-line weapon bias. |
| Bastion Core | Cuboid armor plates | Higher health, slower movement. |
| Fractal Core | Stacked triangle shard crown | Split/shard weapon bias. |
| Singularity Core | Ring/lens shell | Magnet/gravity bias. |

Rules:

- Player cores should change playstyle, not invalidate baseline.
- Core silhouettes must remain readable and player-owned.
- Controller selection should be supported if a core screen is added later.

## 8. RPG Progression Layers

Candidate RPG progression:

- Player core unlocks.
- Player core levels.
- Weapon mastery.
- Weapon family mastery.
- Owned weapon Forge power ranks.
- Neon Dust economy upgrades.
- Sector unlocks.
- Difficulty tiers.
- Score/rank milestones.
- Boss trophies/codex entries.
- Achievement-style goals.
- Stash capacity upgrades, only if capacity limits are approved.

Rules:

- Permanent progression should unlock options more than mandatory raw power.
- Progression should support player goals between runs.
- New players should still have a strong baseline.

## Phase 29 Update — Weapon Forge Progression

Weapon Forge is the second major Neon Dust sink after Core Upgrades.

Current Forge progression:

- Owned weapon instances can be improved directly.
- Upgrade Power adds small, permanent stat bonuses to a specific weapon instance.
- Stat reroll replaces random stat rolls while preserving weapon family and rarity.
- Modifier reroll replaces modifiers only when the rarity supports modifier rolls.

Current cost model:

- Costs scale by rarity.
- Upgrade Power cost increases by current Forge rank.
- Reroll Stats has a lower fixed rarity-scaled cost.
- Reroll Modifier has a higher fixed rarity-scaled cost because modifiers are more build-defining.

Current balance rule:

- Forge should make a favorite weapon feel better over time, not erase loot decisions or make un-forged weapons useless.
- Forge power ranks are capped at 5 and use small percent bonuses.

Phase 32 Forge evolution/fusion:

- `EVOLVE / FUSE` now exists as a first foundation action inside the Weapon Forge.
- The selected weapon is the primary.
- A compatible stash weapon is selected as fusion material.
- Same-family material always works.
- Same geometry-group material works.
- The material weapon is consumed only after final confirmation.
- The primary weapon gains a saved `evolution_rank`, currently capped at 3.
- Evolution adds modest runtime stats through `evolution_stats`: damage, cooldown, range, and lifetime.
- Evolution does not currently add projectile-count, orbit-count, split-count, or chain-count bonuses.

Current fusion compatibility groups:

| Group | Families |
| --- | --- |
| Projectile | Pulse Blaster, Tri-Burst Cannon, Nova Needle, Vector Spear, Shield Breaker |
| Orbit | Orbit Spark, Ring Saw, Orbital Saw Array |
| Area / Field | Nova Burst, Gravity Mine, Gravity Well, Star Pulse |
| Chain / Beam | Arc Beam, Prism Chain, Prism Lance |
| Shard / Split | Fractal Shard, Fractal Bloom, Hex Mortar, Hex Shatter |

Future Forge directions:

- Ascend, family mastery, curated evolved forms, and stronger evolve visuals remain future systems.
- Future phases should add better preview UX, economy tuning, and long-term unlock requirements before adding high-impact Forge effects.

## 9. Difficulty Modifiers

Current Phase 30 combat pacing foundation:

- The active run now has a simple Wave Director that scales spawn interval, extra-spawn chance, and elite chance by sector, wave phase, and sector elapsed time.
- Sector 1 stays simpler and delays elites longer.
- Sector 2 emphasizes Prism Rift pressure through splitters, slicers, leeches, and pulsing enemies.
- Sector 3 emphasizes Null Zone control pressure through shield, pulse, leech, and heavier enemy groups.
- Sector 4 pushes faster Hyper Grid pressure with denser timing and higher capped elite presence.
- Elite variants currently use existing enemy families instead of adding new enemy types.
- Elite rewards are intentionally modest: extra XP, extra score, and a small chance at Neon Dust.

Current Phase 31 boss encounter foundation:

- Bosses now schedule major attacks through telegraphs before damage or projectile release.
- Boss phase shifts provide a combat notice, burst, audio cue, and `PHASE 2` HUD label.
- Boss death rewards continue to use the existing XP/reward flow.
- Boss telegraphs are capped and cleaned with combat hazards to prevent buildup.

Planned modifier types:

- Enemy speed up.
- Enemy health up.
- Reduced healing.
- Faster boss timers.
- Increased XP rewards with higher risk.
- Limited weapon pool challenges.
- Sector hazard variants after hazards are mature.

Rules:

- Modifiers should be optional.
- Modifiers should clearly show score/rank impact.
- Modifiers should not be mixed into normal mode without player choice.

## 10. Score / Rank System

Planned ranking inputs:

- Final score.
- Time survived.
- Sectors cleared.
- Bosses defeated.
- Damage taken.
- Deaths/restarts.
- Difficulty modifiers.
- Optional challenge constraints.

Candidate ranks:

- C
- B
- A
- S
- S+

Rules:

- Ranking should reward skilled survival and build execution.
- Ranking should not punish accessibility/settings choices like mute or fullscreen.
- Ranking should be shown on a future post-run summary screen.

## 11. Sector Unlocks

Planned direction:

- First-run onboarding may unlock sectors sequentially.
- Once unlocked, normal arcade mode can use the full sector chain.
- Future challenge modes may start at later sectors with adjusted starter rewards.

Sector unlock candidates:

| Sector | Unlock Condition |
| --- | --- |
| Neon Grid | Available by default. |
| Prism Rift | Clear Neon Grid. |
| Null Zone | Clear Prism Rift. |
| Hyper Grid | Clear Null Zone. |
| Fractal Core | Defeat Null Octagon Prime or clear a future four-sector run. |
| Singularity Swarm | Clear Fractal Core. |

## 12. Challenge Modes

Candidate challenge modes:

- Boss Rush: boss events only with controlled reward drops.
- Weapon Draft: choose a limited weapon pool before the run.
- Hyper Timer: shorter sectors with higher spawn pressure.
- No Magnet: lower pickup range, higher score multiplier.
- One Core: fixed player core and fixed starting weapon.
- Daily Seed: deterministic run only if future seeded content is approved.

Rules:

- Challenge modes should reuse official systems.
- No hidden playable scenes.
- No duplicate title screen.
- No new mode should bypass settings, audio, controller, pause, restart, or HUD requirements.

## 13. Achievement-Style Goals

Candidate goals:

- Clear each sector.
- Defeat each boss.
- Clear a run with a specific core.
- Clear a run with a specific weapon family.
- Collect a target amount of XP.
- Survive with low health for a short interval.
- Complete a sector without taking damage.
- Reach score thresholds.

Rules:

- Goals should unlock content, cosmetics, or challenge entries.
- Avoid grind-only goals.
- Avoid goals that encourage unreadable or passive play.

## 14. Post-Run Summary / Rewards

Current Phase 28 foundation:

- Death and run-complete panels now show score, sectors cleared, weapons gained, Neon Dust gained this run, and current total Neon Dust.
- Sector clears bank a small Neon Dust bonus.
- Run complete grants an additional Neon Dust bonus.
- Death grants a small partial Neon Dust reward based on kills and sectors cleared.

Longer-term planned post-run summary:

- Result: death, sector clear, run complete.
- Time.
- Sector reached.
- Bosses defeated.
- Kills.
- Score.
- Level reached.
- Weapons/upgrades chosen.
- Damage taken.
- Rank.
- Unlocks earned.
- Loot found.
- Weapons kept, salvaged, or sent to stash, if loot systems are approved.

Rules:

- Post-run UI should use the current command-plate/HUD visual language.
- Restart and return-to-title controls must remain controller-friendly.
- Summary should not replace the current death/success restart flow until a future phase approves it.

## 15. Save Data Boundaries

Settings already persist in a config file.

Current save boundary:

- Settings: volume, mute, fullscreen, VFX, screen shake.
- Inventory/progression config: owned weapon instances, equipped slots, stash contents, Neon Dust, Core Upgrade ranks.

Future progression save data may expand into a dedicated file if the system grows:

- Progression: unlocks, ranks, achievements, best scores, player core state.
- Inventory: owned weapon instances, equipped slots, stash contents, favorite/locked flags.

Rules:

- Do not mix progression and settings in one fragile blob.
- Save format should be inspectable and recoverable.
- Use schema/version fields for future migration.
- Add reset/clear progression only when progression exists.

## 16. Implementation Order Recommendation

Recommended order:

1. Inventory/stash UI prototype.
2. Manual equip/replace flow.
3. Weapon comparison panel.
4. Loot drop and pickup flow.
5. Post-run summary prototype.
6. Score/rank calculation.
7. Weapon unlock flags.
8. Player core roster.
9. Sector unlock flags.
10. Challenge modes.
11. Achievement-style goals.

Reasoning:

- Phase 19 established the weapon architecture needed before 200+ weapons are realistic.
- Stash/comparison UI should come before loot volume increases.
- Post-run summary and ranking create feedback before permanent progression expands.
- Challenge modes should wait until more content is stable.

## 17. Phase 28 Neon Dust / Core Upgrade Foundation

Implemented persistent currency:

- `NEON DUST` saves in `user://neon_swarm_weapon_inventory.cfg`.
- Old saves default to `0` dust and rank `0` upgrades.
- Stash weapon scrap now removes the stored weapon after confirmation and grants rarity-based Neon Dust.
- Generated weapon reward `SCRAP / SKIP` also grants rarity-based Neon Dust and does not store the weapon.

Current rarity scrap values:

| Rarity | Neon Dust |
| --- | ---: |
| Common | 8 |
| Uncommon | 16 |
| Rare | 30 |
| Epic | 55 |
| Legendary | 95 |
| Anomaly | 150 |

Core Upgrade terminal:

| Upgrade | Max Rank | Cost Pattern | Effect |
| --- | ---: | --- | --- |
| Core Vitality | 5 | 40 + 35 per owned rank | +6 max health per rank |
| Magnetic Field | 5 | 35 + 30 per owned rank | +0.35 XP pickup range per rank |
| Weapon Tuning | 5 | 55 + 45 per owned rank | +2% global weapon damage per rank |
| Coolant Flow | 5 | 55 + 45 per owned rank | -1.5% weapon cooldown per rank |

Balance note:

- Bonuses are intentionally modest and capped.
- Cooldown bonus is applied as a separate global multiplier and cannot bypass weapon/projectile caps.
- Core upgrades apply when a run starts from the saved loadout/progression state.
- Future tuning should use playtest data before adding larger upgrade trees.

## 18. Phase 30 Wave Director / Elite Progression Hooks

Implemented enemy pacing foundation:

- Wave Director reads sector profiles and wave phase data from the content catalog.
- Spawn intervals tighten as sectors and waves escalate.
- Extra spawn chance rises through peak/warning/cleanup waves while boss-active spawns are softened.
- Elite spawn checks are delayed out of the first wave and prevented during active boss fights.
- Active elite count is capped per sector to avoid early chaos and runaway pressure.

Implemented elite variants:

| Variant | Role | Reward Hook |
| --- | --- | --- |
| Overcharged | Faster pressure enemy with brighter cyan elite marker. | Extra XP/score, small Neon Dust chance. |
| Armored | Slower, tougher enemy with gold frame marker. | Extra XP/score, small Neon Dust chance. |
| Shielded | Adds temporary shield durability to eligible enemies. | Extra XP/score, small Neon Dust chance. |
| Volatile | Faster pressure enemy with a small death pulse. | Extra XP/score, small Neon Dust chance. |
| Splitter Elite | Stronger Triad Splitter variant with one extra capped fragment. | Extra XP/score, small Neon Dust chance. |

Balance guardrails:

- Elites are not a replacement for bosses.
- Elites do not drop weapons.
- Neon Dust from elites is a bonus chance, not the main economy source.
- Sector 1 elite access is delayed and capped lower than later sectors.
- Sector 4 can apply higher pressure, but enemy and projectile caps remain unchanged.

## 19. Phase 31 Boss Telegraph / Encounter Progression Hooks

Implemented boss encounter foundation:

- Prism Warden now rotates through shard fan, beam lane, and shield-pulse telegraphed attacks.
- Fractal Crown now telegraphs crown burst, line-pattern shard attack, and shard-summon attack.
- Null Octagon now telegraphs void ring, void pulse, and add-vector attacks.
- Null Octagon Prime now adds stronger multi-ring and Hyper Grid rail-sweep telegraphs.
- Boss attacks use existing projectile, hazard, add, and burst caps.
- Boss phase shifts are feedback-only progression events inside a run, not permanent progression.

Progression boundaries:

- Bosses still reward XP and sector reward flow through the existing boss-death path.
- Bosses do not drop weapons directly in Phase 31.
- Boss telegraph tuning should happen before future difficulty modifiers increase boss pressure.
- Future post-run summaries can later track boss hitless clears, boss phase survival, or boss defeat medals if approved.
