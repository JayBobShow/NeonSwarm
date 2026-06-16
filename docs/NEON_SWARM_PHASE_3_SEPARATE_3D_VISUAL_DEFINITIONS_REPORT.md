# Neon Swarm Phase 3 Separate 3D Visual Definitions Report

## 1. Executive Summary

The Phase 2.6B visual proof board was reviewed and found structurally insufficient as a visual asset scene.

The problem was not just visual quality. The proof board used one large procedural construction script to generate every object. That made the player, enemies, XP orb, and projectile too likely to share the same silhouette recipe: body, shell, edge tubes, core, spark ring, pulse.

Phase 3 corrects the architecture by creating separate 3D visual definitions for:

- Player3D
- Chaser3D
- Tank3D
- Shooter3D
- Exploder3D
- XPOrb3D
- Projectile3D

The main game was not migrated. Gameplay was not changed.

## 2. Review Of Previous Proof Board Script

Reviewed:

- `scripts/NeonSwarm3DVisualProofBoard.gd`

Finding:

- The old script extended the 3D stress prototype.
- It owned the proof-board environment, object layout, materials, meshes, animation arrays, sparks, trails, and all object construction.
- Every object was built through the same repeated procedural pattern.
- This made the proof board technically useful, but weak as art direction proof.

Rejected pattern:

- one all-in-one generator
- repeated shell/core/tube/spark construction
- object identity defined by function variants in one board script
- proof board scene as only a Node3D script shell

Accepted pattern:

- shared low-level mesh/material utilities only
- separate object scenes
- separate object scripts
- object-specific geometry, materials, silhouette, motion, and gameplay meaning
- proof board instances visual definitions instead of creating them all directly

## 3. Phase 3 Architecture Change

Created a shared low-level helper:

- `scripts/visuals/Neon3DVisualKit.gd`

This helper owns only reusable primitives:

- emissive materials
- plasma shell materials
- simple low-poly meshes
- tube-edge mesh construction
- labels
- pooled spark MultiMesh helpers

It does not decide enemy identity, pickup identity, projectile identity, or art direction.

The refactored proof board now preloads and instances separate scenes:

- `res://scenes/visuals/Player3D.tscn`
- `res://scenes/visuals/Chaser3D.tscn`
- `res://scenes/visuals/Tank3D.tscn`
- `res://scenes/visuals/Shooter3D.tscn`
- `res://scenes/visuals/Exploder3D.tscn`
- `res://scenes/visuals/XPOrb3D.tscn`
- `res://scenes/visuals/Projectile3D.tscn`

## 4. Separate Visual Definitions

Player3D:

- Primary shape: octahedron / diamond core
- Secondary shape: sphere reactor, torus shield rings, cyan/magenta plasma shell
- Motion: rotating shield assembly, orbiting ion sparks, breathing shells
- Meaning: player-owned combat core, highest screen priority

Chaser3D:

- Primary shape: tetrahedron / triangular pyramid needle
- Secondary shape: rear fins, nose core, rear wake
- Motion: sharp wobble, edge sparks, directional wake
- Meaning: fast aggressive contact threat

Tank3D:

- Primary shape: cuboid / rectangular prism
- Secondary shape: thick corner tubes, internal crossbars, corner pylons
- Motion: slow heavy rotation, subtle pylon pulse
- Meaning: durable heavy enemy

Shooter3D:

- Primary shape: hexagonal prism
- Secondary shape: forward aim spine, charged muzzle shell, focus ring
- Motion: charge pulse and muzzle sparks
- Meaning: ranged enemy with obvious firing direction

Exploder3D:

- Primary shape: sphere / unstable plasma orb
- Secondary shape: torus warning rings and radial spikes
- Motion: danger pulse, rotating warning rings, leaking ion sparks
- Meaning: volatile detonation threat

XPOrb3D:

- Primary shape: sphere energy pickup
- Secondary shape: cyan/gold torus rings and tiny sparkles
- Motion: bob, ring orbit, small sparkle motion
- Meaning: valuable collectible energy, lower priority than enemies

