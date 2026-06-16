extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

const TRAIL_LENGTH := 5
const IDLE_SPARK_COUNT := 5
const VISUAL_QUALITY_SWARM := 0
const VISUAL_QUALITY_MEDIUM := 1
const VISUAL_QUALITY_FULL := 2

var value := 1
var target: CharacterBody2D
var main_ref: Node
var color := Color(0.75, 1.0, 0.12)
var _spin := 0.0
var _pulse := 0.0
var _trail_points: Array[Vector2] = []
var _spark_seed := 0.0
var _diamond_points := PackedVector2Array()
var _diamond_closed := PackedVector2Array()
var _idle_redraw_timer := 0.0


func _ready() -> void:
	add_to_group("xp_orbs")
	z_index = 0
	set_physics_process(false)
	_spark_seed = randf_range(0.0, TAU)


func _process(delta: float) -> void:
	if is_instance_valid(target):
		return

	_spin += delta * 1.8
	_pulse += delta * 2.6
	_idle_redraw_timer -= delta
	var quality := _visual_quality()
	if _idle_redraw_timer <= 0.0 and quality > VISUAL_QUALITY_SWARM:
		_idle_redraw_timer = 0.15 if quality == VISUAL_QUALITY_FULL else 0.24
		queue_redraw()


func configure(p_value: int) -> void:
	value = p_value
	var radius := clampf(5.0 + float(value) * 0.45, 6.0, 12.0)
	_update_collision_radius()
	_update_color()
	_cache_draw_points()
	queue_redraw()


func attract_to(player: CharacterBody2D) -> void:
	target = player
	set_physics_process(true)


func set_main_ref(main_node: Node) -> void:
	main_ref = main_node


func add_value(extra_value: int) -> void:
	value += extra_value
	_update_collision_radius()
	_update_color()
	_cache_draw_points()
	queue_redraw()


func _physics_process(delta: float) -> void:
	_spin += delta * 4.0
	_pulse += delta * 6.0
	rotation = _spin

	if is_instance_valid(target):
		var to_target := target.global_position - global_position
		var distance := to_target.length()
		if distance < 18.0:
			if target.main_ref and target.main_ref.has_node("ParticleFX"):
				target.main_ref.particle_fx.pickup_pop(global_position)
			target.collect_xp(value)
			queue_free()
			return

		var pull_speed := clampf(260.0 + (target.pickup_radius - distance) * 5.0, 260.0, 780.0)
		global_position += to_target.normalized() * pull_speed * delta
		_record_trail_point()

	queue_redraw()


func _draw() -> void:
	var quality := _visual_quality()
	if quality == VISUAL_QUALITY_FULL:
		_draw_trail()

	var radius := _visual_radius()
	var pulse := sin(_pulse + _spark_seed) * 0.5 + 0.5
	var flicker := sin(_pulse * 2.7 + _spark_seed) * 0.5 + 0.5
	var warm_core := Color(1.0, 0.98, 0.58)
	var cool_core := Color(0.25, 1.0, 1.0)

	if quality > VISUAL_QUALITY_SWARM:
		_draw_plasma_haze(radius + 20.0 + pulse * 4.0, color, 0.26 + flicker * 0.10, quality)
		_draw_neon_arc(Vector2.ZERO, radius + 18.0 + pulse * 4.0, 0.0, TAU, 36 if quality == VISUAL_QUALITY_FULL else 22, color, warm_core, 11.0, 1.7, quality)
		_draw_neon_arc(Vector2.ZERO, radius + 10.0 + pulse * 2.2, _spin * 0.95, _spin * 0.95 + TAU * 0.70, 26 if quality == VISUAL_QUALITY_FULL else 16, Color(1.0, 0.96, 0.10), Color.WHITE, 7.8, 1.6, quality)
		_draw_neon_arc(Vector2.ZERO, radius + 15.0, -_spin * 0.72, -_spin * 0.72 + TAU * 0.36, 18 if quality == VISUAL_QUALITY_FULL else 10, cool_core, Color.WHITE, 6.0, 1.2, quality)
		_draw_vapor_breakup(radius + 19.0 + pulse * 2.0, cool_core, quality)
		if quality == VISUAL_QUALITY_FULL:
			_draw_ring_sparks(radius + 15.0 + pulse * 2.5, IDLE_SPARK_COUNT + int(value > 6), pulse)
	else:
		draw_arc(Vector2.ZERO, radius + 10.0, 0.0, TAU, 14, Color(color.r, color.g, color.b, 0.86), 2.1)

	_draw_neon_outline(_diamond_closed, color, Color.WHITE, quality, 0.72)
	_draw_neon_line(Vector2(-radius * 1.56, 0.0), Vector2(radius * 1.56, 0.0), Color(1.0, 0.96, 0.16), Color.WHITE, quality, 0.74)
	_draw_neon_line(Vector2(0.0, -radius * 1.56), Vector2(0.0, radius * 1.56), cool_core, Color.WHITE, quality, 0.70)
	if quality > VISUAL_QUALITY_SWARM:
		_draw_neon_line(Vector2(-radius * 0.82, -radius * 0.82), Vector2(radius * 0.82, radius * 0.82), color, Color.WHITE, quality, 0.42)
		_draw_neon_line(Vector2(-radius * 0.82, radius * 0.82), Vector2(radius * 0.82, -radius * 0.82), cool_core, Color.WHITE, quality, 0.40)

	var spark_angle := _spin * 1.65 + _spark_seed
	var spark_pos := Vector2.from_angle(spark_angle) * (radius + 13.0 + pulse * 2.0)
	var spark_tangent := Vector2.from_angle(spark_angle + PI * 0.5)
	_draw_neon_line(spark_pos - spark_tangent * 4.5, spark_pos + spark_tangent * 5.5, cool_core, Color.WHITE, quality, 0.54)
	if quality > VISUAL_QUALITY_SWARM:
		_draw_neon_line(spark_pos - spark_tangent.rotated(PI * 0.5) * 3.8, spark_pos + spark_tangent.rotated(PI * 0.5) * 3.8, Color(1.0, 0.96, 0.16), Color.WHITE, quality, 0.42)
	_draw_hot_point(Vector2.ZERO, 4.0 + pulse * 1.0 + flicker * 0.7, Color(1.0, 0.96, 0.16), quality, 1.1 + flicker * 0.35)
	draw_arc(Vector2.ZERO, radius * 0.46 + pulse * 0.8, 0.0, TAU, 14 if quality > VISUAL_QUALITY_SWARM else 8, Color(color.r, color.g, color.b, 0.68), 1.2)


