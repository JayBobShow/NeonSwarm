extends Node3D

const ARENA_HALF_SIZE := 22.0
const STRESS_ENEMY_COUNT := 150
const STRESS_XP_COUNT := 240
const STRESS_PROJECTILE_COUNT := 60
const SPARK_POOL_COUNT := 96
const TRAIL_SEGMENT_COUNT := 7
const QUALITY_FULL := 2
const QUALITY_MEDIUM := 1
const QUALITY_SWARM := 0

var _time := 0.0
var _stress_logged := false
var _quality_mode := QUALITY_FULL
var _materials: Dictionary = {}
var _meshes: Dictionary = {}

var _player_root: Node3D
var _player_shell: Node3D
var _player_position := Vector3.ZERO
var _trail_segments: Array[MeshInstance3D] = []
var _trail_points: Array[Vector3] = []

var _enemy_batches: Dictionary = {}
var _enemy_nodes: Dictionary = {}
var _xp_data: Array[Dictionary] = []
var _xp_nodes: Dictionary = {}
var _projectile_data: Array[Dictionary] = []
var _projectile_nodes: Dictionary = {}
var _spark_nodes: Dictionary = {}
var _spark_dirs: Array[Vector3] = []
var _spark_speeds: Array[float] = []
var _nova_ring: MeshInstance3D


func _ready() -> void:
	name = "NeonSwarm3DVisualPrototype"
	_create_materials()
	_create_shared_meshes()
	_setup_world_environment()
	_create_camera()
	_create_arena()
	_create_player_visual()
	_create_enemy_batches()
	_create_xp_batches()
	_create_projectile_batches()
	_create_spark_batch()
	_create_nova_sample()
	_update_quality_mode()
	_update_all_visuals(0.0)
	print("Neon Swarm 3D true-object prototype: enemies=%d xp_orbs=%d projectiles=%d sparks=%d nodes=%d quality=%s" % [STRESS_ENEMY_COUNT, STRESS_XP_COUNT, STRESS_PROJECTILE_COUNT, SPARK_POOL_COUNT, _count_visual_nodes(self), _quality_label()])


func _process(delta: float) -> void:
	_time += delta
	_update_quality_mode()
	_animate_player(delta)
	_update_all_visuals(delta)
	if not _stress_logged and _time >= 2.0:
		_stress_logged = true
		print(get_stress_summary())


func get_stress_summary() -> String:
	return "Phase 2.6B true 3D stress summary: enemies=%d xp_orbs=%d projectiles=%d spark_pool=%d total_visual_nodes=%d quality=%s" % [
		STRESS_ENEMY_COUNT,
		STRESS_XP_COUNT,
		STRESS_PROJECTILE_COUNT,
		SPARK_POOL_COUNT,
		_count_visual_nodes(self),
		_quality_label()
	]


func get_node_audit() -> Dictionary:
	return {
		"player_visual_nodes": _count_visual_nodes(_player_root),
		"enemy_visual_nodes": _count_batch_nodes(_enemy_nodes),
		"xp_visual_nodes": _count_batch_nodes(_xp_nodes),
		"projectile_visual_nodes": _count_batch_nodes(_projectile_nodes),
		"spark_vfx_nodes": _count_batch_nodes(_spark_nodes) + (1 if is_instance_valid(_nova_ring) else 0),
		"arena_grid_nodes": get_node_or_null("OptimizedArena").get_child_count() + 1 if has_node("OptimizedArena") else 0,
		"lighting_camera_world_nodes": 2,
		"total_visual_nodes": _count_visual_nodes(self),
		"quality_mode": _quality_label()
	}


