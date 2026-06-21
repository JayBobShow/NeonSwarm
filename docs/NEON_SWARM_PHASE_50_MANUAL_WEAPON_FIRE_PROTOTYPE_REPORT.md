# Neon Swarm Phase 50 Manual Weapon Fire Prototype Report

## Scope

Phase 50 adds a safe manual weapon slot firing prototype. It is gameplay mechanics work only: no Sector 3 work, no Sector 3 arena art, no Sector 5 work, and no ending content.

## Feature Flag

- `MANUAL_WEAPON_FIRE_EXPERIMENT_ENABLED = true`
- When the flag is `true`, equipped weapon families only fire or trigger while one of their mapped weapon slot inputs is held.
- When the flag is `false`, `_is_weapon_slot_fire_pressed()` returns `true` and the previous timer-driven auto-fire behavior remains available.

## Input Actions Added

- `fire_weapon_slot_1`
- `fire_weapon_slot_2`
- `fire_weapon_slot_3`
- `fire_weapon_slot_4`
- `fire_weapon_slot_5`
- `fire_weapon_slot_6`
- `fire_weapon_slot_7`
- `fire_weapon_slot_8`

## Default Bindings

Keyboard and mouse:

- Slot 1: `LMB`
- Slot 2: `RMB`
- Slot 3: `Q`
- Slot 4: `E`
- Slot 5: `R`
- Slot 6: `F`
- Slot 7: `Z`
- Slot 8: `X`

Controller:

- Slot 1: `RT`
- Slot 2: `LT`
- Slot 3: `RB`
- Slot 4: `LB`

Slots 5-8 currently have keyboard defaults only. Full controller binding UI remains a later design pass.

## Slot-To-Button Mapping

The prototype maps weapon activation through these helpers in `scripts/NeonSwarm3DGameplayPrototype.gd`:

- `_get_fire_action_for_weapon_slot(slot_index)`
- `_is_weapon_slot_fire_pressed(slot_index)`
- `_should_weapon_slot_fire(slot_index, weapon_data)`
- `_fire_slot_indices_for_weapon_definition(definition_id)`
- `_is_weapon_definition_fire_pressed(definition_id)`

Equipped weapon slot index `0` maps to `fire_weapon_slot_1`, slot index `1` maps to `fire_weapon_slot_2`, and so on through slot index `7`.

Run bonus weapons do not replace equipped loadout slots. In manual-fire mode, run bonus weapons receive the next open fire slot after the equipped loadout when one exists, preserving acquisition order during the run. If all eight equipped slots are already occupied, the run bonus weapon is reported as `NO BIND` and needs a future binding/design pass.

## Weapon Behavior

The following weapon families are gated by slot-fire input while preserving their existing cooldown, rate, range, damage, projectile, chaining, mine, orbit, ring, and burst behavior:

- Pulse Blaster
- Hex Shatter
- Fractal Shard
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine
- Prism Lance
- Ring Saw
- Tri-Burst Cannon
- Hex Mortar
- Vector Spear
- Orbital Saw Array
- Prism Chain
- Gravity Well
- Nova Needle
- Fractal Bloom
- Shield Breaker
- Star Pulse

Projectile weapons use manual aim input first. If no active aim input exists, they use the preserved last manual aim-facing direction. In manual-fire mode they do not choose a nearest enemy direction.

Cooldown timers continue to advance while a fire button is released. This lets a ready weapon fire immediately when the assigned button is pressed, then continue respecting its cooldown while held.

## HUD Changes

The gameplay loadout HUD now shows each equipped slot's fire binding beside its rarity code. Tooltips also include a `Fire:` line. Empty slots show their assigned binding so the player can understand the button map.

Run bonus weapon HUD labels include their assigned binding when available, or `NO BIND` when all prototype slots are occupied.

## Old Auto-Fire Fallback

The old behavior remains behind `MANUAL_WEAPON_FIRE_EXPERIMENT_ENABLED = false`. With the flag off, weapon update methods treat each slot as pressed and continue firing from their existing cooldown timers.

## Tested Weapon Types

Focused prototype validation covers:

- Slot 1 projectile firing with Pulse Blaster.
- Slot 2 projectile firing with Nova Needle in a two-slot runtime test loadout.
- Simultaneous Slot 1 and Slot 2 firing.
- Cooldown gating while holding Slot 1.
- Empty slot input safety.
- Manual aim preservation with enemy presence.

The broader headless scene validation covers normal startup, campaign initialization, HUD creation, Sector 1 startup, and existing Sector 1/Sector 2 arena resource loading.

## Weapon Types Needing Design Review

- Orbit Spark, Ring Saw, Orbital Saw Array, Nova Burst, Star Pulse, Gravity Mine, Gravity Well, Arc Beam, and Prism Chain are now manually triggered, but their long-term feel may need design review because they were previously passive or semi-passive.
- Run bonus weapons need a final binding model once the equipped loadout already uses all eight prototype fire slots.
- A full controller binding UI is still needed for direct access to slots 5-8.

## Risks / Known Issues

- If the player starts a run and presses fire before ever aiming, projectile weapons wait until a manual aim direction exists.
- Weapon runtime state is still family-based in this prototype. Duplicate equipped copies of the same weapon family share one cooldown/update path and can be triggered by any slot assigned to that family; true per-instance cooldowns remain future work.
- Existing generated weapons and saved loadouts remain compatible because no save schema changed, but their runtime firing feel is now button-gated while the experiment flag is enabled.
- This phase does not rebalance cooldowns, damage, projectile caps, or enemy pressure for manual firing.
