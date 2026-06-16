extends Node2D

const VISUAL_QUALITY_FULL := 2
const VISUAL_QUALITY_MEDIUM := 1
const VISUAL_QUALITY_SWARM := 0
const MAX_EFFECT_NODES_FULL := 72
const MAX_EFFECT_NODES_MEDIUM := 46
const MAX_EFFECT_NODES_SWARM := 24
const SECONDARY_EFFECT_RESERVE_FULL := 10
const SECONDARY_EFFECT_RESERVE_MEDIUM := 7
const SECONDARY_EFFECT_RESERVE_SWARM := 5
const IMPACT_BUCKET_SIZE := 52.0
const HIT_BUCKET_SIZE := 44.0
const PICKUP_BUCKET_SIZE := 38.0
const THROTTLE_CLEANUP_INTERVAL := 0.40

var visual_quality := VISUAL_QUALITY_FULL
var additive_material: CanvasItemMaterial
var _fx_clock := 0.0
var _throttle_cleanup_timer := THROTTLE_CLEANUP_INTERVAL
var _spatial_fx_times := {}
var _global_fx_times := {}


func _ready() -> void:
	additive_material = CanvasItemMaterial.new()
	additive_material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD


func _process(delta: float) -> void:
	_fx_clock += delta
	_throttle_cleanup_timer -= delta
	if _throttle_cleanup_timer <= 0.0:
		_throttle_cleanup_timer = THROTTLE_CLEANUP_INTERVAL
		_trim_throttle_buckets()


func set_visual_quality(quality: int) -> void:
	visual_quality = clampi(quality, VISUAL_QUALITY_SWARM, VISUAL_QUALITY_FULL)


func get_active_effect_count() -> int:
	return get_child_count()


func explosion(position: Vector2, color: Color, amount: int = 36, scale_factor: float = 1.0) -> void:
	if not _can_spawn_effect(1):
		return

	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_vapor_puff(position, color, 5.0 * scale_factor, 66.0 * scale_factor, 18.0 * scale_factor, 0.26)
	_plasma_core_pop(position, color, 25.0 * scale_factor, 0.14)
	_center_star(position, color, 30.0 * scale_factor, 0.12)
	_vector_fragment_burst(position, color, amount, 20.0 * scale_factor, 58.0 * scale_factor, 0.28, 108.0 * scale_factor)

	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_energy_ring(position, 9.0 * scale_factor, 96.0 * scale_factor, Color.WHITE.lerp(color, 0.24), 2.5, 0.20)
		_energy_ring(position, 17.0 * scale_factor, 84.0 * scale_factor, color, 5.2, 0.26)
	if visual_quality == VISUAL_QUALITY_FULL:
		_spark_spokes(position, color, 7, 62.0 * scale_factor, 0.15)


func spark(position: Vector2, color: Color) -> void:
	projectile_impact(position, color, Vector2.ZERO)


func projectile_impact(position: Vector2, color: Color, direction: Vector2 = Vector2.ZERO) -> void:
	if not _allow_spatial_effect(position, "projectile_impact", _projectile_impact_interval(), IMPACT_BUCKET_SIZE):
		return
	if not _can_spawn_effect(1):
		return

	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_vapor_puff(position, color, 3.5, 24.0, 8.0, 0.11)
	_plasma_core_pop(position, color, 11.0, 0.065)
	_center_star(position, color, 13.0, 0.062)
	if direction.length() > 0.05:
		_directional_fragment_burst(position, color, direction.normalized(), 6, 10.0, 30.0, 0.13, 42.0)
	else:
		_vector_fragment_burst(position, color, 6, 8.0, 24.0, 0.13, 38.0)
	if visual_quality == VISUAL_QUALITY_FULL:
		_spark_spokes(position, color, 2, 28.0, 0.085)


func enemy_hit(position: Vector2, color: Color) -> void:
	if not _allow_spatial_effect(position, "enemy_hit", _enemy_hit_interval(), HIT_BUCKET_SIZE):
		return
	if not _can_spawn_effect(1):
		return

	_center_star(position, color, 9.5, 0.055)
	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_vapor_puff(position, color, 2.8, 18.0, 6.0, 0.09)
		_plasma_core_pop(position, color, 8.0, 0.06)
	_vector_fragment_burst(position, color, 4, 6.0, 20.0, 0.10, 26.0)


