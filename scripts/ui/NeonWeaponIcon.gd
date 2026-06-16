extends Control
class_name NeonWeaponIcon

var weapon_id := "unknown_weapon":
	set(value):
		weapon_id = str(value)
		queue_redraw()

var rarity := "Common":
	set(value):
		rarity = str(value)
		queue_redraw()

var accent := Color(0.0, 0.95, 1.0, 0.96):
	set(value):
		accent = value
		queue_redraw()

var secondary := Color(1.0, 0.06, 0.86, 0.88):
	set(value):
		secondary = value
		queue_redraw()

var show_frame := true:
	set(value):
		show_frame = bool(value)
		queue_redraw()

var animate_preview := true:
	set(value):
		animate_preview = bool(value)
		set_process(animate_preview)
		queue_redraw()

var _cached_icon_id := ""
var _cached_texture: Texture2D
var _anim_phase := 0.0


static func icon_ids() -> Array[String]:
	return [
		"pulse_blaster",
		"orbit_spark",
		"nova_burst",
		"arc_beam",
		"gravity_mine",
		"prism_lance",
		"ring_saw",
		"hex_shatter",
		"fractal_shard",
		"tri_burst_cannon",
		"hex_mortar",
		"vector_spear",
		"orbital_saw_array",
		"prism_chain",
		"gravity_well",
		"nova_needle",
		"fractal_bloom",
		"shield_breaker",
		"star_pulse"
	]


static func icon_resource_path(definition_id: String) -> String:
	if icon_ids().has(definition_id):
		return "res://art/weapons/icons/exported/%s_icon_hd.png" % definition_id
	return "res://art/weapons/icons/exported/unknown_weapon_icon_hd.png"


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clip_contents = true
	custom_minimum_size = Vector2(48, 48) if custom_minimum_size == Vector2.ZERO else custom_minimum_size
	set_process(animate_preview)


func _process(delta: float) -> void:
	if not animate_preview or not is_visible_in_tree():
		return
	_anim_phase = fposmod(_anim_phase + delta, 1000.0)
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()


func _draw() -> void:
	if size.x < 12.0 or size.y < 12.0:
		return
	var w := size.x
	var h := size.y
	var s := minf(w, h)
	var origin := Vector2((w - s) * 0.5, (h - s) * 0.5)
	var c := origin + Vector2(s * 0.5, s * 0.5)
	var a := _rarity_accent()
	if show_frame:
		_draw_frame(origin, s, a)
	var id := _normalized_weapon_id()
	var texture := _icon_texture(id)
	if texture != null:
		var inset := s * 0.06
		var icon_size := s - inset * 2.0
		var spin := _preview_spin_speed(id) * _anim_phase
		var pulse := 1.0 + sin(_anim_phase * 2.15 + float(id.length()) * 0.17) * 0.025
		var alpha := 0.92 + sin(_anim_phase * 2.80 + 0.45) * 0.045
		_draw_preview_motion_arcs(c, s, a)
		draw_set_transform(c, spin, Vector2.ONE * pulse)
		draw_texture_rect(texture, Rect2(Vector2(-icon_size * 0.5, -icon_size * 0.5), Vector2(icon_size, icon_size)), false, Color(1.0, 1.0, 1.0, alpha))
		draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	else:
		_draw_preview_motion_arcs(c, s, a)
		_draw_family_icon(id, origin, s, c, a)
	if show_frame:
		_draw_rarity_badge(origin, s, a)


func _normalized_weapon_id() -> String:
	var id := weapon_id.strip_edges().to_lower()
	if icon_ids().has(id):
		return id
	return "unknown_weapon"


func _icon_texture(id: String) -> Texture2D:
	if id == _cached_icon_id and _cached_texture != null:
		return _cached_texture
	var path := icon_resource_path(id)
	var image := Image.load_from_file(path)
	if image == null or image.is_empty():
		_cached_icon_id = id
		_cached_texture = null
		return null
	_cached_icon_id = id
	_cached_texture = ImageTexture.create_from_image(image)
	return _cached_texture


func _rarity_accent() -> Color:
	match rarity:
		"Uncommon":
			return Color(0.27, 1.0, 0.60, 0.98)
		"Rare":
			return Color(0.21, 0.65, 1.0, 0.98)
		"Epic":
			return Color(0.84, 0.34, 1.0, 0.98)
		"Legendary":
			return Color(1.0, 0.89, 0.36, 0.98)
		"Anomaly":
			return Color(1.0, 0.42, 0.16, 0.98)
		_:
			return accent


func _rarity_short_code() -> String:
	match rarity:
		"Uncommon":
			return "U"
		"Rare":
			return "R"
		"Epic":
			return "E"
		"Legendary":
			return "L"
		"Anomaly":
			return "A"
		_:
			return "C"


