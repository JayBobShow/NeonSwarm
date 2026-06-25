import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_3/source/blender/sector_3_ember_circuit_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_3/exported/sector_3_ember_circuit_arena.glb"
PROOF_RENDER = REPO_ROOT / "art/arenas/sector_3/review/sector_3_ember_circuit_arena_blender_proof.png"

ARENA_HALF_SIZE = 28.0
FLOOR_PANEL_COUNT = 8
FLOOR_PANEL_STEP = 7.0
FLOOR_PANEL_SIZE = 6.45
FLOOR_TOP_Z = 0.0
FLOOR_THICKNESS = 0.16
NEON_Z = 0.150
LOW_RAIL_Z = 0.320


def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete()
    for data_blocks in (
        bpy.data.meshes,
        bpy.data.materials,
        bpy.data.cameras,
        bpy.data.lights,
        bpy.data.curves,
        bpy.data.images,
    ):
        for data_block in list(data_blocks):
            if data_block.users == 0:
                data_blocks.remove(data_block)


def purge_non_asset_materials() -> None:
    for material in list(bpy.data.materials):
        if not material.name.startswith("NS_S3_HR1_"):
            bpy.data.materials.remove(material, do_unlink=True)


def set_input(node, names, value) -> None:
    for name in names:
        if name in node.inputs:
            node.inputs[name].default_value = value
            return


def color_mix(a, b, t: float) -> tuple:
    return (
        a[0] + (b[0] - a[0]) * t,
        a[1] + (b[1] - a[1]) * t,
        a[2] + (b[2] - a[2]) * t,
        a[3] + (b[3] - a[3]) * t,
    )


def make_principled_material(
    name: str,
    color,
    metallic: float,
    roughness: float,
    emission=None,
    emission_strength: float = 0.0,
    alpha: float = 1.0,
    noise: bool = False,
    noise_scale: float = 48.0,
):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    mat.diffuse_color = (color[0], color[1], color[2], alpha)
    mat.blend_method = "BLEND" if alpha < 1.0 else "OPAQUE"
    nodes = mat.node_tree.nodes
    bsdf = nodes.get("Principled BSDF")
    if not bsdf:
        return mat

    set_input(bsdf, ["Base Color"], (color[0], color[1], color[2], alpha))
    set_input(bsdf, ["Metallic"], metallic)
    set_input(bsdf, ["Roughness"], roughness)
    set_input(bsdf, ["Alpha"], alpha)
    if emission is not None and emission_strength > 0.0:
        set_input(bsdf, ["Emission Color", "Emission"], emission)
        set_input(bsdf, ["Emission Strength"], emission_strength)

    if noise:
        noise_node = nodes.new("ShaderNodeTexNoise")
        noise_node.inputs["Scale"].default_value = noise_scale
        noise_node.inputs["Detail"].default_value = 12.0
        noise_node.inputs["Roughness"].default_value = 0.54
        ramp = nodes.new("ShaderNodeValToRGB")
        ramp.color_ramp.elements[0].position = 0.18
        ramp.color_ramp.elements[0].color = color_mix((color[0], color[1], color[2], alpha), (0.0, 0.0, 0.0, alpha), 0.25)
        ramp.color_ramp.elements[1].position = 1.0
        ramp.color_ramp.elements[1].color = color_mix((color[0], color[1], color[2], alpha), (0.44, 0.35, 0.28, alpha), 0.18)
        mat.node_tree.links.new(noise_node.outputs["Fac"], ramp.inputs["Fac"])
        mat.node_tree.links.new(ramp.outputs["Color"], bsdf.inputs["Base Color"])
        bump = nodes.new("ShaderNodeBump")
        bump.inputs["Strength"].default_value = 0.030
        bump.inputs["Distance"].default_value = 0.115
        mat.node_tree.links.new(noise_node.outputs["Fac"], bump.inputs["Height"])
        mat.node_tree.links.new(bump.outputs["Normal"], bsdf.inputs["Normal"])

    return mat


