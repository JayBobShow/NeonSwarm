extends Node2D

const PROJECTILE_SCRIPT := preload("res://scripts/Projectile.gd")

const PULSE_BASE_DAMAGE := 18.0
const PULSE_BASE_INTERVAL := 0.42
const PULSE_SPEED := 720.0
const PULSE_RANGE := 840.0
const ORBIT_BASE_DAMAGE := 14.0
const ORBIT_RADIUS := 72.0
const ORBIT_HIT_INTERVAL := 0.32
const NOVA_BASE_DAMAGE := 34.0
const NOVA_BASE_COOLDOWN := 6.6
const NOVA_RADIUS := 175.0
const ORBIT_HIT_FX_INTERVAL_FULL := 0.035
const ORBIT_HIT_FX_INTERVAL_MEDIUM := 0.070
const ORBIT_HIT_FX_INTERVAL_SWARM := 0.120

var main_ref: Node
var player: CharacterBody2D
var pulse_timer := 0.18
var nova_timer := 3.2
var orbit_angle := 0.0
var orbital_nodes: Array[Area2D] = []
var orbital_hit_cooldowns := {}
var additive_material: CanvasItemMaterial
var orbit_hit_fx_timer := 0.0


func configure(main_node: Node, player_node: CharacterBody2D) -> void:
	main_ref = main_node
	player = player_node
	additive_material = CanvasItemMaterial.new()
	additive_material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	refresh_from_player_stats()


func _physics_process(delta: float) -> void:
	if not is_instance_valid(player) or player.dead:
		return

	_decay_orbital_hit_cooldowns(delta)
	orbit_hit_fx_timer = maxf(0.0, orbit_hit_fx_timer - delta)
	_update_pulse(delta)
	_update_orbits(delta)
	_update_nova(delta)


func refresh_from_player_stats() -> void:
	if not is_instance_valid(player):
		return

	var desired: int = 1 + int(player.orbital_count_bonus)
	while orbital_nodes.size() < desired:
		orbital_nodes.append(_create_orbital(orbital_nodes.size()))
	while orbital_nodes.size() > desired:
		var orbital: Area2D = orbital_nodes.pop_back()
		if is_instance_valid(orbital):
			orbital.queue_free()


func _update_pulse(delta: float) -> void:
	pulse_timer -= delta
	if pulse_timer > 0.0:
		return

	var manual_direction: Vector2 = player.get_aim_direction() if player.has_method("get_aim_direction") else Vector2.ZERO
	if manual_direction != Vector2.ZERO:
		_fire_pulse_in_direction(manual_direction)
		pulse_timer = PULSE_BASE_INTERVAL / maxf(player.fire_rate_multiplier, 0.2)
		return

	var target: Area2D = null
	if main_ref and main_ref.has_method("find_nearest_enemy"):
		target = main_ref.find_nearest_enemy(player.global_position)
	if target == null:
		pulse_timer = 0.08
		return

	_fire_pulse(target)
	pulse_timer = PULSE_BASE_INTERVAL / maxf(player.fire_rate_multiplier, 0.2)


func _fire_pulse(target: Area2D) -> void:
	var base_direction := (target.global_position - player.global_position).normalized()
	if base_direction == Vector2.ZERO:
		base_direction = Vector2.RIGHT

	var count: int = 1 + int(player.projectile_count_bonus)
	var spread_step := 0.13
	for i in range(count):
		var centered_index := float(i) - (float(count) - 1.0) * 0.5
		var direction := base_direction.rotated(centered_index * spread_step)
		_spawn_pulse_projectile(direction)


func _fire_pulse_in_direction(base_direction: Vector2) -> void:
	var count: int = 1 + int(player.projectile_count_bonus)
	var spread_step := 0.13
	for i in range(count):
		var centered_index := float(i) - (float(count) - 1.0) * 0.5
		var direction := base_direction.rotated(centered_index * spread_step)
		_spawn_pulse_projectile(direction)


func _spawn_pulse_projectile(direction: Vector2) -> void:
	if main_ref and main_ref.has_method("can_spawn_player_projectile") and not main_ref.can_spawn_player_projectile():
		return

	var projectile := PROJECTILE_SCRIPT.new()
	projectile.setup(
		player.global_position + direction * 30.0,
		direction,
		player.get_damage(PULSE_BASE_DAMAGE),
		PULSE_SPEED,
		PULSE_RANGE,
		Color(0.0, 0.96, 1.0),
		"enemies",
		main_ref,
		5.5,
		player.pulse_pierce_bonus
	)
	main_ref.projectiles_root.add_child(projectile)

	if main_ref and main_ref.has_node("ParticleFX") and main_ref.particle_fx.has_method("weapon_muzzle"):
		main_ref.particle_fx.weapon_muzzle(player.global_position + direction * 28.0, direction, Color(0.0, 0.96, 1.0))


