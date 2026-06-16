extends CharacterBody2D

const MOVE_DEADZONE := 0.24
const AIM_DEADZONE := 0.28
const TRAIL_LENGTH := 12
const EDGE_SPARK_COUNT := 14
const EDGE_SPARK_COUNT_SWARM := 8
const VISUAL_QUALITY_SWARM := 0
const VISUAL_QUALITY_MEDIUM := 1
const VISUAL_QUALITY_FULL := 2

signal health_changed(current: float, maximum: float)
signal xp_changed(current: int, required: int, level: int)
signal leveled_up(level: int)
signal stats_changed
signal died

@onready var pickup_area: Area2D = $PickupArea
@onready var pickup_shape: CollisionShape2D = $PickupArea/PickupShape
@onready var weapon_controller: Node2D = $WeaponController

var main_ref: Node

var max_health := 100.0
var health := 100.0
var speed := 260.0
var damage_multiplier := 1.0
var fire_rate_multiplier := 1.0
var pickup_radius := 110.0
var projectile_count_bonus := 0
var orbital_count_bonus := 0
var nova_cooldown_multiplier := 1.0
var orbit_damage_multiplier := 1.0
var pulse_pierce_bonus := 0

var level := 1
var xp := 0
var xp_required := 20
var pending_level_ups := 0
var level_up_in_progress := false
var dead := false

var aim_direction := Vector2.ZERO

var _hurt_flash := 0.0
var _invulnerability_timer := 0.0
var _visual_time := 0.0
var _trail_points: Array[Vector2] = []
var _outer_diamond := PackedVector2Array()
var _hex_closed := PackedVector2Array()


func _ready() -> void:
	add_to_group("player")
	z_index = 45
	pickup_shape.shape = pickup_shape.shape.duplicate()
	pickup_area.area_entered.connect(_on_pickup_area_entered)
	_update_pickup_radius()
	_cache_draw_points()
	emit_signals()


func configure(main_node: Node) -> void:
	main_ref = main_node
	weapon_controller.configure(main_node, self)


func _physics_process(delta: float) -> void:
	if dead:
		return

	_visual_time += delta
	if _invulnerability_timer > 0.0:
		_invulnerability_timer -= delta
	if _hurt_flash > 0.0:
		_hurt_flash -= delta
		queue_redraw()

	var input_vector := _read_movement_input()
	aim_direction = _read_aim_input()
	velocity = input_vector * speed
	move_and_slide()

	if main_ref and main_ref.has_method("clamp_to_arena"):
		global_position = main_ref.clamp_to_arena(global_position, 24.0)

	_record_trail_point()
	queue_redraw()


