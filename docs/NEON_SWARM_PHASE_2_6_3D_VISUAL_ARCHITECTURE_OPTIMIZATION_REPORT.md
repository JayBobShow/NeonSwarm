# Neon Swarm Phase 2.6: 3D Visual Architecture Optimization Report

## 1. Executive Summary

Phase 2.6 optimized the isolated 3D-on-2D visual prototype without migrating the main game.

The prototype now uses batched visual architecture instead of building every enemy edge, XP ring, projectile, and spark as separate scene nodes. The optimized scene keeps the same 3D-on-2D goal: hot neon tubes, white-hot cores, colored emission glow, plasma haze, ghostly trails, glowing grid floor, readable swarms, and flat X/Z gameplay-plane presentation.

Result:

- Previous Phase 2.5 stress: `2730` total visual nodes.
- Optimized Phase 2.6 stress: `43` total visual nodes.
- Previous stress load: `75` enemies, `120` XP, `18` projectiles, `96` sparks.
- Optimized stress load: `150` enemies, `240` XP, `60` projectiles, `96` pooled sparks.

The main 2D game was not replaced. `Main.tscn` remains the project main scene.

## 2. Why Full Migration Is Not Approved Yet

Full migration is still not approved because Phase 2.5 proved the 3D look was promising but too node-heavy to trust for real swarm gameplay.

The rejected migration risk:

- `2730` total visual nodes with only `75` enemy visuals.
- `120` XP visuals already consumed hundreds of nodes.
- Sparks were independent nodes.
- Enemies were assembled from many child mesh nodes per visual.
- A full swarm could multiply node count and transparent overdraw quickly.

Phase 2.6 addresses the architecture risk, but it still does not prove full gameplay integration. Manual live visual review and a hybrid bridge test are still required before any main-game migration.

## 3. Node Count Audit

Phase 2.5 node source audit:

- Player visual nodes: `24`
- Enemy visual nodes: `1803`
- XP visual nodes: `720`
- Projectile visual nodes: `72`
- Spark/VFX nodes: `96`
- Arena/grid/world/camera nodes: `14`
- Scene root: `1`
- Total: `2730`

Primary cause:

- Every enemy edge was a separate `MeshInstance3D`.
- Every XP orb was a `Node3D` with five child visuals.
- Every projectile was a root node plus several child meshes.
- Every spark was an independent `MeshInstance3D`.

Phase 2.6 optimized node audit:

- Player visual nodes: `9`
- Enemy visual nodes: `9`
- XP visual nodes: `5`
- Projectile visual nodes: `3`
- Spark/VFX nodes: `1`
- Arena/grid nodes: `6`
- Lighting/camera/world nodes: `2`
- Total visual nodes: `43`

## 4. Optimization Changes

Files changed:

- `scripts/NeonSwarm3DVisualPrototype.gd`

Core optimization changes:

- Replaced per-object enemy scene trees with type-based `MultiMeshInstance3D` batches.
- Replaced per-XP scene trees with shared XP `MultiMeshInstance3D` layers.
- Replaced per-projectile scene trees with three projectile batches.
- Replaced 96 independent spark nodes with one pooled spark `MultiMeshInstance3D`.
- Shared emissive materials across all instances.
- Shared generated meshes for cores, halos, rings, projectiles, and enemy wire/tube frames.
- Built enemy tube geometry into reusable merged meshes instead of child tubes per enemy.
- Kept the player detailed but reduced the player node footprint.
- Kept arena grid and border batched into a small number of nodes.

## 5. Enemy Visual Optimization

Enemy count in optimized stress:

- `150` enemy visuals.

Enemy node architecture:

- Chaser batch:
  - One haze `MultiMeshInstance3D`
  - One colored outer tube `MultiMeshInstance3D`
  - One white-hot core `MultiMeshInstance3D`
- Tank batch:
  - One haze `MultiMeshInstance3D`
  - One colored outer tube `MultiMeshInstance3D`
  - One white-hot core `MultiMeshInstance3D`
- Shooter batch:
  - One haze `MultiMeshInstance3D`
  - One colored outer tube `MultiMeshInstance3D`
  - One white-hot core `MultiMeshInstance3D`

Total enemy visual nodes:

- `9`

Preserved shape-language identities:

- Chaser: triangular / pyramid-arrow threat.
- Tank: cube / square-frame heavy shape.
- Shooter: octahedron / diamond ranged shape.

Optimization result:

- Enemy visuals no longer scale node count linearly.
- Enemy transforms still animate individually through MultiMesh instance transforms.
- Enemy haze can be hidden in swarm mode before colored tubes or white cores are reduced.

## 6. XP Orb Optimization

XP count in optimized stress:

- `240` XP orb visuals.

XP node architecture:

- One halo batch.
- One white-hot core batch.
- One yellow annulus batch.
- One cyan inner-ring batch.
- One orbit-spark batch.

Total XP visual nodes:

- `5`

LOD behavior:

- Full quality: halo, core, yellow annulus, cyan inner ring, orbit spark.
- Medium quality: halo, core, yellow annulus, cyan inner ring.
- Swarm quality: halo, core, yellow annulus.

Optimization result:

