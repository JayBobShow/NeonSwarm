# Neon Swarm Phase 2.6B Visual Proof Board Report

Update:

This Phase 2.6B proof-board structure was later reviewed and found insufficient because the board generated all major objects through one large procedural script. Phase 3 separates the object identities into individual visual definitions. See:

- `docs/NEON_SWARM_PHASE_3_SEPARATE_3D_VISUAL_DEFINITIONS_REPORT.md`

## 1. Executive Summary

Phase 2.6B visual work is stopped behind a new visual proof gate.

Created an isolated proof-board scene:

- `scenes/NeonSwarm3DVisualProofBoard.tscn`

This scene does not replace the main game, does not migrate gameplay, and does not add gameplay content. It presents large review versions of the player, enemies, XP orb, projectile, nova ring, enemy death burst, and arena/grid sample so the art direction can be judged visually before any migration decision.

The proof board intentionally pushes beyond basic 3D primitives by layering:

- true 3D mesh bodies
- thick neon tube-edge geometry
- white-hot inner cores
- colored plasma shell shader materials
- bloom/glow environment settings
- ghost trails
- pooled spark samples
- animated pulse/rotation

This report does not claim visual approval. It asks for manual review.

## 2. Why Technical 3D Was Not Enough

The previous Phase 2.6B report proved the prototype used technical 3D shapes, but technical 3D is not the same as correct art direction.

The rejected state was:

- a 3D octahedron is not automatically a premium player core
- a cube is not automatically a strong tank visual
- a sphere and torus are not automatically neon plasma
- an emissive material alone can still look like a plain primitive
- technical compliance does not prove the object feels hot, alive, powerful, or arcade-premium

This proof board exists to make the art target visible before more implementation work continues.

## 3. Geometry Art Director Review

Geometry Art Director role used:

- `docs/NEON_SWARM_GEOMETRY_ART_DIRECTOR_ROLE.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`

Assigned workers:

- Shape Language Specialist: checked primary/secondary shape identity and gameplay meaning.
- 3D Form / Perspective Specialist: checked true 3D volume, silhouette, camera angle, and readability.
- Neon Material / Plasma Form Specialist: checked white-hot cores, colored neon tubes, plasma shells, haze, sparks, and trails.

Geometry Art Director ruling:

- The proof board is acceptable as a visual-review scene.
- The proof board is not approval for full 3D migration.
- Any object the user finds too primitive, flat, weak, or non-premium must be rejected and revised before migration.

## 4. Player Visual Review

Asset/Object Name: Player Core Visual

- Primary shape: Octahedron / diamond-like Platonic solid
- Secondary shape: Sphere core, torus shield rings, plasma shell
- Why the shape fits gameplay: A diamond/octahedron reads as a central combat core with sharp arcade energy.
- How it shows true 3D volume: Solid octahedron mesh, 3D tube edges, rotating tilted torus rings, transparent plasma shell.
- How it avoids flat wireframe/icon look: Uses a translucent 3D body plus thick cylindrical edge tubes instead of flat line drawing.
- White-hot core treatment: Central emissive white sphere and white-hot inner edge tubes.
- Colored neon/plasma treatment: Cyan/magenta thick tubes, cyan/magenta shell shader, bloom-heavy environment.
- Glow/haze treatment: Fresnel-style plasma shell and additive ghost trail.
- Particle/spark/trail treatment: Orbiting ion sparks and trailing light smear.
- Readability at gameplay scale: Intended to be brightest and most distinctive object.
- Performance risk: Moderate for hero object; acceptable because there is only one player.
- Approved or rejected: Approved for proof-board manual review only.

## 5. Enemy Visual Reviews

Asset/Object Name: Chaser Visual

- Primary shape: Tetrahedron / triangular pyramid
- Secondary shape: Nose core, rear plasma trail, edge sparks
- Why the shape fits gameplay: A forward-pointing tetrahedron reads as a fast sharp pursuit threat.
- How it shows true 3D volume: Four-sided solid tetrahedron mesh with visible depth and angled facets.
- How it avoids flat wireframe/icon look: Has a translucent body and thick neon tube edges rather than flat triangle lines.
- White-hot core treatment: Nose point white-hot core sphere and white inner edge tubes.
- Colored neon/plasma treatment: Green plasma body, green neon tubes, green edge spark shedding.
- Glow/haze treatment: Additive plasma shell material and rear ghost trail.
- Particle/spark/trail treatment: Edge sparks and trailing smear behind the threat direction.
- Readability at gameplay scale: Sharp silhouette should remain quick to identify.
- Performance risk: Low to moderate; enemy batches would need shared meshes/materials if migrated.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Tank Visual

