# Neon Swarm Phase 21 - True Weapon Loadout Runtime Integration Report

## 1. Executive Summary

Phase 21 connects the Phase 20 Armory/Stash UI to real runtime weapon behavior.

The active run now rebuilds weapon family activation from saved equipped weapon instances. A weapon equipped in the Armory determines which weapon logic is active during gameplay, and generated stat rolls feed the existing bounded runtime stat multipliers.

This phase did not add new sectors, enemies, bosses, weapons, HUD redesigns, menu redesigns, or alternate scenes.

## 2. Approved Phase 20 Baseline Preserved

Preserved:

- Official build path: `scenes/Main.tscn`
- Title menu: Start Game, Armory, Options, Quit
- Armory/Stash screen
- Options menu and saved settings
- Pause menu, Return to Title, and Quit Game
- Audio, mute, music/SFX volume routing
- HUD and loadout chip styling
- XP, level-up, sector rewards, weapon rewards
- Sector flow through the current prototype run
- Boss events and RUN COMPLETE flow
- Keyboard/controller navigation paths
- Neon tube edge visual style and performance caps

## 3. Equipped Weapon Slot Model

Current slot model:

- Flexible equipped weapon-system slots.
- Slot cap: 8 equipped weapon instances.
- Stash cap: 48 stored weapon instances.
- New or empty saves create a safe Common starter loadout from `WeaponCatalog.default_loadout_ids()`.
- Each equipped instance stores definition id, family, rarity, stat rolls, modifier rolls, power score, and equipped state.

The system intentionally stays flexible for now instead of locking slots to primary/secondary/utility categories. Slot categories can be added later once the weapon roster is larger.

## 4. Runtime Weapon Router

Runtime routing now rebuilds active weapon families from `_equipped_weapon_instances`.

Implemented behavior:

- `_initialize_weapon_framework()` starts weapon states disabled.
- `_rebuild_weapon_stat_bonuses()` aggregates stat rolls per equipped weapon family.
- Weapon states are enabled only when that family is equipped.
- Pulse Blaster, Orbit Spark, Nova Burst, Arc Beam, Gravity Mine, Prism Lance, Ring Saw, Hex Shatter, and Fractal Shard all check runtime enabled state before firing or applying damage.
- Fractal Shard also preserves the existing temporary in-run level-up unlock flag so older level-up choices do not break.
- Orbit Spark and Ring Saw visuals hide when their families are not equipped.
- HUD loadout chips show `OFF` for inactive orbit/lance/saw/mine systems.

Runtime stat rolls remain bounded by existing helpers:

- Damage multiplier
- Fire-rate multiplier
- Cooldown multiplier
- Projectile speed multiplier
- Lifetime multiplier
- Range multiplier
- Integer bonuses for projectile, pierce, split, chain, and orbit counts

## 5. Cross-Family Equip/Swap Behavior

Armory now supports cross-family replacement.

Current behavior:

- Select an equipped slot.
- Select a stashed weapon.
- Confirm equip.
- The stashed weapon replaces the selected equipped slot, even if the weapon family differs.
- The previous equipped weapon is moved back into the same stash position.
- The loadout is saved immediately.
- Runtime weapon bonuses are rebuilt immediately.
- A new run uses the swapped weapon family.

Validated example:

- Rare Fractal Shard from stash replaced slot 1 Pulse Blaster.
- Pulse Blaster runtime state became inactive.
- Fractal Shard runtime state became active.
- Start Game fired Fractal Shard projectiles and did not fire Pulse Blaster.

## 6. Starter Loadout Behavior

If weapon inventory cannot load or contains no valid equipped weapons:

- The game creates a default Common starter loadout.
- Starter weapons are generated from catalog definitions.
- The equipped loadout is never empty.
- Start Game remains safe for new players or cleared saves.

The Phase 21 validation script confirms starter weapons are Common and use valid catalog definitions.

## 7. Armory UI Changes

Armory updates:

- Comparison now targets the currently selected equipped slot instead of only a matching family.
- Comparison text shows `A: EQUIP INTO E##`.
- Status text explains that the stash weapon will replace the selected equipped slot.
- Equip confirmation reports the target slot and that the previous weapon was sent to stash.
- Existing neon-glass styling, row focus, controller/keyboard navigation, and Back behavior are preserved.

## 8. Reward Flow Connection

Sector weapon rewards remain connected to the weapon inventory and runtime stat system.

Current behavior:

- Generated weapon rewards still roll rarity, stat rolls, modifier rolls, and power score.
- Direct reward equip can replace a matching equipped family or fill an open equipped slot.
- If the current in-run reward flow cannot safely present a full slot-pick replacement, the weapon goes to stash when space is available.
- Stashed reward weapons can then be cross-family equipped through the Armory and will affect future runs.

