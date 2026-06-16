# Neon Swarm Phase 2.5: 3D-On-2D-Plane Visual Prototype Report

## 1. Executive Summary

Phase 2.5 created a contained 3D visual prototype for Neon Swarm without replacing the current 2D game.

The prototype tests whether Neon Swarm should use 3D neon visuals locked to a 2D gameplay plane. It keeps the concept of top-down arena survival, flat X/Z movement, simple collision assumptions, readable swarms, and procedural geometric shape language.

Created isolated prototype scene:

- `scenes/NeonSwarm3DVisualPrototype.tscn`

Created support script:

- `scripts/NeonSwarm3DVisualPrototype.gd`

The current `Main.tscn`, 2D gameplay loop, weapons, enemies, XP system, pause system, controller support, and progression were not replaced.

## 2. Why 3D-On-2D Was Tested

The current 2D version has improved through several repair passes, but the user feedback remains consistent:

- The game still does not fully read as ghostly gas-light neon plasma.
- 2D procedural draw calls can still look like clean vector symbols or layered cardboard.
- The target wants hot neon tubes, thick emission lines, white-hot cores, bloom, vapor haze, and energy objects that feel dimensional.

3D-on-2D was tested because Godot 3D can express that target through:

- Emissive materials.
- Bloom/glow environment.
- Transparent plasma shells.
- Wireframe/tube-like meshes.
- Rotating geometry.
- Dark grid floor depth.
- Capped spark pools and projectile streaks.

This is not a gameplay rewrite. It is a visual experiment.

## 3. 3D Visual Approach

The prototype uses:

- `Node3D` root.
- Fixed orthographic, slightly angled top-down `Camera3D`.
- X/Z as the visual gameplay plane.
- Dark world environment with glow enabled.
- Procedural emissive materials.
- Cylinder meshes as thick neon tubes.
- Torus meshes as emission rings.
- Sphere meshes as white-hot cores and transparent plasma halos.
- ImmediateMesh grid lines for the arena floor.
- Capped spark pool for burst behavior.
- Runtime-built sample objects, not imported sprite sheets.

The geometry bible is respected:

- Chaser: triangular / pyramid-arrow identity.
- Tank: cube / square-frame heavy identity.
- Shooter: octahedron / diamond identity.
- XP: sphere / annulus energy pickup identity.
- Projectile: line segment / laser streak identity.
- Arena: rectangle/grid identity.

## 4. Player Visual Result

The prototype player is a glowing 3D combat core:

- White-hot center sphere.
- Cyan and magenta emission rings.
- Angular diamond energy frame.
- Transparent cyan plasma shell.
- Rotating inner ring.
- Short ghost trail/light smear using reusable tube segments.
- Slight animated movement on the X/Z plane to demonstrate trail readability.

Result: the player reads more like a dimensional neon energy object than a flat 2D icon. It is also the brightest and clearest object in the prototype scene.

## 5. Enemy Visual Result

Three enemy visual samples were created, plus a stress field of repeated samples:

- Chaser: green/cyan triangular pyramid-arrow frame with white-hot inner tubes and a small ion trail.
- Tank: orange cube/square-frame structure with internal white crossbars and heavier plasma haze.
- Shooter: violet octahedron/diamond frame with a white-hot muzzle point.

All samples are visual-only. They do not add new enemy gameplay, AI, collision behavior, or spawner behavior.

Result: rotating 3D wire/tube shapes are more dimensional than the current flat 2D outline approach, but they increase node count substantially if every edge is built from separate mesh instances.

## 6. XP Orb Visual Result

The XP orb prototype uses:

- White-hot core sphere.
- Yellow transparent plasma halo.
- Yellow annulus ring.
- Cyan rotating orbit ring.
- Small white orbit spark.
- Animated bob and rotation.

Result: the XP pickup reads as a premium 3D energy reward and is visually stronger than the current 2D XP orb direction. It also creates a clear migration path for making pickups feel more valuable without changing XP logic.

## 7. Projectile/VFX Result

Projectile and VFX samples include:

