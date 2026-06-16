# Neon Swarm Phase 2.6B: True 3D Geometric Neon Object Report

## 1. Executive Summary

Phase 2.6B rebuilds the isolated 3D visual prototype so important objects are actual 3D geometric bodies instead of flat line symbols or wireframe icons.

The main game was not migrated. `Main.tscn` was not replaced. The current 2D version remains intact.

Core result:

- Player is now an octahedron-style 3D neon combat core with shell, rings, white-hot center, and trail.
- Enemies now use solid low-poly 3D bodies:
  - Chaser: tetrahedron / triangular pyramid form.
  - Tank: cuboid / cube block form.
  - Shooter: octahedron / diamond body with muzzle accent.
  - Exploder: sphere body with torus warning ring.
- XP pickups are small 3D sphere/torus energy objects.
- Projectiles are 3D capsule-like energy bolts with body, core, and trail batches.
- Spark/VFX and nova samples remain pooled/batched.
- Performance architecture remains controlled through shared meshes, shared materials, and MultiMesh batching.
- Geometry Art Director review is now mandatory and has been added to this report.

This pass is not approval for full migration.

## 2. Why Phase 2.6A Was Rejected

Phase 2.6A improved hierarchy and composition, but the visuals still read too much like thin 2D line drawings.

Rejected issues:

- Enemy visuals still looked like wireframe icons.
- The shape language felt flat even when technically 3D-positioned.
- Projectiles still risked reading as line segments.
- The player was not yet a convincing 3D object.
- The prototype needed actual geometric volume, not just batched tube/edge outlines.

Phase 2.6B addresses that by making the core body of each object a solid/simple 3D mesh.

## 3. True 3D Visual Direction

The new visual direction uses:

- Solid low-poly 3D forms.
- Emissive colored body materials.
- White-hot core accents.
- Transparent plasma shell layers.
- Rotating torus/ring elements.
- Capped spark sphere batches.
- A 3D expanding torus nova sample.
- Dark low-priority grid battlefield.
- Fixed angled top-down camera.

Gameplay remains conceptually locked to the X/Z plane.

## 4. Tools Used

Used:

- Godot: procedural meshes, materials, environment glow, MultiMesh batching, scene validation, stress validation.

Not used:

- Blender: not needed for this pass because the required low-poly shapes were generated procedurally in Godot.
- Inkscape: not needed.
- Krita: not needed.

Reason: using Godot procedural meshes avoided imported asset clutter and kept the prototype clean, reusable, and performance-safe.

## 5. Player 3D Object Design

Player treatment:

- Primary body: solid octahedron-style 3D mesh.
- Secondary shapes: transparent sphere shell and two torus shield rings.
- White-hot center: enlarged emissive sphere core.
- Color identity: cyan/magenta, separate from common enemy colors.
- Trail: fixed-count ghost trail tubes.
- Movement plane: X/Z plane only.

Why it reads as 3D:

- The body is a filled 3D octahedron mesh, not a line outline.
- The camera angle exposes volume.
- The torus rings rotate around the body.
- The center core is a 3D sphere, not a 2D dot.

## 6. Enemy 3D Object Designs

Chaser:

- Primary shape: tetrahedron / triangular pyramid.
- Secondary shape: transparent scaled shell.
- Gameplay meaning: sharp fast contact threat.
- 3D read: pointed volumetric triangular pyramid body.
- Avoids flat icon look by using filled triangular faces, not triangle linework.

Tank:

- Primary shape: cube / cuboid.
- Secondary shape: transparent block shell and white-hot center.
- Gameplay meaning: heavier durable enemy.
- 3D read: solid block volume with visible depth from the camera angle.
- Avoids flat square icon look by using a cuboid mesh, not square wireframe.

Shooter:

- Primary shape: octahedron / diamond.
- Secondary shape: muzzle capsule accent.
- Gameplay meaning: ranged enemy with firing direction.
- 3D read: solid diamond body plus forward 3D muzzle.
- Avoids flat diamond icon look by using an octahedron mesh and a directional capsule accent.

Exploder:

- Primary shape: sphere.
- Secondary shape: torus warning ring.
- Gameplay meaning: unstable danger object.
- 3D read: pulsing spherical body and rotating 3D torus.
- Avoids flat ring icon look by using a solid orb plus volumetric ring accent.

Shared enemy treatment:

