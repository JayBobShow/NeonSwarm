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

## Hard Repair 2 - White Real Spotlight and Neon Blue Propulsion Ripple

This repair replaces the unapproved blue blob/halo read with a separated two-layer system:

- White/soft-white player-following spotlight and visible beam.
- Blue/cyan player propulsion ripple under the core.

### Godot Docs / Classes Referenced

- `SpotLight3D`: `https://docs.godotengine.org/en/stable/classes/class_spotlight3d.html`
- `Light3D`: `https://docs.godotengine.org/en/stable/classes/class_light3d.html`
- 3D lights and shadows: `https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html`
- `ShaderMaterial`: `https://docs.godotengine.org/en/4.6/classes/class_shadermaterial.html`
- Spatial shaders: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/spatial_shader.html`
- Shading language: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/shading_language.html`

### Why These APIs Were Chosen

- The official run scene is a 3D `Node3D` gameplay scene, so the real player-following light uses `SpotLight3D`.
- `SpotLight3D` is appropriate because Godot documents it as a directional cone light with angle, range, energy, and attenuation controls.
- `Light3D.light_color` and `light_energy` are used directly so the spotlight is soft white and remains separate from blue propulsion.
- The 3D lighting docs note that shadows increase cost, so this always-following presentation light keeps shadows disabled.
- A `SpotLight3D` lights surfaces but does not guarantee a visible air beam in this scene, so the visible shaft uses persistent transparent `MeshInstance3D` sheets.
- `ShaderMaterial` with `shader_type spatial` is used for the beam and ripple because both are 3D meshes and need runtime-driven uniforms.
- The ripple uses shader uniforms, radial `UV` math, `ALBEDO`, `EMISSION`, and `ALPHA`, matching the spatial shader/shading language docs.

### White Spotlight Implementation

- Light node: `PlayerFocusedWhiteSpotlight`
- Class: `SpotLight3D`
- Parent: `PlayerPresentationSpotlightAndPropulsionRipple`
- Color: `Color(1.0, 0.985, 0.94, 1.0)`
- Base energy: `3.35`
- Spot angle: `23.5` to `27.0` degrees based on player movement
- Spot attenuation: `1.92`
- Height / Z offset: `11.2` / `3.65`
- Shadows: disabled
- Bake mode: `Light3D.BAKE_DISABLED`

The presentation root follows `_player_area.position.x/z`. The light is positioned above and slightly behind the player, then aimed at a floor/player target using `look_at()`. Visibility is controlled by gameplay/menu state so the light is hidden outside active runs.

### Visible White Beam Implementation

- Beam nodes: `PlayerSpotlightVolumetricBeamSheet00` through `PlayerSpotlightVolumetricBeamSheet04`
- Mesh type: persistent `ArrayMesh` tapered trapezoid sheets
- Material type: one shared `ShaderMaterial`
- Shader type: `spatial`
- Render mode: `unshaded, blend_add, depth_draw_never, cull_disabled`
- Beam color: `Color(1.0, 0.985, 0.94, 0.115)`
- Beam emission strength: `2.85`
- Beam bottom radius: `1.46`
- Beam top radius: `0.18`

The five crossed sheets align to the same source/target vector as the `SpotLight3D`, creating a visible soft-white cone/shaft without turning the floor effect blue. The shader uses UV-based center falloff, soft edge fade, source/floor fade, and subtle time-driven strand motion. It is intentionally white so it can later be reused visually for warning/light systems without being confused with the player's blue propulsion energy.

### Neon Blue Propulsion Ripple Shader

- Ripple node: `PlayerPropulsionRadialShaderRippleDisk`
- Mesh type: one persistent `PlaneMesh`
- Material type: one persistent `ShaderMaterial`
- Shader type: `spatial`
- Render mode: `unshaded, blend_add, depth_draw_never, cull_disabled`
- Ripple color: `Color(0.0, 0.92, 1.0, 0.72)`
- Core color: `Color(0.05, 0.36, 1.0, 0.42)`