func _update_collision_radius() -> void:
	var radius := clampf(5.0 + float(value) * 0.32, 6.0, 14.0)
	var circle := CircleShape2D.new()
	circle.radius = radius
	var shape_node: CollisionShape2D = collision_shape
	if shape_node == null:
		shape_node = get_node_or_null("CollisionShape2D") as CollisionShape2D
	if shape_node:
		shape_node.shape = circle


func _update_color() -> void:
	color = Color(0.58, 1.0, 0.08).lerp(Color(1.0, 0.92, 0.06), clampf(float(value) / 12.0, 0.0, 1.0))


func _visual_radius() -> float:
	return clampf(6.0 + float(value) * 0.34, 6.0, 15.0)


func _cache_draw_points() -> void:
	var radius := _visual_radius()
	_diamond_points = PackedVector2Array([
		Vector2(0.0, -radius),
		Vector2(radius, 0.0),
		Vector2(0.0, radius),
		Vector2(-radius, 0.0)
	])
	_diamond_closed = PackedVector2Array([
		_diamond_points[0],
		_diamond_points[1],
		_diamond_points[2],
		_diamond_points[3],
		_diamond_points[0]
	])


func _record_trail_point() -> void:
	if _trail_points.is_empty() or _trail_points[-1].distance_to(global_position) > 10.0:
		_trail_points.append(global_position)

	while _trail_points.size() > TRAIL_LENGTH:
		_trail_points.pop_front()


func _draw_trail() -> void:
	if _trail_points.size() < 2:
		return

	for i in range(_trail_points.size() - 1):
		var age := float(i) / float(maxi(_trail_points.size() - 1, 1))
		var from_point := to_local(_trail_points[i])
		var to_point := to_local(_trail_points[i + 1])
		var alpha := 0.06 + age * 0.18
		var width := 4.0 + age * 4.0
		draw_line(from_point, to_point, Color(color.r, color.g, color.b, alpha * 0.24), width + 4.0)
		draw_line(from_point, to_point, Color(color.r, color.g, color.b, alpha * 0.68), width)
		draw_line(from_point, to_point, Color(1.0, 1.0, 0.72, alpha), 1.0 + age * 1.8)
		draw_line(from_point, to_point, Color(0.25, 1.0, 1.0, alpha * 0.42), maxf(0.8, width * 0.30))


func _draw_plasma_haze(haze_radius: float, haze_color: Color, alpha: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	if quality <= VISUAL_QUALITY_SWARM:
		draw_circle(Vector2.ZERO, haze_radius * 0.54, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.07))
		return

	draw_circle(Vector2.ZERO, haze_radius, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.09))
	draw_circle(Vector2.ZERO, haze_radius * 0.54, Color(1.0, 0.96, 0.18, alpha * 0.12))
	draw_arc(Vector2.ZERO, haze_radius * 0.82, _spin * 0.45, _spin * 0.45 + TAU * 0.52, 22 if quality == VISUAL_QUALITY_FULL else 14, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.70), 2.0)
	draw_arc(Vector2.ZERO, haze_radius * 0.60, -_spin * 0.64, -_spin * 0.64 + TAU * 0.32, 16 if quality == VISUAL_QUALITY_FULL else 10, Color(1.0, 1.0, 1.0, alpha * 0.46), 1.0)


