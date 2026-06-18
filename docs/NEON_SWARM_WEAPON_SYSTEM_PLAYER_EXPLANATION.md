# Neon Swarm Weapon System - Player Explanation

## 1. What Is A Weapon Family?

A weapon family is the weapon type.

Examples:

- Pulse Blaster
- Ring Saw
- Fractal Shard
- Tri-Burst Cannon
- Hex Mortar
- Gravity Well

The family decides what the weapon actually does in combat. A Tri-Burst Cannon shoots triangle bolts. A Gravity Well creates a pull field. A Star Pulse makes a radial burst.

Think of weapon family as the weapon's gameplay identity.

## 2. What Is A Weapon Instance?

A weapon instance is one owned copy of a weapon family.

Example:

- Family: Tri-Burst Cannon
- Instance: Rare Tri-Burst Cannon with +Damage, +Shot Speed, and Ricochet

Two weapons can belong to the same family but have different rolls.

Example:

- Common Tri-Burst Cannon with +Damage
- Epic Tri-Burst Cannon with +Cooldown, +Projectiles, and Overclocked

Both are Tri-Burst Cannon weapons, but they are different weapon instances.

## 3. What Is A Generated Weapon Reward?

A generated weapon reward is a random weapon instance created by the loot system during a run.

It has:

- Weapon name
- Family
- Rarity
- Archetype
- Shape identity
- Random stat rolls
- Modifier rolls if rarity allows them
- Power score

Generated weapon rewards currently appear as sector-clear reward choices, not as normal enemy drops.

## 4. Difference Between XP, Upgrades, Sector Rewards, Weapon Rewards, Armory, Stash, And Equipped Weapons

XP pickups:

- Dropped by enemies.
- Collected by moving near them.
- Fill the XP bar.
- Cause level-ups.
- They are not weapons.

Level-up upgrades:

- Appear when XP fills the level bar.
- Usually improve run stats such as damage, fire rate, health, pickup range, orbit count, or existing weapon strength.
- They are immediate run upgrades.
- They are separate from generated weapon loot.

Sector rewards:

- Appear after clearing a sector boss or sector objective.
- Pause the game with a reward choice panel.
- Current sector rewards include one generated weapon reward plus other reward/stat choices.

Generated weapon rewards:

- A specific kind of sector reward.
- Creates a random weapon instance.
- Opens a loot decision console when selected.
- Lets the player equip, replace, stash, or scrap/skip the weapon.

Weapons in the Armory:

- The title-screen weapon management screen.
- Shows equipped weapons and stash weapons.
- Lets the player inspect, compare, and swap stashed weapons into equipped slots.

Weapons in the stash:

- Owned weapons that are stored but not active.
- They do not fire during gameplay.
- They can be equipped later from the Armory.

Equipped weapons:

- Weapons currently in the player's active loadout.
- They automatically run during gameplay.
- They are what Start Game uses when a new run begins.

Run weapons / bonus run arsenal:

- Temporary weapons added during the current run by specific boss, mini-boss, or Warden reward cards.
- A `NEW RUN WEAPON` starts firing immediately when selected.
- It does not need Armory equipment.
- It does not replace one of the 8 equipped loadout weapons.
- It is run-only unless another separate loot/save route stores the weapon elsewhere.

## 5. How Does The Player Get A New Weapon During A Run?

Current intended flow:

1. Start a run.
2. Clear a sector.
3. The sector-clear reward panel appears.
4. One of the reward choices is a generated weapon reward.
5. Select that weapon reward.
6. The weapon loot decision console opens.
7. Choose what to do with the weapon: equip, replace, stash, or scrap/skip.

Separate run-weapon flow:

- Some boss/mini-boss/Warden cards say `NEW RUN WEAPON`.
- Selecting that card adds the weapon to the current run arsenal immediately.
- It starts firing during the run.
- It does not open the Armory equip flow.
- It does not replace an equipped loadout slot.

New weapons do not currently drop directly from regular enemies.

## 5A. Equipped Weapons vs Run Weapons

Your 8 equipped weapons are your starting loadout.

Equipped loadout weapons:

- chosen from Armory,
- shown in the right-side gameplay HUD,
- persistent/loadout-based,
- active automatically when a run starts.

Run weapons:

- selected during a run from boss/mini-boss/Warden rewards,
- start firing immediately,
- do not need Armory equip,
- do not replace the 8 equipped weapons,
- are run-only unless a separate loot/save system awards or stores them.

Runtime note:

- A `NEW RUN WEAPON` is added to the active runtime firing arsenal, not to the equipped loadout list.
- Its cooldown timer is primed so it can fire on the next unpaused weapon update.
- It remains active through current-run stat rebuilds and is cleared when the run ends, restarts, returns to title, or completes.

## 6. When Does A Weapon Go To The Stash?

A weapon goes to the stash when:

- The player chooses `SEND TO STASH` from an in-run weapon reward.
- The player chooses `REPLACE SLOT` from an in-run weapon reward; the old equipped weapon is sent to stash.
- The player swaps a stash weapon into an equipped slot from the Armory; the old equipped weapon is moved back into the stash position.

Stashed weapons are saved.

Stashed weapons do not affect gameplay until equipped.

## 7. When Does A Weapon Become Equipped?

A weapon becomes equipped when:

- It is part of the default starting loadout on a new save.
- The player equips a stash weapon from the Armory.
- The player chooses `EQUIP NOW` from an in-run weapon reward and there is an open equipped slot.
- The player chooses `REPLACE SLOT` from an in-run weapon reward and confirms a slot to replace.

Once equipped, it becomes active immediately during the current run or at the start of the next run.

A `NEW RUN WEAPON` is different. It becomes active for the current run without becoming equipped.

## 8. How Many Weapons Can The Player Equip Right Now?

The current equipped weapon cap is 8.

The default new-save loadout already fills all 8 slots:

- Pulse Blaster
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine
- Prism Lance
- Ring Saw
- Hex Shatter

This means a new generated weapon usually cannot simply become a ninth weapon. The player normally has to replace an existing equipped slot or send the new weapon to stash.

A `NEW RUN WEAPON` is the exception because it is not an equipped slot. It is a temporary run-only addition, enters the active firing arsenal immediately, and does not change the 8-slot loadout cap.

## 9. Are Equipped Weapons Automatic Or Button-Fired?

Equipped weapons are automatic.

The player does not press a fire button for each weapon.

During gameplay, each equipped weapon checks its own cooldown and fires or triggers automatically when it can.

For aimed projectile weapons:

- If the player is aiming, the weapon uses the aim direction.
- If the player is not aiming, the weapon targets the nearest enemy in range.

For area/orbit/control weapons:

- They trigger around the player, around enemies, or through their own targeting logic.

## 10. How Does The Game Decide Which Weapon Fires?

The game does not choose only one weapon at a time.

Every equipped weapon family is enabled in the runtime weapon router.

Each enabled weapon has its own timer. When that timer reaches zero and caps allow it, that weapon fires or activates.

Example:

- Pulse Blaster may fire often.
- Nova Burst may pulse less often.
- Ring Saw may check contact around the player.
- Prism Chain may jump between nearby enemies.
- Star Pulse may trigger as a timed radial burst.

All equipped weapons can be active in the same run.

## 11. How Does The Armory Affect Start Game?

Start Game reads the saved equipped weapon list.

If the player swaps a weapon in the Armory, that saved equipped list changes.

When Start Game begins a run, the runtime weapon router enables the weapon families in the equipped list.

## 12. If I Equip A Weapon In The Armory, What Should I See When I Start A Run?

Expected player experience:

1. The weapon appears in the Armory equipped list.
2. The old equipped weapon moves to stash.
3. Start Game begins with the new loadout.
4. The equipped weapon automatically activates during combat.
5. You should see that weapon's projectile, beam, orbit, field, or pulse behavior.

Important current limitation:

- The HUD does not yet have clear dedicated chips/icons for every Phase 23 weapon.
- Some new weapons are easiest to confirm by watching the combat visuals, not by reading the HUD.

## 13. If I Receive A Weapon Reward During Sector Clear, What Choices Do I Get?

The weapon reward console gives these choices:

- `EQUIP NOW`
- `REPLACE SLOT`
- `SEND TO STASH`
- `SCRAP / SKIP`

The result is shown before combat resumes.

## 14. If All Equipped Weapon Slots Are Full, What Is Supposed To Happen?

If all 8 equipped slots are full:

- `EQUIP NOW` cannot add the weapon as a ninth weapon.
- It routes to the replacement flow.
- `REPLACE SLOT` opens the slot picker.
- The player chooses which equipped weapon to replace.
- The new weapon becomes equipped.
- The old equipped weapon goes to stash.

If the stash is full, replacement is blocked so the old weapon is not lost.

## 15. What Does SCRAP / SKIP Do Right Now?

`SCRAP / SKIP` rejects the generated weapon.

Current behavior:

- The weapon is not equipped.
- The weapon is not stored.
- The player gets `+500` score.
- The run continues.

