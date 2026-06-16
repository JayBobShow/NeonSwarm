# Neon Swarm Full Game Roadmap

## 1. Current Development Status

Neon Swarm is an active-development neon arena survival RPG / roguelite, not a finished build.

Current approved baseline:

- Title screen works.
- Options and saved settings work.
- How To Play instruction menu and first-run tutorial prompts exist.
- Procedural audio and volume controls work.
- HUD, pause, restart, death, rewards, XP, and level-up flows work.
- The official run is implemented in `scenes/Main.tscn`.
- The current prototype run now has four playable sectors after Phase 18 foundation work.
- Phase 30 adds the first Wave Director foundation and elite enemy variants using existing enemy families.
- Phase 31 adds the first boss encounter telegraph foundation for readable delayed boss attacks and phase feedback.
- Phase 34 adds the first Run Objective / Sector Event foundation so sectors can include readable mid-run goals beyond pure survival.

Major development still needed:

- More sectors beyond the current prototype foundation.
- More enemy families and behavior variety.
- More bosses and boss patterns.
- More weapons and upgrade synergies.
- Weapon loot, random stats, rarity, comparison, equipped loadouts, and stash systems.
- RPG-style progression and stronger long-term player goals.
- Stronger progression and replayability.
- Better long-term run structure.
- Continued sector background depth and authored art polish beyond the Phase 26 procedural upgrade.
- Updated player, enemy, and boss graphics.
- Storyline, opening scene, and possible cutscenes.
- Professional audio/music direction beyond placeholder procedural foundations.
- More polish, balancing, accessibility, and content depth.

Long-term expansion reference:

- `docs/NEON_SWARM_LONG_TERM_RPG_ROGUELITE_EXPANSION_PLAN.md`

Phase 19 foundation references:

- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_WEAPON_RARITY_AND_STAT_ROLLS.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`

## 2. Target Sector Structure

Target full-game sector count: six core sectors before optional challenge/remix modes.

Current and planned sectors:

| Sector | Name | Status | Role | Geometry Identity |
| --- | --- | --- | --- | --- |
| 1 | Neon Grid | Implemented with Phase 26 Hard Reset HD background plate | Opening sector, teaches movement, XP, rewards, and boss clear flow. | HD square/rectangle cyan-blue arena plate with connected circuit paths and sparse light runners. |
| 2 | Prism Rift | Implemented with Phase 26 Hard Reset HD background plate | Middle pressure, fractures, stronger enemy mixes, Fractal Crown event. | HD diamond/triangle prism plate with magenta/purple/cyan angular route lighting. |
| 3 | Null Zone | Implemented with Phase 26 Hard Reset HD background plate | Darker late-run escalation and Null Octagon gatekeeper. | HD octagon/hex black-glass plate with slow purple/cyan polygon edge lighting. |
| 4 | Hyper Grid | Phase 35 active content pass implemented | Late-game/final-sector pressure using Rail Skimmer dash enemies, Grid Splitters, Hyper Grid elite variants, stronger event pressure, and Null Octagon Prime final buildup. | HD rail/stretched-diamond hyperlane plate with fast cyan/white lane runners. |
| 5 | Fractal Core | Planned | Deep build-check sector with heavier pattern variety. | Stacked triangles, recursive shards, crown-core motifs. |
| 6 | Singularity Swarm | Planned | Full-game final sector with dense but readable endgame pressure. | Rings, lens shapes, gravity arcs, singularity cages. |

Sector design rule: each sector should change pacing, enemy mix, boss placement, and geometry identity without requiring alternate playable scenes unless a future phase explicitly approves new level work.

## 3. Enemy Family Expansion

Current enemy families:

- Chaser: direct pursuit pressure.
- Tank: high-health blocker.
- Shooter: ranged firing pressure.
- Exploder: proximity burst danger.
- Spiral Drifter: curved movement pressure.
- Shield Node: defensive/support pressure.
- Hex Slicer: dash melee pressure.
- Prism Leech: hazard trail/area denial.
- Triad Splitter: capped split-on-death swarm pressure.
- Hex Pulser: telegraphed proximity pulse pressure.

Phase 30 Wave Director status:

- Sector spawn profiles now use a simple director model with intro, pressure, peak, warning, boss, and cleanup pacing.
- Sector enemy mixes are weighted differently so Neon Grid, Prism Rift, Null Zone, and Hyper Grid no longer feel like the same spawn rhythm.
- Elite variants are implemented on existing enemy families only: Overcharged, Armored, Shielded, Volatile, and Splitter Elite.
- Elites are capped by sector, delayed out of the opening wave, blocked during active boss fights, and separated by cooldowns.
- Elite rewards currently add extra XP/score and a small chance for Neon Dust without creating a new loot-drop system.

Planned enemy families:

- Rail Lancer: stretched diamond/arrow silhouette that charges along straight rails.
- Mirror Shard: diamond shard that briefly reflects or redirects movement lanes.
- Fractal Seed: limited add-summoner with strict caps, reserved for later sectors.
- Singularity Anchor: slow gravitational zone controller, used sparingly.
- Phase Gate: stationary or low-mobility shape that changes spawn lanes.

Enemy expansion rules:

- Every enemy needs unique geometry, readable silhouette, distinct behavior, fair counterplay, and cap-safe implementation.
- Avoid recolored chasers.
- Avoid diluting octagon language, which should remain elite/null-family language.

## 4. Boss Roster

Current bosses/events:

- Prism Warden: Sector 1 boss, octahedron command threat.
- Fractal Crown: Sector 2 boss event, stacked triangle/crown threat.
- Null Octagon: Sector 3 gatekeeper boss.
- Null Octagon Prime: current Sector 4 final prototype boss.

Planned boss roster:

- Hyper Rail Monarch: planned Sector 4 alternate boss candidate, stretched diamond/rail language.
- Fractal Core Regent: planned Sector 5 major boss, recursive triangle/crown language.
- Singularity Heart: planned Sector 6 final boss, ring/lens/gravity cage language.
- Optional remix bosses: later challenge-mode variants only after base content is stable.

Boss rules:

- Bosses should be readable at arena scale.
- Boss warning, phase shift, projectile language, adds, and death burst must be distinct.
- Boss overlap should remain controlled by trimming non-boss enemies and clearing hostile hazards on boss entry.

Phase 31 boss encounter status:

- Boss attacks now use a capped telegraph queue before release instead of firing every major attack instantly.
- Prism Warden rotates between shard fan, beam lane, and shield-pulse patterns.
- Fractal Crown telegraphs crown burst, line pattern, and shard-summon attacks with phase-two escalation.
- Null Octagon telegraphs void ring, void pulse, and add-vector attacks with phase feedback.
- Null Octagon Prime adds stronger multi-ring and Hyper Grid rail-sweep telegraphs.
- Boss HUD labels append `PHASE 2` when a boss enters escalation.

Phase 34 run objective status:

- A lightweight Run Event Director now controls one active sector objective at a time.
- Current event types are Data Cache, Rift Surge, Elite Hunt, and Overload Shrine / Power Node.
- Events are blocked during title/menu/Armory/Forge/pause/reward states and near boss windows.
- Event rewards are modest score, XP burst pickups, and capped Neon Dust chance.
- Event markers use current runtime neon geometry; future phases can replace them with authored Blender props if approved.

## 5. Weapon Roster

Current weapons:

- Pulse Blaster
- Orbit Spark
- Nova Burst
- Arc Beam
- Gravity Mine
- Prism Lance
- Ring Saw
- Hex Shatter
- Fractal Shard
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

Phase 19 architecture status:

- Current weapons are now mapped into weapon definitions and weapon instances.
- Generated weapon rewards can roll rarity, stat rolls, modifier rolls, and comparison data.
- Generated sector weapon rewards can affect gameplay when equipped directly or later swapped in from the Armory.
- Stash backend exists for generated weapons that are not equipped.

Phase 20 Armory status:

- Title menu Armory entry exists.
- Equipped and stashed weapons can be viewed.
- Weapon detail and comparison text is visible.
- Phase 20 established the first player-facing Armory/Stash UI.

Phase 21 runtime loadout status:

- Equipped weapon instances now drive which weapon family logic runs.
- Armory swaps can replace the selected equipped slot across weapon families.
- Previous equipped weapons return to stash during swaps.
- Saved loadout changes affect the next active run.

Phase 22 in-run reward status:

- Generated sector weapon rewards now open a loot decision console.
- The player can equip into an open slot, replace an equipped slot, send to stash, or scrap/skip.
- Replacement affects the current runtime loadout immediately and saves the loadout.
- Old equipped weapons move to stash when replaced.
- Scrap/skip rejects the weapon and now grants saved Neon Dust based on rarity.

Phase 28 Neon Dust / Core Upgrade status:

- Neon Dust is persistent and saved in the weapon inventory save file.
- Scrapping stored weapons grants Neon Dust by rarity.
- Sector clear, run complete, and death/end-run summaries can report run Neon Dust gains.
- Core Upgrades give modest persistent bonuses for health, XP pickup range, global weapon damage, and cooldown.

Phase 29 Weapon Forge status:

- Weapon Forge is accessible from the existing Armory actions.
- Equipped and stashed weapons can be selected for Forge actions.
- Upgrade Power spends Neon Dust to add modest permanent stat bonuses to the selected weapon instance.
- Reroll Stats spends Neon Dust to reroll a selected weapon's random stat rolls while keeping family and rarity.
- Reroll Modifier spends Neon Dust to reroll modifier rolls where rarity supports modifiers.
- Forge changes save/load with each weapon instance and feed into runtime weapon stat totals when equipped.

Phase 32 Weapon Evolution / Fusion status:

- Weapon Forge now exposes `EVOLVE / FUSE` as a progression action for owned weapons.
- Fusion uses a primary weapon plus one compatible stash weapon as material.
- Same-family fusion is valid; same geometry compatibility group fusion is valid.
- Fusion consumes only the confirmed stash material, spends Neon Dust, and raises the primary weapon's saved `evolution_rank`.
- Evolution is capped at rank 3 and adds modest damage, cooldown, range, and lifetime bonuses through the same runtime stat aggregation path as normal rolls and Forge power.
- Evolved weapons show `EV#` row labels, detail-panel evolution rank, fusion group, evolution bonuses, and fusion history.

