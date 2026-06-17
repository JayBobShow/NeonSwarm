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

## Hard Repair - Godot Manual-Based Spotlight and Shader Ripple

This hard repair replaces the unapproved Phase 37 presentation. The current version uses one real Godot light, crossed volumetric beam sheets, and one radial shader ripple plane.

Manual docs/classes referenced:

- `SpotLight3D`: `https://docs.godotengine.org/en/stable/classes/class_spotlight3d.html`
- 3D lights and shadows: `https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html`
- `ShaderMaterial`: `https://docs.godotengine.org/en/4.6/classes/class_shadermaterial.html`
- Spatial shaders: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/spatial_shader.html`
- Shading language: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/shading_language.html`

Why those docs/classes were used:

- The official build is a 3D `Node3D` scene, so the player-following light uses `SpotLight3D`.
- `SpotLight3D` properties are used directly: color, energy, range, angle, attenuation, and disabled shadows.
- Godot light/shadow guidance informed the performance decision to keep one focused light and leave shadows disabled for this always-following player presentation.
- `ShaderMaterial` is used for the beam and ripple so runtime code can update uniforms with `set_shader_parameter()`.
- Spatial shaders are used because both the beam and ripple are 3D `MeshInstance3D` materials.
- The ripple shader uses spatial shader built-ins such as `UV`, `ALBEDO`, `EMISSION`, and `ALPHA`.

Engine light implementation:

- Light node: `PlayerFocusedBlueCyanSpotlight`
- Class: `SpotLight3D`
- Attached under: `PlayerPresentationSpotlightAndPropulsionRipple`
- The presentation root follows `_player_area.position.x/z`.
- The light is positioned above and slightly behind the player, then aimed at the player/floor target.
- Shadows are disabled.
- Energy, range, and angle are updated from VFX intensity and a small movement boost.

Visible beam implementation:

- The visible beam uses four crossed tapered beam sheets:
  - `PlayerSpotlightVolumetricBeamSheet00`
  - `PlayerSpotlightVolumetricBeamSheet01`
  - `PlayerSpotlightVolumetricBeamSheet02`
  - `PlayerSpotlightVolumetricBeamSheet03`
- Each beam sheet is an `ArrayMesh` trapezoid aligned to the same source/target vector as the `SpotLight3D`.
- The beam material is a `ShaderMaterial` spatial shader with:
  - `render_mode unshaded, blend_add, depth_draw_never, cull_disabled`
  - center-line core fade
  - soft edge fade across `UV.x`
  - length fade across `UV.y`
  - subtle scan/pulse motion from the gameplay-driven beam time uniform
- This creates a visible sci-fi spotlight/tractor-beam shaft without adding volumetric fog or a flat floor marker.

Ripple shader implementation:

- Ripple node: `PlayerPropulsionRadialShaderRippleDisk`
- Mesh: one persistent `PlaneMesh`
- Material: one persistent `ShaderMaterial`
- The shader computes a radial coordinate from `UV - vec2(0.5, 0.5)`.
- Four center-origin ring bands expand outward, fade, and repeat.
- A secondary repeating radial wave layer adds water-ripple texture without becoming random particles.
- A small center pulse gives the player core a propulsion source point.
- The shader disc discards low-alpha fragments outside the circular ripple so it does not read as a square or static flat plate.

Final ripple settings:

- Ripple radius: `3.20`
- Ripple period: `0.92` seconds
- Wave speed uniform: `1.0`
- Wave frequency uniform: `4.65`
- Ring layers: `4`
- Beam sheets: `4`
- Spotlight height: `10.6`
- Spotlight Z offset: `4.15`
- Beam bottom radius: `2.22`
- Beam top radius: `0.32`

Pause/menu behavior:

- The effect is hidden on title/menu startup.
- The effect is shown/reset only when gameplay starts.
- `_sync_player_presentation_visibility()` hides it during title, pause, game-over, run-success, level-up, weapon reward, and sector reward modal states.
- Ripple time advances only through `_update_player_presentation_effects(delta)` on the gameplay update path.
- The shader uses a gameplay-driven `ripple_time` uniform instead of raw shader `TIME`, so the ripple freezes correctly when gameplay is paused.

Performance safeguards:

- One `SpotLight3D`, four beam sheet meshes, and one ripple plane are created once.
- Runtime updates only transforms and shader uniforms.
- No per-frame node creation.
- No per-frame mesh rebuilding.
- No volumetric fog.
- Shadows are disabled on the player spotlight.
- Child counts are validated to remain stable across repeated presentation updates.

Hard repair validation:

- `godot --headless --path . --script /tmp/neon_swarm_phase37_hard_repair_validate.gd`
- Confirmed:
  - `SpotLight3D` initializes safely
  - four shader beam sheets initialize safely
  - shader ripple `PlaneMesh` initializes safely
  - effect is hidden on title/menu startup
  - effect appears during gameplay
  - effect follows player X/Z position
  - ripple time and shader uniform advance during gameplay
  - presentation hides during manual pause
  - ripple time does not advance while paused
  - presentation reappears after pause
  - presentation hides after return to title
  - child counts remain stable during repeated updates

Manual hard repair test checklist:

- Start Game and look for a real blue/cyan spotlight beam, not only a floor circle.
- Move around and confirm the beam follows the player smoothly.
- Stand still and confirm the ripple starts from the exact center under the player.
- Move around and confirm the ripple remains centered under the player.
- Confirm multiple blue rings expand outward and fade continuously.
- Confirm the ripple reads as sci-fi propulsion energy, not a debug marker.
- Pause and confirm the effect hides/freezes cleanly.
- Return to title and confirm the effect is gone.
- Change VFX intensity and confirm the effect changes strength without flooding the arena.
