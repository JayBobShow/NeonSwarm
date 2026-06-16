# Neon Swarm Phase 17 Technical Cleanup, Export Prep, and QA Report

## 1. Executive Summary

Phase 17 is a technical cleanup, QA hygiene, and future build-readiness pass for the official Neon Swarm prototype.

This phase does not mean Neon Swarm is close to finished. The game remains in active development.

Current approved baseline:

- Title screen works.
- Options menu works.
- Audio works.
- Three-sector prototype run works.
- Core gameplay loop works.

Major development still needed:

- More sectors
- More enemies
- More bosses
- More weapons
- Better progression
- Stronger replay value
- Better enemy and boss variety
- Better long-term structure
- More polish
- More content depth

No new sectors, enemies, bosses, weapons, HUD redesigns, title redesigns, campaign/story systems, meta progression, alternate playable scenes, or hidden test scenes were created.

## 2. Approved Phase 16 Baseline Preserved

Preserved:

- Approved title screen layout
- Approved centered Options panel
- HUD
- Phase 16 music and SFX
- Audio volume/mute behavior
- Controller and keyboard support
- Pause
- Restart after death
- Restart after success
- XP spawn and collection
- Level-up flow
- Sector progression
- Sector rewards
- Bosses and boss events
- Settings save/load
- Fullscreen toggle
- VFX LOW / NORMAL / HIGH
- Neon tube edge visual style
- Runtime caps

## 3. Cleanup Performed

Project metadata:

- Set `config/version="0.17.0-dev"` in `project.godot`.
- Confirmed app name is `Neon Swarm`.
- Confirmed main scene remains `res://scenes/Main.tscn`.
- Confirmed icon remains `res://art/branding/neonswarm_icon.png`.

Player-facing cleanup:

- Replaced visible title status text with `ACTIVE DEVELOPMENT // v0.17`.
- Updated console build banner to active-development wording.
- Updated console runtime summary wording from review-build phrasing to `Neon Swarm runtime summary`.

Future build-readiness cleanup:

- Added a Linux export preset.
- Excluded docs from the export preset.
- Excluded archived Phase 2 prototype scenes from the export preset.
- Excluded old visual prototype/proof-board scripts from the export preset.
- Excluded source SVG UI construction files from the export preset.

Not deleted:

- `scenes/archive_phase2_old/*` remains in the project tree for historical reference. It is excluded from the export preset because deleting archived prototype work is riskier than excluding it from future build packaging.

## 4. Export Setup / Export Result

Created:

- `export_presets.cfg`
- `builds/linux/`

Linux preset:

- Name: `Linux`
- Platform: `Linux`
- Architecture: `x86_64`
- Export path: `builds/linux/NeonSwarm.x86_64`
- Main scene: inherited from project setting `res://scenes/Main.tscn`
- Icon: inherited from project setting `res://art/branding/neonswarm_icon.png`

Export result from the Phase 17 check:

- Binary export did not succeed because Linux export templates are missing.
- No exported executable was created.
- `builds/linux/` is currently empty.

Godot reported missing templates:

- `/home/jason/.local/share/godot/export_templates/4.6.3.stable/linux_debug.x86_64`
- `/home/jason/.local/share/godot/export_templates/4.6.3.stable/linux_release.x86_64`

No further export work was attempted after the status correction.

## 5. Player-Facing Polish Check

Checked:

- Window/app name is `Neon Swarm`.
- Main scene is official `scenes/Main.tscn`.
- Title menu launches.
- Start Game works.
- Options opens and closes.
- Approved Options panel position remains `(740, 380)` with size `(560, 520)`.
- Options controls still save and load settings.
- Fullscreen toggle remains present.
- Audio defaults and sliders remain functional.
- Quit path exits cleanly.
- Death screen appears.
- `RUN COMPLETE` screen appears.
- No stale phase marker/debug label was found in the official player-facing scene/script after cleanup.
- Title status now reads as an active-development build.

## 6. Full Run QA Results

Phase 17 full QA passed:

- Official `Main.tscn` loads.
- Project app name is set.
- Project main scene is official.
- Approved icon is configured.
- Title menu launches.
- Title music state is active.
- Options opens and closes.
- Start Game works.
- Gameplay music state becomes active.
- Caps are valid after start.
- Every current enemy type spawns:
  - Chaser
  - Tank
  - Shooter
  - Exploder
  - Spiral Drifter
  - Shield Node
  - Hex Slicer
  - Prism Leech
  - Triad Splitter
  - Triad Fragment
  - Hex Pulser
  - Mini Boss / Prism Warden
  - Fractal Crown
  - Null Octagon
  - Final Null Octagon
- Current weapon families validate:
  - Pulse Blaster projectile
  - Hex Shatter projectile
  - Fractal Shard projectile
  - Prism Lance projectile
  - Nova effect
  - Arc Beam effect
  - Gravity Mine
  - Ring Saw visual
  - Orbit Spark visuals
