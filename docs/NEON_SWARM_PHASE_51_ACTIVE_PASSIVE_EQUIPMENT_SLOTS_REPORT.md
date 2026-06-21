# Neon Swarm Phase 51 Active/Passive Equipment Slots Report

## Scope

Phase 51 converts the Phase 50 manual-fire prototype into an active/passive equipment slot prototype. The old manual-fire fallback flag remains:

- `MANUAL_WEAPON_FIRE_EXPERIMENT_ENABLED = true`

When that flag is false, the existing auto-fire fallback path is still available through `_manual_weapon_fire_enabled()`.

No Sector 3 work, Phase 50 sector art, Sector 1/2 arena art changes, Sector 5 content, ending content, movement changes, collision changes, HUD redesign, or push were performed.

## Active Slots

There are five active manual-fire bindings:

| Active slot | Keyboard/mouse | Controller |
| --- | --- | --- |
| 1 | LMB | RT |
| 2 | RMB | LT |
| 3 | Q | RB |
| 4 | E | LB |
| 5 | R | L3 |

Implementation constants:

- `ACTIVE_WEAPON_SLOT_CAP = 5`
- `WEAPON_FIRE_SLOT_ACTIONS = ["fire_weapon_slot_1", ..., "fire_weapon_slot_5"]`
- `WEAPON_FIRE_SLOT_KEYBOARD_LABELS = ["LMB", "RMB", "Q", "E", "R"]`
- `WEAPON_FIRE_SLOT_CONTROLLER_LABELS = ["RT", "LT", "RB", "LB", "L3"]`

`fire_weapon_slot_6`, `fire_weapon_slot_7`, and `fire_weapon_slot_8` still exist as actions for compatibility, but their default F/Z/X bindings are removed by configuring them with empty event lists.

## Passive Families

Passive classification is centralized in `_is_passive_weapon_family(definition_id)`.

Current passive weapon definition ids:

- `prism_chain`
- `nova_burst`
- `star_pulse`
- `gravity_mine`
- `gravity_well`

The helper now checks the explicit `PASSIVE_WEAPON_DEFINITION_IDS` table instead of broad id/family/archetype substring matches. This keeps outward chain/nova/radial/field weapons passive while preventing aimed weapons such as `tri_burst_cannon`, `nova_needle`, `arc_beam`, and `hex_mortar` from becoming passive only because their names contain `burst`, `nova`, or beam/chain wording.

Active aimed examples after the hotfix:

- `tri_burst_cannon`: active aimed spread projectile
- `nova_needle`: active aimed needle projectile
- `arc_beam`: active manual beam weapon
- `hex_mortar`: active aimed arcing shell that bursts after launch

## Slot Unlock Curve

Equipment slots use the tunable constant:

```gdscript
EQUIPMENT_SLOT_UNLOCK_LEVELS = [1, 1, 4, 10, 20, 35, 50, 70]
```

Unlocked total equipment slots:

- Level 1: 2
- Level 4: 3
- Level 10: 4
- Level 20: 5
- Level 35: 6
- Level 50: 7
- Level 70: 8

Locked slots do not contribute runtime weapon stats, do not fire, and display as `LOCKED` with their unlock level. Level-up now records a pending equipment slot unlock notice when crossing a threshold.

## Starting Loadout

New default inventory behavior:

- Slot 1 starts with `Pulse Blaster`.
- Slot 2 starts empty.
- Remaining slots are empty or locked depending on player level.
- The older default loadout weapons are preserved in stash instead of being deleted.

Existing saves are normalized to eight equipment entries. Invalid entries become empty slots, extra entries beyond the cap are moved to stash when possible, and locked slots remain visible as locked instead of firing.

## Slot-To-Button Behavior

Active button assignment is based on active weapons among unlocked equipment slots. Passive weapons do not consume active buttons.

Examples:

- Equipment slot 1 active weapon: `LMB/RT`
- Equipment slot 2 passive weapon: `PASSIVE`
- Equipment slot 3 active weapon: `RMB/LT`
- Empty unlocked slot: `EMPTY`
- Locked slot: `LOCKED`

