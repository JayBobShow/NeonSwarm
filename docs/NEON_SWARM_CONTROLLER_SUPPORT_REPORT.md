# Neon Swarm Controller Support Report

## 1. Executive Summary

This pass adds full Xbox-style controller support for the existing Neon Swarm Phase 1 prototype without expanding gameplay, weapons, enemies, or visual identity. Input is now centralized through explicit Godot input actions, player movement uses deadzoned action vectors, the level-up screen is controller navigable, and Start toggles a simple pause state.

## 2. Controller Controls

- Left stick: move
- D-pad: move and navigate level-up choices
- Right stick: optional Pulse Blaster aim override
- A: confirm selected level-up upgrade
- B: mapped to cancel, but no current gameplay menu has a valid cancel action
- Start: pause/unpause during normal gameplay
- No fire button is required during normal gameplay

## 3. Keyboard Controls

- WASD or arrow keys: move
- IJKL: optional Pulse Blaster aim override
- Enter, numpad Enter, or Space: confirm selected level-up upgrade
- P or Escape: pause/unpause during normal gameplay
- Escape or Backspace: mapped to cancel, but level-up choices cannot be canceled
- Mouse: still works for clicking level-up upgrade buttons

## 4. Input Actions Added/Changed

Input actions are configured at startup in `scripts/InputMapConfig.gd`:

- `move_left`
- `move_right`
- `move_up`
- `move_down`
- `aim_left`
- `aim_right`
- `aim_up`
- `aim_down`
- `confirm`
- `cancel`
- `pause`

Movement uses a `0.24` deadzone. Optional aiming uses a `0.28` deadzone. `nova_burst` was not added because Nova Burst remains automatic.

## 5. Level-Up Menu Controller Support

The level-up menu now tracks a selected upgrade index. Left stick, D-pad, WASD, and arrow-key movement can change the selected upgrade. A, Enter, numpad Enter, or Space confirms it. The focused upgrade button uses the existing highlighted focus style, and the level-up prompt includes controller-friendly text.

B/cancel does not close the level-up screen because picking an upgrade is required to resume gameplay.

## 6. Nova/Weapon Control Behavior

Pulse Blaster still auto-targets the nearest enemy when no aim input is active. If the player holds the right stick, Pulse Blaster fires in that direction instead. Orbit Spark and Nova Burst remain automatic. No trigger or fire button is needed for normal play.

## 7. Files Changed

- `scripts/InputMapConfig.gd`
- `scripts/Main.gd`
- `scripts/Player.gd`
- `scripts/WeaponController.gd`
- `scripts/UpgradeSystem.gd`
- `scripts/HUD.gd`
- `docs/NEON_SWARM_CONTROLLER_SUPPORT_REPORT.md`

## 8. QA Results

Passed:

- Godot startup validation with no parser/runtime errors
- Extended headless scene smoke pass
- Temporary controller smoke test verified required input actions exist
- Temporary controller smoke test verified left stick and D-pad movement mappings
- Temporary controller smoke test verified A confirm, B cancel mapping, and Start pause mapping
- Temporary controller smoke test verified movement returns to zero without input
- Temporary controller smoke test verified optional aim action works
- Temporary controller smoke test verified Start pauses and unpauses
- Temporary controller smoke test verified D-pad changes level-up selection
- Temporary controller smoke test verified A confirms a selected upgrade

Commands run:

```bash
godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd
godot --headless --path . --quit-after 3000
```

## 9. How I Should Test It

1. Open the project in Godot 4.6.3.
2. Connect an Xbox-style controller.
3. Start the main scene.
4. Move with the left stick.
5. Move with the D-pad.
6. Press Start to pause, then Start again to resume.
7. Survive until a level-up appears.
8. Use D-pad or left stick to change the selected upgrade.
9. Press A to confirm the upgrade.
10. During combat, hold the right stick to aim Pulse Blaster manually, then release it to return to nearest-enemy auto-targeting.

## 10. Known Issues

- Controller hot-plug prompts are not dynamic; the level-up prompt always shows controller-friendly text.
- B is mapped but has no active cancel behavior because the current level-up screen must be resolved by choosing an upgrade.
- Nova Burst is automatic, so RT is intentionally unused in this pass.

## 11. Pause Fix / True Pause Validation

### 1. What Was Broken

The pause overlay appeared, but gameplay kept running. `Main` used `PROCESS_MODE_ALWAYS` so it could receive pause/unpause input while paused, but gameplay descendants were inheriting that always-active mode. As a result, enemies, attacks, spawners, weapons, and pickups could continue updating behind the pause text.

### 2. What Files Changed

- `scripts/Main.gd`
- `scripts/Player.gd`
- `docs/NEON_SWARM_CONTROLLER_SUPPORT_REPORT.md`

### 3. How Pause Is Implemented

Manual pause still uses `get_tree().paused = true` and unpause uses `get_tree().paused = false`. `Main` remains `PROCESS_MODE_ALWAYS` so Start/P/Esc can resume the game while paused. HUD and level-up UI also remain always-active. Gameplay branches are explicitly set to `PROCESS_MODE_PAUSABLE`:

- `World`
- `World/Enemies`
- `World/Projectiles`
- `World/Pickups`
- `EnemySpawner`
- `ParticleFX`

`Player.take_damage()` also rejects damage while the tree is paused as a defensive guard.

### 4. How Level-Up Pause And Manual Pause Interact

Manual pause shows the pause panel and resumes only through Start/P/Esc. Level-up pause hides the manual pause panel, pauses the tree, shows the level-up choices, and resumes only after an upgrade is confirmed. Pause input is ignored while the level-up screen is visible, so manual pause cannot accidentally close or override the upgrade flow.

### 5. QA Results

Passed:

- Start button pauses and enemies freeze
- P pauses and enemies freeze
- Esc pauses and enemies freeze
- Start/P/Esc resumes gameplay
- Player does not take damage while paused
- Survival timer does not advance while paused
- Enemy spawner does not add enemies while paused
- Pulse Blaster and Nova timers stop while paused
- XP orbs stop moving while paused
- Pause overlay remains visible while gameplay is paused
- Level-up screen still works while the tree is paused
- Controller upgrade selection still works during level-up pause
- A confirms a level-up upgrade during level-up pause
- Keyboard and controller smoke tests still pass after resume
- Extended gameplay smoke pass still runs cleanly

Commands run:

```bash
godot --headless --path . --script /tmp/neon_swarm_true_pause_smoke.gd
godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd
godot --headless --path . --quit-after 3000
godot --headless --path . --quit-after 3
```

### 6. How I Should Test It Manually

1. Start the game with keyboard or an Xbox-style controller.
2. Let enemies approach.
3. Press Start, P, or Esc.
4. Confirm enemies, projectiles, pickups, weapon effects, and the survival timer stop.
5. Let an enemy overlap the player while paused and confirm health does not drop.
6. Press Start, P, or Esc again and confirm gameplay resumes.
7. Level up, navigate choices with D-pad or left stick, and confirm with A.
8. Confirm level-up pause resumes only after choosing an upgrade.
