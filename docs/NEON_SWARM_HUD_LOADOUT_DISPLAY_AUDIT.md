# Neon Swarm HUD Loadout Display Audit

## Phase 38 Hotfix 6 — Non-Scrolling Gameplay Loadout Layout

Scope:

- Official scene only: `scenes/Main.tscn`.
- Gameplay HUD only, not Armory/Forge/menu UI.
- Visual/readability change only; no weapon gameplay, balance, save, controller, Armory, Forge, Evolution/Fusion, Neon Dust, or progression changes.

Godot docs/classes referenced:

- `Control`: fixed HUD panels are positioned in the 1920x1080 design root.
- `VBoxContainer`: vertical stat and weapon stacks use documented container layout.
- `HBoxContainer`: each weapon row uses a small horizontal icon/text layout.
- `ScrollContainer`: reviewed to confirm the gameplay HUD should not scroll; scrolling remains menu-only.

## Audit Result

Runtime equipped weapon capacity:

- `EQUIPPED_WEAPON_SLOT_CAP` is `8`.
- Equipped weapons are driven by `_equipped_weapon_instances`.

Old bottom HUD before Phase 38 HUD fixes:

- The bottom rail showed `DMG`, `RATE`, `SPD`, `PICKUP`, `ORBIT`, `LANCE`, `SAW`, and `MINE`.
- `DMG`, `RATE`, `SPD`, and `PICKUP` were run stat chips.
- `ORBIT`, `LANCE`, `SAW`, and `MINE` were weapon-family status chips.
- That meant the bottom rail represented only four weapon families, not all `8` equipped weapon slots.

Hotfix 5 result:

- Hotfix 5 changed the bottom rail to show `8` equipped weapon slots.
- The user still rejected the bottom rail layout as unclear for gameplay readability.

Hotfix 6 final layout:

- Top-left `GameplayCoreVitalsPanel`: health, XP, level, and core vitals remain at the screen edge.
- Top-right `GameplayRunTelemetryPanel`: timer, sector, kills, score, hostiles, and audio state remain at the screen edge.
- Left-side `GameplayStatsReadoutPanel`: vertical stat chips for `DMG`, `RATE`, `SPD`, and `PICKUP`.
- Right-side `GameplayEquippedWeaponVerticalPanel`: vertical equipped loadout display.
- `GameplayLoadoutEightSlotColumn`: fixed `VBoxContainer` with all `8` equipped weapon slots.
- Slots are named `GameplayLoadoutSlot01` through `GameplayLoadoutSlot08`.
- Each slot row has a `NeonWeaponIcon`, slot number, rarity code, and compact weapon name.
- Empty slots render as dim `EMPTY` rows.

Scrolling confirmation:

- The gameplay HUD does not use `ScrollContainer`.
- No equipped weapon slot is hidden behind scrolling.
- Menu systems may still use `ScrollContainer` where appropriate: Help, Armory, detail/comparison panels, stash lists, and weapon reward UI.

Manual test checklist:

- Start Game.
- Confirm the bottom loadout rail is gone.
- Confirm the left side shows run stats vertically.
- Confirm the right side shows `8` equipped weapon rows without scrolling.
- Confirm weapon names/icons remain readable while moving and fighting.
- Confirm empty slots, if present, are visibly dim and labeled `EMPTY`.
- Confirm top-left/top-right HUD panels stay at the screen edges.
- Confirm enemies, XP, bullets, player core, event objectives, and arena boundaries remain readable.