func player_hit(position: Vector2) -> void:
	var color := Color(1.0, 0.12, 0.24)
	_vapor_puff(position, color, 8.0, 66.0, 18.0, 0.18)
	_plasma_core_pop(position, color, 24.0, 0.16)
	_energy_ring(position, 22.0, 76.0, color, 5.0, 0.22)
	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_spark_spokes(position, color, 8, 42.0, 0.18)
	explosion(position, color, 14, 0.45)


func player_death(position: Vector2) -> void:
	_vapor_puff(position, Color(0.0, 0.95, 1.0), 16.0, 190.0, 42.0, 0.34)
	_plasma_core_pop(position, Color.WHITE, 46.0, 0.22)
	explosion(position, Color(0.0, 0.95, 1.0), 58, 1.3)
	explosion(position, Color(1.0, 0.1, 0.85), 34, 1.05)
	_energy_ring(position, 36.0, 210.0, Color(1.0, 1.0, 1.0), 6.0, 0.42)


func level_up_burst(position: Vector2) -> void:
	_vapor_puff(position, Color(0.2, 1.0, 0.62), 18.0, 170.0, 32.0, 0.32)
	_plasma_core_pop(position, Color(0.72, 1.0, 0.94), 34.0, 0.20)
	_energy_ring(position, 34.0, 190.0, Color(0.2, 1.0, 0.62), 5.0, 0.42)
	_energy_ring(position, 20.0, 120.0, Color(0.0, 0.88, 1.0), 3.0, 0.34)
	explosion(position, Color(0.2, 1.0, 0.62), 44, 0.9)


func nova(position: Vector2, radius: float, color: Color) -> void:
	_vapor_puff(position, color, radius * 0.10, radius * 0.92, radius * 0.12, 0.26)
	_plasma_core_pop(position, color, 44.0, 0.18)
	_center_star(position, color, 54.0, 0.16)
	_energy_ring(position, radius * 0.12, radius, Color.WHITE.lerp(color, 0.22), 3.0, 0.25)
	_energy_ring(position, radius * 0.18, radius, color, 7.5, 0.34)
	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_energy_ring(position, radius * 0.08, radius * 0.64, Color.WHITE, 2.2, 0.22)
		_radial_rays(position, color, 20, radius * 0.12, radius * 1.02, 0.20)
	else:
		_radial_rays(position, color, 7, radius * 0.22, radius * 0.72, 0.12)

	if not _can_spawn_effect(2):
		return

	var ring := Line2D.new()
	ring.name = "NovaRing"
	ring.global_position = position
	ring.width = 4.6 if visual_quality > VISUAL_QUALITY_SWARM else 2.4
	ring.default_color = Color(color.r, color.g, color.b, 0.92)
	ring.closed = true
	ring.points = _circle_points(radius, _ring_point_count())
	ring.material = _additive_material()
	ring.antialiased = true
	add_child(ring)

	var inner := Line2D.new()
	inner.name = "NovaInnerRing"
	inner.global_position = position
	inner.width = 1.8
	inner.default_color = Color(1.0, 1.0, 1.0, 0.9)
	inner.closed = true
	inner.points = _circle_points(radius * 0.55, _ring_point_count())
	inner.material = _additive_material()
	inner.antialiased = true
	add_child(inner)

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(ring, "scale", Vector2(1.18, 1.18), 0.32)
	tween.tween_property(ring, "modulate:a", 0.0, 0.32)
	tween.tween_property(inner, "scale", Vector2(1.45, 1.45), 0.26)
	tween.tween_property(inner, "modulate:a", 0.0, 0.26)
	tween.finished.connect(func() -> void:
		if is_instance_valid(ring):
			ring.queue_free()
		if is_instance_valid(inner):
			inner.queue_free()
	)

	_vector_fragment_burst(position, color, 24, 24.0, 70.0, 0.25, 132.0)


