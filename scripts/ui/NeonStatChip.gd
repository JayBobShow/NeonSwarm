extends Control
class_name NeonStatChip

const CHIP_ICON_ATLAS := preload("res://art/ui/phase10_chip_icons.png")

var label_text := "DMG"
var value_text := "100%"
var icon_kind := "diamond"
var accent := Color(0.0, 0.95, 1.0, 0.90)
var secondary := Color(1.0, 0.06, 0.86, 0.75)
var glass := Color(0.0, 0.006, 0.024, 0.66)

func configure(title: String, value: String, icon := "diamond", primary := Color(0.0, 0.95, 1.0, 0.90), second := Color(1.0, 0.06, 0.86, 0.75)) -> void:
	label_text = title
	value_text = value
	icon_kind = icon
	accent = primary
	secondary = second
	custom_minimum_size = Vector2(118, 42)
	queue_redraw()


func set_value(value: String) -> void:
	value_text = value
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _draw() -> void:
	var w := size.x
	var h := size.y
	if w < 24.0 or h < 20.0:
		return
	var c := minf(10.0, h * 0.35)
	var points := PackedVector2Array([
		Vector2(c, 0.0),
		Vector2(w, 0.0),
		Vector2(w, h - c),
		Vector2(w - c, h),
		Vector2(0.0, h),
		Vector2(0.0, c),
	])
	var closed := points.duplicate()
	closed.append(points[0])
	draw_colored_polygon(points, glass)
	draw_polyline(closed, Color(accent.r, accent.g, accent.b, 0.22), 6.0, true)
	draw_polyline(closed, accent, 1.5, true)
	draw_line(Vector2(8, h - 5), Vector2(w - 12, h - 5), Color(secondary.r, secondary.g, secondary.b, 0.45), 1.0, true)

	_draw_icon(Rect2(Vector2(8, 8), Vector2(22, h - 16)))
	var font := get_theme_font("font", "Label")
	var title_size := 9
	var value_size := 15
	draw_string(font, Vector2(36, 15), label_text, HORIZONTAL_ALIGNMENT_LEFT, w - 40, title_size, Color(0.48, 1.0, 1.0, 0.92))
	draw_string(font, Vector2(36, h - 8), value_text, HORIZONTAL_ALIGNMENT_LEFT, w - 40, value_size, Color(0.94, 1.0, 1.0, 1.0))


func _draw_icon(rect: Rect2) -> void:
	var icon_size := minf(rect.size.x, rect.size.y)
	var icon_rect := Rect2(
		rect.position + Vector2((rect.size.x - icon_size) * 0.5, (rect.size.y - icon_size) * 0.5),
		Vector2(icon_size, icon_size)
	)
	var atlas := _get_icon_atlas()
	if atlas:
		draw_texture_rect_region(
			atlas,
			icon_rect,
			_icon_region(),
			Color(accent.r, accent.g, accent.b, 0.96),
			false
		)
		return
	_draw_fallback_icon(icon_rect)


func _get_icon_atlas() -> Texture2D:
	return CHIP_ICON_ATLAS


func _icon_region() -> Rect2:
	match icon_kind:
		"bolt":
			return Rect2(64, 0, 64, 64)
		"speed":
			return Rect2(128, 0, 64, 64)
		"pickup":
			return Rect2(192, 0, 64, 64)
		"ring":
			return Rect2(256, 0, 64, 64)
		"triangle":
			return Rect2(320, 0, 64, 64)
		"mine":
			return Rect2(384, 0, 64, 64)
		_:
			return Rect2(0, 0, 64, 64)


func _draw_fallback_icon(rect: Rect2) -> void:
	var center := rect.get_center()
	var r := minf(rect.size.x, rect.size.y) * 0.48
	var color := Color(accent.r, accent.g, accent.b, 0.88)
	var hot := Color(1.0, 1.0, 0.86, 0.70)
	var points := PackedVector2Array([
		center + Vector2(0.0, -r),
		center + Vector2(r, 0.0),
		center + Vector2(0.0, r),
		center + Vector2(-r, 0.0),
		center + Vector2(0.0, -r),
	])
	draw_polyline(points, color, 2.0, true)
	draw_line(center + Vector2(-r * 0.45, 0), center + Vector2(r * 0.45, 0), hot, 1.0, true)
