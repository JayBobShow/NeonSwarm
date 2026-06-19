# Neon Swarm Phase 48 Sector 1 Subsector Arena Content Pass Report

Phase 48 builds the first Sector 1 subsector arena content pass for Neon Grid
only. The pass keeps 1.0 Awakening Grid on the approved base Sector 1 arena and
adds full visual runtime arena-layout variants for 1A through 1D.

No Phase 49 work, Sector 2 subsector art, Sector 3 subsector art, Sector 4
subsector art, Sector 5 runtime content, final boss content, ending sequence,
HUD redesign, gameplay balance change, movement change, collision change, or
official scene path change is included.

## References Checked

- `art/reference/README.md`
- `art/reference/sector_1_neon_grid/`
- `art/reference/sector_1_neon_grid/sector_1_refference_sheet.png`
- `art/reference/user_original_art/`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_CAMPAIGN_STRUCTURE_PLAN.md`
- `docs/NEON_SWARM_PHASE_47_CAMPAIGN_PROGRESSION_RUNTIME_FOUNDATION_REPORT.md`
- Existing Sector 1 arena source and notes under
  `art/arenas/sector_1/source/blender/`

The Sector 1 reference folder now contains the user-provided reference sheet, so
the art direction follows that sheet first while preserving the approved Sector
1 Neon Grid visual language: dark gunmetal/aluminum hard-surface floor
architecture, restrained cyan/blue embedded channels, readable bevels, and
low-profile visual detail.

Phase 48 reference-first correction:

- Found image files in `art/reference/sector_1_neon_grid/`:
  `sector_1_refference_sheet.png`.
- The image is a 1408x768 multi-image user reference sheet titled
  `SECTOR 1 REFERENCE SHEET -- NEON GRID`.
- This is now the primary Sector 1 visual guide.
- The sheet maps left-to-right to:
  - Panel 1: `1.0 Awakening Grid` / base starting arena.
  - Panel 2: `1A Relay Yard` / communications hub.
  - Panel 3: `1B Data Trench` / memory zone.
  - Panel 4: `1C Capacitor Field` / power storage.
  - Panel 5: `1D Rail Approach` / transit corridor.
- Copied as design intent: top-down hard-surface room composition, large
  readable floor-layout silhouettes, raised perimeter walls, embedded cyan
  channels, central or directional landmark structures, bridge/trench depth,
  capacitor-bank clustering, and rail/gate corridor framing.
- Not copied directly: the PNG is not used as a floor texture, decal, or pasted
  plate. The Blender generator rebuilds the ideas as real low-profile 3D
  geometry with project materials.
- Blender rebuild plan from the reference:
  - 1.0 keeps the approved base Sector 1 arena unless a future approved pass
    requests a base-arena change.
  - 1A uses the communications-hub panel: four relay stations, a rectangular
    central receiver/console, orthogonal cable trays, perimeter banks, and
    signal emitter machinery.
  - 1B uses the memory-zone panel: a dominant central sunken data trench,
    narrower side conduits, raised side decks, bridge plates, and darker lower
    channels.
  - 1C uses the power-storage panel: central power spine, repeated capacitor
    cells, charge wells, bank clusters, meter faces, and side power buses.
  - 1D uses the transit-corridor panel: twin rail lanes, sleeper/bracket
    hardware, side armor, and a heavier far gate for the Grix approach.

## Official Docs Reviewed

Blender official documentation reviewed:

- Bevel Modifier:
  `https://docs.blender.org/manual/en/latest/modeling/modifiers/generate/bevel.html`
- Weighted Normal Modifier:
  `https://docs.blender.org/manual/en/latest/modeling/modifiers/normals/weighted_normal.html`
- Mesh Normals:
  `https://docs.blender.org/manual/en/latest/modeling/meshes/editing/mesh/normals.html`
- Principled BSDF:
  `https://docs.blender.org/manual/en/latest/render/shader_nodes/shader/principled.html`
- glTF / GLB Export:
  `https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html`
- Blender Python API:
  `https://docs.blender.org/api/current/index.html`

Godot official documentation reviewed:

- Importing 3D Scenes:
  `https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/index.html`
- `Node3D`:
  `https://docs.godotengine.org/en/stable/classes/class_node3d.html`
- `MeshInstance3D`:
  `https://docs.godotengine.org/en/stable/classes/class_meshinstance3d.html`
- `StandardMaterial3D` / `BaseMaterial3D`:
  `https://docs.godotengine.org/en/stable/classes/class_standardmaterial3d.html`
- `ResourceLoader`:
  `https://docs.godotengine.org/en/stable/classes/class_resourceloader.html`

Outside reference categories were used only for workflow framing: modular sci-fi
floor kits, hard-surface floor panels, arena readability, top-down/orthographic
camera readability, and neon channel integration. No third-party design was
copied.

## Role Delegation Summary

- Environment Art Director: keep all four variants inside the blue/cyan Neon
  Grid family while making each read distinctly at gameplay camera distance.
- Blender Hard-Surface Environment Artist: build one shared scripted kit with
  bevels, weighted normals, low floor panels, rails, trenches, cells, and border
  machinery; avoid tall interior props and collision.
- Material / Lighting Artist: keep `NS_S1_` materials, avoid black floor
  collapse, and keep cyan accents restrained so bullets, XP, enemies, ripple,
  and player stay readable.
- Godot Technical Artist: integrate full 1A-1D arena layouts through a Sector
  1-only runtime resolver, keep 1.0 on the approved base arena, and avoid
  preloading missing variants.
- Gameplay Readability QA: validate real campaign node switching, no duplicate
  arena roots, no gameplay collision nodes under variant imports, Phase 47 UI
  sequencing, and no Sector 2/Sector 5 changes.