- Primary shape: Cuboid / rectangular prism
- Secondary shape: Internal diagonal crossbars, center core, larger haze box
- Why the shape fits gameplay: A cuboid reads heavy, durable, and slower than sharp enemies.
- How it shows true 3D volume: Solid cuboid mesh, visible corner depth, tube edges on all 12 box edges.
- How it avoids flat wireframe/icon look: Uses translucent 3D volume and thick hot-tube construction rather than a flat square frame.
- White-hot core treatment: Center white-hot sphere and thin white edge cores.
- Colored neon/plasma treatment: Gold/orange neon corner tubes and internal energy crossbars.
- Glow/haze treatment: Soft rectangular plasma haze shell.
- Particle/spark/trail treatment: No heavy constant sparks; kept controlled to avoid tank clutter.
- Readability at gameplay scale: Smaller footprint than previous large square clutter; still reads as heavy.
- Performance risk: Moderate due edge count; must be batched if used in swarms.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Shooter Visual

- Primary shape: Octahedron / diamond
- Secondary shape: Forward capsule muzzle and charged muzzle plasma sphere
- Why the shape fits gameplay: Diamond/octahedron reads as a ranged energy node; muzzle marks firing direction.
- How it shows true 3D volume: Solid octahedron, 3D tube edges, protruding 3D muzzle.
- How it avoids flat wireframe/icon look: Adds glass body, tube geometry, and forward depth marker instead of a flat diamond icon.
- White-hot core treatment: White edge cores and white-hot muzzle bolt.
- Colored neon/plasma treatment: Violet plasma body and violet tubes.
- Glow/haze treatment: Cyan muzzle plasma shell.
- Particle/spark/trail treatment: Muzzle charge sparks.
- Readability at gameplay scale: Direction marker should distinguish it from tanks/chasers.
- Performance risk: Moderate; muzzle and sparks should be pooled or batched if migrated.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Exploder Visual

- Primary shape: Sphere / unstable plasma orb
- Secondary shape: Torus warning rings and radial spike rays
- Why the shape fits gameplay: A pulsing sphere/ring form reads unstable and dangerous before detonation.
- How it shows true 3D volume: 3D sphere mesh, crossing torus rings, radial spike tubes around volume.
- How it avoids flat wireframe/icon look: Uses layered sphere body, shell, and ring volumes instead of a flat circular outline.
- White-hot core treatment: Center white-hot sphere and white inner spike cores.
- Colored neon/plasma treatment: Red/orange warning rings, red plasma shell, orange leak accents.
- Glow/haze treatment: Pulsing red shell shader.
- Particle/spark/trail treatment: Orbiting red/orange ion sparks.
- Readability at gameplay scale: Strong red warning identity should stand apart from other enemies.
- Performance risk: Moderate; ring/spike detail should be reduced first under swarm load.
- Approved or rejected: Approved for proof-board manual review only.

## 6. XP/Projectile/VFX Reviews

Asset/Object Name: XP Orb Visual

- Primary shape: Sphere
- Secondary shape: Annulus/torus rings and orbiting spark points
- Why the shape fits gameplay: A small glowing orb reads as collectible energy reward.
- How it shows true 3D volume: Sphere body, shell, and rotating torus rings.
- How it avoids flat wireframe/icon look: Uses layered 3D orb volume instead of a 2D circle/token.
- White-hot core treatment: Small white-hot center sphere.
- Colored neon/plasma treatment: Yellow/gold orb with cyan/gold rings.
- Glow/haze treatment: Gold plasma shell shader with pulse.
- Particle/spark/trail treatment: Orbiting white/gold spark points.
- Readability at gameplay scale: Bright but smaller than enemies/player.
- Performance risk: High if every XP orb uses full detail; migration must use LOD/batching.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Projectile Visual

- Primary shape: Capsule / short cylinder bolt
- Secondary shape: White-hot inner needle and blue ghost trail
- Why the shape fits gameplay: A capsule bolt reads as fast laser energy.
- How it shows true 3D volume: 3D capsule meshes for body, haze, and inner core.
- How it avoids flat wireframe/icon look: Uses volume and layered bolt body instead of a line segment.
- White-hot core treatment: Thin white capsule core.
- Colored neon/plasma treatment: Cyan bolt body and blue plasma haze.
- Glow/haze treatment: Additive trail/haze capsule.
- Particle/spark/trail treatment: Short ghost trail.
- Readability at gameplay scale: Bright and simple; intended to stay above XP in priority.
- Performance risk: Moderate under projectile flood; should use MultiMesh batching.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Nova Ring Visual

- Primary shape: Torus / annulus shockwave
- Secondary shape: Radial rays and center flash
- Why the shape fits gameplay: Expanding ring clearly communicates radial burst.
- How it shows true 3D volume: 3D torus mesh lying on gameplay plane with visible tube thickness.
- How it avoids flat wireframe/icon look: Uses thick torus geometry, white-hot torus core, and radial 3D tube rays.
- White-hot core treatment: White-hot torus core and center flash.
- Colored neon/plasma treatment: Green/cyan shockwave haze.
- Glow/haze treatment: Pulsing additive torus material.
- Particle/spark/trail treatment: Radial ray tubes imply outward energy.
- Readability at gameplay scale: Large, brief, and high-priority; should not persist long.
- Performance risk: Low if short-lived and pooled.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Enemy Death Burst Sample