Firing rules:

- Active weapons fire only while their assigned active action is held.
- Passive weapons fire/trigger from cooldown without a held button.
- Empty slots do nothing.
- Locked slots do nothing.
- Cooldowns/rate limits remain in the weapon update functions.
- Manual aim remains the aim source; player visual enemy auto-facing remains disabled.

## Clear Slot Behavior

Armory equipped-slot actions now include:

- `FORGE SELECTED`
- `CLEAR SLOT`
- `CANCEL`

The clear workflow:

1. Select a filled, unlocked equipped slot in Armory.
2. Confirm `CLEAR SLOT`.
3. Confirm `CONFIRM CLEAR`.
4. The weapon moves to stash and the equipment slot becomes empty.

Clear is blocked safely when the selected slot is locked, already empty, or stash is full.

## HUD Behavior

The gameplay loadout HUD and Armory now distinguish:

- Active equipped weapon: button label such as `LMB/RT`, `RMB/LT`, `Q/RB`, `E/LB`, `R/L3`
- Passive equipped weapon: `PASSIVE`
- Empty unlocked slot: `EMPTY`
- Locked slot: `LOCKED`

Reward and Armory comparison previews use a prospective binding helper so the player can see which button or passive label a weapon would get before equipping.

## HUD Polish / Button Glyph Pass

The equipment UI now uses large framed glyph badges instead of relying on dense row text.

Glyph labels supported:

- Active keyboard/mouse: `LMB`, `RMB`, `Q`, `E`, `R`
- Active controller: `RT`, `LT`, `RB`, `LB`, `L3`
- Combined gameplay labels: `LMB / RT`, `RMB / LT`, `Q / RB`, `E / LB`, `R / L3`
- State labels: `PASSIVE`, `EMPTY`, `LV 4`, `LV 10`, `LV 20`, `LV 35`, `LV 50`, `LV 70`

Gameplay HUD card layout:

- Large glyph badge first.
- Weapon name next to the glyph.
- State line below the name: `ACTIVE`, `FIRING`, `AUTO WEAPON`, `AUTO FIRING`, `SLOT OPEN`, or locked unlock text.
- Existing fire-source pulse remains on the slot card and badge, with no node creation per shot.

Armory card layout:

- Equipment rows render as compact cards with a small slot number, large glyph badge, weapon/state name, and clear state line.
- Active equipped weapons show their exact glyph, such as `LMB / RT`, plus `ACTIVE WEAPON`.
- Passive equipped weapons show `PASSIVE` plus `NO BUTTON REQUIRED`.
- Empty slots show `EMPTY`, `OPEN SLOT`, and `READY TO EQUIP`.
- Locked slots show the unlock-level glyph, such as `LV 20`, plus `LOCKED` and the required level.

Stash / inventory display behavior:

- Stored active weapons show an `ACTIVE` glyph and `USES EQUIPPED SLOT`.
- Stored passive weapons show a `PASSIVE` glyph and `NO BUTTON REQUIRED`.
- The detail panel now states `ACTIVE WEAPON` with the projected target slot button, or `PASSIVE WEAPON` with no fire button required.
- The Armory overlay scrim is darker while Armory is open to improve card contrast without removing the existing visual style.

## Passive Nova/Burst Hotfix

The Phase 51 passive classification was narrowed after user clarification that "burst weapons are passive" means outward/bomb/radial/shockwave-style build powers, not every aimed projectile with `burst` in its name.

What changed:

- `PASSIVE_WEAPON_DEFINITION_IDS` is the single classification table.
- `nova_burst`, `star_pulse`, `gravity_mine`, `gravity_well`, and `prism_chain` fire from cooldown without held input.
- `tri_burst_cannon`, `nova_needle`, `arc_beam`, and `hex_mortar` require their assigned active slot button.
- Passive nova/radial effects still pulse the correct equipment HUD slot when they trigger.

Nova/radial tuning added:

- `NOVA_BURST_RADIUS_MULTIPLIER = 1.20`
- `NOVA_BURST_MAX_RADIUS = 9.0`
- `NOVA_BURST_VISUAL_RADIUS_MULTIPLIER = 1.40`
- `NOVA_BURST_VISUAL_MAX_RADIUS = 10.8`
- `NOVA_BURST_IMPACT_FLASH_SCALE = 1.05`
- `NOVA_BURST_EFFECT_DURATION = 0.58`
- `STAR_PULSE_MAX_RADIUS = 8.4`
- `STAR_PULSE_EFFECT_DURATION = 0.42`

Projectile range / cleanup tuning added:

- `PLAYER_PROJECTILE_RANGE_MULTIPLIER = 1.18`
- `PLAYER_PROJECTILE_MAX_TRAVEL_DISTANCE = 42.0`
- `PLAYER_PROJECTILE_OFFSCREEN_CLEANUP_MARGIN = 8.0`

These values are Godot world units, not screen pixels. No literal `600` pixel projectile cleanup constant was found. Before this pass, player projectiles were cleaned up by lifetime plus `_outside_arena(node.position, 2.0)`. The off-arena margin is now named and wider for player projectiles, and each player projectile records `spawn_position` and `max_travel` so range cleanup is tunable without allowing infinite projectile leaks.

## Nova Size / Buff / Slot Flow Hotfix

Nova Burst damage and visual scale are now tuned separately. Damage still uses `_nova_burst_radius()`, while the screen-space shockwave uses `_nova_burst_visual_radius()`.

Nova visual size:

- Before this hotfix, the base visual radius from the prior pass was about `10.04` world units (`NOVA_RADIUS * NOVA_BURST_RADIUS_MULTIPLIER * 1.35`).
- After that hotfix, the base visual radius was about `5.21` world units (`_nova_burst_radius() * 0.70`) with `NOVA_BURST_VISUAL_MAX_RADIUS = 5.4`. This smaller value was intentionally doubled in the final floor-plane size tuning below.
- The impact flash was reduced from an inline `1.70` burst scale to `NOVA_BURST_IMPACT_FLASH_SCALE = 1.05`.

Nova damage proof:

- Focused validation spawned three enemies: two inside the tuned damage radius and one outside.
- Result: Nova Burst damaged exactly `2 / 3` enemies, and the outside enemy remained undamaged.
- The spawned Nova visual effect used the reduced `_nova_burst_visual_radius()` value.

Fractal Shard / Fractal Splitter behavior:

- `fractal_shard_unlock` was removed from the level-up upgrade pool. Fractal Shard is a weapon and must be intentionally acquired/equipped through weapon reward/equipment flow.
- `Fractal Core`, `Fractal Splitter`, `Fractal Coolant`, `Fractal Tail`, and `Fractal Aperture` are now buffs only; they no longer include `fractal_shard_enable`.
- Fractal buffs are filtered out of level-up rolls unless Fractal Shard is already equipped or otherwise active as a legacy run target.
- Legacy `fractal_shard_enable` data no longer creates a run bonus weapon, does not set `_fractal_shard_enabled`, and does not start firing.
- Fractal buffs do not bank hidden Fractal bonuses when Fractal Shard is absent; they modify the existing Fractal Shard only.

In-run Level 4 Slot 3 unlock flow:

- When an XP pickup crosses a slot threshold, equipment slots are normalized, the gameplay HUD is dirtied, and the HUD refreshes immediately.
- Level 4 changes Slot 3 from `LV 4` / locked to `EMPTY` during that same run.
- Weapon reward routing normalizes against the current in-run level before selecting an open slot, so a post-Level 4 in-run weapon reward can equip into Slot 3 without requiring death or main Armory.

## Nova Floor-Plane Visual Hotfix

Nova Burst now uses a floor-plane-only visual. The gameplay damage radius remains separate from visual scale.

What changed:

