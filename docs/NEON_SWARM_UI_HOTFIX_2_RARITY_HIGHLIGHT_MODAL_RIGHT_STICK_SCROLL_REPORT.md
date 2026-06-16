# Neon Swarm UI Hotfix 2 — Rarity Highlight / Modal / Right-Stick Scroll Report

## 1. Rarity Highlight Changes

- Strengthened `NeonWeaponIcon` so every weapon preview now draws a stronger rarity-colored frame, bottom glow strip, and corner rarity badge.
- Added row-level rarity strips and corner rarity badges to `NeonMenuButton` when weapon rows provide rarity metadata.
- Armory equipped rows and Inventory / Stash rows now send rarity color/code metadata into the shared row renderer.
- Reward cards, replacement slot icons, comparison previews, How To Play examples, and generated weapon icons inherit the stronger rarity badge through the shared weapon icon control.
- Rarity remains data-driven from `WeaponCatalog.rarity_accent_hex()` for Common, Uncommon, Rare, Epic, Legendary, and Anomaly.

## 2. Weapon Cell / Icon Visibility Changes

- Equipped Loadout row icon cells increased from `42x42` to `52x52`.
- Inventory / Stash row icon cells increased from `42x42` to `52x52`.
- Armory row height increased to `64` so icons, text, selected state, and rarity badges no longer fight for the same space.
- Generated weapon reward preview increased to `92x92`.
- Reward comparison icons increased to `78x78`.
- Replacement slot icons increased to `58x58`.
- Level-up/generated weapon icon cells increased to `64x64`.

## 3. How To Play Modal Fixes

- How To Play now uses a stronger modal scrim with `0.82` alpha so the title menu no longer visually fights the help panel.
- The How To Play console was widened and recentered to `Rect2(330, 148, 1260, 784)`.
- Help tab buttons are taller and wider with left-aligned text padding.
- Help tab spacing was increased to reduce cramped/doubled-looking labels.
- Help body and weapon example areas were widened.
- How To Play weapon example icons increased to `88x88`.
- The title menu cursor remains hidden while How To Play is open.

## 4. Right-Stick Scrolling Implementation

- Added `_update_right_stick_ui_scroll(delta)` using the existing right-stick aim actions:
  - `aim_left`
  - `aim_right`
  - `aim_up`
  - `aim_down`
- Added active UI scroll routing for:
  - Armory Equipped list
  - Armory Inventory / Stash list
  - Armory detail panel
  - Armory comparison panel
  - Weapon reward detail panel
  - Weapon reward comparison panel
  - Weapon reward replacement slot picker
  - How To Play tab list
  - How To Play body text
  - How To Play horizontal weapon icon row
- Right stick only scrolls while scrollable UI is active, so gameplay aiming is not affected during normal play.
- Vertical stick movement scrolls vertical panels.
- Horizontal stick movement scrolls horizontal panels when horizontal scrolling is enabled.

## 5. Controller Hint Updates

- Armory prompt now includes `RS SCROLL`.
- How To Play prompt now includes `RS SCROLL`.
- Weapon reward decision prompts now include `RS: Scroll` when scrollable detail/slot content is active.

## 6. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonMenuButton.gd`
- `scripts/ui/NeonWeaponIcon.gd`
- `/tmp/neon_swarm_ui_layout_hotfix_validation.gd`
- `docs/NEON_SWARM_UI_HOTFIX_2_RARITY_HIGHLIGHT_MODAL_RIGHT_STICK_SCROLL_REPORT.md`
- `docs/NEON_SWARM_UI_DYNAMIC_WEAPON_MENU_LAYOUT_HOTFIX_REPORT.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`

## 7. Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

The custom UI script confirms:

- Armory opens.
- Equipped Loadout is fixed and does not create/use an Equipped ScrollContainer.
- Stash / Detail / Compare scroll containers exist.
- Equipped list still exposes `8` visible equipped row controls.
- Stash list still exposes `48` stash row controls.
- Equipped rows now include rarity strip metadata.
- Right-stick scroll helper can move right-side detail and stash scroll containers.
- Temporary stash item can enter stash action mode, open scrap confirmation, and scrap back to the original stash size.
- How To Play opens.
- How To Play modal scrim is active and strong enough to separate from title.
- Title menu root is hidden while title Help is open.
- How To Play tab/body/icon scroll containers exist.
- Help body scroll helper runs without errors.
- Armory and Help close paths still work.

## 8. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 9. What I Should Test Visually

- Open Armory and confirm rarity is obvious in Equipped rows.
- Confirm rarity is obvious in Inventory / Stash rows.
- Confirm selected weapon preview and comparison icons show rarity badges.
- Trigger a generated weapon reward and confirm the reward card rarity is immediately visible.
- Open replacement slot picker and confirm rarity/icon cells remain aligned.
- Open How To Play and confirm it reads as one clean modal, not a double overlay.
- Confirm Help tab labels no longer overlap or look doubled.
- Use right stick to scroll Armory, Help body, Help icon row, and replacement slot picker.
- Confirm D-pad / left-stick navigation, A / Enter, and B / Esc still behave normally.

## 10. Known Issues

- Scrollbars still use Godot `ScrollContainer` behavior; a custom neon scrollbar skin remains a future polish task.
- Right-stick scrolling currently scrolls active/readable panels in the current menu context; it does not add a separate focus mode for detail vs comparison panels.
- Headless validation is structural. Final spacing, rarity brightness, and modal composition still need visual review in the playable window.

## Hotfix 2 Repair — Fixed Equipped Layout, Detail Scrolling, Right-Stick Scroll, How To Play Modal, and Stash Scrap

What changed:

- Equipped Loadout no longer uses a scroll container.
- All `8` equipped slots are built as fixed visible rows.
- Armory panel was enlarged to `Rect2(620, 150, 1240, 840)` so the fixed Equipped list, Stash list, right-side detail panels, and action row have breathing room.
- Inventory / Stash remains scrollable and keeps the larger animated weapon icon cells plus rarity strips.
- Right-side weapon detail and comparison text remain in dedicated scroll areas with aligned preview/comparison icons.
- Right-stick scrolling now routes only to the current active scroll target:
  - Stash focus scrolls Stash.
  - Equipped focus scrolls the right-side weapon detail/comparison area.
  - How To Play uses an explicit scroll focus: tabs, body, or icons.
  - Weapon reward replacement mode still routes right stick to reward detail/compare/slot scroll regions.
- How To Play hides the title root while open from the title menu, uses high z-order modal elements, and keeps the title panel from visually fighting the modal.
- How To Play tab labels no longer restore normal Button font color, preventing doubled custom/default text.
- Stash weapons now support a safe Scrap flow:
  - Select a stash weapon.
  - Press A / Enter to open `EQUIP / SWAP`, `SCRAP`, or `CANCEL`.
  - Choose `SCRAP`.
  - Confirm `CONFIRM SCRAP`.
  - Phase 28 supersedes the original score-only reward: the weapon is removed from stash and grants rarity-based Neon Dust.
  - Cancel backs out without deletion.
- Equipped weapons cannot be scrapped through this flow.
- Custom validation temporarily injects a test stash weapon, runs the stash action/scrap confirmation path, and verifies the stash returns to its original size before closing Armory.

Repair validation:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

Manual checks still needed:

- Confirm Equipped shows all `8` slots at once in the playable window.
- Confirm Stash scrolls cleanly with keyboard/controller.
- Confirm right stick scrolls the intended active panel; in Stash, the selection highlight follows the scroll direction.
- Confirm How To Play reads as one clean modal with no doubled tab text.
- Confirm stash Scrap confirmation prevents accidental deletion.

## Right Stick Stash Selection Sync Hotfix

Problem fixed:

- The Inventory / Stash list could scroll with right stick while the selected stash index, selector cursor, detail panel, and comparison panel stayed on the last D-pad-selected weapon.

Implementation:

- Added `_sync_armory_stash_selection_with_right_stick(stick)`.
- When Armory is open, action mode is `browse`, and the active section is `stash`, vertical right-stick input now advances `_armory_stash_selected_index`.
- Right-stick stash movement clamps at the first and last stored weapon instead of wrapping.
- The selected stash item is refreshed through `_update_armory_ui()` so weapon detail and comparison data update immediately.
- `_focus_armory_choice()` keeps the highlighted stash row visible after the selected index changes.
- During the right-stick repeat cooldown, stash scroll input is consumed so the list cannot drift away from the selected row.
- D-pad / left-stick selection still uses the existing `_move_armory_selection()` path and keeps its previous behavior.

Validation update:

- `/tmp/neon_swarm_ui_layout_hotfix_validation.gd` now creates temporary stash weapons, moves selection down and up through `_sync_armory_stash_selection_with_right_stick()`, verifies `_armory_stash_selected_index` changes, and confirms the weapon detail panel updates to the newly selected weapon.
- The script still restores the original stash after testing the scrap path.

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

Manual check:

- Open Armory / Stash.
- Move through stash with D-pad and confirm existing behavior.
- Use right stick down and confirm highlight, detail, and comparison follow the next stash weapon.
- Use right stick up and confirm highlight, detail, and comparison move back.
- Confirm no old highlighted row remains stuck after the list scrolls.

## Right Stick Slow/Fast Scroll Stability Fix

Problem fixed:

- Slow analog movement on the right stick could still feel inconsistent because the first stash sync pass used a simple shared Armory navigation cooldown.

Implementation:

- Added dedicated stash right-stick repeat state:
  - `_armory_stash_rs_repeat_timer`
  - `_armory_stash_rs_last_direction`
- Added analog thresholds:
  - `UI_RIGHT_STICK_STASH_DEADZONE = 0.34`
  - `UI_RIGHT_STICK_STASH_FAST_THRESHOLD = 0.78`
  - `UI_RIGHT_STICK_STASH_SLOW_REPEAT = 0.24`
  - `UI_RIGHT_STICK_STASH_FAST_REPEAT = 0.075`
- Tiny analog movement below the stash deadzone now resets repeat state and does nothing.
- Slight right-stick up/down moves one stash item, then waits for the slow repeat interval.
- Strong right-stick up/down uses the faster repeat interval for faster inventory traversal.
- Releasing the stick resets repeat timing.
- Changing direction resets repeat timing so the opposite direction responds cleanly.
- Selection remains clamped at the first and last stash item.
- Right-stick stash input is consumed while stash is active so raw scroll offset cannot drift away from selected index.

Validation update:

- `/tmp/neon_swarm_ui_layout_hotfix_validation.gd` now verifies:
  - Slow right-stick movement advances one item.
  - Immediate repeated slight movement does not jitter forward again.
  - Releasing resets the repeat state.
  - Opposite-direction movement responds cleanly.
  - Strong held movement can advance faster.
  - First and last stash item boundaries clamp without wrap.
  - Detail text updates to the newly selected stash weapon.

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --quit-after 3000
godot --headless --path . scenes/Main.tscn --quit-after 3
godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd
```

Manual check:

- Slowly push right stick down/up in Inventory / Stash and confirm one-row controlled movement.
- Hold right stick down/up strongly and confirm faster traversal.
- Confirm selection never wraps at the top or bottom.
- Confirm the highlighted row, detail panel, and comparison panel update together every step.

## 11. Approval Question

Do you approve UI Hotfix 2, or should the next work remain a focused UI-only repair pass?
