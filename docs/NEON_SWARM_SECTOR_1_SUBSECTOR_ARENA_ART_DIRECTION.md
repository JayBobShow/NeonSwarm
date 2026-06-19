# Neon Swarm Sector 1 Subsector Arena Art Direction

Sector 1 is Neon Grid: a blue/cyan arcade battlefield built from dark
hard-surface Grid infrastructure.

Phase 48 keeps the approved 1.0 Awakening Grid arena as the base and adds
distinct visual-only full arena-layout variants for 1A through 1D.

The primary reference is the user-provided multi-image sheet:
`art/reference/sector_1_neon_grid/sector_1_refference_sheet.png`.

Reference panel mapping:

- Panel 1: 1.0 Awakening Grid / base starting arena.
- Panel 2: 1A Relay Yard / communications hub.
- Panel 3: 1B Data Trench / memory zone.
- Panel 4: 1C Capacitor Field / power storage.
- Panel 5: 1D Rail Approach / transit corridor.

The sheet is design intent, not a texture source. The implementation must copy
the layout language through modeled 3D forms: raised/recessed floor structure,
large landmarks, purpose-built machinery, embedded neon channels, and clear
camera-readable silhouettes.

## Shared Rules

- Stay in the Sector 1 blue/cyan Neon Grid family.
- Use dark aluminum, gunmetal, recessed depth metal, black service trim, and
  restrained cyan embedded channels.
- Keep the center fight space readable from the existing gameplay camera.
- Keep all geometry visual-only and low-profile.
- Do not build subsectors as decals, random line overlays, or the same base room
  with different small boxes drawn on top.
- Avoid random neon dash noise, bright full-floor grid clutter, black invisible
  floors, tall interior props, and collision complexity.
- Preserve player, XP, enemies, bullets, ripple, Lyra panel, HUD, boss cards,
  Memory Shard panel, and reward UI readability.

## 1A Relay Yard

Story purpose: Lyra begins tracing the broken Grid signal.

Visual language:

- Raised relay-node hardware arranged around the arena.
- Four large relay station foundations near the edges/corners.
- A rectangular central signal hub / receiver that anchors the layout.
- Modeled cable trays and tray lips, not free-floating line art.
- Embedded signal windows attached to trays, pads, cabinets, and wall banks.
- Perimeter relay wall banks, short antenna masts, and signal projector blocks.

Readability target: open and clean, with a clear signal-node identity and no
interior obstacle read.

## 1B Data Trench

Story purpose: the player pushes through corrupted Grid memory channels.

Visual language:

- One dominant central sunken trench plus narrower side data conduit trenches.
- Raised deck islands separated by the trench lanes.
- Raised lips and bridge plates across the channels.
- Broken memory panel hardware and contained cyan conduits inside trenches.
- Stronger depth read than 1A without hiding pickups or projectiles.

Readability target: the arena should feel like data channels under the player,
while the gameplay plane remains flat and uncluttered.

## 1C Capacitor Field

Story purpose: the Aether Core begins adapting and storing weapon memory.

Visual language:

- Capacitor plates and storage cells.
- A readable capacitor cell grid or energy-bank cluster layout.
- A central power spine with charge nodes.
- Dark charge wells with restrained cyan bars.
- Perimeter charge banks.
- Side power buses, meter faces, terminals, and contained capacitor traces.

Readability target: energized but not overbright; the center fighting area stays
clear.

## 1D Rail Approach

Story purpose: final approach to Grix's defense gate.

Visual language:

- Physical rail feet, raised rail caps, sleeper plates, and rail brackets.
- Central rail-corridor runway composition.
- Heavy north defense-gate approach with tower/gate framing.
- Embedded wall warning panels, lane power cores, and stronger military-grid
  structure.
- Heavier border/gate identity without starting the boss fight early.

Readability target: it should feel like the route into Grix's gate while leaving
combat, rewards, and story UI readable.
