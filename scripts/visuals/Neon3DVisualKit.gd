extends RefCounted

const LOCAL_ASSET_GLOW_TUNE := 1.36
const BODY_FACE_EMISSION_BIAS := 0.68
const PLASMA_HAZE_EMISSION_BIAS := 0.84


static func make_emissive_material(color: Color, energy: float, transparent := true) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	material.emission_enabled = true
	material.emission = Color(color.r, color.g, color.b, 1.0)
	material.emission_energy_multiplier = energy * LOCAL_ASSET_GLOW_TUNE
	if transparent or color.a < 0.99:
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
		material.no_depth_test = false
	return material


static func make_neon_body_material(color: Color, energy: float) -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, depth_draw_opaque, cull_back;

uniform vec4 body_color : source_color = vec4(0.0, 0.8, 1.0, 1.0);
uniform float emission_strength = 1.2;
uniform float rim_strength = 1.70;
uniform float rim_power = 2.18;

void fragment() {
	float ndv = clamp(abs(dot(normalize(NORMAL), normalize(VIEW))), 0.0, 1.0);
	float rim = pow(1.0 - ndv, rim_power);
	vec3 base = body_color.rgb * (0.18 + rim * 0.12);
	vec3 edge = body_color.rgb * emission_strength * (0.12 + rim * rim_strength);
	ALBEDO = base;
	EMISSION = edge;
	ALPHA = 1.0;
}
"""
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("body_color", color)
	material.set_shader_parameter("emission_strength", energy * LOCAL_ASSET_GLOW_TUNE * BODY_FACE_EMISSION_BIAS)
	material.set_shader_parameter("rim_strength", 1.70)
	material.set_shader_parameter("rim_power", 2.18)
	return material


static func make_plasma_shell_material(color: Color, energy: float, rim_power: float) -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_mix, depth_draw_never, cull_back;

uniform vec4 plasma_color : source_color = vec4(0.0, 0.85, 1.0, 0.35);
uniform float emission_strength = 4.0;
uniform float rim_power = 1.4;
uniform float flicker_scale = 0.08;

void fragment() {
	float fresnel = pow(1.0 - clamp(abs(dot(normalize(NORMAL), normalize(VIEW))), 0.0, 1.0), rim_power);
	float plasma = clamp(0.052 + fresnel * 0.64, 0.0, 1.0);
	ALBEDO = plasma_color.rgb * plasma;
	EMISSION = plasma_color.rgb * emission_strength * plasma;
	ALPHA = plasma_color.a * plasma;
}
"""
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("plasma_color", color)
	material.set_shader_parameter("emission_strength", energy * LOCAL_ASSET_GLOW_TUNE * PLASMA_HAZE_EMISSION_BIAS)
	material.set_shader_parameter("rim_power", rim_power)
	return material


static func add_mesh(parent: Node3D, node_name: String, mesh: Mesh, material: Material, position := Vector3.ZERO) -> MeshInstance3D:
	var instance := MeshInstance3D.new()
	instance.name = node_name
	instance.mesh = mesh
	instance.position = position
	if material:
		instance.material_override = material
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	parent.add_child(instance)
	return instance


static func add_label(parent: Node3D, text: String, position: Vector3) -> Label3D:
	var label := Label3D.new()
	label.name = "%sLabel" % text.replace(" ", "")
	label.text = text
	label.pixel_size = 0.022
	label.font_size = 24
	label.modulate = Color(0.72, 0.95, 1.0, 0.90)
	label.outline_size = 8
	label.outline_modulate = Color(0.0, 0.08, 0.16, 0.90)
	label.position = position
	parent.add_child(label)
	return label


static func sphere_mesh(radius: float, radial_segments: int, rings: int) -> SphereMesh:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0
	mesh.radial_segments = radial_segments
	mesh.rings = rings
	return mesh


static func box_mesh(size: Vector3) -> BoxMesh:
	var mesh := BoxMesh.new()
	mesh.size = size
	return mesh


static func capsule_mesh(radius: float, height: float, radial_segments: int, rings: int) -> CapsuleMesh:
	var mesh := CapsuleMesh.new()
	mesh.radius = radius
	mesh.height = height
	mesh.radial_segments = radial_segments
	mesh.rings = rings
	return mesh


static func cylinder_mesh(radius: float, height: float, radial_segments: int) -> CylinderMesh:
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height
	mesh.radial_segments = radial_segments
	mesh.rings = 1
	return mesh


static func torus_mesh(radius: float, tube_radius: float, ring_segments: int, rings: int) -> TorusMesh:
	var mesh := TorusMesh.new()
	mesh.inner_radius = maxf(0.01, radius - tube_radius)
	mesh.outer_radius = radius + tube_radius
	mesh.ring_segments = ring_segments
	mesh.rings = rings
	return mesh


