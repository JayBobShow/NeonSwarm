extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _core: Node3D
var _helix_root: Node3D
var _spark_batch: MultiMeshInstance3D
var _spark_points: Array = []
var _spark_count := 10


func _ready() -> void:
	name = "SpiralDrifter3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.72
	rotation.x = sin(_time * 1.15) * 0.10
	if is_instance_valid(_core):
		_core.scale = Vector3.ONE * (1.0 + sin(_time * 2.7) * 0.045)
	if is_instance_valid(_helix_root):
		_helix_root.rotation.y += delta * 2.2
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.99, 0.86, 1.0), 7.2, false)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.95, 1.0, 0.94), 6.5, true)
	var violet := Kit.make_emissive_material(Color(0.62, 0.08, 1.0, 0.78), 4.8, true)
	var body_material := Kit.make_neon_body_material(Color(0.0, 0.34, 0.48, 1.0), 0.92)
	var shell := Kit.make_plasma_shell_material(Color(0.0, 0.86, 1.0, 0.085), 0.96, 1.36)

	_core = Node3D.new()
	_core.name = "HelixDrifterDarkCoreBody"
	add_child(_core)
	var body := Kit.add_mesh(_core, "DrifterSpheroidBody", Kit.sphere_mesh(0.58, 14, 7), body_material)
	body.scale = Vector3(0.86, 1.18, 0.86)
	var haze := Kit.add_mesh(_core, "ControlledDrifterPlasmaHaze", Kit.sphere_mesh(0.78, 14, 7), shell)
	haze.scale = Vector3(0.82, 1.20, 0.82)
	Kit.add_mesh(_core, "WhiteHotHelixCorePoint", Kit.sphere_mesh(0.13, 8, 4), white)
	var sail_mesh := Kit.triangular_prism_mesh(0.40, 0.98, 0.16)
	var left_sail := Kit.add_mesh(_core, "LeftCyanDriftSailBlade", sail_mesh, cyan, Vector3(-0.72, 0.0, 0.06))
	var right_sail := Kit.add_mesh(_core, "RightVioletDriftSailBlade", sail_mesh, violet, Vector3(0.72, 0.0, -0.06))
	left_sail.rotation.z = PI * 0.16
	left_sail.rotation.y = PI * 0.18
	right_sail.rotation.z = -PI * 0.16
	right_sail.rotation.y = -PI * 0.18
	Kit.tube_between(_core, "LeftWhiteHotDriftSailEdge", Vector3(-0.82, -0.46, -0.18), Vector3(-0.58, 0.52, 0.22), 0.018, white, 6)
	Kit.tube_between(_core, "RightWhiteHotDriftSailEdge", Vector3(0.82, -0.46, 0.18), Vector3(0.58, 0.52, -0.22), 0.018, white, 6)

	_helix_root = Node3D.new()
	_helix_root.name = "DoubleHelixNeonTubeAssembly"
	add_child(_helix_root)
	var helix_a := _make_helix_points(0.64, 1.26, 1.34, 26, 0.0)
	var helix_b := _make_helix_points(0.64, 1.26, 1.34, 26, PI)
	var helix_edges := _make_chain_edges(helix_a.size())
	Kit.add_mesh(_helix_root, "CyanPrimaryHelixNeonTube", Kit.tube_edge_mesh(helix_a, helix_edges, 0.060, 8), cyan)
	Kit.add_mesh(_helix_root, "WhiteHotPrimaryHelixCore", Kit.tube_edge_mesh(helix_a, helix_edges, 0.018, 6), white)
	Kit.add_mesh(_helix_root, "VioletSecondaryHelixNeonTube", Kit.tube_edge_mesh(helix_b, helix_edges, 0.040, 8), violet)
	_spark_points = helix_a + helix_b

	var upper_ring := Kit.add_mesh(self, "DrifterUpperNeonAnnulus", Kit.torus_mesh(0.66, 0.024, 34, 5), cyan)
	var lower_ring := Kit.add_mesh(self, "DrifterLowerVioletAnnulus", Kit.torus_mesh(0.54, 0.020, 32, 5), violet)
	upper_ring.position.y = 0.58
	lower_ring.position.y = -0.58
	upper_ring.rotation.x = PI * 0.5
	lower_ring.rotation.x = PI * 0.5

	_spark_batch = Kit.create_spark_multimesh(self, "DrifterHelixEdgeSparkBatch", Kit.sphere_mesh(0.034, 8, 4), white, _spark_count)
	_update_sparks()


func _make_helix_points(radius: float, height: float, turns: float, count: int, phase_offset: float) -> Array:
	var points: Array = []
	for i in range(count):
		var t := float(i) / float(maxi(1, count - 1))
		var angle := TAU * turns * t + phase_offset
		points.append(Vector3(cos(angle) * radius, lerpf(-height * 0.5, height * 0.5, t), sin(angle) * radius))
	return points


func _make_chain_edges(count: int) -> Array:
	var edges: Array = []
	for i in range(count - 1):
		edges.append([i, i + 1])
	return edges


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch) or _spark_points.is_empty():
		return
	for i in range(_spark_count):
		var base: Vector3 = _spark_points[i * 3 % _spark_points.size()]
		var phase := _time * 5.0 + float(i) * 1.3
		var pos := base + Vector3(sin(phase) * 0.05, cos(phase * 0.7) * 0.06, cos(phase) * 0.05)
		var scale := 0.46 + sin(phase * 1.2) * 0.18
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.04, scale)), pos))
