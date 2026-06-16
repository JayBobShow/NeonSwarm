# Phase 27 Repair Boss Blender Pipeline Notes

## Purpose

The failed flat PNG boss pass is replaced by real Blender-made 3D boss and mini-boss models.

## Source / Export

Blender sources:

- `art/bosses/source/blender/prism_warden.blend`
- `art/bosses/source/blender/null_octagon.blend`
- `art/bosses/source/blender/null_octagon_prime.blend`
- `art/bosses/source/blender/fractal_crown.blend`

Runtime GLBs:

- `art/bosses/exported/3d/prism_warden.glb`
- `art/bosses/exported/3d/null_octagon.glb`
- `art/bosses/exported/3d/null_octagon_prime.glb`
- `art/bosses/exported/3d/fractal_crown.glb`

## Model Design

- Prism Warden: octahedron/prism authority body, crown hex modules, command ring, violet/cyan tube edges.
- Null Octagon: black-glass octagonal body, cyan/magenta edge cages, void-ring accents.
- Null Octagon Prime: larger octagonal void command form with stronger magenta/cyan hierarchy.
- Fractal Crown: dark diamond core, stacked crown spikes, broken halo, cyan/magenta/orange tube language.

## Phase 27 Repair 2 Readability Pass

- Boss neon material emission was increased.
- Boss-scale readability frames were added:
  - Prism Warden: diamond authority route plus white inner route.
  - Null Octagon / Prime: octagonal route plus white inner route.
  - Fractal Crown: crown/diamond route plus white inner route.
- This is visual-only and does not change boss behavior, timing, HP, or attacks.

## Godot Integration

Boss enemy ids map through `_enemy_blender_asset_path()` to `art/bosses/exported/3d/`. Sector boss placement and behavior are unchanged.