func _create_materials() -> void:
	_materials["white_hot"] = _make_emissive_material(Color(1.0, 0.98, 0.90, 1.0), 8.4, false)
	_materials["soft_white"] = _make_emissive_material(Color(0.90, 0.96, 1.0, 0.76), 3.6, true)
	_materials["player_body"] = _make_emissive_material(Color(0.03, 0.76, 1.0, 0.96), 5.8, true)
	_materials["player_shell"] = _make_emissive_material(Color(0.0, 0.80, 1.0, 0.20), 2.6, true)
	_materials["player_magenta"] = _make_emissive_material(Color(1.0, 0.03, 0.94, 0.98), 5.3, true)
	_materials["chaser_body_near"] = _make_emissive_material(Color(0.08, 1.0, 0.42, 0.90), 3.6, true)
	_materials["chaser_body_far"] = _make_emissive_material(Color(0.04, 0.62, 0.28, 0.58), 1.45, true)
	_materials["chaser_shell"] = _make_emissive_material(Color(0.12, 1.0, 0.48, 0.13), 1.7, true)
	_materials["tank_body_near"] = _make_emissive_material(Color(1.0, 0.42, 0.06, 0.88), 3.4, true)
	_materials["tank_body_far"] = _make_emissive_material(Color(0.70, 0.25, 0.04, 0.54), 1.35, true)
	_materials["tank_shell"] = _make_emissive_material(Color(1.0, 0.36, 0.06, 0.12), 1.5, true)
	_materials["shooter_body_near"] = _make_emissive_material(Color(0.70, 0.18, 1.0, 0.90), 3.5, true)
	_materials["shooter_body_far"] = _make_emissive_material(Color(0.42, 0.08, 0.72, 0.56), 1.38, true)
	_materials["shooter_shell"] = _make_emissive_material(Color(0.66, 0.12, 1.0, 0.14), 1.6, true)
	_materials["exploder_body_near"] = _make_emissive_material(Color(1.0, 0.10, 0.18, 0.88), 3.9, true)
	_materials["exploder_body_far"] = _make_emissive_material(Color(0.76, 0.06, 0.11, 0.58), 1.55, true)
	_materials["exploder_shell"] = _make_emissive_material(Color(1.0, 0.10, 0.08, 0.16), 1.9, true)
	_materials["xp_core"] = _make_emissive_material(Color(1.0, 0.96, 0.36, 0.92), 4.2, true)
	_materials["xp_shell"] = _make_emissive_material(Color(1.0, 0.82, 0.12, 0.15), 1.35, true)
	_materials["xp_cyan"] = _make_emissive_material(Color(0.0, 0.72, 1.0, 0.54), 1.7, true)
	_materials["projectile_body"] = _make_emissive_material(Color(0.02, 0.86, 1.0, 0.92), 5.5, true)
	_materials["projectile_core"] = _make_emissive_material(Color(1.0, 0.98, 0.86, 1.0), 7.6, false)
	_materials["projectile_trail"] = _make_emissive_material(Color(0.0, 0.70, 1.0, 0.18), 2.2, true)
	_materials["spark_vfx"] = _make_emissive_material(Color(1.0, 0.78, 0.18, 0.80), 3.0, true)
	_materials["nova_ring"] = _make_emissive_material(Color(0.10, 1.0, 0.62, 0.35), 3.2, true)
	_materials["grid_minor"] = _make_emissive_material(Color(0.03, 0.17, 0.42, 0.22), 0.62, true)
	_materials["grid_major"] = _make_emissive_material(Color(0.09, 0.36, 0.80, 0.34), 0.95, true)
	_materials["grid_axis"] = _make_emissive_material(Color(0.42, 0.12, 0.78, 0.42), 1.18, true)
	_materials["border_cyan"] = _make_emissive_material(Color(0.03, 0.62, 0.95, 0.66), 1.65, true)
	for i in range(TRAIL_SEGMENT_COUNT):
		var alpha := lerpf(0.22, 0.035, float(i) / float(TRAIL_SEGMENT_COUNT - 1))
		_materials["trail_%d" % i] = _make_emissive_material(Color(0.0, 0.92, 1.0, alpha), 2.1, true)


func _make_emissive_material(color: Color, energy: float, transparent: bool) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = Color(color.r, color.g, color.b, 1.0)
	material.emission_energy_multiplier = energy
	if transparent or color.a < 0.99:
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
		material.no_depth_test = true
	return material


func _create_shared_meshes() -> void:
	_meshes["player_body"] = _octahedron_mesh(0.92)
	_meshes["player_shell"] = _sphere_mesh(0.92, 20, 10)
	_meshes["sphere_core"] = _sphere_mesh(0.18, 16, 8)
	_meshes["sphere_shell"] = _sphere_mesh(0.75, 16, 8)
	_meshes["chaser_body"] = _tetrahedron_arrow_mesh()
	_meshes["tank_body"] = _box_mesh(Vector3(0.88, 0.78, 0.88))
	_meshes["shooter_body"] = _octahedron_mesh(0.82)
	_meshes["shooter_muzzle"] = _capsule_mesh(0.075, 0.58, 8, 4)
	_meshes["exploder_body"] = _sphere_mesh(0.62, 16, 8)
	_meshes["exploder_ring"] = _torus_mesh(0.72, 0.055, 32, 6)
	_meshes["xp_body"] = _sphere_mesh(0.30, 14, 7)
	_meshes["xp_shell"] = _sphere_mesh(0.54, 12, 6)
	_meshes["xp_ring"] = _torus_mesh(0.43, 0.028, 28, 6)
	_meshes["projectile_body"] = _capsule_mesh(0.120, 0.86, 10, 4)
	_meshes["projectile_core"] = _capsule_mesh(0.052, 0.70, 8, 3)
	_meshes["projectile_trail"] = _capsule_mesh(0.070, 1.10, 8, 3)
	_meshes["spark"] = _sphere_mesh(0.055, 8, 4)


