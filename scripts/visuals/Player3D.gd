extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _rings: Node3D
var _shells: Array[Node3D] = []
var _spark_batch: MultiMeshInstance3D
var _spark_count := 14


func _ready() -> void:
	name = "Player3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y = sin(_time * 0.85) * 0.16
	if is_instance_valid(_rings):
		_rings.rotation.y += delta * 1.55
		_rings.rotation.x = sin(_time * 1.4) * 0.20
	for i in range(_shells.size()):
		var pulse := 1.0 + sin(_time * (1.8 + float(i) * 0.42)) * (0.075 + float(i) * 0.025)
		_shells[i].scale = Vector3.ONE * pulse
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.99, 0.88, 1.0), 8.0, false)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.94), 7.3, true)
	var magenta := Kit.make_emissive_material(Color(1.0, 0.04, 0.96, 0.92), 6.9, true)
	var cyan_body := Kit.make_neon_body_material(Color(0.0, 0.48, 0.66, 1.0), 1.18)
	var magenta_body := Kit.make_neon_body_material(Color(0.62, 0.0, 0.50, 1.0), 1.04)
	var cyan_shell := Kit.make_plasma_shell_material(Color(0.0, 0.86, 1.0, 0.14), 1.25, 1.54)
	var magenta_shell := Kit.make_plasma_shell_material(Color(1.0, 0.04, 0.92, 0.10), 1.12, 1.42)

	var body := Kit.add_mesh(self, "DiamondOctahedronReadableBody", Kit.octahedron_mesh(0.98), cyan_body)
	body.scale = Vector3(1.0, 1.18, 1.0)
	var inner := Kit.add_mesh(self, "CounterRotatedMagentaInnerDiamond", Kit.octahedron_mesh(0.66), magenta_body)
	inner.rotation.y = PI * 0.25
	_shells.append(Kit.add_mesh(self, "ControlledCyanPlasmaShell", Kit.sphere_mesh(1.12, 18, 9), cyan_shell))
	_shells.append(Kit.add_mesh(self, "ControlledMagentaEnergyShell", Kit.sphere_mesh(0.92, 16, 8), magenta_shell))
	_shells[1].rotation.z = PI * 0.24

	Kit.add_glowing_edges(self, "PlayerDiamond", Kit.octahedron_points(1.05), Kit.octahedron_edges(), 0.132, 0.034, cyan, white)
	Kit.add_mesh(self, "WhiteHotReactorCore", Kit.sphere_mesh(0.29, 16, 8), white)
	var prow := Kit.add_mesh(self, "PlayerForwardWhiteHotCommandProw", Kit.capsule_mesh(0.070, 0.74, 10, 3), white)
	prow.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3(0.0, 0.08, -1.18))

	var chevron_points := [
		Vector3(0.0, 0.18, -1.22),
		Vector3(-0.74, -0.08, -0.34),
		Vector3(0.74, -0.08, -0.34),
		Vector3(0.0, -0.18, 0.54)
	]
	var chevron_edges := [[0, 1], [0, 2], [1, 3], [2, 3]]
	Kit.add_mesh(self, "PlayerCyanCommandChevronTubes", Kit.tube_edge_mesh(chevron_points, chevron_edges, 0.046, 8), cyan)
	Kit.add_mesh(self, "PlayerWhiteHotCommandChevronCores", Kit.tube_edge_mesh(chevron_points, chevron_edges, 0.014, 6), white)

	var wing_mesh := Kit.triangular_prism_mesh(0.48, 0.70, 0.16)
	var left_wing := Kit.add_mesh(self, "PlayerLeftMagentaDeltaWing", wing_mesh, magenta, Vector3(-0.76, -0.16, 0.16))
	var right_wing := Kit.add_mesh(self, "PlayerRightMagentaDeltaWing", wing_mesh, magenta, Vector3(0.76, -0.16, 0.16))
	left_wing.rotation.z = PI * 0.34
	left_wing.rotation.y = -PI * 0.12
	right_wing.rotation.z = -PI * 0.34
	right_wing.rotation.y = PI * 0.12

	_rings = Node3D.new()
	_rings.name = "RotatingShieldRingAssembly"
	add_child(_rings)
	var ring_a := Kit.add_mesh(_rings, "CyanEquatorialTorus", Kit.torus_mesh(1.16, 0.062, 52, 6), cyan)
	var ring_b := Kit.add_mesh(_rings, "MagentaVerticalTorus", Kit.torus_mesh(1.34, 0.052, 52, 6), magenta)
	var ring_c := Kit.add_mesh(_rings, "WhiteHotInnerStabilizerTorus", Kit.torus_mesh(0.74, 0.026, 40, 5), white)
	ring_a.rotation.x = PI * 0.5
	ring_b.rotation.y = PI * 0.5
	ring_c.rotation.z = PI * 0.5

	_spark_batch = Kit.create_spark_multimesh(self, "PlayerOrbitingIonSparkBatch", Kit.sphere_mesh(0.050, 8, 4), white, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 2.1 + TAU * float(i) / float(_spark_count)
		var radius := 1.48 + sin(_time * 3.4 + float(i)) * 0.08
		var pos := Vector3(cos(phase) * radius, sin(phase * 1.8) * 0.34, sin(phase) * radius)
		var scale := 0.82 + sin(_time * 5.2 + float(i)) * 0.24
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale), pos))