func _preview_spin_speed(id: String) -> float:
	match id:
		"ring_saw", "orbital_saw_array", "star_pulse":
			return 0.42
		"gravity_well", "gravity_mine", "nova_burst":
			return 0.30
		"prism_chain", "arc_beam":
			return 0.18
		"unknown_weapon":
			return 0.12
		_:
			return 0.24


func _draw_preview_motion_arcs(center: Vector2, s: float, a: Color) -> void:
	var phase := _anim_phase * 1.35
	var r := s * 0.405
	var arc_alpha := 0.16 + sin(_anim_phase * 2.4) * 0.035
	draw_arc(center, r, phase, phase + 1.15, 14, Color(a.r, a.g, a.b, arc_alpha), maxf(1.0, s * 0.018), true)
	draw_arc(center, r * 0.72, -phase * 0.75, -phase * 0.75 + 0.78, 12, Color(secondary.r, secondary.g, secondary.b, 0.12), maxf(1.0, s * 0.014), true)


func _draw_frame(origin: Vector2, s: float, a: Color) -> void:
	var cut := s * 0.16
	var points := PackedVector2Array([
		origin + Vector2(cut, 0.0),
		origin + Vector2(s - cut * 0.55, 0.0),
		origin + Vector2(s, cut * 0.65),
		origin + Vector2(s, s - cut),
		origin + Vector2(s - cut, s),
		origin + Vector2(cut * 0.55, s),
		origin + Vector2(0.0, s - cut * 0.65),
		origin + Vector2(0.0, cut)
	])
	var closed := points.duplicate()
	closed.append(points[0])
	draw_colored_polygon(points, Color(0.0, 0.008, 0.030, 0.76))
	draw_polyline(closed, Color(a.r, a.g, a.b, 0.32), maxf(3.0, s * 0.13), true)
	draw_polyline(closed, Color(secondary.r, secondary.g, secondary.b, 0.18), maxf(2.0, s * 0.075), true)
	draw_polyline(closed, Color(a.r, a.g, a.b, 1.0), maxf(1.8, s * 0.042), true)
	draw_rect(Rect2(origin + Vector2(s * 0.10, s * 0.86), Vector2(s * 0.80, maxf(3.0, s * 0.055))), Color(a.r, a.g, a.b, 0.72), true)


func _draw_rarity_badge(origin: Vector2, s: float, a: Color) -> void:
	var badge_w := maxf(18.0, s * 0.30)
	var badge_h := maxf(16.0, s * 0.24)
	var badge_origin := origin + Vector2(s - badge_w - s * 0.045, s * 0.045)
	var cut := badge_h * 0.34
	var points := PackedVector2Array([
		badge_origin + Vector2(cut, 0.0),
		badge_origin + Vector2(badge_w, 0.0),
		badge_origin + Vector2(badge_w, badge_h - cut),
		badge_origin + Vector2(badge_w - cut, badge_h),
		badge_origin + Vector2(0.0, badge_h),
		badge_origin + Vector2(0.0, cut),
	])
	var closed := points.duplicate()
	closed.append(points[0])
	draw_colored_polygon(points, Color(a.r, a.g, a.b, 0.82))
	draw_polyline(closed, Color(1.0, 1.0, 1.0, 0.78), maxf(1.0, s * 0.018), true)
	var font := get_theme_font("font", "Label")
	var font_size := int(clampi(roundi(s * 0.15), 10, 18))
	var code := _rarity_short_code()
	var text_y := badge_origin.y + badge_h * 0.5 + float(font_size) * 0.36
	draw_string(font, Vector2(badge_origin.x, text_y), code, HORIZONTAL_ALIGNMENT_CENTER, badge_w, font_size, Color(0.0, 0.012, 0.035, 0.96))


