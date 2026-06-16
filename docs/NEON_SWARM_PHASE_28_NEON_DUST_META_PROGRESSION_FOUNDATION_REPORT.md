# Neon Swarm Phase 28 - Neon Dust Economy / Meta Progression Foundation

## 1. Executive Summary

Phase 28 adds the first persistent roguelite progression foundation to the official build only: `scenes/Main.tscn`.

Implemented:

- Persistent `NEON DUST` currency.
- Rarity-based stash weapon scrap rewards.
- Generated weapon reward scrap converted from score to Neon Dust.
- Title menu `CORE UPGRADES` terminal.
- Four modest persistent upgrade lines.
- Death/run-complete economy summary text.
- Backward-compatible save/load defaults for older weapon inventory saves.

No new sectors, enemies, bosses, weapon families, gameplay balance overhaul, alternate scenes, or hidden test scenes were added.

## 2. Neon Dust Currency

`NEON DUST` now persists in `user://neon_swarm_weapon_inventory.cfg` under the `economy` section.

Sources currently implemented:

- Scrapping stored stash weapons.
- Scrapping/skipping generated weapon rewards.
- Sector clear bonus.
- Run complete bonus.
- Death/end-run partial bonus.

Old saves that do not contain economy data default to `0` Neon Dust.

## 3. Scrap Economy

Stored stash weapons now scrap into Neon Dust instead of score.

Rarity values:

| Rarity | Neon Dust |
| --- | ---: |
| Common | 8 |
| Uncommon | 16 |
| Rare | 30 |
| Epic | 55 |
| Legendary | 95 |
| Anomaly | 150 |

Safety behavior:

- Scrap is only available for stored stash weapons.
- Scrap requires confirmation.
- Confirmed scrap removes the weapon from stash.
- Equipped weapons are not scrappable through the Armory scrap flow.
- Save happens immediately after confirmed scrap.

## 4. Core Upgrade Terminal

The title menu now includes:

`START GAME`  
`ARMORY`  
`CORE UPGRADES`  
`OPTIONS`  
`HOW TO PLAY`  
`QUIT`

The Core Upgrade terminal shows:

- Current Neon Dust.
- Upgrade name.
- Rank / max rank.
- Cost.
- Current effect.
- Confirmation status.

Purchases require a second confirm press and save immediately.

## 5. Upgrade List / Costs / Effects

| Upgrade | Max Rank | Cost Pattern | Effect |
| --- | ---: | --- | --- |
| Core Vitality | 5 | 40 + 35 per owned rank | +6 max health per rank |
| Magnetic Field | 5 | 35 + 30 per owned rank | +0.35 XP pickup range per rank |
| Weapon Tuning | 5 | 55 + 45 per owned rank | +2% global weapon damage per rank |
| Coolant Flow | 5 | 55 + 45 per owned rank | -1.5% weapon cooldown per rank |

Bonuses are deliberately modest and capped.

## 6. Post-Run Reward Summary

Death and run-complete panels now include:

- Score.
- Sectors cleared.
- Weapons gained.
- Neon Dust earned this run.
- Total Neon Dust.

The summary was added inside the existing end panels. Restart behavior remains unchanged.

## 7. Save/Load Changes

Weapon inventory save now includes:

- Existing equipped weapons.
- Existing stash weapons.
- Existing discovered families.
- Existing weapon instance counter.
- New `economy/neon_dust`.
- New `core_upgrades/ranks`.

Backward compatibility:

- Missing economy data defaults to `0`.
- Missing upgrade ranks default to rank `0`.
- Invalid or over-cap ranks are clamped.

## 8. UI/Controller Support

Core Upgrades supports:

- D-pad / left stick selection.
- A / Enter confirm.
- B / Esc back.
- Two-step purchase confirmation.

Armory/Stash updates:

- Neon Dust readout.
- Scrap action text shows the exact Neon Dust value.
- Confirmation text shows the exact Neon Dust value.
- Existing right-stick scrolling and rarity UI remain intact.

## 9. Balance Notes

This is foundation, not a power spike.

- Health gains are small.
- Pickup range gains are small.
- Global damage gains are small.
- Cooldown gains are small and applied through the existing capped weapon cooldown multiplier.
- Projectile, enemy, mine, beam, XP, and burst caps remain unchanged.

## 10. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_28_NEON_DUST_META_PROGRESSION_FOUNDATION_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_UI_HOTFIX_2_RARITY_HIGHLIGHT_MODAL_RIGHT_STICK_SCROLL_REPORT.md`

Temporary validation scripts were created under `/tmp` only and are not part of the project build.

## 11. Validation Results

Passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd`
- Additional short reload after resetting validation-created economy noise.

Save readback:

- Current user save contains `[economy] neon_dust=0`.
- Current user save contains `[core_upgrades] ranks={...}`.
- This confirms old/current save can load the new sections and starts clean at zero currency/rank defaults.

Notes:

- I did not delete the player save to simulate a destructive fresh-save path.
- Fresh missing-save behavior is handled in code by initializing Neon Dust to `0` and upgrade ranks to `0` before saving the default starter loadout.

## 12. Exact Run Command

`godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`

## 13. What I Should Test

Test manually:

- Open title menu and confirm `CORE UPGRADES` appears.
- Open Core Upgrades and confirm Neon Dust reads `0` on the current save.
- Try buying an upgrade with no dust; it should block purchase.
- Clear a sector and confirm Neon Dust is banked.
- Open Armory and confirm Neon Dust readout appears.
- Scrap a stored weapon and confirm the confirmation prompt shows the dust amount.
- Confirm the weapon is removed from stash after scrap.
- Confirm Neon Dust persists after restart.
- Buy a Core Upgrade after earning enough dust.
- Start Game and confirm the upgrade applies.
- Die or complete a run and check the economy summary.
- Confirm Armory/Stash, Options, How To Play, pause, controller navigation, XP, rewards, and runtime weapons still work.

## 14. Known Issues

- Core Upgrades are intentionally small and not yet a full RPG tree.
- There is no reset/refund upgrade UI yet.
- Neon Dust has no shop beyond Core Upgrades yet.
- Post-run summary is still compact inside the existing end panels, not a full results screen.
- Custom isolated `--user-data-dir` validation crashed Godot before project code while opening the log path, so I avoided using it and did not delete the real player save.

## 15. Approval Question

Is Phase 28 approved as the first Neon Dust economy and meta-progression foundation?
