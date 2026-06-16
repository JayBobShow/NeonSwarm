# Neon Swarm Phase 22 - In-Run Weapon Reward Replacement UI Report

## 1. Executive Summary

Phase 22 finishes the missing in-run generated weapon loot decision flow.

Generated weapon rewards now open a player-facing neon command console before sector progression continues. The player can equip into an open slot, replace an equipped slot, send the weapon to stash, or scrap/skip it for a small score reward.

No new sectors, enemies, bosses, weapons, HUD redesigns, title redesigns, alternate scenes, or hidden playable scenes were created.

## 2. Approved Phase 21 Baseline Preserved

Preserved:

- Official build path: `scenes/Main.tscn`
- Title menu, Armory, Options, Quit
- Pause menu, Return to Title, Quit Game
- Settings save/load, audio, mute, fullscreen, VFX intensity
- HUD, XP, level-up, sector reward flow
- Runtime weapon loadouts and stash backend
- Current sectors, bosses, RUN COMPLETE, death/restart, success/restart
- Keyboard/controller action mapping
- Neon tube edge style and performance caps

## 3. In-Run Weapon Reward Flow

When a generated weapon reward is selected after sector clear:

- The normal reward card hides.
- The in-run weapon reward decision console opens.
- The game remains paused.
- The player chooses a loot route.
- A result message confirms what happened.
- A final confirm continues sector progression.

Routes:

- `EQUIP NOW`
- `REPLACE SLOT`
- `SEND TO STASH`
- `SCRAP / SKIP`

## 4. Equip Now Behavior

`EQUIP NOW` checks for an open equipped weapon slot.

If an open slot exists:

- The generated weapon is equipped.
- Runtime weapon bonuses rebuild immediately.
- Weapon inventory saves.
- Result text confirms the slot used.

If the loadout is full:

- The flow routes to the slot picker instead of silently failing or discarding the reward.

## 5. Replace Slot UI

`REPLACE SLOT` opens a two-column slot picker showing all equipped weapon slots.

Each slot card shows:

- Slot number
- Current weapon name
- Rarity and power summary
- New weapon power comparison
- Compact stat difference hints

Replacement behavior:

- The new reward weapon becomes equipped in the selected slot.
- The old equipped weapon is sent to stash.
- Runtime weapon family activation updates immediately.
- Inventory saves immediately.
- Result text confirms the replacement.

Safety behavior:

- Replacement is blocked if stash is full, because the old equipped weapon cannot be safely stored.

## 6. Send To Stash Behavior

`SEND TO STASH` stores the generated weapon without changing the active loadout.

Behavior:

- Weapon is marked unequipped.
- Weapon is appended to stash.
- Inventory saves.
- Armory can see the stored weapon later.
- Result text confirms the stash action.

If stash is full:

- The action is blocked.
- The player stays in the decision console and can choose another route.

## 7. Scrap/Skip Behavior

`SCRAP / SKIP` rejects the generated weapon.

Current behavior:

- The weapon is not equipped.
- The weapon is not stored.
- Player receives `+500` score.
- Inventory is saved so the generated counter remains clean.
- Result text confirms the weapon was scrapped/skipped.

## 8. Weapon Comparison UI

The reward console shows:

- New weapon rarity, family, archetype, power, primary modifier, and key stat rolls.
- Current equipped slot comparison.
- Rarity change.
- Family change.
- Power delta.
- Damage/rate/cooldown/range and other stat deltas when present.
- Compact arrow hints for better/worse/different comparisons.

The UI uses the approved neon-glass panel language, angular card buttons, rarity accent colors, selected glow, and ship/core cursor.

## 9. Save/Load Behavior

Weapon inventory remains in:

- `user://neon_swarm_weapon_inventory.cfg`

Saved after:

- Equip now
- Replace slot
- Send to stash
- Scrap/skip

Validated:

- Replaced loadout saved.
- Fresh scene instance reloaded the replaced weapon.
- Runtime router enabled the replaced weapon family after reload.
- Stashed reward weapons remained visible to Armory validation.

