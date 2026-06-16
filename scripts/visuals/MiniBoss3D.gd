extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _core: Node3D
var _rings: Array[Node3D] = []
var _spark_batch: MultiMeshInstance3D
var _spark_count := 22


func _ready() -> void:
	name = "MiniBoss3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.28
	rotation.x = sin(_time * 0.72) * 0.08
	if is_instance_valid(_core):
		_core.scale = Vector3.ONE * (1.0 + sin(_time * 1.8) * 0.045)
	for i in range(_rings.size()):
		var ring := _rings[i]
		ring.rotation.y += delta * (0.64 + float(i) * 0.22)
		ring.rotation.x += delta * (0.22 + float(i) * 0.16)
		ring.scale = Vector3.ONE * (1.0 + sin(_time * 2.1 + float(i)) * 0.05)
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.98, 0.84, 1.0), 8.2, false)
	var violet := Kit.make_emissive_material(Color(0.78, 0.06, 1.0, 0.96), 7.1, true)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.92, 1.0, 0.86), 6.0, true)
	var magenta := Kit.make_emissive_material(Color(1.0, 0.04, 0.90, 0.86), 5.9, true)
	var body_material := Kit.make_neon_body_material(Color(0.34, 0.02, 0.66, 1.0), 1.12)
	var shell := Kit.make_plasma_shell_material(Color(0.58, 0.08, 1.0, 0.10), 1.10, 1.38)

	_core = Node3D.new()
	_core.name = "PrismWardenOctahedronCore"
	add_child(_core)
	var body := Kit.add_mesh(_core, "LargeReadableOctahedronBody", Kit.octahedron_mesh(1.22), body_material)
	body.scale = Vector3(1.0, 1.18, 1.0)
	var haze := Kit.add_mesh(_core, "ControlledVioletPlasmaShell", Kit.octahedron_mesh(1.44), shell)
	haze.scale = Vector3(1.0, 1.08, 1.0)
	Kit.add_glowing_edges(_core, "PrismWardenOctahedron", Kit.octahedron_points(1.34), Kit.octahedron_edges(), 0.148, 0.040, violet, white)
	Kit.add_mesh(_core, "WhiteHotCommandCore", Kit.sphere_mesh(0.34, 16, 8), white)
	for beacon in Kit.octahedron_points(1.48):
		Kit.add_mesh(_core, "PrismWardenWhiteHotVertexBeacon", Kit.sphere_mesh(0.090, 8, 4), white, beacon)
	var left_command_fin := Kit.add_mesh(_core, "LeftMagentaCommandShoulderFin", Kit.triangular_prism_mesh(0.64, 1.12, 0.18), magenta, Vector3(-1.10, 0.02, 0.0))
	var right_command_fin := Kit.add_mesh(_core, "RightMagentaCommandShoulderFin", Kit.triangular_prism_mesh(0.64, 1.12, 0.18), magenta, Vector3(1.10, 0.02, 0.0))
	left_command_fin.rotation.z = PI * 0.34
	left_command_fin.rotation.y = -PI * 0.18
	right_command_fin.rotation.z = -PI * 0.34
	right_command_fin.rotation.y = PI * 0.18

	var crown := Node3D.new()
	crown.name = "PrismWardenCommandCrownAssembly"
	crown.position = Vector3(0.0, 1.28, 0.0)
	_core.add_child(crown)
	Kit.add_mesh(crown, "VioletFloatingHexCommandCrownPlate", Kit.hex_prism_mesh(0.76, 0.12), body_material)
	Kit.add_glowing_edges(crown, "PrismWardenHexCommandCrown", Kit.hex_prism_points(0.84, 0.16), Kit.hex_prism_edges(), 0.070, 0.020, cyan, white)
	for i in range(6):
		var angle := TAU * float(i) / 6.0
		var spire_pos := Vector3(cos(angle) * 0.84, 0.28, sin(angle) * 0.84)
		Kit.add_mesh(crown, "PrismWardenCrownSpire%d" % i, Kit.cylinder_mesh(0.044, 0.56, 8), magenta, spire_pos)
		Kit.add_mesh(crown, "PrismWardenCrownBeacon%d" % i, Kit.sphere_mesh(0.075, 8, 4), white, spire_pos + Vector3(0.0, 0.34, 0.0))

	for i in range(3):
		var ring_material: Material = cyan if i == 0 else magenta if i == 1 else violet
		var ring := Kit.add_mesh(self, "PrismWardenReactorTorus%d" % i, Kit.torus_mesh(1.58 + float(i) * 0.18, 0.058, 56, 6), ring_material)
		ring.rotation.x = PI * 0.5
		ring.rotation.z = float(i) * PI / 5.0
		_rings.append(ring)

	_spark_batch = Kit.create_spark_multimesh(self, "PrismWardenCrownSparkBatch", Kit.sphere_mesh(0.052, 8, 4), white, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 2.7 + TAU * float(i) / float(_spark_count)
		var radius := 1.74 + sin(_time * 3.9 + float(i)) * 0.12
		var pos := Vector3(cos(phase) * radius, sin(phase * 1.6) * 0.52, sin(phase) * radius)
		var scale := 0.66 + sin(_time * 5.4 + float(i)) * 0.24
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.05, scale)), pos))
