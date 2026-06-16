# Neon Swarm Geometry Shape-Language Bible

## Purpose

This document is the official geometry-shape reference for Neon Swarm.

Before adding any regular enemy, elite enemy, mini-boss, major boss, weapon, pickup, hazard, level theme, or visual style pass, check against this document.

Every enemy, boss, hazard, level, and pickup must have a clear primary geometry identity.

Neon Swarm uses original neon gas-light / plasma geometry. Gameplay objects must still use real collision shapes and clean gameplay logic. Particles, glow, trails, and plasma effects are visual presentation only.

The Geometry Art Director role is mandatory for all visual work. The role, authority, worker responsibilities, and required review format are defined in `docs/NEON_SWARM_GEOMETRY_ART_DIRECTOR_ROLE.md`.

## Permanent Shape-Language Rules

- Do not use random shapes.
- Do not use flat cardboard shapes.
- Do not use weak outline icons.
- Do not copy Geometry Wars assets, enemy designs, names, layouts, or copyrighted material.
- Do not use hand-painted sprite sheets.
- Do not use AI-generated character frames.
- Do not reuse Moonbane assets.
- Use procedural geometric shapes, particles, lines, glow, shaders, and draw calls.
- Build visual identity from white-hot cores, colored neon strokes, plasma bloom, edge sparks, motion trails, and readable silhouettes.
- A shape may have secondary detail, but it must still read from its primary geometry identity.
- Shape identity must remain readable during heavy enemy counts.
- Player readability has priority over all other visual elements.

## Shape Identity Requirement

Each new gameplay or visual element must define:

- Primary geometry identity
- Secondary geometry accents, if any
- Color identity
- Motion identity
- Threat or function read
- Collision shape strategy
- VFX behavior
- Readability priority

Example:

```text
Entity: Chaser
Primary geometry identity: Acute triangle / arrow
Secondary accents: Internal energy strokes and trailing spark fragments
Color identity: Cyan-green
Motion identity: Direct fast pursuit
Function read: Fast aggressive contact threat
Collision shape strategy: Simple collision shape matching gameplay footprint
VFX behavior: Leading-edge glow, edge spark shedding, color-matched death burst
Readability priority: Enemy danger
```

## Approved 2D Shape Vocabulary

### Triangles

- Equilateral Triangle
- Isosceles Triangle
- Scalene Triangle
- Right Triangle
- Obtuse Triangle
- Acute Triangle

### Quadrilaterals

- Square
- Rectangle
- Parallelogram
- Rhombus
- Trapezoid / Trapezium
- Kite
- Dart

### Other Polygons

- Pentagon
- Hexagon
- Heptagon
- Octagon
- Nonagon
- Decagon
- Hendecagon
- Dodecagon
- Icosagon
- Megagon

### Curved 2D Shapes

- Circle
- Ellipse
- Oval
- Semicircle
- Annulus / Ring
- Crescent
- Lune
- Sector
- Segment

## Approved 3D Shape Vocabulary

Neon Swarm is currently a 2D game, but 3D shape identities may be translated into 2D neon projections, holographic motifs, boss silhouettes, arena motifs, hazards, or UI/level themes.

### Platonic Solids

- Tetrahedron
- Cube / Hexahedron
- Octahedron
- Dodecahedron
- Icosahedron

### Prisms

- Triangular Prism
- Rectangular Prism / Cuboid
- Pentagonal Prism
- Hexagonal Prism
- Octagonal Prism

### Pyramids

- Triangular Pyramid
- Square Pyramid
- Pentagonal Pyramid
- Hexagonal Pyramid

### Curved 3D Shapes

- Sphere
- Hemisphere
- Cylinder
- Cone
- Torus / Donut
- Ellipsoid
- Spheroid

### Other 3D Shapes

- Frustum / Truncated Cone or Pyramid
- Prism
- Antiprism
- Bipyramid
- Cupola

## Special / Advanced Shape Vocabulary

These shapes may be used for advanced hazards, level themes, boss motifs, upgrade visuals, or late-game VFX only if they remain readable.

- Mobius Strip
- Klein Bottle
- Hyperboloid
- Paraboloid
- Helix
- Fractal Shapes
- Sierpinski Triangle
- Mandelbrot Set

## Neon Gas-Light Construction Rule

Do not draw a flat triangle, circle, diamond, or square and only add a glow behind it.

Approved visual baseline as of Phase 5 Repair 1:

- Dark 3D body faces show real volume.
- Bright neon tube edges define the arcade identity.
- White-hot corner/core accents reinforce important vertices and silhouettes.
- Local edge glow is preferred over blurry global bloom.

Build each important gameplay object as a layered energy object:

1. White-hot inner core line
2. Bright colored neon line
3. Soft outer glow
4. Small particle sparks around the edge
5. Motion trail or smear
6. Hit flash
7. Death, collection, or impact burst

The object should feel like it is made from hot neon gas, plasma, bloom, particles, and electric light.

## Current Phase 1 / Phase 2 Shape Assignments

These are the current baseline identities and should remain consistent unless deliberately revised in a future approved pass.

- Player: angular energy core with diamond/hex/ring plasma accents
- Chaser: acute triangle / arrow-like threat
- Tank: square / rectangle / box-ring structure
- Shooter: diamond / rhombus / hex energy frame
- Exploder: annulus / ring with radial warning spikes
- XP Orb: circle / annulus energy pickup with small spark accents
- Pulse Blaster projectile: line segment / laser streak with hot point core
- Orbit Spark: moving light node with arc/ring trail
- Nova Burst: expanding annulus / radial sector burst
- Arena border: rectangle with neon line-frame treatment
- Arena grid: square/rectangle grid field with blue/purple energy lines

## Visual Priority Rules

When the screen is busy, shape and light priority must remain:

1. Player
2. Enemy danger
3. Enemy bullets/projectiles
4. XP orbs
5. Background

Decorative details must degrade before gameplay readability.

## Performance Rules

- Do not solve shape identity by spawning unlimited particles.
- Cap decorative VFX.
- Pool or reuse effects when useful.
- Use draw-based glow and linework where cheaper than particle spam.
- Reduce non-critical spark/trail density under high enemy counts.
- Never degrade player readability.
- Never degrade enemy danger readability.
- Keep gameplay collision separate from visual plasma effects.

## Approval Checklist For New Shapes

Before any new element is accepted, answer:

1. What is its primary geometry identity?
2. Can the player identify it at gameplay speed?
3. Does it look like neon gas-light/plasma instead of cardboard or a UI icon?
4. Does it avoid copied Geometry Wars assets or enemy designs?
5. Does the collision shape remain simple and gameplay-driven?
6. Does it have a distinct color and motion identity?
7. Does it remain readable in a crowded arena?
8. Does it respect performance guardrails?

If any answer is no, the shape is not ready.
