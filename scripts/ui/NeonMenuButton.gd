extends Button
class_name NeonMenuButton

var accent := Color(0.0, 0.95, 1.0, 0.92)
var secondary := Color(1.0, 0.06, 0.86, 0.78)
var pulse_phase := 0.0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	focus_mode = Control.FOCUS_ALL
	custom_minimum_size = Vector2(390, 56)
	add_theme_font_size_override("font_size", 22)
	add_theme_color_override("font_color", Color.TRANSPARENT)
	add_theme_color_override("font_focus_color", Color.TRANSPARENT)
	add_theme_color_override("font_hover_color", Color.TRANSPARENT)
	add_theme_color_override("font_pressed_color", Color.TRANSPARENT)
	add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.95))
	add_theme_constant_override("outline_size", 2)
	for state in ["normal", "hover", "pressed", "focus", "disabled"]:
		add_theme_stylebox_override(state, StyleBoxEmpty.new())
	focus_entered.connect(func() -> void: queue_redraw())
	focus_exited.connect(func() -> void: queue_redraw())
	mouse_entered.connect(func() -> void: queue_redraw())
	mouse_exited.connect(func() -> void: queue_redraw())


func _process(delta: float) -> void:
	if has_focus():
		pulse_phase += delta
		queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _draw() -> void:
	if size.x < 24.0 or size.y < 20.0:
		return
	var focused := has_focus()
	var hot := focused or is_hovered()
	var pulse := sin(pulse_phase * 5.8) * 0.5 + 0.5
	var primary := Color(1.0, 0.92, 0.08, 1.0) if focused else accent
	var secondary_color := secondary if not focused else Color(0.0, 0.95, 1.0, 0.90)
	var alpha := 1.0 if focused else (0.86 if hot else 0.54)
	var c := minf(14.0, size.y * 0.38)
	var points := PackedVector2Array([
		Vector2(c, 0.0),
		Vector2(size.x - c * 0.4, 0.0),
		Vector2(size.x, c * 0.4),
		Vector2(size.x, size.y - c),
		Vector2(size.x - c, size.y),
		Vector2(0.0, size.y),
		Vector2(0.0, c),
	])
	var closed := points.duplicate()
	closed.append(points[0])
	draw_colored_polygon(points, Color(0.0, 0.008, 0.030, 0.58 if hot else 0.34))
	var rarity_strip: Color = get_meta("rarity_strip_color", Color.TRANSPARENT)
	var rarity_code := str(get_meta("rarity_code", ""))
	if rarity_strip.a > 0.01:
		var strip_w := minf(12.0, size.x * 0.055)
		draw_rect(Rect2(Vector2(0.0, c * 0.82), Vector2(strip_w, size.y - c * 0.82)), Color(rarity_strip.r, rarity_strip.g, rarity_strip.b, 0.92), true)
		draw_rect(Rect2(Vector2(strip_w, c), Vector2(3.0, size.y - c * 1.15)), Color(rarity_strip.r, rarity_strip.g, rarity_strip.b, 0.34), true)
		if rarity_code != "":
			var badge_w := 28.0
			var badge_h := 20.0
			var badge_origin := Vector2(size.x - badge_w - 7.0, 7.0)
			var badge_points := PackedVector2Array([
				badge_origin + Vector2(6.0, 0.0),
				badge_origin + Vector2(badge_w, 0.0),
				badge_origin + Vector2(badge_w, badge_h - 6.0),
				badge_origin + Vector2(badge_w - 6.0, badge_h),
				badge_origin + Vector2(0.0, badge_h),
				badge_origin + Vector2(0.0, 6.0),
			])
			var badge_closed := badge_points.duplicate()
			badge_closed.append(badge_points[0])
			draw_colored_polygon(badge_points, Color(rarity_strip.r, rarity_strip.g, rarity_strip.b, 0.82))
			draw_polyline(badge_closed, Color(1.0, 1.0, 1.0, 0.58), 1.0, true)
			var badge_font := get_theme_font("font", "Button")
			draw_string(badge_font, Vector2(badge_origin.x, badge_origin.y + 14.5), rarity_code, HORIZONTAL_ALIGNMENT_CENTER, badge_w, 12, Color(0.0, 0.012, 0.035, 0.96))
	if focused:
		draw_polyline(closed, Color(primary.r, primary.g, primary.b, 0.20 + pulse * 0.08), 12.0, true)
		draw_polyline(closed, Color(secondary_color.r, secondary_color.g, secondary_color.b, 0.18 + pulse * 0.06), 7.0, true)
	else:
		draw_polyline(closed, Color(primary.r, primary.g, primary.b, 0.13), 7.0, true)
	draw_polyline(closed, Color(primary.r, primary.g, primary.b, alpha), 2.0 if focused else 1.4, true)
	draw_line(Vector2(c, size.y - 7), Vector2(size.x - c, size.y - 7), Color(secondary_color.r, secondary_color.g, secondary_color.b, 0.64 if focused else 0.32), 1.4, true)
	if focused:
		draw_line(Vector2(c + 10.0, 8.0), Vector2(size.x - c - 10.0, 8.0), Color(1.0, 1.0, 0.72, 0.34 + pulse * 0.12), 1.0, true)
		draw_line(Vector2(12.0, c), Vector2(12.0, size.y - c), Color(0.0, 0.95, 1.0, 0.52 + pulse * 0.14), 2.0, true)
	var font := get_theme_font("font", "Button")
	var font_size := get_theme_font_size("font_size", "Button")
	var text_color := Color(1.0, 0.98, 0.40) if focused else Color(0.70, 0.92, 0.96)
	var baseline := size.y * 0.5 + float(font_size) * 0.36
	var left_text_padding := float(get_meta("left_text_padding", 0.0))
	var text_alignment := HORIZONTAL_ALIGNMENT_LEFT if left_text_padding > 0.0 else HORIZONTAL_ALIGNMENT_CENTER
	var text_origin_x := left_text_padding
	var text_width := maxf(1.0, size.x - left_text_padding - 12.0)
	draw_string(font, Vector2(text_origin_x + 1.0, baseline + 1.0), text, text_alignment, text_width, font_size, Color(0.0, 0.0, 0.0, 0.82))
	if focused:
		draw_string(font, Vector2(text_origin_x, baseline), text, text_alignment, text_width, font_size, Color(0.0, 0.95, 1.0, 0.20))
	draw_string(font, Vector2(text_origin_x, baseline), text, text_alignment, text_width, font_size, text_color)
