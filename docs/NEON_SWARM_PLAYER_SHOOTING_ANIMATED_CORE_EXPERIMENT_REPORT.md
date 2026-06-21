# Neon Swarm Player Shooting Animated Core Experiment Report

Date: 2026-06-21

## Scope

This pass integrates the user-provided player GLB as a safe optional visual experiment in the official Neon Swarm project:

- Project: `/home/jason/GodotProjects/NeonSwarm`
- Official scene: `scenes/Main.tscn`
- Asset used: `art/player/exported/3d/player_core_user_replacement_pre_orientation_hotfix_shooting_animated.glb`
- Approved fallback asset: `art/player/exported/3d/player_core.glb`

No Sector 3 work was started. No Phase 50 sector work was started. Gameplay movement, collision, hurtboxes, weapon balance, HUD, Lyra, Memory Shards, boss cards, campaign progression, Sector 1 arenas, and Sector 2 arenas were not redesigned.

## GLB Inspection

Runtime inspection through `GLTFDocument` found:

- Mesh count: `1`
- Material count: `1`
- Node count: `5`
- Skeleton present: yes, one `Skeleton3D`
- Skin present: yes, one skinned mesh
- Animation count: `1`
- Animation names: `shooting_arm_loop`
- Animation length: approximately `2.0417` seconds
- Animation loop mode: enabled
- Animation tracks: `4` bone transform tracks
- Animated bones: `Left_UpperArm`, `Left_Forearm`, `Right_UpperArm`, `Right_Forearm`
- Skeleton bones: `Body_Root`, `Left_UpperArm`, `Left_Forearm`, `Right_UpperArm`, `Right_Forearm`

Approximate raw bounds:

- Min: `(-0.9489, 0.0000, -0.5466)`
- Max: `(0.9498, 1.1401, 0.5385)`
- Size: `(1.8987, 1.1401, 1.0852)`
- Center: `(0.0004, 0.5701, -0.0041)`

The model appears upright in Godot coordinates with height on `Y`. In gameplay validation, the animated GLB needed a `180` degree yaw correction to match the current player aim-facing convention.

## Animation Reality

The GLB contains real usable animation tracks. The `shooting_arm_loop` clip has four keyed bone transform tracks with `63` keys per track. It is not an empty placeholder.

There is no separate idle or default animation in this GLB.

## Runtime Integration

The experiment is controlled by:

```gdscript
PLAYER_SHOOTING_ANIMATED_CORE_EXPERIMENT_ENABLED = true
```

When true, the player visual uses:

```gdscript
art/player/exported/3d/player_core_user_replacement_pre_orientation_hotfix_shooting_animated.glb
```

When false, the approved fallback remains:

```gdscript
art/player/exported/3d/player_core.glb
```

The imported `AnimationPlayer` is discovered under the generated GLB scene. Available animation names are recorded at runtime. The best shooting animation is selected by matching shooting/fire/attack-style names and checking for real keyed tracks.

Weapon fire events call a visual-only trigger. If `shooting_arm_loop` is already playing, the trigger extends the hold timer and does not restart the clip, avoiding per-frame or spread-shot jitter. With no idle animation available, the player returns to the first pose of the shooting clip after the firing hold expires.

The orientation hotfix keeps the animated GLB root upright and uses a forearm-only `Skeleton3D` pose override while the shooting clip is active. The imported forearm mesh length follows each forearm bone's local `+Y` axis, so the runtime correction aligns that axis to the current aim direction projected onto the arena plane. This fixes the downward shooting pose without changing movement, collision, weapon fire, or the approved fallback player asset.

## Tuning Values

Current experiment tuning:

- `PLAYER_SHOOTING_ANIMATED_CORE_SCALE`: `PLAYER_CORE_VISUAL_SCALE` (`1.18 * 1.375 = 1.6225`)
- `PLAYER_SHOOTING_ANIMATED_CORE_YAW_DEGREES`: `180.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_PITCH_DEGREES`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ROLL_DEGREES`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_Y_OFFSET`: `0.05`
- `PLAYER_SHOOTING_ANIMATED_CORE_Z_OFFSET`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_MIN_PLAY_SECONDS`: `0.35`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_POSE_CORRECTION_ENABLED`: `true`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_POSE_OVERRIDE_AMOUNT`: `1.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_POSE_BONES`: `["Left_Forearm", "Right_Forearm"]`

The selected clip length is approximately `2.0417` seconds, so a firing trigger holds the animation for that full clip length unless further shots extend it.

## Focused Validation

Temporary runtime validation confirmed:

- Player gameplay area exists at `(0.000, 1.050, 0.000)`.
- Active visual child is `Blender3DPlayerShootingAnimatedCoreExperiment`.
- Player core local position is `(0.000, 0.050, 0.000)`.
- Player core scale is `(1.622, 1.622, 1.622)`.
- Player core rotation starts at `(0.000, 180.000, 0.000)` degrees.
- Player collision sphere radius remains `0.720`.
- Animation player exists.
- Runtime animation names are `["shooting_arm_loop"]`.
- Selected shooting animation is `shooting_arm_loop`.
- No idle animation was found.
- Re-triggering while the shooting clip is already playing preserved the current animation position at `0.500`, confirming no restart jitter.
- Aim-facing right updates player core yaw to approximately `89.6` degrees with the yaw correction applied.
- Aim-facing preserves local position and scale.
- Gameplay-view screenshot validation showed the body no longer using the backward/pitched setup and the forearms lifted out of the floor into a forward firing pose.
- Runtime bone-axis validation for aim `(0, 0, -1)` reported both forearm `+Y` axes at approximately `(0, 0, -1)`, `dot_aim=1.000`, `vertical=0.000`.
- Runtime bone-axis validation for aim `(1, 0, 0)` reported both forearm `+Y` axes at approximately `(1, 0, 0)`, `dot_aim=1.000`, `vertical=0.000`.
- Runtime movement sanity check moved the player on `move_right` by `0.653` world units.
- Runtime weapon sanity check produced `9` player projectiles after the run started.
- Runtime campaign sanity check reported `campaign_node_elapsed=1.280`, `title_menu_active=false`, and `sector_name=Neon Grid`.
- Collision, HUD, Lyra, Memory Shards, boss cards, reward panels, Sector 1 arenas, and Sector 2 arenas were not changed by the hotfix.

## Remaining Improvements

- Add a separate idle/default clip if a future player GLB includes one.
- Tune the shooting arm pose further if the gameplay camera shows the arms competing with enemies, XP, bullets, Lyra, boss cards, reward panels, HUD, or Memory Shards.
- If future GLBs use a different forward axis, adjust only the named yaw/pitch/roll/offset constants rather than hardcoding orientation values.
