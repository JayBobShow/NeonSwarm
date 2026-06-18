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

## Phase 38 Hotfix 9 — Upgrade-to-Weapon Clarity and Reward Pool Audit

Scope:

- Gameplay reward-card clarity and in-run weapon HUD linkage.
- Kept the approved side HUD layout.
- Kept all `8` equipped weapon slots visible.
- Kept the gameplay HUD non-scrolling.
- No weapon balance, damage, cooldown, target count, progression, save data, Armory, Forge, Evolution/Fusion, arena bounds, player controls, or Phase 37 ripple behavior was changed.

Godot docs/classes referenced:

- `Control`: fixed side HUD panels remain anchored/positioned in the design-space HUD root.
- `VBoxContainer`: left stat stack and right equipped weapon stack remain fixed vertical containers.
- `Button`: level-up/reward cards use focus events to update selected-card preview linkage.
- `Label`: weapon rows continue to use compact multiline status/stat feedback.
- `ScrollContainer`: reviewed to confirm no gameplay HUD scrolling was introduced.

Missing clarity found:

- Upgrade cards previously showed title, description, and category, but not the affected equipped slot.
- Player could not immediately tell whether a card was a current-weapon buff, global stat buff, non-equipped family buff, new run weapon unlock, or generated weapon route.
- Right-side rows flashed after an upgrade was accepted, but selection did not preview the affected row.
- `_roll_upgrade_choices()` prevented exact duplicate cards in one panel only; it did not suppress recent repeated IDs or same-family clustering.

Final card format:

- Card title.
- `AFFECTS: ...`
- `GAIN: ...`
- `TYPE: ...`

Examples now supported:

- `AFFECTS: SLOT 02 - ORBIT SPARK`
- `AFFECTS: NEW RUN WEAPON - FRACTAL SHARD`
- `AFFECTS: FRACTAL SHARD FAMILY - NOT EQUIPPED`
- `AFFECTS: GLOBAL CORE STATS`
- `AFFECTS: NEW WEAPON - OPEN SLOT`
- `GAIN: PIERCE 4 -> 5`
- `GAIN: DMG +12% / RATE +10%`
- `GAIN: PULSE COUNT 1 -> 2`

Equipped weapon row linkage:

- Selecting a card computes affected weapon definitions from its effects.
- Equipped affected definitions get a cyan preview highlight on the right-side weapon row before confirmation.
- Confirmed weapon-specific upgrades still use the Hotfix 8 gold flash.
- Global weapon-output upgrades preview all equipped rows; player-only global upgrades remain left-stat-stack information.
- Non-equipped-family or new-run-weapon cards explain that no current slot is affected instead of highlighting a misleading row.

Right weapon stack adjustment:

- Right panel moved slightly lower and taller: `Rect2(1602, 204, 300, 462)`.
- Row size increased to `272x50`.
- Weapon icon size increased to `34x34`.
- Text label size increased to `216x44`, with font size `9`.
- All `8` slots remain visible in a single non-scrolling vertical stack.

Reward pool audit result:

- Existing pool weights are implicit one-entry-per-upgrade, but the Fractal family has multiple entries and could appear repeatedly across nearby level-ups.
- The same panel already removed exact duplicate IDs, but could still roll several same-family cards.
- Hotfix 9 adds a recent-card history of the last `9` shown level-up card IDs and avoids those IDs while enough alternatives exist.
- Hotfix 9 also avoids repeating the same primary target/family inside one `3`-card level-up roll while enough alternatives exist.
- This is presentation/pool clarity only; upgrade values and gameplay math are unchanged.

Manual test checklist:

- Start Game and trigger an XP level-up.
- Confirm each card says what it affects and what it grants.
- Move selection across cards and confirm matching equipped weapon rows highlight when applicable.
- Confirm new weapon and non-equipped-family cards are labeled clearly.
- Confirm global cards still update the left stat stack after selection.
- Confirm weapon-specific cards still update and flash the right weapon row after selection.
- Confirm all `8` right-side weapon rows remain visible without scrolling.

## Phase 38 Hotfix 10 — Equipped Weapons vs Run Weapons Explanation

Scope:

- Player-facing clarity for `NEW RUN WEAPON` cards.
- Runtime audit of run-only Fractal Shard activation.
- How To Play explanation update.
- Compact run-bonus HUD indicator below the right-side equipped weapon stack.
- No weapon damage, cooldown, projectile count, loadout cap, Armory, Forge, Evolution/Fusion, Neon Dust, save format, arena, or Phase 37 ripple balance was changed.

