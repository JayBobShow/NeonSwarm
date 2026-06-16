extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")
const PLAYER_SCENE := preload("res://scenes/visuals/Player3D.tscn")
const CHASER_SCENE := preload("res://scenes/visuals/Chaser3D.tscn")
const TANK_SCENE := preload("res://scenes/visuals/Tank3D.tscn")
const SHOOTER_SCENE := preload("res://scenes/visuals/Shooter3D.tscn")
const EXPLODER_SCENE := preload("res://scenes/visuals/Exploder3D.tscn")
const XP_ORB_SCENE := preload("res://scenes/visuals/XPOrb3D.tscn")
const PROJECTILE_SCENE := preload("res://scenes/visuals/Projectile3D.tscn")

const BURST_SPARK_COUNT := 64

var _time := 0.0
var _materials: Dictionary = {}
var _nova_nodes: Array[Node3D] = []
var _burst_sparks: MultiMeshInstance3D
var _burst_dirs: Array[Vector3] = []


func _ready() -> void:
	name = "NeonSwarm3DVisualProofBoard"
	_create_materials()
	_setup_world_environment()
	_create_camera()
	_create_arena()
	_create_visual_review_objects()
	print("Neon Swarm Phase 3 visual definition proof board: separate_visual_scenes=7 review_objects=10 visual_nodes=%d" % _count_visual_nodes(self))


func _process(delta: float) -> void:
	_time += delta
	_update_nova()
	_update_death_burst()


func get_proof_summary() -> String:
	return "Phase 3 visual definition proof board summary: separate_visual_scenes=7 review_objects=10 visual_nodes=%d burst_sparks=%d" % [
		_count_visual_nodes(self),
		BURST_SPARK_COUNT
	]


func _create_materials() -> void:
	_materials["white"] = Kit.make_emissive_material(Color(1.0, 0.98, 0.88, 1.0), 8.8, false)
	_materials["soft_white"] = Kit.make_emissive_material(Color(0.92, 0.98, 1.0, 0.76), 3.8, true)
	_materials["cyan"] = Kit.make_emissive_material(Color(0.0, 0.76, 1.0, 0.82), 4.2, true)
	_materials["green"] = Kit.make_emissive_material(Color(0.08, 1.0, 0.54, 0.62), 4.4, true)
	_materials["orange"] = Kit.make_emissive_material(Color(1.0, 0.45, 0.04, 0.84), 5.4, true)
	_materials["grid_minor"] = Kit.make_emissive_material(Color(0.03, 0.16, 0.42, 0.22), 0.60, true)
	_materials["grid_major"] = Kit.make_emissive_material(Color(0.10, 0.36, 0.86, 0.35), 0.95, true)
	_materials["grid_axis"] = Kit.make_emissive_material(Color(0.46, 0.10, 0.82, 0.42), 1.18, true)
	_materials["border"] = Kit.make_emissive_material(Color(0.03, 0.64, 1.0, 0.66), 1.75, true)
	_materials["nova"] = Kit.make_emissive_material(Color(0.08, 1.0, 0.62, 0.42), 4.0, true)
	_materials["nova_haze"] = Kit.make_plasma_shell_material(Color(0.08, 1.0, 0.62, 0.26), 3.4, 1.25)
	_materials["spark"] = Kit.make_emissive_material(Color(1.0, 0.76, 0.18, 0.85), 4.6, true)


func _setup_world_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.0, 0.001, 0.008, 1.0)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.02, 0.025, 0.06, 1.0)
	environment.ambient_light_energy = 0.18
	environment.glow_enabled = true
	environment.glow_intensity = 1.85
	environment.glow_strength = 2.15
	environment.glow_bloom = 0.48
	environment.glow_hdr_threshold = 0.08
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.18
	world_environment.environment = environment
	add_child(world_environment)


func _create_camera() -> void:
	var camera := Camera3D.new()
	camera.name = "VisualProofBoardCamera"
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 17.8
	camera.position = Vector3(0.0, 15.5, 15.2)
	camera.current = true
	add_child(camera)
	camera.look_at(Vector3(0.0, 0.4, 0.8), Vector3.UP)


