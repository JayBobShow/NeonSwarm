# Neon Swarm Phase 58A - Hollow Warden Production Planning Gate

## Scope

Phase 58A is a docs-only / plan-only Hollow Warden production planning gate.

This report defines the production target, constraints, validation, QA
requirements, and approval gates for any future Hollow Warden production work.
It does not implement the Hollow Warden production pass.

No scripts, scenes, project settings, art assets, Blender files, GLB files,
gameplay, enemies, projectiles, XP, HUD, weapons, hazards, bosses, rewards, save
schema, Sector 5 runtime, or alternate scenes are changed by this phase.

## Official Build

Official scene:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

The official playable scene remains `scenes/Main.tscn`.

`project.godot` remains expected to launch `res://scenes/Main.tscn`.

No alternate playable scene is approved or created by this planning gate.

## Source State Reviewed

- `AGENTS.md`
- `STUDIO.md`
- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_REFERENCE_IMAGE_RULES.md`
- `docs/NEON_SWARM_BOSS_BIBLE.md`
- `docs/NEON_SWARM_PHASE_55D_SECTOR_4_BOSS_GATE_HOLLOW_WARDEN_REVIEW_REPORT.md`
- `docs/NEON_SWARM_PHASE_55_SECTOR_4_CLOSEOUT_REPORT.md`
- `docs/NEON_SWARM_PHASE_56E_ROADMAP_STATUS_CLEANUP_REPORT.md`
- `docs/NEON_SWARM_PHASE_57F_REWARD_FEEL_REVIEW_REPORT.md`
- `docs/NEON_SWARM_FULL_GAME_BUILDOUT_ROADMAP.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_CAMPAIGN_STRUCTURE_PLAN.md`
- Current Hollow Warden runtime references in
  `scripts/NeonSwarm3DGameplayPrototype.gd`
- Current Sector 4 boss catalog data in `scripts/content/NeonContentCatalog.gd`

No external Godot API documentation was required because this phase is
docs-only and does not change engine-dependent behavior.

## Current Hollow Warden Status

Hollow Warden is the current Sector 4 run endpoint and can remain as the current
prototype placeholder for now.

Hollow Warden is not production-complete.

Current runtime references:

- Active boss identity id: `hollow_warden`.
- Active sector index: `3`.
- Runtime boss type: `final_null_octagon`.
- Display name: `The Hollow Warden`.
- Identity title: `Guardian of Mira's Seal`.
- Current role: Sector 4 / Hyper Grid boss and active four-sector endpoint.
- Current story reveal: Mira became the living lock holding the Null King in the
  dark.
- Current Memory Shard reward: `prism_shard_4_living_lock`.
- Current run endpoint policy: the run completes after Hollow Warden defeat.

Phase 55D passed the boss-gate review for the current placeholder path:

- Hollow Warden warning timing passed.
- Boss arrival card passed.
- Boss bar passed.
- Lyra warning flow passed.
- Boss readability passed for the current placeholder.
- Boss pressure and caps passed in the focused review.
- Run-complete flow passed.
- Memory Shard IV flow passed.

Phase 57F confirmed that Hollow Warden still ends the run and that no Sector 5
runtime leak appeared after the reward polish.

## Production Boss Goals

A future Hollow Warden production implementation should make Hollow Warden feel
like a real Sector 4 endpoint without changing the current campaign endpoint or
opening Sector 5.

Production goals:

- Make Hollow Warden feel like the guardian of Mira's living-lock seal.
- Preserve the existing four-sector run-complete structure.
- Preserve the current story role: truth-gate, prison guardian, and reveal that
  Mira is the lock holding back the Null King.
- Raise presentation quality from prototype placeholder to readable production
  boss.
- Keep the fight readable at the official gameplay camera distance.
- Preserve player, enemy, projectile, XP, pickup, HUD, boss bar, boss card, and
  warning readability.
- Preserve Sector 4 Hyper Grid identity without making the fight feel like
  Sector 5 / Black Crown.
- Avoid adding new Sector 4 population pressure while the 4A headroom caveat is
  active.

## Silhouette And Readability Target

Hollow Warden production art should use the established Neon Swarm visual
language: dark 3D body faces, bright neon tube edges, white-hot core or vertex
accents, controlled glow, and strong geometric silhouette.

Target identity:

- Primary geometry: hollow octagonal guardian / lock-frame entity.
- Secondary motifs: hollow armor, seal rings, lock glyphs, white cracks,
  cyan-pink storm rails, restrained Nullborn fracture accents.
- Color identity: dark body faces with controlled cyan, pink, and white-hot
  lock energy. Avoid broad orange, broad white wash, and black-on-black collapse.
- Motion identity: deliberate guardian movement, seal-charging beats, and
  readable attack preparation rather than frantic visual noise.
- Threat read: the boss must immediately read as the endpoint guardian, not a
  normal enemy, pickup, projectile, or Sector 5 Crown entity.

