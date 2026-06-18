# Neon Swarm Stash / Armory Plan

## 1. Current Phase 27 Status

Phase 27 keeps the Phase 20 Armory/Stash UI, Phase 21 runtime loadout foundation, Phase 22 in-run weapon reward decision flow, Phase 23 active weapon catalog, Phase 24 player education, Phase 25 icon pipeline, and upgrades weapon-family icons through the Blender 3D repair pipeline where practical.

Implemented:

- Equipped weapon instance data.
- Stash weapon instance data.
- Discovered weapon family list.
- Separate weapon save file.
- Generated weapon rewards can be sent to stash when they cannot be equipped or replace an existing family.
- Title menu `ARMORY` entry.
- Armory screen with equipped weapon rows.
- Stash screen rows with empty-state handling.
- Selected weapon detail panel.
- Stash-vs-equipped comparison panel.
- Cross-family equip/swap action into the selected equipped slot.
- Runtime weapon family activation from equipped weapon instances.
- Previous equipped weapon returns to stash during Armory swaps.
- In-run weapon reward action console.
- In-run replacement slot picker.
- In-run send-to-stash and scrap/skip handling.
- Phase 23 weapon content pack displays in reward cards, replacement UI, Armory, and stash.
- Armory help text explains equipped versus stash behavior.
- How To Play explains automatic weapons, generated weapon rewards, and loadout effects.
- Reward screen helper text explains equip, replace, stash, and scrap routes.
- Blender-rendered family icons display through the existing `NeonWeaponIcon` control in Armory, stash rows, weapon details, comparison panels, replacement UI, reward cards, and How To Play where those controls are used.
- Phase 27 Repair 2 regenerates those family icons from the actual Blender weapon models where practical, instead of relying on the rejected flat placeholder gameplay-art pass.
- Phase 27 Repair 3 animates those same Blender-derived icons with subtle spin, pulse, and energy arcs through `NeonWeaponIcon`.
- Save after equip/swap changes.
- Keyboard/controller-style navigation.

Not implemented:

- Dedicated manual unequip.
- Weapon sorting/filtering.
- Sell/salvage/economy.
- Favorite/lock UI.

Reason:

- Phase 21 makes equipped weapon slots drive which weapon families fire during a run.
- Phase 22 lets generated sector weapon rewards make clear player-facing routing decisions before the next sector starts.
- Phase 23 proves the loot system can support many weapon families without adding new UI frameworks.
- Phase 24 explains the system in the actual player-facing menus instead of relying on external docs.
- Advanced stash management remains deferred so the loadout foundation can be validated before adding inventory complexity.

## 2. Current Save Data

Weapon inventory path:

- `user://neon_swarm_weapon_inventory.cfg`

Stored data:

- Schema version.
- Instance counter.
- Equipped weapon instances.
- Stash weapon instances.
- Discovered weapon families.

Settings remain separate:

- `user://neon_swarm_settings.cfg`

## 3. Equipped Weapon Slots

Current equipped slot cap:

- 8

Current baseline equipped families:

- Pulse Blaster
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine
- Prism Lance
- Ring Saw
- Hex Shatter

Generated weapons equipped through the Armory can replace any selected equipped slot and affect gameplay.

Generated sector reward weapons now open an in-run decision console before the next sector starts.

In-run reward actions:

- `EQUIP NOW` fills an open slot.
- `REPLACE SLOT` opens a picker for all equipped slots and sends the old weapon to stash.
- `SEND TO STASH` stores the weapon for Armory use.
- `SCRAP / SKIP` rejects the weapon and grants saved Neon Dust based on rarity.

Armory equip rule:

- A stashed weapon can swap into the currently selected equipped slot, even when its family differs.
- The previous equipped instance is sent back to the same stash position.
- The saved loadout is rebuilt immediately so a new run uses the swapped weapon family.

## 4. Stash Rules

Current stash cap:

- 48 weapon instances

Rules:

