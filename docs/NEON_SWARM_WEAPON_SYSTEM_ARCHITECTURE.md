# Neon Swarm Weapon System Architecture

## 1. Purpose

Phase 19 begins the weapon architecture needed for a long-term RPG / roguelite weapon ecosystem.

The current implementation is a foundation, not the final 200+ weapon system.

## 2. Core Concepts

Weapon Definition:

- Stable weapon blueprint.
- Owns id, display name, family, archetype, shape identity, base stats, allowed stat rolls, allowed modifiers, and future VFX/audio hooks.

Weapon Instance:

- Generated owned item.
- Owns instance id, definition id, rarity, seed, rolled stats, modifier rolls, equipped/stashed state, favorite/locked flags, and power score.

Weapon Family:

- Broad identity group such as Pulse Blaster, Orbit Spark, Prism Lance, or Ring Saw.
- Used for UI grouping, stat application, and future mastery/unlocks.

Weapon Archetype:

- Gameplay behavior class such as rapid projectile, orbit contact, chain beam, area pulse, or split projectile.

Rarity Tier:

- Loot quality tier that controls stat roll count, roll strength, modifier chance, UI accent, and drop weight.

Stat Rolls:

- Bounded random stat values such as damage bonus, cooldown reduction, projectile speed, lifetime, split count, or chain count.

Modifier Rolls:

- Named modifiers that can add one or more small stat effects and later become behavior modifiers.

Equipped Weapon Slots:

- Current prototype supports a capped equipped instance list that drives active runtime weapon families.
- The cap is currently conservative and preserves run balance while allowing cross-family replacement.

Stash / Stored Weapons:

- Backend storage exists for generated weapon instances that are not equipped.
- Phase 20 added the first player-facing Armory/Stash UI.
- Phase 21 lets stashed weapons replace the selected equipped slot across weapon families.
- Phase 22 adds in-run generated weapon reward routing for equip, replace, stash, and scrap/skip decisions.
- Phase 23 adds the first weapon content pack and expanded modifier pool.
- Phase 24 adds player-facing instruction surfaces that explain automatic weapons, generated weapon rewards, equipped slots, stash behavior, and Armory loadout impact.

Weapon Comparison Data:

- Candidate and current power score.
- Power delta.
- Per-stat deltas.
- Relation: new, upgrade, or downgrade.

Weapon Icon / Preview Data:

- Phase 25 implements one family-level icon/preview per active weapon family, plus a fallback unknown weapon icon.
- Phase 25 icons were functional preview icons / placeholder UI symbols, not final weapon art.
- Phase 27 Repair upgrades the active icon path to Blender-rendered PNG family icons where practical while preserving the same one-icon-per-family mapping.
- Phase 27 Repair 2 regenerates the active weapon-family preview PNGs from the actual Blender weapon models where practical.
- Phase 27 Repair 3 animates those existing Blender-derived family previews in UI with subtle spin, pulse, and energy arcs.
- Runtime UI icons are drawn by `scripts/ui/NeonWeaponIcon.gd` so rarity accents and family shapes can be reused without creating separate art for every random instance.
- `NeonWeaponIcon.icon_ids()` is the current family id allow-list.
- `NeonWeaponIcon.icon_resource_path(definition_id)` maps weapon family ids to rendered PNG files under `art/weapons/icons/exported/`, with `unknown_weapon_icon_hd.png` as fallback.
- Icons/previews are derived from geometry shape identity, not generic item art.
- Visual style matches Neon Swarm dark bodies and bright neon tube edges.
- Active examples: triangle spread for Tri-Burst Cannon, hex shell for Hex Mortar, piercing arrow/rail for Vector Spear, neon ring/vortex for Gravity Well, radial starburst for Star Pulse, and rotating saw ring for Ring Saw.
- The pipeline supports Armory, stash rows, reward cards, comparison panels, replacement slot rows, and How To Play / weapon explanation pages.
- Phase 27 Repair replaces the Phase 25 placeholder UI symbols with Blender-rendered PNG family icons where practical while preserving the same family-level mapping.
- Blender-rendered icon sources live under `art/weapons/icons/source/rendered_from_3d/`; exported PNGs live under `art/weapons/icons/exported/`.
- A future larger art pass can still improve the icons, but the active UI now uses animated rendered family icons from Blender weapon art instead of procedural placeholder drawings when the PNG exists.
- Future 200+ weapon scaling should reuse this family-preview mapping system; random weapon instances should not require separate manual art.