func _setup_world_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.001, 0.002, 0.009, 1.0)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.015, 0.028, 0.060, 1.0)
	environment.ambient_light_energy = 0.22
	environment.glow_enabled = true
	environment.glow_intensity = 1.22
	environment.glow_strength = 1.52
	environment.glow_bloom = 0.34
	environment.glow_hdr_threshold = 0.16
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.08
	world_environment.environment = environment
	add_child(world_environment)


func _create_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "PrototypeCamera"
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 43.0
	camera.position = Vector3(0.0, 33.0, 24.0)
	camera.current = true
	add_child(camera)
	camera.look_at(Vector3.ZERO, Vector3.UP)


func _create_arena() -> void:
	var arena := Node3D.new()
	arena.name = "OptimizedArena"
	add_child(arena)
	_create_grid_mesh(arena, "BatchedNeonGrid", _materials["grid_minor"], _materials["grid_major"], _materials["grid_axis"])
	var y := 0.025
	var a := ARENA_HALF_SIZE
	var points: Array = [Vector3(-a, y, -a), Vector3(a, y, -a), Vector3(a, y, a), Vector3(-a, y, a)]
	var edges: Array = [[0, 1], [1, 2], [2, 3], [3, 0]]
	_add_mesh_instance(arena, "ArenaBorderSolidGlow", _tube_edge_mesh(points, edges, 0.125, 8), _materials["border_cyan"])
	_add_mesh_instance(arena, "ArenaBorderWhiteCore", _tube_edge_mesh(points, edges, 0.046, 8), _materials["soft_white"])


func _create_grid_mesh(parent: Node3D, mesh_name: String, minor_material: Material, major_material: Material, axis_material: Material) -> void:
	var minor := ImmediateMesh.new()
	var major := ImmediateMesh.new()
	var axis := ImmediateMesh.new()
	_build_grid_surface(minor, 1.0, minor_material, false)
	_build_grid_surface(major, 4.0, major_material, false)
	_build_grid_surface(axis, ARENA_HALF_SIZE, axis_material, true)
	_add_mesh_instance(parent, mesh_name + "Minor", minor, null)
	_add_mesh_instance(parent, mesh_name + "Major", major, null)
	_add_mesh_instance(parent, mesh_name + "Axis", axis, null)


func _build_grid_surface(mesh: ImmediateMesh, spacing: float, material: Material, axis_only: bool) -> void:
	mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	var y := -0.015
	if axis_only:
		mesh.surface_add_vertex(Vector3(-ARENA_HALF_SIZE, y, 0.0))
		mesh.surface_add_vertex(Vector3(ARENA_HALF_SIZE, y, 0.0))
		mesh.surface_add_vertex(Vector3(0.0, y, -ARENA_HALF_SIZE))
		mesh.surface_add_vertex(Vector3(0.0, y, ARENA_HALF_SIZE))
	else:
		var steps := int((ARENA_HALF_SIZE * 2.0) / spacing)
		for i in range(steps + 1):
			var offset := -ARENA_HALF_SIZE + float(i) * spacing
			if absf(offset) < 0.001:
				continue
			mesh.surface_add_vertex(Vector3(-ARENA_HALF_SIZE, y, offset))
			mesh.surface_add_vertex(Vector3(ARENA_HALF_SIZE, y, offset))
			mesh.surface_add_vertex(Vector3(offset, y, -ARENA_HALF_SIZE))
			mesh.surface_add_vertex(Vector3(offset, y, ARENA_HALF_SIZE))
	mesh.surface_end()