Phase 33 project safety / backup status:

- Git project safety has an explicit recovery and backup plan.
- Root README documents the active-development project and official run command.
- `tools/backup_neon_swarm.sh` creates timestamped archives under `~/GodotProjects/NeonSwarm_BACKUPS/`.
- Backup archives exclude Git metadata, Godot caches, import caches, build/export folders, temp/log/cache files, and Blender `.blend1` backups.

Phase 23 weapon content status:

- First weapon content pack adds 10 active loot families.
- New families have catalog definitions, rarity/stat rolls, modifier support, reward display, Armory/Stash display, runtime hooks, and save/load support.
- Modifier pool expanded to 15 bounded modifiers.
- Rarity tiers now influence modifier count more clearly.

Phase 24 player education status:

- Title menu includes `HOW TO PLAY`.
- Pause menu includes `HOW TO PLAY`.
- Instruction pages explain controls, core loop, XP/level-ups, weapon systems, sector rewards, Armory/Stash, and sectors/bosses.
- First-run tutorial prompts explain XP, automatic weapons, sector rewards, weapon loot, and Armory.
- Reward and Armory helper text now explains automatic equipped weapons, stash behavior, and Start Game loadout behavior.

Phase 25 / 27 weapon icon / preview art pipeline status:

- Do not manually create 200+ weapon images up front.
- Phase 25 implements one clear functional preview icon per active weapon family, plus a fallback unknown weapon icon.
- Phase 25 icons were approved as placeholder UI symbols, not final weapon art.
- Phase 27 Repair upgrades active weapon-family icons by rendering them from Blender weapon models where practical while preserving the same one-preview-per-family scaling rule.
- Icons use each weapon family's geometry shape identity as the visual source.
- Icons match the Neon Swarm dark-body, bright neon tube edge style.
- Icons now appear in Armory equipped/stash rows, selected weapon details, comparison panels, generated weapon reward cards, replacement slot rows, and How To Play weapon explanation pages.
- Readable family examples are active: triangle spread for Tri-Burst Cannon, hex shell for Hex Mortar, piercing arrow/rail for Vector Spear, neon ring/vortex for Gravity Well, radial starburst for Star Pulse, and rotating saw ring for Ring Saw.
- Future higher-quality weapon preview revisions should build on the Phase 27 Blender source/export pipeline.
- Future 200+ weapon scaling should reuse this one-family-preview mapping instead of requiring unique art for every random weapon instance.