Current audited behavior:

- `NEW RUN WEAPON` applies to Fractal Shard upgrade cards while Fractal Shard is not equipped from the Armory/loadout.
- Selecting the card enables Fractal Shard for the current run and lowers its timer so it starts firing automatically shortly after selection.
- It does not append to or replace `_equipped_weapon_instances`.
- It does not use the generated weapon loot decision console and does not require Armory equipment.
- It is run-only because the run-bonus state is not saved to weapon inventory.
- Existing generated weapon rewards remain separate: they can still equip into an open slot, replace a loadout slot, go to stash, or be scrapped through the existing reward console.
- The right-side `GameplayLoadoutEightSlotColumn` remains the fixed `8` equipped Armory/loadout slots.

Hotfix 10 mechanic correction:

- The run-only state is now tracked separately from equipped weapon state through `_run_bonus_weapon_definitions`.
- `_rebuild_weapon_stat_bonuses()` now refreshes runtime activation from equipped weapons plus run-bonus weapons, so a later weapon-stat rebuild cannot silently turn off a selected run-only Fractal Shard.
- The final intended mechanic is: equipped loadout weapons are the persistent starting arsenal; `NEW RUN WEAPON` cards add a temporary current-run weapon; the run weapon starts firing immediately; it does not replace one of the `8` equipped weapons.

Reward card wording:

- New run weapon cards no longer use the ambiguous `AFFECTS: NEW RUN WEAPON` style.
- They now use compact explicit text:
  - `TYPE: NEW RUN WEAPON`
  - `ADDS: FRACTAL SHARD`
  - `STARTS FIRING NOW`
  - `RUN ONLY - DOES NOT REPLACE LOADOUT`
  - one concise stat line such as `SPLITS: 5 -> 7`, `DAMAGE: +18%`, or `COOLDOWN: -14%`
- If Fractal Shard is already active as a run-bonus weapon, later Fractal cards identify as `RUN WEAPON BUFF` / `AFFECTS: RUN BONUS - FRACTAL SHARD` instead of pretending to add a new weapon again.

How To Play update:

- `WEAPON SYSTEMS` now states that up to `8` equipped weapons are chosen from Armory, persist with the loadout, and appear in the right-side HUD.
- A new `EQUIPPED VS RUN WEAPONS` page explains:
  - equipped loadout weapons are the starting loadout,
  - run weapons come from boss/mini-boss/Warden rewards during a run,
  - `NEW RUN WEAPON` starts firing immediately,
  - run weapons do not need Armory equip,
  - run weapons do not replace one of the `8` equipped weapons,
  - run weapons are run-only unless a separate loot/save reward stores them elsewhere.
- `SECTOR REWARDS` now calls out that some boss rewards can add temporary run weapons.

HUD indicator decision:

- Added `GameplayRunBonusWeaponsPanel` directly below the right-side equipped weapon stack.
- It is hidden by default and only appears when a run-only weapon is active.
- Current display format:
  - `RUN BONUS WEAPONS`
  - `FRACTAL SHARD`
- No scrolling was added.
- The existing `8` equipped weapon slots stay visible and unchanged.

Manual test checklist:

- Start Game with Fractal Shard not equipped.
- Trigger or force a Fractal Shard `NEW RUN WEAPON` card.
- Confirm the card says `TYPE: NEW RUN WEAPON`, `STARTS FIRING NOW`, `RUN ONLY`, and `DOES NOT REPLACE LOADOUT`.
- Select it and confirm Fractal Shard starts firing automatically.
- Confirm the right-side equipped HUD still shows the same `8` equipped loadout slots.
- Confirm `RUN BONUS WEAPONS / FRACTAL SHARD` appears below the right stack.
- Take another reward that rebuilds weapon stats and confirm Fractal Shard remains active for the run.
- Return to title/restart and confirm the run-only weapon is not added to the saved loadout unless another existing loot/save route stores it.

Validation run:

- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed.
- `godot --headless --path . --script /tmp/neon_swarm_phase38_hotfix10_validation.gd`: passed with `PHASE38_HOTFIX10_RUN_WEAPON_CLARITY_PASS`.
- Focused validation confirmed card text, How To Play text, run-bonus activation, weapon-stat rebuild persistence, `8` equipped HUD rows, no gameplay HUD scroll container, generated reward flow initialization, and no save compatibility break.
