# Neon Swarm UI Dynamic Weapon Menu Layout Hotfix Report

## 1. What UI Layout Problems Were Found

- Animated weapon previews were larger than the old fixed row layout expected.
- Armory equipped/stash rows placed icon controls over centered button text.
- Stash used a recycled fixed ten-row window instead of a true scrollable inventory list.
- Detail and comparison text could overflow into adjacent menu areas.
- How To Play opened over the title menu without enough modal separation.
- Reward replacement slot rows had large icons but no reserved text lane.

## 2. What Scrolling Systems Were Added

- Armory equipped loadout now sits inside a clipped `ScrollContainer`.
- Inventory / stash now has a full scrollable row list for the `48` stored-weapon cap.
- Armory detail and comparison text areas are clipped scroll regions.
- How To Play tab list, body text, and weapon icon row are scroll containers.
- In-run replacement slot picker now sits inside a clipped scroll container.
- Controller/keyboard focus calls now scroll the selected Armory, Help, and replacement-slot row into view.

## 3. Icon Cell Size / Alignment Changes

- `NeonWeaponIcon` now clips its animated preview inside its cell.
- `NeonMenuButton` supports a left text padding meta value so rows can reserve a fixed icon lane.
- Armory row text was compacted and left-aligned beside the icon lane.
- Reward replacement slot buttons preserve a larger left content margin during selected/unselected style refresh.
- Level-up/generated weapon cards now reserve left padding for the icon cell.

## 4. Armory / Inventory / Stash Layout Changes

- Armory columns now use tighter fixed widths that fit inside the existing command panel.
- EQUIPPED LOADOUT uses consistent `42x42` icon cells inside `56px` rows.
- INVENTORY / STASH now builds one row per stash capacity slot instead of recycling ten rows.
- Empty stash state still displays cleanly.
- Selected rows remain controller-focusable and are scrolled into view.
- Detail and comparison panels now use larger preview icons with scroll-clipped text.

## 5. Reward / Replacement UI Layout Changes

- Generated weapon reward detail and comparison text now use clipped scroll regions.
- Replacement slot picker is now scrollable and only reserves layout space when slot mode is active.
- Replacement slot icon cells are aligned to a fixed left lane.
- Replacement slot text no longer resets into the icon area when focus styling changes.

## 6. How To Play Layout Cleanup

- Added a modal backdrop scrim behind How To Play.
- Help tab list is clipped/scrollable.
- Help body text is clipped/scrollable.
- Help weapon icon row is clipped and horizontally scrollable if future icon count grows.
- Title menu is visually pushed back while How To Play is open.

## 7. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonMenuButton.gd`
- `scripts/ui/NeonWeaponIcon.gd`
- `docs/NEON_SWARM_UI_DYNAMIC_WEAPON_MENU_LAYOUT_HOTFIX_REPORT.md`

Temporary validation script:

- `/tmp/neon_swarm_ui_layout_hotfix_validation.gd`

## 8. Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

The UI smoke script confirmed:

- Armory opens.
- Armory equipped/stash/detail/compare scroll containers exist.
- Equipped row count remains `8`.
- Stash row capacity is `48`.
- Armory selection movement works without crashing.
- How To Play opens.
- How To Play modal scrim appears.
- How To Play tab/body/icon scroll containers exist.
- Help selection movement works without crashing.
- Help and Armory close paths work.

## 9. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 10. What I Should Test Visually

- Open How To Play and confirm the title menu behind it is dimmed/pushed back.
- Open Armory and confirm equipped weapon icons line up cleanly.
- Scroll through inventory/stash and confirm weapon icons/text remain aligned.
- Confirm selected weapon preview and comparison panels do not overlap text.
- Trigger generated weapon reward/replacement UI and confirm replacement slot icons align.
- Confirm controller and keyboard navigation scroll selected rows into view.
- Confirm no menu traps when backing out of Armory, How To Play, and reward replacement.

## 11. Known Issues

- The UI smoke validation is structural/headless; final spacing and visual taste still need manual review in the playable window.
- Scrollbars use Godot `ScrollContainer` behavior. They are functional but may need a later custom neon scrollbar skin if the visible default bar is considered too plain.
- The How To Play icon row is prepared for horizontal overflow, but current pages still use six example icons.

## 12. Approval Question

Do you approve this UI dynamic weapon menu layout hotfix, or should the next work remain a focused UI-only repair pass for visual spacing and menu composition?

## UI Hotfix 2 Follow-Up — Rarity / Modal / Right-Stick Scroll

- Weapon icon cells now include stronger rarity-colored frames, bottom glow strips, and corner rarity badges.
- Armory Equipped and Inventory / Stash rows now include rarity-colored row strips plus rarity corner badges.
- Armory, generated weapon rewards, replacement slots, comparisons, and How To Play examples inherit the stronger rarity badge treatment through the shared weapon icon control.
- How To Play was widened/recentered and now uses a stronger modal scrim so the title menu no longer visually fights the help panel.
- Right-stick scrolling was added for active scrollable Armory, Help, and generated weapon reward/replacement panels.
- UI helper text now advertises `RS SCROLL` where scrollable menus need it.
