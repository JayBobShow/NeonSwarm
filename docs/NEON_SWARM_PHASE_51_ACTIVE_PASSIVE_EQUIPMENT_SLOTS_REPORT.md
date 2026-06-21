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
- `NOVA_BURST_VISUAL_RADIUS_MULTIPLIER = 1.35`
- `NOVA_BURST_EFFECT_DURATION = 0.58`
- `STAR_PULSE_MAX_RADIUS = 8.4`
- `STAR_PULSE_EFFECT_DURATION = 0.42`

Projectile range / cleanup tuning added:

- `PLAYER_PROJECTILE_RANGE_MULTIPLIER = 1.18`
- `PLAYER_PROJECTILE_MAX_TRAVEL_DISTANCE = 42.0`
- `PLAYER_PROJECTILE_OFFSCREEN_CLEANUP_MARGIN = 8.0`

These values are Godot world units, not screen pixels. No literal `600` pixel projectile cleanup constant was found. Before this pass, player projectiles were cleaned up by lifetime plus `_outside_arena(node.position, 2.0)`. The off-arena margin is now named and wider for player projectiles, and each player projectile records `spawn_position` and `max_travel` so range cleanup is tunable without allowing infinite projectile leaks.

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

Required final validation commands were run after implementation and documentation.