Weapon Visual / VFX Art Data:

- Phase 27 Repair adds Blender `.blend` source files and mesh-only `.glb` gameplay visual assets for every active weapon family.
- Phase 27 Repair 2 keeps the same runtime weapon model mapping, regenerates weapon preview renders from Blender, and does not change weapon damage, cooldown, random-stat, or projectile cap behavior.
- Runtime weapon projectile and field presentation uses `art/weapons/exported/3d/*.glb` through helper functions in `scripts/NeonSwarm3DGameplayPrototype.gd`.
- The visual art layer is keyed by weapon family id and does not change weapon damage, cooldowns, projectile caps, target logic, or generated stat math.
- Missing future visual art falls back safely to the existing mesh/procedural presentation instead of crashing, but those fallbacks are not the approved final gameplay-object art direction.

## 3. Current Implementation

Added:

- `scripts/content/NeonWeaponCatalog.gd`

The catalog defines:

- Rarity tiers.
- Initial weapon definitions plus Phase 23 weapon content pack definitions.
- Random stat pools.
- Expanded modifier pools.
- Default loadout ids.
- Weapon instance generation.
- Power scoring.
- Stat aggregation.
- Comparison data.

Official gameplay script integration:

- `scripts/NeonSwarm3DGameplayPrototype.gd` preloads the weapon catalog.
- Existing weapons remain functional.
- Equipped weapon instances load on boot.
- Stash instances load on boot.
- Sector reward flow can generate weapon loot.
- Selected generated weapons open an in-run loot decision console.
- In-run weapon rewards can equip into open slots, replace selected equipped slots, go to stash, or be scrapped/skipped.
- Title menu Armory can display equipped weapons, stashed weapons, details, and comparison.
- Title menu Armory can equip/swap stashed weapons into the selected equipped slot across families.
- Runtime weapon updates enable or disable weapon family logic from the equipped instance list.
- Phase 23 weapon families use the same runtime router and caps as earlier weapons.
- Weapon data saves separately from options.
- How To Play pages and compact helper text now explain the weapon system from the player point of view.
- Phase 25 added `scripts/ui/NeonWeaponIcon.gd`, initial SVG/placeholder icon assets, Armory/list previews, reward card previews, replacement slot icons, comparison icons, and How To Play example icon rows.
- Phase 27 Repair upgrades those icon visuals with Blender-rendered PNG assets and adds Blender `.glb` gameplay weapon models for projectile, beam, orbit, mine, pulse, field, and burst readability.
- Phase 27 Repair 2 confirms Armory, stash, reward cards, replacement UI, comparison panels, and How To Play still use the `NeonWeaponIcon` path backed by Blender-rendered weapon-family PNGs where practical.
- Phase 27 Repair 3 adds animation inside `NeonWeaponIcon`, so the same previews animate everywhere that existing weapon-related menus already use that control.

## 4. Active Weapon Families

Baseline mapped families:

- Pulse Blaster
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine
- Prism Lance
- Ring Saw
- Hex Shatter
- Fractal Shard

Phase 23 content pack families:

- Tri-Burst Cannon
- Hex Mortar
- Vector Spear
- Orbital Saw Array
- Prism Chain
- Gravity Well
- Nova Needle
- Fractal Bloom
- Shield Breaker
- Star Pulse

Note:

- Hex Shatter is included because it is already active gameplay content, even though the long-term direction list emphasized the other existing families.
- Fractal Shard remains a generated/unlock-style weapon family and is not forced active at run start.
- Phase 23 families are active loot definitions and have runtime hooks; they are not placeholder catalog entries.

## 5. Runtime Stat Connections

Connected safely:

- Damage bonus.
- Fire rate bonus.
- Cooldown reduction.
- Projectile speed.
- Projectile lifetime.
- Projectile count for Pulse Blaster.
- Pierce for Prism Lance and Fractal Shard.
- Split count for Hex Shatter and Fractal Shard.
- Chain count for Arc Beam.
- Orbit count for Orbit Spark.
- Range/area for Nova Burst, Ring Saw, Gravity Mine, and Arc Beam.
- Equipped weapon family activation.
- Cross-family loadout replacement through the Armory.
- In-run cross-family slot replacement for generated weapon rewards.
- Phase 23 family runtime hooks: spread shots, arcing mortar burst, rail pierce, orbit saw pulse, prism chain beam, gravity well field, rapid needles, controlled fractal bloom split, heavy shield breaker, and radial star pulse.
- Ricochet modifier support for projectile families that opt into one-bounce behavior.

Not connected yet:

- True crit chance.
- Deep behavior-changing affixes.
- Dedicated manual unequip screen.
- Deeper salvage/sell/crafting economy beyond Phase 28 Neon Dust.
- Enemy-dropped live loot pickup flow.

## 6. Save Files

Settings remain separate:

- `user://neon_swarm_settings.cfg`

Weapon inventory uses:

- `user://neon_swarm_weapon_inventory.cfg`

Weapon save data includes:

- Schema version.
- Instance counter.
- Equipped weapon instances.
- Stash weapon instances.
- Discovered families.
- Neon Dust.
- Core Upgrade ranks.

Tutorial/help settings include:

- First-run hint flags in `user://neon_swarm_settings.cfg`.
- Hints are player education state, not weapon inventory state.

## 7. Safety Rules

All generated stats must remain bounded.

## Phase 29 Update — Weapon Forge Foundation

Phase 29 adds a Neon Dust Weapon Forge foundation on top of the existing weapon instance model.

New weapon instance fields:

- `forge_power_rank`: permanent per-weapon power rank, currently capped at rank 5.
- `forge_power_stats`: modest permanent stat bonuses generated from the power rank.
- `forge_dust_spent`: total Neon Dust spent on that weapon instance.

Forge actions:

- Upgrade Power: increases `forge_power_rank` and writes small bonuses into `forge_power_stats`.
- Reroll Stats: rerolls `stat_rolls` while keeping the same weapon family, rarity, equipped/stash state, and modifier rolls.
- Reroll Modifier: rerolls `modifier_rolls` only when the weapon rarity supports modifiers.

Runtime behavior:

- `WeaponCatalog.stat_totals()` now includes `forge_power_stats`.
- `WeaponCatalog.estimate_power()` includes forge power stats in the displayed power score.
- Existing runtime weapon routing continues to read equipped weapon instances, so forged equipped weapons affect gameplay through the same stat path as generated weapon rolls.
- Stashed forged weapons remain inactive until equipped.

Safety:

- Forge power is capped at 5 ranks.
- Upgrade bonuses are intentionally modest: +1.2% damage, -0.4% cooldown, and +0.4% range per rank.
- Rerolls keep family and rarity stable, preventing one weapon from turning into another family.
- Every Forge action requires a confirmation before Neon Dust is spent.
- Old saves without Forge fields load safely because missing fields default to rank 0 and empty forge stats.

Current caps preserved:

- Enemy cap.
- XP cap.
- Player projectile cap.
- Enemy projectile cap.
- Burst cap.
- Beam cap.
- Mine cap.
- Hazard cap.
- Orbit visual cap.

Weapon rolls must never bypass these caps.

## Phase 32 Update — Evolution / Fusion Foundation

Phase 32 adds the first Weapon Forge evolution/fusion foundation. This is a progression system for owned weapon instances, not a new weapon content pack.

New weapon instance fields:

- `evolution_rank`: saved evolution rank, capped at rank 3.
- `evolution_stats`: modest stat bonuses from the current evolution rank.
- `fusion_history`: short saved record of recent material weapons consumed by fusion.
- `fusion_dust_spent`: total Neon Dust spent on evolution/fusion for that weapon instance.

Forge action:

- `EVOLVE / FUSE`: selects the current owned weapon as the primary, then selects one compatible stash weapon as material.
- The material weapon is consumed only after a final confirmation.
- Neon Dust is spent only after confirmation.
- Same-family fusion is always compatible.
- Same geometry group fusion is compatible.
- Incompatible material weapons are blocked.

Compatibility groups:

| Group | Families |
| --- | --- |
| Projectile | Pulse Blaster, Tri-Burst Cannon, Nova Needle, Vector Spear, Shield Breaker |
| Orbit | Orbit Spark, Ring Saw, Orbital Saw Array |
| Area / Field | Nova Burst, Gravity Mine, Gravity Well, Star Pulse |
| Chain / Beam | Arc Beam, Prism Chain, Prism Lance |
| Shard / Split | Fractal Shard, Fractal Bloom, Hex Mortar, Hex Shatter |

Runtime behavior:

- `WeaponCatalog.stat_totals()` includes `evolution_stats`.
- `WeaponCatalog.estimate_power()` includes `evolution_stats`.
- Equipped evolved weapons affect runtime through the same safe stat path used by random rolls and Forge power.
- Stashed evolved weapons remain inactive until equipped.

Current evolution stat effects:

- +1.8% damage per evolution rank.
- -0.6% cooldown per evolution rank.
- +0.6% range per evolution rank.
- +0.4% lifetime per evolution rank.

Safety:

- Evolution is capped at rank 3.
- Fusion does not add projectile-count, chain-count, orbit-count, or split-count bonuses yet.
- Fusion cannot consume a weapon without confirmation.
- Fusion consumes only stash weapons, not equipped weapons.
- Old saves without evolution fields load safely as rank 0 weapons.

## 8. Future Architecture Work

Later phases should add:

- Dedicated weapon resources or JSON-like data files if the catalog grows.
- Further Blender model polish if the Phase 27 Repair source assets need higher-detail revisions.
- Dedicated 3D-derived texture previews for future weapon families using the Phase 27 Repair icon/visual mapping pattern.
- More advanced inventory/stash UI.
- Explicit slot categories or flexible-slot tuning after more weapon families exist.
- Larger weapon comparison panel.
- Loot pickup flow.
- Rarity drop presentation.
- Stash-full overflow handling beyond blocking unsafe replacement/stash actions.
- Weapon family mastery.
- Full save migration/versioning.
- Deeper player-facing icon glossary support if future weapon volume makes the current How To Play examples insufficient.

## UI Hotfix 2 Weapon Presentation Notes

- Rarity presentation is now part of the shared weapon UI component path.
- `NeonWeaponIcon` displays rarity through a stronger frame, glow strip, and corner badge.
- Weapon list rows receive rarity strip metadata so Equipped, Stash, replacement, and generated weapon contexts do not rely on small rarity text alone.
- Right-stick scrolling uses existing aim actions during active UI menus only; runtime weapon aiming remains unchanged during gameplay.

## Hotfix 2 Repair — Fixed Equipped Layout, Detail Scrolling, Right-Stick Scroll, How To Play Modal, and Stash Scrap

- Equipped Loadout UI is now fixed-size because the current runtime slot cap is `8`.
- Inventory / Stash stays scrollable and remains the only Armory list intended to grow.
- Armory detail and comparison panels keep independent scroll regions for long weapon stats and comparison text.
- Right-stick UI scroll routing is separated from left-stick/D-pad selection.
- Stash scrap is a stored-weapon-only action with a confirmation state.
- Current scrap reward is saved Neon Dust based on weapon rarity.
- Scrapping does not change weapon runtime behavior, random stat generation, combat balance, or equipped loadout rules.

## Phase 28 Neon Dust / Meta Progression Hooks

Weapon economy hooks now active:

- Stored weapons in Inventory / Stash can be scrapped for Neon Dust.
- Generated weapon rewards can be scrapped/skipped for Neon Dust.
- Scrap value comes from rarity:
  - Common: 8
  - Uncommon: 16
  - Rare: 30
  - Epic: 55
  - Legendary: 95
  - Anomaly: 150
- Neon Dust is persisted in `user://neon_swarm_weapon_inventory.cfg` with weapon inventory data.
- Core Upgrade ranks are persisted in the same config under a separate progression section.

Runtime integration:

- Core Vitality increases max health before active run play.
- Magnetic Field adds to XP pickup radius without replacing temporary run pickup upgrades.
- Weapon Tuning multiplies global weapon damage without changing individual weapon definitions.
- Coolant Flow multiplies weapon cooldowns through the existing cooldown multiplier path and remains capped.

Architecture note:

- Phase 28 intentionally keeps economy data compact and inspectable.
- A later larger progression system can split progression into its own file if the save format grows beyond inventory/economy basics.