## 10. Controller/Keyboard Controls

Controls:

- `A / Enter`: select route, confirm slot, continue result
- `B / Esc`: back from slot picker to routes, back from routes to reward card, continue result
- D-pad / arrow keys: navigate route cards and slot cards
- Left/right: route/slot movement
- Up/down: route movement or two-column slot movement

Validation covered action-mapped navigation, slot picker entry, slot movement, and cancel-back behavior. Physical controller hardware should still be checked manually.

## 11. Files Changed

Changed:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_PHASE_22_IN_RUN_WEAPON_REWARD_REPLACEMENT_UI_REPORT.md`

Temporary validation scripts used from `/tmp`:

- `/tmp/neon_swarm_phase22_weapon_reward_flow_validation.gd`
- `/tmp/neon_swarm_phase22_full_flow_validation.gd`
- `/tmp/neon_swarm_phase22_reward_navigation_validation.gd`

No alternate playable scenes or hidden test scenes were created.

## 12. Validation Results

Required validation:

- PASS: `godot --headless --path . --quit-after 3`
- PASS: `godot --headless --path . --quit-after 3000`
- PASS: `godot --headless --path . scenes/Main.tscn --quit-after 3`

Phase 22 validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase22_weapon_reward_flow_validation.gd`
- Output: `PHASE22_REWARD_FLOW_PASS equip_now=true replace=true stash=true scrap=true reloaded=true`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase22_full_flow_validation.gd`
- Output: `PHASE22_FULL_FLOW_PASS weapon_rewards=3 equipped=8 stash=5 run_success=true`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase22_reward_navigation_validation.gd`
- Output: `PHASE22_REWARD_NAV_PASS action_nav=true slot_nav=true cancel_back=true`

Regression validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase20_armory_validation.gd`
- Output: `PHASE20_ARMORY_PASS equipped_rows=8 stash_rows=10 restored_stash=2`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_pause_menu_hotfix_validation.gd`
- Output: `PHASE19_PAUSE_HOTFIX_PASS pause_buttons=4 options_buttons=8`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase21_loadout_runtime_validation.gd`
- Output: `PHASE21_LOADOUT_PASS active_fractal=true damage=1.12 cooldown=0.86 restored_equipped=8`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_runtime_stress.gd`
- Output: `PHASE19_RUNTIME_STRESS_PASS sector=Null Zone enemies=13/54 player_projectiles=0/36 enemy_projectiles=0/28 bursts=3/18 equipped=8 stash=2`

Note:

- The older Phase 19 full-flow validation is obsolete because it expects a weapon reward confirm to advance the sector immediately. Phase 22 correctly requires confirming the reward result screen before sector progression.

## 13. Exact Run Command

Official editor run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 14. What The User Should Test

Manual test checklist:

- Launch official build.
- Start Game.
- Clear a sector and choose the generated weapon reward.
- Confirm the reward decision console opens.
- Test `EQUIP NOW` if an open slot is available.
- Test `REPLACE SLOT` with a full loadout.
- Confirm old equipped weapon moves to stash.
- Confirm the replacement weapon affects gameplay immediately.
- Test `SEND TO STASH`.
- Confirm Armory sees the stashed weapon after returning to title.
- Test `SCRAP / SKIP`.
- Confirm no accidental discard occurs from one button press.
- Test keyboard and controller navigation.
- Confirm Options, pause menu, Return to Title, XP, level-up, all sectors, RUN COMPLETE, death/restart, and success/restart still work.

## 15. Known Issues

- Stash-full replacement is blocked instead of offering an overflow/discard-old flow. This prevents item loss but should get a better player-facing overflow option later.
- Dedicated manual unequip is still not implemented.
- Sorting, filtering, favorite/lock, salvage/sell, and advanced comparison UI remain future Armory work.
- Physical controller hardware still needs manual confirmation outside headless validation.

## 16. Approval Question

Phase 22 is complete for in-run weapon reward replacement UI and loot decision flow. Approve Phase 22?