- Stashed weapons are saved.
- Stashed weapons do not affect gameplay until equipped.
- Stashed weapons are visible in the Armory UI.
- If stash is full, generated weapon reward cards can report `STASH FULL`.
- In-run replacement is blocked if the stash is full and the old equipped weapon cannot be safely stored.
- In-run send-to-stash is blocked if the stash is full.
- Empty stash displays a clean empty-state row.

## 5. Current Armory UI Features

Current Armory includes:

- Title menu entry.
- Equipped weapon list.
- Stash list with visible windowing through stored weapons.
- Weapon detail panel.
- Weapon comparison panel.
- Cross-family equip/swap action against the selected equipped slot.
- Phase 23 weapon family names, rarities, archetypes, shape identities, stat rolls, and modifiers.
- Compact help hint: equipped weapons are active in run, stash weapons are stored only, and Start Game uses the equipped loadout.
- Controller and keyboard navigation.
- Neon-glass command panel styling.
- No default Godot UI visuals.

## 6. Current In-Run Reward UI Features

Current in-run reward UI includes:

- Neon-glass weapon reward decision console.
- Reward weapon detail panel.
- Compact comparison panel.
- Action row for equip, replace, stash, and scrap/skip.
- Helper copy: equipped weapons auto-fire, stashed weapons can be managed in Armory, and scrap converts weapons into Neon Dust.
- Two-column equipped slot picker showing all current equipped slots.
- Slot-level power/stat comparison hints.
- Result-confirm mode so the player sees what happened before combat resumes.
- Keyboard/controller navigation with Back returning from slot picker to actions.

## 7. Current Phase 27 Icon / Preview Support

Phase 25 added:

- Functional preview icons/shape badges for every active weapon family plus a fallback unknown weapon icon.
- Equipped row icons in the Armory.
- Stash row icons in the Armory.
- Larger selected weapon preview in the detail panel.
- Current-vs-selected icons in comparison panels.
- Generated weapon reward card icons.
- Replacement slot picker icons.
- How To Play weapon example icons.

Phase 27 Repair upgrades:

- Blender weapon icon source renders: `art/weapons/icons/source/rendered_from_3d/*_icon_rendered_from_blender.png`
- UI-ready exported PNG icons: `art/weapons/icons/exported/*_icon_hd.png`
- Blender weapon model sources: `art/weapons/source/blender/*.blend`
- Blender weapon runtime models: `art/weapons/exported/3d/*.glb`
- Fallback icon: `art/weapons/icons/exported/unknown_weapon_icon_hd.png`

Phase 27 Repair 2 confirms:

- Active Armory/stash/reward/comparison/How To Play previews use the exported Blender-rendered icon PNGs where practical.
- Runtime weapon objects use `art/weapons/exported/3d/*.glb`.
- The fallback unknown icon remains for future missing family ids, but it is not a final art solution.

Phase 27 Repair 3 confirms:

- Armory equipped rows, stash rows, selected preview, comparison icons, generated weapon reward cards, replacement slot icons, reward comparison icons, and How To Play weapon examples all inherit animated previews from `NeonWeaponIcon`.
- The animation is UI-only and does not affect weapon runtime behavior, cooldowns, damage, or loadout data.

Current rules:

- Icons represent weapon families, not every generated weapon instance.
- Icons are now Blender-rendered family-level visual symbols where practical. They are still per-family, not per-random-instance.
- The preview source should remain the actual Blender weapon family model whenever possible.
- Current previews animate as family-level mini live previews, not as separate per-instance animations.
- Rarity and random stats remain card/list data around the icon.
- Adding a future family requires a `NeonWeaponIcon.gd` mapping, a matching Blender weapon model if the family is active in gameplay, rendered icon source under `art/weapons/icons/source/rendered_from_3d/`, and UI-ready export under `art/weapons/icons/exported/`.
- Future 200+ weapon scaling should reuse this one-preview-per-family mapping.
- A later final art pass can further upgrade these previews, but the current active UI is no longer using the Phase 25 placeholder-only SVG path when a Phase 27 Repair PNG exists.