func _create_player_visual() -> void:
	_player_root = Node3D.new()
	_player_root.name = "PlayerTrue3DNeonCore"
	_player_position = Vector3(0.0, 0.85, 3.2)
	_player_root.position = _player_position
	add_child(_player_root)

	_player_shell = Node3D.new()
	_player_shell.name = "PlayerRotating3DShell"
	_player_root.add_child(_player_shell)

	var body := _add_mesh_instance(_player_root, "PlayerOctahedronBody", _meshes["player_body"], _materials["player_body"])
	body.scale = Vector3.ONE * 1.18
	var aura := _add_mesh_instance(_player_root, "PlayerTransparentPlasmaShell", _meshes["player_shell"], _materials["player_shell"])
	aura.scale = Vector3.ONE * 1.62
	var core := _add_mesh_instance(_player_root, "PlayerWhiteHotCenter", _meshes["sphere_core"], _materials["white_hot"])
	core.scale = Vector3.ONE * 1.95
	_add_mesh_instance(_player_shell, "PlayerCyanShieldTorus", _torus_mesh(1.10, 0.064, 48, 8), _materials["player_body"]).rotation.x = PI * 0.5
	_add_mesh_instance(_player_shell, "PlayerMagentaShieldTorus", _torus_mesh(1.38, 0.052, 48, 8), _materials["player_magenta"]).rotation.y = PI * 0.5

	for i in range(TRAIL_SEGMENT_COUNT):
		var segment := _create_tube_instance(self, _player_position, _player_position + Vector3(0.1, 0.0, 0.0), 0.050 * (1.0 - float(i) * 0.070), _materials["trail_%d" % i], "PlayerGhostTrail")
		_trail_segments.append(segment)
		_trail_points.append(_player_position)
	_trail_points.append(_player_position)


func _create_enemy_batches() -> void:
	_enemy_batches.clear()
	for enemy_type in ["chaser", "tank", "shooter", "exploder"]:
		for tier in ["near", "far"]:
			_enemy_batches[_enemy_batch_key(enemy_type, tier)] = {
				"enemy_type": enemy_type,
				"tier": tier,
				"positions": [],
				"scales": [],
				"speeds": [],
				"phases": []
			}

	var columns := 15
	for i in range(STRESS_ENEMY_COUNT):
		var enemy_type: String = ["chaser", "tank", "shooter", "exploder"][i % 4]
		var col := i % columns
		var row := i / columns
		var x := -19.6 + float(col) * 2.9
		var z := -16.4 + float(row) * 2.9
		var scale := _enemy_base_scale(enemy_type)
		if i < 4:
			x = [-9.3, -3.1, 3.1, 9.3][i]
			z = -4.8
			scale = _enemy_showcase_scale(enemy_type)
		var position := Vector3(x, 0.80, z)
		var tier := "near" if position.distance_to(_player_position) <= 9.0 or i < 4 else "far"
		var key := _enemy_batch_key(enemy_type, tier)
		_enemy_batches[key]["positions"].append(position)
		_enemy_batches[key]["scales"].append(scale)
		_enemy_batches[key]["speeds"].append(0.30 + randf() * 0.38)
		_enemy_batches[key]["phases"].append(randf() * TAU)

	for key in _enemy_batches.keys():
		var batch: Dictionary = _enemy_batches[key]
		var enemy_type: String = batch["enemy_type"]
		var tier: String = batch["tier"]
		var count: int = batch["positions"].size()
		var nodes := {
			"body": _create_multimesh("Enemy%sBodyBatch" % key.capitalize(), _meshes["%s_body" % enemy_type], _enemy_body_material(enemy_type, tier), count),
			"shell": _create_multimesh("Enemy%sPlasmaShellBatch" % key.capitalize(), _enemy_shell_mesh(enemy_type), _enemy_shell_material(enemy_type), count),
			"core": _create_multimesh("Enemy%sWhiteHotCoreBatch" % key.capitalize(), _meshes["sphere_core"], _enemy_core_material(tier), count)
		}
		if enemy_type == "shooter":
			nodes["muzzle"] = _create_multimesh("Enemy%sMuzzleBatch" % key.capitalize(), _meshes["shooter_muzzle"], _materials["projectile_core"], count)
		if enemy_type == "exploder":
			nodes["ring"] = _create_multimesh("Enemy%sWarningTorusBatch" % key.capitalize(), _meshes["exploder_ring"], _materials["exploder_body_near"] if tier == "near" else _materials["exploder_body_far"], count)
		_enemy_nodes[key] = nodes