There is no full salvage currency or crafting system yet.

## 16. How Do Random Stats Affect Actual Gameplay?

Random stats are added to the equipped weapon family.

Connected stat examples:

- Damage bonus increases that weapon's damage.
- Fire rate bonus makes supported weapons trigger faster.
- Cooldown reduction lowers supported weapon cooldowns.
- Projectile speed affects projectile movement.
- Lifetime affects projectile or field duration.
- Range affects area, orbit, beam, or field size where supported.
- Projectile count can add a shot where supported.
- Split count adds shards where supported.
- Pierce lets supported projectiles hit more enemies.
- Chain count lets supported beams jump to more targets.
- Orbit count adds orbiting/blade count where supported.
- Ricochet gives supported projectile weapons one safe bounce.

Important current limitation:

- Some generic modifiers are more useful on some weapon families than others.
- The system is real, but not every modifier has a unique custom behavior on every weapon yet.

## 17. Which Phase 23 Weapons Are Active And Playable?

These Phase 23 weapons are active and playable:

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

They are not just placeholder names. Each has runtime behavior.

## 18. Phase 23 Weapon Details

### Tri-Burst Cannon

How the player obtains it:

- It can appear as a generated weapon reward after Sector 1 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- During a run: choose its weapon reward, then choose `REPLACE SLOT` or `EQUIP NOW` if an open slot exists.
- From title: open Armory, select an equipped slot, select Tri-Burst Cannon from stash, confirm the swap.

What it does:

- Automatically fires three triangular neon bolts in a spread.

Visual effect to watch for:

- Three small triangle/prism shots leaving the player in a fan pattern.

Manual confirmation:

- Equip it, start a run, stand near enemies, and watch for repeated three-shot triangular spread fire.

### Hex Mortar

How the player obtains it:

- It can appear as a generated weapon reward after Sector 2 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Use the in-run weapon reward replacement flow, or swap it from stash into an equipped slot in the Armory.

What it does:

- Automatically launches a slower arcing hex shell.
- The shell bursts into capped smaller hex shards.

Visual effect to watch for:

- A hexagonal shell rising/arching, then popping into hex shard projectiles.

Manual confirmation:

- Equip it and watch for slower orange/cyan hex mortar shots that burst instead of flying straight like Pulse Blaster.

### Vector Spear

How the player obtains it:

- It can appear as a generated weapon reward after Sector 1 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically fires a long, fast piercing rail/arrow projectile.

Visual effect to watch for:

- A long cyan/white spear or rail line shooting through enemies.

Manual confirmation:

- Equip it and look for long piercing shots that travel faster and straighter than most projectiles.

### Orbital Saw Array

How the player obtains it:

- It can appear as a generated weapon reward after Sector 2 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically creates rotating saw-shard damage around the player.

Visual effect to watch for:

- Small saw-like burst points circling at a ring distance around the player.

Manual confirmation:

- Equip it, let enemies approach, and watch for rotating ring-blade bursts damaging enemies near the orbit radius.

### Prism Chain

How the player obtains it:

- It can appear as a generated weapon reward after Sector 2 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically chains segmented beam damage from the player through nearby enemies.

Visual effect to watch for:

- Cyan prism-link beams connecting from the player to one enemy and then to additional enemies.

Manual confirmation:

- Equip it and wait until several enemies are near each other. Look for short segmented chain beams jumping between targets.

### Gravity Well

How the player obtains it:

- It can appear as a generated weapon reward after Sector 3 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically creates a short-lived pull field near the player.
- The field pulls enemies and damages them.

Visual effect to watch for:

- A dark void core with purple/cyan rings.

Manual confirmation:

- Equip it, start combat, and watch for a circular gravity field appearing near the player and tugging enemies inward.

### Nova Needle

How the player obtains it:

- It can appear as a generated weapon reward after Sector 1 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically fires fast, tiny needle shots.

Visual effect to watch for:

- Thin diamond/needle shots with quick cyan streaks.

Manual confirmation:

- Equip it and watch for frequent small, fast shots that are visually thinner than Pulse Blaster.

### Fractal Bloom

How the player obtains it:

- It can appear as a generated weapon reward after Sector 2 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically fires a projectile that splits into a controlled fan of triangular shard children.

Visual effect to watch for:

- A larger bloom projectile that bursts into magenta/cyan triangular shard fans.

Manual confirmation:

- Equip it and watch for a slower shot that breaks into multiple triangular fragments on hit or expiry.

### Shield Breaker

How the player obtains it:

- It can appear as a generated weapon reward after Sector 1 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically fires a slower, heavier piercing shot.

Visual effect to watch for:

- A thick square/diamond hammer-like shard shot.

Manual confirmation:

- Equip it and look for larger, slower heavy projectiles that hit harder and pierce.

### Star Pulse

How the player obtains it:

- It can appear as a generated weapon reward after Sector 1 clear or later.
- It can also be equipped from the Armory if already stored in the stash.

How to equip it:

- Replace an equipped slot during the reward flow, or equip it from stash in the Armory.

What it does:

- Automatically emits a timed radial burst around the player.

Visual effect to watch for:

- A star-shaped radial pulse with spokes around the player.

Manual confirmation:

- Equip it, let enemies enter the area around the player, and wait for the timed starburst to flash and damage nearby enemies.

## 19. Is There A Player-Facing Way To Force-Test Each Weapon?

No.

There is not currently a player-facing force-test menu, debug selector, weapon spawn console, or guaranteed weapon picker.

## 20. What Does That Mean Practically?

If the weapon is already in your stash:

- You can test it from the title screen through the Armory.

If the weapon is not already in your stash:

- You cannot force it from the title screen.
- You must play until a generated weapon reward randomly offers it.
- That makes manual testing of a specific new Phase 23 weapon slower than it should be.

This is a real usability/testing limitation in the current system.

## 21. Exact Steps To Test One Specific New Weapon From The Title Screen

These steps only work if the weapon is already in the stash.

To test Tri-Burst Cannon:

1. Launch the official build.
2. From the title screen, open `ARMORY`.
3. Move selection to an equipped slot you are willing to replace.
4. Move selection to the stash list.
5. Find `Tri-Burst Cannon`.
6. Press `A / Enter` to equip it into the selected equipped slot.
7. Confirm the equipped list now shows `Tri-Burst Cannon`.
8. Back out to the title screen.
9. Choose `START GAME`.
10. During combat, do not expect a fire button.
11. Watch for automatic three-shot triangular spread fire from the player.
12. If you see repeated triangle bolt fans, Tri-Burst Cannon is working.

If Tri-Burst Cannon is not in the stash:

1. Start Game.
2. Clear Sector 1.
3. Check the sector-clear reward choices.
4. If the generated weapon reward is Tri-Burst Cannon, select it.
5. Choose `REPLACE SLOT`.
6. Pick an equipped slot to replace.
7. Confirm the result.
8. In the next sector, watch for automatic three-shot triangular spread fire.
9. If the reward is not Tri-Burst Cannon, there is currently no player-facing way to force that exact roll.

The same testing pattern applies to the other Phase 23 weapons:

- Open Armory if the weapon is already stashed.
- Equip it into an equipped slot.
- Start Game.
- Watch for that weapon's automatic visual behavior.

## 22. Current Limitations

Current limitations:

- No player-facing force-test tool for specific weapons.
- No guaranteed way to pick a specific Phase 23 weapon from a normal new save.
- Default loadout already fills all 8 equipped slots, so new rewards usually require replacement.
- HUD does not clearly label every active Phase 23 weapon during combat.
- Armory has no sorting/filtering yet.
- Stash has no favorite/lock UI yet.
- Some modifiers are generic and do not have unique custom behavior on every weapon family.
- No enemy-dropped live weapon loot yet.
- No salvage currency or crafting system yet.

## 23. What Is Real Gameplay Now?

Real gameplay now:

- Weapon families exist.
- Weapon instances exist.
- Rarity tiers exist.
- Random stat rolls exist.
- Modifier rolls exist.
- Equipped slots drive runtime weapon behavior.
- Armory swaps can change Start Game loadout.
- Stash stores unequipped weapons.
- Sector reward weapon loot creates generated weapons.
- In-run reward choices can equip, replace, stash, or scrap/skip.
- Phase 23 weapons are active when equipped.
- Random stats affect damage, cooldown/rate, speed, range, lifetime, split count, pierce, chain count, orbit count, and related supported behavior.

## 24. What Is Backend Or Future Foundation?

Backend/future foundation:

- 200+ weapon scaling is planned but not implemented.
- Full stash sorting/filtering is not implemented.
- Weapon comparison is functional but still basic.
- Dedicated icon art for every weapon family is not implemented.
- Manual force-test tools are not implemented.
- Live enemy weapon drops are not implemented.
- Salvage economy is not implemented.
- Deep behavior-changing affixes are not fully implemented.
- Full RPG progression, unlocks, and long-term weapon collection are not implemented yet.
