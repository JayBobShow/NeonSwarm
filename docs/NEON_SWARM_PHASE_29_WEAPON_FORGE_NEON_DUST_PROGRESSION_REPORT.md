# Neon Swarm Phase 29 — Weapon Forge / Neon Dust Weapon Progression Report

## 1. Executive Summary

Phase 29 adds the first Weapon Forge foundation to the official build only: `scenes/Main.tscn`.

Neon Dust now has a second major use beyond Core Upgrades. Players can select owned weapons in the Armory and spend Neon Dust to upgrade weapon power, reroll stat rolls, or reroll modifiers when rarity supports modifiers.

No new weapons, enemies, bosses, sectors, or gameplay balance rewrites were added.

## 2. Weapon Forge Access

Forge access is inside the existing Armory flow.

- Equipped weapon selected: confirm opens `FORGE SELECTED`.
- Inventory/Stash weapon selected: confirm opens `EQUIP / SWAP`, `FORGE SELECTED`, `SCRAP`, and `CANCEL`.
- Forge works for both equipped and stashed weapons.
- Equipped forged weapons affect runtime behavior through the existing weapon stat totals.
- Stashed forged weapons remain stored and inactive until equipped.

## 3. Forge Actions

Implemented Forge actions:

- `UPGRADE POWER`: increases the selected weapon's permanent Forge rank.
- `REROLL STATS`: rerolls the selected weapon's random stat rolls while keeping family and rarity.
- `REROLL MOD`: rerolls modifier rolls only when the weapon rarity supports modifiers.

Safety behavior:

- Every Forge action opens a confirmation panel before spending Neon Dust.
- Insufficient Neon Dust blocks the action and shows a clear message.
- Modifier reroll is shown as locked when the weapon rarity does not support modifiers.

## 4. Neon Dust Costs

Current costs:

- Upgrade Power: `(20 + current_rank * 18) * rarity_multiplier`
- Reroll Stats: `24 * rarity_multiplier`
- Reroll Modifier: `42 * rarity_multiplier`

Rarity multipliers:

- Common: `1.00`
- Uncommon: `1.25`
- Rare: `1.65`
- Epic: `2.15`
- Legendary: `3.00`
- Anomaly: `4.00`

## 5. Upgrade / Reroll Rules

Upgrade Power:

- Max rank: `5`
- Per-rank bonuses: `+1.2% damage`, `-0.4% cooldown`, `+0.4% range`
- Stored as `forge_power_rank` and `forge_power_stats` on the weapon instance.

Reroll Stats:

- Keeps weapon family.
- Keeps rarity.
- Keeps equipped/stash state.
- Replaces random stat rolls.

Reroll Modifier:

- Keeps weapon family.
- Keeps rarity.
- Replaces modifier rolls only.
- Locked for rarities without modifier support.

## 6. Save/Load Changes

Weapon save schema was bumped to version `2`.

Each weapon instance can now store:

- `forge_power_rank`
- `forge_power_stats`
- `forge_dust_spent`

Old saves remain safe because missing Forge fields default to un-forged values.

## 7. UI / Controller Support

Armory UI updates:

- Weapon rows show `F#` when a weapon has Forge power ranks.
- Detail panel shows Forge rank, Forge bonuses, and Neon Dust invested.
- Comparison panel switches to Forge preview text while Forge actions are active.
- Confirm panel shows action cost and before/after preview before spending.

Existing controls remain:

- D-pad / left stick: selection.
- Right stick: scroll active scroll panels.
- A / Enter: confirm.
- B / Esc: back/cancel.

## 8. Balance Notes

Forge bonuses are intentionally modest.

This phase is a progression foundation, not a power spike:

- Power rank is capped.
- Per-rank bonuses are small.
- Rerolls preserve family and rarity.
- Forge does not bypass existing projectile, cooldown, split, orbit, mine, beam, or VFX caps.

## 9. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/content/NeonWeaponCatalog.gd`
- `docs/NEON_SWARM_PHASE_29_WEAPON_FORGE_NEON_DUST_PROGRESSION_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`

Temporary validation scripts were created under `/tmp` and are not playable scenes.

## 10. Validation Results

Passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase29_forge_validation.gd`

Forge validation covered:

- Forge opens from Armory.
- Selected weapon appears in Forge.
- Upgrade Power spends Neon Dust.
- Upgraded weapon saves/loads.
- Stat reroll works.
- Modifier reroll works where allowed.
- Insufficient Neon Dust blocks the action.
- Confirm/cancel path works.

The weapon inventory save was backed up before mutating validation scripts and restored afterward.

## 11. Exact Run Command

`godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`

## 12. What I Should Test

Test in the official build:

1. Open Armory.
2. Select an equipped weapon.
3. Confirm and open Forge.
4. Try Upgrade Power with enough Neon Dust.
5. Try Reroll Stats.
6. Try Reroll Modifier on a higher-rarity weapon.
7. Confirm that insufficient Neon Dust blocks spending.
8. Start Game and confirm forged equipped weapons still fire normally.
9. Return to Armory and confirm Forge rank/stat changes persist.

## 13. Known Issues

- Forge does not yet include future locked actions such as Evolve, Fuse, or Ascend.
- Forge preview is text/icon based; it does not yet include a dedicated animated before/after stat card.
- Modifier reroll requires a rarity that supports modifiers.
- There is no dedicated Forge tutorial page yet beyond Armory text.

## 14. Approval Question

Is Phase 29 approved as the Weapon Forge / Neon Dust weapon progression foundation?
