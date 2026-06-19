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
- Phase 36 adds a full-run clarity pass so sector entry, sector rewards, boss states, weapon progression, Neon Dust, death, and run-complete outcomes are easier to understand.
- Phase 37 leaves the active player presentation as a blue shader propulsion ripple under the player after rejected spotlight work was removed.
- Phase 38 prototypes the first Level 1 / Sector 1 visual-only 3D arena architecture layer while preserving the existing 2D gameplay plane.
- Phase 40 locks the official story bible, character bible, enemy faction bible, boss bible, five-sector story direction, and naming foundation before cutscene work begins.
- Phase 41 adds the first skippable opening intro sequence with original Neon Swarm story panels, subtle neon presentation, and a procedural intro music state.
- Phase 42 adds Lyra Quill as a short companion/tutorial radio voice for key gameplay systems without adding a full cutscene or dialogue framework.
- Phase 43 adds lightweight sector story progression with title cards, sector-specific Lyra intros, memory reveals, and locked boss-name references without adding a full boss pass or ending sequence.
- Phase 44 adds lightweight boss identity presentation for the four current runtime bosses with boss arrival cards, intro quotes, defeat quotes, and boss-specific Lyra warnings without changing boss behavior, adding Sector 5, adding the Null King stage, or building an ending.

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
- Story implementation beyond the Phase 44 four-boss identity foundation, including future Sector 5 / Black Crown work, Null King stage work, ending work, Memory Shard work, and deeper cinematic presentation.
- Professional audio/music direction beyond placeholder procedural foundations.
- More polish, balancing, accessibility, and content depth.

Long-term expansion reference:

- `docs/NEON_SWARM_LONG_TERM_RPG_ROGUELITE_EXPANSION_PLAN.md`

Phase 19 foundation references:

- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_WEAPON_RARITY_AND_STAT_ROLLS.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`

Phase 40 story foundation references:

- `docs/NEON_SWARM_STORY_BIBLE.md`
- `docs/NEON_SWARM_CHARACTER_BIBLE.md`
- `docs/NEON_SWARM_ENEMY_FACTION_BIBLE.md`
- `docs/NEON_SWARM_BOSS_BIBLE.md`
- `docs/NEON_SWARM_STORY_IMPLEMENTATION_PLAN.md`
- `docs/NEON_SWARM_PHASE_41_OPENING_INTRO_SEQUENCE_REPORT.md`
- `docs/NEON_SWARM_PHASE_42_LYRA_COMPANION_TUTORIAL_LORE_REPORT.md`
- `docs/NEON_SWARM_PHASE_43_SECTOR_STORY_PROGRESSION_REPORT.md`
- `docs/NEON_SWARM_PHASE_44_BOSS_IDENTITY_PASS_REPORT.md`

## 2. Target Sector Structure

Target full-game sector count: five core story sectors before optional challenge/remix modes.

Current and planned sectors:

| Sector | Name | Status | Role | Geometry Identity |
| --- | --- | --- | --- | --- |
| 1 | Neon Grid | Implemented with Phase 38 visual-only Blender-built 3D aluminum arena kit; Phase 43 adds intro and memory text | Opening sector, teaches movement, XP, rewards, and boss clear flow. | Blender-authored 7x7 aluminum/gunmetal floor panel kit with bevels, inset plates, cyan neon seams, raised border walls aligned to the gameplay boundary, top rails, corner pylons, and subtle depth buttresses. |
| 2 | Prism Rift | Phase 39 approved arena identity preserved; Phase 43 adds intro and Mira-memory text | First memory of Mira, prism fracture pressure, Veyraxis reveal. | Purple/magenta fractured prism/glass arena. Current Blender arena work remains preserved; future story work must not overwrite the approved Sector 2 arena direction. |
| 3 | Ember Circuit | Planned story identity; Phase 43 adds intro and Aether-weapon memory text while current runtime assets remain prototype-level | The war begins, old weapon factory, Lord Cobalt Hex reveal. | Red/orange molten neon factory, cobalt machine authority, weapon-memory furnaces. |
| 4 | Hyper Grid | Phase 35 active content pass implemented; Phase 43 adds intro and Mira-lock memory text | Truth of the seal, high-speed Grid storm, Mira lock reveal. | High-speed cyan/pink digital storm with rails, lock glyphs, and overclocked Grid machinery. |
| 5 | The Black Crown | Future content only; Phase 43 locks data-only intro text and Phase 44 locks future boss identity notes, but no Sector 5 gameplay or Null King stage exists yet | Crown Shard gatekeeper, Null King final boss, Mira rescue conflict. | Black void, white cracks, dead neon stars, crown fragments, silent geometry. |

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
- Sector enemy mixes are weighted differently so Neon Grid, Prism Rift, Ember Circuit, and Hyper Grid no longer feel like the same spawn rhythm.
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

Official Phase 40 boss roster:

- Grix the Rail Butcher: Sector 1 boss, corrupted Gridborn execution machine.
- Veyraxis, Prism Widow: Sector 2 boss, prism-memory predator.
- Lord Cobalt Hex: Sector 3 boss, old Aether Core weapon-factory commander.
- The Hollow Warden: Sector 4 boss, guardian of Mira's seal.
- The Crown Shard: Sector 5 mid-boss, fragment of the Null King's crown.
- The Null King, Crown of the Empty Grid: final boss and main villain.
- Optional remix bosses: later challenge-mode variants only after base content is stable.

Boss rules:

- Bosses should be readable at arena scale.
- Boss warning, phase shift, projectile language, adds, and death burst must be distinct.
- Boss overlap should remain controlled by trimming non-boss enemies and clearing hostile hazards on boss entry.

Phase 31 boss encounter status:

- Boss attacks now use a capped telegraph queue before release instead of firing every major attack instantly.
- Current prototype boss behaviors remain under the hood until future approved boss content phases replace them.
- Grix the Rail Butcher currently maps to the old Sector 1 boss behavior.
- Veyraxis, Prism Widow currently maps to the old Sector 2 boss behavior.
- Lord Cobalt Hex currently maps to the old Sector 3 boss behavior.
- The Hollow Warden currently maps to the old Sector 4 boss behavior.
- Boss HUD labels append `PHASE 2` when a boss enters escalation.

Phase 44 boss identity status:

- The four current runtime bosses now show short arrival title cards with locked names,
  identity titles, and intro quotes.
- Runtime boss warning time now queues boss-specific Lyra warning lines for those
  four active bosses only.
- Runtime boss defeat now shows short defeat quote cards for those four active
  bosses where the existing boss-defeated hook is safe.
- The Crown Shard and The Null King identity data are locked for future
- approved Sector 5 / final boss work only and are not in the current runtime
  boss-card lookup.
- No boss attack, health, reward, model, or balance changes are included.

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
- Sector 2 currently uses the Phase 39 Hard Repair 2 Blender-authored Prism Rift 3D arena candidate instead of the old flat HD prism plate; it has been rebuilt from the rejected neon-strip version and still requires user gameplay-camera visual approval.
- Sector 3 now uses an HD octagon/hex black-glass plate with slow polygon edge lighting.
- Sector 4 now uses an HD rail/stretched-diamond hyperlane plate with fast lane runners.
- Adds sparse sector-authored `HDLightRunner_*` animation over the plates.
- Adds background opacity caps tied to VFX intensity.
- The rejected procedural grid/floor fragments, loose marker overlays, random diagonal scratches, rings, glyph spam, floating stickers, monoliths, pylons, gates, and warp effects are disabled from the active background path.
- Future authored sector art should follow the Phase 38/39 Blender source plus runtime GLB path for 3D arena passes, must complete the documentation-first Blender art workflow in the approved visual style lock, and should not return to the rejected procedural filler direction.

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

Phase 41 status:

- Adds an original procedural `intro` music state for the opening story panels.
- Uses the existing generated audio path; no copyrighted music or external audio
  imports are introduced.

Phase 42 status:

- Adds a subtle original procedural `lyra_radio` SFX key for companion radio
  callouts.
- Uses the existing generated SFX path; no copyrighted music or external audio
  imports are introduced.

Phase 43 status:

- Reuses the Phase 42 Lyra radio panel for sector-specific mission callouts.
- Adds no new music, SFX, external audio, or copyrighted audio.

Phase 44 status:

- Adds an original procedural `boss_identity` SFX key for boss arrival cards.
- Uses the existing generated SFX path; no copyrighted music or external audio
  imports are introduced.

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
- Opening scene polish and replay controls beyond the Phase 41 foundation.
- Companion dialogue, sector story, and boss identity polish beyond the Phase 44 foundation.
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
| Phase 36 | Full Run Polish / Player Progression Clarity Pass | Adds clearer run start, sector entry, sector clear, boss, event reward, weapon progression, Forge, Neon Dust, death, and run-complete messaging without changing gameplay balance. |
| Phase 37 | Player Propulsion Ripple Presentation | Removes rejected spotlight work and preserves the active blue/cyan shader ripple under the player as visual-only presentation. |
| Phase 38 | Level 1 3D Arena Map Architecture Prototype | Adds and hard-repairs Sector 1-only visual 3D map architecture with a Blender source/GLB pipeline: aluminum/gunmetal beveled floor panels, cyan seams, camera/bounds fit, raised border walls, neon rails, corner pylons, and subtle depth pieces while preserving flat gameplay. |
| Phase 39 | Sector 2 3D Prism Rift Arena Map Architecture Prototype | Approved/preserved Sector 2 Blender source/GLB Prism Rift arena direction. Hard Repair 3 uses the user-owned original floor reference for large readable octagonal glass panels, dark machined grid structure, contained magenta/violet fracture detail, Sector 2-only runtime integration, and preserved flat gameplay. |
| Phase 40 | Story Bible + Naming Lock Foundation | Locks Nova Veyr, the Aether Core, Lyra Quill, Rook-7, Mira Sol, the Null King, the Swarm, the five-sector story arc, enemy factions, boss names, future opening outline, future ending outline, and label-only runtime naming. No cutscene system or story scene is built. |
| Phase 41 | Opening Intro Sequence Foundation | Adds a skippable title-menu-to-gameplay opening sequence with eight Neon Swarm story panels, subtle dark neon motion, original procedural intro music, and safe handoff into the existing run flow. No ending sequence or Phase 42 work is built. |
| Phase 42 | Lyra Companion / Tutorial Lore Integration | Adds Lyra Quill as a lightweight companion radio voice for first gameplay start, movement, XP, level-up, run weapons, Neon Dust, Forge reference, boss warning, sector transition, low health, death, and sector clear / run victory. No sector story progression, ending sequence, or Phase 43 work is built. |
| Phase 43 | Sector Story Progression | Adds sector title cards, sector-specific Lyra intros, memory reveal cards, runtime-session one-shot story flags, and lightweight boss-name references for the locked story sectors. No Phase 44 full boss pass or ending sequence is built. |
| Phase 44 | Boss Identity Pass | Adds boss identity data, boss arrival cards, intro quotes, defeat quote cards, boss-specific Lyra warnings, and a procedural boss identity sting for the four active runtime bosses only, with Crown Shard and Null King future/data-ready only and excluded from current runtime boss-card lookup. No Sector 5, Null King stage, Phase 45 Memory Shard system, or ending sequence is built. |
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
- Manually review Phase 36 notice timing/readability during a complete run, especially stacked event/boss/reward moments.
- Manually validate the Phase 38 Sector 1 3D arena prototype for border clarity, readability under swarm pressure, and Phase 37 ripple visibility before expanding the architecture system to other sectors.
- Manually validate the Phase 39 Hard Repair 3 Sector 2 Prism Rift arena against `art/reference/user_original_art/sector2_user_original_floor_reference.jpg` before treating the Sector 2 visual direction as approved.
- Manually validate the Phase 41 opening intro for readable panel pacing, immediate skip response, controller skip response, music mix, and clean gameplay handoff.
- Manually validate the Phase 42 Lyra panel for readable placement, nonintrusive pacing, low-health cooldown behavior, reward-menu cancel safety, and clean interaction with the Phase 41 intro.
- Manually validate the Phase 43 sector title cards and memory reveals for readable placement, nonintrusive timing, cancel dismissal, clean Lyra sequencing, and preserved Sector 2 arena presentation.
- Manually validate the Phase 44 boss cards and Lyra warnings for readable placement, nonintrusive timing, quote readability, boss-defeat reward flow, and preserved boss balance.
- Expand Armory only through approved focused passes.
- Keep tuning the four-sector prototype run while architecture work happens.
- Add stronger boss and graphics variety only through approved focused phases.
- Keep documentation and content catalogs updated as content grows.