func _draw() -> void:
	var quality := _visual_quality()
	_draw_movement_trail()

	var flash := clampf(_hurt_flash * 5.0, 0.0, 1.0)
	var pulse := sin(_visual_time * 5.2) * 0.5 + 0.5
	var turbulence := sin(_visual_time * 13.7) * 0.5 + 0.5
	var core_color := Color(0.04, 0.96, 1.0).lerp(Color(1.0, 0.12, 0.22), flash)
	var accent_color := Color(1.0, 0.08, 0.92)
	var green_flare := Color(0.18, 1.0, 0.72)
	var shell_color := Color(0.0, 0.92, 1.0).lerp(Color.WHITE, flash * 0.75)
	var ring_segments := 58 if quality == VISUAL_QUALITY_FULL else 42
	var spark_count := EDGE_SPARK_COUNT if quality > VISUAL_QUALITY_SWARM else EDGE_SPARK_COUNT_SWARM

	_draw_velocity_smear(shell_color, accent_color, quality)
	_draw_plasma_haze(Vector2.ZERO, 41.0 + pulse * 3.0, shell_color, 0.32 + flash * 0.26, quality)
	_draw_neon_arc(Vector2.ZERO, 39.0 + pulse * 2.6, -0.12, TAU + 0.12, ring_segments, shell_color, Color.WHITE, 16.0, 3.0, quality)
	_draw_neon_arc(Vector2.ZERO, 30.0 + pulse * 1.7, _visual_time * 1.25, _visual_time * 1.25 + TAU * 0.70, 36 if quality > VISUAL_QUALITY_SWARM else 24, accent_color, Color.WHITE, 11.0, 2.2, quality)
	_draw_neon_arc(Vector2.ZERO, 47.0 + pulse * 3.3, -_visual_time * 0.82, -_visual_time * 0.82 + TAU * 0.34, 24 if quality > VISUAL_QUALITY_SWARM else 14, green_flare, Color.WHITE, 8.4, 1.7, quality)
	_draw_vapor_breakup(48.0 + pulse * 3.5, shell_color, accent_color, pulse, quality)
	_draw_orbit_sparks(spark_count, 43.0 + pulse * 3.0, pulse, flash, quality)

	_draw_neon_polyline(_outer_diamond, accent_color, Color.WHITE, 15.0, 2.8, quality)
	if quality > VISUAL_QUALITY_SWARM:
		_draw_polyline_sparks(_outer_diamond, 8, accent_color, _visual_time * 1.8)

	_update_hex_points(18.0, PI / 6.0 + _visual_time * 0.35)
	_draw_neon_polyline(_hex_closed, core_color, Color.WHITE, 11.0, 2.4, quality)
	_draw_neon_line(Vector2(-25.0, 0.0), Vector2(25.0, 0.0), core_color, Color.WHITE, 9.8, 2.2, quality)
	_draw_neon_line(Vector2(0.0, -25.0), Vector2(0.0, 25.0), core_color, Color.WHITE, 9.8, 2.2, quality)
	_draw_neon_line(Vector2(-16.0, -16.0), Vector2(16.0, 16.0), accent_color, Color.WHITE, 7.0, 1.5, quality)
	_draw_neon_line(Vector2(-16.0, 16.0), Vector2(16.0, -16.0), accent_color, Color.WHITE, 7.0, 1.5, quality)
	_draw_hot_point(Vector2.ZERO, 5.0 + turbulence * 1.1, Color.WHITE, core_color, 1.0 + flash)
	_draw_hot_point(Vector2.from_angle(_visual_time * 2.4) * 18.5, 2.4, Color.WHITE, accent_color, 0.78)
	if quality > VISUAL_QUALITY_SWARM:
		_draw_hot_point(Vector2.from_angle(-_visual_time * 1.9 + PI) * 23.0, 2.1, Color.WHITE, green_flare, 0.66)

	if aim_direction != Vector2.ZERO:
		_draw_neon_line(Vector2.ZERO, aim_direction * 54.0, green_flare, Color.WHITE, 8.5, 1.9, quality)
		_draw_neon_arc(aim_direction * 58.0, 7.0 + pulse, 0.0, TAU, 18 if quality > VISUAL_QUALITY_SWARM else 12, green_flare, Color.WHITE, 6.2, 1.4, quality)
		_draw_hot_point(aim_direction * 56.0, 2.4 + pulse * 0.6, Color.WHITE, green_flare, 0.85)

	if flash > 0.0:
		_draw_plasma_haze(Vector2.ZERO, 60.0 + 18.0 * flash, Color(1.0, 0.05, 0.12), 0.42 * flash, quality)
		_draw_neon_arc(Vector2.ZERO, 52.0 + 24.0 * flash, 0.0, TAU, 46 if quality > VISUAL_QUALITY_SWARM else 28, Color(1.0, 0.05, 0.12), Color.WHITE, 18.0 * flash, 3.0, quality)
		_draw_neon_line(Vector2(-40.0, 0.0), Vector2(40.0, 0.0), Color(1.0, 0.05, 0.12), Color.WHITE, 12.0 * flash, 1.8, quality)
		_draw_neon_line(Vector2(0.0, -40.0), Vector2(0.0, 40.0), Color(1.0, 0.05, 0.12), Color.WHITE, 12.0 * flash, 1.8, quality)


func _read_movement_input() -> Vector2:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down", MOVE_DEADZONE)
	return input_vector.limit_length(1.0)


func _read_aim_input() -> Vector2:
	var input_vector := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down", AIM_DEADZONE)
	return input_vector.normalized() if input_vector.length() > 0.0 else Vector2.ZERO


func get_aim_direction() -> Vector2:
	return aim_direction


func take_damage(amount: float) -> void:
	if dead or _invulnerability_timer > 0.0 or get_tree().paused:
		return

	health = maxf(0.0, health - amount)
	_hurt_flash = 0.32
	_invulnerability_timer = 0.18
	if main_ref:
		if main_ref.has_method("request_screen_shake"):
			main_ref.request_screen_shake(7.5, 0.14)
		if main_ref.has_node("ParticleFX"):
			main_ref.particle_fx.player_hit(global_position)
	health_changed.emit(health, max_health)
	queue_redraw()

	if health <= 0.0:
		dead = true
		died.emit()


func collect_xp(value: int) -> void:
	if dead:
		return

	xp += value
	while xp >= xp_required:
		xp -= xp_required
		level += 1
		pending_level_ups += 1
		xp_required = int(round(float(xp_required) * 1.28 + 8.0))

	xp_changed.emit(xp, xp_required, level)
	_request_next_level_up()


