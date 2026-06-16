extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _haze: Node3D
var _trail_tubes: Array[MeshInstance3D] = []


func _ready() -> void:
	name = "Projectile3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	if is_instance_valid(_haze):
		_haze.scale = Vector3.ONE * (1.0 + sin(_time * 6.2) * 0.08)
	for i in range(_trail_tubes.size()):
		var start := Vector3(0.0, 0.0, 0.58 + float(i) * 0.30)
		var end := start + Vector3(0.0, 0.0, 0.92 - float(i) * 0.17)
		Kit.update_tube(_trail_tubes[i], start, end, lerpf(0.048, 0.014, float(i) / float(maxi(1, _trail_tubes.size() - 1))))


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.99, 0.86, 1.0), 8.4, false)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.94, 1.0, 0.92), 6.8, true)
	var blue_haze := Kit.make_emissive_material(Color(0.0, 0.58, 1.0, 0.062), 1.16, true)
	var shell := Kit.make_plasma_shell_material(Color(0.0, 0.82, 1.0, 0.075), 1.02, 1.36)

	_haze = Node3D.new()
	_haze.name = "BoltPlasmaHazeAssembly"
	add_child(_haze)
	var haze_capsule := Kit.add_mesh(_haze, "BlueControlledPlasmaHazeCapsule", Kit.capsule_mesh(0.25, 1.54, 12, 4), shell)
	var body := Kit.add_mesh(self, "CyanEnergyBoltBody", Kit.capsule_mesh(0.16, 1.18, 12, 4), cyan)
	var core := Kit.add_mesh(self, "WhiteHotNeedleCore", Kit.capsule_mesh(0.076, 1.36, 10, 3), white)
	haze_capsule.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3.ZERO)
	body.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3.ZERO)
	core.transform = Transform3D(Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0)), Vector3.ZERO)

	for i in range(2):
		_trail_tubes.append(Kit.tube_between(self, "ProjectileStackedGhostTrail%d" % i, Vector3.ZERO, Vector3(0.0, 0.0, 1.0), 0.038, blue_haze, 8))
