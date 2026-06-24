# Neon Swarm Cursor Notes

- Source: `art/ui/cursor/neon_swarm_cursor.svg`
- Export: `art/ui/cursor/neon_swarm_cursor.png`
- Canvas: 48 x 48 px, transparent background
- Hotspot: centered at `(24, 24)`
- Design: original Neon Swarm aim reticle with a dark contrast shell, cyan/white reticle strokes, a small magenta center accent, and yellow orientation chips.
- Visibility intent: readable on dark gunmetal floors, cyan Sector 1 neon, violet/magenta Sector 2 neon, yellow accents, bright white flashes, projectiles, and Nova Burst VFX.
- Integration: Godot native custom cursor API via `Input.set_custom_mouse_cursor`, applied to arrow, pointing hand, cross, drag, can-drop, and forbidden cursor shapes. Runtime loads the raw PNG with `Image.load()` and creates an `ImageTexture`, so the cursor does not depend on editor-generated import metadata.
- Aim alignment: the custom cursor is native and does not alter mouse coordinates; the centered hotspot matches the existing mouse aim ray used by `_set_player_core_mouse_aim_facing_from_viewport_position()`.