func pickup_pop(position: Vector2) -> void:
	if not _allow_spatial_effect(position, "pickup_pop", _pickup_pop_interval(), PICKUP_BUCKET_SIZE):
		return
	if not _can_spawn_effect(1):
		return

	var color := Color(0.95, 1.0, 0.18)
	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_vapor_puff(position, color, 3.0, 26.0, 8.5, 0.10)
	_plasma_core_pop(position, color, 12.0, 0.075)
	_center_star(position, Color.WHITE.lerp(color, 0.28), 14.0, 0.065)
	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_energy_ring(position, 5.0, 34.0, color, 2.3, 0.14)
	_vector_fragment_burst(position, color, 5, 6.0, 18.0, 0.10, 26.0)


func weapon_muzzle(position: Vector2, direction: Vector2, color: Color) -> void:
	if visual_quality == VISUAL_QUALITY_SWARM:
		return
	if not _allow_global_effect("weapon_muzzle", _muzzle_interval()):
		return
	if not _can_spawn_effect(1):
		return

	var aim := direction.normalized() if direction.length() > 0.05 else Vector2.RIGHT
	_plasma_core_pop(position, color, 7.0, 0.045)
	_directional_fragment_burst(position, color, aim, 3, 7.0, 18.0, 0.065, 16.0)


func _circle_points(radius: float, count: int) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in range(count):
		points.append(Vector2.from_angle(TAU * float(i) / float(count)) * radius)
	return points


func _spark_spokes(position: Vector2, color: Color, count: int, length: float, duration: float) -> void:
	if not _can_spawn_secondary_effect(_plasma_line_cost()):
		return

	var spoke_count := mini(count, int(float(_available_secondary_effect_slots()) / float(_plasma_line_cost())))
	for i in range(spoke_count):
		if not _can_spawn_secondary_effect(_plasma_line_cost()):
			return

		var angle := TAU * float(i) / float(count) + randf_range(-0.16, 0.16)
		var direction := Vector2.from_angle(angle)
		var spark_color := Color.WHITE.lerp(color, 0.55)
		spark_color.a = 0.86
		_spawn_plasma_line(
			position,
			direction * length * 0.12,
			direction * length,
			spark_color,
			1.55,
			8.6,
			duration,
			direction * length * 0.32,
			Vector2(1.28, 1.28)
		)


func _energy_ring(position: Vector2, start_radius: float, end_radius: float, color: Color, width: float, duration: float) -> void:
	if not _can_spawn_effect(1):
		return

	var ring := _make_ring("NeonEnergyGlow", position, start_radius, width * 3.2, Color(color.r, color.g, color.b, 0.28))
	_animate_ring(ring, end_radius, duration)

	if visual_quality > VISUAL_QUALITY_SWARM and _can_spawn_effect(1):
		var core_color := Color.WHITE.lerp(color, 0.30)
		core_color.a = 0.96
		var core := _make_ring("NeonEnergyCore", position, start_radius, maxf(1.0, width * 0.42), core_color)
		_animate_ring(core, end_radius, duration * 0.88)


func _plasma_core_pop(position: Vector2, color: Color, radius: float, duration: float) -> void:
	if not _can_spawn_effect(1):
		return

	var hot := Color.WHITE.lerp(color, 0.12)
	hot.a = 0.96
	_center_star(position, hot, radius, duration * 0.78)
	if visual_quality >= VISUAL_QUALITY_MEDIUM:
		_energy_ring(position, radius * 0.18, radius * 1.22, hot, 1.8, duration)
		if _can_spawn_effect(1):
			_energy_ring(position, radius * 0.34, radius * 1.62, color, 3.6, duration * 1.08)


func _center_star(position: Vector2, color: Color, radius: float, duration: float) -> void:
	var spoke_count := 4 if visual_quality == VISUAL_QUALITY_FULL else 3 if visual_quality == VISUAL_QUALITY_MEDIUM else 2
	var white := Color(1.0, 1.0, 1.0, 0.96)
	var accent := Color.WHITE.lerp(color, 0.36)
	accent.a = 0.84

	for i in range(spoke_count):
		if not _can_spawn_effect(_plasma_line_cost()):
			return
		var angle := TAU * float(i) / float(spoke_count) + PI * 0.25
		var direction := Vector2.from_angle(angle)
		var line_color := white if i % 2 == 0 else accent
		_spawn_plasma_line(
			position,
			-direction * radius * 0.42,
			direction * radius,
			line_color,
			2.7 if visual_quality >= VISUAL_QUALITY_MEDIUM else 1.5,
			11.0 if visual_quality >= VISUAL_QUALITY_MEDIUM else 3.6,
			duration,
			direction * radius * 0.12,
			Vector2(1.18, 1.18)
		)


