extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _spark_batch: MultiMeshInstance3D
var _trail_tubes: Array[MeshInstance3D] = []
var _edge_points: Array = []
var _spark_count := 10


func _ready() -> void:
	name = "Chaser3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y = sin(_time * 1.5) * 0.20
	rotation.x = sin(_time * 2.2) * 0.08
	for i in range(_trail_tubes.size()):
		var start := Vector3(0.0, -0.10, 0.64 + float(i) * 0.32)
		var end := start + Vector3(0.0, 0.0, 1.15 - float(i) * 0.18)
		Kit.update_tube(_trail_tubes[i], start, end, lerpf(0.086, 0.030, float(i) / float(maxi(1, _trail_tubes.size() - 1))))
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 1.0, 0.90, 1.0), 7.3, false)
	var green := Kit.make_emissive_material(Color(0.02, 1.0, 0.44, 0.95), 6.8, true)
	var acid := Kit.make_emissive_material(Color(0.54, 1.0, 0.02, 0.58), 4.4, true)
	var body_material := Kit.make_neon_body_material(Color(0.0, 0.46, 0.18, 1.0), 0.98)
	var shell := Kit.make_plasma_shell_material(Color(0.06, 1.0, 0.44, 0.10), 1.02, 1.34)
	var tail_haze := Kit.make_emissive_material(Color(0.02, 1.0, 0.38, 0.066), 1.10, true)

	_edge_points = Kit.tetrahedron_arrow_points()
	Kit.add_mesh(self, "ForwardTriangularPyramidReadableBody", Kit.tetrahedron_arrow_mesh(), body_material)
	var controlled_shell := Kit.add_mesh(self, "ThinGreenPlasmaShell", Kit.tetrahedron_arrow_mesh(), shell)
	controlled_shell.scale = Vector3.ONE * 1.05
	Kit.add_glowing_edges(self, "ChaserNeedleTetrahedron", _edge_points, Kit.tetrahedron_edges(), 0.108, 0.028, green, white)
	Kit.add_mesh(self, "WhiteHotAttackNose", Kit.sphere_mesh(0.21, 10, 5), white, Vector3(0.0, 0.20, -1.16))

	var fin_mesh := Kit.triangular_prism_mesh(0.62, 0.54, 0.20)
	var left_fin := Kit.add_mesh(self, "LeftRearEnergyFin", fin_mesh, acid, Vector3(-0.48, -0.24, 0.72))
	var right_fin := Kit.add_mesh(self, "RightRearEnergyFin", fin_mesh, acid, Vector3(0.48, -0.24, 0.72))
	left_fin.rotation.z = -PI * 0.28
	right_fin.rotation.z = PI * 0.28
	var keel_fin := Kit.add_mesh(self, "VentralKnifeKeelFin", Kit.triangular_prism_mesh(0.46, 0.66, 0.18), acid, Vector3(0.0, -0.54, -0.04))
	keel_fin.rotation.x = PI * 0.5
	keel_fin.rotation.z = PI

	Kit.tube_between(self, "LeftForwardRakingTalon", Vector3(-0.24, 0.02, -0.34), Vector3(-0.70, 0.18, -1.03), 0.042, acid, 8)
	Kit.tube_between(self, "RightForwardRakingTalon", Vector3(0.24, 0.02, -0.34), Vector3(0.70, 0.18, -1.03), 0.042, acid, 8)
	Kit.tube_between(self, "WhiteHotCenterNeedleRidge", Vector3(0.0, 0.52, -0.02), Vector3(0.0, 0.20, -1.20), 0.026, white, 6)
	Kit.add_mesh(self, "RearIonWakeNode", Kit.sphere_mesh(0.19, 10, 5), green, Vector3(0.0, -0.06, 0.78))

	for i in range(2):
		_trail_tubes.append(Kit.tube_between(self, "ChaserNeedleWake%d" % i, Vector3.ZERO, Vector3(0.0, 0.0, 1.0), 0.05, tail_haze, 8))

	_spark_batch = Kit.create_spark_multimesh(self, "ChaserCornerShearSparkBatch", Kit.sphere_mesh(0.052, 8, 4), green, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var base: Vector3 = _edge_points[i % _edge_points.size()]
		var phase := _time * 5.2 + float(i) * 1.7
		var pos := base + Vector3(sin(phase) * 0.06, cos(phase * 0.8) * 0.08, cos(phase) * 0.06)
		var scale := 0.58 + sin(phase * 1.3) * 0.20
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.04, scale)), pos))