Readability rules:

- Boss silhouette must remain readable under normal, dense, and boss-gate
  pressure.
- Boss core and weak/read focal points must not be hidden by player projectiles.
- Boss warning and attack tells must remain visible over the Hyper Grid floor.
- Boss VFX must not obscure player position, incoming hostile projectiles, XP,
  pickups, or HUD.
- Decorative cracks, rails, glyphs, and seal rings must support the primary
  shape instead of replacing it.

## Attack Readability Target

Phase 58A does not approve new attacks.

For a later separately approved production implementation, attack presentation
should follow these rules:

- Every damaging boss action needs a visible warning before damage.
- Telegraphs must be distinct from player projectiles, enemy projectiles, XP,
  pickups, and Hyper Grid floor lanes.
- Warning color and damage color must remain readable against Sector 4 cyan and
  white floor accents.
- Telegraphs must clearly communicate direction, footprint, timing, and owner.
- Warning windows must be long enough for a fair dodge at gameplay speed.
- VFX should clear quickly after impact.
- Boss attacks must stay within existing object-cap and pressure budgets unless
  a separate cap review approves otherwise.

If future work changes only visuals for existing attacks, it must prove that
attack timing, damage, projectile behavior, and cap behavior remain unchanged.

If future work proposes new attacks, that is a separate implementation approval
and must include a dedicated pressure/cap review before it can proceed.

## VFX And Audio Goals

Phase 58A does not approve VFX or audio implementation.

Future separately approved production work may plan or implement:

- A restrained boss intro sting that supports the current arrival card.
- A seal/lock charge sound identity.
- Low, mechanical guardian motion layers.
- Distinct attack warning cues that do not mask critical gameplay audio.
- Short-lived impact and seal fracture effects.
- Controlled local glow on boss edges, lock glyphs, and white-hot crack points.

Future VFX/audio must not:

- Add screen-wide bloom or haze.
- Hide player, enemy projectiles, boss telegraphs, XP, pickups, or HUD.
- Make Hollow Warden read as the Null King or Crown Shard.
- Increase runtime pressure, object counts, or caps without separate approval.
- Require a large new audio, cutscene, or VFX framework in the first production
  pass.

## Story Role

Hollow Warden is the current four-sector endpoint.

Story role:

- Sector: Hyper Grid.
- Role: prison guardian and truth-gate.
- Reveal: Mira Sol became the living lock holding the Null King in the dark.
- Current reward beat: Memory Shard IV, `prism_shard_4_living_lock`.
- Current run result: defeating Hollow Warden completes the active run.

Production work should strengthen this role without activating future content.

Do not use Hollow Warden production work to unlock Sector 5, Prism Shards V/VI,
Crown Shard, Null King, final ending content, or a new campaign route.

## Pressure And Object-Cap Budget

Known current caps from the Phase 57F reward-feel closeout:

- `ENEMY_CAP`: `54`
- `XP_CAP`: `100`
- `PLAYER_PROJECTILE_CAP`: `36`
- `ENEMY_PROJECTILE_CAP`: `28`
- `BURST_CAP`: `18`
- `MINE_CAP`: `6`
- `HAZARD_TRAIL_CAP`: `10`

Phase 55D focused Hollow Warden boss-pressure sample:

| Object Type | Peak |
| --- | ---: |
| Enemies | `26/54` |
| Player projectiles | `0/36` |
| Enemy projectiles | `12/28` |
| XP | `1/100` |
| Hazards | `2/10` |
| Beams | `4/8` |
| Bursts | `0/18` |
| Mines | `0/6` |
| Rail warnings | `4` |

Production budget rules:

- Do not raise caps as part of the first Hollow Warden production pass.
- Do not add boss adds while the 4A enemy-headroom caveat is active.
- Do not add new Sector 4 population pressure.
- Do not add new Sector 4 event pressure.
- Do not add new Sector 4 hazard pressure.
- Do not increase persistent projectile pressure without a separate cap review.
- Prefer replacing placeholder presentation over adding more simultaneous
  objects.
- Decorative VFX must degrade before gameplay-critical readability.
- Any new mesh/VFX/audio work must be cleanup-safe and not leave persistent
  spawned objects behind.

## 4A Enemy-Headroom Caveat Rules

The 4A Routing Spine `54/54` enemy-headroom caveat remains active.

Phase 55C and later closeouts recorded that low-kill auto-advance conditions can
still touch `54/54` enemies in 4A. Phase 57F reproduced the caveat and confirmed
it was not worsened by reward work.

Rules while this caveat remains active:

- No new Sector 4 population pressure.
- No new boss add pressure.
- No new hazard pressure.
- No new event pressure.
- No Sector 4 pressure increase hidden inside boss production work.
- No cap raises to mask the caveat.
- Any future Hollow Warden implementation must prove that 4A headroom is not
  worsened.
- If the production boss requires extra pressure, a separate 4A pressure/cap
  review must happen first.

