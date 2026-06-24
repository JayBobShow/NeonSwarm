---
name: blender-game-asset
description: Use for Neon Swarm Blender source assets, GLB exports, modeled gameplay objects, arena kits, boss geometry, props, materials, scale, naming, and Godot import expectations.
---

# Blender Game Asset

Use this skill when creating or editing real 3D assets for Neon Swarm.

## Required Project Context

Read before modeling or exporting:

- `AGENTS.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_REFERENCE_IMAGE_RULES.md`
- Relevant sector, enemy, boss, weapon, or arena docs

## Blender Documentation Rule

Before Blender work, consult official Blender documentation for the tools used.
Do not guess export, material, modifier, normal, or transform behavior.

Common official starting points:

- Bevel Modifier: `https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/bevel.html`
- Weighted Normal Modifier: `https://docs.blender.org/manual/en/latest/modeling/modifiers/modify/weighted_normal.html`
- Mesh normals: `https://docs.blender.org/manual/en/latest/modeling/meshes/editing/mesh/normals.html`
- Principled BSDF: `https://docs.blender.org/manual/en/latest/render/shader_nodes/shader/principled.html`
- Materials: `https://docs.blender.org/manual/en/latest/render/materials/index.html`
- UVs: `https://docs.blender.org/manual/en/latest/modeling/meshes/uv/index.html`
- glTF / GLB import-export: `https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html`
- Object origins and transforms:
  `https://docs.blender.org/manual/en/latest/scene_layout/object/`
- Blender Python API: `https://docs.blender.org/api/current/`

## Asset Requirements

For requested gameplay-ready 3D objects, create or update:

- Blender source `.blend`.
- Runtime `.glb` export.
- Clear object names.
- Clear material names.
- Sane scale relative to current gameplay objects.
- Correct origin and transforms.
- Applied transforms when appropriate for export.
- Dark face materials and bright readable neon edge/accent materials.
- Collision expectations documented if the asset is visual-only or gameplay
  collision is separate.

## Neon Swarm Style Rules

- Build real 3D geometric forms, not flat placeholders.
- Dark body faces must remain visible.
- Neon edges should clarify silhouette, seams, and important contours.
- Avoid muddy glow, random line overlays, and black-collapse floors.
- Make assets readable at gameplay camera distance.
- Do not copy third-party protected designs, models, textures, layouts, logos,
  or exact compositions.

## Godot Export Expectations

When exporting GLB:

- Preserve clear hierarchy and names.
- Keep transforms predictable.
- Use material settings that import cleanly into Godot.
- Avoid unnecessary hidden objects, cameras, lights, or unused high-poly debris
  unless intentionally included.
- Report source and export paths.
- Verify the GLB imports and reads in the official build context when integration
  is part of the task.

## Validation

Before closeout, verify:

- `.blend` opens and contains expected named objects/materials.
- `.glb` exists and has expected objects/materials.
- Scale, origin, and transforms are sane.
- Asset reads at gameplay camera distance.
- The asset does not harm player, enemy, projectile, XP, boss, or HUD
  readability.

Report Blender docs consulted, source path, export path, validation commands,
known limitations, and whether Godot files were changed.
