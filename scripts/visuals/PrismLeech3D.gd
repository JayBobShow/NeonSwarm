extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _core: Node3D
var _rings: Array[Node3D] = []
var _tethers: Array[MeshInstance3D] = []


func _ready() -> void:
	name = "PrismLeech3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.34
	rotation.x = sin(_time * 0.9) * 0.11
	if is_instance_valid(_core):
		_core.scale = Vector3.ONE * (1.0 + sin(_time * 2.8) * 0.045)
	for i in range(_rings.size()):
		var ring := _rings[i]
		ring.rotation.y += delta * (0.9 + float(i) * 0.36)
		ring.rotation.z += delta * (0.22 + float(i) * 0.11)
	for i in range(_tethers.size()):
		var angle := _time * 1.6 + TAU * float(i) / float(maxi(1, _tethers.size()))
		var start := Vector3(cos(angle) * 0.24, -0.18, sin(angle) * 0.24)
		var end := Vector3(cos(angle) * 1.05, -0.28 + sin(_time * 2.2 + float(i)) * 0.10, sin(angle) * 1.05)
		Kit.update_tube(_tethers[i], start, end, 0.030)


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 1.0, 0.88, 1.0), 7.9, false)
	var violet := Kit.make_emissive_material(Color(0.68, 0.08, 1.0, 0.90), 6.6, true)
	var teal := Kit.make_emissive_material(Color(0.0, 1.0, 0.78, 0.82), 5.8, true)
	var magenta := Kit.make_emissive_material(Color(1.0, 0.05, 0.82, 0.58), 4.2, true)
	var body_material := Kit.make_neon_body_material(Color(0.20, 0.02, 0.42, 1.0), 0.92)
	var shell := Kit.make_plasma_shell_material(Color(0.72, 0.08, 1.0, 0.11), 1.02, 1.34)

	_core = Node3D.new()
	_core.name = "PrismLeechDiamondPressureCore"
	add_child(_core)
	var body := Kit.add_mesh(_core, "DarkVioletLeechOctahedronBody", Kit.octahedron_mesh(0.86), body_material)
	body.scale = Vector3(0.78, 1.18, 0.78)
	var haze := Kit.add_mesh(_core, "ThinLeechPressureShell", Kit.octahedron_mesh(1.02), shell)
	haze.scale = Vector3(0.76, 1.10, 0.76)
	Kit.add_glowing_edges(_core, "PrismLeechDiamond", Kit.octahedron_points(0.96), Kit.octahedron_edges(), 0.070, 0.020, violet, white)
	Kit.add_mesh(_core, "WhiteHotDrainNode", Kit.sphere_mesh(0.20, 12, 6), white)

	for i in range(3):
		var ring_material: Material = teal if i % 2 == 0 else magenta
		var ring := Kit.add_mesh(self, "LeechDrainOrbitRing%d" % i, Kit.torus_mesh(0.76 + float(i) * 0.14, 0.024, 42, 5), ring_material)
		ring.rotation.x = PI * 0.5
		ring.rotation.z = float(i) * PI / 4.0
		_rings.append(ring)

	for i in range(4):
		_tethers.append(Kit.tube_between(self, "LeechPressureTether%d" % i, Vector3.ZERO, Vector3(0.0, 0.0, 0.8), 0.030, teal, 7))