- `NOVA_BURST_VISUAL_FLOOR_PLANE_ONLY = true`
- `NOVA_BURST_VISUAL_VERTICAL_SCALE = 1.0`
- `NOVA_BURST_VISUAL_START_SCALE = 1.20`
- `NOVA_BURST_VISUAL_FLOOR_Y = 0.12`
- `NOVA_BURST_VISUAL_MAX_SCREEN_DIAMETER_PX = 1000.0`

The cause of the screen-covering look was that Godot `TorusMesh` is already flat on X/Z, but the Nova visual rotated the torus children by `PI * 0.5` and then scaled the root uniformly on X/Y/Z. That made the effect read as an upright, camera-facing circle/volume. The Nova torus children now keep their native flat X/Z orientation, and `_update_beam_effects()` scales Nova as `Vector3(radius, NOVA_BURST_VISUAL_VERTICAL_SCALE, radius)` so it expands across the arena floor without growing vertically toward the camera.

The dynamic weapon Blender model was removed from the expanding Nova shockwave because it was being scaled inside the already-expanding effect root and could read as a large blob instead of a floor ring.

Validation proof:

- Focused validation: `NOVA_FLOOR_PLANE_LOGIC_VALIDATION_PASS`.
- Initial floor-plane validation projected gameplay-camera diameter: `280.68 px`, below `NOVA_BURST_VISUAL_MAX_SCREEN_DIAMETER_PX = 1000.0`.
- Nova visual root stays at `NOVA_BURST_VISUAL_FLOOR_Y = 0.12`.
- Nova visual Y scale remains `1.0` while X/Z scale expands.
- Nova torus child `rotation.x` remains `0.0`, so the torus is not rotated upright toward the camera.
- Nova still damaged exactly `2 / 3` validation enemies: the two inside damage radius were hit and the outside enemy was not.
- Native viewport screenshot capture was not available under this headless/dummy-renderer environment; the validation image generated from the gameplay-camera projection is `/tmp/neon_swarm_nova_floor_plane_hotfix_validation.png`.

## Nova Floor-Plane Size Final Tuning

Nova Burst floor-plane orientation stayed approved, but the flat visual was too small after the orientation fix. The final tuning doubles only the floor-plane visual size:

- `NOVA_BURST_VISUAL_RADIUS_MULTIPLIER` changed from `0.70` to `1.40`.
- `NOVA_BURST_VISUAL_MAX_RADIUS` changed from `5.4` to `10.8`.
- `NOVA_BURST_VISUAL_START_SCALE` changed from `0.60` to `1.20`.
- `NOVA_BURST_VISUAL_FLOOR_PLANE_ONLY` remains `true`.
- `NOVA_BURST_VISUAL_VERTICAL_SCALE` remains `1.0`.
- `NOVA_BURST_VISUAL_MAX_SCREEN_DIAMETER_PX` remains `1000.0`.

The visual continues to scale as `Vector3(radius, NOVA_BURST_VISUAL_VERTICAL_SCALE, radius)`, so the shockwave grows across the arena floor without vertical/camera-axis growth. Damage radius remains separate and unchanged.

Final size validation:

- Focused validation: `NOVA_FLOOR_PLANE_LOGIC_VALIDATION_PASS`.
- Projected gameplay-camera diameter changed from `280.68 px` to `561.37 px`.
- Final projected diameter remains below `NOVA_BURST_VISUAL_MAX_SCREEN_DIAMETER_PX = 1000.0`.
- Nova still damaged exactly `2 / 3` validation enemies.

## Reward / Run Weapon Behavior

Generated weapon rewards use unlocked compatible equipment slots for `Equip Now`; replacement blocks locked slots and blocks adding a sixth active weapon unless replacing an existing active slot or equipping a passive.

Run-only bonus weapons remain outside persistent equipment slots for this prototype and are treated as temporary passive/run-only systems. This avoids consuming the limited five active bindings until a later binding UI/design pass.

## Known Balance Risks

- Active button assignment is compacted by active weapon order, so equipping an active weapon into an earlier equipment slot can shift later active weapon labels.
- Passive classification is explicit for the current weapon catalog; future weapon design should move this to catalog metadata if more weapon families are added.
- Existing saves with weapons in locked slots preserve those entries but do not activate them until the slot unlocks.
- Full controller remapping UI is still future work.

