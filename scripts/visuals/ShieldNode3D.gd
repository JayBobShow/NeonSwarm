extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _rings: Array[Node3D] = []
var _core: Node3D
var _spark_batch: MultiMeshInstance3D
var _spark_count := 8


func _ready() -> void:
	name = "ShieldNode3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.38
	if is_instance_valid(_core):
		_core.scale = Vector3.ONE * (1.0 + sin(_time * 1.8) * 0.035)
	for i in range(_rings.size()):
		var ring := _rings[i]
		ring.rotation.y += delta * (0.84 + float(i) * 0.28)
		ring.rotation.x += delta * (0.20 + float(i) * 0.12)
		ring.scale = Vector3.ONE * (1.0 + sin(_time * 2.4 + float(i)) * 0.045)
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.99, 0.86, 1.0), 7.0, false)
	var blue := Kit.make_emissive_material(Color(0.05, 0.56, 1.0, 0.92), 6.0, true)
	var cyan := Kit.make_emissive_material(Color(0.0, 1.0, 0.92, 0.84), 5.5, true)
	var body_material := Kit.make_neon_body_material(Color(0.0, 0.18, 0.44, 1.0), 0.88)
	var shell := Kit.make_plasma_shell_material(Color(0.05, 0.54, 1.0, 0.09), 0.98, 1.34)

	_core = Node3D.new()
	_core.name = "ShieldNodeDarkCore"
	add_child(_core)
	Kit.add_mesh(_core, "ShieldNodeSpheroidBody", Kit.sphere_mesh(0.54, 14, 7), body_material)
	Kit.add_mesh(_core, "ShieldNodeHexagonalWardCorePlate", Kit.hex_prism_mesh(0.54, 0.10), body_material)
	Kit.add_glowing_edges(_core, "ShieldNodeHexagonalWardCore", Kit.hex_prism_points(0.58, 0.12), Kit.hex_prism_edges(), 0.036, 0.012, cyan, white)
	Kit.add_mesh(_core, "ShieldNodeControlledPlasmaShell", Kit.sphere_mesh(0.74, 14, 7), shell)
	Kit.add_mesh(_core, "ShieldNodeWhiteHotProtectedCore", Kit.sphere_mesh(0.12, 8, 4), white)

	var ward_face := Node3D.new()
	ward_face.name = "ForwardHexWardFaceAssembly"
	ward_face.position = Vector3(0.0, 0.0, -0.48)
	ward_face.rotation.x = PI * 0.5
	add_child(ward_face)
	Kit.add_mesh(ward_face, "ForwardBlueHexShieldPlate", Kit.hex_prism_mesh(0.52, 0.08), body_material)
	Kit.add_glowing_edges(ward_face, "ForwardBlueHexShield", Kit.hex_prism_points(0.58, 0.10), Kit.hex_prism_edges(), 0.040, 0.014, blue, white)

	var ring_a := Kit.add_mesh(self, "ShieldNodePrimaryAnnulusTube", Kit.torus_mesh(0.88, 0.074, 44, 6), blue)
	var ring_b := Kit.add_mesh(self, "ShieldNodeWhiteHotAnnulusCore", Kit.torus_mesh(0.88, 0.024, 44, 5), white)
	var ring_c := Kit.add_mesh(self, "ShieldNodeVerticalCyanShieldRing", Kit.torus_mesh(0.70, 0.040, 38, 5), cyan)
	ring_a.rotation.x = PI * 0.5
	ring_b.rotation.x = PI * 0.5
	ring_c.rotation.z = PI * 0.5
	_rings.append(ring_a)
	_rings.append(ring_c)

	var spokes := _make_spoke_points(0.20, 0.92, 8)
	var edges := _make_spoke_edges(8)
	Kit.add_mesh(self, "ShieldNodeCyanRadialSpokeTubes", Kit.tube_edge_mesh(spokes, edges, 0.030, 7), cyan)
	Kit.add_mesh(self, "ShieldNodeWhiteHotSpokeCores", Kit.tube_edge_mesh(spokes, edges, 0.010, 5), white)

	_spark_batch = Kit.create_spark_multimesh(self, "ShieldNodeEdgeSparkBatch", Kit.sphere_mesh(0.034, 8, 4), white, _spark_count)
	_update_sparks()


func _make_spoke_points(inner_radius: float, outer_radius: float, count: int) -> Array:
	var points: Array = []
	for i in range(count):
		var angle := TAU * float(i) / float(count)
		points.append(Vector3(cos(angle) * inner_radius, 0.0, sin(angle) * inner_radius))
		points.append(Vector3(cos(angle) * outer_radius, 0.0, sin(angle) * outer_radius))
	return points


func _make_spoke_edges(count: int) -> Array:
	var edges: Array = []
	for i in range(count):
		edges.append([i * 2, i * 2 + 1])
	return edges


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 3.4 + TAU * float(i) / float(_spark_count)
		var radius := 1.00 + sin(_time * 5.0 + float(i)) * 0.05
		var pos := Vector3(cos(phase) * radius, sin(phase * 1.6) * 0.16, sin(phase) * radius)
		var scale := 0.48 + sin(_time * 5.8 + float(i)) * 0.16
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.04, scale)), pos))