- XP collection triggers level-up.
- Pause and resume work.
- Sector 1 reward appears.
- Sector 2 starts.
- Sector 2 reward appears.
- Sector 3 starts.
- Final boss clear triggers `RUN COMPLETE`.
- Music loop stops on success.
- Success/restart works.
- Death works.
- Music loop stops on death.
- Death/restart works.
- Caps remain valid at QA end.

## 7. Warning/Error Review

Required headless validation produced no blocking warnings or errors.

Known forced-exit warning review:

- Normal Quit path was tested through the official `_quit_game()` path.
- Normal Quit exited cleanly with exit code 0 and did not print the previous object-leak warning.
- Forced non-headless `--quit-after 3` launch was retested.
- Forced non-headless launch exited with code 0 and did not reproduce the previous object-leak warning.

Export warning/error:

- Export currently fails only because the Linux export templates are missing.
- This is an environment/export-template blocker, not a gameplay or project-resource failure.

## 8. Performance Results

Required validation passed:

- `godot --headless --path . --quit-after 3`
- `godot --headless --path . --quit-after 3000`
- `godot --headless --path . scenes/Main.tscn --quit-after 3`

Additional validation passed:

- `PHASE17_FULL_QA_PASS`
- `PHASE16_AUDIO_SMOKE_PASS`
- `PHASE16_AUDIO_MIX_HOTFIX_PASS`
- `PHASE15_OPTIONS_SMOKE_PASS`
- `PHASE15_OPTIONS_LAYOUT_HOTFIX_PASS`
- `PHASE15_RUNTIME_STRESS_PASS`

Stress results:

- Enemy cap stayed within 54.
- XP cap stayed within 100.
- Player projectile cap stayed within 36.
- Enemy projectile cap stayed within 28.
- Burst cap stayed within 18.
- Beam cap stayed within 8.
- Mine cap stayed within 6.
- Hazard trail cap stayed within 10.
- Triad Fragment count remained capped.

## 9. Files Changed

Project files:

- `project.godot`
- `export_presets.cfg`
- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `docs/NEON_SWARM_PHASE_17_TECHNICAL_CLEANUP_EXPORT_PREP_QA_REPORT.md`

Removed outdated report artifact:

- Previous incorrectly named Phase 17 report file.

Directory created:

- `builds/linux/`

Temporary validation only:

- `/tmp/neon_swarm_phase17_full_qa.gd`
- `/tmp/neon_swarm_phase17_normal_quit_validation.gd`
- `/tmp/neon_swarm_phase16_audio_smoke.gd`
- `/tmp/neon_swarm_phase16_audio_mix_hotfix_validation.gd`
- `/tmp/neon_swarm_phase15_options_smoke.gd`
- `/tmp/neon_swarm_phase15_options_layout_validation.gd`
- `/tmp/neon_swarm_phase15_runtime_stress.gd`

## 10. Exact Editor Run Command

```sh
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

## 11. Exact Export Command or Export Steps

Command attempted during Phase 17 export-prep check:

```sh
godot --headless --path . --export-release Linux builds/linux/NeonSwarm.x86_64
```

Current blocker:

- Godot 4.6.3 Linux export templates are not installed.

No template installation or further export retry was performed after the status correction.

When export is explicitly requested later:

1. Open Godot 4.6.3.
2. Go to `Editor > Manage Export Templates`.
3. Install/download export templates for `4.6.3.stable`.
4. Open `Project > Export`.
5. Select the `Linux` preset.
6. Export to `builds/linux/NeonSwarm.x86_64`.

After templates are installed, command-line export should be:

```sh
godot --headless --path /home/jason/GodotProjects/NeonSwarm --export-release Linux builds/linux/NeonSwarm.x86_64
```

## 12. Exported Build Location, if Created

No exported Linux build was created because export templates are missing.

Intended future output location:

```text
builds/linux/NeonSwarm.x86_64
```

## 13. What The User Should Test

- Launch the editor build with the official run command.
- Confirm the title screen reads as active development.
- Confirm Options panel position and controls.
- Confirm Master/SFX/Music/Mute settings.
- Confirm saved settings persist after restart.
- Play from title to `RUN COMPLETE`.
- Confirm death/restart and success/restart.
- Confirm controller and keyboard behavior on physical hardware.
- Continue production work on content depth, progression, sector variety, enemy variety, boss variety, weapon variety, replay value, and long-term structure.

## 14. Known Issues

- Linux binary export is blocked until Godot 4.6.3 export templates are installed.
- `builds/linux/` exists but contains no executable yet.
- Archived old Phase 2 prototype scenes remain in `scenes/archive_phase2_old/`; they are excluded from the Linux export preset.
- Final audio loudness/taste still needs human speaker/headphone review in the playable build.
- Exported-build smoke could not be run because no executable was created.
- The game remains an active-development prototype and still needs major content, progression, replay, and polish work.

## 15. Approval Question

Is Phase 17 approved as technical cleanup, QA hygiene, export-prep check, and future build-readiness for the official `scenes/Main.tscn` active-development build?
