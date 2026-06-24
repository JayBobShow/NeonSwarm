---
name: neon-art-readability-qa
description: Use for Neon Swarm visual QA, art direction review, readability checks, HUD clarity, projectile visibility, enemy silhouette review, and neon contrast evaluation.
---

# Neon Art Readability QA

Use this skill to review Neon Swarm visual changes before or after art, VFX,
arena, boss, enemy, projectile, HUD, or readability work.

## Required References

Read:

- `docs/NEON_SWARM_ACTIVE_ART_DIRECTION.md`
- `docs/NEON_SWARM_APPROVED_VISUAL_STYLE_LOCK.md`
- `docs/NEON_SWARM_GEOMETRY_SHAPE_LANGUAGE_BIBLE.md`
- `docs/NEON_SWARM_ACTIVE_QA_CHECKLIST.md`
- Relevant sector, enemy, boss, HUD, or phase docs

## Review Priorities

Gameplay readability wins over decoration.

Check, in order:

1. Player silhouette and position.
2. Enemy danger silhouette, color, and motion.
3. Enemy bullets and boss attack telegraphs.
4. Player projectiles and weapon effects.
5. XP orbs and rewards.
6. HUD legibility.
7. Arena identity and background art.

## Camera-Distance Checks

Evaluate visuals at actual gameplay camera distance, not only in isolated asset
renders or editor close-ups.

Reject or flag:

- Tiny enemies that disappear in motion.
- Black-on-black floors.
- Muddy neon glow that erases silhouette hierarchy.
- Projectiles with weak direction, weak ownership, or weak contrast.
- Boss tells hidden by arena effects.
- XP hidden by floor lines, particles, or enemy effects.
- HUD text or icons that overlap combat reads.

## Neon Contrast Checks

Approved Neon Swarm contrast uses:

- Dark readable 3D faces.
- Bright neon tube edges.
- White-hot accents where gameplay importance needs emphasis.
- Controlled local glow.
- Distinct sector palettes that still preserve player, enemy, projectile, XP,
  and HUD readability.

Do not approve broad bloom or haze as a substitute for strong shape design.

## Output Format

Report:

- Overall readability verdict.
- Highest-risk visual issue first.
- Player readability.
- Enemy readability.
- Projectile and boss telegraph readability.
- XP and pickup visibility.
- HUD readability.
- Arena/background contrast.
- Performance or clutter risks.
- Specific recommended fixes.

If no issue is found, say that clearly and note what was checked.
