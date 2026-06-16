extends Node2D

const PLAYER_SCENE := preload("res://scenes/Player.tscn")
const ENEMY_SCENE := preload("res://scenes/Enemy.tscn")
const XP_ORB_SCENE := preload("res://scenes/XPOrb.tscn")
const PROJECTILE_SCRIPT := preload("res://scripts/Projectile.gd")
const INPUT_MAP_CONFIG := preload("res://scripts/InputMapConfig.gd")

const ARENA_SIZE := Vector2(2400.0, 1400.0)
const GRID_SPACING := 96.0
const STAR_COUNT := 72
const DUST_COUNT := 18
const TARGET_REFRESH_INTERVAL := 0.10
const MAX_ENEMIES := 180
const MAX_PROJECTILES := 260
const MAX_XP_ORBS := 240
const VISUAL_QUALITY_FULL := 2
const VISUAL_QUALITY_MEDIUM := 1
const VISUAL_QUALITY_SWARM := 0
const GRID_TIER_MINOR := 0.0
const GRID_TIER_MAJOR := 1.0
const GRID_TIER_AXIS := 2.0
const ARENA_REDRAW_INTERVAL_FULL := 0.033
const ARENA_REDRAW_INTERVAL_MEDIUM := 0.066
const ARENA_REDRAW_INTERVAL_SWARM := 0.15

@onready var world_root: Node2D = $World
@onready var enemies_root: Node2D = $World/Enemies
@onready var projectiles_root: Node2D = $World/Projectiles
@onready var pickups_root: Node2D = $World/Pickups
@onready var enemy_spawner: Node = $EnemySpawner
@onready var upgrade_system: Node = $UpgradeSystem
@onready var particle_fx: Node2D = $ParticleFX
@onready var hud: CanvasLayer = $HUD

var player: CharacterBody2D
var arena_rect := Rect2(-ARENA_SIZE * 0.5, ARENA_SIZE)
var survival_time := 0.0
var kills := 0
var score := 0
var game_over := false
var manual_pause_active := false
var camera: Camera2D
var arena_time := 0.0
var starfield_points: Array[Vector4] = []
var dust_points: Array[Vector4] = []
var vertical_grid_lines: Array[Vector4] = []
var horizontal_grid_lines: Array[Vector4] = []
var grid_node_points: Array[Vector2] = []
var arena_corners: Array[Vector2] = []
var shake_timer := 0.0
var shake_duration := 0.0
var shake_strength := 0.0
var visual_quality := VISUAL_QUALITY_FULL
var _arena_redraw_timer := 0.0
var enemy_count_cache := 0
var projectile_count_cache := 0
var pickup_count_cache := 0
var active_fx_count_cache := 0
var nearest_enemy_cache: Area2D
var nearest_enemy_timer := 0.0
var pending_xp_orbs: Array[Area2D] = []


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	INPUT_MAP_CONFIG.ensure_actions()
	randomize()
	_build_arena_cache()
	_build_backdrop_points()
	_configure_process_modes()
	_spawn_player()
	upgrade_system.upgrade_selected.connect(_on_upgrade_selected)
	enemy_spawner.configure(self, player)
	hud.setup(player, self)
	queue_redraw()


func _process(delta: float) -> void:
	if game_over or get_tree().paused:
		return

	arena_time += delta
	survival_time += delta
	_update_performance_state(delta)
	_update_camera_shake(delta)
	hud.update_match(survival_time, kills, score, enemy_count_cache)
	_arena_redraw_timer -= delta
	if _arena_redraw_timer <= 0.0:
		_arena_redraw_timer = _arena_redraw_interval_for_quality()
		queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if game_over:
		return
	if event.is_action_pressed("pause"):
		if upgrade_system.has_method("is_showing_choices") and upgrade_system.is_showing_choices():
			return
		_set_manual_pause(not manual_pause_active)
		get_viewport().set_input_as_handled()