func _create_xp_batches() -> void:
	for i in range(STRESS_XP_COUNT):
		var angle := TAU * float(i) / float(STRESS_XP_COUNT)
		var ring := 7.0 + float(i % 7) * 2.05
		var pos := Vector3(cos(angle) * ring, 0.58, sin(angle) * ring + 4.2)
		if pos.distance_to(_player_position) < 3.0:
			pos += Vector3(3.0, 0.0, -2.0)
		_xp_data.append({
			"position": pos,
			"scale": 0.34 + float(i % 4) * 0.032,
			"phase": randf() * TAU,
			"speed": 1.0 + randf() * 1.3
		})
	_xp_nodes = {
		"shell": _create_multimesh("XPTransparentEnergyShellBatch", _meshes["xp_shell"], _materials["xp_shell"], STRESS_XP_COUNT),
		"body": _create_multimesh("XPSolidEnergyBodyBatch", _meshes["xp_body"], _materials["xp_core"], STRESS_XP_COUNT),
		"ring": _create_multimesh("XPRotatingTorusBatch", _meshes["xp_ring"], _materials["xp_cyan"], STRESS_XP_COUNT),
		"spark": _create_multimesh("XPOrbitSparkBatch", _meshes["spark"], _materials["soft_white"], STRESS_XP_COUNT)
	}


func _create_projectile_batches() -> void:
	for i in range(STRESS_PROJECTILE_COUNT):
		_projectile_data.append({
			"position": Vector3(-19.0 + float(i % 10) * 4.2, 0.82, 13.0 + float(i / 10) * 1.2),
			"yaw": randf() * TAU,
			"speed": 3.0 + randf() * 2.5,
			"lane": i
		})
	_projectile_nodes = {
		"trail": _create_multimesh("ProjectilePlasmaTrailBatch", _meshes["projectile_trail"], _materials["projectile_trail"], STRESS_PROJECTILE_COUNT),
		"body": _create_multimesh("ProjectileSolidBoltBatch", _meshes["projectile_body"], _materials["projectile_body"], STRESS_PROJECTILE_COUNT),
		"core": _create_multimesh("ProjectileWhiteHotCoreBatch", _meshes["projectile_core"], _materials["projectile_core"], STRESS_PROJECTILE_COUNT)
	}


func _create_spark_batch() -> void:
	for i in range(SPARK_POOL_COUNT):
		_spark_dirs.append(Vector3(randf_range(-1.0, 1.0), randf_range(-0.08, 0.85), randf_range(-1.0, 1.0)).normalized())
		_spark_speeds.append(randf_range(1.7, 5.8))
	_spark_nodes = {
		"sparks": _create_multimesh("PooledPlasmaSparkSphereBatch", _meshes["spark"], _materials["spark_vfx"], SPARK_POOL_COUNT)
	}


func _create_nova_sample() -> void:
	_nova_ring = _add_mesh_instance(self, "Nova3DExpandingTorusSample", _torus_mesh(1.0, 0.045, 64, 8), _materials["nova_ring"])
	_nova_ring.position = Vector3(5.4, 0.08, 6.0)
	_nova_ring.rotation.x = PI * 0.5


func _create_multimesh(node_name: String, mesh: Mesh, material: Material, count: int) -> MultiMeshInstance3D:
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = mesh
	multimesh.instance_count = count
	var instance := MultiMeshInstance3D.new()
	instance.name = node_name
	instance.multimesh = multimesh
	instance.material_override = material
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(instance)
	return instance


func _update_quality_mode() -> void:
	var load := STRESS_ENEMY_COUNT + STRESS_XP_COUNT + STRESS_PROJECTILE_COUNT
	if load >= 420:
		_quality_mode = QUALITY_SWARM
	elif load >= 260:
		_quality_mode = QUALITY_MEDIUM
	else:
		_quality_mode = QUALITY_FULL

	if not _xp_nodes.is_empty():
		_xp_nodes["spark"].visible = _quality_mode >= QUALITY_FULL
	if not _enemy_nodes.is_empty():
		for key in _enemy_nodes.keys():
			var batch: Dictionary = _enemy_batches[key]
			var tier: String = batch["tier"]
			_enemy_nodes[key]["shell"].visible = tier == "near" or _quality_mode >= QUALITY_MEDIUM


func _update_all_visuals(delta: float) -> void:
	_update_enemy_batches()
	_update_xp_batches()
	_update_projectile_batches(delta)
	_update_spark_batch()
	_update_nova_sample()


func _animate_player(delta: float) -> void:
	var previous := _player_position
	_player_position = Vector3(sin(_time * 0.55) * 1.25, 0.85, 3.2 + cos(_time * 0.48) * 0.75)
	_player_root.position = _player_position
	_player_root.rotation.y = sin(_time * 0.8) * 0.24
	_player_shell.rotation.y += delta * 1.45
	_player_shell.rotation.x = sin(_time * 1.2) * 0.18
	_trail_points.push_front(previous)
	while _trail_points.size() > TRAIL_SEGMENT_COUNT + 1:
		_trail_points.pop_back()
	for i in range(_trail_segments.size()):
		var start: Vector3 = _trail_points[min(i, _trail_points.size() - 1)]
		var end: Vector3 = _trail_points[min(i + 1, _trail_points.size() - 1)]
		_update_tube(_trail_segments[i], start, end, 0.060 * (1.0 - float(i) * 0.070))


