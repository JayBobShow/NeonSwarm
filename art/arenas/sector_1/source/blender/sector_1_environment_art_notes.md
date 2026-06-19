# Sector 1 Neon Grid Environment Art Notes

Phase 38 Hard Repair 3 rebuilds the Level 1 arena as a visual-only hard-surface metal power deck.

Goals:

- Read as dark aluminum/gunmetal 3D construction at the gameplay camera distance.
- Keep gameplay locked to the existing flat X/Z plane.
- Use the Blender source and exported GLB as the active Sector 1 arena kit.
- Keep cyan as restrained embedded channels and rail accents.
- Preserve player, enemy, XP, projectile, event, HUD, and Phase 37 ripple readability.

Do not reintroduce:

- Full-length white/cyan center cross lines.
- Bright corner cap marker dots.
- Continuous flat cyan grid lines across the whole floor.
- Runtime procedural Sector 1 floor tiles over the GLB.
- Tall interior floor objects that look like gameplay obstacles.
- Dynamic light spam or material bloom that washes out combat reads.
- Random short cyan floor dash accents. Hotfix 5 removed the service/vent/heavy/reactor dash marks and scattered seam accent dashes; keep cyan accents on intentional wall/perimeter machinery instead.
- Running outer rails/buttresses outside the arena. Hotfix 6 removed the far restrained cyan rails and outer service buttresses beyond the actual playfield boundary.

Current art structure:

- 7x7 base layout retained for bounds alignment, but panel variants break the tile-board read.
- Floor modules include service hatches, vents, diagonal braces, heavy access covers, macro ribs, and a central low power-deck panel.
- Seam channels are recessed dark trenches with bridge plates; floor-level random cyan dash accents were removed in Hotfix 5.
- Border walls are segmented machinery modules with plinths, inset wall faces, top caps, inner curbs, brackets, and restrained cyan rail segments.
- Corner and mid-wall anchors are built as dark machinery, not bright markers.
- Far outside depth rails/buttresses are intentionally absent after Hotfix 6; keep the visual boundary on the playable arena edge.

Hard Repair 4 material/lighting visibility notes:

- The Hard Repair 3 geometry was not rebuilt; the issue was value/lighting collapse, not missing modeled structure.
- Metal panel materials were lifted out of near-black and moved from very high metallic toward mixed metal/diffuse response so they stay visible under the Sector 1 runtime lighting.
- The runtime still applies a Sector 1-only material visibility pass to imported `NS_S1_` materials after GLB load so the exported asset and live build stay aligned.
- Cyan channel/rail materials remain restrained accents and should not return to full-floor grid identity.
- A single shadowless Godot `DirectionalLight3D` is added at runtime on an arena-only visual light layer to help the metal catch light without globally brightening combat objects.

Hotfix 5 floor accent / ripple visibility notes:

- Floor-level cyan dash accents were removed from the Blender source because they read as random weak markers at gameplay zoom.
- Perimeter rails, wall slits, pylon insets, and boundary cyan accents remain so the arena edge still reads as built neon machinery.
- Do not re-add `ShortCyanHatchStatus`, `TinyEmbeddedCyanVentCue`, `CyanAccessTag`, `NorthCyanPowerInset`, `SouthCyanPowerInset`, or `Sector1AAAEmbeddedCyanAccentX/Y` without a full art review.
- The player propulsion ripple is now rendered slightly above the raised floor details at runtime; future floor details near arena center should stay below that visual layer unless the ripple offset is retuned.

Hotfix 6 outer rail cleanup notes:

- Removed `Sector1AAAOuterNorth/South/West/EastServiceButtress*` meshes from the Blender build.
- Removed `Sector1AAAFarNorth/South/West/EastRestrainedCyanRail` meshes from the Blender build.
- Kept `Sector1AAASegmentedWall_*_*`, `Sector1AAASegmentedWall_*_*_SegmentedCyanTopRail`, `Sector1AAACornerMachineryAnchor*`, and `Sector1AAAMidWallPylon_*_*` as the actual readable arena boundary.
- Do not re-add decorative rails past the arena half-size unless they are clearly outside the camera/playfield composition and approved as background architecture.

Phase 48 Sector 1 subsector notes:

- `sector_1_neon_grid_arena.glb` remains the 1.0 Awakening Grid base arena.
- `sector_1_relay_yard.glb`, `sector_1_data_trench.glb`, `sector_1_capacitor_field.glb`, and `sector_1_rail_approach.glb` are visual-only overlays for 1A-1D.
- The subsector overlays are built from `build_sector_1_subsector_arena_kit.py` and `sector_1_subsector_arena_kit.blend`.
- Keep these overlays low-profile, collision-free, and inside the existing blue/cyan Neon Grid family.
- Do not use Phase 48 as precedent for Sector 2/3/4 art; those require separate approved content phases.