func _configure_process_modes() -> void:
	world_root.process_mode = Node.PROCESS_MODE_PAUSABLE
	enemies_root.process_mode = Node.PROCESS_MODE_PAUSABLE
	projectiles_root.process_mode = Node.PROCESS_MODE_PAUSABLE
	pickups_root.process_mode = Node.PROCESS_MODE_PAUSABLE
	enemy_spawner.process_mode = Node.PROCESS_MODE_PAUSABLE
	particle_fx.process_mode = Node.PROCESS_MODE_PAUSABLE
	upgrade_system.process_mode = Node.PROCESS_MODE_ALWAYS
	hud.process_mode = Node.PROCESS_MODE_ALWAYS
	z_index = -100
	pickups_root.z_index = 0
	projectiles_root.z_index = 10
	enemies_root.z_index = 20
	world_root.z_index = 0
	particle_fx.z_index = 30


func _build_backdrop_points() -> void:
	starfield_points.clear()
	dust_points.clear()

	for i in range(STAR_COUNT):
		starfield_points.append(Vector4(
			randf_range(arena_rect.position.x, arena_rect.end.x),
			randf_range(arena_rect.position.y, arena_rect.end.y),
			randf_range(0.65, 2.2),
			randf_range(0.0, TAU)
		))

	for i in range(DUST_COUNT):
		dust_points.append(Vector4(
			randf_range(arena_rect.position.x, arena_rect.end.x),
			randf_range(arena_rect.position.y, arena_rect.end.y),
			randf_range(18.0, 44.0),
			randf_range(0.0, TAU)
		))


func _build_arena_cache() -> void:
	vertical_grid_lines.clear()
	horizontal_grid_lines.clear()
	grid_node_points.clear()

	var x := floorf(arena_rect.position.x / GRID_SPACING) * GRID_SPACING
	while x <= arena_rect.end.x:
		vertical_grid_lines.append(Vector4(x, arena_rect.position.y, arena_rect.end.y, _grid_tier_for_position(x)))
		x += GRID_SPACING

	var y := floorf(arena_rect.position.y / GRID_SPACING) * GRID_SPACING
	while y <= arena_rect.end.y:
		horizontal_grid_lines.append(Vector4(y, arena_rect.position.x, arena_rect.end.x, _grid_tier_for_position(y)))
		y += GRID_SPACING

	var step := GRID_SPACING * 4.0
	x = floorf(arena_rect.position.x / step) * step
	while x <= arena_rect.end.x:
		y = floorf(arena_rect.position.y / step) * step
		while y <= arena_rect.end.y:
			grid_node_points.append(Vector2(x, y))
			y += step
		x += step

	arena_corners.clear()
	arena_corners.append(arena_rect.position)
	arena_corners.append(Vector2(arena_rect.end.x, arena_rect.position.y))
	arena_corners.append(arena_rect.end)
	arena_corners.append(Vector2(arena_rect.position.x, arena_rect.end.y))


func _grid_tier_for_position(value: float) -> float:
	if absf(value) < 1.0:
		return GRID_TIER_AXIS
	var grid_index := int(round(absf(value / GRID_SPACING)))
	return GRID_TIER_MAJOR if grid_index % 4 == 0 else GRID_TIER_MINOR


