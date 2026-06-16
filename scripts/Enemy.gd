extends Area2D

signal died(enemy: Area2D, death_position: Vector2, xp_value: int, color: Color)

const TRAIL_LENGTH := 6
const CONTACT_CHECK_RANGE_PADDING := 34.0
const REDRAW_INTERVAL_FULL := 0.033
const REDRAW_INTERVAL_MEDIUM := 0.058
const REDRAW_INTERVAL_SWARM := 0.12
const EDGE_SPARKS_FULL := 8
const EDGE_SPARKS_MEDIUM := 5
const EDGE_SPARKS_SWARM := 2
const VISUAL_QUALITY_SWARM := 0
const VISUAL_QUALITY_MEDIUM := 1
const VISUAL_QUALITY_FULL := 2

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var enemy_type := "chaser"
var player: CharacterBody2D
var main_ref: Node
var max_health := 30.0
var health := 30.0
var speed := 110.0
var contact_damage := 10.0
var xp_value := 3
var radius := 16.0
var color := Color(0.0, 1.0, 0.65)
var projectile_damage := 8.0
var projectile_speed := 300.0
var shoot_interval := 1.8
var blast_radius := 0.0
var blast_damage := 0.0

var _contact_timer := 0.0
var _shoot_timer := 0.8
var _flash_timer := 0.0
var _alive := true
var _visual_time := 0.0
var _visual_seed := 0.0
var _trail_points: Array[Vector2] = []
var _last_player_distance := INF
var _redraw_timer := 0.0
var _body_points := PackedVector2Array()
var _body_closed := PackedVector2Array()
var _outer_points := PackedVector2Array()
var _outer_closed := PackedVector2Array()
var _inner_points := PackedVector2Array()
var _inner_closed := PackedVector2Array()
var _last_motion := Vector2.ZERO


func _ready() -> void:
	add_to_group("enemies")
	z_index = 20


func configure(kind: String, target_player: CharacterBody2D, main_node: Node, survival_time: float) -> void:
	enemy_type = kind
	player = target_player
	main_ref = main_node
	_visual_seed = randf_range(0.0, TAU)

	var scale := 1.0 + survival_time / 180.0
	match enemy_type:
		"tank":
			radius = 25.0
			max_health = 92.0 * scale
			speed = 66.0
			contact_damage = 18.0
			xp_value = 7
			color = Color(1.0, 0.72, 0.12)
		"shooter":
			radius = 18.0
			max_health = 42.0 * scale
			speed = 92.0
			contact_damage = 8.0
			xp_value = 5
			color = Color(1.0, 0.13, 0.85)
			projectile_damage = 9.0 + survival_time / 80.0
			projectile_speed = 330.0
			shoot_interval = 1.65
			_shoot_timer = randf_range(0.35, 1.25)
		"exploder":
			radius = 15.0
			max_health = 28.0 * scale
			speed = 148.0
			contact_damage = 0.0
			xp_value = 4
			color = Color(1.0, 0.24, 0.12)
			blast_radius = 92.0
			blast_damage = 24.0 + survival_time / 95.0
		_:
			enemy_type = "chaser"
			radius = 16.0
			max_health = 30.0 * scale
			speed = 124.0
			contact_damage = 10.0
			xp_value = 3
			color = Color(0.0, 1.0, 0.62)

	health = max_health
	var circle := CircleShape2D.new()
	circle.radius = radius
	collision_shape.shape = circle
	_cache_draw_points()
	queue_redraw()


func _physics_process(delta: float) -> void:
	if not _alive or not is_instance_valid(player):
		return

	_visual_time += delta
	_contact_timer = maxf(0.0, _contact_timer - delta)
	_flash_timer = maxf(0.0, _flash_timer - delta)
	var quality := _visual_quality()

	var to_player := player.global_position - global_position
	var distance := to_player.length()
	_last_player_distance = distance
	var direction := to_player / distance if distance > 0.01 else Vector2.ZERO
	var movement := Vector2.ZERO

	match enemy_type:
		"shooter":
			movement = _shooter_movement(direction, distance, delta)
		"tank":
			movement = direction * speed
			rotation += delta * 0.32
		_:
			movement = direction * speed
			rotation = direction.angle()

	_last_motion = movement
	global_position += movement * delta
	if main_ref and main_ref.has_method("clamp_to_arena"):
		global_position = main_ref.clamp_to_arena(global_position, radius + 6.0)

	_apply_contact_damage()
	if quality == VISUAL_QUALITY_FULL:
		_record_trail_point()
	_redraw_timer -= delta
	if _redraw_timer <= 0.0:
		_redraw_timer = _redraw_interval_for_quality(quality)
		queue_redraw()


