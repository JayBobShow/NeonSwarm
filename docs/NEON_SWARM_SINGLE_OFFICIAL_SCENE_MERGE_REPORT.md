# Neon Swarm Single Official Scene Merge Report

## 1. Executive Summary

Neon Swarm now has one official playable launch scene:

`res://scenes/Main.tscn`

The current real 3D-on-2D gameplay prototype was promoted into `Main.tscn`, and old/prototype root scenes were moved into `scenes/archive_phase2_old/` so they are not accidentally launched as the current build. The official scene now displays a temporary HUD label:

`OFFICIAL 3D NEON SWARM BUILD`

No gameplay balance, weapons, enemy types, bosses, progression, camera behavior, collision rules, or main loop behavior were expanded.

## 2. Which Scene Is Now Official

Official playable scene:

`scenes/Main.tscn`

This scene now represents the current approved playable direction:

TRUE 3D-ON-2D NEON SWARM GAMEPLAY.

## 3. What Was Archived

Archived under:

`scenes/archive_phase2_old/`

Archived scenes:

- `Main_2D_Phase1.tscn`
- `NeonSwarm3DGameplayPrototype_original.tscn`
- `NeonSwarm3DVisualPrototype.tscn`
- `NeonSwarm3DVisualProofBoard.tscn`

Supporting reusable 3D visual asset scenes remain active under `scenes/visuals/` because `Main.tscn` depends on them.

## 4. What Was Promoted/Replaced

Promoted:

- `scenes/NeonSwarm3DGameplayPrototype.tscn`

Replaced:

- old 2D `scenes/Main.tscn`

New official scene:

- `scenes/Main.tscn`

The original 3D prototype scene file was archived after promotion to prevent duplicate active gameplay entry points.

## 5. project.godot Main Scene Confirmation

`project.godot` already points to the correct launch scene:

```ini
run/main_scene="res://scenes/Main.tscn"
```

Pressing F5 in Godot now launches the official 3D Neon Swarm build.

## 6. Files Changed

Changed:

- `scenes/Main.tscn`
- `scripts/NeonSwarm3DGameplayPrototype.gd`

Created:

- `scenes/archive_phase2_old/`
- `docs/NEON_SWARM_SINGLE_OFFICIAL_SCENE_MERGE_REPORT.md`

Moved to archive:

- `scenes/Main.tscn` old 2D version -> `scenes/archive_phase2_old/Main_2D_Phase1.tscn`
- `scenes/NeonSwarm3DGameplayPrototype.tscn` -> `scenes/archive_phase2_old/NeonSwarm3DGameplayPrototype_original.tscn`
- `scenes/NeonSwarm3DVisualPrototype.tscn` -> `scenes/archive_phase2_old/NeonSwarm3DVisualPrototype.tscn`
- `scenes/NeonSwarm3DVisualProofBoard.tscn` -> `scenes/archive_phase2_old/NeonSwarm3DVisualProofBoard.tscn`

## 7. Validation Results

Required launch checks:

- `godot --headless --path . --quit-after 3`
  - Passed.
  - Booted the real 3D gameplay review build.

- `godot --headless --path . --quit-after 3000`
  - Passed.
  - Runtime summary reached `time=12.0`, with enemies, kills, XP, score, and capped bursts active.

- `godot --headless --path . scenes/Main.tscn --quit-after 3`
  - Passed.
  - Explicit `Main.tscn` launch booted the real 3D gameplay review build.

Additional smoke validation:

- `godot --headless --path . --script /tmp/neon_swarm_main_official_smoke.gd`
  - Passed.
  - Confirmed official HUD label.
  - Confirmed keyboard/controller input map bindings.
  - Confirmed true pause freezes survival timer, enemies, and player damage.
  - Confirmed resume works.
  - Confirmed enemies, projectiles, XP collection, kills, and score operate from `Main.tscn`.

Stress/cap validation:

- `godot --headless --path . --script /tmp/neon_swarm_main_official_stress.gd`
  - Passed.
  - Reported `avg_headless_frame_ms=6.827`.
  - Reported `nodes=1725`.
  - Caps remained intact for enemies, XP, projectiles, enemy projectiles, and bursts.

## 8. Exact Command To Run

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 9. How User Should Launch With F5

Open the project in Godot and press F5.

Expected confirmation:

- The game launches `scenes/Main.tscn`.
- The HUD shows `OFFICIAL 3D NEON SWARM BUILD`.
- The scene is the true 3D-on-2D gameplay build, not the old 2D scene or proof board.

## 10. Known Issues

- The active gameplay script is still named `scripts/NeonSwarm3DGameplayPrototype.gd` for continuity, but it now powers the official `Main.tscn` scene.
- Older reports still mention previous prototype scene paths. The current official launch target is now `scenes/Main.tscn`.
- Headless validation confirms controller mappings, but physical controller feel still requires manual hardware testing.
- Archived scenes are preserved for reference and are not the current launch target.

## 11. Approval Question

After launching `scenes/Main.tscn`, is this single official scene merge accepted as the only current playable Neon Swarm build?