func complete_level_up_choice() -> void:
	level_up_in_progress = false
	_request_next_level_up()


func apply_upgrade(upgrade: Dictionary) -> void:
	var effects: Dictionary = upgrade.get("effects", {})

	damage_multiplier += effects.get("damage_multiplier_add", 0.0)
	fire_rate_multiplier += effects.get("fire_rate_multiplier_add", 0.0)
	speed += effects.get("speed_add", 0.0)
	pickup_radius += effects.get("pickup_radius_add", 0.0)
	projectile_count_bonus += effects.get("projectile_count_add", 0)
	orbital_count_bonus += effects.get("orbital_count_add", 0)
	orbit_damage_multiplier += effects.get("orbit_damage_multiplier_add", 0.0)
	pulse_pierce_bonus += effects.get("pulse_pierce_add", 0)
	nova_cooldown_multiplier = maxf(0.35, nova_cooldown_multiplier + effects.get("nova_cooldown_multiplier_add", 0.0))

	if effects.has("max_health_add"):
		max_health += effects.max_health_add
		health = minf(max_health, health + effects.get("heal_add", effects.max_health_add))
	elif effects.has("heal_add"):
		health = minf(max_health, health + effects.heal_add)

	_update_pickup_radius()
	weapon_controller.refresh_from_player_stats()
	emit_signals()


func get_damage(base_damage: float) -> float:
	return base_damage * damage_multiplier


func emit_signals() -> void:
	health_changed.emit(health, max_health)
	xp_changed.emit(xp, xp_required, level)
	stats_changed.emit()


func _request_next_level_up() -> void:
	if level_up_in_progress or pending_level_ups <= 0:
		return

	pending_level_ups -= 1
	level_up_in_progress = true
	leveled_up.emit(level)


func _update_pickup_radius() -> void:
	if pickup_shape and pickup_shape.shape:
		pickup_shape.shape.radius = pickup_radius


func _on_pickup_area_entered(area: Area2D) -> void:
	if area.has_method("attract_to"):
		area.attract_to(self)


func _record_trail_point() -> void:
	if _trail_points.is_empty() or _trail_points[-1].distance_to(global_position) > 7.0:
		_trail_points.append(global_position)

	while _trail_points.size() > TRAIL_LENGTH:
		_trail_points.pop_front()


func _cache_draw_points() -> void:
	_outer_diamond = PackedVector2Array([
		Vector2(0.0, -31.0),
		Vector2(31.0, 0.0),
		Vector2(0.0, 31.0),
		Vector2(-31.0, 0.0),
		Vector2(0.0, -31.0)
	])
	_hex_closed = PackedVector2Array()


func _update_hex_points(poly_radius: float, offset: float) -> void:
	_hex_closed.clear()
	for i in range(6):
		_hex_closed.append(Vector2.from_angle(offset + TAU * float(i) / 6.0) * poly_radius)
	if _hex_closed.size() > 0:
		_hex_closed.append(_hex_closed[0])


func _draw_movement_trail() -> void:
	if _trail_points.size() < 2:
		return

	for i in range(_trail_points.size() - 1):
		var age := float(i) / float(maxi(_trail_points.size() - 1, 1))
		var from_point := to_local(_trail_points[i])
		var to_point := to_local(_trail_points[i + 1])
		var alpha := 0.05 + age * 0.20
		var width := 1.4 + age * 5.2
		draw_line(from_point, to_point, Color(0.0, 0.96, 1.0, alpha * 0.50), width + 3.0)
		draw_line(from_point, to_point, Color(0.0, 0.96, 1.0, alpha), width)
		draw_line(from_point, to_point, Color(1.0, 1.0, 1.0, alpha * 0.72), 1.0 + age * 1.0)
		draw_line(from_point, to_point, Color(1.0, 0.08, 0.85, alpha * 0.36), maxf(1.0, width * 0.32))
		var smear := (to_point - from_point).normalized().rotated(PI * 0.5) if from_point.distance_to(to_point) > 0.1 else Vector2.RIGHT
		draw_line(from_point + smear * 3.0, to_point + smear * 2.0, Color(0.12, 1.0, 0.78, alpha * 0.24), maxf(1.0, width * 0.36))
		draw_line(from_point - smear * 2.4, to_point - smear * 1.8, Color(1.0, 0.08, 0.9, alpha * 0.22), maxf(1.0, width * 0.30))