Projectile3D:

- Primary shape: capsule / energy bolt
- Secondary shape: white-hot needle core and ghost trail
- Motion: pulsing bolt haze and stacked trail
- Meaning: fast readable projectile energy

## 5. Geometry Art Director Notes

Geometry Art Director ruling for this pass:

- The old proof-board generator is rejected as the source of visual identity.
- The new separate definitions are approved as an architecture correction only.
- This is not visual approval for migration.
- The user must still manually review whether the objects look premium enough.

Shape Bible compliance:

- Player uses octahedron / diamond family.
- Chaser uses tetrahedron / triangular pyramid family.
- Tank uses cuboid / rectangular prism family.
- Shooter uses hexagonal prism family.
- Exploder uses sphere / torus family.
- XP uses sphere / torus pickup family.
- Projectile uses capsule / cylinder-bolt family.

## 6. Files Created

Visual helper:

- `scripts/visuals/Neon3DVisualKit.gd`

Visual scripts:

- `scripts/visuals/Player3D.gd`
- `scripts/visuals/Chaser3D.gd`
- `scripts/visuals/Tank3D.gd`
- `scripts/visuals/Shooter3D.gd`
- `scripts/visuals/Exploder3D.gd`
- `scripts/visuals/XPOrb3D.gd`
- `scripts/visuals/Projectile3D.gd`

Visual scenes:

- `scenes/visuals/Player3D.tscn`
- `scenes/visuals/Chaser3D.tscn`
- `scenes/visuals/Tank3D.tscn`
- `scenes/visuals/Shooter3D.tscn`
- `scenes/visuals/Exploder3D.tscn`
- `scenes/visuals/XPOrb3D.tscn`
- `scenes/visuals/Projectile3D.tscn`

Files changed:

- `scripts/NeonSwarm3DVisualProofBoard.gd`
- `docs/NEON_SWARM_PHASE_2_6B_VISUAL_PROOF_BOARD_REPORT.md`

## 7. Validation

Standalone visual scene validation passed:

```text
godot --headless --path . scenes/visuals/Player3D.tscn --quit-after 3
godot --headless --path . scenes/visuals/Chaser3D.tscn --quit-after 3
godot --headless --path . scenes/visuals/Tank3D.tscn --quit-after 3
godot --headless --path . scenes/visuals/Shooter3D.tscn --quit-after 3
godot --headless --path . scenes/visuals/Exploder3D.tscn --quit-after 3
godot --headless --path . scenes/visuals/XPOrb3D.tscn --quit-after 3
godot --headless --path . scenes/visuals/Projectile3D.tscn --quit-after 3
```

Refactored proof-board validation passed:

```text
godot --headless --path . scenes/NeonSwarm3DVisualProofBoard.tscn --quit-after 3
godot --headless --path . scenes/NeonSwarm3DVisualProofBoard.tscn --quit-after 3000
```

Proof-board runtime output:

```text
Neon Swarm Phase 3 visual definition proof board: separate_visual_scenes=7 review_objects=10 visual_nodes=122
```

## 8. How To View

Open the full review board:

```text
scenes/NeonSwarm3DVisualProofBoard.tscn
```

Open individual visual definitions:

```text
scenes/visuals/Player3D.tscn
scenes/visuals/Chaser3D.tscn
scenes/visuals/Tank3D.tscn
scenes/visuals/Shooter3D.tscn
scenes/visuals/Exploder3D.tscn
scenes/visuals/XPOrb3D.tscn
scenes/visuals/Projectile3D.tscn
```

## 9. Known Issues

- These are still procedural runtime visual definitions, not exported Blender assets.
- The `.tscn` files are lightweight scene roots backed by separate scripts.
- The objects still need manual visual approval.
- No full migration should happen from this pass alone.

## 10. Approval Question

Do the separate visual definitions solve the architecture problem enough to continue visual iteration object-by-object, or should any of the seven definitions be rejected and redesigned before further work?