Phase 26 sector background / arena visual upgrade status:

- Hard Reset changes the current direction to an asset-backed HD sector background system in the official arena.
- Keeps all gameplay in `scenes/Main.tscn`; no alternate playable scenes were added.
- Inkscape SVG source files exist for all four current sectors.
- Krita-ready layered ORA source files exist for all four current sectors.
- Krita-exported 4096x4096 PNG plates exist for all four current sectors.
- Godot loads the PNGs directly through `Image.load_from_file()` and renders them as sector background plates.
- Sector 1 now uses an HD square/rectangle cyan-blue arena plate with connected circuit paths.
- Sector 2 now uses an HD diamond/triangle prism plate with magenta/purple/cyan route lighting.
- Sector 3 now uses an HD octagon/hex black-glass plate with slow polygon edge lighting.
- Sector 4 now uses an HD rail/stretched-diamond hyperlane plate with fast lane runners.
- Adds sparse sector-authored `HDLightRunner_*` animation over the plates.
- Adds background opacity caps tied to VFX intensity.
- The rejected procedural grid/floor fragments, loose marker overlays, random diagonal scratches, rings, glyph spam, floating stickers, monoliths, pylons, gates, and warp effects are disabled from the active background path.
- Future authored sector art should improve the HD plates and Krita/Inkscape source pipeline, not return to the rejected procedural filler direction.

Planned weapon candidates:

- Rail Cutter: long straight-line beam/rail weapon, strong lane control.
- Singularity Well: capped gravity pulse weapon, area grouping without unbounded pull spam.
- Mirror Fan: angled shard fan with limited ricochet behavior.
- Core Overdrive: temporary fire-rate and damage burst tied to future progression or rare upgrades.

Weapon rules:

- No weapon should make older weapons obsolete.
- Every weapon must use existing caps or define a safe cap before implementation.
- Shape identity must be distinct from enemy projectile language.
- Future architecture must support 200+ weapons or weapon variants through definitions and generated instances, not one-off main-script branches.
- Weapon instances should support random stat rolls, rarity tiers, comparison data, equipped state, and stash storage.

## 6. Upgrade Categories

Current upgrade categories:

- Damage
- Fire rate
- Projectile count
- Pickup range
- Movement speed
- Max health/heal
- Orbit count
- Nova cooldown
- Beam duration
- Mine radius
- Prism Lance damage/pierce
- Hex Shatter damage/rate/split
- Fractal Shard unlock/damage/rate/split/lifetime/pierce
- XP reward economy
- Sector rewards

Planned categories:

- Rarity tiers
- Random weapon stats
- Weapon affixes/modifiers
- Weapon comparison stats
- Equipped loadout bonuses
- Weapon unlock weighting
- Weapon-specific branch upgrades
- Defensive mitigation and armor
- Build synergies
- Risk/reward upgrades
- Rerolls, bans, and locks
- Sector-specific reward pools
- Challenge modifiers

## 7. Progression Systems

Future progression should be planned before implementation.

Candidate systems:

- Unlockable weapons.
- Random weapon stat rolls.
- Weapon rarity tiers.
- Equipped weapon loadouts.
- Stash box / weapon storage.
- Weapon comparison UI.
- Unlockable player cores.
- Sector unlocks.
- Difficulty modifiers.
- Score/rank system.
- Challenge modes.
- Achievement-style goals.
- Post-run summary and rewards.

Phase 18 does not implement meta progression. The progression plan is tracked separately in `docs/NEON_SWARM_PROGRESSION_SYSTEM_PLAN.md`.

## 8. Replayability Systems

Replayability should eventually come from:

- Sector order variants after the baseline run is stable.
- Boss/event variants.
- Weapon unlock pools.
- Upgrade rarity and synergy paths.
- Challenge modifiers.
- Score/rank pressure.
- Daily/seeded runs if a future phase approves deterministic generation.