func _draw_velocity_smear(shell_color: Color, accent_color: Color, quality: int) -> void:
	var speed_ratio := clampf(velocity.length() / maxf(speed, 1.0), 0.0, 1.0)
	if speed_ratio <= 0.08:
		return

	var direction := velocity.normalized()
	var back := -direction
	var side := direction.rotated(PI * 0.5)
	var length := 30.0 + 22.0 * speed_ratio
	var alpha := 0.18 + 0.10 * speed_ratio
	draw_line(back * 14.0 + side * 4.0, back * length + side * 9.0, Color(shell_color.r, shell_color.g, shell_color.b, alpha * 0.42), 12.0 if quality > VISUAL_QUALITY_SWARM else 7.0)
	draw_line(back * 10.0 - side * 5.0, back * (length * 0.82) - side * 8.0, Color(accent_color.r, accent_color.g, accent_color.b, alpha * 0.38), 9.0 if quality > VISUAL_QUALITY_SWARM else 5.0)
	draw_line(back * 8.0, back * (length * 0.72), Color(1.0, 1.0, 1.0, alpha * 0.54), 1.4)


func _draw_plasma_haze(center: Vector2, radius: float, plasma_color: Color, alpha: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	if quality <= VISUAL_QUALITY_SWARM:
		draw_circle(center, radius * 0.70, Color(plasma_color.r, plasma_color.g, plasma_color.b, alpha * 0.08))
		draw_arc(center, radius * 0.80, _visual_time * 0.7, _visual_time * 0.7 + TAU * 0.42, 20, Color(plasma_color.r, plasma_color.g, plasma_color.b, alpha * 0.42), 1.5)
		return

	draw_circle(center, radius, Color(plasma_color.r, plasma_color.g, plasma_color.b, alpha * 0.11))
	draw_circle(center, radius * 0.68, Color(plasma_color.r, plasma_color.g, plasma_color.b, alpha * 0.14))
	draw_arc(center, radius * 0.92, _visual_time * 0.7, _visual_time * 0.7 + TAU * 0.62, 34, Color(plasma_color.r, plasma_color.g, plasma_color.b, alpha * 0.66), 2.5)
	draw_arc(center, radius * 0.74, -_visual_time * 1.1, -_visual_time * 1.1 + TAU * 0.38, 24, Color(1.0, 1.0, 1.0, alpha * 0.54), 1.2)


func _draw_vapor_breakup(radius: float, primary: Color, secondary: Color, pulse: float, quality: int) -> void:
	var count := 7 if quality > VISUAL_QUALITY_SWARM else 4
	for i in range(count):
		var t := float(i) / float(maxi(count, 1))
		var angle := t * TAU + _visual_time * (0.26 + t * 0.12)
		var arc_radius := radius + sin(_visual_time * 2.1 + float(i)) * 3.2
		var vapor_color := primary.lerp(secondary, fmod(float(i), 2.0))
		var start := angle + pulse * 0.16
		var span := 0.18 + 0.10 * (sin(_visual_time * 3.0 + float(i) * 2.7) * 0.5 + 0.5)
		draw_arc(Vector2.ZERO, arc_radius, start, start + span, 5, Color(vapor_color.r, vapor_color.g, vapor_color.b, 0.20), 3.8 if quality > VISUAL_QUALITY_SWARM else 2.2)
		if quality > VISUAL_QUALITY_SWARM:
			draw_arc(Vector2.ZERO, arc_radius - 2.4, start + span * 0.22, start + span * 0.78, 4, Color(1.0, 1.0, 1.0, 0.32), 0.8)


func _draw_orbit_sparks(count: int, radius: float, pulse: float, flash: float, quality: int) -> void:
	for i in range(count):
		var t := float(i) / float(maxi(count, 1))
		var jitter := sin(_visual_time * (5.2 + t * 3.0) + t * 19.0)
		var angle := t * TAU + _visual_time * (0.75 + fmod(float(i), 3.0) * 0.17) + jitter * 0.08
		var spark_radius := radius + jitter * 3.4 + pulse * 2.0
		var pos := Vector2.from_angle(angle) * spark_radius
		var tangent := Vector2.from_angle(angle + PI * 0.5)
		var spark_color := Color(0.0, 0.96, 1.0).lerp(Color(1.0, 0.08, 0.92), fmod(float(i), 2.0))
		var alpha := 0.50 + pulse * 0.20 + flash * 0.30
		draw_line(pos - tangent * 4.2, pos + tangent * 5.6, Color(spark_color.r, spark_color.g, spark_color.b, alpha * 0.34), 4.6 if quality > VISUAL_QUALITY_SWARM else 2.8)
		draw_line(pos - tangent * 3.2, pos + tangent * 4.4, Color(1.0, 1.0, 1.0, alpha), 1.0)


func _draw_polyline_sparks(points: PackedVector2Array, count: int, spark_color: Color, phase: float) -> void:
	if points.size() < 2:
		return

	for i in range(count):
		var segment := i % (points.size() - 1)
		var t := fmod(phase * 0.21 + float(i) * 0.37, 1.0)
		var from_point := points[segment]
		var to_point := points[segment + 1]
		var pos := from_point.lerp(to_point, t)
		var tangent := (to_point - from_point).normalized()
		var normal := tangent.rotated(PI * 0.5)
		var flicker := sin(phase * 3.4 + float(i) * 7.1) * 0.5 + 0.5
		pos += normal * (flicker * 3.0 - 1.5)
		draw_line(pos - tangent * 3.0, pos + tangent * 4.6, Color(spark_color.r, spark_color.g, spark_color.b, 0.42 + flicker * 0.28), 3.0)
		draw_line(pos - tangent * 1.8, pos + tangent * 2.8, Color(1.0, 1.0, 1.0, 0.68 + flicker * 0.20), 1.0)


func _draw_hot_point(position: Vector2, radius: float, core_color: Color, glow_color: Color, intensity: float) -> void:
	draw_circle(position, radius * 3.1, Color(glow_color.r, glow_color.g, glow_color.b, 0.08 * intensity))
	draw_circle(position, radius * 1.75, Color(glow_color.r, glow_color.g, glow_color.b, 0.30 * intensity))
	draw_circle(position, radius, Color(core_color.r, core_color.g, core_color.b, 0.96))


func _draw_neon_polyline(points: PackedVector2Array, tube_color: Color, core_color: Color, glow_width: float, core_width: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.72)
	if quality <= VISUAL_QUALITY_SWARM:
		draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.72), maxf(1.8, glow_width * 0.24))
		draw_polyline(points, Color(hot_core.r, hot_core.g, hot_core.b, 0.96), maxf(1.0, core_width * 0.78))
		return

	draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.09), glow_width * 1.85)
	draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), glow_width * 1.08)
	draw_polyline(points, Color(tube_color.r, tube_color.g, tube_color.b, 0.62), maxf(core_width + 2.4, glow_width * 0.48))
	draw_polyline(points, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), core_width)