static func octahedron_mesh(size: float) -> ArrayMesh:
	return mesh_from_arrays(PackedVector3Array(octahedron_points(size)), PackedInt32Array([
		0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 1,
		5, 2, 1, 5, 3, 2, 5, 4, 3, 5, 1, 4
	]))


static func tetrahedron_arrow_mesh() -> ArrayMesh:
	return mesh_from_arrays(PackedVector3Array(tetrahedron_arrow_points()), PackedInt32Array([
		0, 1, 2,
		0, 3, 1,
		0, 2, 3,
		1, 3, 2
	]))


static func hex_prism_mesh(radius: float, height: float) -> ArrayMesh:
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()
	for y in [-height * 0.5, height * 0.5]:
		for i in range(6):
			var angle := TAU * float(i) / 6.0 + PI / 6.0
			vertices.append(Vector3(cos(angle) * radius, y, sin(angle) * radius))
	for i in range(6):
		var next := (i + 1) % 6
		indices.append_array(PackedInt32Array([i, next, i + 6, next, next + 6, i + 6]))
	for i in range(1, 5):
		indices.append_array(PackedInt32Array([0, i, i + 1]))
		indices.append_array(PackedInt32Array([6, 6 + i + 1, 6 + i]))
	return mesh_from_arrays(vertices, indices)


static func octagonal_prism_mesh(radius: float, height: float) -> ArrayMesh:
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()
	for y in [-height * 0.5, height * 0.5]:
		for i in range(8):
			var angle := TAU * float(i) / 8.0 + PI / 8.0
			vertices.append(Vector3(cos(angle) * radius, y, sin(angle) * radius))
	for i in range(8):
		var next := (i + 1) % 8
		indices.append_array(PackedInt32Array([i, next, i + 8, next, next + 8, i + 8]))
	for i in range(1, 7):
		indices.append_array(PackedInt32Array([0, i, i + 1]))
		indices.append_array(PackedInt32Array([8, 8 + i + 1, 8 + i]))
	return mesh_from_arrays(vertices, indices)


static func triangular_prism_mesh(width: float, height: float, depth: float) -> ArrayMesh:
	var w := width * 0.5
	var h := height * 0.5
	var d := depth * 0.5
	var vertices := PackedVector3Array([
		Vector3(0.0, h, -d), Vector3(-w, -h, -d), Vector3(w, -h, -d),
		Vector3(0.0, h, d), Vector3(-w, -h, d), Vector3(w, -h, d)
	])
	var indices := PackedInt32Array([
		0, 1, 2, 3, 5, 4,
		0, 3, 4, 0, 4, 1,
		1, 4, 5, 1, 5, 2,
		2, 5, 3, 2, 3, 0
	])
	return mesh_from_arrays(vertices, indices)


static func mesh_from_arrays(vertices: PackedVector3Array, indices: PackedInt32Array) -> ArrayMesh:
	var flat_vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	for i in range(0, indices.size(), 3):
		var a := vertices[indices[i]]
		var b := vertices[indices[i + 1]]
		var c := vertices[indices[i + 2]]
		var normal := (b - a).cross(c - a).normalized()
		flat_vertices.append(a)
		flat_vertices.append(b)
		flat_vertices.append(c)
		normals.append(normal)
		normals.append(normal)
		normals.append(normal)
	var arrays: Array = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = flat_vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh


static func tube_between(parent: Node3D, node_name: String, start: Vector3, end: Vector3, radius: float, material: Material, radial_segments := 8) -> MeshInstance3D:
	var mesh := cylinder_mesh(radius, maxf(start.distance_to(end), 0.001), radial_segments)
	var tube := add_mesh(parent, node_name, mesh, material)
	update_tube(tube, start, end, radius)
	return tube


static func update_tube(tube: MeshInstance3D, start: Vector3, end: Vector3, radius: float) -> void:
	var delta := end - start
	var length := delta.length()
	if length < 0.001:
		tube.visible = false
		return
	tube.visible = true
	var mesh := tube.mesh as CylinderMesh
	if mesh:
		mesh.height = length
		mesh.top_radius = radius
		mesh.bottom_radius = radius
	tube.transform = Transform3D(basis_from_y_axis(delta.normalized()), (start + end) * 0.5)


static func tube_edge_mesh(points: Array, edges: Array, radius: float, radial_segments: int) -> ArrayMesh:
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()
	for edge in edges:
		append_tube(vertices, indices, points[edge[0]], points[edge[1]], radius, radial_segments)
	return mesh_from_arrays(vertices, indices)


