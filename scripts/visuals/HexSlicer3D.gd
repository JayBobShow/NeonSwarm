extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _core: Node3D
var _warning_ring: MeshInstance3D
var _spark_batch: MultiMeshInstance3D
var _spark_count := 14


func _ready() -> void:
	name = "HexSlicer3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.74
	rotation.z = sin(_time * 3.4) * 0.08
	if is_instance_valid(_core):
		_core.scale = Vector3(1.0, 1.0 + sin(_time * 5.2) * 0.055, 1.0)
	if is_instance_valid(_warning_ring):
		_warning_ring.rotation.y -= delta * 2.8
		_warning_ring.scale = Vector3.ONE * (1.0 + sin(_time * 7.6) * 0.10)
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 1.0, 0.86, 1.0), 8.0, false)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.92), 7.0, true)
	var magenta := Kit.make_emissive_material(Color(1.0, 0.04, 0.86, 0.88), 6.4, true)
	var blade := Kit.make_emissive_material(Color(0.96, 0.98, 1.0, 0.48), 3.0, true)
	var body_material := Kit.make_neon_body_material(Color(0.0, 0.20, 0.34, 1.0), 0.95)
	var shell := Kit.make_plasma_shell_material(Color(0.0, 0.96, 1.0, 0.10), 1.04, 1.26)

	_core = Node3D.new()
	_core.name = "HexSlicerKnifeHexCore"
	add_child(_core)
	Kit.add_mesh(_core, "BlackGlassHexagonalKnifeBody", Kit.hex_prism_mesh(0.78, 0.26), body_material)
	var haze := Kit.add_mesh(_core, "ThinCyanHexWarningShell", Kit.hex_prism_mesh(0.86, 0.30), shell)
	haze.rotation.y = PI / 6.0
	Kit.add_glowing_edges(_core, "HexSlicerBody", Kit.hex_prism_points(0.84, 0.30), Kit.hex_prism_edges(), 0.068, 0.020, cyan, white)

	for i in range(6):
		var angle := TAU * float(i) / 6.0
		var dir := Vector3(cos(angle), 0.0, sin(angle))
		var blade_node := Kit.add_mesh(_core, "RadialKnifeShard%d" % i, Kit.triangular_prism_mesh(0.28, 0.72, 0.16), blade, dir * 0.86)
		blade_node.rotation.y = -angle + PI * 0.5
		blade_node.rotation.z = PI * 0.5
		Kit.tube_between(_core, "KnifeShardHotEdge%d" % i, dir * 0.62 + Vector3(0.0, 0.05, 0.0), dir * 1.24 + Vector3(0.0, 0.05, 0.0), 0.026, magenta, 6)

	_warning_ring = Kit.add_mesh(self, "DashTelegraphHexAnnulus", Kit.torus_mesh(1.02, 0.026, 6, 4), magenta)
	_warning_ring.rotation.x = PI * 0.5

	_spark_batch = Kit.create_spark_multimesh(self, "HexSlicerCornerSparkBatch", Kit.triangular_prism_mesh(0.10, 0.08, 0.18), cyan, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var angle := TAU * float(i) / float(_spark_count) + _time * 1.7
		var radius := 0.92 + sin(_time * 4.4 + float(i)) * 0.10
		var pos := Vector3(cos(angle) * radius, sin(_time * 3.2 + float(i)) * 0.18, sin(angle) * radius)
		var basis := Kit.basis_from_y_axis(Vector3(cos(angle), 0.18, sin(angle)).normalized())
		var scale := 0.55 + sin(_time * 5.6 + float(i)) * 0.20
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(basis.scaled(Vector3.ONE * maxf(0.05, scale)), pos))