func _update_orbits(delta: float) -> void:
	refresh_from_player_stats()
	orbit_angle += delta * 3.4
	queue_redraw()

	var count: int = orbital_nodes.size()
	if count <= 0:
		return

	for i in range(count):
		var orbital := orbital_nodes[i]
		if not is_instance_valid(orbital):
			continue

		var angle := orbit_angle + TAU * float(i) / float(count)
		orbital.position = Vector2.from_angle(angle) * ORBIT_RADIUS
		orbital.rotation = angle

		for area in orbital.get_overlapping_areas():
			if area.is_in_group("enemies") and area.has_method("take_damage"):
				var key := "%d:%d" % [i, area.get_instance_id()]
				if not orbital_hit_cooldowns.has(key):
					area.take_damage(player.get_damage(ORBIT_BASE_DAMAGE) * player.orbit_damage_multiplier, player)
					if main_ref and main_ref.has_node("ParticleFX") and _can_emit_orbit_hit_fx():
						main_ref.particle_fx.enemy_hit(area.global_position, Color(1.0, 0.9, 0.1))
						orbit_hit_fx_timer = _orbit_hit_fx_interval()
					orbital_hit_cooldowns[key] = ORBIT_HIT_INTERVAL


func _update_nova(delta: float) -> void:
	nova_timer -= delta
	if nova_timer > 0.0:
		return

	nova_timer = NOVA_BASE_COOLDOWN * player.nova_cooldown_multiplier
	_trigger_nova()


func _trigger_nova() -> void:
	var pulse := Area2D.new()
	pulse.name = "NovaBurstHitbox"
	pulse.collision_layer = 0
	pulse.collision_mask = 2
	pulse.monitoring = true
	pulse.monitorable = false

	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = NOVA_RADIUS
	shape.shape = circle
	pulse.add_child(shape)
	pulse.global_position = player.global_position
	main_ref.projectiles_root.add_child(pulse)

	if main_ref and main_ref.particle_fx:
		main_ref.particle_fx.nova(player.global_position, NOVA_RADIUS, Color(0.2, 1.0, 0.55))
	if main_ref and main_ref.has_method("request_screen_shake"):
		main_ref.request_screen_shake(11.0, 0.2)

	await get_tree().physics_frame
	if not is_instance_valid(pulse):
		return

	for area in pulse.get_overlapping_areas():
		if area.is_in_group("enemies") and area.has_method("take_damage"):
			area.take_damage(player.get_damage(NOVA_BASE_DAMAGE), player)

	pulse.queue_free()


func _create_orbital(index: int) -> Area2D:
	var orbital := Area2D.new()
	orbital.name = "OrbitSpark%d" % index
	orbital.collision_layer = 4
	orbital.collision_mask = 2
	orbital.monitoring = true
	orbital.monitorable = false

	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 10.0
	shape.shape = circle
	orbital.add_child(shape)

	var outline := Line2D.new()
	outline.name = "OrbitSparkOutline"
	outline.closed = true
	outline.width = 2.0
	outline.default_color = Color(1.0, 1.0, 0.88, 1.0)
	outline.points = _orbital_diamond_points(12.0)
	outline.material = _additive_material()
	outline.antialiased = true
	orbital.add_child(outline)

	var glow := Line2D.new()
	glow.name = "OrbitSparkGlow"
	glow.closed = true
	glow.width = 14.0
	glow.default_color = Color(1.0, 0.64, 0.04, 0.20)
	glow.points = _orbital_diamond_points(26.0)
	glow.material = _additive_material()
	glow.antialiased = true
	orbital.add_child(glow)

	var plasma := Line2D.new()
	plasma.name = "OrbitSparkPlasmaGas"
	plasma.closed = true
	plasma.width = 6.2
	plasma.default_color = Color(1.0, 0.92, 0.08, 0.38)
	plasma.points = _orbital_diamond_points(18.0)
	plasma.material = _additive_material()
	plasma.antialiased = true
	orbital.add_child(plasma)

	var slash_a := Line2D.new()
	slash_a.name = "OrbitSparkVectorA"
	slash_a.width = 1.85
	slash_a.default_color = Color.WHITE
	slash_a.points = PackedVector2Array([Vector2(-9.0, 0.0), Vector2(9.0, 0.0)])
	slash_a.material = _additive_material()
	slash_a.antialiased = true
	orbital.add_child(slash_a)

	var slash_b := Line2D.new()
	slash_b.name = "OrbitSparkVectorB"
	slash_b.width = 1.50
	slash_b.default_color = Color(1.0, 1.0, 0.68, 0.92)
	slash_b.points = PackedVector2Array([Vector2(0.0, -9.0), Vector2(0.0, 9.0)])
	slash_b.material = _additive_material()
	slash_b.antialiased = true
	orbital.add_child(slash_b)

	add_child(orbital)
	return orbital


