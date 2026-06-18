import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_1/source/blender/sector_1_neon_grid_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_1/exported/sector_1_neon_grid_arena.glb"

ARENA_HALF_SIZE = 28.0
PANEL_COUNT = 7
PANEL_STEP = 8.0
PANEL_SIZE = 7.05
PANEL_THICKNESS = 0.34
FLOOR_TOP_Z = -0.012
PANEL_CENTER_Z = FLOOR_TOP_Z - PANEL_THICKNESS * 0.5
NEON_Z = 0.062


def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete()


def set_input(node, names, value) -> None:
    for name in names:
        if name in node.inputs:
            node.inputs[name].default_value = value
            return


def make_principled_material(name: str, color, metallic: float, roughness: float, emission=None, emission_strength: float = 0.0):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    bsdf = mat.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        set_input(bsdf, ["Base Color"], color)
        set_input(bsdf, ["Metallic"], metallic)
        set_input(bsdf, ["Roughness"], roughness)
        if emission is not None and emission_strength > 0.0:
            set_input(bsdf, ["Emission Color", "Emission"], emission)
            set_input(bsdf, ["Emission Strength"], emission_strength)
    mat.diffuse_color = color
    return mat


def make_materials() -> dict:
    return {
        "dark_aluminum": make_principled_material(
            "NS_S1_Dark_Brushed_Aluminum",
            (0.132, 0.140, 0.146, 1.0),
            0.88,
            0.36,
            (0.010, 0.036, 0.046, 1.0),
            0.018,
        ),
        "raised_gunmetal": make_principled_material(
            "NS_S1_Raised_Gunmetal_Panel",
            (0.178, 0.190, 0.198, 1.0),
            0.90,
            0.32,
            (0.012, 0.044, 0.054, 1.0),
            0.024,
        ),
        "edge_metal": make_principled_material(
            "NS_S1_Beveled_Edge_Gunmetal",
            (0.044, 0.052, 0.064, 1.0),
            0.82,
            0.48,
            (0.006, 0.026, 0.034, 1.0),
            0.014,
        ),
        "deep_metal": make_principled_material(
            "NS_S1_Dark_Depth_Metal",
            (0.024, 0.030, 0.040, 1.0),
            0.64,
            0.72,
            (0.004, 0.016, 0.024, 1.0),
            0.008,
        ),
        "cyan_neon": make_principled_material(
            "NS_S1_Dim_Cyan_Embedded_Channel",
            (0.000, 0.430, 0.620, 1.0),
            0.0,
            0.32,
            (0.000, 0.700, 0.880, 1.0),
            1.05,
        ),
        "cyan_core": make_principled_material(
            "NS_S1_Soft_Cyan_Rail_Core",
            (0.120, 0.620, 0.760, 1.0),
            0.0,
            0.26,
            (0.080, 0.780, 0.920, 1.0),
            1.45,
        ),
        "sheen": make_principled_material(
            "NS_S1_Cool_Aluminum_Sheen",
            (0.480, 0.610, 0.660, 1.0),
            0.68,
            0.20,
            (0.016, 0.052, 0.064, 1.0),
            0.045,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    for polygon in obj.data.polygons:
        polygon.use_smooth = True


def add_bevel(obj, amount: float, segments: int = 2) -> None:
    if amount <= 0.0:
        smooth_mesh_faces(obj)
        return
    bevel = obj.modifiers.new("real_beveled_edges", "BEVEL")
    bevel.width = amount
    bevel.segments = segments
    bevel.affect = "EDGES"
    smooth_mesh_faces(obj)


def add_box(root, name: str, location, size, material, bevel: float = 0.0, segments: int = 2):
    bpy.ops.mesh.primitive_cube_add(size=1.0, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.dimensions = size
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(material)
    add_bevel(obj, bevel, segments)
    obj.parent = root
    return obj


def add_cylinder_between(root, name: str, start, end, radius: float, material, vertices: int = 16):
    start_v = Vector(start)
    end_v = Vector(end)
    direction = end_v - start_v
    length = direction.length
    if length <= 0.001:
        return None
    mid = start_v + direction * 0.5
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=radius, depth=length, location=mid)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.rotation_euler = direction.to_track_quat("Z", "Y").to_euler()
    obj.data.materials.append(material)
    smooth_mesh_faces(obj)
    obj.parent = root
    return obj


def create_floor_panels(root, mats: dict) -> None:
	offset = float(PANEL_COUNT - 1) * PANEL_STEP * 0.5
	for row in range(PANEL_COUNT):
		for column in range(PANEL_COUNT):
			x = -offset + float(column) * PANEL_STEP
			y = -offset + float(row) * PANEL_STEP
			variation = [-0.014, -0.006, 0.006, 0.014][(row * 2 + column) % 4]
			mat = mats["raised_gunmetal"] if (row + column) % 3 == 1 else mats["dark_aluminum"]
			add_box(
				root,
				f"Sector1BlenderFloorPanelR{row}C{column}",
				(x, y, PANEL_CENTER_Z + variation),
				(PANEL_SIZE, PANEL_SIZE, PANEL_THICKNESS),
				mat,
				0.135,
				2,
			)
			add_box(
				root,
				f"Sector1BlenderInsetPlateR{row}C{column}",
				(x, y, FLOOR_TOP_Z + 0.038 + variation),
				(PANEL_SIZE - 1.34, PANEL_SIZE - 1.34, 0.052),
				mats["raised_gunmetal"] if (row + column) % 3 != 1 else mats["dark_aluminum"],
				0.070,
				1,
			)
			add_box(
				root,
				f"Sector1BlenderPanelNorthRaisedLipR{row}C{column}",
				(x, y - PANEL_SIZE * 0.5 + 0.42, FLOOR_TOP_Z + 0.040 + variation),
				(PANEL_SIZE - 1.18, 0.155, 0.044),
				mats["edge_metal"],
				0.026,
				1,
			)
			add_box(
				root,
				f"Sector1BlenderPanelSouthRaisedLipR{row}C{column}",
				(x, y + PANEL_SIZE * 0.5 - 0.42, FLOOR_TOP_Z + 0.040 + variation),
				(PANEL_SIZE - 1.18, 0.155, 0.044),
				mats["edge_metal"],
				0.026,
				1,
			)
			add_box(
				root,
				f"Sector1BlenderPanelWestRaisedLipR{row}C{column}",
				(x - PANEL_SIZE * 0.5 + 0.42, y, FLOOR_TOP_Z + 0.042 + variation),
				(0.155, PANEL_SIZE - 1.18, 0.044),
				mats["edge_metal"],
				0.026,
				1,
			)
			add_box(
				root,
				f"Sector1BlenderPanelEastRaisedLipR{row}C{column}",
				(x + PANEL_SIZE * 0.5 - 0.42, y, FLOOR_TOP_Z + 0.042 + variation),
				(0.155, PANEL_SIZE - 1.18, 0.044),
				mats["edge_metal"],
				0.026,
				1,
			)
			add_box(
				root,
				f"Sector1BlenderPanelBrushedGrooveAR{row}C{column}",
				(x - 0.52, y + 1.05, FLOOR_TOP_Z + 0.070 + variation),
				(PANEL_SIZE * 0.46, 0.052, 0.014),
				mats["deep_metal"],
				0.010,
				1,
			).rotation_euler.z = math.radians(4.0)
			add_box(
				root,
				f"Sector1BlenderPanelBrushedGrooveBR{row}C{column}",
				(x + 0.64, y - 1.18, FLOOR_TOP_Z + 0.071 + variation),
				(PANEL_SIZE * 0.34, 0.046, 0.014),
				mats["deep_metal"],
				0.010,
				1,
			).rotation_euler.z = math.radians(-4.0)
			if (row + column) % 3 == 0:
				strip = add_box(
					root,
					f"Sector1BlenderSheenStripR{row}C{column}",
					(x - 0.74, y - 1.08, FLOOR_TOP_Z + 0.082 + variation),
					(PANEL_SIZE * 0.38, 0.060, 0.010),
					mats["sheen"],
					0.012,
					1,
				)
				strip.rotation_euler.z = math.radians(7.0)
			for sx, sy in [(-2.46, -2.46), (2.46, 2.46)]:
				add_box(
					root,
					f"Sector1BlenderPanelAnchorR{row}C{column}_{sx:.0f}_{sy:.0f}",
					(x + sx, y + sy, FLOOR_TOP_Z + 0.070 + variation),
					(0.42, 0.24, 0.030),
					mats["edge_metal"],
					0.024,
					1,
				)


def create_neon_seams(root, mats: dict) -> None:
	boundaries = [-ARENA_HALF_SIZE + i * PANEL_STEP for i in range(PANEL_COUNT + 1)]
	for index, p in enumerate(boundaries):
		is_perimeter = index in [0, len(boundaries) - 1]
		channel_width = 0.150 if is_perimeter else 0.110
		add_box(
			root,
			f"Sector1BlenderRecessedMetalSeamX{index}",
			(0.0, p, FLOOR_TOP_Z + 0.040),
			(ARENA_HALF_SIZE * 2.0, channel_width, 0.042),
			mats["deep_metal"],
			0.018,
			2,
		)
		add_box(
			root,
			f"Sector1BlenderRecessedMetalSeamY{index}",
			(p, 0.0, FLOOR_TOP_Z + 0.042),
			(channel_width, ARENA_HALF_SIZE * 2.0, 0.042),
			mats["deep_metal"],
			0.018,
			2,
		)
		for segment_index, segment_center in enumerate([-20.0, -8.0, 8.0, 20.0]):
			if (index + segment_index) % 2 == 0:
				add_box(
					root,
					f"Sector1BlenderEmbeddedCyanAccentX{index}_{segment_index}",
					(segment_center, p, NEON_Z),
					(2.10, 0.038, 0.016),
					mats["cyan_neon"],
					0.010,
					1,
				)
			if (index + segment_index) % 2 == 1:
				add_box(
					root,
					f"Sector1BlenderEmbeddedCyanAccentY{index}_{segment_index}",
					(p, segment_center, NEON_Z + 0.004),
					(0.038, 2.10, 0.016),
					mats["cyan_neon"],
					0.010,
					1,
				)


def create_border_and_pylons(root, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    wall_height = 1.06
    wall_thickness = 1.02
    wall_center_z = 0.49
    long_size = half * 2.0 + wall_thickness
    add_box(root, "Sector1BlenderNorthRaisedBorderWall", (0.0, -half, wall_center_z), (long_size, wall_thickness, wall_height), mats["edge_metal"], 0.150, 2)
    add_box(root, "Sector1BlenderSouthRaisedBorderWall", (0.0, half, wall_center_z), (long_size, wall_thickness, wall_height), mats["edge_metal"], 0.150, 2)
    add_box(root, "Sector1BlenderWestRaisedBorderWall", (-half, 0.0, wall_center_z), (wall_thickness, long_size, wall_height), mats["edge_metal"], 0.150, 2)
    add_box(root, "Sector1BlenderEastRaisedBorderWall", (half, 0.0, wall_center_z), (wall_thickness, long_size, wall_height), mats["edge_metal"], 0.150, 2)

    rail_z = 1.08
    add_cylinder_between(root, "Sector1BlenderNorthCyanTopRail", (-half, -half, rail_z), (half, -half, rail_z), 0.048, mats["cyan_neon"], 16)
    add_cylinder_between(root, "Sector1BlenderSouthCyanTopRail", (-half, half, rail_z), (half, half, rail_z), 0.048, mats["cyan_neon"], 16)
    add_cylinder_between(root, "Sector1BlenderWestCyanTopRail", (-half, -half, rail_z), (-half, half, rail_z), 0.048, mats["cyan_neon"], 16)
    add_cylinder_between(root, "Sector1BlenderEastCyanTopRail", (half, -half, rail_z), (half, half, rail_z), 0.048, mats["cyan_neon"], 16)

    for i, (x, y) in enumerate([(-half, -half), (half, -half), (half, half), (-half, half)]):
        add_box(root, f"Sector1BlenderCornerPylonBase{i}", (x, y, 0.30), (1.62, 1.62, 0.60), mats["deep_metal"], 0.125, 2)
        add_box(root, f"Sector1BlenderCornerPylonCore{i}", (x, y, 0.96), (0.98, 0.98, 1.28), mats["edge_metal"], 0.105, 2)
        add_box(root, f"Sector1BlenderCornerPylonMetalCap{i}", (x, y, 1.66), (1.08, 1.08, 0.18), mats["edge_metal"], 0.060, 2)
        add_box(root, f"Sector1BlenderCornerPylonCyanSideSlitX{i}", (x, y + (0.56 if y < 0.0 else -0.56), 1.18), (0.56, 0.040, 0.12), mats["cyan_neon"], 0.010, 1)
        add_box(root, f"Sector1BlenderCornerPylonCyanSideSlitY{i}", (x + (0.56 if x < 0.0 else -0.56), y, 1.18), (0.040, 0.56, 0.12), mats["cyan_neon"], 0.010, 1)


def create_depth_and_detail(root, mats: dict) -> None:
    depth = ARENA_HALF_SIZE + 2.55
    for i, p in enumerate([-18.0, 0.0, 18.0]):
        add_box(root, f"Sector1BlenderNorthOuterButtress{i}", (p, -depth, 0.18), (7.6, 0.44, 0.34), mats["deep_metal"], 0.060, 1)
        add_box(root, f"Sector1BlenderSouthOuterButtress{i}", (p, depth, 0.18), (7.6, 0.44, 0.34), mats["deep_metal"], 0.060, 1)
        add_box(root, f"Sector1BlenderWestOuterButtress{i}", (-depth, p, 0.18), (0.44, 7.6, 0.34), mats["deep_metal"], 0.060, 1)
        add_box(root, f"Sector1BlenderEastOuterButtress{i}", (depth, p, 0.18), (0.44, 7.6, 0.34), mats["deep_metal"], 0.060, 1)
    add_cylinder_between(root, "Sector1BlenderNorthFarCyanRail", (-22.0, -depth, 0.48), (22.0, -depth, 0.48), 0.026, mats["cyan_neon"], 12)
    add_cylinder_between(root, "Sector1BlenderSouthFarCyanRail", (-22.0, depth, 0.48), (22.0, depth, 0.48), 0.026, mats["cyan_neon"], 12)
    add_cylinder_between(root, "Sector1BlenderWestFarCyanRail", (-depth, -22.0, 0.48), (-depth, 22.0, 0.48), 0.026, mats["cyan_neon"], 12)
    add_cylinder_between(root, "Sector1BlenderEastFarCyanRail", (depth, -22.0, 0.48), (depth, 22.0, 0.48), 0.026, mats["cyan_neon"], 12)


def setup_scene() -> None:
    clear_scene()
    bpy.context.scene.unit_settings.system = "METRIC"
    bpy.context.scene.render.engine = "CYCLES"
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector1_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.0, 0.004, 0.012)

    root = bpy.data.objects.new("Sector1BlenderArenaKitRoot", None)
    root.empty_display_type = "CUBE"
    root["neon_swarm_asset"] = "phase_38_sector_1_blender_arena_kit"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_floor_panels(root, mats)
    create_neon_seams(root, mats)
    create_border_and_pylons(root, mats)
    create_depth_and_detail(root, mats)

    camera_data = bpy.data.cameras.new("ReferenceGameplayCamera")
    camera = bpy.data.objects.new("ReferenceGameplayCamera", camera_data)
    camera.location = (0.0, -34.0, 33.0)
    camera.rotation_euler = (math.radians(54.0), 0.0, 0.0)
    camera_data.type = "ORTHO"
    camera_data.ortho_scale = 47.5
    bpy.context.collection.objects.link(camera)

    light_data = bpy.data.lights.new("ReferenceSoftPreviewAreaLight", "AREA")
    light = bpy.data.objects.new("ReferenceSoftPreviewAreaLight", light_data)
    light.location = (0.0, -8.0, 14.0)
    light_data.energy = 360.0
    light_data.size = 18.0
    bpy.context.collection.objects.link(light)


def export_assets() -> None:
    SOURCE_BLEND.parent.mkdir(parents=True, exist_ok=True)
    EXPORT_GLB.parent.mkdir(parents=True, exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(SOURCE_BLEND))
    bpy.ops.object.select_all(action="SELECT")
    try:
        bpy.ops.export_scene.gltf(
            filepath=str(EXPORT_GLB),
            export_format="GLB",
            use_selection=True,
            export_apply=True,
            export_cameras=False,
            export_lights=False,
            export_extras=True,
        )
    except TypeError:
        bpy.ops.export_scene.gltf(
            filepath=str(EXPORT_GLB),
            export_format="GLB",
            use_selection=True,
            export_cameras=False,
            export_lights=False,
            export_extras=True,
        )
    print(f"saved_blend={SOURCE_BLEND}")
    print(f"exported_glb={EXPORT_GLB}")


if __name__ == "__main__":
    setup_scene()
    export_assets()