Avoid replayability systems that make the current run unreadable or grind-heavy.

## 9. Visual Polish Needs

Future visual work:

- Give Pulse Blaster a stronger faceted player-owned projectile shape.
- Give Prism Lance more actual prism geometry.
- Replace or upgrade the Phase 25 placeholder family icons in a future final weapon preview art pass.
- Continue refining the Phase 25 family-preview pipeline before scaling weapon count heavily.
- Consider future modifier glyphs separately from family icons.
- Continue refining Phase 26 sector depth into richer authored backgrounds only if readability stays intact.
- Improve boss phase-change visual readability.
- Improve sector-transition visual identity without adding visual mud.
- Continue balancing VFX intensity LOW/NORMAL/HIGH.

Visual rules stay locked:

- Dark body faces.
- Bright neon tube edges.
- Clean geometric silhouettes.
- No blurry blob replacements.
- No uncontrolled particle spam.

## 10. Audio / Music Needs

Current procedural music/SFX foundation should remain.

Future audio work:

- More distinct sector music layers.
- More boss-specific motifs.
- Cleaner dynamic intensity transitions.
- More mix testing on normal speakers/headphones.
- Optional music authoring/export pipeline if a later phase approves asset production.

Rules:

- No copyrighted audio.
- Master/Music/SFX/Mute settings must continue to work.
- No painful volume spikes or sound spam.

## 11. Future Export / Build Readiness

Export remains future-readiness work, not current release focus.

Future steps:

- Install matching Godot export templates only when explicitly approved.
- Recheck Linux export preset.
- Create Windows/macOS presets later if needed.
- Verify app icon/window title.
- Export smoke test builds.
- Document exact export commands and template requirements.
- Add packaging checks only after the game has more content depth.

Do not describe the game as finished or in any late-stage status until explicitly approved later.

## 12. Long-Term RPG / Roguelite Systems

Long-term target systems:

- 200+ weapons or weapon systems over time.
- Random weapon stats.
- Weapon rarity tiers.
- Weapon comparison.
- Equipped weapon loadouts.
- Stash box / weapon storage.
- RPG-style progression.
- Stronger sector backgrounds.
- Updated player graphics.
- Updated enemy graphics.
- Stronger boss graphics.
- Storyline.
- Opening scene.
- Possible cutscenes.
- Better audio and music.
- Professional SFX replacing placeholder procedural sounds over time.

Architecture rule:

- Build data architecture before adding volume. Do not manually create hundreds of weapons or dump content into the current script.

## 13. Future Phase Roadmap

Likely future phases:

| Phase | Focus | Notes |
| --- | --- | --- |
| Phase 19 | Weapon System Architecture + Random Stat Foundation | Implemented as foundation: definitions, instances, rarity, stat rolls, generated sector rewards, backend stash/save. |
| Phase 20 | Inventory/Stash UI Prototype | Implemented first Armory/Stash UI: equipped list, stash list, details, comparison, initial swap/save. |
| Phase 21 | True Weapon Loadout Runtime Integration | Implemented runtime weapon routing from equipped slots, cross-family Armory swaps, starter loadout guard, and saved loadout activation. |
| Phase 22 | In-Run Weapon Reward Replacement UI + Loot Decision Flow | Implemented equip now, replace slot picker, send to stash, scrap/skip, result confirmation, and save/runtime updates for generated weapon rewards. |
| Phase 23 | Weapon Content Pack 1 + Modifier Pool Expansion | Implemented 10 new active weapon families, expanded modifiers, stronger rarity behavior, runtime hooks, and loot UI support. |
| Phase 24 | Tutorial / Instructions / Player Education UI | Implemented How To Play from title/pause, first-run prompts, reward micro-explanations, and Armory help text. |
| Phase 25 | Weapon Icon / Preview Art Pipeline | Implemented family-level placeholder preview icons in Armory, stash rows, reward cards, replacement UI, and How To Play. Not final weapon art. |
| Phase 26 | Sector Background / Arena Visual Upgrade 1 | Hard Reset implements an Inkscape/Krita HD sector background pipeline, four 4096x4096 sector plates, Godot texture-backed background planes, sparse `HDLightRunner_*` animation, VFX opacity caps, and disabled rejected procedural clutter. |
| Phase 27 | Blender 3D Gameplay Asset Hard Reset Repair | Replaced failed flat PNG gameplay-object pass with Blender `.blend` sources, mesh-only `.glb` runtime models, GLTF runtime loading, and 3D-derived weapon icons where practical. No combat balance/content changes. |
| Phase 28 | Neon Dust Economy / Meta Progression Foundation | Adds saved Neon Dust, rarity-based stash/weapon scrap value, modest Core Upgrades, and death/run-complete economy summaries as the first persistent roguelite progression layer. |
| Phase 29 | Weapon Forge / Neon Dust Weapon Progression Foundation | Adds Armory Forge actions for owned weapons: Upgrade Power, Reroll Stats, and Reroll Modifier, with saved Neon Dust costs and conservative per-weapon progression. |
| Phase 30 | Enemy Wave Director / Elite Enemy Variety Foundation | Adds sector-aware wave pacing, sector-specific enemy mix pressure, capped elite enemy variants, and modest elite XP/score/Neon Dust hooks. |
| Phase 31 | Boss Encounter / Attack Telegraph Upgrade | Adds boss attack telegraphs, scheduled attack release, boss phase feedback, boss-specific attack patterns, and preserved boss reward flow. |
| Phase 32 | Weapon Evolution / Fusion Foundation | Adds Forge-based Evolve/Fuse with compatible stash-material consumption, saved evolution ranks, and modest runtime stat effects. |
| Phase 33 | Project Safety / Git / Backup Foundation | Adds root README, recovery/backup plan, and timestamped project backup script. No gameplay content changes. |
| Phase 34 | Run Objective / Sector Event Variety Foundation | Adds a lightweight Run Event Director plus Data Cache, Rift Surge, Elite Hunt, and Overload Shrine objectives with safe cleanup and modest rewards. |
| Phase 35 | Sector 4 Hyper Grid Full Content Pass | Adds Rail Skimmer, Grid Splitter/Grid Fragment, Sector 4 elite variants, Hyper Grid wave director tuning, Sector 4 event pressure, and final-sector boss buildup. |
| Later approved phase | Real Audio Replacement Pass | Original authored music/SFX replacement direction. Do not start without explicit approval. |

Do not start the next phase until explicitly approved.

## 14. Near-Term Production Priorities

Recommended next production direction:

- Tune and validate the Phase 19/20 weapon architecture and Armory UI before adding many new weapons.
- Tune and validate the Phase 21 runtime loadout foundation before adding many new weapons.
- Tune and validate the Phase 23 weapon content pack before adding enemy loot drops or larger weapon pools.
- Validate Phase 24 player education with real players before adding more weapon or loot complexity.
- Validate Phase 25 placeholder weapon icons with real players before scaling to many more weapon families.
- Plan a later final weapon art/previews pass that matches actual in-game weapon visuals/VFX.
- Validate Phase 26 Hard Reset sector readability on real displays before finalizing this background direction or adding heavier authored backgrounds.
- Validate Phase 27 Blender gameplay models and 3D-rendered icons in motion, especially player/enemy/weapon readability against the Phase 26 HD sector plates.
- Tune Phase 28 Neon Dust values and Core Upgrade costs after real playtesting; current values are intentionally conservative.
- Tune Phase 29 Forge costs/effects and Phase 30 elite spawn rates after real playtesting before adding more progression power or enemy content.
- Tune Phase 31 boss telegraph timing, attack frequency, and visual intensity through manual playtesting before adding more bosses.
- Tune Phase 34 event frequency, reward values, and objective readability through manual playtesting before expanding event pools.
- Tune Phase 35 Sector 4 rail dash timing, Grid Splitter fragment caps, Hyper elite frequency, and event pressure through manual playtesting before adding more late-game sectors or enemies.
- Expand Armory only through approved focused passes.
- Keep tuning the four-sector prototype run while architecture work happens.
- Add stronger boss and graphics variety only through approved focused phases.
- Keep documentation and content catalogs updated as content grows.
