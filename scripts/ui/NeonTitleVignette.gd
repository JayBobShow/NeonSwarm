extends Control
class_name NeonTitleVignette

const COVER_ASPECT := 1055.0 / 1491.0

var pulse_phase := 0.0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _process(delta: float) -> void:
	pulse_phase += delta
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _draw() -> void:
	if size.x <= 0.0 or size.y <= 0.0:
		return
	var pulse := sin(pulse_phase * 2.2) * 0.5 + 0.5
	var cover_width := minf(size.x, size.y * COVER_ASPECT)
	var cover_x := (size.x - cover_width) * 0.5
	var cover_right := cover_x + cover_width

	for i in range(18):
		var t := float(i + 1) / 18.0
		var band := 18.0 + t * 20.0
		var alpha := t * t * 0.018
		draw_rect(Rect2(0, 0, size.x, band), Color(0.0, 0.0, 0.018, alpha))
		draw_rect(Rect2(0, size.y - band, size.x, band), Color(0.0, 0.0, 0.018, alpha))
		draw_rect(Rect2(0, 0, band * 1.7, size.y), Color(0.0, 0.0, 0.018, alpha * 1.4))
		draw_rect(Rect2(size.x - band * 1.7, 0, band * 1.7, size.y), Color(0.0, 0.0, 0.018, alpha * 1.4))

	var rail_alpha := 0.22 + pulse * 0.07
	draw_line(Vector2(cover_x - 10.0, 26.0), Vector2(cover_x - 10.0, size.y - 26.0), Color(0.0, 0.95, 1.0, rail_alpha), 1.5, true)
	draw_line(Vector2(cover_right + 10.0, 26.0), Vector2(cover_right + 10.0, size.y - 26.0), Color(1.0, 0.05, 0.86, rail_alpha), 1.5, true)
	draw_line(Vector2(cover_right + 22.0, size.y * 0.63), Vector2(size.x - 170.0, size.y * 0.63), Color(0.0, 0.95, 1.0, 0.18 + pulse * 0.06), 1.0, true)
	draw_line(Vector2(cover_right + 22.0, size.y * 0.665), Vector2(size.x - 224.0, size.y * 0.665), Color(1.0, 0.05, 0.86, 0.16 + pulse * 0.06), 1.0, true)