- Primary shape: Radial burst / sphere-origin spark explosion
- Secondary shape: Short torus glow ring and pooled capsule fragments
- Why the shape fits gameplay: A central pop with outward sparks communicates enemy destruction.
- How it shows true 3D volume: Spark fragments move in 3D directions from a center point.
- How it avoids flat wireframe/icon look: Uses 3D capsule fragments and a torus glow ring, not flat drawn streaks.
- White-hot core treatment: White-hot center pop.
- Colored neon/plasma treatment: Orange/gold spark fragments.
- Glow/haze treatment: Short glow ring.
- Particle/spark/trail treatment: 64 pooled spark fragments, animated and capped.
- Readability at gameplay scale: Should be satisfying but short enough not to hide enemies.
- Performance risk: Controlled by fixed pooled spark count.
- Approved or rejected: Approved for proof-board manual review only.

Asset/Object Name: Arena/Grid Sample

- Primary shape: Rectangle / square grid field
- Secondary shape: Thick border tube and dim blue grid lines
- Why the shape fits gameplay: Grid reinforces the 2D gameplay plane and arcade battlefield.
- How it shows true 3D volume: Border uses 3D tube geometry; camera angle shows floor perspective.
- How it avoids flat wireframe/icon look: Background is intentionally low priority; the border is tube geometry, not a flat UI box.
- White-hot core treatment: Thin white-hot border core.
- Colored neon/plasma treatment: Cyan border glow with dark blue/purple grid.
- Glow/haze treatment: World bloom and emissive grid materials.
- Particle/spark/trail treatment: None; background must stay quiet.
- Readability at gameplay scale: Background remains dim beneath gameplay objects.
- Performance risk: Low; grid is batched into a few mesh surfaces.
- Approved or rejected: Approved for proof-board manual review only.

## 7. Materials/Shaders Used

Runtime materials are procedural Godot resources:

- `StandardMaterial3D` unshaded emissive materials for white-hot cores, colored neon tubes, sparks, trails, grid, and border.
- Additive alpha blend for haze, trails, and glow surfaces.
- `ShaderMaterial` plasma shell shader using view-angle rim/fresnel-style intensity for lit-glass/gas-light shells.
- `Environment` glow/bloom enabled with a nearly black background.
- Thick 3D tube meshes are used for neon geometry edges, not flat 2D lines.

No imported sprite sheets, hand-painted assets, Moonbane assets, or copied Geometry Wars assets were used.

## 8. Tools Used

Used:

- Godot: scene creation, procedural meshes, emissive materials, shader material, bloom environment, animated proof-board layout.

Not used:

- Blender: not needed for this proof board because the required meshes were cleanly generated in Godot.
- Inkscape: not needed for this proof board.
- Krita: not used; no concept paintovers or sprite sheets created.

## 9. Performance Notes

Headless scene validation passed:

```text
godot --headless --path . scenes/NeonSwarm3DVisualProofBoard.tscn --quit-after 3
Result: visual_nodes=108
```

Longer headless validation passed:

```text
godot --headless --path . scenes/NeonSwarm3DVisualProofBoard.tscn --quit-after 3000
Result: visual_nodes=108
```

Proof-board performance guardrails:

- 108 total visual nodes in the review scene.
- 64 pooled death-burst spark fragments.
- Orbiting spark samples use `MultiMeshInstance3D`.
- No unbounded particle spawning.
- No gameplay migration.
- No swarm stress replacement.

Automated screenshot capture was attempted with a temporary Godot script, but headless mode returned an empty viewport texture from the dummy renderer. No screenshot was generated from headless mode.

## 10. How The User Should View The Proof Board

Open this scene in Godot:

```text
scenes/NeonSwarm3DVisualProofBoard.tscn
```

Or run:

```bash
godot --path . scenes/NeonSwarm3DVisualProofBoard.tscn
```

Manual review focus:

1. Player core: does it look like a premium neon plasma combat core, not a primitive octahedron?
2. Chaser: does the tetrahedron feel like a hot sharp energy threat?
3. Tank: does the cuboid feel heavy without becoming a plain box?
4. Shooter: does the octahedron/muzzle read as a ranged enemy?
5. Exploder: does the sphere/torus/radial form feel unstable and dangerous?
6. XP orb: does it look like a collectible energy reward, not a token?
7. Projectile: does it look like a 3D energy bolt, not a line segment?
8. Nova: does it look like a 3D shockwave ring?
9. Death burst: does it feel like a short plasma explosion?
10. Arena/grid: does it support the neon look without overpowering objects?

## 11. Approval Question

Does `scenes/NeonSwarm3DVisualProofBoard.tscn` visually prove the target direction strongly enough to continue refining the 3D-on-2D visual prototype, or should specific proof-board objects be rejected and revised first?