- Solid emissive body.
- Transparent plasma shell.
- White-hot core.
- Near/far brightness tiers.
- Swarm mode keeps bodies/cores readable while reducing far shell visibility.

## 7. XP 3D Object Design

XP pickup treatment:

- Primary shape: small 3D sphere.
- Secondary shape: rotating torus ring.
- Shell: transparent yellow/gold plasma sphere.
- Core: emissive yellow energy body.
- Spark: pooled small white spark batch.

Why it reads as 3D:

- XP has actual spherical volume.
- The ring is a 3D torus, not a flat 2D circle.
- The object bobs and rotates, exposing depth.

XP remains lower priority than player, projectiles, and enemies.

## 8. Projectile/VFX 3D Design

Projectile treatment:

- Primary shape: capsule-like 3D energy bolt.
- Body: cyan emissive capsule mesh.
- Core: smaller white-hot capsule mesh.
- Trail: transparent capsule trail batch.

VFX treatment:

- Spark burst: pooled `MultiMeshInstance3D` of small glowing spheres.
- Nova sample: animated expanding 3D torus on the X/Z gameplay plane.

Why it reads as 3D:

- Projectiles have capsule volume instead of being rendered as flat line segments.
- Nova is a torus mesh, not a 2D arc.
- Sparks are small 3D spheres in a pooled burst.

## 9. Materials/Shaders Created

Reusable Godot materials created in `scripts/NeonSwarm3DVisualPrototype.gd`:

- White-hot core material.
- Soft white core material.
- Cyan player body material.
- Cyan player plasma shell material.
- Magenta player ring material.
- Chaser near/far emissive materials.
- Tank near/far emissive materials.
- Shooter near/far emissive materials.
- Exploder near/far emissive materials.
- XP core/shell/cyan ring materials.
- Projectile body/core/trail materials.
- Spark VFX material.
- Nova torus material.
- Dim grid and border materials.

Material approach:

- `StandardMaterial3D`
- Unshaded emission.
- Additive transparent plasma shells where appropriate.
- Shared materials reused across batches.

No imported shader assets were added.

## 10. Shape Bible Compliance

The pass uses [NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md](/home/jason/GodotProjects/NeonSwarm/docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md:1).

Shape mapping:

- Player: octahedron / sphere / torus.
- Chaser: tetrahedron / triangular pyramid.
- Tank: cube / cuboid.
- Shooter: octahedron / diamond.
- Exploder: sphere / torus.
- XP: sphere / torus.
- Projectile: capsule/cylinder-like energy bolt.
- Nova: torus.
- Arena: rectangular grid and border.

Every important object now has a primary 3D shape identity.

## 10A. Geometry Art Director Review

The Geometry Art Director role is mandatory from this point forward. This Phase 2.6B review uses:

- [NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md](/home/jason/GodotProjects/NeonSwarm/docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md:1)
- [NEON_SWARM_GEOMETRY_ART_DIRECTOR_ROLE.md](/home/jason/GodotProjects/NeonSwarm/docs/NEON_SWARM_GEOMETRY_ART_DIRECTOR_ROLE.md:1)

Geometry Art Director workers assigned:

- Shape Language Specialist: checked shape-to-gameplay meaning and shape-bible fit.
- 3D Form / Perspective Specialist: checked true 3D form, camera angle, perspective, volume, and silhouette.
- Neon Material / Plasma Form Specialist: checked emissive body, white-hot core, shell/haze, spark/trail/VFX treatment, and material fit.

Geometry Art Director Review:

* Asset/Object Name: Player True 3D Neon Core
* Gameplay Role: Player avatar / highest-priority readable object
* Primary Shape: Octahedron
* Secondary Shape: Sphere core, transparent sphere shell, torus shield rings
* Shape Family: Platonic solid / curved solids
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Octahedron gives the player a sharp energy-core identity without matching common enemy shapes.
* How the 3D volume is shown: Filled octahedron body, sphere core, torus rings, angled orthographic camera, and rotation expose volume.
* How perspective is handled: Fixed angled top-down orthographic camera shows depth while preserving X/Z-plane readability.
* How silhouette remains readable: Large center core, unique cyan/magenta identity, and ring shell separate it from enemies.
* Neon/plasma material treatment: Cyan emissive body, magenta ring, transparent plasma shell, white-hot core.
* Particle/spark/trail treatment: Fixed-count ghost trail tubes; no unbounded particles.
* Performance risk: Low; player is a small dedicated node cluster and not multiplied.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Chaser Enemy Visual
* Gameplay Role: Fast contact threat
* Primary Shape: Tetrahedron / triangular pyramid
* Secondary Shape: Transparent scaled shell, white-hot core
* Shape Family: Platonic solid / pyramid
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Pointed triangular volume communicates speed, aggression, and direct pursuit.
* How the 3D volume is shown: Filled triangular faces form a pyramid-like body rather than a flat triangle outline.
* How perspective is handled: Rotation and angled camera reveal the body faces from top-down gameplay distance.
* How silhouette remains readable: Sharp forward point and compact triangular mass remain distinct from cuboids, octahedrons, and spheres.
* Neon/plasma material treatment: Green emissive near/far body materials, transparent green shell, white-hot core.
* Particle/spark/trail treatment: Current prototype uses shared shell/core and pooled global sparks; future gameplay hookup should add short directionally trailing sparks.
* Performance risk: Low; chasers render through shared MultiMesh batches.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Tank Enemy Visual
* Gameplay Role: Heavy durable enemy
* Primary Shape: Cube / cuboid
* Secondary Shape: Transparent cuboid shell, white-hot center
* Shape Family: Platonic solid / prism / cuboid
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Blocky volume communicates weight, durability, and slower pressure.
* How the 3D volume is shown: Solid cuboid body with visible depth and face volume, not square wireframe.
* How perspective is handled: Slight top-down camera angle exposes top and side proportions.
* How silhouette remains readable: Reduced footprint prevents square piles; compact block silhouette still reads as heavy.
* Neon/plasma material treatment: Orange emissive body, transparent orange shell, white-hot core.
* Particle/spark/trail treatment: Current prototype uses shared shell/core and pooled global sparks; future gameplay hookup should use brief impact flashes rather than persistent debris.
* Performance risk: Low; tanks render through shared MultiMesh batches.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Shooter Enemy Visual
* Gameplay Role: Ranged threat
* Primary Shape: Octahedron / diamond
* Secondary Shape: Capsule muzzle accent, transparent plasma shell
* Shape Family: Platonic solid / diamond-like form
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Diamond/octahedron form reads as precise and directional; muzzle accent communicates ranged behavior.
* How the 3D volume is shown: Filled octahedron faces and a 3D capsule muzzle replace flat diamond linework.
* How perspective is handled: Rotation plus angled orthographic view expose top/side facets.
* How silhouette remains readable: Diamond body and forward muzzle remain distinct from chaser pyramid and tank cuboid.
* Neon/plasma material treatment: Violet emissive body, transparent violet shell, white-hot muzzle/core.
* Particle/spark/trail treatment: Current prototype uses muzzle geometry and pooled sparks; future gameplay hookup should add short muzzle charge flash.
* Performance risk: Low; shooter body, shell, core, and muzzle use shared MultiMesh batches.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Exploder Enemy Visual
* Gameplay Role: Unstable proximity/detonation threat
* Primary Shape: Sphere
* Secondary Shape: Torus warning ring, transparent plasma shell
* Shape Family: Curved 3D solids
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Pulsing orb and torus ring communicate unstable stored energy and explosion warning.
* How the 3D volume is shown: Solid sphere body, scaled shell, and rotating torus exist in 3D space.
* How perspective is handled: Sphere remains readable from any top-down angle; torus is rotated on the gameplay plane.
* How silhouette remains readable: Rounded danger profile and red/orange color separate it from angular enemies.
* Neon/plasma material treatment: Red/orange emissive body, transparent danger shell, white-hot core, torus warning material.
* Particle/spark/trail treatment: Current prototype uses pooled sparks and animated torus warning; future gameplay hookup should trigger short burst on detonation.
* Performance risk: Low; body/shell/core/ring are shared batches.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: XP Energy Pickup
* Gameplay Role: Collectible reward / progression pickup
* Primary Shape: Sphere
* Secondary Shape: Torus ring, transparent shell, small spark
* Shape Family: Curved 3D solids
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Small glowing orb reads as collectible energy and avoids enemy-like angular threat language.
* How the 3D volume is shown: Spherical body/shell and rotating torus show volume and depth.
* How perspective is handled: Bobbing and rotation make depth visible from the fixed camera.
* How silhouette remains readable: Small gold/yellow orb and ring stay below enemy and projectile priority.
* Neon/plasma material treatment: Yellow/gold emissive body, transparent shell, cyan torus accent.
* Particle/spark/trail treatment: Pooled orbit spark batch; future collection stream should pull small particles into player.
* Performance risk: Low; 240 XP visuals use four shared MultiMesh batches.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Projectile Energy Bolt
* Gameplay Role: Weapon/projectile readability
* Primary Shape: Capsule / cylinder-like bolt
* Secondary Shape: White-hot capsule core, transparent capsule trail
* Shape Family: Curved 3D solids
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Capsule bolt gives forward motion and energy direction without reading as a flat line segment.
* How the 3D volume is shown: Body, core, and trail are capsule meshes oriented in travel direction.
* How perspective is handled: `_basis_from_y_axis` aligns capsule length to projectile direction on X/Z plane.
* How silhouette remains readable: Bright cyan/white bolt remains thinner and brighter than enemies.
* Neon/plasma material treatment: Cyan emissive body, white-hot core, transparent plasma trail.
* Particle/spark/trail treatment: Trail batch follows each bolt; future impacts should use pooled spark bursts.
* Performance risk: Low; 60 projectiles use three shared MultiMesh batches.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Arena / Grid Battlefield
* Gameplay Role: Level theme / spatial orientation background
* Primary Shape: Rectangle / square grid
* Secondary Shape: Rectangular border, axis lines
* Shape Family: 2D polygons projected in 3D scene space
* 2D or 3D Form: 2D plane inside 3D presentation
* Why this shape fits the gameplay: Grid and rectangular border define the flat X/Z gameplay plane without implying free 3D movement.
* How the 3D volume is shown: The floor itself is intentionally flat; perspective is shown through angled camera projection and 3D objects above it.
* How perspective is handled: Fixed angled top-down orthographic camera keeps grid perspective consistent and low priority.
* How silhouette remains readable: Grid is dim and behind gameplay objects.
* Neon/plasma material treatment: Dim blue/purple emissive lines and subdued cyan border.
* Particle/spark/trail treatment: None; grid must remain background.
* Performance risk: Low; grid/border use a small fixed node count.
* Shape Bible compliance: Compliant as a level/theme plane.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Pooled Spark Burst VFX
* Gameplay Role: Impact/death/energy burst sample
* Primary Shape: Small spheres
* Secondary Shape: Radial burst motion
* Shape Family: Curved 3D solids
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Small sphere sparks read as energy fragments without becoming new gameplay entities.
* How the 3D volume is shown: Spark particles are sphere meshes in 3D positions.
* How perspective is handled: Sparks spread in 3D around a fixed burst center while staying visual-only.
* How silhouette remains readable: Sparks are small and capped; they do not override player/projectile/enemy readability.
* Neon/plasma material treatment: Yellow/orange emissive material with additive transparency.
* Particle/spark/trail treatment: Pooled MultiMesh spark transforms; no unbounded spawning.
* Performance risk: Low; one MultiMesh batch.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