- XP remains an energy pickup with white-hot core and plasma ring.
- Decorative spark/secondary ring detail degrades before the main pickup read.
- XP no longer creates one scene subtree per orb.

## 7. VFX/Spark Optimization

Spark/VFX stress count:

- `96` pooled sparks.

Previous architecture:

- `96` independent `MeshInstance3D` spark nodes.

Optimized architecture:

- One `MultiMeshInstance3D` spark pool.
- Individual spark transforms animate inside the pool.
- Swarm quality activates only half the spark transforms while preserving the burst read.

Projectile optimization:

- `60` projectiles are rendered through three batches:
  - Outer cyan plasma streaks.
  - White-hot inner cores.
  - Hot tip spheres.

No runaway VFX behavior was added. This is still a visual-only prototype.

## 8. LOD/Quality Scaling Rules

Quality mode is based on prototype visual load.

Current Phase 2.6 stress enters:

- `swarm` quality

Swarm-mode reduction order:

1. Reduce spark density first.
2. Hide XP orbit sparks.
3. Hide XP secondary cyan inner rings.
4. Hide enemy ghost haze.
5. Preserve enemy colored tube silhouettes.
6. Preserve enemy white-hot cores.
7. Preserve projectile outer/core readability.
8. Preserve player clarity.

This follows the project priority rule:

1. Player
2. Enemy danger
3. Projectiles
4. XP
5. Background

The pass does not optimize by collapsing the game back into weak outlines.

## 9. Stress Test Results Before/After

Phase 2.5 before optimization:

- Enemies: `75`
- XP orbs: `120`
- Projectiles: `18`
- Spark nodes: `96`
- Total visual nodes: `2730`
- 480-frame headless window: `3302 ms`
- Approximate headless ms/frame: `6.88`

Phase 2.6 after optimization:

- Enemies: `150`
- XP orbs: `240`
- Projectiles: `60`
- Spark pool: `96`
- Total visual nodes: `43`
- Quality mode: `swarm`
- 480-frame headless window: `3305 ms`
- Approximate headless ms/frame: `6.89`

Validation commands:

- `godot --headless --path . scenes/NeonSwarm3DVisualPrototype.tscn --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_phase26_3d_architecture_stress.gd`
- `godot --headless --path . --quit-after 3`

Results:

- Optimized prototype scene passed.
- Phase 2.6 architecture stress passed.
- Current 2D main scene still launches.

Interpretation:

- Node count is dramatically improved.
- The optimized prototype handles a stronger visual load with roughly the same headless frame-window time as Phase 2.5.
- Headless timing is not final renderer proof; live GPU/display review is still required.

## 10. Risks

- This is still not integrated with real gameplay.
- MultiMesh batching makes individual per-enemy material variation harder.
- Collision and gameplay remain outside this prototype.
- Transparent glow and bloom can still become expensive on a real renderer.
- Headless timing does not prove subjective readability, bloom quality, or GPU overdraw behavior.
- The optimized scene uses procedural mesh generation at startup; production should cache or prebuild resources if this path is adopted.
- A full migration could still create complexity around input, pause, level-up UI, camera framing, and 2D-to-3D coordinate mapping.

## 11. Files Changed

Changed:

- `scripts/NeonSwarm3DVisualPrototype.gd`

Previously created and still used:

- `scenes/NeonSwarm3DVisualPrototype.tscn`

Created:

- `docs/NEON_SWARM_PHASE_2_6_3D_VISUAL_ARCHITECTURE_OPTIMIZATION_REPORT.md`

Validation helper:

- `/tmp/neon_swarm_phase26_3d_architecture_stress.gd`

## 12. How To Run The Optimized Prototype

In Godot 4.6.3:

1. Open the Neon Swarm project.
2. Open `scenes/NeonSwarm3DVisualPrototype.tscn`.
3. Run that scene directly.
4. Do not run it as a replacement for `Main.tscn`.

Command-line scene smoke:

```bash
godot --headless --path . scenes/NeonSwarm3DVisualPrototype.tscn --quit-after 3000
```

Command-line architecture stress:

```bash
godot --headless --path . --script /tmp/neon_swarm_phase26_3d_architecture_stress.gd
```

## 13. Recommendation: Stay 2D, Hybridize, or Migrate

Recommendation: create a new 3D-on-2D branch/prototype or hybrid bridge next. Do not fully migrate the main game yet.

Reason:

- Phase 2.6 solves the biggest immediate architecture concern: visual node count.
- The optimized 3D approach is now plausible for swarm visualization.
- The hot neon tube / plasma target is better served by 3D emissive geometry than the current 2D draw stack.
- Manual live visual review is still required.
- Real gameplay integration remains unproven.

Decision gate:

- Stay 2D if live review shows the optimized 3D look is still not meaningfully better.
- Hybridize if player, XP, projectiles, or a few enemy visuals look clearly better in 3D while full migration remains risky.
- Create a new 3D-on-2D branch/prototype if live review approves the optimized architecture.
- Do not fully migrate until gameplay, UI, pause, controller, collision, and performance are proven in an integrated branch.

## 14. Approval Question

Is the optimized 3D-on-2D visual architecture strong and efficient enough to justify a new hybrid or 3D-on-2D branch prototype, or should Neon Swarm stay with the current 2D renderer and only borrow selected visual ideas from this experiment?
