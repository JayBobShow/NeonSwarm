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

The orientation hotfix keeps the animated GLB root upright with the model/root transform values below. The previous forearm-only `Skeleton3D` pose override was tested against the unforced imported animation and is now behind a safety toggle that defaults off. The override can still be re-enabled for debugging, but it is not part of the approved runtime look because it can twist the side-aim arm silhouette.

The arm-level hotfix keeps that forearm-only aim override off and adds a separate local arm-chain pitch correction. The runtime cause of the floor-shooting pose was that the imported shooting pose's forearm forward axis entered gameplay with a strong downward component after the player root aim-facing transform was applied. Runtime capture measured the baseline `Left_Forearm` and `Right_Forearm` forward axes at approximately `Y = -0.740`. The fix does not rotate the player body. The first level pass used a controlled local `-75` degree pitch on the existing animated upper-arm and forearm poses after the clip pose was evaluated, which raised the weapons without replacing the forearm aim basis or reintroducing the prior twist.

The outward-aim hotfix keeps the arms level but retunes that correction so the forearms point forward toward the fire direction instead of remaining side-splayed. The cause was that the level-only correction left a large horizontal side component: the forearm aim dot against the fire direction was only about `0.695` while the arms were visibly spread away from the target line. The final correction uses a shallower arm pitch plus mirrored left/right yaw spread, which keeps vertical pitch near level while moving both forearm axes onto the aim vector.

## Tuning Values

Current experiment tuning:

- `PLAYER_SHOOTING_ANIMATED_CORE_SCALE`: `PLAYER_CORE_VISUAL_SCALE` (`1.18 * 1.375 = 1.6225`)
- `PLAYER_SHOOTING_ANIMATED_CORE_YAW_DEGREES`: `180.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_PITCH_DEGREES`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ROLL_DEGREES`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_Y_OFFSET`: `0.05`
- `PLAYER_SHOOTING_ANIMATED_CORE_Z_OFFSET`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_MIN_PLAY_SECONDS`: `0.35`
- `PLAYER_SHOOTING_ANIMATED_CORE_FOREARM_POSE_CORRECTION_ENABLED`: `false`
- `PLAYER_SHOOTING_ANIMATED_CORE_FOREARM_POSE_OVERRIDE_AMOUNT`: `1.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_FOREARM_POSE_BONES`: `["Left_Forearm", "Right_Forearm"]`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_LEVEL_CORRECTION_ENABLED`: `true`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_PITCH_DEGREES`: `-55.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_YAW_DEGREES`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_SPREAD_DEGREES`: `40.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_LEFT_ARM_YAW_DEGREES`: `40.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_RIGHT_ARM_YAW_DEGREES`: `-40.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_ROLL_DEGREES`: `0.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_POSE_OVERRIDE_AMOUNT`: `1.0`
- `PLAYER_SHOOTING_ANIMATED_CORE_ARM_POSE_BONES`: `["Left_UpperArm", "Left_Forearm", "Right_UpperArm", "Right_Forearm"]`

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
- Gameplay-view A/B screenshots tested forearm correction ON and OFF across aim up, aim down, aim left, and aim right.
- Forearm correction ON forced the `Left_Forearm` and `Right_Forearm` bones to the aim vector, but the side-aim screenshots showed a twisted/cross-body forearm silhouette that looked worse than the imported animation.
- Forearm correction OFF preserved the imported arm animation and looked better overall in gameplay. This is the current default.
- Final gameplay-view screenshots with correction OFF covered aim up, aim down, aim left, and aim right. The player body faces the aim direction, the old floor-pointing pose is not present, and the arms no longer receive the runtime twist.
- Runtime check reported `forearm_pose_correction_should_apply=false`.
- Runtime movement sanity check moved the player on `move_right` by `0.816` world units.
- Runtime weapon sanity check produced `9` player projectiles after the run started.
- Runtime campaign sanity check reported `campaign_node_elapsed=1.279`, `title_menu_active=false`, and `sector_name=Neon Grid`.
- Collision, HUD, Lyra, Memory Shards, boss cards, reward panels, Sector 1 arenas, and Sector 2 arenas were not changed by the hotfix.
- Arm-level gameplay screenshots were captured from the actual patched runtime at `/tmp/neon_swarm_arm_level_final/final_aim_up.png`, `/tmp/neon_swarm_arm_level_final/final_aim_down.png`, `/tmp/neon_swarm_arm_level_final/final_aim_left.png`, and `/tmp/neon_swarm_arm_level_final/final_aim_right.png`.
- Final runtime capture reported `arm_level_should_apply=true`, `forearm_pose_correction_should_apply=false`, `arm_pose_bone_count=4`, and `forearm_pose_bone_count=2`.
- Final forearm forward-axis vertical components were near level: aim up approximately `-0.004`, aim down approximately `-0.030`, aim left approximately `-0.025`, and aim right approximately `-0.004`.
- The screenshots covered aim up, aim down, aim left, and aim right. The body still faces the aim direction, the arms no longer point down into the floor, and the prior forearm twist/cross-body correction remains disabled.
- Outward-aim gameplay screenshots were captured from the actual patched runtime at `/tmp/neon_swarm_arm_outward_final/final_aim_up.png`, `/tmp/neon_swarm_arm_outward_final/final_aim_down.png`, `/tmp/neon_swarm_arm_outward_final/final_aim_left.png`, and `/tmp/neon_swarm_arm_outward_final/final_aim_right.png`.
- Outward-aim final runtime capture reported `arm_level_should_apply=true`, `forearm_pose_correction_should_apply=false`, `arm_pose_bone_count=4`, and `forearm_pose_bone_count=2`.
- Final forearm vertical components stayed near level at approximately `0.025` to `0.030`. Final horizontal aim dots were approximately `0.994` for aim up, `0.992` to `0.997` for aim down, `0.925` to `0.981` for aim left, and `0.994` to `0.997` for aim right.
- Left and right arms required separate mirrored yaw offsets: left arm `+40` degrees and right arm `-40` degrees. A common yaw alone improved one arm while worsening the other, so mirrored spread was required to avoid inward/cross-body aiming.

## Remaining Improvements

- Add a separate idle/default clip if a future player GLB includes one.
- Tune the shooting arm pose further if a future GLB changes the arm bone local axes or if the gameplay camera shows the arms competing with enemies, XP, bullets, Lyra, boss cards, reward panels, HUD, or Memory Shards.
- If future GLBs use a different forward axis, adjust only the named yaw/pitch/roll/offset constants rather than hardcoding orientation values.
