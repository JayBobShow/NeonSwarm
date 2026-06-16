# Neon Swarm Phase 25 Weapon Icon / Preview Pipeline Report

## 1. Executive Summary

Phase 25 adds the first weapon family icon/preview pipeline to the official build only: `scenes/Main.tscn`.

The work makes weapon loot easier to read without changing combat balance, adding weapons, adding sectors, or redesigning the HUD/menu. Each active weapon family now has a geometry-driven functional preview icon, and the UI shows those icons in the Armory, stash rows, generated weapon rewards, replacement slot picker, comparison areas, and How To Play weapon education pages.

Important approval clarification:

- These icons are approved as family-level preview icons / placeholder UI symbols.
- These icons are not approved as final weapon art.
- Final weapon preview art remains future work.
- The current goal is one readable icon/preview per weapon family.
- Future 200+ weapon scaling should reuse this family-icon pipeline instead of creating unique art for every random weapon instance.

## 2. Approved Baseline Preserved

Preserved:

- Official scene path: `scenes/Main.tscn`
- Title screen and existing menu composition
- How To Play menu
- Armory / stash backend
- Options and saved settings
- Pause menu and Return to Title
- HUD
- Audio/mute
- XP, level-up, sector rewards, generated weapon reward flow
- Runtime weapon loadouts
- Sectors, bosses, death/restart, success/restart
- Controller/keyboard navigation
- Neon tube edge style

No gameplay balance, enemy, boss, weapon, sector, or combat logic changes were made.

## 3. Weapon Icon System

Added `scripts/ui/NeonWeaponIcon.gd`.

It provides:

- Runtime procedural vector icons for active weapon families.
- One icon per weapon family, not per random weapon instance.
- Rarity-aware accent coloring.
- Fallback unknown weapon icon handling.
- Helper mapping through `NeonWeaponIcon.icon_resource_path(definition_id)`.
- Temporary symbolic previews until higher-quality final weapon art/previews are approved.

Covered active family ids:

- `pulse_blaster`
- `orbit_spark`
- `nova_burst`
- `arc_beam`
- `gravity_mine`
- `prism_lance`
- `ring_saw`
- `hex_shatter`
- `fractal_shard`
- `tri_burst_cannon`
- `hex_mortar`
- `vector_spear`
- `orbital_saw_array`
- `prism_chain`
- `gravity_well`
- `nova_needle`
- `fractal_bloom`
- `shield_breaker`
- `star_pulse`
- `unknown_weapon`

`hex_shatter` is included because it is still an active catalog/runtime weapon family.

## 4. Icon Style / Shape Language

The icon style follows the approved Neon Swarm language as a functional placeholder preview style:

- Dark geometric base faces.
- Bright neon tube strokes.
- Cyan/magenta/orange accents.
- Clear silhouette at small UI sizes.
- Shape communicates weapon behavior.

Examples:

- Tri-Burst Cannon: three triangle bolts.
- Hex Mortar: hex shell with shard burst.
- Vector Spear: piercing rail/arrow.
- Gravity Well: neon ring/vortex.
- Star Pulse: radial starburst.
- Ring Saw: saw ring with teeth.
- Prism Chain: segmented chain beam.
- Nova Needle: thin needle streaks.

## 5. Tool Usage: Inkscape/Krita/Godot

Primary implementation uses Godot UI drawing through `NeonWeaponIcon.gd` so icons can inherit rarity accents and scale cleanly inside existing menus.

SVG assets were added under:

- `art/weapons/icons/`
- `art/weapons/icons/source/`

Those SVGs mirror the runtime shapes and are ready for future Inkscape/Krita polish. Krita was not needed for raster polish in this phase because the approved target was clean small vector-style placeholder UI previews, not final weapon art.

Future final-art work should create higher-quality weapon previews that better match each family’s in-game weapon visual/VFX.

## 6. Armory Integration

Armory now shows:

- Equipped weapon row icons.
- Stash weapon row icons.
- Larger selected weapon preview in the detail panel.
- Current-vs-selected comparison icons.

The Armory still uses the existing neon-glass panel style and controller/keyboard focus behavior.

## 7. Reward Card Integration

Generated weapon reward cards now show weapon family icons.

The in-run weapon loot decision panel now shows:

- New weapon preview icon.
- Current equipped comparison icon.
- Candidate reward weapon icon.
- Replacement slot icons for equipped weapons.

Stat upgrades remain text-focused, so normal level-up rewards do not get misleading weapon icons.

## 8. How To Play Integration

How To Play now includes compact weapon example icon rows on:

- Weapon Systems
- Sector Rewards
- Armory / Stash

The Weapon Systems page also explains that icons represent weapon family behavior while random stats modify individual weapon instances.

## 9. Fallback/Future-Proofing

Future weapon families that are missing an explicit icon fall back to `unknown_weapon`.

To add a future weapon icon:

1. Add the family id to `NeonWeaponIcon.icon_ids()`.
2. Add the family drawing branch in `_draw_family_icon()`.
3. Add a matching SVG under `art/weapons/icons/`.
4. Keep the icon readable at Armory row, reward card, comparison, and How To Play sizes.

The pipeline intentionally avoids creating 200+ manual images now. Future 200+ weapon scaling should keep using one family preview as the base identity, with random stats/modifiers shown through text, rarity frames, and later approved modifier glyphs.

Final weapon art is still future work:

- The current Phase 25 icons are functional UI symbols.
- They should not be treated as finished item art.
- A later final weapon preview pass should better match each weapon’s actual in-game projectile, beam, orbit, mine, pulse, or burst VFX.
- That future pass should preserve this mapping system so Armory, rewards, stash, comparison, and How To Play do not need to be rebuilt.

## 10. Files Changed

Code:

- `scripts/NeonSwarm3DGameplayPrototype.gd`
- `scripts/ui/NeonWeaponIcon.gd`

New icon assets:

- `art/weapons/icons/*.svg`
- `art/weapons/icons/source/neon_weapon_icon_family_sheet.svg`
- `art/weapons/icons/source/neon_weapon_icon_pipeline_notes.md`

Docs:

- `docs/NEON_SWARM_PHASE_25_WEAPON_ICON_PREVIEW_PIPELINE_REPORT.md`
- `docs/NEON_SWARM_WEAPON_SYSTEM_ARCHITECTURE.md`
- `docs/NEON_SWARM_STASH_ARMORY_PLAN.md`
- `docs/NEON_SWARM_FULL_GAME_ROADMAP.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_AUDIT.md`

## 11. Validation Results

Required commands:

- PASS: `godot --headless --path . --quit-after 3`
- PASS: `godot --headless --path . --quit-after 3000`
- PASS: `godot --headless --path . scenes/Main.tscn --quit-after 3`

Additional Phase 25 icon smoke validation:

- PASS: `/tmp/neon_swarm_phase25_weapon_icon_validation.gd`

Validated by script:

- Armory equipped icon controls exist.
- Armory selected weapon preview appears.
- Generated weapon reward card icon appears.
- In-run reward decision preview icon appears.
- Candidate comparison icon appears.
- Replacement slot icons appear.
- How To Play weapon example icons appear.
- Missing/future weapon family maps to fallback icon path.

## 12. Exact Run Command

`godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`

## 13. What The User Should Test

Test these in the playable build:

- Open Armory and confirm equipped/stash rows show weapon icons.
- Select different equipped/stash weapons and confirm the large preview changes.
- Compare a stashed weapon against an equipped slot and confirm both icons show.
- Clear a sector and confirm generated weapon reward cards show family icons.
- Use Replace Slot and confirm equipped slot rows show current weapon icons.
- Open How To Play and review Weapon Systems, Sector Rewards, and Armory / Stash pages.
- Confirm Start Game, Options, pause, Return to Title, rewards, and weapon loadouts still behave as before.

## 14. Known Issues

- Icons are family-level previews only; random stats/modifiers do not get separate art yet.
- Icons are placeholder UI symbols and are not final weapon art.
- SVG files are lightweight vector exports and have not had a dedicated Inkscape/Krita final-art polish pass.
- Final weapon preview art that better matches in-game weapon VFX remains future work.
- No force-test weapon menu was added; weapon acquisition remains random by approved direction.

## 15. Approval Status / Question

Phase 25 is approved as a weapon icon / preview pipeline only.

Open approval question for a later phase: should a future final weapon art/previews pass replace these placeholder family symbols with higher-quality previews that match the actual in-game weapon visuals and VFX?
