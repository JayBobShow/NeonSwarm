# Neon Swarm Official Build Rule

## Permanent Rule

All approved Neon Swarm work must update the official current build.

Official scene:

`scenes/Main.tscn`

Official launch command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Godot F5 launch target:

```ini
run/main_scene="res://scenes/Main.tscn"
```

## Scope

This rule applies to all approved:

- gameplay work
- HUD work
- visual work
- audio work
- balance work
- enemy work
- weapon work
- boss work
- polish work
- bug fixes
- performance work

Do not leave approved work in side scenes or hidden test scenes.

## Alternate Scene Restriction

Do not create alternate playable scenes unless the user explicitly asks for a separate prototype.

If a temporary test scene is absolutely necessary:

1. Ask first.
2. Label it clearly.
3. Do not treat it as the main build.
4. Merge approved work back into `scenes/Main.tscn`.
5. Archive the test scene afterward.

## Reporting Requirements

Every future Neon Swarm report must include:

- exact command to run the official build
- confirmation whether `scenes/Main.tscn` was updated
- confirmation that `project.godot` still launches `res://scenes/Main.tscn`

Never leave the user guessing which scene is current.

## Current Confirmation

As of this rule document:

- official scene is `scenes/Main.tscn`
- official command is `godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn`
- `project.godot` main scene is `res://scenes/Main.tscn`
- F5 launches the official current build

## Reason

This rule exists because multiple scenes caused confusion and wasted testing time.

No future work should recreate that problem.
