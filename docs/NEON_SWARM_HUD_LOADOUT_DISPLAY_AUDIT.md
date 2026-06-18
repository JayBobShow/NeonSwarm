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

## Phase 38 Hotfix 7 — HUD Panel Spacing and Play-Area Protection

Scope:

- Official scene only: `scenes/Main.tscn`.
- Gameplay HUD layout refinement only.
- Kept the Hotfix 6 direction: left-side vertical stat stack and right-side vertical `8`-slot equipped weapon stack.
- No gameplay, weapon, balance, save, Armory, Forge, progression, arena bounds, or ripple behavior was changed.

Godot docs/classes referenced:

- `Control`: fixed HUD panels remain positioned in the 1920x1080 design-space root with explicit size and position.
- `VBoxContainer`: the stat and weapon stacks remain vertical container layouts with explicit row spacing.
- `ScrollContainer`: reviewed to confirm the gameplay loadout HUD remains non-scrolling.

Old overlap/play-area issue:

- `GameplayCoreVitalsPanel` and `GameplayRunTelemetryPanel` were `360px` wide.
- `GameplayStatsReadoutPanel` and `GameplayEquippedWeaponVerticalPanel` began at `y = 176`, only `16px` below the top panels.
- The telemetry panel's timer and five telemetry rows also caused runtime container expansion beyond the requested rect, which made the right stack read as overlapping.
- The right weapon panel was `542px` tall and visually dominated the right side.
- The layout showed all `8` weapon rows, but the panel footprint intruded too much into the central play area.

Final non-scrolling spacing solution:

- Top-left `GameplayCoreVitalsPanel`: `Rect2(18, 28, 300, 132)`.
- Left `GameplayStatsReadoutPanel`: `Rect2(18, 198, 226, 224)`.
- Top-right `GameplayRunTelemetryPanel`: `Rect2(1602, 28, 300, 132)`.
- Right `GameplayEquippedWeaponVerticalPanel`: `Rect2(1602, 190, 300, 438)`.
- Core vitals and telemetry now have clean vertical gaps before their side stacks begin after runtime container sizing.
- Telemetry typography was compacted: timer font `36 -> 28`, telemetry row font `12 -> 10`, and telemetry column separation `4px -> 1px`.
- Health/XP bars were reduced to `252px` so the narrower vitals panel does not overflow.
- Weapon rows were compacted to `268x46` with `34x34` icons and `4px` vertical separation, so all `8` rows fit cleanly without scrolling.

Top-center notification protection:

- Top-center boss/combat/objective/test rails remain centered and separate from side HUD.
- Combat notice, objective, and event test rails were slightly reduced/repositioned to avoid glow crowding.

HUD audit confirmation:

- `EQUIPPED_WEAPON_SLOT_CAP` remains `8`.
- `GameplayLoadoutEightSlotColumn` still creates `GameplayLoadoutSlot01` through `GameplayLoadoutSlot08`.
- All equipped weapon slots are visible/represented.
- Empty slots remain visibly dim and labeled `EMPTY`.
- The gameplay HUD does not use a `ScrollContainer`.
- Menu scroll containers remain separate and unchanged.

Manual test checklist:

- Start Game.
- Confirm the Core Vitals panel does not overlap the left stat stack.
- Confirm the telemetry panel does not overlap the right weapon stack.
- Confirm all `8` weapon slots remain visible on the right side.
- Confirm the HUD does not scroll.
- Confirm the side HUD feels outside or at the edge of the gameplay arena as much as practical.
- Confirm top-center notification/objective panels do not collide with side panels.
- Confirm enemies, XP, bullets, player core, Phase 37 ripple, event objectives, and arena boundaries remain readable.

## Phase 38 Hotfix 8 — Weapon HUD Upgrade Stat Feedback Restore

Scope:

- Gameplay HUD only.
- Restores weapon upgrade/stat feedback to the right-side `8`-slot weapon stack.
- Keeps the Phase 38 side HUD layout, all `8` visible slots, and no scrolling.
- No weapon gameplay, upgrade balance, save data, loadout capacity, Armory, Forge, Evolution/Fusion, arena bounds, or controls were changed.

Godot docs/classes referenced:

- `Control`: fixed side HUD placement remains in the existing design-space root.
- `VBoxContainer`: the right weapon stack remains one vertical non-scrolling column.
- `Label`: weapon rows now use a compact three-line label for status and stat feedback.
- `ScrollContainer`: reviewed to confirm gameplay HUD scrolling was not reintroduced.

Missing information found:

- Hotfix 6/7 right-side weapon rows showed only slot number, rarity code, and weapon name.
- The old bottom rail had weapon-family feedback chips for `ORBIT`, `LANCE`, `SAW`, and `MINE`.
- Those old chips did not show all `8` equipped slots, but they did communicate weapon upgrades/status that the new stack needed to recover.

Current data source:

- Equipped rows read `_equipped_weapon_instances`.
- Instance stat rolls, modifiers, forge stats, and evolution stats are summarized with `WeaponCatalog.stat_totals(instance)`.
- Runtime weapon-family upgrades from XP choices are folded into the display for the affected weapon family.
- Global/player upgrades remain on the left stat stack.

Final right-side row format:

- Line 1: `SLOT ##`, rarity code, and status.
- Line 2: compact weapon name.
- Line 3: up to two compact stat feedback items, or `PWR #.##` when no bonus stats exist.

Status values:

- `READY`: weapon timer is ready.
- `CD #.#s`: weapon is cooling down.
- `ACTIVE`: persistent orbit/saw style weapon is active.
- `OFF`: weapon family is not enabled.

Displayed stat examples:

- `DMG +12%`
- `RATE +8%`
- `CD -15%`
- `PROJ +1`
- `PIERCE +1`
- `SPLIT +2`
- `CHAIN +1`
- `ORBIT +1`
- `AREA +10%`
- `SPIN +12%`
- `BEAM +0.08s`

XP/run upgrade feedback:

- `_apply_upgrade()` now marks affected weapon-family rows for a brief highlight when the upgrade is weapon-specific.
- `_apply_weapon_reward()` also marks the affected equipped row after weapon loot/replacement changes rebuild weapon stat bonuses.
- Highlight duration is `1.45s` and uses persistent row style updates, not spawned VFX nodes.

Layout confirmation:

- `GameplayLoadoutEightSlotColumn` still creates exactly `GameplayLoadoutSlot01` through `GameplayLoadoutSlot08`.
- Weapon row height is `48px`, icon size is `32px`, and stack separation is `3px`.
- The gameplay HUD still has no `ScrollContainer`.
- Empty slots still show `EMPTY` and `--`.

Manual test checklist:

- Start Game.
- Confirm all `8` equipped weapon slots remain visible on the right.
- Confirm each equipped row shows status plus stat feedback or `PWR`.
- Choose an XP upgrade that targets a weapon family and confirm the matching row updates/highlights.
- Confirm global upgrades still change the left `DMG`, `RATE`, `SPD`, or `PICKUP` chips.
- Confirm no HUD scrolling appears during gameplay.
- Confirm the HUD stays outside the play area as much as practical.
