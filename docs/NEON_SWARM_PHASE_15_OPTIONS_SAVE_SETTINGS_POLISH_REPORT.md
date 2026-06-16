# Neon Swarm Phase 15 Options, Save Settings, and Final Run Polish Report

## 1. Executive Summary

Phase 15 turns the approved prototype into a cleaner player-facing build by replacing the title-screen Options placeholder with a real options menu, adding persistent settings, wiring audio volume behavior, and adding practical VFX intensity controls.

All work was done in the official build path:

- `scenes/Main.tscn`
- `scripts/NeonSwarm3DGameplayPrototype.gd`

No new sectors, enemies, bosses, weapons, campaign/story systems, meta progression, alternate playable scenes, hidden test scenes, HUD redesigns, or title-screen redesigns were added.

## 2. Approved Phase 14 Baseline Preserved

Preserved:

- Approved title screen
- Start Game
- Real Options entry
- Quit
- Approved HUD
- Keyboard support
- Controller-style navigation support
- Pause
- Death/restart
- Success/restart
- XP spawn and collection
- Level-up choices
- Sector rewards
- All three sectors
- Triad Splitter
- Hex Pulser
- Fractal Crown
- Fractal Shard
- Final Null Octagon Prime boss
- `RUN COMPLETE`
- Neon tube edge visual style
- Runtime caps and pooling limits

## 3. Options Menu Features

The title-screen Options command now opens a real neon command plate instead of the old placeholder.

Options included:

- Master Volume
- SFX Volume
- Music Volume placeholder
- Mute ON/OFF
- Screen Shake ON/OFF
- VFX Intensity: LOW / NORMAL / HIGH
- Fullscreen ON/OFF
- Back

Control behavior:

- Up/down changes the selected row.
- Left/right adjusts sliders and cycles choices.
- A / Enter / confirm activates the selected row.
- B / Esc / cancel backs out of Options.
- The existing ship/core title cursor moves onto the options rows.
- The panel uses the existing NeonFramePanel and NeonMenuButton visual language.
- No default Godot buttons were introduced.

## Options Menu Hotfix — Centered Composition

1. What was wrong

The first Phase 15 Options panel placement sat too far to the right and too low at `Rect2(720, 500, 760, 496)`. It functioned correctly, but the composition read like a side-pushed panel instead of an intentional title-screen control console.

2. New panel position

The Options panel now uses `Rect2(740, 380, 560, 520)` at the 1920x1080 HUD design size.

Composition notes:

- The Start menu remains on the left at `Rect2(150, 620, 520, 340)`.
- The Options panel now has a measured 70px horizontal gap from the Start menu.
- The Options panel is higher and more centered vertically.
- Option rows were compacted to 490x42 so the final measured panel stays at 560x520.
- The prompt text was shortened to fit the compact modal width cleanly.
- The cover/logo treatment was not blurred or redesigned.

3. Controls retested

Retested and passed:

- Options open/close
- Back
- Start Game
- Quit command path
- Keyboard-style focus
- Controller-style focus
- Up/down navigation
- Left/right option adjustment
- Confirm activation
- Ship/core cursor focus on Options rows

4. Settings retested

Retested and passed:

- Master Volume adjusts
- SFX Volume adjusts
- Music Volume placeholder adjusts
- Mute toggles
- Mute persists after reload
- Screen Shake toggles
- Screen Shake OFF suppresses shake
- VFX Intensity adjusts
- VFX LOW affects burst fragment counts
- Saved settings reload correctly
- Fullscreen row remains present and adjustable

5. Files changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_15_OPTIONS_SAVE_SETTINGS_POLISH_REPORT.md`

Temporary validation only:

- `/tmp/neon_swarm_phase15_options_layout_validation.gd`
- `/tmp/neon_swarm_phase15_options_smoke.gd`

6. What I should review

- Open Options from the official title screen and confirm the panel feels intentionally centered-right, not pushed off to the side.
- Confirm the Options panel does not cover the main logo/cover art in an ugly way on the target display.
- Confirm the 70px gap from the Start menu feels balanced in the live build.
- Confirm the compact option rows still feel readable from normal play distance.
- Confirm controller navigation still feels natural on physical hardware.

## 4. Save Settings Implementation

Settings use a Godot `ConfigFile` saved at:

- `user://neon_swarm_settings.cfg`

Saved settings:

- Master volume
- SFX volume
- Music volume placeholder
- Mute
- Screen shake
- VFX intensity
- Fullscreen

Load/save behavior:

- Settings load during game startup.
- Settings apply immediately when changed.
- Settings save when changed.
- Settings save when leaving Options.
- Settings save when using Quit.
- Missing config files fall back to safe defaults.
- Headless runs skip fullscreen application safely.

## 5. Audio / Volume Behavior

Audio behavior now respects player settings:

- Master Volume controls the Master bus volume.
- SFX Volume is applied to generated SFX playback.
- Mute overrides the Master bus.
- Mute persists across scene reloads.
- Existing SFX cooldowns remain intact.
- Music Volume is stored for future music support, but no music bus or music content was added in this phase.