func _draw() -> void:
	var quality := _visual_quality()
	var count := maxi(orbital_nodes.size(), 1)
	var base_color := Color(1.0, 0.88, 0.08, 0.36)
	var orbit_segments := 24
	if quality >= 2:
		orbit_segments = 72
	elif quality == 1:
		orbit_segments = 44
	draw_arc(Vector2.ZERO, ORBIT_RADIUS, 0.0, TAU, orbit_segments, Color(base_color.r, base_color.g, base_color.b, 0.08), 0.8)

	for i in range(count):
		var angle := orbit_angle + TAU * float(i) / float(count)
		var arc_segments := 5
		if quality >= 2:
			arc_segments = 14
		elif quality == 1:
			arc_segments = 9
		if count >= 4:
			arc_segments = maxi(5, arc_segments - 3)
		var glow_width := 3.6 if quality >= 1 else 2.0
		var orbital_position := Vector2.from_angle(angle) * ORBIT_RADIUS
		var tangent := Vector2.from_angle(angle + PI * 0.5)
		if quality >= 1:
			draw_arc(Vector2.ZERO, ORBIT_RADIUS, angle - 0.72, angle + 0.20, arc_segments, Color(1.0, 0.58, 0.02, 0.14), glow_width * 2.5)
		draw_arc(Vector2.ZERO, ORBIT_RADIUS, angle - 0.58, angle + 0.20, arc_segments, Color(1.0, 0.84, 0.06, 0.52), glow_width)
		draw_arc(Vector2.ZERO, ORBIT_RADIUS + 4.0, angle - 0.28, angle + 0.06, maxi(4, arc_segments / 2), Color(1.0, 1.0, 1.0, 0.50), 1.25)
		draw_line(orbital_position - tangent * 18.0, orbital_position + tangent * 16.0, Color(1.0, 0.70, 0.04, 0.30), 7.0 if quality >= 1 else 3.0)
		draw_line(orbital_position - tangent * 10.0, orbital_position + tangent * 11.0, Color.WHITE, 1.35)
		if quality >= 2:
			draw_line(orbital_position - tangent * 4.0 + Vector2.from_angle(angle) * 9.0, orbital_position + tangent * 4.0 - Vector2.from_angle(angle) * 9.0, Color(1.0, 1.0, 0.58, 0.62), 0.85)


func _decay_orbital_hit_cooldowns(delta: float) -> void:
	for key in orbital_hit_cooldowns.keys():
		orbital_hit_cooldowns[key] -= delta
		if orbital_hit_cooldowns[key] <= 0.0:
			orbital_hit_cooldowns.erase(key)


func _orbital_diamond_points(size: float) -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(size, 0.0),
		Vector2(0.0, size),
		Vector2(-size, 0.0),
		Vector2(0.0, -size)
	])


func _additive_material() -> CanvasItemMaterial:
	if additive_material == null:
		additive_material = CanvasItemMaterial.new()
		additive_material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return additive_material


func _can_emit_orbit_hit_fx() -> bool:
	return orbit_hit_fx_timer <= 0.0


func _orbit_hit_fx_interval() -> float:
	match _visual_quality():
		0:
			return ORBIT_HIT_FX_INTERVAL_SWARM
		1:
			return ORBIT_HIT_FX_INTERVAL_MEDIUM
		_:
			return ORBIT_HIT_FX_INTERVAL_FULL


func _visual_quality() -> int:
	if main_ref and main_ref.has_method("get_visual_quality"):
		return main_ref.get_visual_quality()
	return 2
