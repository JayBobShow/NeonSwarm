extends PanelContainer
class_name NeonHudPanel

var accent_primary := Color(0.0, 0.95, 1.0, 0.92)
var accent_secondary := Color(1.0, 0.05, 0.86, 0.72)
var glass_color := Color(0.0, 0.004, 0.018, 0.58)
var cut_size := 14.0
var tube_width := 2.0


func configure(primary: Color, secondary: Color, minimum_size: Vector2, cut := 14.0, tube := 2.0) -> void:
	accent_primary = primary
	accent_secondary = secondary
	custom_minimum_size = minimum_size
	cut_size = cut
	tube_width = tube
	_setup_content_margins()
	queue_redraw()


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_setup_content_margins()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _setup_content_margins() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color.TRANSPARENT
	style.content_margin_left = 12
	style.content_margin_top = 8
	style.content_margin_right = 12
	style.content_margin_bottom = 8
	add_theme_stylebox_override("panel", style)


func _draw() -> void:
	if size.x < 18.0 or size.y < 18.0:
		return
	var c := minf(cut_size, minf(size.x * 0.18, size.y * 0.34))
	var points := PackedVector2Array([
		Vector2(c, 0.0),
		Vector2(size.x - c * 0.55, 0.0),
		Vector2(size.x, c * 0.55),
		Vector2(size.x, size.y - c),
		Vector2(size.x - c, size.y),
		Vector2(c * 0.55, size.y),
		Vector2(0.0, size.y - c * 0.55),
		Vector2(0.0, c)
	])
	var closed := points.duplicate()
	closed.append(points[0])

	draw_colored_polygon(points, glass_color)
	draw_polyline(closed, Color(accent_primary.r, accent_primary.g, accent_primary.b, 0.22), tube_width + 6.0, true)
	draw_polyline(closed, Color(accent_primary.r, accent_primary.g, accent_primary.b, accent_primary.a), tube_width, true)

	var inset := 5.0
	var inner := PackedVector2Array([
		Vector2(c + inset, inset),
		Vector2(size.x - c - inset, inset),
		Vector2(size.x - inset, c + inset),
		Vector2(size.x - inset, size.y - c - inset),
		Vector2(size.x - c - inset, size.y - inset),
		Vector2(c + inset, size.y - inset),
		Vector2(inset, size.y - c - inset),
		Vector2(inset, c + inset)
	])
	inner.append(inner[0])
	draw_polyline(inner, Color(accent_secondary.r, accent_secondary.g, accent_secondary.b, 0.34), 1.0, true)

	_draw_corner_tube(Vector2(c * 0.45, 0.0), Vector2(0.0, c * 0.95), accent_secondary, 3.0)
	_draw_corner_tube(Vector2(size.x - c * 1.18, size.y), Vector2(size.x, size.y - c * 1.18), accent_secondary, 3.0)
	_draw_corner_tube(Vector2(size.x - c * 2.1, 0.0), Vector2(size.x - c * 0.60, 0.0), accent_primary, 2.0)
	_draw_corner_tube(Vector2(c * 0.60, size.y), Vector2(c * 2.1, size.y), accent_primary, 2.0)


func _draw_corner_tube(start: Vector2, end: Vector2, color: Color, width: float) -> void:
	draw_line(start, end, Color(color.r, color.g, color.b, 0.24), width + 5.0, true)
	draw_line(start, end, color, width, true)