func _update_enemy_batches() -> void:
	for key in _enemy_batches.keys():
		var batch: Dictionary = _enemy_batches[key]
		var nodes: Dictionary = _enemy_nodes[key]
		var enemy_type: String = batch["enemy_type"]
		var tier: String = batch["tier"]
		var positions: Array = batch["positions"]
		for i in range(positions.size()):
			var position: Vector3 = positions[i]
			var scale: float = batch["scales"][i]
			var speed: float = batch["speeds"][i]
			var phase: float = batch["phases"][i]
			var distance_to_player := position.distance_to(_player_position)
			var hierarchy_scale := 1.05 if distance_to_player <= 7.0 else 0.90 if tier == "far" else 1.0
			var pulse := 1.0 + sin(_time * _enemy_pulse_speed(enemy_type) + phase) * _enemy_pulse_amount(enemy_type)
			var yaw := _time * speed + phase
			var basis := Basis.IDENTITY.rotated(Vector3.UP, yaw).rotated(Vector3.RIGHT, sin(_time * speed + phase) * 0.10)
			var transform := Transform3D(basis.scaled(Vector3.ONE * scale * pulse * hierarchy_scale), position)
			nodes["body"].multimesh.set_instance_transform(i, transform)
			nodes["shell"].multimesh.set_instance_transform(i, Transform3D(basis.scaled(Vector3.ONE * scale * 1.22 * pulse * hierarchy_scale), position))
			nodes["core"].multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale * _enemy_core_scale(enemy_type)), position))
			if nodes.has("muzzle"):
				var forward := basis * Vector3(0.0, 0.0, -1.0)
				nodes["muzzle"].multimesh.set_instance_transform(i, Transform3D(_basis_from_y_axis(forward).scaled(Vector3.ONE * scale), position + forward * scale * 0.72))
			if nodes.has("ring"):
				var ring_basis := Basis.IDENTITY.rotated(Vector3.RIGHT, PI * 0.5).rotated(Vector3.UP, -yaw * 1.6)
				nodes["ring"].multimesh.set_instance_transform(i, Transform3D(ring_basis.scaled(Vector3.ONE * scale * (1.05 + sin(_time * 4.0 + phase) * 0.08)), position))


func _update_xp_batches() -> void:
	for i in range(_xp_data.size()):
		var data: Dictionary = _xp_data[i]
		var base_position: Vector3 = data["position"]
		var scale: float = data["scale"]
		var phase: float = data["phase"]
		var speed: float = data["speed"]
		var bob := sin(_time * 2.4 + phase) * 0.10
		var position := Vector3(base_position.x, 0.58 + bob, base_position.z)
		var spin := _time * speed + phase
		_xp_nodes["shell"].multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale * 1.28), position))
		_xp_nodes["body"].multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale), position))
		_xp_nodes["ring"].multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.rotated(Vector3.RIGHT, PI * 0.5).rotated(Vector3.UP, spin).scaled(Vector3.ONE * scale), position))
		_xp_nodes["spark"].multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale), position + Vector3(cos(spin) * 0.42 * scale, 0.16 * scale, sin(spin) * 0.42 * scale)))


func _update_projectile_batches(delta: float) -> void:
	for i in range(_projectile_data.size()):
		var data: Dictionary = _projectile_data[i]
		var yaw: float = data["yaw"]
		var direction := Vector3(cos(yaw), 0.0, -sin(yaw))
		var position: Vector3 = data["position"] + direction * float(data["speed"]) * delta
		if position.x > ARENA_HALF_SIZE or position.x < -ARENA_HALF_SIZE or position.z > ARENA_HALF_SIZE or position.z < -ARENA_HALF_SIZE:
			var lane: int = data["lane"]
			position = Vector3(-19.0 + float(lane % 10) * 4.2, 0.82, 13.0 + float(lane / 10) * 1.2)
			yaw += PI * 0.72
		data["position"] = position
		data["yaw"] = yaw
		_projectile_data[i] = data
		var basis := _basis_from_y_axis(direction)
		_projectile_nodes["trail"].multimesh.set_instance_transform(i, Transform3D(basis.scaled(Vector3(0.88, 1.0, 0.88)), position - direction * 0.62))
		_projectile_nodes["body"].multimesh.set_instance_transform(i, Transform3D(basis, position))
		_projectile_nodes["core"].multimesh.set_instance_transform(i, Transform3D(basis, position + direction * 0.04))