func _draw() -> void:
	var quality := _visual_quality()
	if quality == VISUAL_QUALITY_FULL:
		_draw_movement_trail()

	var flash := clampf(_flash_timer * 6.0, 0.0, 1.0)
	var pulse := sin(_visual_time * _pulse_speed() + _visual_seed) * 0.5 + 0.5
	var tube_color := color.lerp(Color.WHITE, flash * 0.55)
	var core_color := Color.WHITE if flash > 0.05 else color.lerp(Color.WHITE, 0.42)
	var spark_count := _spark_count_for_quality(quality)

	if quality > VISUAL_QUALITY_SWARM:
		_draw_motion_smear(tube_color, quality)
		_draw_plasma_haze(radius + 14.0 + pulse * _pulse_size(), color, 0.14 + flash * 0.22, quality)
		_draw_neon_arc(Vector2.ZERO, radius + 11.0 + pulse * _pulse_size(), 0.0, TAU, 30 if quality == VISUAL_QUALITY_FULL else 18, color, color.lerp(Color.WHITE, 0.70), 9.8, 1.35, quality)

	match enemy_type:
		"tank":
			_draw_dark_interior(_body_points, 0.12, quality)
			_draw_neon_outline(_outer_closed, tube_color, core_color, quality, 1.38)
			_draw_neon_outline(_body_closed, tube_color, core_color, quality, 1.16)
			_draw_neon_outline(_inner_closed, color, color.lerp(Color.WHITE, 0.82), quality, 0.84)
			_draw_neon_line(Vector2(-radius * 0.84, 0.0), Vector2(radius * 0.84, 0.0), color, core_color, quality, 1.14)
			_draw_neon_line(Vector2(0.0, -radius * 0.84), Vector2(0.0, radius * 0.84), color, core_color, quality, 1.14)
			_draw_hot_nodes(_outer_points, color, quality, 1.2 + flash)
			_draw_edge_sparks(_outer_closed, spark_count, color, quality, pulse)
			if quality == VISUAL_QUALITY_FULL:
				_draw_neon_arc(Vector2.ZERO, radius * 0.36 + pulse, 0.0, TAU, 20, color, Color.WHITE, 6.8, 1.35, quality)
				_draw_edge_sparks(_inner_closed, 4, color.lerp(Color.WHITE, 0.35), quality, 1.0 - pulse)
		"shooter":
			_draw_dark_interior(_body_points, 0.10, quality)
			_draw_neon_outline(_body_closed, tube_color, core_color, quality, 1.16)
			_draw_neon_outline(_inner_closed, color, color.lerp(Color.WHITE, 0.82), quality, 0.78)
			if quality == VISUAL_QUALITY_FULL:
				_draw_neon_arc(Vector2.ZERO, radius + 9.0, -0.95, 0.95, 18, color, Color.WHITE, 7.4, 1.25, quality)
				_draw_edge_sparks(_body_closed, spark_count, color, quality, pulse)
			_draw_neon_line(Vector2(-radius * 0.20, 0.0), Vector2(radius + 20.0, 0.0), color, Color.WHITE, quality, 1.52)
			_draw_neon_arc(Vector2(radius + 20.0, 0.0), 5.4 + pulse * 2.2, 0.0, TAU, 12 if quality > VISUAL_QUALITY_SWARM else 8, color, Color.WHITE, 5.8, 1.15, quality)
			_draw_hot_point(Vector2(radius + 20.0, 0.0), 2.8 + pulse * 1.0, color, quality, 1.05 + pulse * 0.35)
			_draw_hot_nodes(_body_points, color, quality, 0.9 + flash)
		"exploder":
			var warning_radius := radius + 8.0 + pulse * (8.0 if quality > VISUAL_QUALITY_SWARM else 4.0)
			var warning_segments := _arc_segments_for_quality(quality, 38, 22, 14)
			var warning_width := 12.0 if quality > VISUAL_QUALITY_SWARM else 5.2
			_draw_neon_arc(Vector2.ZERO, warning_radius, 0.0, TAU, warning_segments, Color(1.0, 0.08, 0.04), Color.WHITE, warning_width, 2.2, quality)
			_draw_neon_arc(Vector2.ZERO, radius * 0.58 + pulse * 2.1, 0.0, TAU, 24 if quality > VISUAL_QUALITY_SWARM else 10, color, Color.WHITE, 7.8, 1.45, quality)
			var spoke_count := _count_for_quality(quality, 10, 7, 5)
			for i in range(spoke_count):
				var angle := TAU * float(i) / float(spoke_count) + pulse * 0.12
				var inner := Vector2.from_angle(angle) * (radius * 0.78)
				var outer := Vector2.from_angle(angle) * (warning_radius + 4.0)
				_draw_neon_line(inner, outer, color, Color.WHITE, quality, 0.86)
			_draw_neon_outline(_body_closed, tube_color, core_color, quality, 0.84)
			_draw_edge_sparks(_body_closed, spark_count + 2, Color(1.0, 0.18, 0.08), quality, pulse)
			_draw_hot_point(Vector2.ZERO, 4.2 + pulse * 2.0, Color(1.0, 0.18, 0.08), quality, 1.2 + pulse)
		_:
			_draw_dark_interior(_body_points, 0.08, quality)
			_draw_neon_outline(_body_closed, tube_color, core_color, quality, 1.20)
			_draw_neon_line(Vector2(-radius * 0.92, -radius * 0.58), Vector2(radius * 0.64, 0.0), color, core_color, quality, 0.98)
			_draw_neon_line(Vector2(-radius * 0.92, radius * 0.58), Vector2(radius * 0.64, 0.0), color, core_color, quality, 0.98)
			_draw_neon_line(Vector2(-radius * 0.60, 0.0), Vector2(radius * 1.02, 0.0), color, Color.WHITE, quality, 1.25)
			_draw_hot_point(Vector2(radius + 6.0, 0.0), 2.8 + pulse * 0.7, color, quality, 1.1 + flash)
			if quality == VISUAL_QUALITY_FULL:
				_draw_edge_sparks(_body_closed, spark_count, color, quality, pulse)
				_draw_chaser_tail_sparks(color, pulse)

	if flash > 0.0:
		_draw_plasma_haze(radius + 20.0 + 20.0 * flash, Color.WHITE, 0.30 * flash, quality)
		_draw_neon_arc(Vector2.ZERO, radius + 10.0 + 22.0 * flash, 0.0, TAU, 26 if quality > VISUAL_QUALITY_SWARM else 14, Color.WHITE, Color.WHITE, 12.0 * flash, 2.2, quality)
		_draw_neon_outline(_body_closed, Color.WHITE, Color.WHITE, quality, 0.62 + flash * 0.62)


