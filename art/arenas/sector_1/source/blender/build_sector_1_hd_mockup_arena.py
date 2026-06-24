import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
REFERENCE_IMAGE = REPO_ROOT / "art/reference/sector_1_neon_grid/sector_1_neon_grid_hd_mockup.png"
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb"
PROOF_RENDER = REPO_ROOT / "art/arenas/sector_1/review/sector_1_hd_mockup_blender_proof.png"
LEGACY_TOPDOWN_RENDER = REPO_ROOT / "art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png"

ARENA_HALF_SIZE = 28.0
PANEL_COUNT = 8
PANEL_STEP = 7.0
PANEL_SIZE = 6.35
FLOOR_TOP_Z = 0.0
NEON_Z = 0.145


def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete()


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
    noise: bool = False,
    noise_scale: float = 38.0,
    alpha: float = 1.0,
):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    mat.diffuse_color = (color[0], color[1], color[2], alpha)
    mat.blend_method = "BLEND" if alpha < 1.0 else "OPAQUE"
    nodes = mat.node_tree.nodes
    bsdf = nodes.get("Principled BSDF")
    if bsdf:
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
            noise_node.inputs["Roughness"].default_value = 0.56
            ramp = nodes.new("ShaderNodeValToRGB")
            ramp.color_ramp.elements[0].position = 0.16
            ramp.color_ramp.elements[0].color = color_mix(color, (0.0, 0.0, 0.0, alpha), 0.22)
            ramp.color_ramp.elements[1].position = 1.0
            ramp.color_ramp.elements[1].color = color_mix(color, (0.44, 0.52, 0.58, alpha), 0.20)
            mat.node_tree.links.new(noise_node.outputs["Fac"], ramp.inputs["Fac"])
            mat.node_tree.links.new(ramp.outputs["Color"], bsdf.inputs["Base Color"])
            bump = nodes.new("ShaderNodeBump")
            bump.inputs["Strength"].default_value = 0.035
            bump.inputs["Distance"].default_value = 0.140
            mat.node_tree.links.new(noise_node.outputs["Fac"], bump.inputs["Height"])
            mat.node_tree.links.new(bump.outputs["Normal"], bsdf.inputs["Normal"])
    return mat


