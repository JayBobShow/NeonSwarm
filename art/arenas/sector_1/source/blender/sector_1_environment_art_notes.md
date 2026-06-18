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

Current art structure:

- 7x7 base layout retained for bounds alignment, but panel variants break the tile-board read.
- Floor modules include service hatches, vents, diagonal braces, heavy access covers, macro ribs, and a central low power-deck panel.
- Seam channels are recessed dark trenches with bridge plates; floor-level random cyan dash accents were removed in Hotfix 5.
- Border walls are segmented machinery modules with plinths, inset wall faces, top caps, inner curbs, brackets, and restrained cyan rail segments.
- Corner and mid-wall anchors are built as dark machinery, not bright markers.

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