- Cyan energy streak projectiles made from thick outer tubes and white-hot inner tubes.
- Hot projectile tip spheres.
- A capped spark burst pool using 96 reusable spark nodes.
- Looping spark expansion/contraction to simulate impact/death-burst plasma without spawning unbounded particles.

Result: 3D streaks and spark pools look promising for plasma feel, especially because they can be made dimensional and bloom-friendly. The prototype intentionally avoids runaway particle spawning.

## 8. Arena/Grid Result

The arena uses:

- Black/dark void environment.
- Glowing X/Z grid floor.
- Major/minor/axis grid line separation.
- Neon rectangular border built from cyan tube meshes.
- Background brightness kept below gameplay objects.

Result: the grid floor gives the scene a stronger neon arcade floor/world presence. It supports the 3D look without replacing gameplay.

## 9. Performance Result

Validation commands run:

- `godot --headless --path . scenes/NeonSwarm3DVisualPrototype.tscn --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_phase25_3d_visual_stress.gd`
- `godot --headless --path . --quit-after 3`

Prototype scene-load stress output:

- Enemy visuals: `75`
- XP orb visuals: `120`
- Projectiles: `18`
- Spark pool: `96`
- Total visual nodes: `2730`

Dedicated 3D visual stress:

- Visual frame window: `480`
- Frame window time: `3302 ms`
- Approximate headless ms/frame: `6.88`
- Result: passed

Current 2D main scene still launches cleanly after adding the prototype:

- `godot --headless --path . --quit-after 3`: passed

Interpretation:

- Headless 3D stress timing is promising for a prototype.
- The current 3D approach uses many nodes because each neon tube/edge is a separate mesh instance.
- It may be smoother visually if optimized with MultiMesh, batched meshes, shared materials, and GPU particles.
- It may be worse than 2D if every enemy is built from many independent MeshInstance3D nodes.
- A full rebuild should not begin until a live visual/performance review confirms that 3D meaningfully improves the target look.

## 10. Files Created

- `scenes/NeonSwarm3DVisualPrototype.tscn`
- `scripts/NeonSwarm3DVisualPrototype.gd`
- `docs/NEON_SWARM_PHASE_2_5_3D_ON_2D_PLANE_VISUAL_PROTOTYPE_REPORT.md`

Validation helper:

- `/tmp/neon_swarm_phase25_3d_visual_stress.gd`

## 11. How To Run The Prototype Scene

In Godot 4.6.3:

1. Open the Neon Swarm project.
2. Open `scenes/NeonSwarm3DVisualPrototype.tscn`.
3. Run the scene directly.
4. Do not run it as a replacement for `Main.tscn`.

Command-line smoke:

```bash
godot --headless --path . scenes/NeonSwarm3DVisualPrototype.tscn --quit-after 3000
```

## 12. Risks / Downsides

- This prototype is visual-only; it does not prove full gameplay integration.
- Node count is high because prototype tubes, rings, sparks, and enemy edges are individual nodes.
- Real performance must be reviewed with an actual renderer/display, not only headless.
- A 3D migration would require mapping existing 2D gameplay positions into X/Z coordinates.
- 3D bloom and transparent plasma can create overdraw if not aggressively capped.
- Controller, pause, level-up, and gameplay systems are not integrated into this prototype scene because it is not a game rewrite.
- A full 3D-on-2D rebuild would need batching, LOD, pooled VFX, and a clear camera/readability rule before production use.

## 13. Recommendation: Stay 2D, Hybridize, Or Rebuild As 3D-On-2D

Recommendation: hybridize next, do not rebuild the full game yet.

Reason:

- The 3D prototype better expresses hot neon tubes, white-hot cores, dimensional XP orbs, rotating wireframe enemies, bloom, and gas-light plasma.
- The result is promising enough to continue testing.
- The node-count cost is real and must be solved before replacing the current game.
- A full rebuild would be premature until manual visual review confirms that the 3D look is clearly superior.

Recommended next step after manual review:

- If approved visually, build a small hybrid bridge prototype that renders only player, XP, and one enemy type in 3D while keeping the current 2D gameplay loop authoritative.
- If rejected visually, keep the main game 2D and use lessons from the 3D prototype to improve the 2D plasma treatment.