def make_materials() -> dict:
    return {
        "floor": make_principled_material(
            "mat_floor_dark_brushed_metal",
            (0.072, 0.092, 0.108, 1.0),
            0.68,
            0.44,
            (0.006, 0.040, 0.055, 1.0),
            0.045,
            True,
            76.0,
        ),
        "floor_variant": make_principled_material(
            "mat_floor_panel_variant",
            (0.108, 0.130, 0.146, 1.0),
            0.64,
            0.39,
            (0.010, 0.048, 0.060, 1.0),
            0.040,
            True,
            54.0,
        ),
        "outer_wall": make_principled_material(
            "mat_outer_wall_dark_metal",
            (0.052, 0.064, 0.078, 1.0),
            0.72,
            0.46,
            (0.005, 0.030, 0.040, 1.0),
            0.030,
            True,
            48.0,
        ),
        "door": make_principled_material(
            "mat_door_dark_metal",
            (0.086, 0.096, 0.108, 1.0),
            0.76,
            0.36,
            (0.008, 0.030, 0.038, 1.0),
            0.035,
            True,
            42.0,
        ),
        "pillar": make_principled_material(
            "mat_pillar_dark_metal",
            (0.122, 0.136, 0.148, 1.0),
            0.72,
            0.34,
            (0.012, 0.040, 0.048, 1.0),
            0.038,
            True,
            36.0,
        ),
        "cover": make_principled_material(
            "mat_cover_dark_metal",
            (0.110, 0.124, 0.136, 1.0),
            0.70,
            0.38,
            (0.010, 0.036, 0.044, 1.0),
            0.035,
            True,
            40.0,
        ),
        "cyan": make_principled_material(
            "mat_cyan_neon_emissive",
            (0.000, 0.720, 0.900, 1.0),
            0.0,
            0.20,
            (0.000, 0.900, 1.000, 1.0),
            3.65,
        ),
        "white": make_principled_material(
            "mat_white_energy_emissive",
            (0.800, 0.960, 1.000, 1.0),
            0.0,
            0.14,
            (0.760, 0.980, 1.000, 1.0),
            4.45,
        ),
        "yellow": make_principled_material(
            "mat_yellow_accent_emissive",
            (1.000, 0.900, 0.140, 1.0),
            0.0,
            0.22,
            (1.000, 0.880, 0.100, 1.0),
            3.80,
        ),
        "recess": make_principled_material(
            "mat_black_recess_shadow",
            (0.006, 0.010, 0.018, 1.0),
            0.40,
            0.80,
            (0.000, 0.012, 0.018, 1.0),
            0.010,
        ),
        "edge": make_principled_material(
            "mat_edge_trim_metal",
            (0.240, 0.286, 0.306, 1.0),
            0.60,
            0.30,
            (0.018, 0.070, 0.080, 1.0),
            0.055,
            True,
            32.0,
        ),
        "scratch": make_principled_material(
            "mat_floor_bright_worn_scratches",
            (0.390, 0.455, 0.465, 1.0),
            0.30,
            0.52,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    if hasattr(obj.data, "polygons"):
        for polygon in obj.data.polygons:
            polygon.use_smooth = True


def add_bevel(obj, amount: float, segments: int = 2) -> None:
    if amount > 0.0:
        bevel = obj.modifiers.new("hard_surface_beveled_edges", "BEVEL")
        bevel.width = amount
        bevel.segments = segments
        bevel.affect = "EDGES"
    if hasattr(obj.data, "use_auto_smooth"):
        obj.data.use_auto_smooth = True
    if hasattr(obj.data, "auto_smooth_angle"):
        obj.data.auto_smooth_angle = math.radians(45.0)
    try:
        normal = obj.modifiers.new("weighted_normals_for_game_camera", "WEIGHTED_NORMAL")
        normal.keep_sharp = True
    except Exception:
        pass
    smooth_mesh_faces(obj)


def add_box(
    root,
    name: str,
    location,
    size,
    material,
    bevel: float = 0.0,
    segments: int = 2,
    rotation_z: float = 0.0,
):
    bpy.ops.mesh.primitive_cube_add(size=1.0, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.dimensions = size
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.rotation_euler.z = rotation_z
    obj.data.materials.append(material)
    add_bevel(obj, bevel, segments)
    obj.parent = root
    return obj


def add_reference_plane() -> None:
    if not REFERENCE_IMAGE.exists():
        raise FileNotFoundError(f"Missing reference image: {REFERENCE_IMAGE}")
    mat = bpy.data.materials.new("ReferenceOnly_sector_1_hd_mockup_blueprint_material")
    mat.use_nodes = True
    nodes = mat.node_tree.nodes
    bsdf = nodes.get("Principled BSDF")
    image_node = nodes.new("ShaderNodeTexImage")
    image_node.image = bpy.data.images.load(str(REFERENCE_IMAGE))
    if bsdf:
        mat.node_tree.links.new(image_node.outputs["Color"], bsdf.inputs["Base Color"])
        set_input(bsdf, ["Alpha"], 0.34)
    mat.blend_method = "BLEND"
    mat.diffuse_color = (1.0, 1.0, 1.0, 0.34)
    bpy.ops.mesh.primitive_plane_add(size=1.0, location=(0.0, 0.0, -0.92))
    plane = bpy.context.object
    plane.name = "ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_hidden_from_export"
    plane.data.name = "ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_Mesh"
    plane.dimensions = (56.0, 56.0, 0.0)
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    plane.data.materials.append(mat)
    plane.hide_render = True
    plane.hide_select = True
    plane["reference_image"] = str(REFERENCE_IMAGE.relative_to(REPO_ROOT))
    plane["exported"] = False


def add_shadow_plate(root, name: str, x: float, y: float, sx: float, sy: float, mats: dict, rotation_z: float = 0.0) -> None:
    add_box(root, name, (x + 0.34, y + 0.42, FLOOR_TOP_Z + 0.010), (sx, sy, 0.018), mats["recess"], 0.090, 2, rotation_z)


def add_surface_plate(root, name: str, x: float, y: float, z: float, sx: float, sy: float, mats: dict, rotation_z: float = 0.0) -> None:
    add_box(root, f"{name}_raised_plate", (x, y, z), (sx, sy, 0.060), mats["floor_variant"], 0.050, 2, rotation_z)
    add_box(root, f"{name}_dark_inner_stamp", (x, y, z + 0.045), (sx * 0.52, sy * 0.42, 0.018), mats["recess"], 0.018, 1, rotation_z)


def add_panel_wear(root, name_prefix: str, x: float, y: float, z: float, mats: dict, row: int, column: int) -> None:
    for i in range(5):
        local_x = -2.2 + float((row * 5 + column * 3 + i * 7) % 45) / 10.0
        local_y = -2.0 + float((row * 11 + column * 2 + i * 9) % 40) / 10.0
        length = 0.75 + float((row + column + i) % 5) * 0.28
        angle = math.radians(-8.0 + float((row * 17 + column * 13 + i * 5) % 17))
        mat = mats["scratch"] if i % 2 == 0 else mats["recess"]
        add_box(root, f"{name_prefix}_scuffed_brushed_line_{i}", (x + local_x, y + local_y, z + 0.032), (length, 0.030, 0.010), mat, 0.004, 1, angle)
    if (row + column) % 3 == 0:
        for i in range(4):
            add_box(root, f"{name_prefix}_service_vent_slat_{i}", (x - 1.05 + i * 0.34, y + 1.46, z + 0.048), (0.140, 1.06, 0.026), mats["edge"], 0.010, 1)


def create_floor_system(root, mats: dict) -> None:
    add_box(root, "floor_full_black_depth_bed", (0.0, 0.0, -0.280), (58.6, 58.6, 0.34), mats["recess"], 0.180, 3)
    add_box(root, "floor_continuous_dark_metal_underplate", (0.0, 0.0, -0.090), (55.2, 55.2, 0.105), mats["floor"], 0.110, 2)
    offset = float(PANEL_COUNT - 1) * PANEL_STEP * 0.5
    for row in range(PANEL_COUNT):
        for column in range(PANEL_COUNT):
            x = -offset + float(column) * PANEL_STEP
            y = -offset + float(row) * PANEL_STEP
            z_variation = [-0.030, -0.014, 0.000, 0.018][(row * 7 + column * 3) % 4]
            material = mats["floor_variant"] if (row + column) % 2 == 0 else mats["floor"]
            panel = add_box(
                root,
                f"floor_layered_panel_R{row}_C{column}",
                (x, y, -0.025 + z_variation),
                (PANEL_SIZE, PANEL_SIZE, 0.145),
                material,
                0.120,
                3,
            )
            panel["panel_role"] = "brushed_metal_floor_panel"
            lip_z = FLOOR_TOP_Z + 0.055 + z_variation
            add_box(root, f"floor_panel_R{row}_C{column}_north_beveled_lip", (x, y - 2.82, lip_z), (4.86, 0.145, 0.052), mats["edge"], 0.022, 1)
            add_box(root, f"floor_panel_R{row}_C{column}_south_beveled_lip", (x, y + 2.82, lip_z), (4.86, 0.145, 0.052), mats["edge"], 0.022, 1)
            if column % 2 == 0:
                add_box(root, f"floor_panel_R{row}_C{column}_east_dark_seam_lip", (x + 2.88, y, lip_z + 0.002), (0.135, 4.70, 0.046), mats["recess"], 0.014, 1)
            if (row + column) % 4 == 0:
                add_surface_plate(root, f"floor_panel_R{row}_C{column}_service_hatch", x - 0.58, y + 0.24, lip_z + 0.030, 2.54, 1.32, mats)
            else:
                add_box(root, f"floor_panel_R{row}_C{column}_offset_panel_groove", (x + 0.62, y - 0.14, lip_z + 0.028), (0.110, 3.35, 0.030), mats["recess"], 0.010, 1, math.radians(6.0))
            add_panel_wear(root, f"floor_panel_R{row}_C{column}", x, y, lip_z, mats, row, column)

    for i in range(PANEL_COUNT + 1):
        p = -ARENA_HALF_SIZE + float(i) * PANEL_STEP
        add_box(root, f"floor_grid_deep_vertical_seam_{i}", (p, 0.0, FLOOR_TOP_Z + 0.036), (0.130, 55.2, 0.040), mats["recess"], 0.014, 1)
        add_box(root, f"floor_grid_deep_horizontal_seam_{i}", (0.0, p, FLOOR_TOP_Z + 0.036), (55.2, 0.130, 0.040), mats["recess"], 0.014, 1)


def create_floor_depth_overlays(root, mats: dict) -> None:
    for x in [-0.82, 0.82]:
        add_box(root, f"central_spine_black_service_trench_{x:+.1f}", (x, 0.0, FLOOR_TOP_Z + 0.112), (0.135, 46.6, 0.040), mats["recess"], 0.008, 1)
    for y in [-20.8, -7.0, 7.0, 20.8]:
        add_box(root, f"wide_cross_panel_shadow_cut_{y:+.1f}", (0.0, y, FLOOR_TOP_Z + 0.106), (47.0, 0.095, 0.036), mats["recess"], 0.006, 1)
    for x in [-21.8, 21.8]:
        add_box(root, f"side_wall_floor_cable_trench_{x:+.1f}", (x, 0.0, FLOOR_TOP_Z + 0.114), (0.120, 44.2, 0.040), mats["recess"], 0.007, 1)

    for i in range(96):
        x = -23.0 + float((i * 17 + 5) % 92) * 0.50
        y = -23.0 + float((i * 29 + 11) % 92) * 0.50
        if abs(x) < 3.7 and abs(y) < 20.5:
            x += 4.8 if x >= 0.0 else -4.8
        length = 0.55 + float((i * 7) % 8) * 0.22
        width = 0.024 + float((i * 5) % 4) * 0.008
        angle = math.radians(-18.0 + float((i * 13) % 37))
        material = mats["scratch"] if i % 3 != 0 else mats["recess"]
        z = FLOOR_TOP_Z + (0.142 if material == mats["scratch"] else 0.128)
        add_box(root, f"floor_irregular_wear_scrape_{i:02d}", (x, y, z), (length, width, 0.014), material, 0.003, 1, angle)

    for i in range(36):
        x = -21.0 + float((i * 19 + 3) % 84) * 0.50
        y = -21.0 + float((i * 23 + 9) % 84) * 0.50
        add_box(root, f"floor_small_black_service_stamp_{i:02d}", (x, y, FLOOR_TOP_Z + 0.133), (0.72, 0.18, 0.020), mats["recess"], 0.006, 1, math.radians((i * 17) % 90))


def add_neon_channel(root, name: str, start, end, width: float, mats: dict, material_key: str = "cyan", core: bool = True) -> None:
    start_v = Vector((start[0], start[1], 0.0))
    end_v = Vector((end[0], end[1], 0.0))
    delta = end_v - start_v
    length = delta.length
    if length <= 0.001:
        return
    angle = math.atan2(delta.y, delta.x)
    mid = start_v + delta * 0.5
    normal_x = -math.sin(angle)
    normal_y = math.cos(angle)
    add_box(root, f"{name}_recessed_black_channel", (mid.x, mid.y, NEON_Z - 0.055), (length + width * 2.6, width * 3.35, 0.072), mats["recess"], 0.030, 1, angle)
    add_box(root, f"{name}_beveled_channel_lip_a", (mid.x - normal_x * width * 1.26, mid.y - normal_y * width * 1.26, NEON_Z - 0.018), (length + width * 1.4, width * 0.28, 0.036), mats["edge"], 0.012, 1, angle)
    add_box(root, f"{name}_beveled_channel_lip_b", (mid.x + normal_x * width * 1.26, mid.y + normal_y * width * 1.26, NEON_Z - 0.018), (length + width * 1.4, width * 0.28, 0.036), mats["edge"], 0.012, 1, angle)
    mat = mats[material_key]
    add_box(root, name, (mid.x, mid.y, NEON_Z + 0.010), (length, width, 0.056), mat, 0.018, 2, angle)
    if core:
        add_box(root, f"{name}_hot_energy_core", (mid.x, mid.y, NEON_Z + 0.046), (length * 0.965, max(0.030, width * 0.26), 0.024), mats["white"], 0.008, 1, angle)


def add_neon_loop(root, name: str, half: float, width: float, mats: dict) -> None:
    add_neon_channel(root, f"{name}_north", (-half, -half), (half, -half), width, mats)
    add_neon_channel(root, f"{name}_south", (-half, half), (half, half), width, mats)
    add_neon_channel(root, f"{name}_west", (-half, -half), (-half, half), width, mats)
    add_neon_channel(root, f"{name}_east", (half, -half), (half, half), width, mats)


def create_neon_routing(root, mats: dict) -> None:
    add_neon_loop(root, "cyan_reference_outer_square_route", 23.1, 0.180, mats)
    add_neon_loop(root, "cyan_reference_inner_square_route", 18.05, 0.125, mats)
    add_neon_channel(root, "cyan_left_outer_vertical_route", (-20.6, -20.4), (-20.6, 20.4), 0.120, mats)
    add_neon_channel(root, "cyan_right_outer_vertical_route", (20.6, -20.4), (20.6, 20.4), 0.120, mats)
    add_neon_channel(root, "cyan_left_inner_vertical_route", (-11.65, -14.9), (-11.65, 14.9), 0.104, mats)
    add_neon_channel(root, "cyan_right_inner_vertical_route", (11.65, -14.9), (11.65, 14.9), 0.104, mats)
    add_neon_channel(root, "cyan_left_top_horizontal_route", (-20.6, -14.9), (-11.65, -14.9), 0.104, mats)
    add_neon_channel(root, "cyan_left_bottom_horizontal_route", (-20.6, 14.9), (-11.65, 14.9), 0.104, mats)
    add_neon_channel(root, "cyan_right_top_horizontal_route", (11.65, -14.9), (20.6, -14.9), 0.104, mats)
    add_neon_channel(root, "cyan_right_bottom_horizontal_route", (11.65, 14.9), (20.6, 14.9), 0.104, mats)

    add_neon_channel(root, "white_energy_central_lane_left_top", (-2.48, -20.95), (-2.48, -3.40), 0.145, mats, "white", False)
    add_neon_channel(root, "white_energy_central_lane_right_top", (2.48, -20.95), (2.48, -3.40), 0.145, mats, "white", False)
    add_neon_channel(root, "white_energy_central_lane_left_bottom", (-2.48, 3.40), (-2.48, 20.95), 0.145, mats, "white", False)
    add_neon_channel(root, "white_energy_central_lane_right_bottom", (2.48, 3.40), (2.48, 20.95), 0.145, mats, "white", False)
    add_neon_channel(root, "white_energy_central_top_bridge", (-2.48, -3.40), (2.48, -3.40), 0.130, mats, "white", False)
    add_neon_channel(root, "white_energy_central_bottom_bridge", (-2.48, 3.40), (2.48, 3.40), 0.130, mats, "white", False)
    add_box(root, "central_recessed_double_lane_spine", (0.0, 0.0, FLOOR_TOP_Z + 0.078), (0.52, 47.0, 0.060), mats["recess"], 0.018, 1)

    add_neon_channel(root, "cyan_left_middle_cross_route", (-11.6, -1.45), (-2.48, -1.45), 0.092, mats)
    add_neon_channel(root, "cyan_right_middle_cross_route", (2.48, -1.45), (11.6, -1.45), 0.092, mats)
    add_neon_channel(root, "cyan_left_lower_cross_route", (-11.6, 9.6), (-2.48, 9.6), 0.092, mats)
    add_neon_channel(root, "cyan_right_lower_cross_route", (2.48, 9.6), (11.6, 9.6), 0.092, mats)

    add_neon_channel(root, "yellow_top_door_floor_feed", (0.0, -25.1), (0.0, -22.55), 0.150, mats, "yellow", False)
    add_neon_channel(root, "yellow_bottom_door_floor_feed", (0.0, 22.55), (0.0, 25.1), 0.150, mats, "yellow", False)
    add_neon_channel(root, "yellow_left_door_floor_feed", (-25.1, 0.0), (-22.55, 0.0), 0.150, mats, "yellow", False)
    add_neon_channel(root, "yellow_right_door_floor_feed", (22.55, 0.0), (25.1, 0.0), 0.150, mats, "yellow", False)


def add_wall_module(root, name: str, side: str, center: float, length: float, mats: dict) -> None:
    if side in ["top", "bottom"]:
        sign = -1.0 if side == "top" else 1.0
        y = sign * 28.15
        add_box(root, f"{name}_deep_outer_plinth", (center, y + sign * 0.55, 0.38), (length, 2.55, 0.76), mats["recess"], 0.120, 2)
        add_box(root, f"{name}_dark_armored_wall_face", (center, y, 1.02), (length * 0.98, 2.05, 1.72), mats["outer_wall"], 0.135, 3)
        add_box(root, f"{name}_raised_top_cap", (center, y, 2.05), (length + 0.26, 2.45, 0.280), mats["edge"], 0.070, 1)
        add_box(root, f"{name}_top_black_inset_access_plate", (center, y, 2.230), (length * 0.64, 0.74, 0.050), mats["recess"], 0.020, 1)
        add_box(root, f"{name}_top_brushed_edge_plate_a", (center - length * 0.29, y, 2.285), (length * 0.16, 0.64, 0.038), mats["floor_variant"], 0.018, 1)
        add_box(root, f"{name}_top_brushed_edge_plate_b", (center + length * 0.29, y, 2.285), (length * 0.16, 0.64, 0.038), mats["floor_variant"], 0.018, 1)
        add_box(root, f"{name}_inner_cyan_wall_glow", (center, y - sign * 1.10, 1.16), (length * 0.80, 0.075, 0.115), mats["cyan"], 0.010, 1)
        add_box(root, f"{name}_black_recess_panel", (center, y - sign * 0.86, 1.04), (length * 0.56, 0.080, 0.62), mats["recess"], 0.018, 1)
        add_box(root, f"{name}_thin_top_cyan_status_slit", (center, y - sign * 0.70, 2.330), (length * 0.38, 0.055, 0.050), mats["cyan"], 0.006, 1)
    else:
        sign = -1.0 if side == "left" else 1.0
        x = sign * 28.15
        add_box(root, f"{name}_deep_outer_plinth", (x + sign * 0.55, center, 0.38), (2.55, length, 0.76), mats["recess"], 0.120, 2)
        add_box(root, f"{name}_dark_armored_wall_face", (x, center, 1.02), (2.05, length * 0.98, 1.72), mats["outer_wall"], 0.135, 3)
        add_box(root, f"{name}_raised_top_cap", (x, center, 2.05), (2.45, length + 0.26, 0.280), mats["edge"], 0.070, 1)
        add_box(root, f"{name}_top_black_inset_access_plate", (x, center, 2.230), (0.74, length * 0.64, 0.050), mats["recess"], 0.020, 1)
        add_box(root, f"{name}_top_brushed_edge_plate_a", (x, center - length * 0.29, 2.285), (0.64, length * 0.16, 0.038), mats["floor_variant"], 0.018, 1)
        add_box(root, f"{name}_top_brushed_edge_plate_b", (x, center + length * 0.29, 2.285), (0.64, length * 0.16, 0.038), mats["floor_variant"], 0.018, 1)
        add_box(root, f"{name}_inner_cyan_wall_glow", (x - sign * 1.10, center, 1.16), (0.075, length * 0.80, 0.115), mats["cyan"], 0.010, 1)
        add_box(root, f"{name}_black_recess_panel", (x - sign * 0.86, center, 1.04), (0.080, length * 0.56, 0.62), mats["recess"], 0.018, 1)
        add_box(root, f"{name}_thin_top_cyan_status_slit", (x - sign * 0.70, center, 2.330), (0.055, length * 0.38, 0.050), mats["cyan"], 0.006, 1)


def create_outer_frame(root, mats: dict) -> None:
    for side in ["top", "bottom"]:
        for index, center in enumerate([-21.0, -14.0, -7.0, 7.0, 14.0, 21.0]):
            add_wall_module(root, f"outer_frame_{side}_armored_segment_{index}", side, center, 6.70, mats)
    for side in ["left", "right"]:
        for index, center in enumerate([-21.0, -14.0, -7.0, 7.0, 14.0, 21.0]):
            add_wall_module(root, f"outer_frame_{side}_armored_segment_{index}", side, center, 6.70, mats)

    for sx in [-1.0, 1.0]:
        for sy in [-1.0, 1.0]:
            add_shadow_plate(root, f"outer_corner_cast_shadow_{int(sx)}_{int(sy)}", sx * 27.9, sy * 27.9, 4.3, 4.3, mats)
            add_box(root, f"outer_frame_corner_heavy_power_housing_{int(sx)}_{int(sy)}", (sx * 27.85, sy * 27.85, 1.04), (3.55, 3.55, 2.08), mats["outer_wall"], 0.160, 3)
            add_box(root, f"outer_frame_corner_top_black_access_panel_{int(sx)}_{int(sy)}", (sx * 27.85, sy * 27.85, 2.16), (1.52, 1.52, 0.110), mats["recess"], 0.035, 1)
            add_box(root, f"outer_frame_corner_cyan_side_strip_{int(sx)}_{int(sy)}", (sx * 26.70, sy * 27.85, 1.55), (0.090, 1.46, 0.160), mats["cyan"], 0.010, 1)
            add_box(root, f"outer_frame_corner_yellow_top_lens_{int(sx)}_{int(sy)}", (sx * 27.85, sy * 27.85, 2.28), (0.72, 0.72, 0.090), mats["yellow"], 0.018, 1)


def door_box(root, side: str, name: str, along: float, inward_offset: float, z: float, length: float, depth: float, height: float, mat, bevel: float, mats: dict):
    if side in ["top", "bottom"]:
        boundary = -28.35 if side == "top" else 28.35
        inward = 1.0 if side == "top" else -1.0
        return add_box(root, name, (along, boundary + inward * inward_offset, z), (length, depth, height), mat, bevel, 3)
    boundary = -28.35 if side == "left" else 28.35
    inward = 1.0 if side == "left" else -1.0
    return add_box(root, name, (boundary + inward * inward_offset, along, z), (depth, length, height), mat, bevel, 3)


def create_door(root, side: str, mats: dict) -> None:
    door_name = {
        "top": "enemy_door_top",
        "bottom": "enemy_door_bottom",
        "left": "enemy_door_left",
        "right": "enemy_door_right",
    }[side]
    door = door_box(root, side, door_name, 0.0, 0.20, 1.30, 10.90, 4.70, 2.60, mats["door"], 0.145, mats)
    door["animation_ready"] = True
    door["sector_1_spawn_door"] = side
    door_box(root, side, f"{door_name}_deep_shadow_socket", 0.0, -0.22, 0.58, 11.70, 5.25, 0.44, mats["recess"], 0.110, mats)
    door_box(root, side, f"{door_name}_raised_outer_housing_cap", 0.0, -0.52, 2.66, 11.72, 5.12, 0.330, mats["edge"], 0.070, mats)
    door_box(root, side, f"{door_name}_left_chunky_hinge_pillar", -5.95, 0.05, 1.42, 1.06, 5.18, 2.85, mats["outer_wall"], 0.095, mats)
    door_box(root, side, f"{door_name}_right_chunky_hinge_pillar", 5.95, 0.05, 1.42, 1.06, 5.18, 2.85, mats["outer_wall"], 0.095, mats)
    for index, along in enumerate([-2.70, 2.70]):
        door_box(root, side, f"{door_name}_top_segmented_dark_panel_{index}", along, 0.22, 2.87, 2.74, 1.54, 0.105, mats["recess"], 0.028, mats)
        door_box(root, side, f"{door_name}_top_segmented_panel_trim_{index}", along, 0.22, 2.96, 2.28, 1.06, 0.045, mats["edge"], 0.018, mats)
        door_box(root, side, f"{door_name}_raised_outer_leaf_plate_{index}", along, 0.36, 3.075, 3.62, 2.74, 0.115, mats["edge"], 0.038, mats)
        door_box(root, side, f"{door_name}_leaf_black_mech_recess_{index}", along, 0.36, 3.165, 2.56, 1.44, 0.060, mats["recess"], 0.020, mats)
        door_box(root, side, f"{door_name}_leaf_inner_metal_access_panel_{index}", along, 0.36, 3.225, 1.78, 0.78, 0.035, mats["door"], 0.014, mats)
        door_box(root, side, f"{door_name}_leaf_upper_cyan_data_slit_{index}", along, 1.28, 3.255, 1.12, 0.055, 0.046, mats["cyan"], 0.006, mats)
        door_box(root, side, f"{door_name}_leaf_lower_yellow_power_slit_{index}", along, -1.08, 3.260, 0.92, 0.055, 0.046, mats["yellow"], 0.006, mats)
    for index, along in enumerate([-4.10, 4.10]):
        door_box(root, side, f"{door_name}_cyan_corner_status_light_{index}", along, 1.86, 2.98, 1.05, 0.100, 0.100, mats["cyan"], 0.010, mats)
        door_box(root, side, f"{door_name}_yellow_corner_warning_lens_{index}", along, -1.82, 2.98, 0.72, 0.100, 0.100, mats["yellow"], 0.010, mats)
        door_box(root, side, f"{door_name}_outer_yellow_corner_bracket_{index}", along, -1.36, 3.220, 1.02, 0.085, 0.070, mats["yellow"], 0.008, mats)
        door_box(root, side, f"{door_name}_outer_cyan_corner_bracket_{index}", along, 1.48, 3.220, 0.92, 0.075, 0.070, mats["cyan"], 0.008, mats)
    door_box(root, side, f"{door_name}_central_yellow_header", 0.0, -1.42, 3.01, 2.10, 0.115, 0.100, mats["yellow"], 0.012, mats)
    door_box(root, side, f"{door_name}_central_black_split_recess", 0.0, 0.36, 3.235, 0.180, 3.38, 0.060, mats["recess"], 0.006, mats)
    door_box(root, side, f"{door_name}_central_locking_spine", 0.0, 0.36, 3.305, 0.360, 2.28, 0.070, mats["edge"], 0.012, mats)
    for i, along in enumerate([-0.42, 0.0, 0.42]):
        door_box(root, side, f"{door_name}_yellow_chevron_arrow_{i}", along, -1.10 + abs(along) * 0.26, 3.08, 0.34, 0.090, 0.080, mats["yellow"], 0.010, mats)
    for index, along in enumerate([-2.0, 0.0, 2.0]):
        door_box(root, side, f"{door_name}_front_layered_mech_rib_{index}", along, 2.00, 2.28, 0.22, 1.62, 0.260, mats["edge"], 0.018, mats)
    for index, along in enumerate([-5.42, 5.42]):
        door_box(root, side, f"{door_name}_side_hinge_top_black_socket_{index}", along, 0.24, 3.150, 0.62, 2.50, 0.070, mats["recess"], 0.014, mats)
        door_box(root, side, f"{door_name}_side_hinge_yellow_status_pair_{index}", along, -1.22, 3.245, 0.44, 0.070, 0.052, mats["yellow"], 0.006, mats)


def create_doors_and_spawn_markers(root, mats: dict) -> None:
    for side in ["top", "bottom", "left", "right"]:
        create_door(root, side, mats)
    marker_data = {
        "enemy_spawn_door_top": (0.0, -24.2, 0.14),
        "enemy_spawn_door_bottom": (0.0, 24.2, 0.14),
        "enemy_spawn_door_left": (-24.2, 0.0, 0.14),
        "enemy_spawn_door_right": (24.2, 0.0, 0.14),
    }
    for name, location in marker_data.items():
        marker = bpy.data.objects.new(name, None)
        marker.empty_display_type = "ARROWS"
        marker.empty_display_size = 1.25
        marker.location = location
        marker["marker_type"] = "enemy_spawn_door"
        marker["visual_only_integration"] = True
        bpy.context.collection.objects.link(marker)
        marker.parent = root


def add_tapered_prism(root, name: str, x: float, y: float, height: float, bottom_size, top_size, mat, rotation_z: float):
    bx, by = bottom_size
    tx, ty = top_size
    z0 = 0.72
    z1 = z0 + height
    z2 = z1 + 0.48
    vertices = [
        (-bx * 0.5, -by * 0.5, z0),
        (bx * 0.5, -by * 0.5, z0),
        (bx * 0.5, by * 0.5, z0),
        (-bx * 0.5, by * 0.5, z0),
        (-tx * 0.5, -ty * 0.5, z1),
        (tx * 0.5, -ty * 0.5, z1),
        (tx * 0.5, ty * 0.5, z1),
        (-tx * 0.5, ty * 0.5, z1),
        (0.0, -ty * 0.42, z2),
        (tx * 0.42, 0.0, z2),
        (0.0, ty * 0.42, z2),
        (-tx * 0.42, 0.0, z2),
    ]
    faces = [
        (0, 1, 2, 3),
        (0, 4, 5, 1),
        (1, 5, 6, 2),
        (2, 6, 7, 3),
        (3, 7, 4, 0),
        (4, 8, 9, 5),
        (5, 9, 10, 6),
        (6, 10, 11, 7),
        (7, 11, 8, 4),
        (8, 9, 10, 11),
    ]
    mesh = bpy.data.meshes.new(f"{name}_Mesh")
    mesh.from_pydata(vertices, [], faces)
    mesh.update()
    obj = bpy.data.objects.new(name, mesh)
    obj.location = (x, y, 0.0)
    obj.rotation_euler.z = rotation_z
    obj.data.materials.append(mat)
    bpy.context.collection.objects.link(obj)
    obj.parent = root
    add_bevel(obj, 0.080, 3)
    return obj


def rotated_offset(x: float, y: float, angle: float) -> tuple[float, float]:
    return (
        x * math.cos(angle) - y * math.sin(angle),
        x * math.sin(angle) + y * math.cos(angle),
    )


def create_pillar(root, name: str, x: float, y: float, rotation_z: float, mats: dict) -> None:
    add_shadow_plate(root, f"{name}_broad_cast_shadow", x, y, 4.90, 6.10, mats, rotation_z)
    add_box(root, f"{name}_wide_stepped_plinth_shadow", (x, y, 0.22), (4.60, 5.18, 0.44), mats["recess"], 0.180, 3, rotation_z)
    add_box(root, f"{name}_wide_stepped_plinth_metal", (x, y, 0.50), (4.06, 4.62, 0.56), mats["outer_wall"], 0.155, 3, rotation_z)
    add_box(root, f"{name}_dark_plinth_top_recess", (x, y, 0.84), (3.28, 3.74, 0.070), mats["recess"], 0.055, 1, rotation_z)
    pillar = add_tapered_prism(root, name, x, y, 4.65, (2.92, 4.05), (1.46, 2.08), mats["pillar"], rotation_z)
    pillar["mockup_role"] = "tall angled obelisk pillar matching reference"
    add_box(root, f"{name}_top_edge_trim_ring", (x, y, 5.88), (1.82, 2.48, 0.078), mats["edge"], 0.030, 1, rotation_z)
    add_box(root, f"{name}_top_black_access_panel", (x, y, 5.95), (1.28, 1.82, 0.080), mats["recess"], 0.030, 1, rotation_z)
    top_rx, top_ry = rotated_offset(0.0, -0.78, rotation_z)
    add_box(root, f"{name}_top_cyan_short_lens", (x + top_rx, y + top_ry, 6.02), (0.92, 0.070, 0.050), mats["cyan"], 0.006, 1, rotation_z)
    top_rx, top_ry = rotated_offset(0.0, 0.82, rotation_z)
    add_box(root, f"{name}_top_yellow_warning_lens", (x + top_rx, y + top_ry, 6.02), (0.74, 0.070, 0.050), mats["yellow"], 0.006, 1, rotation_z)
    for index, (ox, oy) in enumerate([(-1.16, 0.0), (1.16, 0.0)]):
        rx, ry = rotated_offset(ox, oy, rotation_z)
        add_box(root, f"{name}_yellow_vertical_power_strip_{index}", (x + rx, y + ry, 3.18), (0.140, 0.105, 2.86), mats["yellow"], 0.012, 1, rotation_z)
    for index, (ox, oy) in enumerate([(0.0, -2.08), (0.0, 2.08)]):
        rx, ry = rotated_offset(ox, oy, rotation_z)
        add_box(root, f"{name}_cyan_side_status_inset_{index}", (x + rx, y + ry, 2.36), (1.24, 0.075, 0.140), mats["cyan"], 0.010, 1, rotation_z)
    for index, ox in enumerate([-1.74, 1.74]):
        rx, ry = rotated_offset(ox, 1.94, rotation_z)
        add_box(root, f"{name}_yellow_plinth_corner_lens_{index}", (x + rx, y + ry, 0.94), (0.44, 0.080, 0.100), mats["yellow"], 0.010, 1, rotation_z)
    for index, oy in enumerate([-2.18, 2.18]):
        rx, ry = rotated_offset(0.0, oy, rotation_z)
        add_box(root, f"{name}_cyan_plinth_edge_rail_{index}", (x + rx, y + ry, 0.98), (1.58, 0.075, 0.090), mats["cyan"], 0.008, 1, rotation_z)


def create_pillars(root, mats: dict) -> None:
    create_pillar(root, "pillar_northwest", -15.35, -15.25, math.radians(-19.0), mats)
    create_pillar(root, "pillar_northeast", 15.35, -15.25, math.radians(19.0), mats)
    create_pillar(root, "pillar_southwest", -15.35, 15.75, math.radians(19.0), mats)
    create_pillar(root, "pillar_southeast", 15.35, 15.75, math.radians(-19.0), mats)


def create_cover_wall(root, name: str, x: float, y: float, mats: dict) -> None:
    add_shadow_plate(root, f"{name}_soft_contact_shadow", x, y, 8.25, 3.45, mats)
    add_box(root, f"{name}_deep_black_base_socket", (x, y, 0.28), (7.88, 2.72, 0.56), mats["recess"], 0.130, 3)
    cover = add_box(root, name, (x, y, 0.86), (7.22, 2.18, 1.22), mats["cover"], 0.120, 3)
    cover["mockup_role"] = "low rectangular sci-fi cover block matching reference"
    add_box(root, f"{name}_raised_top_armor_plate", (x, y, 1.56), (6.35, 1.52, 0.155), mats["edge"], 0.055, 1)
    add_box(root, f"{name}_top_black_service_inset", (x, y, 1.67), (4.72, 0.86, 0.050), mats["recess"], 0.024, 1)
    add_box(root, f"{name}_top_left_removable_panel", (x - 2.28, y, 1.725), (1.35, 1.04, 0.042), mats["cover"], 0.018, 1)
    add_box(root, f"{name}_top_right_removable_panel", (x + 2.28, y, 1.725), (1.35, 1.04, 0.042), mats["cover"], 0.018, 1)
    add_box(root, f"{name}_top_center_black_lock_slot", (x, y, 1.765), (1.34, 0.145, 0.036), mats["recess"], 0.006, 1)
    add_box(root, f"{name}_top_forward_yellow_light_bar", (x, y - 0.86, 1.755), (4.68, 0.070, 0.050), mats["yellow"], 0.006, 1)
    add_box(root, f"{name}_top_rear_cyan_light_bar", (x, y + 0.86, 1.755), (4.68, 0.070, 0.050), mats["cyan"], 0.006, 1)
    add_box(root, f"{name}_front_dark_recessed_face", (x, y - 1.13, 0.90), (5.72, 0.090, 0.500), mats["recess"], 0.018, 1)
    add_box(root, f"{name}_back_dark_recessed_face", (x, y + 1.13, 0.90), (5.72, 0.090, 0.500), mats["recess"], 0.018, 1)
    add_box(root, f"{name}_front_cyan_power_rail", (x, y - 1.23, 0.64), (4.95, 0.075, 0.100), mats["cyan"], 0.010, 1)
    add_box(root, f"{name}_back_cyan_power_rail", (x, y + 1.23, 0.64), (4.95, 0.075, 0.100), mats["cyan"], 0.010, 1)
    for index, sx in enumerate([-1.0, 1.0]):
        add_box(root, f"{name}_yellow_front_corner_lens_{index}", (x + sx * 3.18, y - 1.20, 1.08), (0.58, 0.085, 0.120), mats["yellow"], 0.010, 1)
        add_box(root, f"{name}_yellow_back_corner_lens_{index}", (x + sx * 3.18, y + 1.20, 1.08), (0.58, 0.085, 0.120), mats["yellow"], 0.010, 1)
        add_box(root, f"{name}_side_black_mech_cap_{index}", (x + sx * 3.74, y, 0.86), (0.220, 1.72, 0.92), mats["outer_wall"], 0.040, 1)


def create_cover_walls(root, mats: dict) -> None:
    create_cover_wall(root, "cover_wall_northwest", -9.70, -5.60, mats)
    create_cover_wall(root, "cover_wall_northeast", 9.70, -5.60, mats)
    create_cover_wall(root, "cover_wall_southwest", -9.70, 8.70, mats)
    create_cover_wall(root, "cover_wall_southeast", 9.70, 8.70, mats)


def aim_camera_at(obj, target) -> None:
    direction = Vector(target) - obj.location
    obj.rotation_euler = direction.to_track_quat("-Z", "Y").to_euler()


def configure_render_settings() -> None:
    try:
        bpy.context.scene.render.engine = "BLENDER_EEVEE_NEXT"
    except TypeError:
        bpy.context.scene.render.engine = "BLENDER_EEVEE"
    eevee = getattr(bpy.context.scene, "eevee", None)
    if eevee is not None:
        if hasattr(eevee, "taa_render_samples"):
            eevee.taa_render_samples = 96
        if hasattr(eevee, "use_gtao"):
            eevee.use_gtao = True
        if hasattr(eevee, "gtao_distance"):
            eevee.gtao_distance = 4.5
        if hasattr(eevee, "gtao_factor"):
            eevee.gtao_factor = 2.20
        if hasattr(eevee, "use_bloom"):
            eevee.use_bloom = True
        if hasattr(eevee, "bloom_intensity"):
            eevee.bloom_intensity = 0.080
    bpy.context.scene.render.resolution_x = 2048
    bpy.context.scene.render.resolution_y = 2048
    bpy.context.scene.view_settings.view_transform = "Filmic"
    bpy.context.scene.view_settings.look = "Medium High Contrast"
    bpy.context.scene.view_settings.exposure = -0.28
    bpy.context.scene.view_settings.gamma = 1.0


def setup_preview_camera_and_lights() -> None:
    camera_data = bpy.data.cameras.new("TopDownOrthographicReferenceProofCamera")
    camera = bpy.data.objects.new("TopDownOrthographicReferenceProofCamera", camera_data)
    camera.location = (0.0, -18.0, 63.0)
    aim_camera_at(camera, (0.0, 0.0, 0.0))
    camera_data.type = "ORTHO"
    camera_data.ortho_scale = 62.0
    bpy.context.collection.objects.link(camera)
    bpy.context.scene.camera = camera

    gameplay_camera_data = bpy.data.cameras.new("ReferenceGameplayCamera")
    gameplay_camera = bpy.data.objects.new("ReferenceGameplayCamera", gameplay_camera_data)
    gameplay_camera.location = (0.0, -34.0, 33.0)
    aim_camera_at(gameplay_camera, (0.0, 0.0, 0.0))
    gameplay_camera_data.type = "ORTHO"
    gameplay_camera_data.ortho_scale = 47.5
    bpy.context.collection.objects.link(gameplay_camera)

    key_data = bpy.data.lights.new("LargeSoftTopDownKeyLight", "AREA")
    key = bpy.data.objects.new("LargeSoftTopDownKeyLight", key_data)
    key.location = (-15.0, -24.0, 32.0)
    aim_camera_at(key, (0.0, 0.0, 0.0))
    key_data.energy = 820.0
    key_data.size = 16.0
    if hasattr(key_data, "use_shadow"):
        key_data.use_shadow = True
    if hasattr(key_data, "use_contact_shadow"):
        key_data.use_contact_shadow = True
    if hasattr(key_data, "contact_shadow_distance"):
        key_data.contact_shadow_distance = 8.0
    bpy.context.collection.objects.link(key)

    rim_data = bpy.data.lights.new("CyanArenaGlowBounce", "POINT")
    rim = bpy.data.objects.new("CyanArenaGlowBounce", rim_data)
    rim.location = (0.0, 0.0, 6.5)
    rim_data.color = (0.0, 0.72, 1.0)
    rim_data.energy = 85.0
    rim_data.shadow_soft_size = 18.0
    bpy.context.collection.objects.link(rim)

    for name, loc, color, energy in [
        ("YellowTopDoorAccentLight", (0.0, -25.0, 3.2), (1.0, 0.86, 0.12), 45.0),
        ("YellowBottomDoorAccentLight", (0.0, 25.0, 3.2), (1.0, 0.86, 0.12), 45.0),
        ("CyanLeftLaneAccentLight", (-20.0, 0.0, 2.6), (0.0, 0.82, 1.0), 55.0),
        ("CyanRightLaneAccentLight", (20.0, 0.0, 2.6), (0.0, 0.82, 1.0), 55.0),
    ]:
        data = bpy.data.lights.new(name, "POINT")
        light = bpy.data.objects.new(name, data)
        light.location = loc
        data.color = color
        data.energy = energy
        data.shadow_soft_size = 8.0
        if hasattr(data, "use_contact_shadow"):
            data.use_contact_shadow = True
        if hasattr(data, "contact_shadow_distance"):
            data.contact_shadow_distance = 5.0
        bpy.context.collection.objects.link(light)


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
    bpy.context.scene.unit_settings.system = "METRIC"
    configure_render_settings()
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector1_HD_Mockup_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.0, 0.003, 0.010)

    add_reference_plane()

    root = bpy.data.objects.new("Sector1HDMockupArenaRoot", None)
    root.empty_display_type = "CUBE"
    root.empty_display_size = 56.0
    root["neon_swarm_asset"] = "sector_1_hd_mockup_arena_reference_rebuild"
    root["reference_image"] = str(REFERENCE_IMAGE.relative_to(REPO_ROOT))
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["collision"] = "visual_only_no_collision"
    root["layout_mapping"] = "reference-traced four doors, four obelisk pillars, four cover blocks, central H lane"
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_floor_system(root, mats)
    create_floor_depth_overlays(root, mats)
    create_neon_routing(root, mats)
    create_outer_frame(root, mats)
    create_doors_and_spawn_markers(root, mats)
    create_pillars(root, mats)
    create_cover_walls(root, mats)
    setup_preview_camera_and_lights()
    return root


def save_render() -> None:
    PROOF_RENDER.parent.mkdir(parents=True, exist_ok=True)
    LEGACY_TOPDOWN_RENDER.parent.mkdir(parents=True, exist_ok=True)
    bpy.context.scene.render.filepath = str(PROOF_RENDER)
    bpy.ops.render.render(write_still=True)
    render_result = bpy.data.images.get("Render Result")
    if render_result is not None:
        render_result.save_render(str(LEGACY_TOPDOWN_RENDER))


def export_assets(root) -> None:
    SOURCE_BLEND.parent.mkdir(parents=True, exist_ok=True)
    EXPORT_GLB.parent.mkdir(parents=True, exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(SOURCE_BLEND))
    select_export_hierarchy(root)
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
    print(f"reference_image={REFERENCE_IMAGE}")
    print(f"saved_blend={SOURCE_BLEND}")
    print(f"proof_render={PROOF_RENDER}")
    print(f"exported_glb={EXPORT_GLB}")


if __name__ == "__main__":
    export_root = setup_scene()
    save_render()
    export_assets(export_root)