def make_materials() -> dict:
    return {
        "dark_floor": make_principled_material(
            "NS_S3_HR1_Dark_Foundry_Floor",
            (0.094, 0.068, 0.052, 1.0),
            0.68,
            0.50,
            (0.040, 0.014, 0.004, 1.0),
            0.040,
            1.0,
            True,
            70.0,
        ),
        "raised_panel": make_principled_material(
            "NS_S3_HR1_Raised_Gunmetal_Panel",
            (0.128, 0.094, 0.074, 1.0),
            0.66,
            0.42,
            (0.050, 0.018, 0.004, 1.0),
            0.052,
            1.0,
            True,
            56.0,
        ),
        "groove": make_principled_material(
            "NS_S3_HR1_Recessed_Heat_Groove",
            (0.022, 0.012, 0.008, 1.0),
            0.42,
            0.82,
            (0.028, 0.006, 0.000, 1.0),
            0.018,
        ),
        "border_wall": make_principled_material(
            "NS_S3_HR1_Charcoal_Border_Wall",
            (0.072, 0.054, 0.048, 1.0),
            0.72,
            0.46,
            (0.032, 0.010, 0.000, 1.0),
            0.034,
            1.0,
            True,
            44.0,
        ),
        "trim": make_principled_material(
            "NS_S3_HR1_Burnt_Service_Trim",
            (0.178, 0.112, 0.076, 1.0),
            0.58,
            0.36,
            (0.060, 0.020, 0.004, 1.0),
            0.060,
            1.0,
            True,
            36.0,
        ),
        "clamp": make_principled_material(
            "NS_S3_HR1_Dark_Forge_Clamp",
            (0.110, 0.082, 0.066, 1.0),
            0.74,
            0.38,
            (0.040, 0.014, 0.003, 1.0),
            0.046,
            1.0,
            True,
            48.0,
        ),
        "ember": make_principled_material(
            "NS_S3_HR1_Ember_Neon_Channel",
            (0.900, 0.250, 0.045, 1.0),
            0.02,
            0.26,
            (1.000, 0.260, 0.035, 1.0),
            1.80,
        ),
        "molten": make_principled_material(
            "NS_S3_HR1_Yellow_White_Molten_Core",
            (1.000, 0.720, 0.155, 1.0),
            0.00,
            0.20,
            (1.000, 0.800, 0.180, 1.0),
            2.45,
        ),
        "cobalt": make_principled_material(
            "NS_S3_HR1_Dim_Cobalt_Memory_Accent",
            (0.110, 0.390, 0.580, 1.0),
            0.04,
            0.34,
            (0.060, 0.480, 0.720, 1.0),
            0.50,
        ),
        "heat_glass": make_principled_material(
            "NS_S3_HR1_Smoked_Heat_Glass",
            (0.420, 0.150, 0.055, 0.72),
            0.02,
            0.30,
            (0.180, 0.040, 0.008, 1.0),
            0.135,
            0.72,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    if hasattr(obj.data, "use_auto_smooth"):
        obj.data.use_auto_smooth = True
    if hasattr(obj.data, "auto_smooth_angle"):
        obj.data.auto_smooth_angle = math.radians(45.0)
    if hasattr(obj.data, "polygons"):
        for polygon in obj.data.polygons:
            polygon.use_smooth = True


def add_bevel_and_weighted_normals(obj, amount: float, segments: int = 1) -> None:
    if amount > 0.0:
        bevel = obj.modifiers.new("game_camera_readable_bevel", "BEVEL")
        bevel.width = amount
        bevel.segments = segments
        bevel.affect = "EDGES"
        bevel.harden_normals = True
    smooth_mesh_faces(obj)
    try:
        weighted = obj.modifiers.new("weighted_normals_for_top_down_readability", "WEIGHTED_NORMAL")
        weighted.keep_sharp = True
        if hasattr(weighted, "weight"):
            weighted.weight = 50
    except Exception:
        pass


def add_box(root, name: str, location, size, material, bevel: float = 0.0, segments: int = 1, rotation_z: float = 0.0):
    bpy.ops.mesh.primitive_cube_add(size=1.0, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.dimensions = size
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.rotation_euler.z = rotation_z
    obj.data.materials.append(material)
    add_bevel_and_weighted_normals(obj, bevel, segments)
    obj.parent = root
    return obj


def add_bar_between(root, name: str, start, end, width: float, height: float, z: float, material, bevel: float = 0.0, segments: int = 1):
    start_v = Vector((start[0], start[1], 0.0))
    end_v = Vector((end[0], end[1], 0.0))
    direction = end_v - start_v
    length = direction.length
    if length <= 0.001:
        return None
    mid = start_v + direction * 0.5
    angle = math.atan2(direction.y, direction.x)
    return add_box(root, name, (mid.x, mid.y, z), (length, width, height), material, bevel, segments, angle)


def polygon_points(center_x: float, center_y: float, radius_x: float, radius_y: float, sides: int, rotation: float = 0.0) -> list:
    points = []
    for index in range(sides):
        angle = rotation + math.tau * index / sides
        points.append((center_x + math.cos(angle) * radius_x, center_y + math.sin(angle) * radius_y))
    return points


def add_poly_prism(
    root,
    name: str,
    points,
    top_z: float,
    thickness: float,
    top_material,
    side_material,
    bevel: float = 0.0,
    segments: int = 1,
):
    top_vertices = [(x, y, top_z) for x, y in points]
    bottom_vertices = [(x, y, top_z - thickness) for x, y in points]
    verts = top_vertices + bottom_vertices
    count = len(points)
    faces = [tuple(range(count)), tuple(reversed(range(count, count * 2)))]
    for index in range(count):
        faces.append((index, (index + 1) % count, count + (index + 1) % count, count + index))
    mesh = bpy.data.meshes.new(f"{name}_Mesh")
    mesh.from_pydata(verts, [], faces)
    mesh.update()
    obj = bpy.data.objects.new(name, mesh)
    obj.data.materials.append(top_material)
    obj.data.materials.append(side_material)
    for polygon in obj.data.polygons[1:]:
        polygon.material_index = 1
    root.users_collection[0].objects.link(obj)
    obj.parent = root
    add_bevel_and_weighted_normals(obj, bevel, segments)
    return obj


def create_floor_panel_field(root, mats: dict) -> None:
    offset = float(FLOOR_PANEL_COUNT - 1) * FLOOR_PANEL_STEP * 0.5
    for row in range(FLOOR_PANEL_COUNT):
        for column in range(FLOOR_PANEL_COUNT):
            x = -offset + float(column) * FLOOR_PANEL_STEP
            y = -offset + float(row) * FLOOR_PANEL_STEP
            mat = mats["raised_panel"] if (row + column) % 3 == 0 else mats["dark_floor"]
            z = FLOOR_TOP_Z - FLOOR_THICKNESS * 0.5
            panel = add_box(
                root,
                f"Sector3EmberCircuitFoundryFloorPanel_R{row}_C{column}",
                (x, y, z),
                (FLOOR_PANEL_SIZE, FLOOR_PANEL_SIZE, FLOOR_THICKNESS),
                mat,
                0.055,
                1,
            )
            panel["gameplay_collision"] = "none_visual_only"
            if (row * 3 + column) % 5 == 0:
                add_box(
                    root,
                    f"Sector3EmberCircuitContainedHeatWearInset_R{row}_C{column}",
                    (x - 1.05, y + 1.20, FLOOR_TOP_Z + 0.012),
                    (2.20, 0.060, 0.030),
                    mats["trim"],
                    0.008,
                    1,
                    math.radians(0.0 if row % 2 == 0 else 90.0),
                )


def create_recessed_panel_grooves(root, mats: dict) -> None:
    field = ARENA_HALF_SIZE - 2.1
    for offset in [-21.0, -14.0, -7.0, 7.0, 14.0, 21.0]:
        add_bar_between(root, f"Sector3EmberCircuitRecessedVerticalServiceGroove_{int(offset)}", (offset, -field), (offset, field), 0.060, 0.038, FLOOR_TOP_Z + 0.018, mats["groove"], 0.006, 1)
        add_bar_between(root, f"Sector3EmberCircuitRecessedHorizontalServiceGroove_{int(offset)}", (-field, offset), (field, offset), 0.060, 0.038, FLOOR_TOP_Z + 0.018, mats["groove"], 0.006, 1)
    for index, y in enumerate([-18.8, -9.4, 9.4, 18.8]):
        add_bar_between(root, f"Sector3EmberCircuitDimCobaltMemoryTrace_{index}", (-22.0, y), (22.0, y + (1.6 if index % 2 == 0 else -1.6)), 0.052, 0.035, NEON_Z - 0.016, mats["cobalt"], 0.006, 1)


def create_foundry_busways(root, mats: dict) -> None:
    add_bar_between(root, "Sector3EmberCircuitCentralFoundrySpineDarkHousing", (0.0, -24.2), (0.0, 24.2), 3.10, 0.095, FLOOR_TOP_Z + 0.080, mats["clamp"], 0.050, 1)
    add_bar_between(root, "Sector3EmberCircuitCentralFoundrySpineEmberEdgeWest", (-1.06, -23.0), (-1.06, 23.0), 0.125, 0.065, NEON_Z, mats["ember"], 0.010, 1)
    add_bar_between(root, "Sector3EmberCircuitCentralFoundrySpineEmberEdgeEast", (1.06, -23.0), (1.06, 23.0), 0.125, 0.065, NEON_Z, mats["ember"], 0.010, 1)
    add_bar_between(root, "Sector3EmberCircuitCentralFoundrySpineMoltenCore", (0.0, -21.6), (0.0, 21.6), 0.125, 0.070, NEON_Z + 0.020, mats["molten"], 0.010, 1)

    add_bar_between(root, "Sector3EmberCircuitCrossHeatBusDarkHousing", (-24.0, 0.0), (24.0, 0.0), 2.65, 0.086, FLOOR_TOP_Z + 0.082, mats["clamp"], 0.050, 1)
    add_bar_between(root, "Sector3EmberCircuitCrossHeatBusNorthEdge", (-22.4, -0.94), (22.4, -0.94), 0.115, 0.060, NEON_Z + 0.010, mats["ember"], 0.010, 1)
    add_bar_between(root, "Sector3EmberCircuitCrossHeatBusSouthEdge", (-22.4, 0.94), (22.4, 0.94), 0.115, 0.060, NEON_Z + 0.010, mats["ember"], 0.010, 1)
    add_bar_between(root, "Sector3EmberCircuitCrossHeatBusMoltenCenterline", (-20.5, 0.0), (20.5, 0.0), 0.105, 0.066, NEON_Z + 0.025, mats["molten"], 0.010, 1)

    for index, x in enumerate([-13.4, 13.4]):
        add_bar_between(root, f"Sector3EmberCircuitVerticalReturnManifoldDarkHousing_{index}", (x, -18.5), (x, 18.5), 1.10, 0.082, FLOOR_TOP_Z + 0.074, mats["border_wall"], 0.038, 1)
        add_bar_between(root, f"Sector3EmberCircuitVerticalReturnManifoldEmberCore_{index}", (x, -16.8), (x, 16.8), 0.105, 0.058, NEON_Z + 0.004, mats["ember"], 0.009, 1)
    for index, y in enumerate([-13.4, 13.4]):
        add_bar_between(root, f"Sector3EmberCircuitHorizontalBypassDarkHousing_{index}", (-18.5, y), (18.5, y), 1.10, 0.082, FLOOR_TOP_Z + 0.074, mats["border_wall"], 0.038, 1)
        add_bar_between(root, f"Sector3EmberCircuitHorizontalBypassEmberCore_{index}", (-16.8, y), (16.8, y), 0.105, 0.058, NEON_Z + 0.004, mats["ember"], 0.009, 1)


def create_foundry_nodes(root, mats: dict) -> None:
    core_plate = add_box(root, "Sector3FoundryGateCentralForgeCoreMachinedPlate", (0.0, 0.0, FLOOR_TOP_Z + 0.165), (7.9, 2.9, 0.160), mats["clamp"], 0.090, 2)
    core_plate["gameplay_collision"] = "none_visual_only"
    add_box(root, "Sector3FoundryGateCentralForgeCoreMoltenSlot", (0.0, 0.0, FLOOR_TOP_Z + 0.270), (5.65, 0.185, 0.065), mats["molten"], 0.018, 1)
    add_box(root, "Sector3FoundryGateCentralForgeCoreEmberOuterSlot", (0.0, -0.48, FLOOR_TOP_Z + 0.245), (6.55, 0.135, 0.050), mats["ember"], 0.014, 1)
    add_box(root, "Sector3FoundryGateCentralForgeCoreEmberReturnSlot", (0.0, 0.48, FLOOR_TOP_Z + 0.245), (6.55, 0.135, 0.050), mats["ember"], 0.014, 1)

    for index, (x, y) in enumerate([(-15.7, -15.7), (15.7, -15.7), (-15.7, 15.7), (15.7, 15.7)]):
        base_points = polygon_points(x, y, 2.75, 2.20, 6, math.radians(30.0))
        add_poly_prism(root, f"Sector3FoundryGateHexagonalForgeNodeBase_{index}", base_points, FLOOR_TOP_Z + 0.118, 0.140, mats["clamp"], mats["border_wall"], 0.045, 1)
        cap_points = polygon_points(x, y, 1.95, 1.52, 6, math.radians(30.0))
        add_poly_prism(root, f"Sector3FoundryGateHexagonalForgeNodeHotCap_{index}", cap_points, FLOOR_TOP_Z + 0.248, 0.050, mats["heat_glass"], mats["ember"], 0.022, 1)
        add_bar_between(root, f"Sector3FoundryGateHexNodeEmberSlash_{index}", (x - 1.20, y), (x + 1.20, y), 0.075, 0.052, NEON_Z + 0.120, mats["ember"], 0.008, 1)


def create_foundry_gate_threshold(root, mats: dict) -> None:
    y = -ARENA_HALF_SIZE + 1.95
    add_box(root, "Sector3FoundryGateNorthLowGateBaseVisualOnly", (0.0, y, 0.405), (18.0, 1.05, 0.62), mats["border_wall"], 0.085, 2)
    add_box(root, "Sector3FoundryGateNorthLowGateInsetHotGlass", (0.0, y + 0.56, 0.742), (11.2, 0.100, 0.105), mats["heat_glass"], 0.014, 1)
    add_box(root, "Sector3FoundryGateNorthLowGateMoltenHeader", (0.0, y + 0.63, 0.825), (8.6, 0.080, 0.070), mats["molten"], 0.010, 1)
    for index, x in enumerate([-9.0, -4.5, 4.5, 9.0]):
        add_box(root, f"Sector3FoundryGateNorthEmbeddedClamp_{index}", (x, y + 0.18, 0.760), (1.25, 0.160, 0.210), mats["trim"], 0.026, 1)


def create_boundary_frame(root, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    for index, center in enumerate([-22.0, -11.0, 0.0, 11.0, 22.0]):
        add_box(root, f"Sector3EmberCircuitNorthLowBoundaryRail_{index}", (center, -half + 0.30, LOW_RAIL_Z), (9.2, 0.58, 0.50), mats["border_wall"], 0.066, 1)
        add_box(root, f"Sector3EmberCircuitSouthLowBoundaryRail_{index}", (center, half - 0.30, LOW_RAIL_Z), (9.2, 0.58, 0.50), mats["border_wall"], 0.066, 1)
        add_box(root, f"Sector3EmberCircuitWestLowBoundaryRail_{index}", (-half + 0.30, center, LOW_RAIL_Z), (0.58, 9.2, 0.50), mats["border_wall"], 0.066, 1)
        add_box(root, f"Sector3EmberCircuitEastLowBoundaryRail_{index}", (half - 0.30, center, LOW_RAIL_Z), (0.58, 9.2, 0.50), mats["border_wall"], 0.066, 1)
        glow_mat = mats["molten"] if index == 2 else mats["ember"]
        add_box(root, f"Sector3EmberCircuitNorthContainedBoundaryGlow_{index}", (center, -half + 0.92, LOW_RAIL_Z + 0.305), (2.45, 0.070, 0.070), glow_mat, 0.010, 1)
        add_box(root, f"Sector3EmberCircuitSouthContainedBoundaryGlow_{index}", (center, half - 0.92, LOW_RAIL_Z + 0.305), (2.45, 0.070, 0.070), glow_mat, 0.010, 1)
        add_box(root, f"Sector3EmberCircuitWestContainedBoundaryGlow_{index}", (-half + 0.92, center, LOW_RAIL_Z + 0.305), (0.070, 2.45, 0.070), glow_mat, 0.010, 1)
        add_box(root, f"Sector3EmberCircuitEastContainedBoundaryGlow_{index}", (half - 0.92, center, LOW_RAIL_Z + 0.305), (0.070, 2.45, 0.070), glow_mat, 0.010, 1)

    for index, (x, y) in enumerate([(-half, -half), (half, -half), (-half, half), (half, half)]):
        sx = math.copysign(1.0, x)
        sy = math.copysign(1.0, y)
        add_box(root, f"Sector3EmberCircuitCornerForgeClampA_{index}", (x - sx * 0.64, y, 0.440), (1.30, 2.95, 0.66), mats["clamp"], 0.080, 1)
        add_box(root, f"Sector3EmberCircuitCornerForgeClampB_{index}", (x, y - sy * 0.64, 0.440), (2.95, 1.30, 0.66), mats["clamp"], 0.080, 1)
        cap_points = polygon_points(x - sx * 0.76, y - sy * 0.76, 1.12, 1.12, 8, math.radians(22.5))
        add_poly_prism(root, f"Sector3EmberCircuitCornerOctagonalHeatCap_{index}", cap_points, 0.845, 0.070, mats["trim"], mats["ember"], 0.030, 1)


def create_low_profile_depth_machinery(root, mats: dict) -> None:
    for index, x in enumerate([-18.0, -9.0, 9.0, 18.0]):
        add_box(root, f"Sector3FoundryGateNorthBackgroundHeatExchanger_{index}", (x, -31.0, 0.430), (5.2, 0.46, 0.58), mats["border_wall"], 0.052, 1)
        add_box(root, f"Sector3FoundryGateSouthBackgroundReturnExchanger_{index}", (x, 31.0, 0.390), (5.2, 0.42, 0.50), mats["border_wall"], 0.052, 1)
        add_box(root, f"Sector3FoundryGateNorthExchangerContainedGlow_{index}", (x, -30.72, 0.745), (2.2, 0.060, 0.052), mats["ember"], 0.008, 1)
        add_box(root, f"Sector3FoundryGateSouthExchangerContainedGlow_{index}", (x, 30.72, 0.675), (2.2, 0.060, 0.052), mats["ember"], 0.008, 1)
    for index, y in enumerate([-18.0, -9.0, 9.0, 18.0]):
        add_box(root, f"Sector3FoundryGateWestBackgroundReturnStack_{index}", (-31.0, y, 0.360), (0.42, 4.6, 0.48), mats["border_wall"], 0.045, 1)
        add_box(root, f"Sector3FoundryGateEastBackgroundReturnStack_{index}", (31.0, y, 0.360), (0.42, 4.6, 0.48), mats["border_wall"], 0.045, 1)
        add_box(root, f"Sector3FoundryGateWestReturnStackGlow_{index}", (-30.72, y, 0.640), (0.060, 1.8, 0.046), mats["ember"], 0.008, 1)
        add_box(root, f"Sector3FoundryGateEastReturnStackGlow_{index}", (30.72, y, 0.640), (0.060, 1.8, 0.046), mats["ember"], 0.008, 1)


def create_service_rail_diagonals(root, mats: dict) -> None:
    rails = [
        ("A", (-22.0, 11.0), (22.0, -11.0)),
        ("B", (-18.0, -18.0), (18.0, 18.0)),
        ("C", (-23.0, -5.5), (-6.5, -22.0)),
        ("D", (6.5, 22.0), (23.0, 5.5)),
    ]
    for name, start, end in rails:
        add_bar_between(root, f"Sector3EmberCircuitMoltenServiceRail{name}DarkBed", start, end, 0.44, 0.052, FLOOR_TOP_Z + 0.050, mats["groove"], 0.014, 1)
        add_bar_between(root, f"Sector3EmberCircuitMoltenServiceRail{name}EmberTrace", start, end, 0.070, 0.048, NEON_Z + 0.005, mats["ember"], 0.008, 1)


def configure_render_settings() -> None:
    engines = [item.identifier for item in bpy.types.RenderSettings.bl_rna.properties["engine"].enum_items]
    bpy.context.scene.render.engine = "BLENDER_EEVEE_NEXT" if "BLENDER_EEVEE_NEXT" in engines else "BLENDER_EEVEE"
    if hasattr(bpy.context.scene, "eevee"):
        if hasattr(bpy.context.scene.eevee, "use_bloom"):
            bpy.context.scene.eevee.use_bloom = True
        if hasattr(bpy.context.scene.eevee, "bloom_intensity"):
            bpy.context.scene.eevee.bloom_intensity = 0.045
        if hasattr(bpy.context.scene.eevee, "taa_render_samples"):
            bpy.context.scene.eevee.taa_render_samples = 64
    bpy.context.scene.render.resolution_x = 1800
    bpy.context.scene.render.resolution_y = 1800
    bpy.context.scene.view_settings.view_transform = "Filmic"
    bpy.context.scene.view_settings.look = "Medium High Contrast"
    bpy.context.scene.view_settings.exposure = -0.18
    bpy.context.scene.view_settings.gamma = 1.0


def setup_preview_camera_and_lights() -> None:
    camera_data = bpy.data.cameras.new("Sector3EmberCircuitProofGameplayCamera")
    camera = bpy.data.objects.new("Sector3EmberCircuitProofGameplayCamera", camera_data)
    camera.location = (0.0, -36.0, 35.0)
    camera.rotation_euler = (math.radians(52.0), 0.0, 0.0)
    camera.data.lens = 25.0
    bpy.context.collection.objects.link(camera)
    bpy.context.scene.camera = camera

    key_data = bpy.data.lights.new("Sector3SoftFoundryProofKeyLight", "AREA")
    key = bpy.data.objects.new("Sector3SoftFoundryProofKeyLight", key_data)
    key.location = (-8.0, -16.0, 22.0)
    key.rotation_euler = (math.radians(58.0), 0.0, math.radians(-18.0))
    key_data.energy = 360.0
    key_data.size = 20.0
    bpy.context.collection.objects.link(key)

    fill_data = bpy.data.lights.new("Sector3DimAmberProofFillLight", "POINT")
    fill = bpy.data.objects.new("Sector3DimAmberProofFillLight", fill_data)
    fill.location = (10.0, 9.0, 8.0)
    fill_data.energy = 80.0
    fill_data.color = (1.0, 0.30, 0.08)
    fill_data.shadow_soft_size = 12.0
    bpy.context.collection.objects.link(fill)


def iter_hierarchy(obj):
    yield obj
    for child in obj.children:
        yield from iter_hierarchy(child)


def select_export_hierarchy(root) -> None:
    bpy.ops.object.select_all(action="DESELECT")
    for obj in iter_hierarchy(root):
        obj.select_set(True)
    bpy.context.view_layer.objects.active = root


def setup_scene():
    clear_scene()
    bpy.context.preferences.filepaths.save_version = 0
    bpy.context.scene.unit_settings.system = "METRIC"
    configure_render_settings()
    if bpy.context.scene.world is None:
        bpy.context.scene.world = bpy.data.worlds.new("NS_Sector3_Ember_Circuit_World")
    bpy.context.scene.world.color = (0.020, 0.004, 0.000)

    root = bpy.data.objects.new("Sector3EmberCircuitFoundryGateArenaRoot", None)
    root.empty_display_type = "CUBE"
    root.empty_display_size = 56.0
    root["neon_swarm_asset"] = "phase_53_sector_3_ember_circuit_foundry_gate_arena"
    root["sector"] = "Sector 3 Ember Circuit"
    root["campaign_node"] = "3.0 Foundry Gate"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["collision"] = "visual_only_no_collision"
    root["primary_shape"] = "rectangular foundry circuit board"
    root["secondary_shape"] = "hexagonal forge nodes and heat-channel busways"
    root["readability_priority"] = "arena background below player enemies projectiles xp hud"
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_floor_panel_field(root, mats)
    create_recessed_panel_grooves(root, mats)
    create_foundry_busways(root, mats)
    create_service_rail_diagonals(root, mats)
    create_foundry_nodes(root, mats)
    create_foundry_gate_threshold(root, mats)
    create_boundary_frame(root, mats)
    create_low_profile_depth_machinery(root, mats)
    setup_preview_camera_and_lights()
    return root


def save_render() -> None:
    PROOF_RENDER.parent.mkdir(parents=True, exist_ok=True)
    bpy.context.scene.render.filepath = str(PROOF_RENDER)
    bpy.ops.render.render(write_still=True)


def export_assets(root) -> None:
    SOURCE_BLEND.parent.mkdir(parents=True, exist_ok=True)
    EXPORT_GLB.parent.mkdir(parents=True, exist_ok=True)
    purge_non_asset_materials()
    bpy.ops.outliner.orphans_purge(do_local_ids=True, do_linked_ids=True, do_recursive=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(SOURCE_BLEND))
    select_export_hierarchy(root)
    kwargs = {
        "filepath": str(EXPORT_GLB),
        "export_format": "GLB",
        "use_selection": True,
        "export_apply": True,
        "export_normals": True,
        "export_materials": "EXPORT",
        "export_cameras": False,
        "export_lights": False,
        "export_animations": False,
        "export_extras": True,
    }
    try:
        bpy.ops.export_scene.gltf(**kwargs)
    except TypeError:
        kwargs.pop("export_extras", None)
        bpy.ops.export_scene.gltf(**kwargs)
    print(f"saved_blend={SOURCE_BLEND}")
    print(f"proof_render={PROOF_RENDER}")
    print(f"exported_glb={EXPORT_GLB}")


def main() -> None:
    export_root = setup_scene()
    save_render()
    export_assets(export_root)


if __name__ == "__main__":
    main()