## Future Implementation May Change

Only after separate approval, a future Hollow Warden production implementation
may change:

- Hollow Warden visual model, materials, or boss presentation assets.
- Boss silhouette and geometry presentation.
- Boss telegraph visuals for existing attacks.
- Boss projectile/VFX presentation for existing attacks.
- Boss intro/defeat presentation polish.
- Boss-specific audio cues and music/sting layers.
- Boss readability helpers such as outline, core, seal, or weak-read accents.
- Documentation and QA reports for the production pass.

Any such work must preserve the active campaign endpoint, current save schema,
reward behavior, Memory Shard IV flow, run-complete flow, Sector 5 lock, and the
one-official-scene rule unless a separate later phase explicitly approves
otherwise.

## Explicitly Blocked By Phase 58A

Phase 58A does not approve:

- Immediate Hollow Warden implementation.
- New boss attacks.
- New boss art.
- New boss VFX/audio implementation.
- New Sector 4 pressure.
- Sector 5 runtime.
- Null King.
- Crown Shard.
- Prism Shards V/VI.
- New weapons.
- New hazards.
- Large systems.
- Alternate scenes.
- Sector 3/4 visual presentation change.
- Boss production work.
- Boss behavior changes.
- Boss stat changes.
- Projectile behavior changes.
- Enemy behavior changes.
- Reward changes.
- Save schema changes.
- `scenes/Main.tscn` changes.
- `project.godot` changes.

## Required Validation Before Future Implementation

Any later Hollow Warden production implementation must validate:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
```

Required focused validation:

- Official scene only: `scenes/Main.tscn`.
- No alternate playable scene.
- `project.godot` still points at `res://scenes/Main.tscn`.
- Hollow Warden warning timing still works.
- Boss arrival card still works.
- Boss bar still works.
- Lyra warning still works.
- Boss defeat card still works.
- Memory Shard IV still unlocks/queues correctly.
- Hollow Warden still ends the active run.
- No Sector 5 title card, entry, debug jump, gameplay, Crown Shard, Null King,
  Prism Shard V, or Prism Shard VI appears.
- `SECTOR_COUNT` remains `4` unless a separate later phase explicitly approves
  runtime sector activation.
- `ContentCatalog.sector_count()` remains `4` unless a separate later phase
  explicitly approves runtime sector activation.
- Enemy, projectile, XP, hazard, beam, burst, and mine caps remain respected.
- 4A enemy-headroom caveat is not worsened.

If visual assets are created in a later approved production pass, the pass must
also validate source/export inventory, GLB loading, material inventory, and
gameplay-camera readability.

## Required Manual QA Checklist Before Future Implementation Approval

Manual QA must cover:

- Sector 4 4D Lockbreaker Gate into Hollow Warden boss gate.
- Hollow Warden warning timing.
- Hollow Warden boss arrival card.
- Hollow Warden boss bar.
- Lyra warning timing and readability.
- Boss silhouette readability at gameplay camera distance.
- Boss core/lock-glyph readability.
- Boss attack telegraph readability.
- Boss projectile readability.
- Player readability.
- Enemy readability.
- Enemy projectile readability.
- Player projectile readability.
- XP and pickup readability.
- HUD readability.
- Boss defeat flow.
- Memory Shard IV flow.
- Run-complete flow.
- No Sector 5 leak.
- No Crown Shard, Null King, Prism Shard V, or Prism Shard VI leak.
- Natural low/medium/high density Sector 4 pressure.
- Focused boss-gate pressure sample.
- Object caps for enemies, player projectiles, enemy projectiles, XP, hazards,
  beams, bursts, mines, and rail warnings.
- Cleanup of temporary VFX, projectiles, hazards, and boss presentation objects.
- Performance during busy boss pressure.
- Save safety if any future work touches reward, memory, or run-complete code.

## Required Approval Gates

Before any Hollow Warden production implementation, a separate approved phase
must define:

- Exact production scope.
- Whether work is art-only, VFX/audio-only, telegraph-readability-only, or boss
  behavior work.
- Allowed files.
- Blocked files.
- Whether Blender source and GLB exports are required.
- Whether Godot runtime script changes are allowed.
- Whether any boss pressure changes are allowed.
- How the 4A enemy-headroom caveat will be protected.
- How Sector 5 runtime remains blocked.
- Required validation commands.
- Required manual QA capture/review steps.
- Local commit policy.

Implementation remains blocked until that separate approval exists.

## Phase 58A Result

Phase 58A creates the Hollow Warden production planning gate only.

Hollow Warden remains the current prototype/non-production-complete four-sector
endpoint. It can stay as-is for now.

The safest future path is a separately approved, tightly scoped Hollow Warden
production pass that improves presentation and readability without adding Sector
4 pressure, activating Sector 5, changing rewards, changing save schema, adding
new hazards, adding new weapons, adding large systems, or creating alternate
scenes.