func _draw_neon_line(from_point: Vector2, to_point: Vector2, tube_color: Color, core_color: Color, glow_width: float, core_width: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.72)
	if quality <= VISUAL_QUALITY_SWARM:
		draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.72), maxf(1.6, glow_width * 0.23))
		draw_line(from_point, to_point, Color(hot_core.r, hot_core.g, hot_core.b, 0.96), maxf(0.9, core_width * 0.78))
		return

	draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.09), glow_width * 1.70)
	draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), glow_width * 1.05)
	draw_line(from_point, to_point, Color(tube_color.r, tube_color.g, tube_color.b, 0.62), maxf(core_width + 2.0, glow_width * 0.48))
	draw_line(from_point, to_point, Color(hot_core.r, hot_core.g, hot_core.b, 0.97), core_width)


func _draw_neon_arc(center: Vector2, arc_radius: float, start_angle: float, end_angle: float, point_count: int, tube_color: Color, core_color: Color, glow_width: float, core_width: float, quality: int = VISUAL_QUALITY_FULL) -> void:
	var hot_core := core_color.lerp(Color.WHITE, 0.72)
	if quality <= VISUAL_QUALITY_SWARM:
		draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.68), maxf(1.8, glow_width * 0.28))
		draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(hot_core.r, hot_core.g, hot_core.b, 0.92), maxf(0.9, core_width * 0.78))
		return

	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.09), glow_width * 1.60)
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.20), glow_width)
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(tube_color.r, tube_color.g, tube_color.b, 0.62), maxf(core_width + 1.9, glow_width * 0.42))
	draw_arc(center, arc_radius, start_angle, end_angle, point_count, Color(hot_core.r, hot_core.g, hot_core.b, 0.94), core_width)


func _visual_quality() -> int:
	if main_ref and main_ref.has_method("get_visual_quality"):
		return main_ref.get_visual_quality()
	return VISUAL_QUALITY_FULL


func _regular_polygon(sides: int, radius: float, offset: float = 0.0) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in range(sides):
		points.append(Vector2.from_angle(offset + TAU * float(i) / float(sides)) * radius)
	return points


func _closed_points(points: PackedVector2Array) -> PackedVector2Array:
	var closed := PackedVector2Array(points)
	if points.size() > 0:
		closed.append(points[0])
	return closed