func take_damage(amount: float, source: Node = null) -> bool:
	if not _alive:
		return false

	health -= amount
	_flash_timer = 0.18
	if source != null and main_ref and main_ref.has_node("ParticleFX"):
		main_ref.particle_fx.enemy_hit(global_position, color)
	if health <= 0.0:
		if enemy_type == "exploder":
			_explode()
		else:
			_die()
		return true

	return false


func is_alive() -> bool:
	return _alive


func _shooter_movement(direction: Vector2, distance: float, delta: float) -> Vector2:
	rotation = direction.angle()

	_shoot_timer -= delta
	if _shoot_timer <= 0.0 and distance < 900.0 and main_ref and main_ref.has_method("spawn_enemy_projectile"):
		main_ref.spawn_enemy_projectile(global_position + direction * (radius + 8.0), direction, projectile_damage, projectile_speed, color)
		_shoot_timer = shoot_interval + randf_range(-0.2, 0.25)

	if distance > 380.0:
		return direction * speed
	if distance < 230.0:
		return -direction * speed * 0.78
	return Vector2.ZERO


func _apply_contact_damage() -> void:
	if _contact_timer > 0.0:
		return
	if _last_player_distance > radius + 28.0 + CONTACT_CHECK_RANGE_PADDING:
		return

	for body in get_overlapping_bodies():
		if body.is_in_group("player") and body.has_method("take_damage"):
			if enemy_type == "exploder":
				_explode()
				return
			body.take_damage(contact_damage)
			_contact_timer = 0.55
			return


func _die() -> void:
	_alive = false
	set_deferred("monitoring", false)
	died.emit(self, global_position, xp_value, color)
	queue_free()