func _update_spark_batch() -> void:
	var center := Vector3(5.4, 0.92, 6.0)
	var cycle := fmod(_time, 1.25) / 1.25
	var active_count := SPARK_POOL_COUNT if _quality_mode == QUALITY_FULL else SPARK_POOL_COUNT * 2 / 3 if _quality_mode == QUALITY_MEDIUM else SPARK_POOL_COUNT / 4
	for i in range(SPARK_POOL_COUNT):
		var scale := 0.0
		var position := center
		if i < active_count:
			var phase := fmod(cycle + float(i % 17) * 0.021, 1.0)
			var distance := sin(phase * PI) * _spark_speeds[i]
			position = center + _spark_dirs[i] * distance
			scale = maxf(0.08, sin(phase * PI))
		_spark_nodes["sparks"].multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale), position))


func _update_nova_sample() -> void:
	if not is_instance_valid(_nova_ring):
		return
	var phase := fmod(_time, 1.6) / 1.6
	var scale := lerpf(0.45, 3.0, phase)
	_nova_ring.scale = Vector3.ONE * scale
	_nova_ring.visible = phase < 0.88


func _add_mesh_instance(parent: Node3D, node_name: String, mesh: Mesh, material: Material) -> MeshInstance3D:
	var instance := MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = mesh
	if material:
		instance.material_override = material
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	parent.add_child(instance)
	return instance


func _create_tube_instance(parent: Node3D, start: Vector3, end: Vector3, radius: float, material: Material, node_name: String) -> MeshInstance3D:
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = maxf(start.distance_to(end), 0.001)
	mesh.radial_segments = 8
	mesh.rings = 1
	var tube := _add_mesh_instance(parent, node_name, mesh, material)
	_update_tube(tube, start, end, radius)
	return tube


func _update_tube(tube: MeshInstance3D, start: Vector3, end: Vector3, radius: float) -> void:
	var delta := end - start
	var length := delta.length()
	if length < 0.001:
		tube.visible = false
		return
	tube.visible = true
	var mesh := tube.mesh as CylinderMesh
	if mesh:
		mesh.height = length
		mesh.top_radius = radius
		mesh.bottom_radius = radius
	tube.transform = Transform3D(_basis_from_y_axis(delta.normalized()), (start + end) * 0.5)


func _sphere_mesh(radius: float, radial_segments: int, rings: int) -> SphereMesh:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0
	mesh.radial_segments = radial_segments
	mesh.rings = rings
	return mesh


func _box_mesh(size: Vector3) -> BoxMesh:
	var mesh := BoxMesh.new()
	mesh.size = size
	return mesh


func _capsule_mesh(radius: float, height: float, radial_segments: int, rings: int) -> CapsuleMesh:
	var mesh := CapsuleMesh.new()
	mesh.radius = radius
	mesh.height = height
	mesh.radial_segments = radial_segments
	mesh.rings = rings
	return mesh


func _torus_mesh(radius: float, tube_radius: float, ring_segments: int, rings: int) -> TorusMesh:
	var mesh := TorusMesh.new()
	mesh.inner_radius = maxf(0.01, radius - tube_radius)
	mesh.outer_radius = radius + tube_radius
	mesh.ring_segments = ring_segments
	mesh.rings = rings
	return mesh


func _octahedron_mesh(size: float) -> ArrayMesh:
	var points := PackedVector3Array([
		Vector3(0.0, size, 0.0),
		Vector3(size, 0.0, 0.0),
		Vector3(0.0, 0.0, size),
		Vector3(-size, 0.0, 0.0),
		Vector3(0.0, 0.0, -size),
		Vector3(0.0, -size, 0.0)
	])
	var indices := PackedInt32Array([
		0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 1,
		5, 2, 1, 5, 3, 2, 5, 4, 3, 5, 1, 4
	])
	return _mesh_from_arrays(points, indices)


func _tetrahedron_arrow_mesh() -> ArrayMesh:
	var points := PackedVector3Array([
		Vector3(0.0, 0.30, -1.20),
		Vector3(-0.74, -0.28, 0.62),
		Vector3(0.74, -0.28, 0.62),
		Vector3(0.0, 0.82, 0.18)
	])
	var indices := PackedInt32Array([
		0, 1, 2,
		0, 3, 1,
		0, 2, 3,
		1, 3, 2
	])
	return _mesh_from_arrays(points, indices)


