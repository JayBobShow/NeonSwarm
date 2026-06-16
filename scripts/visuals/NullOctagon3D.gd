extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _core: Node3D
var _cage: Node3D
var _rings: Array[Node3D] = []
var _spark_batch: MultiMeshInstance3D
var _spark_count := 28


func _ready() -> void:
	name = "NullOctagon3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.22
	rotation.x = sin(_time * 0.5) * 0.06
	if is_instance_valid(_core):
		_core.scale = Vector3.ONE * (1.0 + sin(_time * 2.0) * 0.035)
	if is_instance_valid(_cage):
		_cage.rotation.y -= delta * 0.58
		_cage.rotation.z = sin(_time * 0.8) * 0.10
	for i in range(_rings.size()):
		var ring := _rings[i]
		ring.rotation.y += delta * (0.34 + float(i) * 0.18)
		ring.rotation.x += delta * (0.18 + float(i) * 0.08)
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 1.0, 0.88, 1.0), 8.6, false)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.92), 7.2, true)
	var magenta := Kit.make_emissive_material(Color(1.0, 0.04, 0.86, 0.88), 7.0, true)
	var fracture := Kit.make_emissive_material(Color(0.72, 1.0, 1.0, 0.48), 3.6, true)
	var body_material := Kit.make_neon_body_material(Color(0.015, 0.012, 0.042, 1.0), 1.08)
	var shell := Kit.make_plasma_shell_material(Color(0.0, 0.20, 0.42, 0.10), 1.06, 1.22)

	_core = Node3D.new()
	_core.name = "NullOctagonBlackGlassCore"
	add_child(_core)
	var body := Kit.add_mesh(_core, "BlackGlassOctagonalCommandBody", Kit.octagonal_prism_mesh(1.18, 0.56), body_material)
	body.rotation.x = PI * 0.5
	var haze := Kit.add_mesh(_core, "ControlledNullBlueShell", Kit.octagonal_prism_mesh(1.34, 0.62), shell)
	haze.rotation.x = PI * 0.5
	Kit.add_glowing_edges(_core, "NullOctagonBody", Kit.octagonal_prism_points(1.28, 0.68), Kit.octagonal_prism_edges(), 0.124, 0.034, cyan, white)
	Kit.add_mesh(_core, "WhiteHotNullReactor", Kit.sphere_mesh(0.32, 14, 7), white)

	for i in range(8):
		var angle := TAU * float(i) / 8.0
		var dir := Vector3(cos(angle), 0.0, sin(angle))
		Kit.tube_between(_core, "CyanMagentaFractureLine%d" % i, dir * 0.24 + Vector3(0.0, 0.20, 0.0), dir * 1.20 + Vector3(0.0, 0.20, 0.0), 0.030, fracture if i % 2 == 0 else magenta, 7)
		Kit.add_mesh(_core, "NullOctagonVertexBeacon%d" % i, Kit.sphere_mesh(0.075, 8, 4), white, dir * 1.32)

	_cage = Node3D.new()
	_cage.name = "NullOctagonRotatingFractureCage"
	add_child(_cage)
	for i in range(4):
		var ring_material: Material = cyan if i % 2 == 0 else magenta
		var ring := Kit.add_mesh(_cage, "NullOctagonWarningCageRing%d" % i, Kit.torus_mesh(1.74 + float(i) * 0.12, 0.034, 8, 5), ring_material)
		ring.rotation.x = PI * 0.5
		ring.rotation.z = float(i) * PI / 8.0
		_rings.append(ring)

	_spark_batch = Kit.create_spark_multimesh(self, "NullOctagonFractureSparkBatch", Kit.triangular_prism_mesh(0.12, 0.09, 0.22), cyan, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 2.2 + TAU * float(i) / float(_spark_count)
		var radius := 1.45 + sin(_time * 3.0 + float(i)) * 0.24
		var pos := Vector3(cos(phase) * radius, sin(phase * 1.7) * 0.52, sin(phase) * radius)
		var basis := Kit.basis_from_y_axis(Vector3(cos(phase), 0.18, sin(phase)).normalized()).rotated(Vector3.UP, phase)
		var scale := 0.58 + sin(_time * 5.0 + float(i)) * 0.22
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(basis.scaled(Vector3.ONE * maxf(0.05, scale)), pos))