Geometry Art Director Review:

* Asset/Object Name: Nova 3D Expanding Torus Sample
* Gameplay Role: Major radial shockwave VFX sample
* Primary Shape: Torus
* Secondary Shape: Expanding scale on X/Z plane
* Shape Family: Curved 3D solids
* 2D or 3D Form: True 3D form
* Why this shape fits the gameplay: Torus communicates a radial energy shockwave while remaining locked to the 2D gameplay plane.
* How the 3D volume is shown: The shockwave is a torus mesh, not a flat 2D ring.
* How perspective is handled: Torus is rotated onto the X/Z plane and viewed from the fixed angled camera.
* How silhouette remains readable: It is short-lived and centered away from constant enemy reads in the prototype.
* Neon/plasma material treatment: Green/cyan emissive transparent torus material.
* Particle/spark/trail treatment: Expanding ring sample; future gameplay hookup should pair it with capped sparks.
* Performance risk: Low; one MeshInstance3D sample.
* Shape Bible compliance: Compliant.
* Approved / Rejected: Approved for isolated prototype review; not approved for full migration.
* If rejected, exact reason: N/A

## 11. Performance Results

Validation commands:

- `godot --headless --path . scenes/NeonSwarm3DVisualPrototype.tscn --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_phase26_3d_architecture_stress.gd`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . --script /tmp/neon_swarm_controller_support_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_true_pause_smoke.gd`
- `godot --headless --path . --script /tmp/neon_swarm_xp_collection_smoke.gd`

All passed.

Main game regression:

- Main scene still launches.
- Controller smoke passed.
- True pause smoke passed.
- XP collection smoke passed.

## 12. Stress Test Results

Stress load:

- Enemies: `150`
- XP orbs: `240`
- Projectiles: `60`
- Spark pool: `96`

Stress output:

- Total visual nodes: `60`
- Player visual nodes: `7`
- Enemy visual nodes: `28`
- XP visual nodes: `4`
- Projectile visual nodes: `3`
- Spark/VFX nodes: `2`
- Arena/grid nodes: `6`
- Lighting/camera/world nodes: `2`
- Quality mode: `swarm`
- 480-frame headless window: `3305 ms`
- Approximate headless ms/frame: `6.89`
- Result: passed

Interpretation:

- True 3D body treatment increased node count from Phase 2.6A, but stayed controlled.
- The prototype remains far below the rejected Phase 2.5 node count of `2730`.
- Headless timing is stable, but live renderer review is still required.

## 13. Files Created/Changed

Changed:

- `scripts/NeonSwarm3DVisualPrototype.gd`

Created:

- `docs/NEON_SWARM_PHASE_2_6B_TRUE_3D_GEOMETRIC_NEON_OBJECT_REPORT.md`
- `docs/NEON_SWARM_GEOMETRY_ART_DIRECTOR_ROLE.md`

Updated:

- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_PHASE_2_6B_TRUE_3D_GEOMETRIC_NEON_OBJECT_REPORT.md`

