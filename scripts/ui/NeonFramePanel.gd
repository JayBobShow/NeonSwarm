extends PanelContainer
class_name NeonFramePanel

enum FrameKind {
	LEFT_WEDGE,
	RIGHT_WEDGE,
	RAIL,
	ALERT_RAIL,
	COMMAND_PLATE,
	MENU_PANEL,
	CHIP
}

var frame_kind := FrameKind.LEFT_WEDGE
var accent_primary := Color(0.0, 0.95, 1.0, 0.96)
var accent_secondary := Color(1.0, 0.06, 0.86, 0.82)
var glass_color := Color(0.0, 0.006, 0.024, 0.72)
var cut_size := 22.0
var tube_width := 2.4
var pulse_phase := 0.0
var animated := false


func configure(
	kind: int,
	primary: Color,
	secondary: Color,
	minimum_size: Vector2,
	cut := 22.0,
	tube := 2.4,
	margin := Vector4(18.0, 12.0, 18.0, 12.0)
) -> void:
	frame_kind = kind
	accent_primary = primary
	accent_secondary = secondary
	custom_minimum_size = minimum_size
	cut_size = cut
	tube_width = tube
	_setup_content_margins(margin)
	queue_redraw()


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_setup_content_margins(Vector4(18.0, 12.0, 18.0, 12.0))


func _process(delta: float) -> void:
	if not animated:
		return
	pulse_phase += delta
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _setup_content_margins(margin: Vector4) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color.TRANSPARENT
	style.content_margin_left = margin.x
	style.content_margin_top = margin.y
	style.content_margin_right = margin.z
	style.content_margin_bottom = margin.w
	add_theme_stylebox_override("panel", style)


func _draw() -> void:
	if size.x < 20.0 or size.y < 16.0:
		return
	var points := _frame_points()
	var closed := points.duplicate()
	closed.append(points[0])
	var pulse := 0.0
	if animated:
		pulse = sin(pulse_phase * 5.4) * 0.5 + 0.5
	var primary_alpha := clampf(accent_primary.a + pulse * 0.16, 0.0, 1.0)
	var secondary_alpha := clampf(accent_secondary.a + pulse * 0.12, 0.0, 1.0)

	if frame_kind == FrameKind.MENU_PANEL:
		var shadow := PackedVector2Array()
		for point in points:
			shadow.append(point + Vector2(10.0, 13.0))
		draw_colored_polygon(shadow, Color(0.0, 0.0, 0.018, 0.44))

	draw_colored_polygon(points, glass_color)
	if frame_kind == FrameKind.MENU_PANEL:
		_draw_menu_glass_reflection(pulse)
	draw_polyline(closed, Color(accent_primary.r, accent_primary.g, accent_primary.b, 0.16 + pulse * 0.08), tube_width + 9.0, true)
	draw_polyline(closed, Color(accent_secondary.r, accent_secondary.g, accent_secondary.b, 0.14 + pulse * 0.06), tube_width + 5.0, true)
	draw_polyline(closed, Color(accent_primary.r, accent_primary.g, accent_primary.b, primary_alpha), tube_width, true)

	var inner := _inset_points(points, 7.0)
	if inner.size() > 2:
		inner.append(inner[0])
		draw_polyline(inner, Color(accent_secondary.r, accent_secondary.g, accent_secondary.b, secondary_alpha * 0.42), 1.2, true)

	_draw_accent_tubes(pulse)


func _frame_points() -> PackedVector2Array:
	var w := size.x
	var h := size.y
	var c := minf(cut_size, minf(w * 0.18, h * 0.48))
	match frame_kind:
		FrameKind.RIGHT_WEDGE:
			return PackedVector2Array([
				Vector2(c, 0.0),
				Vector2(w, 0.0),
				Vector2(w, h - c * 0.55),
				Vector2(w - c * 0.55, h),
				Vector2(c, h),
				Vector2(0.0, h - c),
				Vector2(0.0, c),
			])
		FrameKind.RAIL, FrameKind.ALERT_RAIL:
			return PackedVector2Array([
				Vector2(c * 0.72, 0.0),
				Vector2(w - c * 0.72, 0.0),
				Vector2(w, c * 0.72),
				Vector2(w, h - c * 0.72),
				Vector2(w - c * 0.72, h),
				Vector2(c * 0.72, h),
				Vector2(0.0, h - c * 0.72),
				Vector2(0.0, c * 0.72),
			])
		FrameKind.COMMAND_PLATE, FrameKind.MENU_PANEL:
			return PackedVector2Array([
				Vector2(c, 0.0),
				Vector2(w - c, 0.0),
				Vector2(w, c),
				Vector2(w, h - c),
				Vector2(w - c, h),
				Vector2(c, h),
				Vector2(0.0, h - c),
				Vector2(0.0, c),
			])
		FrameKind.CHIP:
			return PackedVector2Array([
				Vector2(c * 0.48, 0.0),
				Vector2(w, 0.0),
				Vector2(w, h - c * 0.48),
				Vector2(w - c * 0.48, h),
				Vector2(0.0, h),
				Vector2(0.0, c * 0.48),
			])
		_:
			return PackedVector2Array([
				Vector2(0.0, c * 0.55),
				Vector2(c * 0.55, 0.0),
				Vector2(w - c, 0.0),
				Vector2(w, c),
				Vector2(w, h - c),
				Vector2(w - c, h),
				Vector2(0.0, h),
			])


