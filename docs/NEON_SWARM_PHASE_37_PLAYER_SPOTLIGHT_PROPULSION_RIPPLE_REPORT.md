# Neon Swarm Phase 37 Player Propulsion Ripple Report

Date: 2026-06-17

## Scope

Phase 37 remains a visual-only player presentation pass in the official build:

- Project: `/home/jason/GodotProjects/NeonSwarm`
- Official scene: `scenes/Main.tscn`
- Player core replacement is preserved.
- Blue/cyan propulsion ripple is preserved.
- Player spotlight attempts are removed from the active build.

No alternate playable scene was created. No Phase 38 work was started. Combat logic, enemy behavior, weapons, balance, sectors, events, stash, forge, progression, menus, controls, and save systems were not changed.

## Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_37_PLAYER_SPOTLIGHT_PROPULSION_RIPPLE_REPORT.md`

## Hotfix 4 - Spotlight Removed / Propulsion Ripple Preserved

The user rejected the repeated spotlight attempts visually. Hotfix 4 removes the player spotlight system cleanly and leaves the accepted blue propulsion ripple as the only active Phase 37 player presentation effect.

Final active player presentation:

- No white `SpotLight3D`.
- No white beam cone or beam sheets.
- No visible top cone.
- No white floor pool.
- No spotlight-only contact shadow.
- Blue/cyan propulsion ripple remains centered under the player and repeats outward.

## Godot Docs / Classes Referenced

- `SpotLight3D`: `https://docs.godotengine.org/en/stable/classes/class_spotlight3d.html`
- `Light3D`: `https://docs.godotengine.org/en/stable/classes/class_light3d.html`
- `ShaderMaterial`: `https://docs.godotengine.org/en/4.6/classes/class_shadermaterial.html`
- Spatial shaders: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/spatial_shader.html`

Why these docs/classes were used:

- `SpotLight3D` and `Light3D` document the rejected real-light path. Hotfix 4 removes that active node path rather than continuing to tune a visually rejected feature.
- `ShaderMaterial` documents the runtime shader parameter path used by the preserved blue ripple.
- Spatial shader documentation covers the ripple's 3D `PlaneMesh` material with `shader_type spatial`, `ALBEDO`, `EMISSION`, and `ALPHA`.

## Spotlight Systems Removed

Removed from the active runtime code:

- `SpotLight3D` player-following light state and creation.
- `PlayerFocusedWhiteSpotlight`.
- `PlayerSpotlightVolumetricBeamSheet%02d` beam sheet nodes.
- White beam `ArrayMesh` generation helper.
- White beam `ShaderMaterial` helper.
- `PlayerSpotlightSoftWhiteFloorPool`.
- White floor pool `PlaneMesh` and material helper.
- `PlayerSubtleGroundedContactShadow`.
- Spotlight-only contact shadow `PlaneMesh` and material helper.
- Spotlight constants for height, offset, beam radii, beam count, light energy, floor pool radius, and contact radius.
- Spotlight update logic for light color, energy, range, angle, attenuation, beam transforms, floor pool uniforms, and contact shadow uniforms.
- Spotlight-specific visibility and cleanup logic.

The presentation root is now named `PlayerPresentationPropulsionRipple` so newly created runtime nodes no longer advertise an active spotlight system.

## Propulsion Ripple Preserved

The active player presentation effect remains:

- Root: `PlayerPresentationPropulsionRipple`
- Ripple root: `PlayerPropulsionShaderRippleRoot`
- Ripple mesh: `PlayerPropulsionRadialShaderRippleDisk`
- Mesh type: persistent `PlaneMesh`
- Material type: persistent `ShaderMaterial`
- Shader type: `spatial`
- Ripple color: `Color(0.0, 0.92, 1.0, 0.72)`
- Core color: `Color(0.05, 0.36, 1.0, 0.42)`
- Radius: `2.72`
- Period: `0.92` seconds
- Wave speed uniform: `1.08`
- Wave frequency uniform: `5.35`

The ripple still computes radial distance from the UV center, expands multiple blue/cyan ring bands outward, fades them as they travel, and repeats using the script-driven `ripple_time` uniform.

## Pause / Menu Behavior

- The ripple presentation is hidden on title/menu startup.
- The ripple is shown/reset only when gameplay starts.
- `_sync_player_presentation_visibility()` hides it during title, pause, game-over, run-success, level-up, weapon reward, and sector reward modal states.
- Ripple time advances only through `_update_player_presentation_effects(delta)` on the gameplay update path.
- The shader uses gameplay-driven `ripple_time`, so the ripple freezes when gameplay is paused.

## Performance Safeguards

- One ripple root, one ripple `PlaneMesh`, and one ripple `ShaderMaterial` are created once.
- Runtime updates only transform, visibility, and shader uniforms.
- No per-frame node creation.
- No per-frame mesh rebuilding.
- No player spotlight light cost.
- No player spotlight shadows.
- No visible beam, floor pool, or contact shadow draw calls remain.

## Validation Results

Final validation was run after implementation and documentation updates:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase37_hotfix4_validate.gd`
- `git diff --check`
- `git diff --stat`
- `git status`

Focused validation confirms:

