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
PANEL_SIZE = 7.18
PANEL_THICKNESS = 0.16
PANEL_CENTER_Z = -0.092
FLOOR_TOP_Z = -0.012
NEON_Z = 0.044


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
            (0.105, 0.116, 0.125, 1.0),
            0.82,
            0.46,
            (0.025, 0.075, 0.095, 1.0),
            0.045,
        ),
        "raised_gunmetal": make_principled_material(
            "NS_S1_Raised_Gunmetal_Panel",
            (0.150, 0.164, 0.174, 1.0),
            0.86,
            0.39,
            (0.030, 0.090, 0.110, 1.0),
            0.055,
        ),
        "edge_metal": make_principled_material(
            "NS_S1_Beveled_Edge_Gunmetal",
            (0.065, 0.078, 0.092, 1.0),
            0.76,
            0.52,
            (0.015, 0.050, 0.070, 1.0),
            0.030,
        ),
        "deep_metal": make_principled_material(
            "NS_S1_Dark_Depth_Metal",
            (0.040, 0.050, 0.064, 1.0),
            0.58,
            0.66,
            (0.010, 0.036, 0.055, 1.0),
            0.020,
        ),
        "cyan_neon": make_principled_material(
            "NS_S1_Cyan_Neon_Channel",
            (0.000, 0.740, 1.000, 1.0),
            0.0,
            0.24,
            (0.000, 0.920, 1.000, 1.0),
            2.60,
        ),
        "cyan_core": make_principled_material(
            "NS_S1_White_Cyan_Hot_Core",
            (0.720, 0.965, 1.000, 1.0),
            0.0,
            0.16,
            (0.720, 0.980, 1.000, 1.0),
            4.20,
        ),
        "sheen": make_principled_material(
            "NS_S1_Cool_Aluminum_Sheen",
            (0.380, 0.560, 0.640, 1.0),
            0.35,
            0.18,
            (0.060, 0.180, 0.230, 1.0),
            0.18,
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
            variation = 0.006 if (row + column) % 2 == 0 else -0.004
            mat = mats["raised_gunmetal"] if (row + column) % 3 == 1 else mats["dark_aluminum"]
            add_box(
                root,
                f"Sector1BlenderFloorPanelR{row}C{column}",
                (x, y, PANEL_CENTER_Z + variation),
                (PANEL_SIZE, PANEL_SIZE, PANEL_THICKNESS),
                mat,
                0.075,
                2,
            )
            add_box(
                root,
                f"Sector1BlenderInsetPlateR{row}C{column}",
                (x, y, FLOOR_TOP_Z + 0.016 + variation),
                (PANEL_SIZE - 1.28, PANEL_SIZE - 1.28, 0.028),
                mats["raised_gunmetal"] if (row + column) % 3 != 1 else mats["dark_aluminum"],
                0.045,
                1,
            )
            if (row + column) % 2 == 0:
                strip = add_box(
                    root,
                    f"Sector1BlenderSheenStripR{row}C{column}",
                    (x - 0.74, y - 1.08, NEON_Z - 0.032),
                    (PANEL_SIZE * 0.48, 0.085, 0.012),
                    mats["sheen"],
                    0.018,
                    1,
                )
                strip.rotation_euler.z = math.radians(7.0)
            for sx, sy in [(-2.72, -2.72), (2.72, -2.72), (2.72, 2.72), (-2.72, 2.72)]:
                add_box(
                    root,
                    f"Sector1BlenderPanelAnchorR{row}C{column}_{sx:.0f}_{sy:.0f}",
                    (x + sx, y + sy, FLOOR_TOP_Z + 0.044 + variation),
                    (0.34, 0.34, 0.030),
                    mats["edge_metal"],
                    0.035,
                    1,
                )


def create_neon_seams(root, mats: dict) -> None:
    boundaries = [-ARENA_HALF_SIZE + i * PANEL_STEP for i in range(PANEL_COUNT + 1)]
    for index, p in enumerate(boundaries):
        major = index in [0, len(boundaries) - 1] or index == len(boundaries) // 2
        width = 0.135 if major else 0.080
        height = 0.034 if major else 0.024
        mat = mats["cyan_core"] if major else mats["cyan_neon"]
        add_box(
            root,
            f"Sector1BlenderNeonSeamX{index}",
            (0.0, p, NEON_Z),
            (ARENA_HALF_SIZE * 2.0, width, height),
            mat,
            width * 0.22,
            2,
        )
        add_box(
            root,
            f"Sector1BlenderNeonSeamY{index}",
            (p, 0.0, NEON_Z + 0.006),
            (width, ARENA_HALF_SIZE * 2.0, height),
            mat,
            width * 0.22,
            2,
        )


def create_border_and_pylons(root, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    wall_height = 0.74
    wall_thickness = 0.82
    wall_center_z = 0.34
    long_size = half * 2.0 + wall_thickness
    add_box(root, "Sector1BlenderNorthRaisedBorderWall", (0.0, -half, wall_center_z), (long_size, wall_thickness, wall_height), mats["edge_metal"], 0.090, 2)
    add_box(root, "Sector1BlenderSouthRaisedBorderWall", (0.0, half, wall_center_z), (long_size, wall_thickness, wall_height), mats["edge_metal"], 0.090, 2)
    add_box(root, "Sector1BlenderWestRaisedBorderWall", (-half, 0.0, wall_center_z), (wall_thickness, long_size, wall_height), mats["edge_metal"], 0.090, 2)
    add_box(root, "Sector1BlenderEastRaisedBorderWall", (half, 0.0, wall_center_z), (wall_thickness, long_size, wall_height), mats["edge_metal"], 0.090, 2)

    rail_z = 0.84
    add_cylinder_between(root, "Sector1BlenderNorthCyanTopRail", (-half, -half, rail_z), (half, -half, rail_z), 0.070, mats["cyan_neon"], 18)
    add_cylinder_between(root, "Sector1BlenderSouthCyanTopRail", (-half, half, rail_z), (half, half, rail_z), 0.070, mats["cyan_neon"], 18)
    add_cylinder_between(root, "Sector1BlenderWestCyanTopRail", (-half, -half, rail_z), (-half, half, rail_z), 0.070, mats["cyan_neon"], 18)
    add_cylinder_between(root, "Sector1BlenderEastCyanTopRail", (half, -half, rail_z), (half, half, rail_z), 0.070, mats["cyan_neon"], 18)

    for i, (x, y) in enumerate([(-half, -half), (half, -half), (half, half), (-half, half)]):
        add_box(root, f"Sector1BlenderCornerPylonBase{i}", (x, y, 0.26), (1.45, 1.45, 0.52), mats["deep_metal"], 0.105, 2)
        add_box(root, f"Sector1BlenderCornerPylonCore{i}", (x, y, 0.86), (0.92, 0.92, 1.20), mats["edge_metal"], 0.085, 2)
        add_box(root, f"Sector1BlenderCornerPylonCyanCap{i}", (x, y, 1.52), (1.08, 1.08, 0.18), mats["cyan_core"], 0.055, 2)


def create_depth_and_detail(root, mats: dict) -> None:
    depth = ARENA_HALF_SIZE + 2.55
    for i, p in enumerate([-18.0, 0.0, 18.0]):
        add_box(root, f"Sector1BlenderNorthOuterButtress{i}", (p, -depth, 0.18), (7.6, 0.44, 0.34), mats["deep_metal"], 0.060, 1)
        add_box(root, f"Sector1BlenderSouthOuterButtress{i}", (p, depth, 0.18), (7.6, 0.44, 0.34), mats["deep_metal"], 0.060, 1)
        add_box(root, f"Sector1BlenderWestOuterButtress{i}", (-depth, p, 0.18), (0.44, 7.6, 0.34), mats["deep_metal"], 0.060, 1)
        add_box(root, f"Sector1BlenderEastOuterButtress{i}", (depth, p, 0.18), (0.44, 7.6, 0.34), mats["deep_metal"], 0.060, 1)
    add_cylinder_between(root, "Sector1BlenderNorthFarCyanRail", (-22.0, -depth, 0.48), (22.0, -depth, 0.48), 0.038, mats["cyan_neon"], 14)
    add_cylinder_between(root, "Sector1BlenderSouthFarCyanRail", (-22.0, depth, 0.48), (22.0, depth, 0.48), 0.038, mats["cyan_neon"], 14)
    add_cylinder_between(root, "Sector1BlenderWestFarCyanRail", (-depth, -22.0, 0.48), (-depth, 22.0, 0.48), 0.038, mats["cyan_neon"], 14)
    add_cylinder_between(root, "Sector1BlenderEastFarCyanRail", (depth, -22.0, 0.48), (depth, 22.0, 0.48), 0.038, mats["cyan_neon"], 14)


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
