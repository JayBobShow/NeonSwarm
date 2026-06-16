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

## 6. Approved Performance Guardrails

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

## 7. Files That Define The Current Approved Look

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

## 8. Do Not Change This Style Without User Approval

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
