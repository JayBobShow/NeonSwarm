# Neon Swarm Active QA Checklist

Use this checklist for active Neon Swarm work. Scale the depth of testing to the
risk of the change, but do not skip the official scene and git hygiene checks.

Official scene:

- Confirm the official scene is still `scenes/Main.tscn`.
- Confirm `project.godot` still launches `res://scenes/Main.tscn` if project
  settings were touched.
- Launch with:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Launch and startup:

- Project opens without import or parse errors.
- Title/menu flow reaches gameplay.
- No new warnings indicate broken resources, missing scripts, missing imports, or
  invalid scene references.

Controls:

- Keyboard and mouse input works.
- Controller input works when the task could affect controls or UI.
- Pause, resume, menus, and Armory navigation remain usable.
- Manual aim and right-stick aim remain consistent with current weapon rules.

Player movement and camera:

- Player movement is responsive and locked to the intended gameplay plane.
- Camera keeps the player, arena, threats, and pickups readable.
- No new camera shake, zoom, obstruction, or geometry hides gameplay.

Bullets and projectiles:

- Player projectiles are bright, directional, and readable during combat.
- Enemy bullets and boss projectiles are distinct from player shots.
- Projectile caps, cleanup, and performance guardrails remain intact.
- Impacts and trails do not hide incoming threats.

Enemy readability:

- Enemy silhouettes remain visible at gameplay camera distance.
- Tiny enemies are not invisible against the floor or VFX.
- Enemy families retain distinct shape/color/motion reads.
- Spawn density does not turn into unreadable neon clutter.

XP and pickups:

- XP orbs remain visible against each active sector floor.
- Pickup motion and collection feedback remain clear.
- Rewards do not hide immediate threats.

Weapon rewards and loadout:

- In-run weapon reward UI opens, reads clearly, and closes safely.
- Weapon names, rarity, stats, and replacement choices remain understandable.
- Existing active/passive/equipment slot behavior is preserved.
- Locked or empty slots do not fire.

Sector progression:

- Sector transitions remain coherent.
- Sector identity is visible without hurting combat readability.
- Arena boundaries are understandable and do not imply false playable routes.
- Debug/test sector jumps still work when relevant to the change.

Campaign progression:

- Campaign nodes, story cards, unlocks, memory shards, and progression flags
  remain consistent with current runtime expectations.
- Save/load behavior does not skip, duplicate, or corrupt campaign progress.

Boss readability:

- Boss silhouette and arena position remain readable.
- Attack telegraphs are visible before damage.
- Boss projectiles are distinct from player projectiles and sector effects.
- Boss VFX does not cover the player, HUD, XP, or enemy bullets.

HUD readability:

- Health, XP, level, weapon/equipment slots, sector info, boss info, and prompts
  are readable in active combat.
- HUD elements do not overlap critical gameplay.
- Text fits inside UI containers at expected viewport sizes.
- Clutter is reduced before adding more effects or labels.

Controller support:

- Start/menu navigation, gameplay, aim, pause, Armory, rewards, settings, and
  back/cancel flows are controller-safe when relevant.
- Focus indicators are visible.
- No mouse-only flow blocks controller users.

Performance:

- Enemy, projectile, XP, VFX, mine, beam, and burst caps remain effective.
- No persistent spawned objects leak over time.
- Busy combat remains responsive.
- Decorative VFX is reduced before gameplay-critical readability.

Save/settings safety:

- Settings changes persist only as intended.
- Save data is not reset, corrupted, or migrated without explicit scope.
- Defaults remain safe if config files are absent.
- Runtime tests do not overwrite user progress unless explicitly approved.

Git hygiene:

- Run `git status --short --branch` before and after work.
- Review `git diff --stat` and relevant diffs before closeout.
- Report changed files.
- Commit locally when complete and safe.
- Do not push unless the user approves.
