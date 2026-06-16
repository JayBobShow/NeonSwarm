# Neon Swarm Weapon Rarity And Stat Rolls

## 1. Purpose

This document describes the weapon rarity, random stat, and modifier foundation through Phase 23.

The system is intentionally conservative. It is designed to prove the architecture without destabilizing the current sector run.

## 2. Implemented Rarity Tiers

| Tier | Role | Roll Count | Strength | Modifier Chance | Drop Weight | Accent |
| --- | --- | --- | --- | --- | --- | --- |
| Common | Baseline generated loot. | 1 | Low | 0%, 0 modifiers | Highest | Cyan |
| Uncommon | Slightly improved loot. | 1-2 | Modest | 14%, up to 1 modifier | High | Green |
| Rare | Stronger but still safe loot. | 2 | Normal | 34%, up to 1 modifier | Medium | Blue |
| Epic | Build-shaping loot. | 2-3 | Elevated | 62%, 1-2 modifiers | Low | Violet |
| Legendary | High-value curated loot. | 3 | High | 86%, 1-2 modifiers | Very low | Gold |
| Anomaly | Rare experimental tier. | 3-4 | Highest | 100%, 2-3 modifiers | Extremely low | Orange |

Drop weights are defined in:

- `scripts/content/NeonWeaponCatalog.gd`

Sector index gives a small high-tier weighting bonus, but the system remains conservative.

## 3. Implemented Stat Roll Types

Implemented stat ids:

- `damage_bonus`
- `fire_rate_bonus`
- `cooldown_reduction`
- `projectile_speed_bonus`
- `lifetime_bonus`
- `projectile_count_bonus`
- `pierce_bonus`
- `split_count_bonus`
- `orbit_count_bonus`
- `range_bonus`
- `chain_count_bonus`
- `pickup_bonus`
- `ricochet_bonus`

Not all stats apply to every weapon. Each weapon definition declares its own allowed stat pool.

## 4. Connected Runtime Effects

Connected:

- Pulse Blaster: damage, fire rate, cooldown, speed, lifetime, projectile count.
- Orbit Spark: damage, pulse rate, orbit count, radius.
- Nova Burst: damage, cooldown, radius.
- Arc Beam: damage, fire rate, cooldown, range, chain count.
- Gravity Mine: damage, cooldown, radius, lifetime.
- Prism Lance: damage, fire rate, cooldown, speed, lifetime, pierce.
- Ring Saw: damage, cooldown, spin/rate, radius.
- Hex Shatter: damage, cooldown, speed, lifetime, split count.
- Fractal Shard: damage, cooldown, speed, lifetime, pierce, split count.
- Tri-Burst Cannon: damage, fire rate, cooldown, speed, lifetime, projectile count.
- Hex Mortar: damage, cooldown, speed, lifetime, split count.
- Vector Spear: damage, fire rate, cooldown, speed, lifetime, pierce, safe ricochet.
- Orbital Saw Array: damage, pulse rate, orbit count, radius.
- Prism Chain: damage, fire rate, cooldown, range, chain count.
- Gravity Well: damage, cooldown, radius, lifetime.
- Nova Needle: damage, fire rate, cooldown, speed, lifetime, projectile count, safe ricochet.
- Fractal Bloom: damage, cooldown, speed, lifetime, split count.
- Shield Breaker: damage, cooldown, speed, lifetime, pierce.
- Star Pulse: damage, cooldown, radius.

The generated stat layer stacks on top of existing upgrade variables, but uses hard clamps.

## 5. Modifier Rolls

Current modifier pool:

- Split Shot
- Piercing
- Ricochet
- Chain
- Overclocked
- Heavy Core
- Lightweight
- Magnetized
- Wide Pattern
- Focused Beam
- Volatile
- Twin Orbit
- Shard Bloom
- Critical Geometry
- Sector-Tuned

Modifiers remain bounded stat bundles, with practical runtime hooks where the current weapon family supports the affected stat. Deep unique affixes are still planned for later phases.

## 6. Balance Limits

Current runtime clamps:

- Weapon damage multiplier from loot is clamped.
- Weapon rate multiplier from loot is clamped.
- Cooldown reduction cannot push cooldown below the safe multiplier floor.
- Projectile speed is clamped.
- Lifetime is clamped.
- Range is clamped.
- Integer rolls such as projectile count, pierce, split count, chain count, and orbit count are capped.
- Ricochet rolls are capped and only apply to supported projectile families.

Projectile and VFX object caps still govern actual runtime load.

## 7. Reward Display

Generated weapon reward cards show:

- Weapon name.
- Rarity.
- Reward action: upgrade, replace, new, stash, or stash full.
- Power score.
- Main modifier/stat.
- Compact stat summary.
- Shape identity.
- Comparison data in Armory and in-run replacement UI.

Rarity affects card accent color.

## 8. Future Work

Future rarity/stat work:

- Better comparison panel.
- More weapon-specific stat pools.
- Behavior-changing affixes.
- Rarity audio stings.
- Loot drop animations.
- Stat budget balancing by sector/difficulty.
- Seeded generation tests.
- Better per-family modifier filtering so irrelevant modifier stats appear less often.
