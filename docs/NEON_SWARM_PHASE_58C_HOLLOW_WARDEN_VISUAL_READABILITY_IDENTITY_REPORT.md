# Neon Swarm Phase 58C Hollow Warden Visual Readability Identity Report

## 1. Summary

Phase 58C added a narrow, script-only visual/readability identity pass for The
Hollow Warden.

Result: pass with capture-environment caveat.

The implementation gives the existing `final_null_octagon` boss, which resolves
to the `null_octagon_prime` visual path, a dedicated boss-attached
lock/core/glyph overlay. The pass is visual-only, reversible, and does not add
collision, attacks, phases, pressure, rewards, art imports, scenes, or Sector 5
runtime behavior.

## 2. Docs And References Consulted

- `AGENTS.md`
- `STUDIO.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_PHASE_58A_HOLLOW_WARDEN_PRODUCTION_PLANNING_REPORT.md`
- `docs/NEON_SWARM_PHASE_58B_HOLLOW_WARDEN_PRODUCTION_GAP_REVIEW_REPORT.md`
- `docs/NEON_SWARM_PHASE_55D_SECTOR_4_BOSS_GATE_HOLLOW_WARDEN_REVIEW_REPORT.md`
- Official Godot documentation for `Node3D`, `MeshInstance3D`, and
  `StandardMaterial3D`

## 3. Exact Visual-Only Implementation

Changed file:

- `scripts/NeonSwarm3DGameplayPrototype.gd`

Implementation details:

- Added Hollow Warden-only materials:
  - `hollow_warden_lock`
  - `hollow_warden_lock_core`
  - `hollow_warden_glyph`
  - `hollow_warden_body`
- Added a `boss_telegraph_prime_core` material for a stronger readable
  white-hot core on existing Hollow Warden telegraphs.
- Added `_add_hollow_warden_identity_overlay(root: Node3D)`.
- Attached the overlay only when `enemy_type == "final_null_octagon"`.
- Kept the existing asset mapping where `final_null_octagon` resolves to
  `null_octagon_prime`.
- Built the overlay from existing script-generated child visuals:
  - `HollowWardenLockGlyphIdentityOverlay`
  - `HollowWardenDarkLockCorePlate`
  - `HollowWardenOctagonalSeal` glowing edge elements
  - `HollowWardenWhiteHotLivingLockRing`
  - `HollowWardenCyanSealHalo`
  - `HollowWardenMagentaSealGlyphHalo`
  - `HollowWardenLivingLockCore`
  - `HollowWardenVerticalLockSpine`
  - `HollowWardenHorizontalLockBar`
  - four `HollowWardenSealGlyphRay` accents
  - four `HollowWardenLockVertex` accents
- Kept the overlay as boss child presentation only. It is not registered in
  enemy, projectile, hazard, boss telegraph, reward, or collision arrays.
- Updated existing boss telegraph material selection so only
  `final_null_octagon` uses `boss_telegraph_prime_core`; other bosses continue
  using the existing `boss_telegraph_core`.

## 4. What Did Not Change

Confirmed unchanged:

- Official scene: `scenes/Main.tscn`
- `project.godot`
- `SECTOR_COUNT = 4`
- `ContentCatalog.sector_count() = 4`
- Active campaign sectors remain Sectors 1-4
- Sector 5 remains future-locked and non-playable
- No Sector 5 title, card, entry, debug jump, or gameplay
- No Null King runtime behavior
- No Crown Shard runtime behavior
- No Prism Shards V/VI runtime unlock
- Boss gate timing
- Arrival card behavior
- Boss bar behavior
- Lyra warning behavior
- Memory Shard IV behavior
- Run-complete after Hollow Warden
- Boss stats, health, movement, attacks, phases, projectile behavior, and adds
- Enemy, projectile, XP, hazard, beam, burst, mine, and boss telegraph caps
- Sector 4 enemy pressure and the 4A headroom caveat
- XP, rewards, weapons, save schema, Armory, HUD, art, Blender files, GLB files,
  and alternate scenes

