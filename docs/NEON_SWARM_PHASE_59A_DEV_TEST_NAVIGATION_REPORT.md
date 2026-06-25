# Neon Swarm Phase 59A - Dev Test Navigation Report

## Scope

Phase 59A adds a narrow, script-only, debug/dev-only testing navigation layer so
late-sector and Hollow Warden QA no longer requires a full playthrough.

Changed files:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_59A_DEV_TEST_NAVIGATION_REPORT.md`

No scenes, project settings, art assets, Blender files, GLB files, gameplay
balance, enemies, weapons, hazards, bosses, rewards, XP, save schema, Armory
behavior, Sector 5 runtime, or alternate scenes were changed.

## Official Build

Official scene:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

The official playable scene remains `scenes/Main.tscn`.

`project.godot` remains expected to launch `res://scenes/Main.tscn`.

No alternate playable scene was created.

## Godot Documentation Consulted

- Official Godot `OS` documentation for `OS.is_debug_build()`.
- Official Godot input event documentation for key event handling.
- Official Godot `InputEventWithModifiers` documentation for shifted key input.

`OS.is_debug_build()` is used as the hard gate so the dev navigation path is
available only in editor/debug builds and remains unavailable in release
exports.

## Exact Controls Added

All controls require:

1. `OS.is_debug_build()` to return `true`.
2. Dev test mode toggled on with `F6`.
3. Existing gameplay-safe input state from `_run_event_test_input_allowed()`.

Controls:

| Key | Behavior |
| --- | --- |
| `F6` | Toggle dev test mode. |
| `F1` | Jump to active Sector 1. |
| `F2` | Jump to active Sector 2. |
| `F3` | Jump to active Sector 3. |
| `F4` | Jump to active Sector 4. |
| `F7` | Keep existing run-event test type cycle. |
| `F8` | Keep existing selected run-event spawn. |
| `F9` | Keep existing run-event clear. |
| `F10` | Jump to Hollow Warden test by entering Sector 4 and then the existing boss-gate flow. |
| `F11` | Keep existing campaign-node advance. |
| `Shift+F11` | Enter the current active sector boss gate through the existing boss-gate flow. |
| `F12` | Reset the current run through the existing `_restart_run()` / official scene reload flow. |

The existing debug label was updated to show the dev test mode state and the new
QA navigation shortcuts.

## Debug And Dev Gating

Implementation guard:

- `_handle_run_event_test_input()` returns immediately unless
  `_dev_test_navigation_available()` is true.
- `_dev_test_navigation_available()` returns `OS.is_debug_build()`.
- The debug label remains hidden unless the debug build gate, the `F6` toggle,
  and existing gameplay-safe input conditions all pass.

Release behavior was reviewed by code inspection: release exports should not
enter the dev navigation handler because `OS.is_debug_build()` is expected to be
false in release export templates.

## Active-Sector Allowlist

The new allowlist is explicit:

```gdscript
const DEV_TEST_ACTIVE_SECTOR_INDICES := [0, 1, 2, 3]
```

Allowed debug jumps are additionally guarded by:

- `index >= 0`
- `index < SECTOR_COUNT`
- `index < ContentCatalog.sector_count()`
- `index < CAMPAIGN_ACTIVE_SECTOR_DATA.size()`

This preserves:

- `SECTOR_COUNT = 4`
- `ContentCatalog.sector_count() = 4`
- Active campaign limited to Sectors 1-4

## Blocked Sector 5 Behavior

No Sector 5 debug control was added.

Sector 5 remains blocked:

- No Sector 5 title/card/entry/debug jump/gameplay.
- No Prism Shards V/VI runtime unlock.
- No Crown Shard runtime behavior.
- No Null King runtime behavior.
- No Sector 5 runtime activation.

The focused validation rejected a Sector 5 jump request and left the active
sector unchanged.

## Boss Gate Behavior

`Shift+F11` and `F10` use existing campaign boss-gate helpers.

