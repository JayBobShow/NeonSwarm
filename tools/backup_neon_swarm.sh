#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PROJECT_PARENT="$(dirname "${PROJECT_ROOT}")"
PROJECT_NAME="$(basename "${PROJECT_ROOT}")"
BACKUP_DIR="${HOME}/GodotProjects/NeonSwarm_BACKUPS"
TIMESTAMP="$(date +"%Y%m%d_%H%M%S")"
ARCHIVE_PATH="${BACKUP_DIR}/neon_swarm_backup_${TIMESTAMP}.tar.gz"

mkdir -p "${BACKUP_DIR}"

tar -C "${PROJECT_PARENT}" -czf "${ARCHIVE_PATH}" \
	--exclude="${PROJECT_NAME}/.git" \
	--exclude="${PROJECT_NAME}/.godot" \
	--exclude="${PROJECT_NAME}/.import" \
	--exclude="${PROJECT_NAME}/build" \
	--exclude="${PROJECT_NAME}/builds" \
	--exclude="${PROJECT_NAME}/export" \
	--exclude="${PROJECT_NAME}/exports" \
	--exclude="${PROJECT_NAME}/tmp" \
	--exclude="${PROJECT_NAME}/temp" \
	--exclude="${PROJECT_NAME}/cache" \
	--exclude="${PROJECT_NAME}/logs" \
	--exclude="${PROJECT_NAME}/NeonSwarm_BACKUPS" \
	--exclude="*.tmp" \
	--exclude="*.cache" \
	--exclude="*.log" \
	--exclude="*.bak" \
	--exclude="*.blend1" \
	--exclude="*~" \
	"${PROJECT_NAME}"

printf 'Neon Swarm backup created: %s\n' "${ARCHIVE_PATH}"
