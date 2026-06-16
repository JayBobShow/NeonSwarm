extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _muzzle_root: Node3D
var _spark_batch: MultiMeshInstance3D
var _spark_count := 10


func _ready() -> void:
	name = "Shooter3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.34
	rotation.x = sin(_time * 1.1) * 0.07
	if is_instance_valid(_muzzle_root):
		var charge := 1.0 + (sin(_time * 5.2) * 0.5 + 0.5) * 0.22
		_muzzle_root.scale = Vector3.ONE * charge
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.98, 0.88, 1.0), 7.5, false)
	var violet := Kit.make_emissive_material(Color(0.84, 0.08, 1.0, 0.95), 6.7, true)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.92, 1.0, 0.84), 5.6, true)
	var violet_body := Kit.make_neon_body_material(Color(0.34, 0.02, 0.62, 1.0), 0.96)
	var muzzle_shell := Kit.make_plasma_shell_material(Color(0.0, 0.86, 1.0, 0.11), 1.10, 1.28)

	var prism_points := Kit.hex_prism_points(0.88, 0.74)
	Kit.add_mesh(self, "HexagonalPrismReadableBody", Kit.hex_prism_mesh(0.88, 0.74), violet_body)
	Kit.add_glowing_edges(self, "ShooterHexPrism", prism_points, Kit.hex_prism_edges(), 0.100, 0.027, violet, white)

	var aim_spine := Kit.add_mesh(self, "ForwardWhiteHotAimSpine", Kit.capsule_mesh(0.066, 1.24, 10, 4), white)
	aim_spine.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3(0.0, 0.0, -0.72))
	for side in [-1.0, 1.0]:
		var rail := Kit.add_mesh(self, "CyanSplitCannonRail%s" % ("Left" if side < 0.0 else "Right"), Kit.capsule_mesh(0.050, 1.30, 8, 3), cyan)
		rail.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3(side * 0.24, 0.08, -0.82))

	var sight_block := Kit.add_mesh(self, "RaisedVioletTargetingCrest", Kit.box_mesh(Vector3(0.34, 0.18, 0.82)), violet_body, Vector3(0.0, 0.54, -0.20))
	sight_block.rotation.x = -PI * 0.05
	var sight_glint := Kit.add_mesh(self, "WhiteHotTargetingCrestLine", Kit.capsule_mesh(0.026, 0.66, 8, 3), white)
	sight_glint.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3(0.0, 0.66, -0.28))

	_muzzle_root = Node3D.new()
	_muzzle_root.name = "ChargedMuzzleAssembly"
	_muzzle_root.position = Vector3(0.0, 0.0, -1.42)
	add_child(_muzzle_root)
	Kit.add_mesh(_muzzle_root, "CyanControlledMuzzleShell", Kit.sphere_mesh(0.30, 12, 6), muzzle_shell)
	Kit.add_mesh(_muzzle_root, "WhiteHotMuzzleCore", Kit.sphere_mesh(0.13, 10, 5), white)
	var ring := Kit.add_mesh(_muzzle_root, "CyanMuzzleFocusRing", Kit.torus_mesh(0.36, 0.038, 30, 5), cyan)
	ring.rotation.x = PI * 0.5

	_spark_batch = Kit.create_spark_multimesh(self, "ShooterMuzzleChargeSparkBatch", Kit.sphere_mesh(0.046, 8, 4), cyan, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 4.6 + TAU * float(i) / float(_spark_count)
		var radius := 0.44 + sin(_time * 6.0 + float(i)) * 0.05
		var pos := Vector3(cos(phase) * radius, sin(phase * 1.3) * 0.20, -1.42 + sin(phase) * radius)
		var scale := 0.52 + sin(_time * 7.0 + float(i)) * 0.24
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.04, scale)), pos))
