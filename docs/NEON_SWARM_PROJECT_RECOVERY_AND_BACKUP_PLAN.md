# Neon Swarm Project Recovery And Backup Plan

## Official Project

- Official project path: `/home/jason/GodotProjects/NeonSwarm`
- Official scene: `scenes/Main.tscn`
- Official run command:

```bash
godot --path /home/jason/GodotProjects/NeonSwarm scenes/Main.tscn
```

Neon Swarm is in active development. Do not describe the project as release-ready unless that is explicitly approved later.

## Check Git Status

From the project root:

```bash
cd /home/jason/GodotProjects/NeonSwarm
git status
git log --oneline -5
git remote -v
```

Use `git status` before and after changes so untracked files, cache folders, and unexpected edits are visible.

## Make A Normal Commit

From the project root:

```bash
cd /home/jason/GodotProjects/NeonSwarm
git status
git add .
git status
git commit -m "Short clear commit message"
```

Before committing, confirm the staged list does not include Godot cache folders, exported builds, local logs, or personal save data.

## Push To GitHub

Remote repository:

```text
https://github.com/JayBobShow/NeonSwarm.git
```

Push after the commit is reviewed:

```bash
git push origin main
```

Do not push automatically if the current task asks to report back first.

## Create A Backup Archive

Run:

```bash
cd /home/jason/GodotProjects/NeonSwarm
bash tools/backup_neon_swarm.sh
```

Backups are written to:

```text
~/GodotProjects/NeonSwarm_BACKUPS/
```

The backup script prints the full archive path when finished.

The archive includes project files, art, scripts, scenes, docs, and config. It excludes:

- `.git/`
- `.godot/`
- `.import/`
- build/export folders
- temporary/cache/log files
- Blender `*.blend1` backup files

## Restore From Git

To inspect recent commits:

```bash
cd /home/jason/GodotProjects/NeonSwarm
git log --oneline -10
```

To restore a single file from the approved baseline or another known commit:

```bash
git restore --source <commit-hash> -- path/to/file
```

To review what changed before committing:

```bash
git diff
git status
```

Avoid destructive whole-project resets unless explicitly approved.

## Restore From Backup Archive

Example:

```bash
mkdir -p ~/GodotProjects/NeonSwarm_RESTORE_TEST
tar -xzf ~/GodotProjects/NeonSwarm_BACKUPS/neon_swarm_backup_YYYYMMDD_HHMMSS.tar.gz -C ~/GodotProjects/NeonSwarm_RESTORE_TEST
```

After extraction, inspect the restored copy before replacing the active project.

If intentionally replacing the active project from a backup, first create a fresh backup of the current active project, then restore from the archive with care.

## Do Not Commit Godot Cache Folders

Do not commit:

- `.godot/`
- `.import/`
- exported build folders
- temporary logs or cache files

These are local/generated artifacts and can create noisy or broken history.

## Do Not Commit Personal Save Data Unless Intended

Godot `user://` save data, local settings, local inventory saves, or other personal runtime state should not be committed unless a future task explicitly asks for controlled test fixtures.

Current gameplay settings/inventory save data is local player data, not source content.

## Approved Baseline

Current approved baseline commit at Phase 33 start:

```text
bff4a6b Phase 32 approved baseline
```
