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