func _draw() -> void:
	_draw_void_background()

	var pulse := sin(arena_time * 0.82) * 0.5 + 0.5
	var grid_alpha := 0.050 + 0.032 * pulse
	if visual_quality == VISUAL_QUALITY_SWARM:
		grid_alpha *= 0.76
	var minor_width := 5.0 if visual_quality > VISUAL_QUALITY_SWARM else 2.2
	var major_width := 8.0 if visual_quality > VISUAL_QUALITY_SWARM else 3.4
	var grid_blue := Color(0.08, 0.46, 1.0, 1.0)
	var grid_violet := Color(0.78, 0.14, 1.0, 1.0)

	for line in vertical_grid_lines:
		if visual_quality == VISUAL_QUALITY_SWARM and line.w == GRID_TIER_MINOR:
			continue
		var is_axis := line.w == GRID_TIER_AXIS
		var is_major := line.w == GRID_TIER_MAJOR
		var color := grid_violet if is_axis else grid_blue
		var line_alpha := grid_alpha * (2.15 if is_axis else 1.35 if is_major else 1.0)
		var glow_width := major_width if is_axis or is_major else minor_width
		_draw_neon_grid_line(Vector2(line.x, line.y), Vector2(line.x, line.z), color, line_alpha, glow_width)

	for line in horizontal_grid_lines:
		if visual_quality == VISUAL_QUALITY_SWARM and line.w == GRID_TIER_MINOR:
			continue
		var is_axis := line.w == GRID_TIER_AXIS
		var is_major := line.w == GRID_TIER_MAJOR
		var color := grid_violet if is_axis else grid_blue
		var line_alpha := grid_alpha * (2.15 if is_axis else 1.35 if is_major else 1.0)
		var glow_width := major_width if is_axis or is_major else minor_width
		_draw_neon_grid_line(Vector2(line.y, line.x), Vector2(line.z, line.x), color, line_alpha, glow_width)

	if visual_quality > VISUAL_QUALITY_SWARM:
		_draw_grid_energy_nodes(pulse)

	_draw_arena_light_border(pulse)


func _draw_void_background() -> void:
	draw_rect(arena_rect.grow(320.0), Color(0.0, 0.0, 0.0, 1.0), true)
	draw_rect(arena_rect, Color(0.0, 0.001, 0.008, 1.0), true)

	if visual_quality > VISUAL_QUALITY_SWARM:
		for dust in dust_points:
			var drift := Vector2(cos(arena_time * 0.11 + dust.w), sin(arena_time * 0.13 + dust.w)) * 8.0
			var alpha := 0.010 + 0.012 * (sin(arena_time * 0.7 + dust.w) * 0.5 + 0.5)
			draw_circle(Vector2(dust.x, dust.y) + drift, dust.z, Color(0.26, 0.08, 0.88, alpha))

	var star_stride := 2 if visual_quality == VISUAL_QUALITY_SWARM else 1
	for i in range(0, starfield_points.size(), star_stride):
		var star := starfield_points[i]
		var twinkle := 0.10 + 0.16 * (sin(arena_time * 1.7 + star.w) * 0.5 + 0.5)
		var point := Vector2(star.x, star.y)
		var color := Color(0.34, 0.86, 1.0, twinkle)
		draw_circle(point, star.z, color)
		if star.z > 1.7 and visual_quality > VISUAL_QUALITY_SWARM:
			draw_line(point + Vector2(-star.z * 2.4, 0.0), point + Vector2(star.z * 2.4, 0.0), Color(1.0, 0.16, 0.92, twinkle * 0.20), 1.0)


func _draw_neon_grid_line(start: Vector2, end: Vector2, color: Color, alpha: float, glow_width: float) -> void:
	if visual_quality == VISUAL_QUALITY_SWARM:
		draw_line(start, end, Color(color.r, color.g, color.b, alpha * 0.48), maxf(1.0, glow_width * 0.42))
		draw_line(start, end, Color(0.78, 0.95, 1.0, alpha * 0.14), 1.0)
		return

	draw_line(start, end, Color(color.r, color.g, color.b, alpha * 0.26), glow_width)
	draw_line(start, end, Color(color.r, color.g, color.b, alpha * 0.70), maxf(1.0, glow_width * 0.34))
	draw_line(start, end, Color(0.78, 0.95, 1.0, alpha * 0.18), 1.0)


func _draw_grid_energy_nodes(pulse: float) -> void:
	var node_alpha := 0.050 + 0.032 * pulse
	for point in grid_node_points:
		var flicker := sin(arena_time * 2.2 + point.x * 0.012 + point.y * 0.017) * 0.5 + 0.5
		var alpha := node_alpha * (0.45 + flicker * 0.55)
		draw_circle(point, 4.0 + flicker * 2.5, Color(0.0, 0.88, 1.0, alpha * 0.35))
		draw_line(point + Vector2(-7.0, 0.0), point + Vector2(7.0, 0.0), Color(0.78, 0.12, 1.0, alpha), 1.0)
		draw_line(point + Vector2(0.0, -7.0), point + Vector2(0.0, 7.0), Color(0.08, 0.82, 1.0, alpha), 1.0)


