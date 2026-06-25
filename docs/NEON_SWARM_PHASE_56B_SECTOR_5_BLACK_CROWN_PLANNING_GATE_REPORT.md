# Neon Swarm Phase 56B Sector 5 Black Crown Planning Gate Report

## Scope

This is a docs-only / plan-only Phase 56B Sector 5 planning gate report.

It defines what a future Sector 5 Black Crown foundation pass may plan later and
what it must not implement yet. It keeps Sector 5 runtime implementation
blocked until a separate approval explicitly authorizes implementation.

This report does not change scripts, scenes, project settings, art assets,
Blender files, GLB files, gameplay, enemies, projectiles, XP, pickups, HUD,
weapons, hazards, bosses, Sector 1, Sector 2, Sector 3, Sector 4, Sector 5
runtime, or alternate scenes.

## Official Build

Official scene remains:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

`project.godot` remains expected to launch:

```ini
run/main_scene="res://scenes/Main.tscn"
```

No alternate playable scene is approved or created by this planning gate.

## Source Context

This report preserves the current gates from:

- `docs/NEON_SWARM_PHASE_54_SECTOR_3_CLOSEOUT_REPORT.md`
- `docs/NEON_SWARM_PHASE_55_SECTOR_4_CLOSEOUT_REPORT.md`
- `docs/NEON_SWARM_CAMPAIGN_STRUCTURE_PLAN.md`
- `docs/NEON_SWARM_BOSS_BIBLE.md`
- `docs/NEON_SWARM_FULL_GAME_BUILDOUT_ROADMAP.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`

## Current Four-Sector Readiness Status

Phase 56A review result: pass for planning/review, not for implementation.

Current runtime state:

- Sector 1 through Sector 4 are the active runtime sectors.
- Sector 5 is future story-locked only.
- The official scene remains `scenes/Main.tscn`.
- Current active campaign data covers Sectors 1-4 only.
- Current run completion remains tied to defeating The Hollow Warden in Sector 4.
- Prism Shards I-IV are active rewards for the current four-sector run.
- Prism Shards V-VI remain future-only.
- The Crown Shard and The Null King remain future-only.

Phase 56A validation evidence:

- `godot --headless --path . --quit-after 3`: passed.
- `godot --headless --path . --scene scenes/Main.tscn --quit-after 3`: passed.
- Sector 3 current-runtime review passed, with known late hazard pressure
  reaching `10/10`.
- Sector 4 natural pressure review passed, with max observed enemies at
  `49/54`.
- Sector 4 forced Rift Surge / Overload review passed, with max observed
  enemies at `50/54`.
- Hollow Warden boss-gate, run-complete, and Memory Shard IV flow passed.

Known active caveats:

- Sector 3 late hazard pressure can already reach `10/10`.
- Sector 4 4A Routing Spine can still touch `54/54` enemies under low-kill
  auto-advance conditions.
- Do not add new Sector 4 population pressure until the 4A caveat is reviewed
  again.
- Hollow Warden can remain as the current prototype placeholder for now.
- Hollow Warden is not production-complete.
- Hollow Warden production work requires separate planning and approval.

## Sector 5 Concept / Black Crown Direction

Sector 5 target identity: The Black Crown.

Story role:

- Final assault into the dead center of the Grid.
- Nova pushes toward Mira's prison and the Null King's influence.
- The sector should feel like a dead neon crown space, not another Hyper Grid
  speed layer.

Locked campaign structure from the campaign plan:

- `5.0 Dead Grid`
- `5A Crown Wound`
- `5B Silent Starfield`
- `5C Null Cathedral`
- `5D Mira's Prison`
- Future boss: The Crown Shard.
- Future final boss: The Null King, Crown of the Empty Grid.

Visual concept direction:

- Dark dead-grid geometry.
- White cracks and crown-fragment motifs.
- Dead neon star fragments.
- Silent void-space restraint.
- Strong readable edges and silhouettes.
- No black-on-black floor collapse.
- No uncontrolled white/cyan screen wash.
- No visual continuation that makes Sector 5 feel like Sector 4 / Hyper Grid.

## What A Future Sector 5 Foundation May Plan Later

A later, separately approved Sector 5 planning or foundation pass may plan:

- Sector 5 scope boundaries.
- Sector 5 runtime activation requirements.
- Sector 5 data shape and inactive future data requirements.
- How the four-sector run transitions into Sector 5 if implementation is later
  approved.
- Black Crown arena identity, shape language, and readability constraints.
- Initial enemy-family reuse strategy using existing enemies only, if needed
  for planning.
- Cap budgets for enemies, projectiles, XP, hazards, beams, bursts, and mines.
- How to keep Sector 5 distinct from Sector 4.
- Crown Shard and Null King story gates.
- Prism Shard V / VI story gates.
- QA scripts or manual checklist requirements for a future implementation.
- Documentation requirements for any later art, Blender, GLB, or runtime work.

If a later Sector 5 runtime foundation implementation is separately approved,
it should start with the smallest possible foundation and should not add final
boss content, ending content, new weapon systems, or broad gameplay rewrites.

This Phase 56B report does not approve that implementation.

## What Sector 5 Must Not Implement Yet

Not allowed by this report:

- Sector 5 runtime activation.
- Sector 5 normal-run progression.
- Sector 5 debug jump.
- Sector 5 enemies.
- Sector 5 hazards.
- Sector 5 arena art.
- Sector 5 Blender files.
- Sector 5 GLB files.
- Crown Shard runtime work.
- Null King runtime work.
- Ending sequence.
- Prism Shard V / VI runtime unlocks.
- New weapons.
- New weapon systems.
- New bosses.
- New hazards.
- New large systems.
- Save-schema changes.
- Sector 1-4 changes.
- Sector 3 visual presentation changes.
- Sector 4 visual presentation changes.
- Alternate scenes.