func _mesh_from_arrays(vertices: PackedVector3Array, indices: PackedInt32Array) -> ArrayMesh:
	var arrays: Array = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices
	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh


func _tube_edge_mesh(points: Array, edges: Array, radius: float, radial_segments: int) -> ArrayMesh:
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()
	for edge in edges:
		_append_tube(vertices, indices, points[edge[0]], points[edge[1]], radius, radial_segments)
	return _mesh_from_arrays(vertices, indices)


func _append_tube(vertices: PackedVector3Array, indices: PackedInt32Array, start: Vector3, end: Vector3, radius: float, radial_segments: int) -> void:
	var direction := end - start
	var length := direction.length()
	if length < 0.001:
		return
	var basis := _basis_from_y_axis(direction.normalized())
	var center := (start + end) * 0.5
	var base_index := vertices.size()
	for i in range(radial_segments):
		var angle := TAU * float(i) / float(radial_segments)
		var ring := Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)
		vertices.append(center + basis * (ring + Vector3(0.0, -length * 0.5, 0.0)))
		vertices.append(center + basis * (ring + Vector3(0.0, length * 0.5, 0.0)))
	for i in range(radial_segments):
		var next := (i + 1) % radial_segments
		var a := base_index + i * 2
		var b := base_index + next * 2
		var c := base_index + i * 2 + 1
		var d := base_index + next * 2 + 1
		indices.append_array(PackedInt32Array([a, c, b, b, c, d]))


func _enemy_batch_key(enemy_type: String, tier: String) -> String:
	return "%s_%s" % [enemy_type, tier]


func _enemy_base_scale(enemy_type: String) -> float:
	match enemy_type:
		"tank":
			return 0.58
		"shooter":
			return 0.56
		"exploder":
			return 0.54
		_:
			return 0.54


func _enemy_showcase_scale(enemy_type: String) -> float:
	match enemy_type:
		"tank":
			return 0.96
		"shooter":
			return 1.00
		"exploder":
			return 0.98
		_:
			return 1.10


func _enemy_body_material(enemy_type: String, tier: String) -> Material:
	match enemy_type:
		"tank":
			return _materials["tank_body_near"] if tier == "near" else _materials["tank_body_far"]
		"shooter":
			return _materials["shooter_body_near"] if tier == "near" else _materials["shooter_body_far"]
		"exploder":
			return _materials["exploder_body_near"] if tier == "near" else _materials["exploder_body_far"]
		_:
			return _materials["chaser_body_near"] if tier == "near" else _materials["chaser_body_far"]


func _enemy_shell_material(enemy_type: String) -> Material:
	match enemy_type:
		"tank":
			return _materials["tank_shell"]
		"shooter":
			return _materials["shooter_shell"]
		"exploder":
			return _materials["exploder_shell"]
		_:
			return _materials["chaser_shell"]


func _enemy_shell_mesh(enemy_type: String) -> Mesh:
	match enemy_type:
		"exploder":
			return _meshes["sphere_shell"]
		_:
			return _meshes["%s_body" % enemy_type]


func _enemy_core_material(tier: String) -> Material:
	return _materials["white_hot"] if tier == "near" else _materials["soft_white"]


func _enemy_core_scale(enemy_type: String) -> float:
	match enemy_type:
		"tank":
			return 0.36
		"exploder":
			return 0.42
		_:
			return 0.32


func _enemy_pulse_speed(enemy_type: String) -> float:
	return 4.4 if enemy_type == "exploder" else 2.0


func _enemy_pulse_amount(enemy_type: String) -> float:
	if enemy_type == "exploder":
		return 0.055
	return 0.010 if _quality_mode == QUALITY_SWARM else 0.020


func _basis_from_y_axis(axis: Vector3) -> Basis:
	var y := axis.normalized()
	var x := Vector3.FORWARD.cross(y)
	if x.length_squared() < 0.001:
		x = Vector3.RIGHT.cross(y)
	x = x.normalized()
	var z := x.cross(y).normalized()
	return Basis(x, y, z)


func _count_batch_nodes(batch: Dictionary) -> int:
	var count := 0
	for value in batch.values():
		if value is Dictionary:
			count += _count_batch_nodes(value)
		elif value is Node:
			count += _count_visual_nodes(value)
	return count


func _count_visual_nodes(node: Node) -> int:
	var count := 1
	for child in node.get_children():
		count += _count_visual_nodes(child)
	return count


func _quality_label() -> String:
	match _quality_mode:
		QUALITY_SWARM:
			return "swarm"
		QUALITY_MEDIUM:
			return "medium"
		_:
			return "full"