func _draw_arena_light_border(pulse: float) -> void:
	var hot := Color(0.86, 1.0, 1.0, 0.92)
	var cyan := Color(0.0, 0.92, 1.0, 0.16 + 0.08 * pulse)
	var magenta := Color(1.0, 0.06, 0.86, 0.18 + 0.06 * pulse)
	if visual_quality > VISUAL_QUALITY_SWARM:
		draw_rect(arena_rect.grow(30.0), cyan, false, 10.0)
		draw_rect(arena_rect.grow(12.0), magenta, false, 5.0)
	else:
		draw_rect(arena_rect.grow(18.0), cyan, false, 4.0)
	draw_rect(arena_rect, hot, false, 1.4)
	if visual_quality > VISUAL_QUALITY_SWARM:
		draw_rect(arena_rect.grow(-8.0), Color(0.0, 0.90, 1.0, 0.46), false, 1.0)

	var corner_length := 96.0
	for corner in arena_corners:
		var sx := 1.0 if corner.x < arena_rect.get_center().x else -1.0
		var sy := 1.0 if corner.y < arena_rect.get_center().y else -1.0
		draw_line(corner, corner + Vector2(corner_length * sx, 0.0), Color.WHITE, 2.0)
		draw_line(corner, corner + Vector2(0.0, corner_length * sy), Color.WHITE, 2.0)
		if visual_quality > VISUAL_QUALITY_SWARM:
			draw_line(corner, corner + Vector2(corner_length * sx, 0.0), Color(0.0, 0.94, 1.0, 0.60), 5.0)
			draw_line(corner, corner + Vector2(0.0, corner_length * sy), Color(1.0, 0.06, 0.86, 0.54), 5.0)


func _spawn_player() -> void:
	player = PLAYER_SCENE.instantiate()
	world_root.add_child(player)
	player.global_position = Vector2.ZERO
	player.configure(self)
	player.leveled_up.connect(_on_player_leveled_up)
	player.died.connect(_on_player_died)

	camera = Camera2D.new()
	camera.name = "Camera2D"
	camera.zoom = Vector2(0.86, 0.86)
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 9.0
	player.add_child(camera)
	camera.make_current()


func get_arena_rect() -> Rect2:
	return arena_rect


func clamp_to_arena(point: Vector2, margin: float = 24.0) -> Vector2:
	return Vector2(
		clampf(point.x, arena_rect.position.x + margin, arena_rect.end.x - margin),
		clampf(point.y, arena_rect.position.y + margin, arena_rect.end.y - margin)
	)


func spawn_enemy(enemy_type: String, spawn_position: Vector2) -> void:
	if game_over:
		return
	if enemies_root.get_child_count() >= MAX_ENEMIES:
		return

	var enemy := ENEMY_SCENE.instantiate()
	enemies_root.add_child(enemy)
	enemy.global_position = clamp_to_arena(spawn_position, 32.0)
	enemy.configure(enemy_type, player, self, survival_time)
	enemy.died.connect(_on_enemy_died)


func spawn_xp_orb(spawn_position: Vector2, value: int) -> void:
	if pickups_root.get_child_count() + pending_xp_orbs.size() >= MAX_XP_ORBS:
		_merge_xp_into_existing_orb(spawn_position, value)
		return

	var orb := XP_ORB_SCENE.instantiate()
	orb.global_position = spawn_position
	if orb.has_method("set_main_ref"):
		orb.set_main_ref(self)
	orb.configure(value)
	pending_xp_orbs.append(orb)
	call_deferred("_add_pending_xp_orb", orb)


func _add_pending_xp_orb(orb: Area2D) -> void:
	pending_xp_orbs.erase(orb)
	if is_instance_valid(orb):
		pickups_root.add_child(orb)