Existing scene still used:

- `scenes/NeonSwarm3DVisualPrototype.tscn`

Stress helper reused:

- `/tmp/neon_swarm_phase26_3d_architecture_stress.gd`

## 14. How The User Should Test It

1. Open `scenes/NeonSwarm3DVisualPrototype.tscn`.
2. Run the scene directly.
3. Confirm the player reads as a real 3D neon core, not a 2D symbol.
4. Confirm chasers look like triangular pyramid/tetrahedron threats.
5. Confirm tanks look like solid cuboid/block enemies, not square wireframes.
6. Confirm shooters look like 3D diamond/octahedron bodies with firing direction.
7. Confirm exploders look like unstable orb/torus plasma objects.
8. Confirm XP orbs look like valuable 3D energy pickups.
9. Confirm projectiles look like 3D energy bolts, not line segments.
10. Confirm the camera shows depth while preserving top-down readability.
11. Confirm performance remains acceptable under the visual stress load.

Self-check:

1. Are the shapes actual 3D objects?
   - Code-side answer: yes. Important visuals now use solid mesh bodies.
2. Does the player read as a 3D neon core?
   - Code-side answer: yes. It uses an octahedron body, sphere core, torus rings, and plasma shell.
3. Do enemies look like 3D geometric bodies, not wireframe icons?
   - Code-side answer: yes. Enemies use tetrahedron, cuboid, octahedron, sphere, and torus meshes.
4. Do XP orbs look like 3D energy pickups?
   - Code-side answer: yes. XP uses sphere body, shell, and torus ring.
5. Do projectiles look like energy bolts, not line segments?
   - Code-side answer: yes. Projectiles use capsule mesh bodies/cores/trails.
6. Does the camera show depth without harming gameplay readability?
   - Code-side answer: yes. It remains fixed angled top-down and orthographic.
7. Does it still run well under stress?
   - Automated answer: yes. Stress passed with 60 visual nodes and 3305 ms for 480 headless frames.
8. Does this finally look closer to the intended neon geometric arcade game?
   - Headless tests cannot prove subjective art approval. Manual review is required.

## 15. Known Issues

- This is still an isolated visual prototype, not gameplay migration.
- Headless tests cannot prove live bloom, depth, or subjective art quality.
- MultiMesh batching limits per-instance material variation.
- The prototype does not yet integrate hit flash, death burst, or collection stream with real gameplay events.
- The nova is a visual sample, not hooked to gameplay logic.
- No full migration is approved.

## 16. Approval Question

Does Phase 2.6B now meet the requirement for actual 3D geometric neon objects strongly enough to justify a hybrid gameplay-visual bridge prototype, or should another isolated visual pass focus on player, enemies, XP, projectiles, VFX, or camera depth before any migration work begins?
