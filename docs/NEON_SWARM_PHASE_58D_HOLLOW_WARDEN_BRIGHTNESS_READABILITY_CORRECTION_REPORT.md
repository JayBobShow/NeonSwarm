# Neon Swarm Phase 58D Hollow Warden Brightness Readability Correction Report

## 1. Summary

Phase 58D is a narrow Hollow Warden brightness/readability correction.

User feedback:

- Hollow Warden was too bright after Phase 58C.
- The overlay/glow made the actual boss shape hard to see.
- Do not redesign the boss.
- Do not start a broad enemy art pass.
- Enemy art and brightness complaints should be recorded as future art backlog
  only.

Result: pass.

This pass reduces material brightness, emission, and alpha for the Phase 58C
Hollow Warden identity overlay and lightly pulls back the Phase 58C
Hollow-Warden-only telegraph brightness. No geometry, behavior, pressure,
runtime progression, scene, project setting, art, Blender, or GLB files changed.

## 2. Official Build

Official scene:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

The official playable scene remains `scenes/Main.tscn`.

`project.godot` remains expected to launch `res://scenes/Main.tscn`.

No alternate playable scene was created.

## 3. Docs And References Consulted

- `AGENTS.md`
- `STUDIO.md`
- `docs/NEON_SWARM_OFFICIAL_BUILD_RULE.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- `docs/NEON_SWARM_PHASE_58A_HOLLOW_WARDEN_PRODUCTION_PLANNING_REPORT.md`
- `docs/NEON_SWARM_PHASE_58B_HOLLOW_WARDEN_PRODUCTION_GAP_REVIEW_REPORT.md`
- `docs/NEON_SWARM_PHASE_58C_HOLLOW_WARDEN_VISUAL_READABILITY_IDENTITY_REPORT.md`
- `docs/NEON_SWARM_PHASE_55D_SECTOR_4_BOSS_GATE_HOLLOW_WARDEN_REVIEW_REPORT.md`
- Official Godot documentation for `StandardMaterial3D`, `Node3D`, and
  `MeshInstance3D`

## 4. Exact Implementation

Changed file:

- `scripts/NeonSwarm3DGameplayPrototype.gd`

The correction changes material values only:

| Material | Phase 58C | Phase 58D |
| --- | --- | --- |
| `boss_telegraph_prime` | alpha `0.50`, energy `5.05` | alpha `0.40`, energy `4.35` |
| `boss_telegraph_prime_core` | alpha `0.82`, energy `6.00` | alpha `0.56`, energy `4.60` |
| `hollow_warden_lock` | alpha `0.64`, energy `5.25` | alpha `0.34`, energy `2.65` |
| `hollow_warden_lock_core` | alpha `0.92`, energy `7.40` | alpha `0.50`, energy `3.60` |
| `hollow_warden_glyph` | alpha `0.44`, energy `4.25` | alpha `0.22`, energy `2.00` |
| `hollow_warden_body` | body energy `0.50` | body energy `0.24` |

The Phase 58C overlay child structure remains intact and still attaches only to
`final_null_octagon`, which maps to the `null_octagon_prime` visual path.

## 5. What Did Not Change

Confirmed unchanged:

- Boss behavior
- Boss attacks
- Boss phases
- Boss movement
- Boss health and stats
- Boss projectile behavior
- Boss gate timing
- Boss arrival card
- Boss bar behavior
- Lyra warning
- Memory Shard IV
- Run-complete after Hollow Warden
- Pressure, enemies, adds, hazards, projectiles, XP, rewards, weapons, HUD, save
  schema, and caps
- Sector 4 pressure and the 4A enemy headroom caveat
- Sector 5 runtime
- Null King, Crown Shard, Prism Shards V/VI runtime behavior
- `scenes/Main.tscn`
- `project.godot`
- Art files, Blender files, and GLB files
- Alternate scenes

No broad enemy art pass, enemy redesign, or global brightness pass was
performed.

## 6. Validation Results

Passed:

```bash
godot --headless --path . --quit-after 3
godot --headless --path . --scene scenes/Main.tscn --quit-after 3
timeout 60s godot --headless --path . --script /tmp/neon_swarm_phase58c_hollow_warden_review.gd
```

Focused official-scene Hollow Warden review confirmed:

- Sector 4 advanced through 4A, 4B, 4C, 4D, and the boss gate.
- Hollow Warden warning and arrival still used the existing boss-gate path.
- Hollow Warden overlay still attached.
- Overlay collision child count remained `0`.
- Existing telegraphs still appeared:
  - `null_radial`
  - `null_void_pulse`
  - `hyper_rail_sweep`
  - `null_adds`
- Memory Shard IV, `prism_shard_4_living_lock`, still unlocked/queued after
  Hollow Warden defeat.
- Run-complete still triggered after Hollow Warden defeat.
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

## 7. QA Notes

This correction specifically addresses the Phase 58C brightness problem by
reducing local overlay/glow intensity so the original boss shape can read again.

Broad enemy art quality, enemy brightness hierarchy, and broader enemy
readability concerns are deferred to a future art polish backlog. They were not
handled in this phase.

Display capture remains limited in this environment:

- Non-headless capture is not available because no X11 or Wayland display is
  available.
- Headless capture cannot save viewport images with the dummy renderer.

The required headless boot and focused official-scene runtime review passed.

## 8. Follow-Up Recommendation

Phase 58D is safe to close as a narrow brightness/readability correction.

Next safest step: review-only Hollow Warden readability confirmation on a
display-capable machine, or broader enemy-art backlog planning if the user wants
to address enemy art quality later. Do not start that broader pass without
separate approval.