func _merge_xp_into_existing_orb(spawn_position: Vector2, value: int) -> void:
	var nearest: Area2D = null
	var best_distance := INF

	for child in pickups_root.get_children():
		if not is_instance_valid(child):
			continue
		if not child.has_method("add_value"):
			continue

		var distance_sq := spawn_position.distance_squared_to(child.global_position)
		if distance_sq < best_distance:
			best_distance = distance_sq
			nearest = child

	for pending_orb in pending_xp_orbs:
		if not is_instance_valid(pending_orb):
			continue
		if not pending_orb.has_method("add_value"):
			continue

		var distance_sq := spawn_position.distance_squared_to(pending_orb.global_position)
		if distance_sq < best_distance:
			best_distance = distance_sq
			nearest = pending_orb

	if nearest and nearest.has_method("add_value"):
		nearest.call_deferred("add_value", value)
	else:
		var orb := XP_ORB_SCENE.instantiate()
		orb.global_position = spawn_position
		if orb.has_method("set_main_ref"):
			orb.set_main_ref(self)
		orb.configure(value)
		pending_xp_orbs.append(orb)
		call_deferred("_add_pending_xp_orb", orb)


func spawn_enemy_projectile(origin: Vector2, direction: Vector2, damage: float, speed: float, color: Color) -> void:
	if projectiles_root.get_child_count() >= MAX_PROJECTILES:
		return

	var projectile := PROJECTILE_SCRIPT.new()
	projectile.setup(origin, direction, damage, speed, 950.0, color, "player", self, 6.0, 0)
	projectiles_root.add_child(projectile)


func spawn_enemy_blast(origin: Vector2, blast_radius: float, damage: float, color: Color) -> void:
	var blast := Area2D.new()
	blast.name = "EnemyBlastHitbox"
	blast.collision_layer = 0
	blast.collision_mask = 1
	blast.monitoring = true
	blast.monitorable = false

	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = blast_radius
	shape.shape = circle
	blast.add_child(shape)
	blast.global_position = origin
	projectiles_root.add_child(blast)

	particle_fx.nova(origin, blast_radius, color)
	request_screen_shake(9.0, 0.16)

	await get_tree().physics_frame
	if not is_instance_valid(blast):
		return

	for body in blast.get_overlapping_bodies():
		if body.is_in_group("player") and body.has_method("take_damage"):
			body.take_damage(damage)

	blast.queue_free()


func find_nearest_enemy(from_position: Vector2) -> Area2D:
	if is_instance_valid(nearest_enemy_cache) and player and from_position.distance_squared_to(player.global_position) < 9.0:
		return nearest_enemy_cache

	var nearest: Area2D = null
	var best_distance := INF

	for child in enemies_root.get_children():
		if not is_instance_valid(child):
			continue
		if not child.has_method("is_alive") or not child.is_alive():
			continue

		var distance_sq := from_position.distance_squared_to(child.global_position)
		if distance_sq < best_distance:
			best_distance = distance_sq
			nearest = child

	return nearest


func _on_enemy_died(enemy: Area2D, death_position: Vector2, xp_value: int, color: Color) -> void:
	kills += 1
	score += xp_value * 10
	spawn_xp_orb(death_position, xp_value)
	particle_fx.explosion(death_position, color, 52, 1.12 + float(xp_value) * 0.08)
	if xp_value >= 5:
		request_screen_shake(3.5 + float(xp_value) * 0.45, 0.13)
	hud.update_match(survival_time, kills, score, enemy_count_cache)


func _on_player_leveled_up(level: int) -> void:
	if game_over:
		return

	manual_pause_active = false
	hud.show_pause(false)
	hud.show_level_flash()
	particle_fx.level_up_burst(player.global_position)
	request_screen_shake(8.0, 0.18)
	get_tree().paused = true
	upgrade_system.show_choices(player, level)


func _on_upgrade_selected(upgrade: Dictionary) -> void:
	player.apply_upgrade(upgrade)
	get_tree().paused = false
	player.complete_level_up_choice()


