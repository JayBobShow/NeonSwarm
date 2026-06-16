extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _pulse_nodes: Array[Node3D] = []
var _corner_nodes: Array[Node3D] = []


func _ready() -> void:
	name = "Tank3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	rotation.y += delta * 0.20
	for i in range(_pulse_nodes.size()):
		var pulse := 1.0 + sin(_time * 1.15 + float(i) * 0.6) * 0.035
		_pulse_nodes[i].scale = Vector3.ONE * pulse
	for i in range(_corner_nodes.size()):
		var node := _corner_nodes[i]
		node.position.y = node.get_meta("base_y") + sin(_time * 1.8 + float(i)) * 0.035


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.98, 0.84, 1.0), 7.0, false)
	var gold := Kit.make_emissive_material(Color(1.0, 0.72, 0.03, 0.94), 6.4, true)
	var orange := Kit.make_emissive_material(Color(1.0, 0.32, 0.02, 0.78), 5.0, true)
	var amber_body := Kit.make_neon_body_material(Color(0.58, 0.22, 0.0, 1.0), 0.95)
	var deep_shell := Kit.make_plasma_shell_material(Color(1.0, 0.28, 0.02, 0.075), 0.92, 1.48)

	var size := Vector3(1.46, 0.92, 1.46)
	var points := Kit.box_points(size)
	_pulse_nodes.append(Kit.add_mesh(self, "HeavyCuboidReadableBody", Kit.box_mesh(size), amber_body))
	var outer := Kit.add_mesh(self, "ControlledRectangularHeatHaze", Kit.box_mesh(size * 1.12), deep_shell)
	_pulse_nodes.append(outer)
	var side_plate_size := Vector3(0.24, 0.52, 1.78)
	Kit.add_mesh(self, "LeftHeavyTreadArmorSlab", Kit.box_mesh(side_plate_size), amber_body, Vector3(-0.96, -0.12, 0.0))
	Kit.add_mesh(self, "RightHeavyTreadArmorSlab", Kit.box_mesh(side_plate_size), amber_body, Vector3(0.96, -0.12, 0.0))
	Kit.add_mesh(self, "ForwardOrangeSiegePlow", Kit.box_mesh(Vector3(1.80, 0.46, 0.18)), orange, Vector3(0.0, -0.08, -0.96))
	Kit.add_mesh(self, "RearGoldEngineCounterweight", Kit.box_mesh(Vector3(0.92, 0.34, 0.20)), gold, Vector3(0.0, -0.18, 0.98))

	Kit.add_glowing_edges(self, "TankCorner", points, Kit.box_edges(), 0.122, 0.032, gold, white)
	Kit.add_glowing_edges(self, "TankInternalLoadBearingCross", points, [[0, 6], [1, 7], [2, 4], [3, 5]], 0.050, 0.016, orange, white)
	Kit.add_mesh(self, "WhiteHotHeavyReactor", Kit.sphere_mesh(0.26, 12, 6), white)

	for corner in [Vector3(-0.82, 0.48, -0.82), Vector3(0.82, 0.48, -0.82), Vector3(0.82, 0.48, 0.82), Vector3(-0.82, 0.48, 0.82)]:
		var pylon := Node3D.new()
		pylon.name = "TankCornerPlasmaPylon"
		pylon.position = corner
		pylon.set_meta("base_y", corner.y)
		add_child(pylon)
		Kit.add_mesh(pylon, "PylonAmberCore", Kit.sphere_mesh(0.13, 8, 4), gold)
		var cap := Kit.add_mesh(pylon, "PylonWhiteHotCap", Kit.cylinder_mesh(0.052, 0.32, 8), white)
		cap.rotation.x = PI * 0.5
		_corner_nodes.append(pylon)
