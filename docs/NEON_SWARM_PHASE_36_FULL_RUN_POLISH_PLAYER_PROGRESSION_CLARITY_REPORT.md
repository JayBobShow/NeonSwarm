# Neon Swarm Phase 36 Full Run Polish / Player Progression Clarity Report

## 1. Executive Summary

Phase 36 improves player-facing clarity across the active four-sector run. It does not add sectors, enemies, bosses, weapons, or balance changes. The pass focuses on clearer run start, sector entry, sector clear, boss, event, reward, weapon progression, Neon Dust, Forge, evolution/fusion, death, and run-complete feedback.

Neon Swarm remains in active development and is not a release candidate.

## 2. Approved Baseline Preserved

- Official scene remains `scenes/Main.tscn`.
- Official run command remains `godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`.
- Sector 4, Phase 34 events, chain weapon hotfixes, Armory/Stash, Weapon Forge, Evolution/Fusion, Neon Dust, bosses, Wave Director, title/menu flow, controller support, and save compatibility were preserved.
- No alternate playable scene was created.

## 3. Run Flow Clarity Changes

- Added a reusable sector display helper for `SECTOR 01 // NEON GRID` style text.
- Added sector identity text:
  - Sector 1: `BASELINE SWARM PRESSURE`
  - Sector 2: `DISTORTED PRISM FORMATIONS`
  - Sector 3: `VOID PRESSURE RISING`
  - Sector 4: `OVERCLOCKED RAIL NETWORK`
- Start Game now posts a readable run-start sector notice.
- The combat notice rail was widened slightly so full-run state messages fit better.

## 4. Sector Transition Changes

- Sector clear reward panel now states:
  - boss defeated
  - reward unlocked
  - Neon Dust banked
  - next sector
- Entering a new sector now posts a sector entry notice using the sector number, name, and identity text.

## 5. Reward Feedback Changes

- Sector reward cards now distinguish `RUN UPGRADE` from `GENERATED WEAPON SYSTEM`.
- Run upgrade choices show effect text more directly.
- Event completion notices now include XP, score, and Neon Dust when awarded.
- Reward result text now starts with `RESULT:` so the outcome is easier to parse.

## 6. Weapon Progression Clarity Changes

- Added a shared weapon progression summary for result messages:
  - rarity
  - weapon name
  - power score
  - Forge rank when present
  - Evolution rank when present
- Weapon reward results now explicitly say whether the weapon was equipped, replaced, stashed, or scrapped.
- Replacement results name the new weapon and say the old weapon moved to stash.
- Scrap results show Neon Dust gained and current total.

## 7. Neon Dust / Meta Progression Clarity

- Forge confirmation now shows cost and remaining Neon Dust before spending.
- Core Upgrade confirmation now shows cost and remaining Neon Dust before spending.
- Forge/Core purchase result text now shows Dust spent and remaining total.
- Death/run-complete summaries now use clearer labels:
  - result
  - score
  - kills
  - sectors cleared
  - weapons gained
  - Neon Dust earned this run
  - current Neon Dust total

## 8. Boss / Run Complete Clarity

- Boss warning text now explains the objective:
  - normal sectors: defeat boss to clear sector
  - final sector: defeat Null Octagon Prime to complete the run
- Boss arrival text now explains that the reward or run complete state comes from defeating the boss.
- Boss defeat text now says `SECTOR REWARD UNLOCKED` or `RUN COMPLETE`.
- Run Complete panel subtitle now states `SECTOR 04 // HYPER GRID CLEARED`.

## 9. Event Clarity Preservation

Phase 34 event instructions remain intact. This pass only clarifies reward output after events complete:

- Data Cache reward notice now includes XP and score.
- Rift Surge reward notice now includes XP and score.
- Elite Hunt reward notice now includes XP and score.
- Overload Node reward notice now includes XP, score, and Neon Dust if awarded.

## 10. Files Changed

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_36_FULL_RUN_POLISH_PLAYER_PROGRESSION_CLARITY_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`

## 11. Validation Results

Passed:

- `git status`
- `godot --headless --path . --quit-after 3`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`
- `godot --headless --path . --script /tmp/neon_swarm_phase36_clarity_validation.gd`
- `git diff --check`
- `git diff --stat`

Focused validation covered:

- run start state safety
- sector transition/sector identity notice text
- upgrade reward notice text
- weapon progression summary text
- death/run-complete summary safety
- return-to-title cleanup

## 12. Exact Run Command

`godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`

## 13. What The User Should Test

Quick full-run clarity test:

1. Launch the official build.
2. Start Game and confirm the Sector 1 run-start notice is readable.
3. Level up and confirm selected upgrade feedback is clear.
4. Clear Sector 1 and confirm the reward panel says boss defeated, Dust banked, and next sector.
5. Choose a generated weapon reward and test Equip / Replace / Stash / Scrap result text.
6. Use Armory Forge and confirm cost/remaining Dust messaging.
7. Reach each sector and confirm sector entry text appears.
8. Trigger events and confirm reward notices show XP/score/Dust clearly.
9. Defeat bosses and confirm reward/run-complete messaging is understandable.
10. Die or complete the run and review the summary.

## 14. Known Issues

- This is a text/presentation clarity pass; it does not redesign the HUD.
- Full-run pacing and subjective timing still need manual playtest review.
- Some notices are intentionally concise to avoid covering combat.

## 15. Approval Question

Is Phase 36 approved as the full-run polish and player progression clarity pass, or should another focused clarity hotfix be made before Phase 37?