## 6. VFX Intensity Behavior

VFX Intensity is a practical runtime setting:

- LOW reduces burst spark/shard counts and lowers screen shake strength.
- NORMAL keeps the approved Phase 14 look.
- HIGH slightly increases burst spark/shard counts and shake strength while staying capped.

Safety rules:

- Burst count remains capped by `BURST_CAP`.
- Particle-like burst fragments remain bounded through pooled MultiMesh effects.
- Screen shake OFF fully suppresses new shake and resets active camera shake.
- HIGH mode does not remove caps or create unbounded effects.

## 7. Run Polish Changes

Run polish was kept targeted so the Phase 14 balance was not destabilized.

Polish applied:

- Options flow now returns cleanly to the title menu.
- Selected title/options rows have consistent cursor behavior.
- Screen shake can be disabled for readability.
- VFX LOW improves readability and performance headroom during heavy action.
- VFX HIGH gives slightly stronger burst feedback without changing enemy, boss, or weapon content.
- Audio levels now respond to player settings immediately.

No new content or broad sector rebalance was added. The existing three-sector run, reward flow, Fractal Shard, Triad Splitter, Hex Pulser, Fractal Crown, and final boss flow were validated after the settings work.

## 8. Files Changed

Project files:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_15_OPTIONS_SAVE_SETTINGS_POLISH_REPORT.md`

Temporary validation only:

- `/tmp/neon_swarm_phase15_options_smoke.gd`
- `/tmp/neon_swarm_phase15_runtime_stress.gd`

## 9. Validation Results

Required validation passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`

Additional Phase 15 options smoke passed:

- Official `Main.tscn` loads.
- Title menu launches.
- Start Game works.
- Options opens the real options menu.
- Options exposes all required rows.
- Options has keyboard/controller-style focus.
- Master Volume adjusts.
- SFX Volume adjusts.
- Music Volume placeholder adjusts.
- Mute toggles.
- Screen Shake toggles.
- Screen Shake OFF suppresses shake.
- VFX Intensity adjusts to LOW.
- VFX LOW reduces burst fragments.
- Options Back works.
- Settings save/load after scene reload.
- Mute persists.
- Screen Shake persists.
- VFX Intensity persists.
- Master Volume persists.
- XP and level-up work.
- Pause works.
- Sector 1 clears and opens reward.
- Sector 2 clears through Fractal Crown.
- Sector 3 clears through final Null Octagon Prime.
- `RUN COMPLETE` works.
- Success/restart works.
- Death/restart works.
- Quit command invokes cleanly.

Additional Phase 15 Options layout hotfix validation passed:

- Official `Main.tscn` loads.
- Options panel exists.
- Start menu panel exists.
- Options panel final measured position is `(740, 380)`.
- Options panel final measured size is `(560, 520)`.
- Options panel keeps a measured 70px gap from the Start menu panel.
- Options panel is vertically composed around the screen center.
- All options rows remain present.
- Compact option rows fit the panel width.
- Options focus/cursor starts on the first row.
- Options close/back state remains available.

Additional Phase 15 runtime stress passed:

- VFX HIGH applies before stress.
- Fractal Crown is active under stress.
- Triad Splitter and Hex Pulser load remain stable.
- Fractal Shard is active under stress.
- Enemy cap stayed within 54.
- XP cap stayed within 100.
- Player projectile cap stayed within 36.
- Enemy projectile cap stayed within 28.
- Burst cap stayed within 18.
- Beam cap stayed within 8.
- Mine cap stayed within 6.
- Hazard trail cap stayed within 10.
- Triad Fragment count remained capped.

## 10. Exact Run Command

```sh
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 11. What The User Should Test

- Open Options from the title screen.
- Adjust Master Volume, SFX Volume, and Music Volume placeholder.
- Toggle Mute, leave Options, restart the game, and confirm Mute persists.
- Toggle Screen Shake OFF and confirm gameplay has no shake.
- Test VFX LOW, NORMAL, and HIGH during heavy combat.
- Toggle Fullscreen ON/OFF on the target display.
- Use keyboard and controller navigation in title/options/pause/reward/level-up flows.
- Play from Start Game to `RUN COMPLETE`.
- Confirm Sector 1 remains approachable.
- Confirm Sector 2 pressure and Fractal Crown readability.
- Confirm Sector 3 final push and Null Octagon Prime readability.
- Confirm death/restart and success/restart still work.

## 12. Known Issues

- Music Volume is stored and shown, but remains a placeholder until music is added.
- Fullscreen is skipped during headless validation; it should be manually checked on the target display.
- Headless validation verifies navigation callbacks and focus state, but physical controller feel should still be checked manually.
- Final visual feel for LOW/NORMAL/HIGH VFX should be judged in the playable build, not only headless.

## 13. Approval Question

Is Phase 15 approved as the real Options menu, persistent settings, and final run polish phase for the official `scenes/Main.tscn` build?