Sector 5 cannot proceed to runtime implementation without separate approval.

## Required Readability Rules

Any future Sector 5 plan or implementation must preserve the active visual
priority:

1. Player.
2. Enemy danger.
3. Enemy bullets and boss attacks.
4. Player bullets and weapon effects.
5. XP and rewards.
6. HUD.
7. Arena and background.

Required Sector 5 readability constraints:

- Black Crown floors must not become unreadable black voids.
- White cracks must not overpower enemy projectiles, XP, player shots, or HUD.
- Dead neon star fragments must stay background-level, not projectile-level.
- Crown fragments must not look like pickups, enemy bullets, or player weapons.
- Boss tells must be readable before damage.
- Sector 5 cannot require dimming the player, enemies, projectiles, XP, or HUD
  to make the background work.
- No 3/4 visual presentation retuning is allowed as part of Sector 5 planning.

## Required Cap / Performance Rules

Any future Sector 5 plan must define cap budgets before implementation.

Required cap rules:

- Do not raise `ENEMY_CAP` without a separate approved performance/balance
  review.
- Do not raise projectile, XP, hazard, beam, burst, or mine caps without a
  separate approved review.
- Sector 5 cannot add population pressure that hides or ignores the Sector 4 4A
  headroom caveat.
- New Sector 5 pressure must start below current late Sector 4 pressure.
- Any future hazard pressure must start rare and capped.
- Any future boss-add pressure must be budgeted separately from normal enemy
  pressure.
- Cleanup must be proven for enemies, projectiles, hazards, XP, beams, bursts,
  mines, and story/UI panels.

Required performance rule:

- Decorative VFX must degrade before gameplay-critical visibility or input
  responsiveness.

## Required Boss / Story Gates

Sector 5 story content remains gated.

Required gates:

- The Crown Shard remains future-only until separately approved.
- The Null King remains future-only until separately approved.
- The ending sequence remains future-only until separately approved.
- Prism Shard V remains future-only until separately approved.
- Prism Shard VI remains future-only until separately approved.
- Hollow Warden remains the current Sector 4 prototype placeholder and is not
  production-complete.
- Hollow Warden production work is a separate boss-planning path, not part of
  this Sector 5 planning gate.
- Sector 5 work must not accidentally treat Hollow Warden as final production
  boss work.

Any future Crown Shard or Null King work must have separate planning and
approval before implementation.

## Required QA Before Any Sector 5 Runtime Work

Before any future Sector 5 runtime implementation can be approved, QA must
confirm:

- `scenes/Main.tscn` remains the only official scene.
- `project.godot` still launches `res://scenes/Main.tscn`.
- Four-sector run still boots.
- Sector 1 through Sector 4 progression still works.
- Sector transitions still work.
- Boss gates still work for Sectors 1-4.
- Prism Shards I-IV still unlock only from active boss clears.
- Prism Shards V-VI do not unlock in the four-sector run.
- The Crown Shard and Null King do not appear in the current runtime before
  approval.
- Run-complete flow after The Hollow Warden remains intact until a later
  approved phase changes the run endpoint.
- HUD remains readable.
- Rewards and XP remain readable.
- Player, enemies, projectiles, XP, pickups, and boss tells remain readable.
- Enemy, projectile, XP, hazard, beam, burst, and mine caps remain respected.
- Sector 4 4A enemy headroom caveat is still documented and not worsened.
- No alternate scenes are created.
- No Sector 3 or Sector 4 visual presentation retune is bundled into Sector 5.

Minimum validation for any future runtime implementation proposal:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
```

Additional runtime/capture reviews must be scoped when implementation is
separately approved.

## Explicit Non-Approval

This Phase 56B report approves no implementation.

Explicitly not approved:

- New Sector 5 runtime content.
- New weapons.
- New hazards.
- New bosses.
- Large systems.
- Alternate scenes.
- Sector 1-4 changes.
- Sector 3 visual presentation changes.
- Sector 4 visual presentation changes.
- Hollow Warden production work.
- Crown Shard implementation.
- Null King implementation.
- Ending implementation.

Sector 5 remains planning-only after this report.

## Files Likely To Change Only If Later Approved

If a later Sector 5 foundation implementation is separately approved, likely
files may include:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/content/NeonContentCatalog.gd`
- Future Sector 5 docs under `docs/`

Possible only if a later art pass is separately approved:

- Future `art/arenas/sector_5/` Blender source files.
- Future `art/arenas/sector_5/` GLB exports.
- Future Sector 5 review images.

Not expected for an initial planning-only gate:

- `scenes/Main.tscn`
- `project.godot`
- Player files.
- Existing enemy files.
- Existing projectile files.
- Existing XP, HUD, weapon, hazard, or boss files.
- Sector 1-4 art or runtime files.
- Alternate scenes.

## Validation For This Report

This report is docs-only. No Godot runtime validation is required because no
engine, script, scene, project, art, or gameplay file is changed.

Required validation:

- Read back this report after writing.
- Run `git status --short --branch`.
- Confirm only this new report changed.
- Confirm `scenes/Main.tscn` remains untouched.
- Confirm `project.godot` remains untouched.
- Confirm no scripts, art, Blender files, GLB files, gameplay, enemies,
  projectiles, XP, HUD, weapons, hazards, bosses, Sector 1-4, Sector 5 runtime,
  or alternate scenes changed.

## Godot Documentation

No external Godot API documentation was required for this report because this
was docs-only and did not change engine-dependent behavior.