## Validation Results

Focused validation script:

- Command: `godot --headless --path . --user-data-dir /tmp/neon_swarm_phase51_userdata --script /tmp/neon_swarm_phase51_validation.gd`
- Result: `PHASE51_ACTIVE_PASSIVE_SLOT_VALIDATION_PASS`

Focused checks covered:

- LMB/RMB/Q/E/R active inputs.
- RT/LT/RB/LB/L3 controller mappings.
- F/Z/X old active slot bindings disabled.
- Explicit passive classification for passive slot behavior.
- Level unlock thresholds.
- Active slot labels, passive labels, empty labels, and locked labels.
- Active held-button firing.
- Active release stops firing.
- Passive weapon does not require a held button.
- Empty and locked slots do not fire.
- Five-active-weapon cap blocks a sixth active weapon.
- Passive weapon can still equip after active cap.
- Default loadout starts with Pulse Blaster only and preserves older defaults in stash.
- Clear slot moves an equipped weapon to stash and leaves the slot empty.

Headless boot validation:

- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . scenes/Main.tscn --quit-after 3`: passed.

HUD polish validation:

- Focused badge/unlock validation: `PHASE51_BADGE_UNLOCK_VALIDATION_PASS`.
- Focused idle-performance regression validation: `PHASE51_IDLE_PERF_VALIDATION_PASS`.
- Confirmed large gameplay glyph badges for active, passive, empty, and locked slots.
- Confirmed Armory equipped cards and stash cards expose glyph/state labels.
- Confirmed reward/detail text reports active target buttons and passive no-button behavior.
- Confirmed slot-fire pulse still uses existing HUD nodes and the idle HUD rebuild throttle remains intact.

Passive nova/burst hotfix validation:

- Focused passive/nova/burst validation: `PHASE51_PASSIVE_NOVA_BURST_VALIDATION_PASS`.
- Confirmed `nova_burst`, `star_pulse`, and `prism_chain` function without held input.
- Confirmed `tri_burst_cannon` and `nova_needle` do not fire while idle and do fire from their active slot button.
- Confirmed passive nova/radial weapons show `PASSIVE` through the slot binding helper.
- Confirmed passive cooldowns reset after firing.
- Confirmed player projectile cleanup has named max-travel and offscreen-margin tuning.
- Confirmed no infinite projectile leak in the focused max-travel cleanup check.

Nova size / buff / slot-flow hotfix validation:

- Focused validation: `PHASE51_NOVA_BUFF_SLOT_HOTFIX_VALIDATION_PASS`.
- Confirmed Nova visual radius reduced from about `10.04` world units to about `5.21` world units at base tuning.
- Confirmed Nova damaged exactly two in-radius enemies and did not damage the out-of-radius enemy.
- Confirmed Fractal Splitter no longer carries `fractal_shard_enable`.
- Confirmed Fractal Splitter does not roll when Fractal Shard is absent.
- Confirmed legacy Fractal enable data does not create a run bonus weapon, does not enable runtime Fractal Shard, and does not spawn projectiles.
- Confirmed Fractal Splitter applies `+2` split bonus only when Fractal Shard is intentionally equipped.
- Confirmed equipped Fractal Shard remains active/manual and does not fire while idle.
- Confirmed Level 4 changes Slot 3 from `LV 4` to `EMPTY` during the same run.
- Confirmed a same-run weapon reward after the Level 4 unlock selects and equips into Slot 3.

Nova floor-plane validation:

- Focused validation: `NOVA_FLOOR_PLANE_LOGIC_VALIDATION_PASS`.
- Confirmed the Nova shockwave lies on the arena X/Z floor plane.
- Confirmed the visual does not scale on the vertical/camera axis.
- Confirmed projected gameplay-camera diameter is `561.37 px`, doubled from `280.68 px` and below the `1000 px` cap.
- Confirmed Nova still damages in-radius enemies.

Required final validation commands were run after implementation and documentation.
