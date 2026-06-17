# Neon Swarm Phase 37 Player Spotlight / Propulsion Ripple Report

Date: 2026-06-17

## Scope

Phase 37 is a visual-only player presentation pass in the official build:

- Project: `/home/jason/GodotProjects/NeonSwarm`
- Official scene: `scenes/Main.tscn`
- Prior approved local commit: `1ff9771 Player core GLB replacement orientation hotfix`

No alternate playable scene was created. No Phase 38 work was started. Combat logic, enemy behavior, weapons, balance, sectors, events, stash, forge, progression, menus, controls, and save systems were not changed.

## Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_37_PLAYER_SPOTLIGHT_PROPULSION_RIPPLE_REPORT.md`

## Spotlight Implementation

The player presentation effect is created once as `PlayerPresentationSpotlightAndPropulsionRipple` under the pausable gameplay root. It starts hidden on the title menu and is shown/reset when gameplay starts.

The spotlight portion uses:

- `PlayerFocusedBlueCyanSpotlight`: a focused blue/cyan `SpotLight3D` with disabled shadows and tight attenuation.
- `PlayerSpotlightOuterFloorFocus` and `PlayerSpotlightInnerCyanFloorFocus`: low-alpha emissive floor focus meshes that provide the readable Neon Swarm-style player pool without washing out the arena.

Every gameplay update, the presentation root copies the player X/Z position, so the spotlight tracks the player while keeping a stable floor height.

## Propulsion Ripple Implementation

The propulsion wave uses a fixed three-node pool named `PlayerPropulsionRippleFixedPool`. Each ripple is a cyan torus that expands from a small radius to a controlled outer radius, fades out, and loops.

Cadence and behavior:

- Ripple count: `3`
- Ripple period: `0.86` seconds
- Radius range: `0.46` to `2.85`
- Each ring is offset evenly through the loop for continuous propulsion energy.
- Ripple alpha gets a subtle movement boost while the player is moving, but remains visible while standing still.
- VFX intensity settings scale spotlight and ripple strength.

No ripple nodes are spawned during gameplay. Existing torus meshes and materials are updated in place.

## Performance Safeguards

- Fixed node pool only; no runaway VFX spawning.
- Spotlight shadows are disabled.
- The effect is updated only from the gameplay update path.
- The effect is hidden on title/menu startup and reset when gameplay starts.
- Pause safety comes from the normal gameplay loop: when the tree is paused, `_process()` returns before `_update_player()`, so ripple phase and spotlight updates stop.
- The floor focus meshes use low alpha and small radii to avoid screen washout and arena readability loss.

## Delegation Summary

- Runtime Architecture Lead confirmed `scenes/Main.tscn` uses `scripts/NeonSwarm3DGameplayPrototype.gd`, and recommended pausable, fixed gameplay nodes with no per-frame allocation.
- Visual/VFX Lead recommended a blue/cyan floor-focus presentation, fixed pooled ripple behavior, no global bloom changes, and VFX intensity scaling.
- Implementation Lead added the runtime effect in the official gameplay script.
- QA Lead reviewed the working tree and found no blocking issues before final validation.

## Validation Results

Passed:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase37_player_presentation_validation.gd`
- `git diff --check`
- `git diff --stat`

Focused validation covered:

- presentation root exists and starts hidden on title/menu startup
- gameplay start shows and resets the effect
- spotlight node exists with shadows disabled
- fixed three-node ripple pool exists
- presentation root follows the player X/Z position
- ripple phase freezes while paused and resumes after unpause
- VFX intensity scales spotlight energy
- ripple meshes remain valid torus meshes

## Manual Test Checklist

Run:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Then test:

- Start Game.
- Confirm the spotlight visibly follows the player.
- Confirm the player stands out better from the arena/background.
- Confirm the blue ripple repeats continuously underneath the player.
- Confirm the ripple reads as futuristic propulsion energy.
- Confirm the effect looks good while moving and standing still.
- Pause gameplay and confirm the ripple freezes correctly.
- Confirm gameplay remains unchanged.
