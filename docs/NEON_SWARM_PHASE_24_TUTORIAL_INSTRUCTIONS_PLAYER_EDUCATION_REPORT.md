# Neon Swarm Phase 24 - Tutorial / Instructions / Player Education Report

## 1. Executive Summary

Phase 24 adds player-facing instruction surfaces so Neon Swarm explains its current systems in-game.

Added:

- Title menu `HOW TO PLAY` entry.
- Pause menu `HOW TO PLAY` entry.
- Seven-section How To Play instruction console.
- First-run non-blocking tutorial prompts with saved hint state.
- Reward screen micro-explanations for generated weapon systems.
- Armory help text explaining equipped weapons, stash weapons, swaps, and Start Game loadout behavior.

No weapons, sectors, enemies, bosses, HUD redesigns, title redesigns, alternate playable scenes, or hidden playable scenes were created.

## 2. Approved Phase 23 Baseline Preserved

Preserved:

- Official build path: `scenes/Main.tscn`
- Start Game, Armory, Options, Quit
- Pause menu, Resume, Return to Title, Quit Game
- Settings save/load, audio, mute, fullscreen, VFX intensity
- HUD, XP, level-up, sector rewards
- Generated weapon rewards and replacement UI
- Runtime weapon loadouts and stash backend
- Current sectors, bosses, RUN COMPLETE, death/restart, success/restart
- Keyboard/controller action mapping
- Neon-glass HUD/menu style and neon tube edge style
- Existing performance caps

## 3. How To Play Menu

Title menu now shows:

- `START GAME`
- `ARMORY`
- `OPTIONS`
- `HOW TO PLAY`
- `QUIT`

`HOW TO PLAY` opens a neon-glass instruction console using the existing angular menu button style and ship/core cursor.

Back behavior:

- From title, `B / Esc / Start` closes Help and returns to title menu focus.
- From pause, `B / Esc / Start` closes Help and returns to the pause menu.

## 4. Tutorial Sections Added

The How To Play console includes seven sections:

- `BASIC CONTROLS`
- `CORE LOOP`
- `XP AND LEVEL-UPS`
- `WEAPON SYSTEMS`
- `SECTOR REWARDS`
- `ARMORY / STASH`
- `SECTORS / BOSSES`

Key explanations covered:

- Movement, aim, pause, and menu navigation.
- Survive waves, kill enemies, collect XP, level up, clear sectors, and reach RUN COMPLETE.
- XP is not weapon loot.
- Equipped weapons fire automatically.
- Start Game uses the equipped loadout.
- Generated weapon rewards are random weapons with rarity and stat rolls.
- Weapon rewards can be equipped, replaced, stashed, or scrapped/skipped.
- Stash weapons are stored and inactive until equipped.

## 5. First-Run Prompts

Added compact first-run prompts:

- Armory/loadout note.
- XP shard note.
- Automatic weapon note.
- Sector reward note.
- Weapon loot note.

Behavior:

- Prompts use a small neon HUD plate.
- Prompts are non-blocking and auto-hide.
- Prompts avoid major modal screens such as Options, Armory, Help, pause, level-up, and weapon reward decisions.
- Prompt completion is stored in `user://neon_swarm_settings.cfg`.

## 6. Pause Menu Help Access

Pause menu now shows:

- `RESUME`
- `OPTIONS`
- `HOW TO PLAY`
- `RETURN TO TITLE`
- `QUIT GAME`

Opening Help from pause does not unpause the run, does not reload the scene, and does not alter gameplay state.

Back returns to the pause menu. Resume still returns to gameplay.

## 7. Reward Screen Explanation Changes

Sector weapon reward cards now label weapon loot as:

- `GENERATED WEAPON SYSTEM`
- `Random weapon with rarity/stat rolls.`

The in-run weapon reward console title now says:

- `GENERATED WEAPON SYSTEM // [RARITY]`

The action prompt now explains:

- Equipped weapons auto-fire.
- Stashed weapons can be managed in Armory.
- Scrap skips for score.
- Replacing a slot moves the old equipped weapon to stash.

Action labels remain:

- `EQUIP NOW`
- `REPLACE SLOT`
- `SEND TO STASH`
- `SCRAP / SKIP`

## 8. Armory Help Changes

Armory now includes compact help text:

- Equipped weapons are active during runs.
- Stash weapons are stored only.
- `A` swaps a stash weapon into the selected equipped slot.
- Start Game uses the equipped loadout.

This keeps the existing Armory layout and adds explanation without redesigning the screen.

## 9. Controls / Navigation

Supported:

- Keyboard navigation.
- Controller/action navigation.
- `A / Enter` select.
- `B / Esc` back.
- Arrow keys / D-pad section navigation.
- Start button backs out of Help instead of trapping the player.

Validated:

- Title Help opens and closes.
- Pause Help opens and returns to pause.
- Help sections change with navigation.
- Armory and reward helper text remain readable through existing UI surfaces.

## 10. Files Changed

Changed:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_24_TUTORIAL_INSTRUCTIONS_PLAYER_EDUCATION_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`

Temporary validation script used from `/tmp`:

- `/tmp/neon_swarm_phase24_tutorial_validation.gd`

No alternate playable scenes or hidden test scenes were created.

## 11. Validation Results

Required validation:

- PASS: `godot --headless --path . --quit-after 3`
- PASS: `godot --headless --path . --quit-after 3000`
- PASS: `godot --headless --path . scenes/Main.tscn --quit-after 3`

Phase 24 education validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase24_tutorial_validation.gd`
- Output: `PHASE24_TUTORIAL_PASS title_help=true pause_help=true pages=7 reward_copy=true armory_help=true prompts=true`

Regression validation:

- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase22_weapon_reward_flow_validation.gd`
- Output: `PHASE22_REWARD_FLOW_PASS equip_now=true replace=true stash=true scrap=true reloaded=true`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase22_full_flow_validation.gd`
- Output: `PHASE22_FULL_FLOW_PASS weapon_rewards=3 equipped=8 stash=8 run_success=true`
- PASS: `godot --headless --path . --script /tmp/neon_swarm_phase19_runtime_stress.gd`
- Output: `PHASE19_RUNTIME_STRESS_PASS sector=Null Zone enemies=13/54 player_projectiles=0/36 enemy_projectiles=0/28 bursts=3/18 equipped=8 stash=5`

Validation note:

- Older Phase 19/20 count-specific scripts that expect the previous four-button pause menu or previous title menu count are now stale after the intentional `HOW TO PLAY` additions. Phase 24 validation supersedes those menu-count assumptions.

## 12. Exact Run Command

Official editor run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 13. What The User Should Test

Manual test checklist:

- Launch the official build.
- Confirm title menu shows `HOW TO PLAY`.
- Open Help from title.
- Navigate all seven Help sections.
- Back out to title.
- Open Armory and read the compact equipped/stash help text.
- Start Game.
- Confirm first-run prompts are small and non-blocking if not already shown in your settings.
- Pause during gameplay.
- Open Help from pause.
- Back out to pause, then Resume.
- Clear a sector and select a generated weapon reward.
- Confirm weapon reward wording explains generated weapon systems, auto-fire, stash, and scrap.
- Confirm Options, Return to Title, Quit, death/restart, success/restart, XP, level-up, sectors, and weapon rewards still work.

## 14. Known Issues

- Help pages are text-based and do not yet include dedicated weapon-family icons or animated examples.
- First-run prompts are remembered globally through settings; there is no in-game reset tutorial button yet.
- Physical controller hardware still needs manual confirmation even though action-based navigation validation passed.
- Legacy validation scripts that assert old menu counts need updating if reused later.

## 15. Approval Question

Is Phase 24 approved as the tutorial/instruction/player education UI pass, with Phase 25 held until explicitly approved?