func _draw_vapor_breakup(vapor_radius: float, vapor_color: Color, quality: int) -> void:
	var count := 4 if quality == VISUAL_QUALITY_FULL else 2
	for i in range(count):
		var flicker := sin(_pulse * 2.3 + _spark_seed + float(i) * 2.9) * 0.5 + 0.5
		var angle := TAU * float(i) / float(count) + _spin * (0.24 + 0.08 * flicker)
		var span := 0.16 + flicker * 0.12
		draw_arc(Vector2.ZERO, vapor_radius + flicker * 2.8, angle, angle + span, 4, Color(vapor_color.r, vapor_color.g, vapor_color.b, 0.26), 2.4)


func _draw_ring_sparks(spark_radius: float, count: int, pulse: float) -> void:
	for i in range(count):
		var t := float(i) / float(maxi(count, 1))
		var flicker := sin(_pulse * (2.0 + t) + _spark_seed + float(i) * 4.4) * 0.5 + 0.5
		var angle := t * TAU + _spin * (0.65 + t * 0.22) + flicker * 0.18
		var pos := Vector2.from_angle(angle) * (spark_radius + (flicker - 0.5) * 4.0)
		var tangent := Vector2.from_angle(angle + PI * 0.5)
		var spark_color := color.lerp(Color(0.25, 1.0, 1.0), fmod(float(i), 2.0))
		var length := 3.4 + pulse * 3.0 + flicker * 2.2
		draw_line(pos - tangent * length * 0.40, pos + tangent * length, Color(spark_color.r, spark_color.g, spark_color.b, 0.36 + flicker * 0.24), 3.0)
		draw_line(pos - tangent * length * 0.20, pos + tangent * length * 0.55, Color(1.0, 1.0, 1.0, 0.62 + flicker * 0.24), 0.9)


func _draw_hot_point(position: Vector2, point_radius: float, glow_color: Color, quality: int, intensity: float) -> void:
	if quality > VISUAL_QUALITY_SWARM:
		draw_circle(position, point_radius * 4.2, Color(glow_color.r, glow_color.g, glow_color.b, 0.11 * intensity))
		draw_circle(position, point_radius * 2.1, Color(glow_color.r, glow_color.g, glow_color.b, 0.36 * intensity))
	else:
		draw_circle(position, point_radius * 1.8, Color(glow_color.r, glow_color.g, glow_color.b, 0.34 * intensity))
	draw_circle(position, point_radius, Color(1.0, 1.0, 1.0, minf(1.0, 0.92 * intensity)))


func _draw_neon_outline(points: PackedVector2Array, tube_color: Color, core_color: Color, quality: int, width_scale: float) -> void:
	if points.size() < 2:
		return

	var hot_core := core_color.lerp(Color.WHITE, 0.70)
	if quality > VISUAL_QUALITY_SWARM:
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.08), 11.0 * width_scale)
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), 6.8 * width_scale)
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.64), 3.3 * width_scale)
	else:
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.74), 2.0 * width_scale)
	draw_polyline(points, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), maxf(0.85, 1.18 * width_scale))


func _draw_neon_line(from_point: Vector2, to_point: Vector2, tube_color: Color, core_color: Color, quality: int, width_scale: float) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.70)
	if quality > VISUAL_QUALITY_SWARM:
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.08), 9.4 * width_scale)
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), 5.6 * width_scale)
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.64), 2.8 * width_scale)
	else:
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.72), 1.8 * width_scale)
	draw_line(from_point, to_point, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), maxf(0.82, 1.08 * width_scale))


func _draw_neon_arc(center: Vector2, arc_radius: float, start_angle: float, end_angle: float, point_count: int, tube_color: Color, core_color: Color, glow_width: float, core_width: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.72)
	if quality <= VISUAL_QUALITY_SWARM:
		draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.70), maxf(1.6, glow_width * 0.30))
		draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(hot_core.r, hot_core.g, hot_core.b, 0.94), maxf(0.8, core_width * 0.78))
		return

	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.08), glow_width * 1.65)
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), glow_width)
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.64), maxf(core_width + 1.4, glow_width * 0.40))
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), core_width)


func _visual_quality() -> int:
	if main_ref and main_ref.has_method("get_visual_quality"):
		return main_ref.get_visual_quality()
	if target and target.main_ref and target.main_ref.has_method("get_visual_quality"):
		return target.main_ref.get_visual_quality()
	return VISUAL_QUALITY_FULL
