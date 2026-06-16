# Neon Swarm Phase 32 Weapon Evolution / Fusion Foundation Report

## 1. Executive Summary

Phase 32 adds the first Weapon Forge evolution/fusion foundation to the official build only: `scenes/Main.tscn`.

The new system lets the player spend Neon Dust and one compatible stash weapon to evolve an owned weapon. This deepens the long-term roguelite loot loop without adding new weapons, enemies, bosses, sectors, or combat-balance overhaul.

## 2. Evolution / Fusion Access

Evolution is accessed from the existing Armory Weapon Forge:

1. Open `ARMORY`.
2. Select an equipped or stored weapon.
3. Choose `FORGE SELECTED`.
4. Choose `EVOLVE / FUSE`.
5. Select a compatible stash material weapon.
6. Confirm the final fusion prompt.

Existing Forge actions remain available:

- `UPGRADE POWER`
- `REROLL STATS`
- `REROLL MOD`
- `EVOLVE / FUSE`

## 3. Fusion Rules

Current fusion rules:

- The selected weapon is the primary weapon.
- The material weapon must come from stash.
- Same-family fusion is compatible.
- Same geometry-group fusion is compatible.
- Incompatible materials are blocked.
- Fusion consumes the material weapon only after final confirmation.
- Fusion spends Neon Dust only after final confirmation.
- The primary weapon remains owned and gains one evolution rank.

## 4. Compatibility Groups

| Group | Compatible Families |
| --- | --- |
| Projectile | Pulse Blaster, Tri-Burst Cannon, Nova Needle, Vector Spear, Shield Breaker |
| Orbit | Orbit Spark, Ring Saw, Orbital Saw Array |
| Area / Field | Nova Burst, Gravity Mine, Gravity Well, Star Pulse |
| Chain / Beam | Arc Beam, Prism Chain, Prism Lance |
| Shard / Split | Fractal Shard, Fractal Bloom, Hex Mortar, Hex Shatter |

Same-family fusion always works even inside the broader group rule.

## 5. Evolution Rank Effects

New saved weapon fields:

- `evolution_rank`
- `evolution_stats`
- `fusion_history`
- `fusion_dust_spent`

Current cap:

- Max evolution rank: 3

Current stat effects per evolution rank:

- Damage bonus: `+1.8%`
- Cooldown reduction: `+0.6%`
- Range bonus: `+0.6%`
- Lifetime bonus: `+0.4%`

The effects are intentionally modest and do not add projectile-count, orbit-count, chain-count, or split-count bonuses yet.

## 6. UI / Confirmation Flow

UI changes:

- Forge actions now include `EVOLVE / FUSE`.
- Material-selection mode shows the primary weapon, selected material, compatibility, cost, and result rank.
- Confirmation mode clearly states that fusion consumes the material weapon.
- Weapon rows show `EV#` for evolved weapons.
- Weapon details show evolution rank, fusion group, evolution bonuses, Neon Dust invested, and latest fusion history.
- Comparison text shows before/after power and evolution stat changes.

Safety:

- No one-button accidental fusion.
- `B / Esc` backs out of material selection or final confirmation.
- Incompatible material weapons are blocked.

## 7. Save/Load Changes

Weapon inventory schema is now saved as version 3.

Save/load now preserves:

- Evolution rank.
- Evolution stat bonuses.
- Fusion history.
- Fusion Dust spent.
- Consumed material removal.
- Neon Dust spent.

Old saves remain compatible because missing evolution fields normalize to rank 0 and empty bonuses.

## 8. Runtime Stat Effects

`WeaponCatalog.stat_totals()` now includes `evolution_stats`.

`WeaponCatalog.estimate_power()` now includes `evolution_stats`.

Equipped evolved weapons affect runtime behavior through the same stat aggregation path as generated stat rolls and Forge Power.

Stashed evolved weapons remain inactive until equipped.

## 9. Balance Notes

The foundation is deliberately conservative:

- Evolution rank is capped at 3.
- Effects are small percent bonuses.
- Fusion requires both Neon Dust and a compatible stash weapon.
- Material weapons are consumed, creating a real inventory decision.
- No new projectile multiplication or recursive weapon behavior was added.
- Existing caps remain in place.

## 10. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/content/NeonWeaponCatalog.gd`
- `docs/NEON_SWARM_PHASE_32_WEAPON_EVOLUTION_FUSION_FOUNDATION_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `/tmp/neon_swarm_phase32_evolution_fusion_validation.gd`

## 11. Validation Results

Passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_ui_layout_hotfix_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase29_forge_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase30_wave_director_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase31_boss_telegraph_validation.gd`
- `godot --headless --path . --script /tmp/neon_swarm_phase32_evolution_fusion_validation.gd`

Specific Phase 32 validation coverage:

- Forge still opens.
- Existing Forge actions still pass validation.
- `EVOLVE / FUSE` action appears through Forge.
- Incompatible material weapons are blocked.
- Compatible material weapons can fuse.
- Confirmation is required before material consumption.
- Material weapon is consumed only after confirmation.
- Evolution rank saves and loads.
- Evolution stats affect runtime stat aggregation when equipped.
- Neon Dust cost applies.
- Old saves normalize missing evolution fields safely.
- UI/controller-facing action modes still load through the existing Armory flow.

## 12. Exact Run Command

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 13. What I Should Test

- Open Armory.
- Select an equipped weapon.
- Open Forge.
- Confirm `EVOLVE / FUSE` appears.
- Try an incompatible stash material and confirm it is blocked.
- Try a compatible same-family or same-group material.
- Confirm the final prompt says the material weapon will be consumed.
- Confirm fusion consumes only the material after confirmation.
- Confirm the primary weapon shows `EV1`, `EV2`, or `EV3`.
- Confirm evolved weapon stats affect the next run when equipped.
- Confirm existing Forge actions still work.

## 14. Known Issues

- Fusion visuals are currently UI/status based only; no new evolved 3D weapon model variants were added in this foundation phase.
- Fusion compatibility is intentionally simple and geometry-group based. Future phases can add curated pairings, evolved forms, or stricter recipes.

## 15. Approval Question

Is Phase 32 approved as the Weapon Evolution / Fusion foundation, with deeper evolved visuals and advanced recipes left for future phases?
