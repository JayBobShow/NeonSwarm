extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _body: Node3D
var _ring_a: Node3D
var _ring_b: Node3D
var _ring_c: Node3D
var _spark_batch: MultiMeshInstance3D
var _spark_count := 12


func _ready() -> void:
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	position.y += sin(_time * 2.8) * 0.0008
	if is_instance_valid(_body):
		_body.scale = Vector3.ONE * (1.0 + sin(_time * 4.2) * 0.10)
	if is_instance_valid(_ring_a):
		_ring_a.rotation.y += delta * 3.6
	if is_instance_valid(_ring_b):
		_ring_b.rotation.x += delta * 3.0
	if is_instance_valid(_ring_c):
		_ring_c.rotation.z -= delta * 4.1
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 1.0, 0.88, 1.0), 8.8, false)
	var gold := Kit.make_emissive_material(Color(1.0, 0.94, 0.02, 0.98), 7.7, true)
	var cyan := Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.84), 6.2, true)
	var magenta := Kit.make_emissive_material(Color(1.0, 0.06, 0.90, 0.68), 4.8, true)
	var green := Kit.make_emissive_material(Color(0.48, 1.0, 0.18, 0.78), 5.0, true)
	var gold_body := Kit.make_neon_body_material(Color(0.50, 0.34, 0.0, 1.0), 1.05)
	var shell := Kit.make_plasma_shell_material(Color(1.0, 0.86, 0.04, 0.13), 1.24, 1.22)

	_body = Node3D.new()
	_body.name = "PremiumGeometricRewardCore"
	add_child(_body)
	Kit.add_mesh(_body, "GoldHexCoinPickupBackplate", Kit.hex_prism_mesh(0.54, 0.08), gold_body)
	Kit.add_glowing_edges(_body, "XPRewardHexCoin", Kit.hex_prism_points(0.58, 0.10), Kit.hex_prism_edges(), 0.032, 0.010, gold, white)
	var gem := Kit.add_mesh(_body, "DarkGoldOctahedronRewardFacetBody", Kit.octahedron_mesh(0.38), gold_body)
	gem.scale = Vector3(0.82, 1.16, 0.82)
	Kit.add_mesh(_body, "ControlledGoldPlasmaHalo", Kit.sphere_mesh(0.58, 14, 7), shell)
	Kit.add_glowing_edges(_body, "XPRewardOctahedron", Kit.octahedron_points(0.42), Kit.octahedron_edges(), 0.036, 0.012, gold, white)
	Kit.add_mesh(_body, "WhiteHotRewardPoint", Kit.sphere_mesh(0.155, 10, 5), white)
	Kit.add_mesh(_body, "WhiteHotXPPlusHorizontalStroke", Kit.box_mesh(Vector3(0.56, 0.052, 0.12)), white, Vector3(0.0, 0.31, 0.0))
	Kit.add_mesh(_body, "WhiteHotXPPlusVerticalStroke", Kit.box_mesh(Vector3(0.12, 0.052, 0.56)), white, Vector3(0.0, 0.31, 0.0))
	_ring_a = Kit.add_mesh(self, "CyanAbsorptionOrbitRing", Kit.torus_mesh(0.64, 0.044, 38, 5), cyan)
	_ring_b = Kit.add_mesh(self, "GoldValueOrbitRing", Kit.torus_mesh(0.49, 0.036, 36, 5), gold)
	_ring_c = Kit.add_mesh(self, "MagentaCoverArtGlintRing", Kit.torus_mesh(0.34, 0.018, 28, 4), magenta)
	_ring_a.rotation.x = PI * 0.5
	_ring_b.rotation.z = PI * 0.5
	_ring_c.rotation.y = PI * 0.5
	var value_glint := Kit.add_mesh(self, "TinyGreenValueGlintRing", Kit.torus_mesh(0.30, 0.018, 24, 4), green)
	value_glint.rotation.y = PI * 0.5
	_spark_batch = Kit.create_spark_multimesh(self, "XPOrbTinySparkleBatch", Kit.sphere_mesh(0.034, 8, 4), white, _spark_count)
	_update_sparks()


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 4.2 + TAU * float(i) / float(_spark_count)
		var radius := 0.76 + sin(_time * 6.0 + float(i)) * 0.07
		var pos := Vector3(cos(phase) * radius, sin(phase * 1.9) * 0.22, sin(phase) * radius)
		var scale := 0.72 + sin(_time * 8.5 + float(i)) * 0.28
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.04, scale)), pos))
