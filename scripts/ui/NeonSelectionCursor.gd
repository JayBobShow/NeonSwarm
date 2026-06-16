extends Control
class_name NeonSelectionCursor

var accent := Color(0.0, 0.96, 1.0, 0.98)
var secondary := Color(1.0, 0.05, 0.86, 0.88)
var pulse_phase := 0.0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	custom_minimum_size = Vector2(58, 38)


func _process(delta: float) -> void:
	pulse_phase += delta
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _draw() -> void:
	if size.x < 24.0 or size.y < 20.0:
		return
	var pulse := sin(pulse_phase * 7.0) * 0.5 + 0.5
	var center := size * 0.5
	var nose := Vector2(size.x - 7.0, center.y)
	var upper := Vector2(10.0, 6.0)
	var lower := Vector2(10.0, size.y - 6.0)
	var mid := Vector2(24.0, center.y)
	var hull := PackedVector2Array([upper, nose, lower, mid, upper])

	draw_polyline(hull, Color(accent.r, accent.g, accent.b, 0.18 + pulse * 0.12), 8.0, true)
	draw_polyline(hull, Color(secondary.r, secondary.g, secondary.b, 0.20 + pulse * 0.12), 5.0, true)
	draw_polyline(hull, Color(accent.r, accent.g, accent.b, 0.92 + pulse * 0.08), 2.0, true)

	var core := center + Vector2(1.0, 0.0)
	var r := 7.0 + pulse * 1.4
	var diamond := PackedVector2Array([
		core + Vector2(0.0, -r),
		core + Vector2(r, 0.0),
		core + Vector2(0.0, r),
		core + Vector2(-r, 0.0),
		core + Vector2(0.0, -r),
	])
	draw_polyline(diamond, Color(1.0, 1.0, 0.78, 0.30 + pulse * 0.16), 5.0, true)
	draw_polyline(diamond, Color(1.0, 1.0, 0.82, 0.98), 1.4, true)

	draw_line(Vector2(3.0, center.y - 8.0), Vector2(16.0, center.y - 3.0), Color(secondary.r, secondary.g, secondary.b, 0.84), 2.0, true)
	draw_line(Vector2(3.0, center.y + 8.0), Vector2(16.0, center.y + 3.0), Color(secondary.r, secondary.g, secondary.b, 0.84), 2.0, true)
	draw_line(Vector2(0.0, center.y), Vector2(12.0, center.y), Color(0.0, 0.96, 1.0, 0.28 + pulse * 0.20), 3.0, true)