func _create_arena() -> void:
	var arena := Node3D.new()
	arena.name = "ProofBoardArenaGridSample"
	add_child(arena)
	var half_size := 10.8
	var minor := ImmediateMesh.new()
	var major := ImmediateMesh.new()
	var axis := ImmediateMesh.new()
	_build_grid_surface(minor, half_size, 1.0, _materials["grid_minor"], false)
	_build_grid_surface(major, half_size, 3.0, _materials["grid_major"], false)
	_build_grid_surface(axis, half_size, half_size, _materials["grid_axis"], true)
	Kit.add_mesh(arena, "ProofBoardDimBlueGridMinor", minor, null)
	Kit.add_mesh(arena, "ProofBoardDimBlueGridMajor", major, null)
	Kit.add_mesh(arena, "ProofBoardPurpleAxisLines", axis, null)
	var points: Array = [
		Vector3(-half_size, 0.02, -half_size),
		Vector3(half_size, 0.02, -half_size),
		Vector3(half_size, 0.02, half_size),
		Vector3(-half_size, 0.02, half_size)
	]
	var edges: Array = [[0, 1], [1, 2], [2, 3], [3, 0]]
	Kit.add_mesh(arena, "ProofBoardThickCyanBorderGlow", Kit.tube_edge_mesh(points, edges, 0.075, 10), _materials["border"])
	Kit.add_mesh(arena, "ProofBoardWhiteHotBorderCore", Kit.tube_edge_mesh(points, edges, 0.025, 8), _materials["soft_white"])


func _build_grid_surface(mesh: ImmediateMesh, half_size: float, spacing: float, material: Material, axis_only: bool) -> void:
	mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	if axis_only:
		mesh.surface_add_vertex(Vector3(-half_size, -0.015, 0.0))
		mesh.surface_add_vertex(Vector3(half_size, -0.015, 0.0))
		mesh.surface_add_vertex(Vector3(0.0, -0.015, -half_size))
		mesh.surface_add_vertex(Vector3(0.0, -0.015, half_size))
	else:
		var steps := int((half_size * 2.0) / spacing)
		for i in range(steps + 1):
			var offset := -half_size + float(i) * spacing
			mesh.surface_add_vertex(Vector3(-half_size, -0.015, offset))
			mesh.surface_add_vertex(Vector3(half_size, -0.015, offset))
			mesh.surface_add_vertex(Vector3(offset, -0.015, -half_size))
			mesh.surface_add_vertex(Vector3(offset, -0.015, half_size))
	mesh.surface_end()


func _create_visual_review_objects() -> void:
	_add_visual("PLAYER CORE", PLAYER_SCENE, Vector3(-7.2, 1.05, -4.4), 1.0)
	_add_visual("CHASER", CHASER_SCENE, Vector3(-2.45, 0.95, -4.4), 1.0)
	_add_visual("TANK", TANK_SCENE, Vector3(2.45, 0.95, -4.4), 1.0)
	_add_visual("SHOOTER", SHOOTER_SCENE, Vector3(7.2, 0.95, -4.4), 1.0)
	_add_visual("EXPLODER", EXPLODER_SCENE, Vector3(-7.2, 0.95, 2.3), 1.0)
	_add_visual("XP ORB", XP_ORB_SCENE, Vector3(-2.45, 0.85, 2.3), 1.35)
	_add_visual("PROJECTILE", PROJECTILE_SCENE, Vector3(2.45, 0.90, 2.3), 1.25)
	_create_nova_review(Vector3(7.2, 0.22, 2.3))
	_create_death_burst_review(Vector3(-3.2, 0.90, 6.7))
	_create_grid_callout(Vector3(4.0, 0.10, 6.7))


func _add_visual(label: String, scene: PackedScene, position: Vector3, visual_scale: float) -> Node3D:
	var visual := scene.instantiate() as Node3D
	visual.name = "%sReviewInstance" % label.replace(" ", "")
	visual.position = position
	visual.scale = Vector3.ONE * visual_scale
	add_child(visual)
	Kit.add_label(self, label, position + Vector3(0.0, 2.25, 0.0))
	return visual


func _create_nova_review(position: Vector3) -> void:
	var root := Node3D.new()
	root.name = "ProofNovaExpanding3DTorusShockwave"
	root.position = position
	add_child(root)
	Kit.add_label(self, "NOVA RING", position + Vector3(0.0, 1.95, 0.0))
	var haze := Kit.add_mesh(root, "NovaWideGreenPlasmaHaze", Kit.torus_mesh(1.40, 0.075, 64, 8), _materials["nova_haze"])
	var core := Kit.add_mesh(root, "NovaWhiteHotTorusCore", Kit.torus_mesh(1.40, 0.028, 64, 8), _materials["white"])
	haze.rotation.x = PI * 0.5
	core.rotation.x = PI * 0.5
	_add_radial_spikes(root, "NovaRadialRays", 1.10, 1.86, 18, _materials["nova"], _materials["soft_white"])
	Kit.add_mesh(root, "NovaCenterFlash", Kit.sphere_mesh(0.30, 16, 8), _materials["white"], Vector3(0.0, 0.10, 0.0))
	_nova_nodes.append(haze)
	_nova_nodes.append(core)