func _draw_family_icon(id: String, origin: Vector2, s: float, center: Vector2, a: Color) -> void:
	var m := s * 0.16
	var hot := Color(0.94, 1.0, 1.0, 0.95)
	var magenta := Color(1.0, 0.08, 0.86, 0.92)
	var orange := Color(1.0, 0.46, 0.12, 0.92)
	match id:
		"pulse_blaster":
			_bolt(origin, s, Vector2(0.20, 0.50), Vector2(0.80, 0.50), a, hot, 0.085)
			_bolt(origin, s, Vector2(0.28, 0.38), Vector2(0.58, 0.38), magenta, hot, 0.036)
		"orbit_spark":
			_ring(center, s * 0.26, a, s * 0.035)
			_circle(center + Vector2(s * 0.20, -s * 0.10), s * 0.075, hot)
			_circle(center - Vector2(s * 0.18, -s * 0.12), s * 0.052, magenta)
		"nova_burst":
			_ring(center, s * 0.16, hot, s * 0.026)
			_ring(center, s * 0.28, a, s * 0.033)
			_ring(center, s * 0.39, magenta, s * 0.024)
		"arc_beam":
			_polyline(origin, s, [Vector2(0.18, 0.34), Vector2(0.42, 0.58), Vector2(0.58, 0.35), Vector2(0.82, 0.64)], a, s * 0.07)
			_nodes(origin, s, [Vector2(0.18, 0.34), Vector2(0.58, 0.35), Vector2(0.82, 0.64)], hot)
		"gravity_mine":
			_circle(center, s * 0.10, hot)
			_ring(center, s * 0.24, magenta, s * 0.04)
			_ring(center, s * 0.36, a, s * 0.028)
		"prism_lance":
			_bolt(origin, s, Vector2(0.18, 0.52), Vector2(0.76, 0.52), magenta, hot, 0.060)
			_triangle(origin, s, Vector2(0.82, 0.52), s * 0.20, a, 0.0)
		"ring_saw":
			_ring(center, s * 0.28, a, s * 0.060)
			for i in range(8):
				var angle := TAU * float(i) / 8.0
				_triangle_abs(center + Vector2(cos(angle), sin(angle)) * s * 0.32, s * 0.09, magenta, angle)
		"hex_shatter":
			_polygon(center, 6, s * 0.24, a, PI / 6.0)
			_shard_fan(center, s, 5, magenta, -0.7, 0.7)
		"fractal_shard":
			_diamond(center, s * 0.30, a)
			_triangle(origin, s, Vector2(0.30, 0.72), s * 0.11, magenta, -0.7)
			_triangle(origin, s, Vector2(0.72, 0.28), s * 0.11, orange, 0.7)
		"tri_burst_cannon":
			for i in range(3):
				_triangle(origin, s, Vector2(0.30 + float(i) * 0.20, 0.58 - absf(float(i) - 1.0) * 0.18), s * 0.16, a if i == 1 else orange, PI * 0.5)
		"hex_mortar":
			_polygon(center + Vector2(-s * 0.10, -s * 0.08), 6, s * 0.18, orange, PI / 6.0)
			_shard_fan(center + Vector2(s * 0.12, s * 0.10), s, 6, a, -PI, PI)
		"vector_spear":
			_bolt(origin, s, Vector2(0.15, 0.50), Vector2(0.78, 0.50), a, hot, 0.048)
			_triangle(origin, s, Vector2(0.84, 0.50), s * 0.20, hot, PI * 0.5)
			_bolt(origin, s, Vector2(0.18, 0.38), Vector2(0.58, 0.38), magenta, hot, 0.018)
		"orbital_saw_array":
			_ring(center, s * 0.30, a, s * 0.030)
			for i in range(4):
				var angle := TAU * float(i) / 4.0 + PI * 0.25
				_triangle_abs(center + Vector2(cos(angle), sin(angle)) * s * 0.30, s * 0.12, orange, angle)
		"prism_chain":
			var pts := [Vector2(0.18, 0.62), Vector2(0.37, 0.38), Vector2(0.58, 0.58), Vector2(0.82, 0.34)]
			_polyline(origin, s, pts, a, s * 0.052)
			_nodes(origin, s, pts, magenta)
		"gravity_well":
			_ring(center, s * 0.16, hot, s * 0.020)
			_ring(center, s * 0.28, magenta, s * 0.034)
			_arc(center, s * 0.38, -0.25, 4.8, a, s * 0.034)
			_circle(center, s * 0.055, Color(0.0, 0.0, 0.02, 1.0))
		"nova_needle":
			for i in range(4):
				var y := 0.30 + float(i) * 0.13
				_bolt(origin, s, Vector2(0.22, y), Vector2(0.76, y - 0.08), a if i % 2 == 0 else hot, hot, 0.026)
		"fractal_bloom":
			_triangle(origin, s, Vector2(0.50, 0.38), s * 0.22, a, PI)
			_shard_fan(center + Vector2(0.0, s * 0.12), s, 7, magenta, -1.25, 1.25)
		"shield_breaker":
			_diamond(center, s * 0.34, orange)
			_bolt(origin, s, Vector2(0.28, 0.50), Vector2(0.74, 0.50), hot, hot, 0.036)
		"star_pulse":
			for i in range(8):
				var angle := TAU * float(i) / 8.0
				_line(center + Vector2(cos(angle), sin(angle)) * s * 0.11, center + Vector2(cos(angle), sin(angle)) * s * 0.38, a if i % 2 == 0 else magenta, s * 0.030)
			_ring(center, s * 0.15, hot, s * 0.025)
		_:
			_ring(center, s * 0.29, a, s * 0.035)
			_diamond(center, s * 0.22, secondary)
			_line(center + Vector2(-m, -m), center + Vector2(m, m), hot, s * 0.030)