func _vapor_puff(position: Vector2, color: Color, start_radius: float, end_radius: float, width: float, duration: float) -> void:
	if not _can_spawn_secondary_effect(1):
		return

	var haze_color := Color(color.r, color.g, color.b, 0.16 if visual_quality >= VISUAL_QUALITY_MEDIUM else 0.10)
	var puff := _make_ring("GhostPlasmaVapor", position, start_radius, width, haze_color)
	var actual_duration := _scaled_duration(duration)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(puff, "points", _circle_points(end_radius, _ring_point_count()), actual_duration)
	tween.tween_property(puff, "width", width * 1.55, actual_duration)
	tween.tween_property(puff, "modulate:a", 0.0, actual_duration)
	tween.finished.connect(func() -> void:
		if is_instance_valid(puff):
			puff.queue_free()
	)


func _vector_fragment_burst(
	position: Vector2,
	color: Color,
	amount: int,
	min_length: float,
	max_length: float,
	duration: float,
	travel: float
) -> void:
	var fragment_count := mini(_scaled_amount(amount), int(float(_available_secondary_effect_slots()) / float(_plasma_line_cost())))
	if fragment_count <= 0:
		return

	for i in range(fragment_count):
		if not _can_spawn_secondary_effect(_plasma_line_cost()):
			return

		var angle := TAU * float(i) / float(fragment_count) + randf_range(-0.24, 0.24)
		var direction := Vector2.from_angle(angle)
		var length := randf_range(min_length, max_length)
		var hotness := randf_range(0.14, 0.52)
		var fragment_color := Color.WHITE.lerp(color, hotness)
		fragment_color.a = randf_range(0.78, 0.96)
		var core_width := randf_range(1.25, 2.6) if visual_quality >= VISUAL_QUALITY_MEDIUM else 0.95
		var glow_width := randf_range(8.0, 14.0) if visual_quality >= VISUAL_QUALITY_MEDIUM else 2.8
		_spawn_plasma_line(
			position,
			direction * randf_range(2.0, 10.0),
			direction * length,
			fragment_color,
			core_width,
			glow_width,
			duration * randf_range(0.78, 1.14),
			direction * travel * randf_range(0.45, 1.0),
			Vector2.ONE
		)


func _directional_fragment_burst(
	position: Vector2,
	color: Color,
	direction: Vector2,
	amount: int,
	min_length: float,
	max_length: float,
	duration: float,
	travel: float
) -> void:
	var fragment_count := mini(_scaled_amount(amount), int(float(_available_secondary_effect_slots()) / float(_plasma_line_cost())))
	if fragment_count <= 0:
		return

	var base_angle := direction.angle()
	for i in range(fragment_count):
		if not _can_spawn_secondary_effect(_plasma_line_cost()):
			return

		var spread := randf_range(-0.64, 0.64)
		var fragment_direction := Vector2.from_angle(base_angle + spread)
		var length := randf_range(min_length, max_length)
		var fragment_color := Color.WHITE.lerp(color, randf_range(0.14, 0.48))
		fragment_color.a = randf_range(0.78, 0.98)
		_spawn_plasma_line(
			position,
			-fragment_direction * randf_range(1.0, 5.0),
			fragment_direction * length,
			fragment_color,
			1.45 if visual_quality >= VISUAL_QUALITY_MEDIUM else 0.9,
			8.4 if visual_quality >= VISUAL_QUALITY_MEDIUM else 2.6,
			duration * randf_range(0.86, 1.12),
			fragment_direction * travel * randf_range(0.35, 0.90),
			Vector2.ONE
		)


func _radial_rays(position: Vector2, color: Color, count: int, start_radius: float, end_radius: float, duration: float) -> void:
	var ray_count := mini(_scaled_amount(count), int(float(_available_secondary_effect_slots()) / float(_plasma_line_cost())))
	if ray_count <= 0:
		return

	for i in range(ray_count):
		if not _can_spawn_secondary_effect(_plasma_line_cost()):
			return
		var angle := TAU * float(i) / float(ray_count)
		var direction := Vector2.from_angle(angle)
		var ray_color := Color.WHITE.lerp(color, 0.28)
		ray_color.a = 0.88
		_spawn_plasma_line(
			position,
			direction * start_radius,
			direction * end_radius,
			ray_color,
			1.55 if visual_quality >= VISUAL_QUALITY_MEDIUM else 0.95,
			9.0 if visual_quality >= VISUAL_QUALITY_MEDIUM else 2.6,
			duration,
			direction * 24.0,
			Vector2.ONE
		)


