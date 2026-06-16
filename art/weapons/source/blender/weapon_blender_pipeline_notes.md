# Phase 27 Repair Weapon Blender Pipeline Notes

## Purpose

The failed flat PNG weapon visuals are replaced where practical by real Blender-made 3D weapon/projectile/field models.

## Source / Export

Blender sources and runtime GLBs exist for:

- `pulse_blaster`
- `orbit_spark`
- `nova_burst`
- `arc_beam`
- `gravity_mine`
- `prism_lance`
- `ring_saw`
- `hex_shatter`
- `fractal_shard`
- `tri_burst_cannon`
- `hex_mortar`
- `vector_spear`
- `orbital_saw_array`
- `prism_chain`
- `gravity_well`
- `nova_needle`
- `fractal_bloom`
- `shield_breaker`
- `star_pulse`

Sources live in:

- `art/weapons/source/blender/{weapon_id}.blend`

Runtime exports live in:

- `art/weapons/exported/3d/{weapon_id}.glb`

## Icon From 3D Status

Blender rendered weapon-family icon PNGs from the 3D weapon models into:

- `art/weapons/icons/source/rendered_from_3d/`
- `art/weapons/icons/exported/`

The fallback unknown icon remains available for future missing family ids.

## Phase 27 Repair 2 Preview Pass

- Weapon-family preview PNGs were regenerated from the Blender weapon models where practical.
- Armory, stash, reward cards, replacement UI, comparison panels, and How To Play continue to use those exported PNGs through `NeonWeaponIcon`.
- Weapon gameplay numbers, cooldowns, projectile caps, and random stat math were not changed.

## Godot Integration

Projectile creation calls `_apply_weapon_projectile_blender_model()`.

Persistent or field-style visuals call `_add_weapon_blender_model()`.

Weapon damage, cooldowns, split counts, projectile caps, runtime loadout behavior, and random stat math were not changed.
