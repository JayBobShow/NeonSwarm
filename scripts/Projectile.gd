extends Area2D

const TRAIL_LENGTH_FULL := 7
const TRAIL_LENGTH_MEDIUM := 5
const TRAIL_LENGTH_SWARM := 2
const TRAIL_SPACING_FULL := 16.0
const TRAIL_SPACING_MEDIUM := 22.0
const TRAIL_SPACING_SWARM := 34.0
const IMPACT_FX_INTERVAL_FULL := 0.018
const IMPACT_FX_INTERVAL_MEDIUM := 0.040
const IMPACT_FX_INTERVAL_SWARM := 0.080
const IMPACT_FX_DISTANCE_FULL := 18.0
const IMPACT_FX_DISTANCE_MEDIUM := 28.0
const IMPACT_FX_DISTANCE_SWARM := 44.0

var direction := Vector2.RIGHT
var speed := 600.0
var damage := 10.0
var max_distance := 800.0
var start_position := Vector2.ZERO
var projectile_color := Color(0.0, 1.0, 1.0)
var target_group := "enemies"
var main_ref: Node
var radius := 5.0
var pierce_remaining := 0
var source: Node
var _hit_ids := {}
var _trail_points: Array[Vector2] = []
var _life_time := 0.0
var _last_impact_fx_time := -999.0
var _last_impact_fx_position := Vector2(10000000.0, 10000000.0)


func setup(
	origin: Vector2,
	p_direction: Vector2,
	p_damage: float,
	p_speed: float,
	p_range: float,
	p_color: Color,
	p_target_group: String,
	p_main_ref: Node,
	p_radius: float,
	p_pierce: int
) -> void:
	global_position = origin
	start_position = origin
	direction = p_direction.normalized() if p_direction.length() > 0.01 else Vector2.RIGHT
	damage = p_damage
	speed = p_speed
	max_distance = p_range
	projectile_color = p_color
	target_group = p_target_group
	main_ref = p_main_ref
	radius = p_radius
	pierce_remaining = p_pierce


func _ready() -> void:
	z_index = 10
	monitoring = true
	monitorable = false

	if target_group == "player":
		collision_layer = 16
		collision_mask = 1
	else:
		collision_layer = 4
		collision_mask = 2

	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = radius
	shape.shape = circle
	add_child(shape)

	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)
	rotation = direction.angle()
	_record_trail_point()


func _physics_process(delta: float) -> void:
	_life_time += delta
	global_position += direction * speed * delta
	rotation = direction.angle()

	if start_position.distance_to(global_position) >= max_distance:
		queue_free()
		return

	_record_trail_point()
	queue_redraw()


func _draw() -> void:
	var quality := _visual_quality()
	if quality >= 1:
		_draw_trail()

	var pulse := sin(_life_time * 28.0) * 0.5 + 0.5
	var core := Color.WHITE.lerp(projectile_color, 0.08)
	var danger_color := projectile_color if target_group == "enemies" else projectile_color.lerp(Color(1.0, 0.08, 0.08), 0.35)
	var beam_length := 56.0 if quality >= 2 else 40.0 if quality == 1 else 28.0
	var head := Vector2(radius * 1.9, 0.0)
	var tail := Vector2(-beam_length, 0.0)
	var gas_alpha := 0.18 + pulse * 0.06
	var hot_alpha := 0.94 + pulse * 0.06
	var outer_width := 19.0 if quality >= 2 else 10.5 if quality == 1 else 5.2
	draw_line(tail * 1.12, head * 1.04, Color(danger_color.r, danger_color.g, danger_color.b, gas_alpha * 0.22), outer_width)
	draw_line(tail * 1.02, head, Color(danger_color.r, danger_color.g, danger_color.b, gas_alpha), outer_width * 0.48)
	draw_line(tail * 0.90, head, Color(danger_color.r, danger_color.g, danger_color.b, 0.76), maxf(1.7, outer_width * 0.18))
	draw_line(tail * 0.70, head, Color(core.r, core.g, core.b, hot_alpha), 1.55 if quality >= 1 else 1.15)
	draw_line(Vector2(-radius * 2.2, 0.0), Vector2(radius * 2.2, 0.0), core, 1.75 if quality >= 1 else 1.25)
	if quality >= 1:
		draw_circle(head, radius * 2.15, Color(danger_color.r, danger_color.g, danger_color.b, 0.10 + pulse * 0.04))
		draw_circle(head, radius * 0.82, Color(1.0, 1.0, 1.0, 0.72 + pulse * 0.18))
		draw_line(Vector2(-radius * 1.6, -radius * 0.92), Vector2(radius * 1.8, radius * 0.92), Color(core.r, core.g, core.b, 0.46), 0.85)
		draw_line(Vector2(-radius * 1.6, radius * 0.92), Vector2(radius * 1.8, -radius * 0.92), Color(core.r, core.g, core.b, 0.46), 0.85)
		draw_line(Vector2(radius * 0.2, -radius * (1.8 + pulse * 0.25)), Vector2(radius * 0.2, radius * (1.8 + pulse * 0.25)), Color(core.r, core.g, core.b, 0.74), 1.0)
	if quality >= 2:
		draw_line(Vector2(-radius * 0.6, -radius * 2.5), Vector2(radius * 1.2, radius * 1.8), Color(danger_color.r, danger_color.g, danger_color.b, 0.42), 0.8)
		draw_line(Vector2(-radius * 0.9, radius * 2.1), Vector2(radius * 1.4, -radius * 1.6), Color(1.0, 1.0, 1.0, 0.36), 0.75)