The ripple shader centers `UV` at `vec2(0.5, 0.5)`, computes radial distance, and emits five center-origin ring bands. Each band starts near the center, expands outward, fades with radius/progress, and repeats. A secondary radial wave adds water-ripple texture while staying clean and propulsion-like. Low-alpha fragments outside the circular ripple are discarded so the effect does not read as a square plate or debug marker.

### Final Visual Settings

- Ripple radius: `2.72`
- Ripple period: `0.92` seconds
- Wave speed uniform: `1.08`
- Wave frequency uniform: `5.35`
- Ring layers: `5`
- Beam sheets: `5`
- Spotlight base energy: `3.35`
- Spotlight height: `11.2`
- Spotlight Z offset: `3.65`
- Beam bottom radius: `1.46`
- Beam top radius: `0.18`

### Pause / Menu Behavior

- The effect is hidden on title/menu startup.
- The effect is shown/reset only when gameplay starts.
- `_sync_player_presentation_visibility()` hides it during title, pause, game-over, run-success, level-up, weapon reward, and sector reward modal states.
- Ripple time advances only through `_update_player_presentation_effects(delta)` on the gameplay update path.
- The shader uses a gameplay-driven `ripple_time` uniform instead of raw shader `TIME`, so the ripple freezes when gameplay is paused.

### Performance Safeguards

- One `SpotLight3D`, five beam sheets, and one ripple plane are created once.
- Runtime updates only transforms, light settings, visibility, and shader uniforms.
- No per-frame node creation.
- No per-frame mesh rebuilding.
- No particle spawning.
- No volumetric fog dependency.
- Shadows are disabled on the player spotlight.
- Focused validation checks child counts stay stable across repeated presentation updates.

### Validation Results

Final validation was run after implementation and documentation updates:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase37_hr2_validate.gd`
- `git diff --check`
- `git diff --stat`
- `git status`

Focused validation confirms:

- White `SpotLight3D` initializes safely.
- White visible beam sheet nodes/material initialize safely.
- Blue/cyan ripple shader/material initializes safely.
- Effect is hidden on title/menu startup.
- Effect appears during gameplay.
- Effect follows player X/Z position.
- Ripple time and shader uniform advance during gameplay.
- Presentation hides during manual pause.
- Ripple time does not advance while paused.
- Presentation reappears after pause.
- Presentation hides after return to title.
- Child counts remain stable during repeated updates.

### Manual Test Checklist

- Start Game and confirm the spotlight/beam is white or soft white, not blue.
- Confirm the white beam follows the player and reads as an actual light shaft.
- Confirm the beam is focused and does not wash out enemies, XP, projectiles, events, or HUD.
- Confirm blue/cyan propulsion ripples start from the exact center under the player.
- Confirm multiple blue rings expand outward, fade, and repeat continuously.
- Move around and confirm the ripple remains centered under the player.
- Stand still and confirm the ripple still reads as continuous propulsion energy.
- Pause and confirm the effect hides/freezes cleanly.
- Return to title and confirm the effect is gone.
- Confirm gameplay controls, combat, weapons, progression, menus, and controller support behave unchanged.

## Phase 37 Hotfix 3 - Wider Floor Spotlight / Hidden Top Cone

This hotfix keeps the Hard Repair 2 two-layer direction, preserves the blue propulsion ripple, and adjusts only the white spotlight presentation so the player sits inside a wider, more cinematic floor-reaching light shaft.

### Godot Docs / Classes Referenced

- `SpotLight3D`: `https://docs.godotengine.org/en/stable/classes/class_spotlight3d.html`
- `Light3D`: `https://docs.godotengine.org/en/stable/classes/class_light3d.html`
- 3D lights and shadows: `https://docs.godotengine.org/en/4.6/tutorials/3d/lights_and_shadows.html`
- `ShaderMaterial`: `https://docs.godotengine.org/en/4.6/classes/class_shadermaterial.html`
- Spatial shaders: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/spatial_shader.html`
- Shading language: `https://docs.godotengine.org/en/4.6/tutorials/shaders/shader_reference/shading_language.html`

### What Changed