func _spawn_vector_line(
	position: Vector2,
	from_point: Vector2,
	to_point: Vector2,
	color: Color,
	width: float,
	duration: float,
	travel: Vector2 = Vector2.ZERO,
	target_scale: Vector2 = Vector2.ONE
) -> void:
	if not _can_spawn_effect(1):
		return

	var line := Line2D.new()
	line.name = "VectorNeonFragment"
	line.width = width
	line.default_color = color
	line.points = PackedVector2Array([from_point, to_point])
	line.material = _additive_material()
	line.antialiased = true
	add_child(line)
	line.global_position = position

	var actual_duration := _scaled_duration(duration)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(line, "position", line.position + travel, actual_duration)
	tween.tween_property(line, "modulate:a", 0.0, actual_duration)
	if target_scale != Vector2.ONE:
		tween.tween_property(line, "scale", target_scale, actual_duration)
	tween.finished.connect(func() -> void:
		if is_instance_valid(line):
			line.queue_free()
	)


func _spawn_plasma_line(
	position: Vector2,
	from_point: Vector2,
	to_point: Vector2,
	color: Color,
	core_width: float,
	glow_width: float,
	duration: float,
	travel: Vector2 = Vector2.ZERO,
	target_scale: Vector2 = Vector2.ONE
) -> void:
	var cost := _plasma_line_cost()
	if not _can_spawn_effect(cost):
		return

	var midpoint := (from_point + to_point) * 0.5
	var normal := (to_point - from_point).orthogonal().normalized()
	var jitter := normal * randf_range(-2.2, 2.2) if visual_quality >= VISUAL_QUALITY_MEDIUM else Vector2.ZERO
	var points := PackedVector2Array([from_point, midpoint + jitter, to_point])
	var actual_duration := _scaled_duration(duration)

	var glow: Line2D = null
	if visual_quality == VISUAL_QUALITY_FULL:
		glow = _make_line("PlasmaGasGlow", points, Color(color.r, color.g, color.b, minf(color.a, 0.34)), glow_width)
		glow.global_position = position

	var core_color := Color.WHITE.lerp(color, 0.16 if visual_quality >= VISUAL_QUALITY_MEDIUM else 0.28)
	core_color.a = minf(1.0, maxf(color.a, 0.92))
	var draw_width := core_width
	if visual_quality == VISUAL_QUALITY_MEDIUM:
		draw_width = maxf(core_width * 1.2, 1.45)
	elif visual_quality == VISUAL_QUALITY_SWARM:
		draw_width = maxf(core_width, 0.95)
	var core := _make_line("PlasmaHotCore", points, core_color, draw_width)
	core.global_position = position

	var tween := create_tween()
	tween.set_parallel(true)
	if glow != null:
		tween.tween_property(glow, "position", glow.position + travel, actual_duration)
		tween.tween_property(glow, "modulate:a", 0.0, actual_duration)
		if target_scale != Vector2.ONE:
			tween.tween_property(glow, "scale", target_scale, actual_duration)
	tween.tween_property(core, "position", core.position + travel, actual_duration)
	tween.tween_property(core, "modulate:a", 0.0, actual_duration)
	if target_scale != Vector2.ONE:
		tween.tween_property(core, "scale", target_scale, actual_duration)
	tween.finished.connect(func() -> void:
		if is_instance_valid(glow):
			glow.queue_free()
		if is_instance_valid(core):
			core.queue_free()
	)


func _make_line(name: String, points: PackedVector2Array, color: Color, width: float) -> Line2D:
	var line := Line2D.new()
	line.name = name
	line.width = width
	line.default_color = color
	line.points = points
	line.material = _additive_material()
	line.antialiased = true
	add_child(line)
	return line