func _on_player_died() -> void:
	game_over = true
	manual_pause_active = false
	get_tree().paused = false
	enemy_spawner.set_process(false)
	particle_fx.player_death(player.global_position)
	request_screen_shake(18.0, 0.38)
	hud.show_pause(false)
	hud.show_game_over(survival_time, kills, score)


func _set_manual_pause(paused: bool) -> void:
	manual_pause_active = paused
	get_tree().paused = paused
	if paused and camera:
		camera.offset = Vector2.ZERO
	hud.show_pause(paused)


func request_screen_shake(strength: float, duration: float) -> void:
	if get_tree().paused:
		return

	if visual_quality == VISUAL_QUALITY_SWARM:
		strength *= 0.65
		duration *= 0.8

	shake_strength = maxf(shake_strength, strength)
	shake_duration = maxf(shake_duration, duration)
	shake_timer = maxf(shake_timer, duration)


func _update_camera_shake(delta: float) -> void:
	if not camera:
		return

	if shake_timer <= 0.0:
		camera.offset = Vector2.ZERO
		return

	shake_timer = maxf(0.0, shake_timer - delta)
	var progress := shake_timer / maxf(shake_duration, 0.001)
	var amount := shake_strength * progress * progress
	camera.offset = Vector2(randf_range(-amount, amount), randf_range(-amount, amount))

	if shake_timer <= 0.0:
		shake_strength = 0.0
		shake_duration = 0.0
		camera.offset = Vector2.ZERO


func _update_performance_state(delta: float) -> void:
	enemy_count_cache = enemies_root.get_child_count()
	projectile_count_cache = projectiles_root.get_child_count()
	pickup_count_cache = pickups_root.get_child_count() + pending_xp_orbs.size()
	active_fx_count_cache = particle_fx.get_active_effect_count() if particle_fx.has_method("get_active_effect_count") else particle_fx.get_child_count()

	var previous_quality := visual_quality
	if enemy_count_cache >= 115 or active_fx_count_cache >= 70 or projectile_count_cache >= 210 or pickup_count_cache >= 205:
		visual_quality = VISUAL_QUALITY_SWARM
	elif enemy_count_cache >= 65 or active_fx_count_cache >= 42 or projectile_count_cache >= 145 or pickup_count_cache >= 135:
		visual_quality = VISUAL_QUALITY_MEDIUM
	else:
		visual_quality = VISUAL_QUALITY_FULL

	if visual_quality != previous_quality:
		_arena_redraw_timer = 0.0
		queue_redraw()

	if particle_fx.has_method("set_visual_quality"):
		particle_fx.set_visual_quality(visual_quality)

	nearest_enemy_timer -= delta
	if nearest_enemy_timer <= 0.0 or not is_instance_valid(nearest_enemy_cache):
		nearest_enemy_cache = _scan_nearest_enemy(player.global_position) if player else null
		nearest_enemy_timer = TARGET_REFRESH_INTERVAL


func get_visual_quality() -> int:
	return visual_quality


func _arena_redraw_interval_for_quality() -> float:
	match visual_quality:
		VISUAL_QUALITY_SWARM:
			return ARENA_REDRAW_INTERVAL_SWARM
		VISUAL_QUALITY_MEDIUM:
			return ARENA_REDRAW_INTERVAL_MEDIUM
		_:
			return ARENA_REDRAW_INTERVAL_FULL


func get_enemy_count() -> int:
	return enemy_count_cache


func can_spawn_player_projectile() -> bool:
	return projectiles_root.get_child_count() < MAX_PROJECTILES


func can_spawn_enemy() -> bool:
	return enemies_root.get_child_count() < MAX_ENEMIES


func _scan_nearest_enemy(from_position: Vector2) -> Area2D:
	var nearest: Area2D = null
	var best_distance := INF

	for child in enemies_root.get_children():
		if not is_instance_valid(child):
			continue
		if not child.has_method("is_alive") or not child.is_alive():
			continue

		var distance_sq := from_position.distance_squared_to(child.global_position)
		if distance_sq < best_distance:
			best_distance = distance_sq
			nearest = child

	return nearest
