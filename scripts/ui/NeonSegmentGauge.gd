extends Control
class_name NeonSegmentGauge

var max_value := 100.0:
	set(value):
		max_value = maxf(0.001, value)
		queue_redraw()
var value := 100.0:
	set(new_value):
		value = clampf(new_value, 0.0, max_value)
		queue_redraw()
var fill_color := Color(1.0, 0.08, 0.20, 0.95)
var accent_color := Color(0.0, 0.92, 1.0, 0.82)
var track_color := Color(0.0, 0.006, 0.025, 0.82)
var cut_size := 5.0
var segment_count := 12:
	set(new_count):
		segment_count = maxi(1, new_count)
		queue_redraw()
var segment_gap := 3.0


func configure(fill: Color, accent: Color, maximum: float, minimum_size: Vector2) -> void:
	fill_color = fill
	accent_color = accent
	max_value = maximum
	value = maximum
	custom_minimum_size = minimum_size
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _draw() -> void:
	if size.x < 18.0 or size.y < 6.0:
		return
	var c := minf(cut_size, size.y * 0.45)
	var outer := _angled_rect_points(Rect2(Vector2.ZERO, size), c)
	var closed_outer := outer.duplicate()
	closed_outer.append(outer[0])
	draw_colored_polygon(outer, track_color)
	draw_polyline(closed_outer, Color(accent_color.r, accent_color.g, accent_color.b, 0.42), 1.0, true)

	var ratio := clampf(value / max_value, 0.0, 1.0)
	var available_width := maxf(1.0, size.x - 4.0)
	var gap := minf(segment_gap, available_width / float(segment_count) * 0.28)
	var segment_width := (available_width - gap * float(segment_count - 1)) / float(segment_count)
	for i in range(segment_count):
		var start_x := 2.0 + float(i) * (segment_width + gap)
		var rect := Rect2(Vector2(start_x, 2.0), Vector2(maxf(1.0, segment_width), maxf(1.0, size.y - 4.0)))
		var segment_ratio := (float(i) + 1.0) / float(segment_count)
		var segment_active := ratio >= segment_ratio
		var partial := clampf((ratio * float(segment_count)) - float(i), 0.0, 1.0)
		var segment_poly := _angled_rect_points(rect, maxf(1.0, c - 1.0))
		if segment_active or partial > 0.0:
			var active_alpha := 0.24 + partial * 0.70
			draw_colored_polygon(segment_poly, Color(fill_color.r, fill_color.g, fill_color.b, active_alpha))
			if partial > 0.92:
				var closed_fill := segment_poly.duplicate()
				closed_fill.append(segment_poly[0])
				draw_polyline(closed_fill, Color(1.0, 1.0, 0.92, 0.66), 1.0, true)
		else:
			draw_colored_polygon(segment_poly, Color(accent_color.r, accent_color.g, accent_color.b, 0.070))
		var closed_segment := segment_poly.duplicate()
		closed_segment.append(segment_poly[0])
		draw_polyline(closed_segment, Color(accent_color.r, accent_color.g, accent_color.b, 0.18), 0.8, true)


func _angled_rect_points(rect: Rect2, cut: float) -> PackedVector2Array:
	var x := rect.position.x
	var y := rect.position.y
	var w := rect.size.x
	var h := rect.size.y
	var c := minf(cut, minf(w * 0.28, h * 0.5))
	return PackedVector2Array([
		Vector2(x + c, y),
		Vector2(x + w, y),
		Vector2(x + w, y + h - c),
		Vector2(x + w - c, y + h),
		Vector2(x, y + h),
		Vector2(x, y + c)
	])