func _explode() -> void:
	if not _alive:
		return

	_alive = false
	set_deferred("monitoring", false)
	if main_ref and main_ref.has_method("spawn_enemy_blast"):
		main_ref.call_deferred("spawn_enemy_blast", global_position, blast_radius, blast_damage, color)
	died.emit(self, global_position, xp_value, color)
	queue_free()


func _record_trail_point() -> void:
	if _trail_points.is_empty() or _trail_points[-1].distance_to(global_position) > 12.0:
		_trail_points.append(global_position)

	while _trail_points.size() > TRAIL_LENGTH:
		_trail_points.pop_front()


func _draw_movement_trail() -> void:
	if _trail_points.size() < 2:
		return

	for i in range(_trail_points.size() - 1):
		var age := float(i) / float(maxi(_trail_points.size() - 1, 1))
		var from_point := to_local(_trail_points[i])
		var to_point := to_local(_trail_points[i + 1])
		var alpha := 0.025 + age * 0.10
		var width := 3.0 + age * 4.6
		draw_line(from_point, to_point, Color(color.r, color.g, color.b, alpha * 0.28), width + 4.0)
		draw_line(from_point, to_point, Color(color.r, color.g, color.b, alpha * 0.80), width)
		draw_line(from_point, to_point, Color(1.0, 1.0, 1.0, alpha * 0.55), 0.8 + age * 1.0)


func _draw_motion_smear(smear_color: Color, quality: int) -> void:
	if _last_motion.length_squared() < 16.0:
		return

	var direction := _last_motion.normalized().rotated(-global_rotation)
	var back := -direction
	var side := direction.rotated(PI * 0.5)
	var speed_ratio := clampf(_last_motion.length() / maxf(speed, 1.0), 0.0, 1.35)
	var length := radius * (1.05 + speed_ratio * 0.62)
	var alpha := 0.10 + speed_ratio * 0.07
	draw_line(back * radius * 0.36 + side * radius * 0.18, back * length + side * radius * 0.32, Color(smear_color.r, smear_color.g, smear_color.b, alpha), 6.5 if quality == VISUAL_QUALITY_FULL else 4.0)
	draw_line(back * radius * 0.24 - side * radius * 0.16, back * length * 0.82 - side * radius * 0.28, Color(1.0, 1.0, 1.0, alpha * 0.50), 1.0)


func _draw_plasma_haze(haze_radius: float, haze_color: Color, alpha: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	if quality <= VISUAL_QUALITY_SWARM:
		draw_circle(Vector2.ZERO, haze_radius * 0.62, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.055))
		draw_arc(Vector2.ZERO, haze_radius * 0.74, _visual_time * 0.8 + _visual_seed, _visual_time * 0.8 + _visual_seed + TAU * 0.30, 12, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.38), 1.2)
		return

	draw_circle(Vector2.ZERO, haze_radius, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.07))
	draw_circle(Vector2.ZERO, haze_radius * 0.58, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.09))
	draw_arc(Vector2.ZERO, haze_radius * 0.84, _visual_time * 0.8 + _visual_seed, _visual_time * 0.8 + _visual_seed + TAU * 0.42, 20, Color(haze_color.r, haze_color.g, haze_color.b, alpha * 0.66), 1.9)
	draw_arc(Vector2.ZERO, haze_radius * 0.62, -_visual_time * 1.2 + _visual_seed, -_visual_time * 1.2 + _visual_seed + TAU * 0.34, 16, Color(1.0, 1.0, 1.0, alpha * 0.44), 1.0)


func _draw_edge_sparks(points: PackedVector2Array, count: int, spark_color: Color, quality: int, pulse: float) -> void:
	if points.size() < 2:
		return

	var width := 3.2 if quality == VISUAL_QUALITY_FULL else 2.0 if quality == VISUAL_QUALITY_MEDIUM else 1.2
	for i in range(count):
		var segment_count := points.size() - 1
		var segment := i % segment_count
		var t := fmod(_visual_time * (0.18 + float(i) * 0.017) + _visual_seed + float(i) * 0.37, 1.0)
		var from_point := points[segment]
		var to_point := points[segment + 1]
		var tangent := (to_point - from_point).normalized()
		var normal := tangent.rotated(PI * 0.5)
		var flicker := sin(_visual_time * (7.0 + float(i) * 0.5) + _visual_seed + float(i) * 5.7) * 0.5 + 0.5
		var pos := from_point.lerp(to_point, t) + normal * ((flicker - 0.5) * 4.0)
		var length := 2.4 + flicker * 4.6 + pulse * 1.4
		draw_line(pos - tangent * length * 0.45, pos + tangent * length, Color(spark_color.r, spark_color.g, spark_color.b, 0.20 + flicker * 0.28), width + (2.4 if quality > VISUAL_QUALITY_SWARM else 0.8))
		draw_line(pos - tangent * length * 0.28, pos + tangent * length * 0.64, Color(1.0, 1.0, 1.0, 0.58 + flicker * 0.24), maxf(0.8, width * 0.38))


