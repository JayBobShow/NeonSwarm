# Neon Swarm Phase 20 Armory / Stash UI Prototype Report

## 1. Executive Summary

Phase 20 adds the first player-facing Armory/Stash screen to the official Neon Swarm build.

Implemented:

- Title menu `ARMORY` entry.
- Equipped weapon display.
- Stash weapon display.
- Empty stash message.
- Selected weapon detail panel.
- Stash-vs-equipped comparison panel.
- Matching-family equip/swap action.
- Save after equip/swap changes.
- Keyboard/controller-style navigation using the approved neon UI language.

No new weapons, enemies, bosses, sectors, or gameplay balance changes were added.

## 2. Approved Phase 19 Baseline Preserved

Preserved:

- Official scene: `scenes/Main.tscn`
- Start Game.
- Options.
- Quit.
- Pause menu.
- Return to Title.
- Quit Game.
- Settings save/load.
- Audio/mute.
- HUD.
- XP and level-up.
- Sector rewards.
- Generated weapon rewards.
- Stash backend/save data.
- All sectors.
- RUN COMPLETE.
- Death/restart.
- Success/restart.
- Controller/keyboard paths.
- Performance caps.
- Neon tube edge visual style.

## 3. Title Menu Armory Entry

The title menu now has:

- `START GAME`
- `ARMORY`
- `OPTIONS`
- `QUIT`

The title command panel was kept in the approved lower-left composition and adjusted only enough to fit the fourth row. The ship/core cursor remains active for title menu navigation.

## 4. Armory/Stash Screen Features

The Armory opens as a neon-glass command console over the title screen.

It shows:

- Equipped weapon list.
- Stash weapon list.
- Selected weapon details.
- Rarity.
- Weapon family.
- Archetype.
- Shape identity text.
- Power score.
- Main modifier.
- Generated stat rolls.
- Comparison against an equipped weapon.
- Action/status feedback.

The UI uses `NeonFramePanel`, `NeonMenuButton`, rarity accents, compact stat rows, and the existing ship/core cursor language.

## 5. Equipped Weapon Display

The equipped column shows up to 8 equipped weapon slots.

Rows include:

- Slot index.
- Weapon name.
- Rarity shorthand.
- Power score.

Selecting an equipped weapon shows its detail panel and prompts the player to switch to stash for comparison/equip actions.

## 6. Stash Weapon Display

The stash column shows stored weapon instances from the Phase 19 backend.

Features:

- Stash count display.
- Visible list window for stored weapons.
- Rarity-colored row accents.
- Empty-state row:
  - `NO STORED WEAPONS`
- Stash weapons remain inactive until equipped.

## 7. Weapon Comparison Behavior

When a stash weapon is selected, the comparison panel shows:

- Current equipped comparison weapon.
- Selected stashed weapon.
- Power delta.
- Stat deltas for key rolls such as damage, rate, cooldown, range, lifetime, speed, projectile count, pierce, split, chain, and orbit.
- Up/down/even indicators.
- Equip/swap availability.

Matching-family stash weapons compare against their matching equipped family slot. If no matching equipped family exists, the UI compares against the currently selected equipped slot but blocks unsafe cross-family replacement.

## 8. Equip/Swap/Save Behavior

Implemented safe equip behavior:

- Selecting a stashed weapon with a matching equipped family swaps it into that equipped slot.
- The previous equipped instance is sent back to stash.
- Weapon inventory saves after the swap.
- Equipped stat bonuses rebuild immediately.
- Start Game uses the updated equipped weapon data.

Also supported:

- If an equipped slot is available, a stash weapon can equip into that empty slot.

Blocked for safety:

- Arbitrary cross-family replacement while the runtime weapon framework still keeps baseline weapon behaviors enabled separately from equipped slot data.

This avoids lying to the player about removing/replacing a weapon when the gameplay behavior is not fully slot-driven yet.

## 9. Reward Flow Connection

Phase 19 generated weapon rewards remain connected:

- Sector reward weapon cards still appear.
- Generated weapon rewards still show rarity/action/stat text.
- Matching-family rewards can still replace equipped family instances.
- Stash rewards still save into the same stash backend shown by Armory.

No reward balance changes were made.

## 10. Controls

Armory controls:

- Up/Down: select row.
- Left/Right: switch equipped/stash list.
- A / Enter: equip/swap selected stash weapon if safe.
- B / Esc: back to title menu.
- Start: back to title menu, so it does not accidentally launch or break menus.

The Armory uses focusable neon buttons and a ship/core cursor. No default Godot buttons are visible.

## 11. Files Changed

Updated:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_LONG_TERM_RPG_ROGUELITE_EXPANSION_PLAN.md`

Created:

- `docs/NEON_SWARM_PHASE_20_ARMORY_STASH_UI_PROTOTYPE_REPORT.md`

## 12. Validation Results

Required commands:

- PASS: `godot --headless --path . --quit-after 3`
- PASS: `godot --headless --path . --quit-after 3000`
- PASS: `godot --headless --path . scenes/Main.tscn --quit-after 3`

Additional smoke validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase20_armory_validation.gd`
  - Title menu launched.
  - `ARMORY` appeared as the second title option.
  - Armory opened.
  - Equipped rows displayed.
  - Empty stash state displayed.
  - Stash weapon details displayed.
  - Comparison displayed.
  - Matching-family equip/swap worked.
  - Previous equipped copy moved to stash.
  - Swapped equipped weapon reloaded from save.
  - Save data was restored after validation.
  - Armory backed out to title.
  - Start Game worked after Armory.
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_pause_menu_hotfix_validation.gd`
  - Pause menu still works.
  - Pause Options still works.
  - Return to Title still works.
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_weapon_reward_validation.gd`
  - Generated weapon reward flow still works.
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_full_flow_validation.gd`
  - Sector progression and RUN COMPLETE still work.
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_runtime_stress.gd`
  - Runtime caps remained stable.

Manual live-window controller validation is still recommended because headless mode cannot physically verify controller feel.

## 13. Exact Run Command

```sh
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 14. What The User Should Test

Test in the official build:

- Title menu launches.
- `ARMORY` appears between Start Game and Options.
- Armory opens.
- Armory backs out to the title menu.
- Equipped weapons display.
- Stash weapons display.
- Empty stash state displays if stash is empty.
- Selected weapon details are readable.
- Comparison text is understandable.
- Matching-family stash weapon swaps into equipped slot.
- Previous equipped weapon moves to stash.
- Swap persists after closing/reopening or restarting.
- Start Game still works after Armory.
- Options still works.
- Pause menu still works.
- Return to Title still works.
- Generated weapon reward cards still work.
- Full run still reaches RUN COMPLETE.

## 15. Known Issues

- Arbitrary cross-family replacement is intentionally blocked until runtime weapon behavior is fully driven by equipped slots.
- There is no sorting/filtering yet.
- There is no favorite/lock UI yet.
- There is no sell/salvage/economy yet.
- Comparison is readable but compact; a later pass should add stronger grouped stat visuals and family shape icons.
- Armory uses text shape identity instead of rendered weapon family icons for this prototype.

## 16. Approval Question

Is Phase 20 approved as the first Armory/Stash UI prototype, with arbitrary cross-family replacement and deeper inventory features deferred to future approved phases?