- No player `SpotLight3D` is created.
- No spotlight beam sheets are created.
- No white floor pool is created.
- No spotlight-only contact shadow is created.
- Blue/cyan ripple `PlaneMesh` and `ShaderMaterial` initialize safely.
- Ripple follows player X/Z position.
- Ripple is hidden on title/menu startup.
- Ripple hides during manual pause and does not advance time while paused.
- Ripple reappears after pause.
- Ripple hides after return to title.
- Child counts remain stable across repeated updates.

## Manual Test Checklist

- Start Game and confirm there is no white spotlight.
- Confirm there is no white beam cone or top cone.
- Confirm there is no white floor pool around the player.
- Confirm the blue/cyan propulsion ripple remains visible under the player.
- Confirm the ripple starts from the player center and repeats outward.
- Move around and confirm the ripple stays centered under the player.
- Stand still and confirm the ripple continues to loop.
- Pause and confirm the ripple hides/freezes cleanly.
- Return to title and confirm the ripple is gone.
- Confirm gameplay controls, combat, weapons, progression, menus, save compatibility, and controller support behave unchanged.

## Hotfix 5 - Remove Player Trail / Strengthen Neon Ripple

Hotfix 5 removes the remaining player-only blue rear smear/trail and slightly strengthens the preserved blue propulsion ripple. The player spotlight system remains removed.

### Godot Docs / Classes Referenced

- `ShaderMaterial`: `https://docs.godotengine.org/en/4.6/classes/class_shadermaterial.html`
- Spatial shaders: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/spatial_shader.html`
- Shading language: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/shading_language.html`

Why these docs/classes were used:

- The accepted ripple is a `ShaderMaterial` on a 3D `PlaneMesh`, so `set_shader_parameter()` remains the correct runtime uniform update path.
- The ripple shader remains `shader_type spatial` and uses documented spatial outputs including `ALBEDO`, `EMISSION`, and `ALPHA`.
- Shading language uniform behavior is used for ripple color, speed, frequency, intensity, and movement response.

### Player Trail Removed

Removed from `scripts/visuals/Player3D.gd`:

- `_trail_tubes`
- `blue_haze`
- `PlayerGhostPlasmaSmear%d`
- the per-frame `Kit.update_tube()` calls that animated the rear blue smear tubes

This removes the small blue streak behind the player without touching enemy trails, projectile trails, XP collection trails, hazard trails, or gameplay logic.

### Ripple Strengthened

The ripple remains the same under-player `PlaneMesh` and does not change size, position, follow behavior, or pause behavior. Changes were limited to the shader/material values for readability:

- Ripple color changed from `Color(0.0, 0.92, 1.0, 0.72)` to `Color(0.0, 0.98, 1.0, 0.78)`.
- Core color changed from `Color(0.05, 0.36, 1.0, 0.42)` to `Color(0.04, 0.44, 1.0, 0.48)`.
- Ring edge definition sharpened by changing `ring_band()` from `width * 0.24` to `width * 0.18`.
- Secondary trailing bands were removed from the ring loop so the ripple reads as cleaner rings instead of a trail.
- Ring width tightened from `mix(0.016, 0.048, progress)` to `mix(0.014, 0.040, progress)`.
- Ring strength increased to `band * 1.18`.
- Ripple alpha cap increased from `0.62` to `0.70`.
- Emission increased to `2.35 + rings * 8.7 + flow_lines * 3.8 + movement_boost * 1.5`.
- Runtime intensity range increased from `lerpf(0.86, 1.18, movement_strength)` to `lerpf(0.94, 1.28, movement_strength)`.

### Spotlight Status

The spotlight remains removed:

- No player `SpotLight3D`.
- No white beam cone or beam sheets.
- No white floor pool.
- No spotlight contact shadow.
- No spotlight constants, state, helpers, or update path restored.

### Hotfix 5 Validation Results

Final validation was run after implementation and documentation updates:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase37_hotfix5_validate.gd`
- `git diff --check`
- `git diff --stat`
- `git status`

Focused validation confirms:

- No player rear smear/trail nodes are created.
- No player `_trail_tubes` state remains.
- No spotlight/beam/floor pool/contact spotlight visuals are active.
- Blue ripple `PlaneMesh` and `ShaderMaterial` initialize safely.
- Ripple uses the strengthened neon color, alpha, and intensity values.
- Ripple follows player X/Z position.
- Ripple is hidden on title/menu startup.
- Ripple hides during manual pause and does not advance time while paused.
- Ripple hides after return to title.

### Hotfix 5 Manual Test Checklist

- Start Game and confirm there is no small blue streak behind the player.
- Confirm the player core no longer has rear ghost smear tubes.
- Confirm there is still no white spotlight, white beam, or white floor pool.
- Confirm the blue/cyan ripple remains under the player.
- Confirm the ripple rings are clearer/brighter but not oversized or blob-like.
- Move around and confirm the ripple stays centered under the player rather than trailing behind.
- Pause and confirm the ripple hides/freezes cleanly.
- Return to title and confirm the ripple is gone.
- Confirm gameplay controls, combat, weapons, progression, menus, save compatibility, and controller support behave unchanged.