func _draw_hot_nodes(points: PackedVector2Array, glow_color: Color, quality: int, intensity: float) -> void:
	if points.is_empty():
		return

	var max_nodes := points.size() if quality == VISUAL_QUALITY_FULL else mini(points.size(), 4)
	for i in range(max_nodes):
		var node_intensity := intensity * (0.82 + (sin(_visual_time * 5.0 + _visual_seed + float(i) * 2.3) * 0.5 + 0.5) * 0.34)
		_draw_hot_point(points[i], 2.2 if quality == VISUAL_QUALITY_FULL else 1.5, glow_color, quality, node_intensity)


func _draw_hot_point(position: Vector2, point_radius: float, glow_color: Color, quality: int, intensity: float) -> void:
	if quality > VISUAL_QUALITY_SWARM:
		draw_circle(position, point_radius * 4.0, Color(glow_color.r, glow_color.g, glow_color.b, 0.08 * intensity))
		draw_circle(position, point_radius * 2.1, Color(glow_color.r, glow_color.g, glow_color.b, 0.28 * intensity))
	else:
		draw_circle(position, point_radius * 1.8, Color(glow_color.r, glow_color.g, glow_color.b, 0.32 * intensity))
	draw_circle(position, point_radius, Color(1.0, 1.0, 1.0, minf(1.0, 0.82 * intensity)))


func _draw_chaser_tail_sparks(spark_color: Color, pulse: float) -> void:
	for i in range(5):
		var spread := -radius * (0.92 + float(i) * 0.16)
		var side := sin(_visual_time * 8.0 + _visual_seed + float(i) * 2.2) * radius * 0.34
		var pos := Vector2(spread, side)
		var length := 5.0 + pulse * 4.0 + float(i)
		draw_line(pos, pos - Vector2(length, side * 0.12), Color(spark_color.r, spark_color.g, spark_color.b, 0.30), 3.0)
		draw_line(pos, pos - Vector2(length * 0.65, side * 0.08), Color(1.0, 1.0, 1.0, 0.62), 0.9)


func _draw_dark_interior(points: PackedVector2Array, alpha: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	if points.size() >= 3:
		draw_colored_polygon(points, Color(0.0, 0.0, 0.0, alpha * (0.65 if quality <= VISUAL_QUALITY_SWARM else 1.0)))


func _draw_neon_outline(points: PackedVector2Array, tube_color: Color, core_color: Color, quality: int, width_scale: float) -> void:
	if points.size() < 2:
		return

	var hot_core := core_color.lerp(Color.WHITE, 0.64)
	if quality > VISUAL_QUALITY_SWARM:
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.08), 12.6 * width_scale)
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), 7.6 * width_scale)
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.66), 3.6 * width_scale)
	else:
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.74), 2.3 * width_scale)
	draw_polyline(points, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), maxf(0.95, 1.35 * width_scale))


func _draw_neon_line(from_point: Vector2, to_point: Vector2, tube_color: Color, core_color: Color, quality: int, width_scale: float) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.64)
	if quality > VISUAL_QUALITY_SWARM:
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.08), 10.6 * width_scale)
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), 6.2 * width_scale)
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.66), 3.0 * width_scale)
	else:
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.72), 2.0 * width_scale)
	draw_line(from_point, to_point, Color(hot_core.r, hot_core.g, hot_core.b, 0.96), maxf(0.9, 1.18 * width_scale))


func _draw_neon_arc(center: Vector2, arc_radius: float, start_angle: float, end_angle: float, point_count: int, tube_color: Color, core_color: Color, glow_width: float, core_width: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.68)
	if quality <= VISUAL_QUALITY_SWARM:
		draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.70), maxf(1.6, glow_width * 0.34))
		draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(hot_core.r, hot_core.g, hot_core.b, 0.94), maxf(0.9, core_width * 0.78))
		return

	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.08), glow_width * 1.7)
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), glow_width)
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.66), maxf(core_width + 1.7, glow_width * 0.42))
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), core_width)


