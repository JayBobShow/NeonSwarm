# Neon Swarm Approved Visual Style Lock

## 1. Approved Visual Direction

Phase 5 Repair 1 is 100% approved as the official Neon Swarm visual baseline.

The approved direction is:

**TRUE 3D-ON-2D NEON SWARM GAMEPLAY with dark 3D body faces and bright neon tube edges.**

Gameplay objects must read as real 3D geometric forms. Their faces provide volume and silhouette; their edge tubes, seams, rings, and corner accents provide the premium neon arcade identity.

## 2. Approved Scene Path

The official playable scene is:

`scenes/Main.tscn`

The official launch command is:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

`project.godot` must keep F5 pointed at:

```ini
run/main_scene="res://scenes/Main.tscn"
```

Do not create or promote alternate playable scenes without explicit user approval.

Permanent official-build rule:

- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`

## 3. Approved Material Rule

Face materials must be darker than edge materials.

Approved material hierarchy:

1. Dark readable 3D faces/facets.
2. Bright emissive neon tube edges.
3. White-hot vertex, core, and corner accents.
4. Controlled local plasma haze.
5. Short-lived spark/VFX accents only where useful.

Objects must not look like matte plastic, cardboard, flat wireframe icons, or plain colored primitives.

## 4. Approved Glow Rule

Glow must come primarily from local neon edge tubes, rings, seams, projectile cores, and VFX bursts.

Do not use large global bloom increases to fake the look.

Approved glow behavior:

- Local neon edge glow.
- Hot glass tube outlines.
- White-hot corner/core accents.
- Controlled plasma haze that supports the geometry.
- No blurry global glow blobs.
- No screen-wide washout.

## 5. Approved Gameplay Rule

Gameplay remains 2D-on-plane.

Approved gameplay presentation:

- Visuals are true 3D geometric objects.
- Movement remains locked to the X/Z gameplay plane.
- Collision remains simple gameplay collision.
- Particles, glow, trails, and plasma are visual effects only.
- `scenes/Main.tscn` remains the official game scene.

Approved arena architecture presentation:

- 3D arena map pieces may use visual-only floor plates, border walls, rails, and background depth geometry.
- Authored Blender source plus GLB runtime kits are preferred for arena architecture when practical, especially for Level/Sector map construction.
- Gameplay remains authoritative on the existing flat plane unless a future phase explicitly approves collision changes.
- Decorative map architecture must not imply playable ramps, platforms, or paths that do not exist.
- Border walls and rails must clarify the playable arena boundary without blocking or hiding combat reads.

## 6. Permanent Blender Documentation-First Art Workflow Rule

Every Blender asset task must complete a documentation, reference, and virtual-role checklist before modeling, scripting, exporting, or integrating art. This is mandatory for all Blender work and especially for environment, arena, and hard-surface assets.

Before Blender work, Codex must:

1. Read the relevant official Blender Manual pages for the task.
2. Identify the Blender tools, modifiers, material workflows, export settings, and verification steps needed.
3. Review reputable tutorial/reference material for the target art style or technique.
4. Use references only for workflow learning, visual standards, vocabulary, and quality comparison.
5. Do not copy copyrighted models, textures, layouts, kitbash sets, or designs.
6. Explicitly delegate and record the required virtual art roles before implementation.
7. Verify the source asset in Blender and the imported GLB in Godot at the actual gameplay camera distance.
8. Reject or rework the asset internally if it only looks good in a report, isolated render, or asset-count validation, but does not read in gameplay.

Minimum official Blender documentation topics to check when relevant:

- Bevel modifier and bevel modeling.
- Weighted normals, custom normals, and face shading.
- Mesh editing and hard-surface panel construction.
- Principled BSDF and PBR material setup.
- Metallic, roughness, specular, alpha, and emission behavior.
- UVs, normal maps, and texture channel setup if textures are used.
- glTF / GLB import-export pipeline.
- Blender Python API when scripting asset generation.
- Scale, origin, transforms, hierarchy, and export correctness.

Official Blender documentation starting points:

- Bevel Modifier: https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/bevel.html
- Weighted Normal Modifier: https://docs.blender.org/manual/en/latest/modeling/modifiers/modify/weighted_normal.html
- Mesh Normals: https://docs.blender.org/manual/en/latest/modeling/meshes/editing/mesh/normals.html
- Principled BSDF: https://docs.blender.org/manual/en/latest/render/shader_nodes/shader/principled.html
- Materials: https://docs.blender.org/manual/en/latest/render/materials/index.html
- UVs: https://docs.blender.org/manual/en/latest/modeling/meshes/uv/index.html
- glTF 2.0 import/export: https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html
- Object origin: https://docs.blender.org/manual/en/latest/scene_layout/object/origin.html
- Object transforms: https://docs.blender.org/manual/en/latest/scene_layout/object/editing/transform/introduction.html
- Blender Python API: https://docs.blender.org/api/current/

For arena and environment art, Codex must also research:

- Modular sci-fi floor kit construction.
- Hard-surface paneling, trims, grooves, anchors, bevels, and readable thickness.
- Readable bevels and material contrast at the official top-down gameplay camera distance.
- Glass, prism, refraction, and transparent material workflows when making prism arenas.
- Neon channel integration as an accent, not as the only visible structure.
- Avoiding flat-grid, debug-board, random-strip, and glow-only visuals.
- Game readability from the top-down or orthographic-style combat camera.

Required virtual role delegation for Blender environment tasks:

1. Environment Art Director - defines the visual target, rejects weak flat/procedural-looking art, and confirms fit with Neon Swarm's style.
2. Blender Hard-Surface Environment Artist - builds the mesh, bevels, panels, seams, thickness, trim, rails, anchors, grooves, and readable depth.
3. Material / Lighting Artist - handles aluminum, gunmetal, glass, prism, neon, emission, roughness, metallic response, and avoids black-collapse or glow-only line art.
4. Godot Technical Artist - handles GLB integration, material overrides, lighting layers, bounds, performance, and runtime loading.
5. Gameplay Readability QA - tests in the official camera and confirms player, enemies, XP, bullets, events, ripple, and HUD remain readable.

Every future Blender art phase or hotfix final report must include:

- Official Blender docs/manual pages referenced.
- Outside tutorial/reference categories reviewed.
- What was learned from those references.
- Which virtual roles were delegated.
- What each role approved or rejected.
- Blender source path.
- GLB export path.
- In-game screenshot or manual test instructions.
- Whether the asset reads correctly at gameplay camera distance.
- Honest limitations and any unapproved visual risks.

Quality gate:

- A Blender environment asset is not approved because it has many objects, many panels, a GLB, passing validation, or updated docs.
- A Blender environment asset is acceptable only when it visually reads in the actual game as the requested environment.
- Sector 2 Prism Rift specifically must not continue as random neon line overlays or purple/magenta lines over black; it must eventually read as a fractured prism/glass sci-fi arena with visible floor material, readable modeled surface, and professional direction.

## 7. Approved Performance Guardrails

Preserve:

- Enemy caps.
- Projectile caps.
- XP caps.
- VFX/burst caps.
- Mine and beam caps.
- Shared meshes/materials where practical.
- Short-lived/self-cleaning VFX.
- Swarm readability and controller responsiveness.

If performance pressure rises, reduce decorative effects first. Do not reduce player readability, projectile readability, immediate threat readability, or the approved neon tube edge identity.

## 8. Files That Define The Current Approved Look

Primary approved look files:

- `scenes/Main.tscn`
- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/visuals/Neon3DVisualKit.gd`
- `scripts/visuals/Player3D.gd`
- `scripts/visuals/Chaser3D.gd`
- `scripts/visuals/Tank3D.gd`
- `scripts/visuals/Shooter3D.gd`
- `scripts/visuals/Exploder3D.gd`
- `scripts/visuals/XPOrb3D.gd`
- `scripts/visuals/Projectile3D.gd`
- `scripts/visuals/MiniBoss3D.gd`

Permanent geometry reference:

- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`

Permanent official build reference:

- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`

## 9. Do Not Change This Style Without User Approval

Do not change this approved visual style without explicit user approval.

Specifically, do not:

- Revert to flat line visuals.
- Revert to blurry glow blobs.
- Revert to matte plastic geometry.
- Revert to cardboard-looking shapes.
- Hide 3D form under bloom.
- Create alternate playable scenes.
- Revive archived prototypes as the active game.
- Replace `scenes/Main.tscn` as the official scene.
- Leave approved work in a side scene or hidden test scene.
- Write a report without the exact official run command.
- Write a report without confirming whether `scenes/Main.tscn` was updated.