They do not directly spawn bosses.

Validation confirmed:

- Current-sector boss-gate jump enters `_campaign_is_boss_step`.
- The boss is not spawned immediately.
- Hollow Warden test enters Sector 4, enters the boss gate, and keeps normal
  boss-gate timing.
- Hollow Warden defeat still completes the run.
- Memory Shard IV remains the Hollow Warden shard.

## Save And Armory Safety

The dev navigation implementation does not:

- Call `_save_weapon_inventory()`.
- Change equipped weapons.
- Change stash.
- Change scrap behavior.
- Change Forge behavior.
- Change reward routing.
- Change save schema.
- Grant permanent weapons.
- Grant persistent progression.

Focused validation used isolated temporary user data:

```bash
XDG_DATA_HOME=/tmp/neon_swarm_phase59a_xdg
```

The isolated temporary user-data directory and temporary validation script were
removed afterward.

Normal save and Armory data were not used by the focused validation.

## Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
```

Passed:

```bash
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
```

Passed focused isolated validation:

```bash
env XDG_DATA_HOME=/tmp/neon_swarm_phase59a_xdg timeout 80s godot --headless --path . --script /tmp/neon_swarm_phase59a_dev_nav_validation.gd
```

Focused validation confirmed:

- Official `Main.tscn` loaded.
- Dev navigation gate matched `OS.is_debug_build()`.
- `ContentCatalog.sector_count()` remained `4`.
- Sectors 1-4 were allowed.
- Sector 5 was blocked.
- F1-F4 style sector jumps reached only Sectors 1-4.
- Sector jumps entered normal subsector flow.
- Sector jumps did not spawn bosses directly.
- Sector 5 jump request was rejected.
- Shift+F11 style boss-gate jump kept the current active sector.
- Shift+F11 style boss-gate jump entered the campaign boss step.
- Shift+F11 style boss-gate jump did not spawn the boss directly.
- F10 style Hollow Warden test entered Sector 4.
- F10 style Hollow Warden test entered the boss gate.
- F10 style Hollow Warden test used gate timing and did not directly spawn the boss.
- Entering the Hollow Warden test gate did not queue a Memory Shard.
- Hollow Warden defeat still ended the run.
- Memory Shard IV remained `prism_shard_4_living_lock`.
- Future shards and future story items stayed absent from the runtime queue.

## Confirmed Unchanged

Confirmed unchanged by code review and git diff:

- Normal player progression.
- Release/player behavior path, except hidden debug/test input is now hard
  gated away from release by `OS.is_debug_build()`.
- `SECTOR_COUNT = 4`.
- `ContentCatalog.sector_count() = 4`.
- Sector 5 lock.
- Prism Shards V/VI.
- Crown Shard.
- Null King.
- Memory Shard normal unlock behavior.
- Save schema.
- Armory and Forge inventory data paths.
- Rewards.
- XP.
- Enemies.
- Weapons.
- Hazards.
- Boss behavior.
- Sector 4 pressure.
- `scenes/Main.tscn`.
- `project.godot`.
- Art, Blender, and GLB files.
- Alternate scenes.

## Remaining Limitations

- The release-export gate was verified by code review and official Godot API
  behavior, not by producing a release export in this phase.
- F12 reset was scoped to the existing `_restart_run()` path and was not
  expanded into a new reset system.
- No temporary XP, level, or weapon grant was added. That remains intentionally
  deferred because it could become save-adjacent or balance-adjacent.
- This pass does not solve the 4A `54/54` enemy headroom caveat. The caveat
  remains active and documented.

## Recommended Next Step

Use Phase 59A dev navigation for manual QA of late-sector and Hollow Warden
flows.

The safest next production step is a review-only pass using the new dev
navigation controls to validate Hollow Warden, boss gates, and late Sector 4 QA
speed. Do not add temporary weapon/XP grants unless repeated manual QA proves
they are needed and a separate save-safe plan is approved.