## 8. Future Armory UI Requirements

Future Armory should add:

- Dedicated manual unequip.
- Favorite/lock action.
- Sort/filter by rarity, family, power, and equipped state.
- Larger comparison panel with more readable grouped stat deltas.
- Higher-quality final weapon preview art for future families using the same Phase 27 Repair Blender source/export structure.
- More extensive icon glossary pages if the weapon roster grows past the current How To Play examples.
- Explicit slot category rules if the loadout expands beyond flexible weapon-system slots.
- Salvage/sell/economy only if later progression approves it.

## 9. Current Interaction Flow

Armory flow:

1. Player opens Armory from title menu.
2. Equipped slots appear on one side.
3. Stash appears as an angular list.
4. Selecting a weapon opens details and comparison.
5. Confirm on a stash weapon equips it into the selected equipped slot and sends the previous equipped instance to stash.
6. Back returns to title menu without disturbing Start/Options/Quit.

In-run reward flow:

1. Player chooses a generated weapon reward after sector clear.
2. Decision console opens.
3. Player chooses equip now, replace slot, send to stash, or scrap/skip.
4. Replace slot opens all equipped slots with comparison text.

## Phase 29 Update — Weapon Forge In Armory

Phase 29 adds Weapon Forge access inside the existing Armory instead of creating a separate title menu.

Access:

- Select an equipped weapon and press confirm to open `FORGE SELECTED`.
- Select a stash weapon and press confirm to choose `EQUIP / SWAP`, `FORGE SELECTED`, `SCRAP`, or `CANCEL`.
- Forge works on both equipped and stored weapons.

Forge actions:

- `UPGRADE POWER`: spends Neon Dust to raise the selected weapon's permanent Forge power rank.
- `REROLL STATS`: spends Neon Dust to replace the selected weapon's random stat rolls while keeping family and rarity.
- `REROLL MOD`: spends Neon Dust to replace modifier rolls when the selected rarity supports modifiers.

Armory display changes:

- Weapon rows show `F#` when a weapon has Forge power ranks.
- Detail panel shows Forge rank, Forge bonuses, and Neon Dust invested.
- Comparison panel switches to Forge preview text while Forge actions are open.
- Confirm panels show current Neon Dust, action cost, and before/after power/stat preview before spending.

Save/load:

- Forged equipped weapons save in the equipped list.
- Forged stash weapons save in the stash list.
- Neon Dust spent is removed immediately and saved with the updated weapon instance.
- Old save data remains valid because missing Forge fields default to an un-forged weapon.

## Phase 32 Update — Evolve / Fuse In Weapon Forge

Phase 32 adds `EVOLVE / FUSE` to the existing Armory Forge flow.

Access:

- Select an equipped weapon or stored weapon.
- Open `FORGE SELECTED`.
- Choose `EVOLVE / FUSE`.
- Select a compatible material weapon from Inventory / Stash.
- Confirm the final fusion prompt.

Fusion rules:

- Same-family material weapons are compatible.
- Same geometry-group material weapons are compatible.
- Incompatible material weapons are blocked.
- The material must come from stash.
- Fusion consumes the material weapon only after confirmation.
- The primary weapon remains owned and gains one saved evolution rank.

Armory display changes:

- Weapon rows show `EV#` when a weapon has evolution ranks.
- Detail panel shows evolution rank, fusion group, evolution bonuses, and last fusion info.
- Forge comparison text shows primary weapon, selected material, compatibility, cost, and before/after power.
- Confirmation text states that fusion consumes the material weapon.

Save/load:

- Evolved equipped weapons save in the equipped list.
- Evolved stash weapons save in the stash list.
- Consumed material weapons are removed from stash after confirmation and saved immediately.
- Old save data remains valid because missing evolution fields default to rank 0.
5. Confirmed equip/replacement affects the current runtime loadout immediately.
6. Result text confirms the outcome before sector progression resumes.

## 10. Risks

Main risks:

- Too much item text can become unreadable.
- Controller focus can become confusing in dense inventory UI.
- Armory UI can collide visually with title/options composition if expanded too far.
- Weapon replacement can confuse players if comparison is weak.
- Duplicate family loadouts can stack stats, so future balance passes may need stricter slot/category rules.
- Stash-full replacement can frustrate players if no overflow system exists.

Mitigation:

- Keep row/card heights stable.
- Use rarity accents sparingly.
- Show only the most important stat deltas first.
- Keep stat and projectile caps active when duplicate or high-rarity weapons are equipped.
- Block stash-full replacement instead of losing the old equipped weapon.

## UI Hotfix 2 Armory Notes

- Equipped and Inventory / Stash rows now use larger animated weapon icon cells plus stronger rarity row strips.
- Rarity should be readable before the player reads the weapon text: row strip, corner badge, icon frame, and rarity code all reinforce the tier.
- Armory scrollable panels support right-stick scrolling through the shared UI scroll helper.
- The current Armory still uses functional Godot `ScrollContainer` behavior; a custom neon scrollbar skin remains future polish.

## Hotfix 2 Repair — Fixed Equipped Layout, Detail Scrolling, Right-Stick Scroll, How To Play Modal, and Stash Scrap

- Equipped Loadout is fixed and always shows all `8` equipped slots without scrolling.
- Inventory / Stash remains the scrolling list because it can grow to the stash cap.
- Right-side weapon detail and comparison text keep their own scroll areas so long stat/comparison output does not cut off.
- Right-stick scroll now targets the active menu context instead of scrolling the fixed Equipped area.
- How To Play from the title menu hides the title root behind the modal to prevent double-overlay composition.
- Stash item removal now exists as a safe confirmation flow:
  1. Select a stored weapon in Inventory / Stash.
  2. Confirm to open stash actions.
  3. Choose `SCRAP`.
  4. Confirm `SCRAP THIS WEAPON?`.
  5. The weapon is removed from stash and grants Neon Dust based on rarity.
- Equipped weapons are not scrappable through this flow.
- Phase 28 replaces the old score-only scrap reward with saved Neon Dust.

## Phase 28 Neon Dust / Core Upgrade Integration

Current Armory economy behavior:

- Armory displays `NEON DUST: <amount>`.
- Stored weapons can be scrapped only from Inventory / Stash.
- Scrap action requires a confirmation prompt.
- Confirmed scrap removes the stored weapon and saves immediately.
- Equipped weapons are not scrappable from this flow.
- Scrap values are rarity-based:
  - Common: 8
  - Uncommon: 16
  - Rare: 30
  - Epic: 55
  - Legendary: 95
  - Anomaly: 150

Core Upgrades:

- Title menu includes `CORE UPGRADES`.
- Upgrades consume saved Neon Dust and save rank changes immediately.
- Purchases require a second confirm press.
- Current upgrades are Core Vitality, Magnetic Field, Weapon Tuning, and Coolant Flow.
- Start Game uses the saved Core Upgrade ranks with the equipped weapon loadout.

## Phase 38 Hotfix 5 Gameplay Loadout HUD Note

- Equipped loadout capacity remains `8` weapons.
- Armory remains the detailed management UI for equipped/stash replacement, comparison, Forge, Evolution/Fusion, and scrolling stash inventory.
- The in-game combat HUD is not a menu and does not scroll.
- Phase 38 Hotfix 5 changed the combat HUD to represent all `8` equipped weapon slots at once.
- Phase 38 Hotfix 6 replaces that bottom rail with a right-side fixed vertical equipped weapon panel.
- The gameplay weapon panel uses fixed slot rows with weapon icon, slot number, rarity code, and compact weapon name.
- Empty slots render as dim `EMPTY` cells if a save/load state has fewer than `8` equipped weapons.
- Stat telemetry is separate in a left-side vertical stat panel so `DMG`, `RATE`, `SPD`, and pickup radius do not consume weapon slot display space.
- No weapon stats, loadout cap, Forge behavior, Armory save data, or progression rules changed for this HUD fix.