func _on_area_entered(area: Area2D) -> void:
	if target_group != "enemies":
		return
	if not area.is_in_group("enemies") or not area.has_method("take_damage"):
		return

	var id := area.get_instance_id()
	if _hit_ids.has(id):
		return

	_hit_ids[id] = true
	area.take_damage(damage, source)
	_spawn_impact()
	_consume_pierce()


func _on_body_entered(body: Node) -> void:
	if target_group != "player":
		return
	if not body.is_in_group("player") or not body.has_method("take_damage"):
		return

	body.take_damage(damage)
	_spawn_impact()
	queue_free()


func _consume_pierce() -> void:
	if pierce_remaining > 0:
		pierce_remaining -= 1
		return
	queue_free()


func _spawn_impact() -> void:
	if not _can_emit_impact_fx():
		return

	if main_ref and main_ref.has_node("ParticleFX"):
		if main_ref.particle_fx.has_method("projectile_impact"):
			main_ref.particle_fx.projectile_impact(global_position, projectile_color, direction)
		else:
			main_ref.particle_fx.spark(global_position, projectile_color)


func _record_trail_point() -> void:
	if _trail_points.is_empty() or _trail_points[-1].distance_to(global_position) > _trail_spacing():
		_trail_points.append(global_position)

	while _trail_points.size() > _trail_limit():
		_trail_points.pop_front()


func _draw_trail() -> void:
	if _trail_points.size() < 2:
		return

	var quality := _visual_quality()
	for i in range(_trail_points.size() - 1):
		var age := float(i) / float(maxi(_trail_points.size() - 1, 1))
		var from_point := to_local(_trail_points[i])
		var to_point := to_local(_trail_points[i + 1])
		var alpha := 0.04 + age * 0.18
		if quality >= 2:
			draw_line(from_point, to_point, Color(projectile_color.r, projectile_color.g, projectile_color.b, alpha * 0.30), 10.0 + age * 8.0)
		draw_line(from_point, to_point, Color(projectile_color.r, projectile_color.g, projectile_color.b, alpha * 1.05), 2.5 + age * 3.0)
		draw_line(from_point, to_point, Color(1.0, 1.0, 1.0, alpha * 0.86), 0.9 + age * 0.8)


func _can_emit_impact_fx() -> bool:
	var interval := _impact_fx_interval()
	var distance := _impact_fx_distance()
	if _life_time - _last_impact_fx_time < interval and global_position.distance_to(_last_impact_fx_position) < distance:
		return false
	_last_impact_fx_time = _life_time
	_last_impact_fx_position = global_position
	return true


func _trail_limit() -> int:
	match _visual_quality():
		0:
			return TRAIL_LENGTH_SWARM
		1:
			return TRAIL_LENGTH_MEDIUM
		_:
			return TRAIL_LENGTH_FULL


func _trail_spacing() -> float:
	match _visual_quality():
		0:
			return TRAIL_SPACING_SWARM
		1:
			return TRAIL_SPACING_MEDIUM
		_:
			return TRAIL_SPACING_FULL


func _impact_fx_interval() -> float:
	match _visual_quality():
		0:
			return IMPACT_FX_INTERVAL_SWARM
		1:
			return IMPACT_FX_INTERVAL_MEDIUM
		_:
			return IMPACT_FX_INTERVAL_FULL


func _impact_fx_distance() -> float:
	match _visual_quality():
		0:
			return IMPACT_FX_DISTANCE_SWARM
		1:
			return IMPACT_FX_DISTANCE_MEDIUM
		_:
			return IMPACT_FX_DISTANCE_FULL


func _visual_quality() -> int:
	if main_ref and main_ref.has_method("get_visual_quality"):
		return main_ref.get_visual_quality()
	return 2