func _visual_quality() -> int:
	if main_ref and main_ref.has_method("get_visual_quality"):
		return main_ref.get_visual_quality()
	return VISUAL_QUALITY_FULL


func _redraw_interval_for_quality(quality: int) -> float:
	match quality:
		VISUAL_QUALITY_SWARM:
			return REDRAW_INTERVAL_SWARM
		VISUAL_QUALITY_MEDIUM:
			return REDRAW_INTERVAL_MEDIUM
		_:
			return REDRAW_INTERVAL_FULL


func _spark_count_for_quality(quality: int) -> int:
	match quality:
		VISUAL_QUALITY_SWARM:
			return EDGE_SPARKS_SWARM
		VISUAL_QUALITY_MEDIUM:
			return EDGE_SPARKS_MEDIUM
		_:
			return EDGE_SPARKS_FULL


func _count_for_quality(quality: int, full_count: int, medium_count: int, swarm_count: int) -> int:
	match quality:
		VISUAL_QUALITY_SWARM:
			return swarm_count
		VISUAL_QUALITY_MEDIUM:
			return medium_count
		_:
			return full_count


func _arc_segments_for_quality(quality: int, full_count: int, medium_count: int, swarm_count: int) -> int:
	return _count_for_quality(quality, full_count, medium_count, swarm_count)


func _pulse_speed() -> float:
	match enemy_type:
		"exploder":
			return 7.6
		"chaser":
			return 5.4
		"shooter":
			return 3.8
		_:
			return 2.4


func _pulse_size() -> float:
	match enemy_type:
		"exploder":
			return 9.0
		"tank":
			return 4.0
		_:
			return 5.5


func _cache_draw_points() -> void:
	match enemy_type:
		"tank":
			_body_points = PackedVector2Array([
				Vector2(-radius, -radius),
				Vector2(radius, -radius),
				Vector2(radius, radius),
				Vector2(-radius, radius)
			])
			_outer_points = PackedVector2Array([
				Vector2(-radius - 6.0, -radius - 6.0),
				Vector2(radius + 6.0, -radius - 6.0),
				Vector2(radius + 6.0, radius + 6.0),
				Vector2(-radius - 6.0, radius + 6.0)
			])
			_inner_points = PackedVector2Array([
				Vector2(0.0, -radius * 0.58),
				Vector2(radius * 0.58, 0.0),
				Vector2(0.0, radius * 0.58),
				Vector2(-radius * 0.58, 0.0)
			])
		"shooter":
			_body_points = PackedVector2Array([
				Vector2(0.0, -radius),
				Vector2(radius, 0.0),
				Vector2(0.0, radius),
				Vector2(-radius, 0.0)
			])
			_outer_points = PackedVector2Array()
			_inner_points = PackedVector2Array([
				Vector2(0.0, -radius * 0.55),
				Vector2(radius * 0.55, 0.0),
				Vector2(0.0, radius * 0.55),
				Vector2(-radius * 0.55, 0.0)
			])
		"exploder":
			_body_points = _regular_polygon(8, radius * 0.78, -PI / 2.0)
			_outer_points = PackedVector2Array()
			_inner_points = PackedVector2Array()
		_:
			_body_points = PackedVector2Array([
				Vector2(radius + 6.0, 0.0),
				Vector2(-radius * 0.9, -radius * 0.85),
				Vector2(-radius * 0.64, 0.0),
				Vector2(-radius * 0.9, radius * 0.85)
			])
			_outer_points = PackedVector2Array()
			_inner_points = PackedVector2Array()

	_body_closed = _closed_points(_body_points)
	_outer_closed = _closed_points(_outer_points)
	_inner_closed = _closed_points(_inner_points)


func _regular_polygon(sides: int, poly_radius: float, offset: float = 0.0) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in range(sides):
		points.append(Vector2.from_angle(offset + TAU * float(i) / float(sides)) * poly_radius)
	return points


func _closed_points(points: PackedVector2Array) -> PackedVector2Array:
	var closed := PackedVector2Array(points)
	if points.size() > 0:
		closed.append(points[0])
	return closed