Known boundary:

- The in-run reward screen does not yet provide a full cross-family slot-pick replacement UI when all slots are full. This is intentionally left for a focused reward UI phase rather than adding a confusing combat-time flow here.

## 9. Save/Load Behavior

Weapon inventory remains separate from options settings.

Weapon save file:

- `user://neon_swarm_weapon_inventory.cfg`

Saved data:

- Schema version
- Instance counter
- Equipped weapon instances
- Stash weapon instances
- Discovered weapon families

Phase 21 validation confirmed:

- Cross-family swapped loadout saved.
- A fresh `scenes/Main.tscn` instance reloaded the swapped weapon.
- The reloaded runtime router activated the saved weapon family.
- Validation restored the original inventory after the test.

## 10. Balance/Safety Caps

Preserved safety rules:

- No zero cooldown.
- No infinite projectile loops.
- Projectile, split, orbit, beam, mine, enemy, XP, and burst caps remain active.
- Stat multipliers are clamped.
- Invalid weapon definitions are blocked in Armory equip.
- Empty loadout fallback creates safe Common weapons.

Current clamps include:

- Damage multiplier: 0.80 to 1.45
- Fire-rate multiplier: 0.80 to 1.35
- Cooldown multiplier: 0.70 to 1.00
- Projectile speed multiplier: 0.85 to 1.32
- Lifetime multiplier: 0.90 to 1.24
- Range multiplier: 0.90 to 1.20

## 11. Files Changed

Changed:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`
- `docs/NEON_SWARM_PHASE_21_TRUE_WEAPON_LOADOUT_RUNTIME_INTEGRATION_REPORT.md`

No alternate playable scenes or hidden test scenes were created.

## 12. Validation Results

Required validation:

- PASS: `godot --headless --path . --quit-after 3`
- PASS: `godot --headless --path . --quit-after 3000`
- PASS: `godot --headless --path . scenes/Main.tscn --quit-after 3`

Targeted Phase 21 validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase21_loadout_runtime_validation.gd`
- Output: `PHASE21_LOADOUT_PASS active_fractal=true damage=1.12 cooldown=0.92 restored_equipped=8`

Regression validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase20_armory_validation.gd`
- Output: `PHASE20_ARMORY_PASS equipped_rows=8 stash_rows=10 restored_stash=2`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_pause_menu_hotfix_validation.gd`
- Output: `PHASE19_PAUSE_HOTFIX_PASS pause_buttons=4 options_buttons=8`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_weapon_reward_validation.gd`
- Output: `PHASE19_WEAPON_REWARD_PASS rarity=Rare action=REPLACE equipped=8 stash=2 sector=2`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_full_flow_validation.gd`
- Output: `PHASE19_FULL_FLOW_PASS weapon_rewards=3 equipped=8 stash=2 run_success=true`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_runtime_stress.gd`
- Output: `PHASE19_RUNTIME_STRESS_PASS sector=Hyper Grid enemies=14/54 player_projectiles=4/36 enemy_projectiles=0/28 bursts=2/18 equipped=8 stash=2`

## 13. Exact Run Command

Official editor run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 14. What The User Should Test

Manual test checklist:

- Launch the official build.
- Open Armory from title.
- Select an equipped slot.
- Select a different-family stashed weapon.
- Equip it and confirm the old equipped weapon moves to stash.
- Back out to title.
- Reopen Armory and confirm the swapped loadout persisted.
- Start Game and confirm the swapped weapon family fires in gameplay.
- Confirm the replaced weapon family no longer fires from that slot.
- Clear sectors and confirm generated weapon rewards still appear.
- Send reward weapons to stash when appropriate.
- Confirm Options, pause menu, Return to Title, Quit Game, XP, level-up, death/restart, success/restart, and audio still work.

## 15. Known Issues

- In-run generated weapon reward cards do not yet include a full cross-family slot-pick replacement screen when all equipped slots are full. They safely equip matching/open-slot rewards or send weapons to stash for Armory management.
- Legacy Fractal Shard level-up choices can still temporarily enable Fractal Shard for the current run without creating a saved weapon instance. Saved Armory loadouts still drive the starting runtime weapon families.
- Dedicated manual unequip is not implemented yet.
- Sorting, filtering, favorite/lock, salvage/sell, and advanced comparison UI are still future Armory work.
- Duplicate family loadouts can stack stat totals because flexible slots are currently allowed. This is capped and safe, but later balance may require slot categories or duplicate-family rules.

## 16. Approval Question

Phase 21 is complete for true weapon loadout runtime integration. Approve Phase 21?
