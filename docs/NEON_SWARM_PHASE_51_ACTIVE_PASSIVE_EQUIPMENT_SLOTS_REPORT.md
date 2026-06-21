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

Prototype passive families:

- chain
- nova
- burst

The helper checks the weapon definition id, family, and archetype text so content-pack weapons such as `prism_chain`, `nova_burst`, `nova_needle`, and `tri_burst_cannon` route consistently. Everything else remains active unless it matches one of those passive terms.

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

## Reward / Run Weapon Behavior

Generated weapon rewards use unlocked compatible equipment slots for `Equip Now`; replacement blocks locked slots and blocks adding a sixth active weapon unless replacing an existing active slot or equipping a passive.

Run-only bonus weapons remain outside persistent equipment slots for this prototype and are treated as temporary passive/run-only systems. This avoids consuming the limited five active bindings until a later binding UI/design pass.

## Known Balance Risks

- Active button assignment is compacted by active weapon order, so equipping an active weapon into an earlier equipment slot can shift later active weapon labels.
- Passive family classification is intentionally broad for prototype speed; future weapon design may need explicit metadata instead of id/family/archetype string matching.
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
- Passive chain/nova/burst classification.
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

Required final validation commands were run after implementation and documentation.