## 5. Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
timeout 60s godot --headless --path . --script /tmp/neon_swarm_phase58c_hollow_warden_review.gd
```

The focused official-scene review verified:

- Sector 4 advanced through 4A, 4B, 4C, 4D, and the boss gate.
- Hollow Warden warning triggered through the existing boss-gate timing path.
- Hollow Warden spawned through the existing boss arrival path.
- The identity overlay attached to the boss node.
- Overlay child inventory was present.
- Overlay collision child count was `0`.
- Existing Hollow Warden telegraphs were observed:
  - `null_radial`
  - `null_void_pulse`
  - `hyper_rail_sweep`
  - `null_adds`
- Memory Shard IV, `prism_shard_4_living_lock`, unlocked/queued after forced
  Hollow Warden defeat.
- Run-complete triggered after Hollow Warden defeat.
- No Sector 5 leak was detected.

Focused review peak counts:

| Object Type | Peak |
| --- | ---: |
| Enemies | `36/54` |
| Player projectiles | `0/36` |
| Enemy projectiles | `12/28` |
| XP | `15/100` |
| Hazards | `2/10` |
| Beams | `5/8` |
| Bursts | `6/18` |
| Mines | `0/6` |
| Boss telegraphs | `1/8` |

Result: pass.

## 6. Manual QA / Capture Findings

Instrumented official-scene QA passed for the 4D into Hollow Warden flow:

- Lyra warning path remained intact.
- Boss-gate warning path remained intact.
- Boss arrival path remained intact.
- Boss bar and run-complete path remained intact.
- Hollow Warden now has a distinct lock/core/glyph read.
- Existing telegraphs retained readable white-hot cores.
- Player, enemies, boss projectiles, player projectiles, XP, HUD, and reward
  flow were not changed by this slice.

Capture caveat:

- Non-headless capture with the default user path hit the existing Godot
  user-log/SIGSEGV issue already documented in Phase 55D.
- Non-headless capture with isolated `/tmp` user data could not run because the
  environment has no X11 or Wayland display.
- Headless capture could not save viewport images because the dummy renderer did
  not provide a viewport texture.

No repo files were changed by the temporary review/capture scripts in `/tmp`.

## 7. Object-Cap Status

Object caps remain unchanged and safe in the focused Phase 58C review.

No new cap array, gameplay object pool, projectile, hazard, add, or enemy
pressure was introduced. The Hollow Warden overlay is scene-child presentation
only.

## 8. 4A Caveat Status

The Phase 55C / Phase 55 closeout caveat remains active:

- 4A can still touch `54/54` enemies under low-kill auto-advance conditions.
- Phase 58C does not add population pressure and does not worsen that caveat.
- No new boss pressure should be added until that caveat is reviewed again.

## 9. Remaining Production Gaps

Hollow Warden remains not production-complete.

Remaining gaps should be handled only through separately approved future slices:

- Dedicated authored boss model or Blender/GLB pass.
- More refined production silhouette.
- Final attack VFX/audio polish for existing attacks.
- Final boss audio identity.
- Screenshot/manual display review on a machine with a working display server.

Still blocked:

- New boss attacks
- New boss phases
- New adds
- New hazards
- New projectiles
- Sector 4 pressure increase
- Sector 5 runtime
- Null King
- Crown Shard
- Prism Shards V/VI
- New weapons
- Large systems
- Alternate scenes
- 3/4 visual presentation change

## 10. Follow-Up Recommendation

Phase 58C is safe to close as a first script-only Hollow Warden visual identity
slice.

The next safest step is a review-only Phase 58D Hollow Warden readability and
boss-flow QA pass on a display-capable environment, or a docs-only Phase 58C
closeout if no further visual evidence is required right now. Do not add boss
behavior, pressure, Sector 5 runtime, or production art without separate
planning and approval.