## Blender Assets Created

- Source generator:
  `art/arenas/sector_1/source/blender/build_sector_1_subsector_arena_kit.py`
- Source blend:
  `art/arenas/sector_1/source/blender/sector_1_subsector_arena_kit.blend`
- Source notes:
  `art/arenas/sector_1/source/blender/sector_1_subsector_art_notes.md`

Runtime GLB exports:

- `art/arenas/sector_1/exported/sector_1_relay_yard.glb`
- `art/arenas/sector_1/exported/sector_1_data_trench.glb`
- `art/arenas/sector_1/exported/sector_1_capacitor_field.glb`
- `art/arenas/sector_1/exported/sector_1_rail_approach.glb`

The generator sets bevels, weighted normals, Principled BSDF materials, and GLB
exports. The new GLBs are full visual arena-layout variants and contain no
collision, cameras, lights, scripts, navigation, or alternate playable scene
setup.

## Runtime Integration

Runtime integration is in `scripts/NeonSwarm3DGameplayPrototype.gd`.

- Sector 1 campaign data now includes `arena_variant_key` only for 1A-1D.
- `SECTOR1_SUBSECTOR_ARENA_SCENE_PATHS` maps those keys to exported GLBs.
- `_create_sector1_neon_grid_3d_architecture()` creates the approved base
  Sector 1 arena only for 1.0.
- `_create_sector1_subsector_arena_variant()` loads the current 1A-1D full
  layout under `Sector1SubsectorArenaVariantRoot` instead of stacking it on the
  1.0 base room.
- `_current_sector1_subsector_arena_variant_key()` returns no variant for 1.0,
  returns the current 1A-1D key during normal subsectors, and lets Rail Approach
  persist into the Grix boss gate after 1D.
- The existing Sector 1 material visibility pass is applied to the imported
  variant root.

No player collision, hurtbox, arena bounds, enemy behavior, boss timing, reward
logic, Memory Shard logic, weapon balance, or official scene path was changed.

## Hotfix Art Quality Pass

The first Phase 48 pass technically made 1A-1D distinct, but too much of the
difference came from thin decorative cyan line overlays. The hotfix rebuilds the
Blender generator and exported GLBs so the variants read through intentional
modeled hard-surface structures.

The art-direction correction stops the same-base-room approach entirely:
1A-1D are full replacement visual layouts with their own floor foundation,
boundary frame, and major modeled landmarks while 1.0 remains the base Sector 1
arena.

Removed / reduced first-pass line clutter:

- `RelayYardReadableSignalLine`
- `DataTrenchBrokenMemoryStrip`
- `CapacitorFieldLowEnergyConduit`
- `RailApproachCoolWarningStrip`

Those were replaced with modeled tray beds, raised lips, relay hardware,
recessed trench lanes, bridge plates, capacitor housings, terminals, side power
buses, physical rail feet, rail caps, brackets, corridor walls, and stronger
Grix gate hardware. Cyan now appears as embedded windows, ports, sockets,
meters, lock faces, and contained power cores attached to the modeled forms.

## Visual Identity

- 1A Relay Yard: four large relay station foundations, raised relay-node pads,
  a rectangular central communications hub/receiver, inset relay service plates,
  short antenna masts, signal projector blocks, modeled orthogonal
  station-to-hub cable trays, trunk junction boxes, embedded signal windows,
  emitter cabinets, and perimeter relay wall banks.
- 1B Data Trench: a dominant central sunken trench, narrower side conduit
  trenches, raised deck islands, raised metal rims, heavy bridge plates,
  bolted clamps, central bridge side guards, a cross-cut service channel, broken
  memory panel hardware, contained cyan conduits, and end memory buses.
- 1C Capacitor Field: a clear capacitor cell-grid layout, a central power
  spine with charge nodes, larger capacitor cell bases, recessed charge wells,
  glowing charge plates, positive/negative terminals, side power buses,
  perimeter charge-bank bodies, meter faces, and contained cell traces.
- 1D Rail Approach: a strong rail-corridor composition with a central runway
  recess, two physical rail lanes with rail feet, raised rail caps, heavy
  sleeper plates, rail brackets, side defense corridor walls, side armor ribs,
  warning panels embedded in those walls, and a heavier north defense-gate frame
  with gate towers and a closed armor face.

## Manual Test Checklist

- Start a run and confirm 1.0 Awakening Grid uses the approved base Sector 1
  arena.
- Use F6/F11 test flow and confirm:
  - 1A loads Relay Yard as a full modeled layout, not an overlay.
  - 1B loads Data Trench as a full modeled layout, not an overlay.
  - 1C loads Capacitor Field as a full modeled layout, not an overlay.
  - 1D loads Rail Approach as a full modeled layout, not an overlay.
- Confirm the boss gate after 1D still leads to Grix the Rail Butcher.
- Confirm Prism Shard I still unlocks after Grix.
- Confirm player core, blue ripple, XP, enemies, bullets, HUD, Lyra, story
  cards, Memory Shard reveal, and reward/comparison panels remain readable.
- Confirm the hotfix variants read as modeled hard-surface arena structures
  rather than random neon floor-line overlays.
- Confirm Sector 2 is unchanged.
- Confirm no Sector 5 runtime content or ending sequence exists.

## Deferred

- Sector 2 subsector arena content is deferred to Phase 49.
- Sector 3 subsector arena content is deferred to Phase 50.
- Sector 4 subsector arena content is deferred to Phase 51.
- Sector 5 / Black Crown runtime remains future-only.
- Ending sequence remains future-only.
