extends Node3D

const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")

var _time := 0.0
var _body: Node3D
var _rings: Array[Node3D] = []
var _spark_batch: MultiMeshInstance3D
var _spark_count := 14


func _ready() -> void:
	name = "Exploder3D"
	_build_visual()


func _process(delta: float) -> void:
	_time += delta
	var danger := 1.0 + sin(_time * 4.2) * 0.13
	if is_instance_valid(_body):
		_body.scale = Vector3.ONE * danger
	for i in range(_rings.size()):
		_rings[i].rotation.y += delta * (1.1 + float(i) * 0.5)
		_rings[i].rotation.x += delta * (0.32 + float(i) * 0.18)
		_rings[i].scale = Vector3.ONE * (1.0 + sin(_time * 3.5 + float(i)) * 0.08)
	_update_sparks()


func _build_visual() -> void:
	var white := Kit.make_emissive_material(Color(1.0, 0.98, 0.84, 1.0), 7.5, false)
	var red := Kit.make_emissive_material(Color(1.0, 0.03, 0.08, 0.96), 6.8, true)
	var orange := Kit.make_emissive_material(Color(1.0, 0.38, 0.02, 0.86), 5.7, true)
	var red_body := Kit.make_neon_body_material(Color(0.62, 0.0, 0.02, 1.0), 0.96)
	var shell := Kit.make_plasma_shell_material(Color(1.0, 0.03, 0.08, 0.12), 1.10, 1.26)
	var inner_shell := Kit.make_plasma_shell_material(Color(1.0, 0.36, 0.02, 0.080), 0.92, 1.58)

	_body = Node3D.new()
	_body.name = "UnstableSphereBodyAssembly"
	add_child(_body)
	Kit.add_mesh(_body, "RedReadableSphereBody", Kit.sphere_mesh(0.72, 18, 9), red_body)
	Kit.add_mesh(_body, "ControlledRedPlasmaShell", Kit.sphere_mesh(0.90, 18, 9), shell)
	Kit.add_mesh(_body, "InnerOrangePressureShell", Kit.sphere_mesh(0.52, 14, 7), inner_shell)
	Kit.add_mesh(_body, "WhiteHotOverloadCore", Kit.sphere_mesh(0.24, 10, 5), white)
	Kit.add_mesh(_body, "TopOrangePressureFuse", Kit.capsule_mesh(0.080, 0.66, 8, 3), orange, Vector3(0.0, 0.86, 0.0))
	Kit.add_mesh(_body, "TopWhiteHotFuseTip", Kit.sphere_mesh(0.105, 8, 4), white, Vector3(0.0, 1.20, 0.0))
	Kit.add_mesh(_body, "BottomWhiteHotVentNozzle", Kit.cylinder_mesh(0.12, 0.34, 10), white, Vector3(0.0, -0.86, 0.0))
	for i in range(6):
		var angle := TAU * float(i) / 6.0
		var charge := Kit.add_mesh(_body, "RaisedOrangePressureCharge%d" % i, Kit.box_mesh(Vector3(0.18, 0.14, 0.36)), orange, Vector3(cos(angle) * 0.78, 0.02, sin(angle) * 0.78))
		charge.rotation.y = PI * 0.5 - angle

	for i in range(3):
		var ring := Kit.add_mesh(self, "ExploderUnstableWarningTorus%d" % i, Kit.torus_mesh(0.94 + float(i) * 0.10, 0.058 - float(i) * 0.005, 48, 6), red if i != 1 else orange)
		ring.rotation.x = PI * 0.5
		ring.rotation.z = float(i) * PI / 3.0
		_rings.append(ring)

	_add_warning_spikes(red, white)
	_spark_batch = Kit.create_spark_multimesh(self, "ExploderLeakingIonSparkBatch", Kit.sphere_mesh(0.052, 8, 4), orange, _spark_count)
	_update_sparks()


func _add_warning_spikes(red: Material, white: Material) -> void:
	var points: Array = []
	var edges: Array = []
	for i in range(16):
		var angle := TAU * float(i) / 16.0
		var inner := Vector3(cos(angle) * 0.86, 0.05, sin(angle) * 0.86)
		var outer := Vector3(cos(angle) * 1.30, 0.10 + sin(angle * 3.0) * 0.10, sin(angle) * 1.30)
		points.append(inner)
		points.append(outer)
		edges.append([i * 2, i * 2 + 1])
	Kit.add_glowing_edges(self, "ExploderRadialWarningSpikes", points, edges, 0.058, 0.020, red, white)


func _update_sparks() -> void:
	if not is_instance_valid(_spark_batch):
		return
	for i in range(_spark_count):
		var phase := _time * 3.8 + TAU * float(i) / float(_spark_count)
		var radius := 1.18 + sin(_time * 7.0 + float(i)) * 0.14
		var pos := Vector3(cos(phase) * radius, sin(phase * 2.2) * 0.38, sin(phase) * radius)
		var scale := 0.50 + sin(_time * 8.0 + float(i)) * 0.25
		_spark_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * maxf(0.05, scale)), pos))
