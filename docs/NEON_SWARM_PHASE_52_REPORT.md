# Neon Swarm Phase 52 Report

## Scope

Phase 52 creates the full-game buildout roadmap and implements only the first
safe production step: Sector 3 Ember Circuit runtime foundation.

This phase does not start Sector 4 or Sector 5 production, does not push, and
does not change weapons, equipment mechanics, player movement, HUD layout,
cursor behavior, or existing Sector 1 / Sector 2 arena art.

## Files Changed

- `docs/NEON_SWARM_FULL_GAME_BUILDOUT_ROADMAP.md`
- `docs/NEON_SWARM_PHASE_52_REPORT.md`
- `scripts/NeonSwarm3DGameplayPrototype.gd`

## Current Game Audit Summary

Current active runtime sectors:

- Sector 1: Neon Grid
- Sector 2: Prism Rift
- Sector 3: Ember Circuit
- Sector 4: Hyper Grid

Future story-locked sector:

- Sector 5: The Black Crown

Current active bosses:

- Grix the Rail Butcher
- Veyraxis, Prism Widow
- Lord Cobalt Hex
- The Hollow Warden

Current enemy families include chaser, tank, shooter, exploder, spiral drifter,
shield node, hex slicer, prism leech, triad splitter/fragments, hex pulser, rail
skimmer, grid splitter/fragments, and current boss families.

Current approved weapon behavior is preserved:

- Auto-fire is enabled.
- Normal shots use mouse/right-stick manual aim.
- No normal-shot enemy auto-aim.
- Passive weapons trigger automatically.
- Empty and locked slots do not fire.

Current systems also include equipment slots, title Armory, pause Armory, weapon
stash, randomized weapon stats, Neon Dust, forge/evolution foundations, opening
intro, Lyra tutorial/dialogue support, sector story cards, boss identity cards,
Memory Shard reveals, procedural audio, combat VFX, and sector presentation.

## Roadmap Created

The full buildout roadmap is documented in:

- `docs/NEON_SWARM_FULL_GAME_BUILDOUT_ROADMAP.md`

Locked phase sequence:

- Phase 52: Full-game roadmap and production locks.
- Phase 53: Sector 3 Ember Circuit arena foundation art.
- Phase 54: Sector 3 enemies and hazards.
- Phase 55: Sector 3 boss production pass.
- Phase 56: Sector 4 Hyper Grid foundation review.
- Phase 57: Sector 4 enemies and hazards.
- Phase 58: Sector 4 boss production pass.
- Phase 59: Sector 5 Black Crown foundation.
- Phase 60: Null King final boss path.
- Phase 61: Weapon stash and randomized stats hardening.
- Phase 62: Expanded weapon families.
- Phase 63: Story intro and NPC dialogue pass.
- Phase 64: Save and meta progression.
- Phase 65: Audio and VFX polish.
- Phase 66: Balance and performance pass.
- Phase 67: Release cleanup.

## Sector 3 Foundation Implemented

Sector 3 was already present in campaign/content data as Ember Circuit, but
some runtime presentation still used older Null Zone visual naming and color
identity.

Phase 52 changes:

- Added `SECTOR_3_EMBER_CIRCUIT_FOUNDATION_ENABLED = true`.
- Added `SECTOR_3_EMBER_CIRCUIT_FOUNDATION_STATUS = "runtime_foundation_only"`.
- Added `SECTOR_3_EMBER_CIRCUIT_DEBUG_INDEX = 2`.
- Added F12 debug/test jump to Sector 3 Ember Circuit foundation while keeping
  the existing F10 Sector 4 debug jump.
- Reworked Sector 3 color identity from violet/cyan Null-style presentation to
  orange/red/yellow Ember Circuit presentation.
- Raised Sector 3 ambient readability enough for foundation testing.
- Renamed Sector 3 HD background runtime design as Ember Circuit Foundation.
- Added procedural Ember Circuit busway floor routing above the temporary legacy
  Sector 3 HD plate.
- Added named Ember Circuit foundation markers for central forge core, heat
  manifolds, return manifolds, foundry nodes, and molten service rails.

The Sector 3 foundation is explicitly not final art. The existing legacy
`sector_3_null_zone_hd.png` plate remains as a temporary source plate under the
new procedural Ember routing until Phase 53 replaces it with approved authored
Ember Circuit art.

## How To Test Sector 3 Foundation

In a local gameplay run:

1. Start `scenes/Main.tscn`.
2. Begin gameplay from the title menu.
3. Press F6 to enable event test mode.
4. Press F12 to jump to Sector 3 Ember Circuit Foundation.

Expected result:

- Current sector becomes Sector 3 / Ember Circuit.
- Campaign node resets to 3.0 Foundry Gate.
- Warm Ember Circuit environment tint is visible.
- Procedural orange/yellow busway floor routing is visible.
- Named Ember foundation geometry is present.
- Enemies spawn using the existing Sector 3 opening wave.

## Collision Behavior

The Phase 52 Sector 3 foundation geometry is visual-only. It adds floor routing
and visual markers only. No new arena collision, player movement collision, or
spawn blocking is added, so it cannot create unfair invisible collision or spawn
the player/enemies inside new geometry.

## Validation Results

Initial syntax validation:

- `godot --headless --path . --quit-after 3`: PASS after fixing explicit
  Vector3 typing in the Ember runner loop.

Focused validation:

- Temporary script: `/tmp/neon_swarm_phase52_validation.gd`
- Result: PASS
- Official `scenes/Main.tscn` packed scene loads.
- Sector 1 Neon Grid loads.
- Sector 2 Prism Rift loads.
- Sector 3 Ember Circuit foundation debug load reaches index 2.
- Sector 3 campaign node resets to `3.0 Foundry Gate`.
- Sector 3 background and geometry roots carry
  `sector_3_foundation_status = runtime_foundation_only`.
- Sector 3 background contains named `EmberCircuit` routing nodes.
- Sector 3 geometry contains named `EmberCircuit` foundation markers.
- Debug HUD exposes `F12 S3`.
- Auto-fire still uses preserved manual mouse aim direction.
- Nearest enemy does not redirect normal Pulse Blaster shot direction.
- Right-stick aim action still controls auto-fire direction.
- Invalid/empty weapon slot check returns no fire.
- Locked equipment slot check returns no fire.
- Custom cursor asset exists and cursor texture loads.
- Equipment slot HUD displays eight slots.
- Pause state and pause Armory open correctly.

## Production Lock Confirmation

- No Sector 4 production work was started.
- No Sector 5 production work was started.
- No weapon mechanics were changed.
- No equipment mechanics were changed.
- No HUD layout was changed.
- No player movement was changed.
- No cursor behavior was changed.
- No push was performed.