func _bolt(origin: Vector2, s: float, from: Vector2, to: Vector2, color: Color, core: Color, width_factor: float) -> void:
	var a := origin + from * s
	var b := origin + to * s
	_line(a, b, Color(color.r, color.g, color.b, 0.24), s * width_factor * 2.1)
	_line(a, b, color, s * width_factor)
	_line(a, b, core, maxf(1.0, s * width_factor * 0.34))


func _line(a: Vector2, b: Vector2, color: Color, width: float) -> void:
	draw_line(a, b, color, width, true)


func _polyline(origin: Vector2, s: float, points: Array, color: Color, width: float) -> void:
	var pts := PackedVector2Array()
	for point in points:
		pts.append(origin + Vector2(point) * s)
	draw_polyline(pts, Color(color.r, color.g, color.b, 0.22), width * 2.4, true)
	draw_polyline(pts, color, width, true)
	draw_polyline(pts, Color(0.92, 1.0, 1.0, 0.82), maxf(1.0, width * 0.30), true)


func _nodes(origin: Vector2, s: float, points: Array, color: Color) -> void:
	for point in points:
		_circle(origin + Vector2(point) * s, s * 0.050, color)


func _ring(center: Vector2, radius: float, color: Color, width: float) -> void:
	_arc(center, radius, 0.0, TAU, color, width)


func _arc(center: Vector2, radius: float, from: float, to: float, color: Color, width: float) -> void:
	draw_arc(center, radius, from, to, 48, Color(color.r, color.g, color.b, 0.20), width * 2.2, true)
	draw_arc(center, radius, from, to, 48, color, width, true)


func _circle(center: Vector2, radius: float, color: Color) -> void:
	draw_circle(center, radius * 1.9, Color(color.r, color.g, color.b, 0.16))
	draw_circle(center, radius, color)


func _polygon(center: Vector2, sides: int, radius: float, color: Color, rotation := 0.0) -> void:
	var points := PackedVector2Array()
	for i in range(sides):
		var angle := rotation + TAU * float(i) / float(sides)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	draw_colored_polygon(points, Color(0.012, 0.010, 0.030, 0.88))
	var closed := points.duplicate()
	closed.append(points[0])
	draw_polyline(closed, Color(color.r, color.g, color.b, 0.22), radius * 0.28, true)
	draw_polyline(closed, color, maxf(1.2, radius * 0.13), true)


func _triangle(origin: Vector2, s: float, center_unit: Vector2, radius: float, color: Color, rotation := 0.0) -> void:
	_triangle_abs(origin + center_unit * s, radius, color, rotation)


func _triangle_abs(center: Vector2, radius: float, color: Color, rotation := 0.0) -> void:
	var points := PackedVector2Array()
	for i in range(3):
		var angle := rotation - PI * 0.5 + TAU * float(i) / 3.0
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	draw_colored_polygon(points, Color(0.012, 0.010, 0.030, 0.88))
	var closed := points.duplicate()
	closed.append(points[0])
	draw_polyline(closed, Color(color.r, color.g, color.b, 0.22), radius * 0.35, true)
	draw_polyline(closed, color, maxf(1.0, radius * 0.16), true)


func _diamond(center: Vector2, radius: float, color: Color) -> void:
	var points := PackedVector2Array([
		center + Vector2(0.0, -radius),
		center + Vector2(radius * 0.72, 0.0),
		center + Vector2(0.0, radius),
		center + Vector2(-radius * 0.72, 0.0)
	])
	draw_colored_polygon(points, Color(0.012, 0.010, 0.030, 0.90))
	var closed := points.duplicate()
	closed.append(points[0])
	draw_polyline(closed, Color(color.r, color.g, color.b, 0.22), radius * 0.26, true)
	draw_polyline(closed, color, maxf(1.2, radius * 0.12), true)


func _shard_fan(center: Vector2, s: float, count: int, color: Color, start_angle: float, end_angle: float) -> void:
	for i in range(count):
		var t := 0.0 if count <= 1 else float(i) / float(count - 1)
		var angle := lerpf(start_angle, end_angle, t)
		var pos := center + Vector2(cos(angle), sin(angle)) * s * (0.18 + 0.09 * float(i % 2))
		_triangle_abs(pos, s * 0.055, color, angle + PI * 0.5)