static func append_tube(vertices: PackedVector3Array, indices: PackedInt32Array, start: Vector3, end: Vector3, radius: float, radial_segments: int) -> void:
	var direction := end - start
	var length := direction.length()
	if length < 0.001:
		return
	var basis := basis_from_y_axis(direction.normalized())
	var center := (start + end) * 0.5
	var base_index := vertices.size()
	for i in range(radial_segments):
		var angle := TAU * float(i) / float(radial_segments)
		var ring := Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)
		vertices.append(center + basis * (ring + Vector3(0.0, -length * 0.5, 0.0)))
		vertices.append(center + basis * (ring + Vector3(0.0, length * 0.5, 0.0)))
	for i in range(radial_segments):
		var next := (i + 1) % radial_segments
		var a := base_index + i * 2
		var b := base_index + next * 2
		var c := base_index + i * 2 + 1
		var d := base_index + next * 2 + 1
		indices.append_array(PackedInt32Array([a, c, b, b, c, d]))


static func add_glowing_edges(parent: Node3D, prefix: String, points: Array, edges: Array, outer_radius: float, core_radius: float, outer_material: Material, core_material: Material) -> void:
	add_mesh(parent, prefix + "OuterNeonTubes", tube_edge_mesh(points, edges, outer_radius, 10), outer_material)
	add_mesh(parent, prefix + "WhiteHotTubeCores", tube_edge_mesh(points, edges, core_radius, 8), core_material)


static func create_spark_multimesh(parent: Node3D, node_name: String, mesh: Mesh, material: Material, count: int) -> MultiMeshInstance3D:
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = mesh
	multimesh.instance_count = count
	var instance := MultiMeshInstance3D.new()
	instance.name = node_name
	instance.multimesh = multimesh
	instance.material_override = material
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	parent.add_child(instance)
	return instance


static func basis_from_y_axis(axis: Vector3) -> Basis:
	var y := axis.normalized()
	var x := Vector3.FORWARD.cross(y)
	if x.length_squared() < 0.001:
		x = Vector3.RIGHT.cross(y)
	x = x.normalized()
	var z := x.cross(y).normalized()
	return Basis(x, y, z)


static func octahedron_points(size: float) -> Array:
	return [
		Vector3(0.0, size, 0.0),
		Vector3(size, 0.0, 0.0),
		Vector3(0.0, 0.0, size),
		Vector3(-size, 0.0, 0.0),
		Vector3(0.0, 0.0, -size),
		Vector3(0.0, -size, 0.0)
	]


static func octahedron_edges() -> Array:
	return [[0, 1], [0, 2], [0, 3], [0, 4], [5, 1], [5, 2], [5, 3], [5, 4], [1, 2], [2, 3], [3, 4], [4, 1]]


static func tetrahedron_arrow_points() -> Array:
	return [
		Vector3(0.0, 0.34, -1.30),
		Vector3(-0.78, -0.30, 0.62),
		Vector3(0.78, -0.30, 0.62),
		Vector3(0.0, 0.86, 0.12)
	]


static func tetrahedron_edges() -> Array:
	return [[0, 1], [0, 2], [0, 3], [1, 2], [1, 3], [2, 3]]


static func box_points(size: Vector3) -> Array:
	var x := size.x * 0.5
	var y := size.y * 0.5
	var z := size.z * 0.5
	return [
		Vector3(-x, -y, -z), Vector3(x, -y, -z), Vector3(x, -y, z), Vector3(-x, -y, z),
		Vector3(-x, y, -z), Vector3(x, y, -z), Vector3(x, y, z), Vector3(-x, y, z)
	]


static func box_edges() -> Array:
	return [[0, 1], [1, 2], [2, 3], [3, 0], [4, 5], [5, 6], [6, 7], [7, 4], [0, 4], [1, 5], [2, 6], [3, 7]]


static func hex_prism_points(radius: float, height: float) -> Array:
	var points: Array = []
	for y in [-height * 0.5, height * 0.5]:
		for i in range(6):
			var angle := TAU * float(i) / 6.0 + PI / 6.0
			points.append(Vector3(cos(angle) * radius, y, sin(angle) * radius))
	return points


static func hex_prism_edges() -> Array:
	var edges: Array = []
	for i in range(6):
		var next := (i + 1) % 6
		edges.append([i, next])
		edges.append([i + 6, next + 6])
		edges.append([i, i + 6])
	return edges


static func octagonal_prism_points(radius: float, height: float) -> Array:
	var points: Array = []
	for y in [-height * 0.5, height * 0.5]:
		for i in range(8):
			var angle := TAU * float(i) / 8.0 + PI / 8.0
			points.append(Vector3(cos(angle) * radius, y, sin(angle) * radius))
	return points


static func octagonal_prism_edges() -> Array:
	var edges: Array = []
	for i in range(8):
		var next := (i + 1) % 8
		edges.append([i, next])
		edges.append([i + 8, next + 8])
		edges.append([i, i + 8])
	return edges