func _inset_points(points: PackedVector2Array, inset: float) -> PackedVector2Array:
	var center := Vector2.ZERO
	for point in points:
		center += point
	center /= float(points.size())
	var inset_points := PackedVector2Array()
	for point in points:
		inset_points.append(point.move_toward(center, inset))
	return inset_points


func _draw_accent_tubes(pulse: float) -> void:
	var w := size.x
	var h := size.y
	var c := minf(cut_size, minf(w * 0.18, h * 0.48))
	var hot := Color(1.0, 1.0, 0.88, 0.38 + pulse * 0.12)
	match frame_kind:
		FrameKind.COMMAND_PLATE:
			_draw_corner_bracket(Vector2(15, 15), Vector2(70, 15), Vector2(15, 70), accent_secondary)
			_draw_corner_bracket(Vector2(w - 15, 15), Vector2(w - 70, 15), Vector2(w - 15, 70), accent_primary)
			_draw_corner_bracket(Vector2(w - 15, h - 15), Vector2(w - 70, h - 15), Vector2(w - 15, h - 70), accent_secondary)
			_draw_corner_bracket(Vector2(15, h - 15), Vector2(70, h - 15), Vector2(15, h - 70), accent_primary)
		FrameKind.MENU_PANEL:
			_draw_corner_bracket(Vector2(17, 17), Vector2(70, 17), Vector2(17, 70), accent_primary)
			_draw_corner_bracket(Vector2(w - 17, 17), Vector2(w - 70, 17), Vector2(w - 17, 70), accent_secondary)
			_draw_corner_bracket(Vector2(w - 17, h - 17), Vector2(w - 70, h - 17), Vector2(w - 17, h - 70), accent_primary)
			_draw_corner_bracket(Vector2(17, h - 17), Vector2(70, h - 17), Vector2(17, h - 70), accent_secondary)
			draw_line(Vector2(c + 8, h - 13), Vector2(w - c - 8, h - 13), Color(accent_secondary.r, accent_secondary.g, accent_secondary.b, 0.42 + pulse * 0.12), 2.0, true)
			draw_line(Vector2(c + 18, 13), Vector2(w - c - 18, 13), hot, 1.0, true)
			draw_line(Vector2(w - 72, 40), Vector2(w - 36, 40), Color(1.0, 1.0, 0.76, 0.34), 1.0, true)
			draw_line(Vector2(36, h - 42), Vector2(84, h - 42), Color(0.0, 0.95, 1.0, 0.32), 1.0, true)
		FrameKind.RAIL, FrameKind.ALERT_RAIL:
			draw_line(Vector2(c, h - 8), Vector2(w - c, h - 8), Color(accent_secondary.r, accent_secondary.g, accent_secondary.b, 0.55 + pulse * 0.15), 2.0, true)
			draw_line(Vector2(c * 1.4, 8), Vector2(w - c * 1.4, 8), hot, 1.0, true)
		_:
			draw_line(Vector2(c, h - 7), Vector2(w - c * 0.9, h - 7), Color(accent_secondary.r, accent_secondary.g, accent_secondary.b, 0.46), 2.0, true)
			draw_line(Vector2(c * 1.2, 7), Vector2(w - c * 1.2, 7), hot, 1.0, true)


func _draw_corner_bracket(corner: Vector2, horizontal: Vector2, vertical: Vector2, color: Color) -> void:
	draw_line(corner, horizontal, Color(color.r, color.g, color.b, 0.30), 7.0, true)
	draw_line(corner, vertical, Color(color.r, color.g, color.b, 0.30), 7.0, true)
	draw_line(corner, horizontal, color, 2.0, true)
	draw_line(corner, vertical, color, 2.0, true)


func _draw_menu_glass_reflection(pulse: float) -> void:
	var w := size.x
	var h := size.y
	var sheen := PackedVector2Array([
		Vector2(48.0, 34.0),
		Vector2(w - 42.0, 34.0),
		Vector2(w - 92.0, 88.0),
		Vector2(22.0, 88.0),
	])
	draw_colored_polygon(sheen, Color(0.60, 1.0, 1.0, 0.035 + pulse * 0.012))
	draw_line(Vector2(42.0, h * 0.34), Vector2(w - 58.0, h * 0.34), Color(0.0, 0.95, 1.0, 0.08 + pulse * 0.03), 1.0, true)
	draw_line(Vector2(56.0, h * 0.37), Vector2(w - 98.0, h * 0.37), Color(1.0, 0.05, 0.86, 0.07 + pulse * 0.03), 1.0, true)