func _create_death_burst_review(position: Vector3) -> void:
	var root := Node3D.new()
	root.name = "ProofEnemyDeathBurstSample"
	root.position = position
	add_child(root)
	Kit.add_label(self, "DEATH BURST", position + Vector3(0.0, 1.95, 0.0))
	Kit.add_mesh(root, "DeathBurstWhiteHotCenterPop", Kit.sphere_mesh(0.28, 16, 8), _materials["white"])
	var ring := Kit.add_mesh(root, "DeathBurstShortGlowRing", Kit.torus_mesh(0.78, 0.036, 48, 6), _materials["orange"])
	ring.rotation.x = PI * 0.5
	_burst_sparks = Kit.create_spark_multimesh(root, "DeathBurstPooledSparkFragments", Kit.capsule_mesh(0.035, 0.42, 8, 3), _materials["spark"], BURST_SPARK_COUNT)
	_burst_dirs.clear()
	for i in range(BURST_SPARK_COUNT):
		var angle := TAU * float(i) / float(BURST_SPARK_COUNT)
		var y := randf_range(-0.06, 0.55)
		_burst_dirs.append(Vector3(cos(angle), y, sin(angle)).normalized())


func _create_grid_callout(position: Vector3) -> void:
	var root := Node3D.new()
	root.name = "ProofArenaGridAndBorderCallout"
	root.position = position
	add_child(root)
	Kit.add_label(self, "GRID / BORDER", position + Vector3(0.0, 1.75, 0.0))
	var half_size := 1.65
	var points: Array = [
		Vector3(-half_size, 0.03, -half_size),
		Vector3(half_size, 0.03, -half_size),
		Vector3(half_size, 0.03, half_size),
		Vector3(-half_size, 0.03, half_size)
	]
	var edges: Array = [[0, 1], [1, 2], [2, 3], [3, 0]]
	Kit.add_mesh(root, "GridSampleCyanBorderTube", Kit.tube_edge_mesh(points, edges, 0.052, 8), _materials["border"])
	Kit.add_mesh(root, "GridSampleWhiteHotBorderCore", Kit.tube_edge_mesh(points, edges, 0.018, 6), _materials["soft_white"])
	var grid := ImmediateMesh.new()
	grid.surface_begin(Mesh.PRIMITIVE_LINES, _materials["grid_major"])
	for i in range(5):
		var offset := -half_size + float(i) * (half_size * 0.5)
		grid.surface_add_vertex(Vector3(-half_size, 0.0, offset))
		grid.surface_add_vertex(Vector3(half_size, 0.0, offset))
		grid.surface_add_vertex(Vector3(offset, 0.0, -half_size))
		grid.surface_add_vertex(Vector3(offset, 0.0, half_size))
	grid.surface_end()
	Kit.add_mesh(root, "GridSampleMajorLines", grid, null)


func _add_radial_spikes(parent: Node3D, prefix: String, inner_radius: float, outer_radius: float, count: int, outer_material: Material, core_material: Material) -> void:
	var points: Array = []
	var edges: Array = []
	for i in range(count):
		var angle := TAU * float(i) / float(count)
		var inner := Vector3(cos(angle) * inner_radius, 0.04, sin(angle) * inner_radius)
		var outer := Vector3(cos(angle) * outer_radius, 0.10 + sin(angle * 2.0) * 0.08, sin(angle) * outer_radius)
		points.append(inner)
		points.append(outer)
		edges.append([i * 2, i * 2 + 1])
	Kit.add_glowing_edges(parent, prefix, points, edges, 0.042, 0.014, outer_material, core_material)


func _update_nova() -> void:
	for i in range(_nova_nodes.size()):
		var node := _nova_nodes[i]
		if is_instance_valid(node):
			node.scale = Vector3.ONE * (1.0 + sin(_time * 1.8 + float(i)) * 0.14)
			node.rotation.y += 0.012 + float(i) * 0.004


func _update_death_burst() -> void:
	if not is_instance_valid(_burst_sparks):
		return
	var cycle := fmod(_time, 1.15) / 1.15
	for i in range(BURST_SPARK_COUNT):
		var phase := fmod(cycle + float(i % 11) * 0.018, 1.0)
		var distance := sin(phase * PI) * (1.3 + float(i % 7) * 0.12)
		var direction := _burst_dirs[i]
		var pos := direction * distance
		var basis := Kit.basis_from_y_axis(direction)
		var scale := maxf(0.05, sin(phase * PI))
		_burst_sparks.multimesh.set_instance_transform(i, Transform3D(basis.scaled(Vector3.ONE * scale), pos))


func _count_visual_nodes(node: Node) -> int:
	var count := 1
	for child in node.get_children():
		count += _count_visual_nodes(child)
	return count