- The real `SpotLight3D` remains soft white and player-following.
- The `SpotLight3D.spot_angle` runtime range was widened to `34.0` through `38.0` degrees.
- `spot_range` now extends `3.1` units past the source-to-target distance.
- `spot_attenuation` was softened to `1.42`.
- Base light energy moved from `3.35` to `3.85`, still with shadows disabled.
- Visible beam sheets increased from `5` to `7`.
- The lower beam radius widened from `1.46` to `2.82`.
- The upper beam radius widened from `0.18` to `0.42`, but the shader now hides/fades the upper cone so the apex does not read as a tight tip.

### Beam Width / Floor Footprint

- New lower beam footprint radius: `2.82`
- New floor pool radius: `5.35`
- New floor pool node: `PlayerSpotlightSoftWhiteFloorPool`
- Floor pool mesh: persistent `PlaneMesh`
- Floor pool material: persistent spatial `ShaderMaterial`
- Floor pool color: `Color(1.0, 0.985, 0.94, 0.235)`

The white floor pool is an additive soft oval under the player. It is separate from the blue propulsion ripple so the spotlight reads as a light landing on the floor while the ripple remains propulsion energy.

### Top Cone Fade / Hide Method

The beam shader now suppresses the upper cone/apex using `UV.y` fades:

- `top_crop_fade = 1.0 - smoothstep(0.58, 0.75, UV.y)`
- `apex_kill = 1.0 - smoothstep(0.72, 0.90, UV.y)`

That makes the upper 25-40% of the visible beam much less visible and shifts emphasis to the lower shaft around the player/floor. The beam starts visually softer and lower, avoiding the skinny top-cone read.

### Floor Light / Contact Change

- New contact node: `PlayerSubtleGroundedContactShadow`
- Contact mesh: persistent `PlaneMesh`
- Contact material: persistent spatial `ShaderMaterial`
- Contact radius: `1.52`
- Contact color: `Color(0.0, 0.012, 0.018, 0.30)`

The contact material is a small transparent dark oval under the player core. It provides a slight grounded/contact feel without changing collision, gameplay, or player physics.

### Ripple Status

The blue propulsion ripple was not redesigned or retuned in Hotfix 3. It remains:

- blue/cyan neon
- centered under the player
- shader-driven on `PlayerPropulsionRadialShaderRippleDisk`
- repeating outward from the center with the existing script-driven `ripple_time`

### Hotfix 3 Performance Safeguards

- The new floor pool and contact shadow are created once.
- Runtime updates only visibility and shader uniforms.
- No per-frame node creation.
- No per-frame mesh rebuilding.
- No particle spawning.
- Player spotlight shadows remain disabled.

### Hotfix 3 Validation Results

Final validation was run after implementation and documentation updates:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase37_hotfix3_validate.gd`
- `git diff --check`
- `git diff --stat`
- `git status`

Focused validation confirms:

- White `SpotLight3D` initializes safely.
- Wider beam sheets initialize safely.
- Beam shader uses the top cone fade/crop variables in shader code.
- White floor pool material initializes safely.
- Contact shadow material initializes safely.
- Blue ripple shader/material still initializes and follows player.
- Presentation hides on title/menu startup.
- Presentation hides during manual pause.
- Presentation hides after return to title.
- Child counts remain stable across repeated updates.

### Hotfix 3 Manual Test Checklist

- Start Game and confirm the white beam is wider around the player/floor.
- Confirm the player feels inside the white shaft of light.
- Confirm the top cone/apex is not visibly tight or distracting.
- Confirm the floor around the player has a wider, softer white light pool.
- Confirm the subtle contact shadow helps ground the player without looking like a gameplay marker.
- Confirm the blue ripple remains visible underneath and still reads as propulsion energy.
- Move around and confirm the spotlight, floor pool, contact shadow, and ripple stay centered under the player.
- Pause and confirm the effect hides/freezes cleanly.
- Return to title and confirm the effect is gone.
- Confirm gameplay controls, combat, weapons, progression, menus, and controller support behave unchanged.