func _make_ring(name: String, position: Vector2, radius: float, width: float, color: Color) -> Line2D:
	var ring := Line2D.new()
	ring.name = name
	ring.width = width
	ring.default_color = color
	ring.closed = true
	ring.points = _circle_points(radius, _ring_point_count())
	ring.material = _additive_material()
	ring.antialiased = true
	add_child(ring)
	ring.global_position = position
	return ring


func _animate_ring(ring: Line2D, end_radius: float, duration: float) -> void:
	var actual_duration := _scaled_duration(duration)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(ring, "points", _circle_points(end_radius, _ring_point_count()), actual_duration)
	tween.tween_property(ring, "modulate:a", 0.0, actual_duration)
	tween.finished.connect(func() -> void:
		if is_instance_valid(ring):
			ring.queue_free()
	)


func _additive_material() -> CanvasItemMaterial:
	if additive_material == null:
		additive_material = CanvasItemMaterial.new()
		additive_material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return additive_material


func _effect_cap() -> int:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return MAX_EFFECT_NODES_SWARM
		VISUAL_QUALITY_MEDIUM:
			return MAX_EFFECT_NODES_MEDIUM
		_:
			return MAX_EFFECT_NODES_FULL


func _can_spawn_effect(cost: int) -> bool:
	return get_child_count() + cost <= _effect_cap()


func _can_spawn_secondary_effect(cost: int) -> bool:
	return get_child_count() + cost + _secondary_effect_reserve() <= _effect_cap()


func _available_effect_slots() -> int:
	return maxi(0, _effect_cap() - get_child_count())


func _available_secondary_effect_slots() -> int:
	return maxi(0, _effect_cap() - _secondary_effect_reserve() - get_child_count())


func _secondary_effect_reserve() -> int:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return SECONDARY_EFFECT_RESERVE_SWARM
		VISUAL_QUALITY_MEDIUM:
			return SECONDARY_EFFECT_RESERVE_MEDIUM
		_:
			return SECONDARY_EFFECT_RESERVE_FULL


func _scaled_amount(amount: int) -> int:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return maxi(2, int(round(float(amount) * 0.24)))
		VISUAL_QUALITY_MEDIUM:
			return maxi(3, int(round(float(amount) * 0.46)))
		_:
			return amount


func _scaled_duration(duration: float) -> float:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return duration * 0.48
		VISUAL_QUALITY_MEDIUM:
			return duration * 0.84
		_:
			return duration


func _plasma_line_cost() -> int:
	return 2 if visual_quality == VISUAL_QUALITY_FULL else 1


func _ring_point_count() -> int:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return 24
		VISUAL_QUALITY_MEDIUM:
			return 42
		_:
			return 64


func _allow_spatial_effect(position: Vector2, effect_name: String, interval: float, bucket_size: float) -> bool:
	var bucket_x := int(floorf(position.x / bucket_size))
	var bucket_y := int(floorf(position.y / bucket_size))
	var throttle_key := "%s:%d:%d" % [effect_name, bucket_x, bucket_y]
	var last_time := float(_spatial_fx_times.get(throttle_key, -999.0))
	if _fx_clock - last_time < interval:
		return false
	_spatial_fx_times[throttle_key] = _fx_clock
	return true


func _allow_global_effect(effect_name: String, interval: float) -> bool:
	var last_time := float(_global_fx_times.get(effect_name, -999.0))
	if _fx_clock - last_time < interval:
		return false
	_global_fx_times[effect_name] = _fx_clock
	return true


func _trim_throttle_buckets() -> void:
	for key in _spatial_fx_times.keys():
		if _fx_clock - float(_spatial_fx_times[key]) > 0.90:
			_spatial_fx_times.erase(key)
	for key in _global_fx_times.keys():
		if _fx_clock - float(_global_fx_times[key]) > 0.90:
			_global_fx_times.erase(key)


func _projectile_impact_interval() -> float:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return 0.075
		VISUAL_QUALITY_MEDIUM:
			return 0.040
		_:
			return 0.018


func _enemy_hit_interval() -> float:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return 0.060
		VISUAL_QUALITY_MEDIUM:
			return 0.032
		_:
			return 0.014


func _pickup_pop_interval() -> float:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return 0.085
		VISUAL_QUALITY_MEDIUM:
			return 0.045
		_:
			return 0.020


func _muzzle_interval() -> float:
	return 0.050 if visual_quality == VISUAL_QUALITY_MEDIUM else 0.026
