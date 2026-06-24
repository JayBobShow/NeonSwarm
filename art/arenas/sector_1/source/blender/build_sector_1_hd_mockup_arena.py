import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
REFERENCE_IMAGE = REPO_ROOT / "art/reference/sector_1_neon_grid/sector_1_neon_grid_hd_mockup.png"
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_1/source/blender/sector_1_hd_mockup_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_1/exported/sector_1_hd_mockup_arena.glb"
TOPDOWN_RENDER = REPO_ROOT / "art/arenas/sector_1/exported/sector_1_hd_mockup_arena_topdown.png"

ARENA_HALF_SIZE = 28.0
INNER_HALF_SIZE = 24.0
PANEL_COUNT = 7
PANEL_STEP = 8.0
PANEL_SIZE = 7.15
FLOOR_TOP_Z = 0.0
NEON_Z = 0.105


def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete()


def set_input(node, names, value) -> None:
    for name in names:
        if name in node.inputs:
            node.inputs[name].default_value = value
            return


def make_principled_material(
    name: str,
    color,
    metallic: float,
    roughness: float,
    emission=None,
    emission_strength: float = 0.0,
):
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
        "floor": make_principled_material(
            "mat_dark_metal_floor",
            (0.118, 0.137, 0.154, 1.0),
            0.58,
            0.50,
            (0.010, 0.045, 0.058, 1.0),
            0.05,
        ),
        "wall": make_principled_material(
            "mat_dark_metal_wall",
            (0.070, 0.084, 0.100, 1.0),
            0.62,
            0.55,
            (0.008, 0.035, 0.050, 1.0),
            0.035,
        ),
        "cyan": make_principled_material(
            "mat_cyan_neon",
            (0.000, 0.680, 0.850, 1.0),
            0.0,
            0.24,
            (0.000, 0.900, 1.000, 1.0),
            1.45,
        ),
        "yellow": make_principled_material(
            "mat_yellow_accent",
            (0.960, 0.880, 0.140, 1.0),
            0.0,
            0.28,
            (1.000, 0.900, 0.120, 1.0),
            1.20,
        ),
        "pillar": make_principled_material(
            "mat_pillar_metal",
            (0.155, 0.172, 0.184, 1.0),
            0.66,
            0.43,
            (0.015, 0.050, 0.060, 1.0),
            0.055,
        ),
        "door": make_principled_material(
            "mat_door_metal",
            (0.105, 0.116, 0.130, 1.0),
            0.70,
            0.44,
            (0.014, 0.040, 0.046, 1.0),
            0.045,
        ),
        "cover": make_principled_material(
            "mat_cover_metal",
            (0.128, 0.142, 0.156, 1.0),
            0.64,
            0.48,
            (0.014, 0.046, 0.054, 1.0),
            0.045,
        ),
        "recess": make_principled_material(
            "mat_black_recess",
            (0.014, 0.020, 0.030, 1.0),
            0.35,
            0.82,
            (0.000, 0.018, 0.026, 1.0),
            0.015,
        ),
        "edge": make_principled_material(
            "mat_cool_worn_edge_metal",
            (0.250, 0.290, 0.310, 1.0),
            0.54,
            0.36,
            (0.020, 0.078, 0.092, 1.0),
            0.07,
        ),
        "white": make_principled_material(
            "mat_cool_white_neon_core",
            (0.780, 0.950, 1.000, 1.0),
            0.0,
            0.18,
            (0.680, 0.960, 1.000, 1.0),
            1.85,
        ),
        "glass": make_principled_material(
            "mat_smoked_glass_plastic_accent",
            (0.060, 0.110, 0.135, 0.74),
            0.0,
            0.18,
            (0.000, 0.150, 0.220, 1.0),
            0.12,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    if hasattr(obj.data, "polygons"):
        for polygon in obj.data.polygons:
            polygon.use_smooth = True


def add_bevel(obj, amount: float, segments: int = 2) -> None:
    if amount > 0.0:
        bevel = obj.modifiers.new("modeled_beveled_edges", "BEVEL")
        bevel.width = amount
        bevel.segments = segments
        bevel.affect = "EDGES"
    if hasattr(obj.data, "use_auto_smooth"):
        obj.data.use_auto_smooth = True
    if hasattr(obj.data, "auto_smooth_angle"):
        obj.data.auto_smooth_angle = math.radians(45.0)
    try:
        normal = obj.modifiers.new("weighted_gameplay_normals", "WEIGHTED_NORMAL")
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


def add_neon_bar(root, name: str, start, end, width: float, height: float, mats: dict, material_key: str = "cyan") -> None:
    start_v = Vector((start[0], start[1], 0.0))
    end_v = Vector((end[0], end[1], 0.0))
    delta = end_v - start_v
    length = delta.length
    if length <= 0.001:
        return
    angle = math.atan2(delta.y, delta.x)
    mid = start_v + delta * 0.5
    add_box(
        root,
        f"{name}_dark_recess",
        (mid.x, mid.y, NEON_Z - 0.036),
        (length + width * 1.20, width * 2.55, 0.050),
        mats["recess"],
        0.026,
        1,
        angle,
    )
    add_box(
        root,
        name,
        (mid.x, mid.y, NEON_Z),
        (length, width, height),
        mats[material_key],
        0.018,
        2,
        angle,
    )
    if material_key == "cyan":
        add_box(
            root,
            f"{name}_white_inner_core",
            (mid.x, mid.y, NEON_Z + 0.014),
            (length * 0.965, max(0.035, width * 0.28), height * 0.45),
            mats["white"],
            0.010,
            1,
            angle,
        )


def add_loop(root, name_prefix: str, half_x: float, half_y: float, width: float, mats: dict) -> None:
    add_neon_bar(root, f"{name_prefix}_north", (-half_x, -half_y), (half_x, -half_y), width, 0.048, mats)
    add_neon_bar(root, f"{name_prefix}_south", (-half_x, half_y), (half_x, half_y), width, 0.048, mats)
    add_neon_bar(root, f"{name_prefix}_west", (-half_x, -half_y), (-half_x, half_y), width, 0.048, mats)
    add_neon_bar(root, f"{name_prefix}_east", (half_x, -half_y), (half_x, half_y), width, 0.048, mats)


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
        set_input(bsdf, ["Alpha"], 0.42)
    mat.blend_method = "BLEND"
    mat.diffuse_color = (1.0, 1.0, 1.0, 0.42)
    bpy.ops.mesh.primitive_plane_add(size=1.0, location=(0.0, 0.0, -0.72))
    plane = bpy.context.object
    plane.name = "ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_hidden_from_export"
    plane.data.name = "ReferenceOnly_sector_1_neon_grid_hd_mockup_blueprint_Mesh"
    plane.dimensions = (56.0, 56.0, 0.0)
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    plane.data.materials.append(mat)
    plane.hide_render = True
    plane["reference_image"] = str(REFERENCE_IMAGE.relative_to(REPO_ROOT))
    plane["exported"] = False


def create_floor_panels(root, mats: dict) -> None:
    add_box(root, "hd_mockup_underfloor_shadow_slab", (0.0, 0.0, -0.270), (58.0, 58.0, 0.34), mats["recess"], 0.160, 2)
    offset = float(PANEL_COUNT - 1) * PANEL_STEP * 0.5
    for row in range(PANEL_COUNT):
        for column in range(PANEL_COUNT):
            x = -offset + float(column) * PANEL_STEP
            y = -offset + float(row) * PANEL_STEP
            z_variation = [-0.016, -0.006, 0.010, 0.018][(row * 2 + column) % 4]
            obj = add_box(
                root,
                f"floor_panel_R{row}_C{column}",
                (x, y, -0.060 + z_variation),
                (PANEL_SIZE, PANEL_SIZE, 0.150),
                mats["floor"],
                0.145,
                3,
            )
            obj["panel_role"] = "modeled_floor_panel"
            lip_z = FLOOR_TOP_Z + 0.030 + z_variation
            add_box(root, f"floor_panel_R{row}_C{column}_north_lip", (x, y - 3.06, lip_z), (5.75, 0.150, 0.052), mats["edge"], 0.024, 1)
            add_box(root, f"floor_panel_R{row}_C{column}_south_lip", (x, y + 3.06, lip_z), (5.75, 0.150, 0.052), mats["edge"], 0.024, 1)
            if (row + column) % 2 == 0:
                add_box(root, f"floor_panel_R{row}_C{column}_service_hatch", (x - 0.48, y + 0.30, lip_z + 0.026), (2.90, 1.45, 0.052), mats["wall"], 0.045, 1)
                add_box(root, f"floor_panel_R{row}_C{column}_hatch_recess", (x - 0.48, y + 0.30, lip_z + 0.058), (2.10, 0.76, 0.020), mats["recess"], 0.014, 1)
            else:
                add_box(root, f"floor_panel_R{row}_C{column}_angled_panel_seam", (x + 0.40, y, lip_z + 0.026), (0.120, 3.45, 0.038), mats["wall"], 0.014, 1, math.radians(9.0))
                add_box(root, f"floor_panel_R{row}_C{column}_short_detail_plate", (x - 1.22, y + 1.35, lip_z + 0.030), (1.80, 0.130, 0.034), mats["edge"], 0.012, 1, math.radians(-4.0))
    for index in range(PANEL_COUNT + 1):
        p = -ARENA_HALF_SIZE + index * PANEL_STEP
        add_box(root, f"floor_panel_vertical_dark_seam_{index}", (p, 0.0, FLOOR_TOP_Z + 0.012), (0.160, 56.0, 0.032), mats["recess"], 0.016, 1)
        add_box(root, f"floor_panel_horizontal_dark_seam_{index}", (0.0, p, FLOOR_TOP_Z + 0.012), (56.0, 0.160, 0.032), mats["recess"], 0.016, 1)


def create_neon_routes(root, mats: dict) -> None:
    add_loop(root, "neon_route_outer_reference_square", 23.2, 23.2, 0.155, mats)
    add_loop(root, "neon_route_inner_reference_square", 18.0, 18.0, 0.105, mats)
    add_neon_bar(root, "neon_route_left_outer_vertical", (-20.7, -20.0), (-20.7, 20.0), 0.105, 0.044, mats)
    add_neon_bar(root, "neon_route_left_inner_vertical", (-11.7, -15.2), (-11.7, 15.2), 0.090, 0.042, mats)
    add_neon_bar(root, "neon_route_left_top_connector", (-20.7, -15.2), (-11.7, -15.2), 0.090, 0.042, mats)
    add_neon_bar(root, "neon_route_left_bottom_connector", (-20.7, 15.2), (-11.7, 15.2), 0.090, 0.042, mats)
    add_neon_bar(root, "neon_route_right_outer_vertical", (20.7, -20.0), (20.7, 20.0), 0.105, 0.044, mats)
    add_neon_bar(root, "neon_route_right_inner_vertical", (11.7, -15.2), (11.7, 15.2), 0.090, 0.042, mats)
    add_neon_bar(root, "neon_route_right_top_connector", (11.7, -15.2), (20.7, -15.2), 0.090, 0.042, mats)
    add_neon_bar(root, "neon_route_right_bottom_connector", (11.7, 15.2), (20.7, 15.2), 0.090, 0.042, mats)

    add_neon_bar(root, "neon_route_central_left_lane_top", (-2.35, -21.6), (-2.35, -3.8), 0.115, 0.052, mats, "white")
    add_neon_bar(root, "neon_route_central_right_lane_top", (2.35, -21.6), (2.35, -3.8), 0.115, 0.052, mats, "white")
    add_neon_bar(root, "neon_route_central_left_lane_bottom", (-2.35, 3.8), (-2.35, 21.6), 0.115, 0.052, mats, "white")
    add_neon_bar(root, "neon_route_central_right_lane_bottom", (2.35, 3.8), (2.35, 21.6), 0.115, 0.052, mats, "white")
    add_neon_bar(root, "neon_route_central_top_step", (-2.35, -3.8), (2.35, -3.8), 0.105, 0.050, mats, "white")
    add_neon_bar(root, "neon_route_central_bottom_step", (-2.35, 3.8), (2.35, 3.8), 0.105, 0.050, mats, "white")
    add_box(root, "central_dark_service_spine", (0.0, 0.0, FLOOR_TOP_Z + 0.045), (0.42, 48.0, 0.052), mats["recess"], 0.020, 1)

    add_neon_bar(root, "neon_route_left_mid_crossbar", (-12.0, -1.6), (-2.35, -1.6), 0.080, 0.038, mats)
    add_neon_bar(root, "neon_route_right_mid_crossbar", (2.35, -1.6), (12.0, -1.6), 0.080, 0.038, mats)
    add_neon_bar(root, "neon_route_left_lower_crossbar", (-12.0, 9.7), (-2.35, 9.7), 0.080, 0.038, mats)
    add_neon_bar(root, "neon_route_right_lower_crossbar", (2.35, 9.7), (12.0, 9.7), 0.080, 0.038, mats)
    for name, x, y in [
        ("neon_door_feed_top", 0.0, -24.0),
        ("neon_door_feed_bottom", 0.0, 24.0),
    ]:
        add_neon_bar(root, name, (x, y - 2.4 if y > 0 else y), (x, y if y > 0 else y + 2.4), 0.140, 0.050, mats, "yellow")
    add_neon_bar(root, "neon_door_feed_left", (-24.0, 0.0), (-21.6, 0.0), 0.140, 0.050, mats, "yellow")
    add_neon_bar(root, "neon_door_feed_right", (21.6, 0.0), (24.0, 0.0), 0.140, 0.050, mats, "yellow")


def add_frame_part(root, side: str, name: str, center: float, length: float, mats: dict) -> None:
    z_center = 0.70
    if side in ["top", "bottom"]:
        y = -ARENA_HALF_SIZE if side == "top" else ARENA_HALF_SIZE
        add_box(root, name, (center, y, z_center), (length, 2.15, 1.40), mats["wall"], 0.110, 2)
        add_box(root, f"{name}_inner_cyan_edge_light", (center, y + (0.96 if side == "top" else -0.96), 0.86), (length * 0.82, 0.060, 0.095), mats["cyan"], 0.012, 1)
        add_box(root, f"{name}_top_armor_cap", (center, y, 1.48), (length + 0.22, 2.35, 0.210), mats["edge"], 0.070, 1)
    else:
        x = -ARENA_HALF_SIZE if side == "left" else ARENA_HALF_SIZE
        add_box(root, name, (x, center, z_center), (2.15, length, 1.40), mats["wall"], 0.110, 2)
        add_box(root, f"{name}_inner_cyan_edge_light", (x + (0.96 if side == "left" else -0.96), center, 0.86), (0.060, length * 0.82, 0.095), mats["cyan"], 0.012, 1)
        add_box(root, f"{name}_top_armor_cap", (x, center, 1.48), (2.35, length + 0.22, 0.210), mats["edge"], 0.070, 1)


def create_outer_frame(root, mats: dict) -> None:
    for side in ["top", "bottom"]:
        add_frame_part(root, side, f"outer_frame_{side}_west_segment", -17.2, 14.0, mats)
        add_frame_part(root, side, f"outer_frame_{side}_east_segment", 17.2, 14.0, mats)
    for side in ["left", "right"]:
        add_frame_part(root, side, f"outer_frame_{side}_north_segment", -17.2, 14.0, mats)
        add_frame_part(root, side, f"outer_frame_{side}_south_segment", 17.2, 14.0, mats)
    for sx in [-1.0, 1.0]:
        for sy in [-1.0, 1.0]:
            add_box(root, f"outer_frame_corner_power_block_{int(sx)}_{int(sy)}", (sx * ARENA_HALF_SIZE, sy * ARENA_HALF_SIZE, 0.86), (3.00, 3.00, 1.72), mats["wall"], 0.150, 2)
            add_box(root, f"outer_frame_corner_cyan_vertical_{int(sx)}_{int(sy)}", (sx * 26.90, sy * ARENA_HALF_SIZE, 1.05), (0.080, 1.34, 0.135), mats["cyan"], 0.012, 1)
            add_box(root, f"outer_frame_corner_yellow_cap_{int(sx)}_{int(sy)}", (sx * 27.40, sy * 27.40, 1.68), (0.72, 0.72, 0.100), mats["yellow"], 0.020, 1)


def door_part(root, side: str, name: str, along: float, inward_offset: float, z: float, length: float, depth: float, height: float, mat, bevel: float, mats: dict):
    if side in ["top", "bottom"]:
        boundary = -ARENA_HALF_SIZE if side == "top" else ARENA_HALF_SIZE
        inward = 1.0 if side == "top" else -1.0
        return add_box(root, name, (along, boundary + inward * inward_offset, z), (length, depth, height), mat, bevel, 2)
    boundary = -ARENA_HALF_SIZE if side == "left" else ARENA_HALF_SIZE
    inward = 1.0 if side == "left" else -1.0
    return add_box(root, name, (boundary + inward * inward_offset, along, z), (depth, length, height), mat, bevel, 2)


def create_door(root, side: str, mats: dict) -> None:
    door_name = {
        "top": "enemy_door_top",
        "bottom": "enemy_door_bottom",
        "left": "enemy_door_left",
        "right": "enemy_door_right",
    }[side]
    door = door_part(root, side, door_name, 0.0, 0.12, 0.94, 9.55, 1.52, 1.88, mats["door"], 0.105, mats)
    door["animation_ready"] = True
    door["sector_1_spawn_door"] = side
    door_part(root, side, f"{door_name}_upper_armor_cap", 0.0, -0.10, 1.94, 10.20, 1.76, 0.260, mats["edge"], 0.060, mats)
    door_part(root, side, f"{door_name}_left_hinge_tower", -5.30, 0.02, 1.05, 0.74, 2.24, 2.10, mats["wall"], 0.080, mats)
    door_part(root, side, f"{door_name}_right_hinge_tower", 5.30, 0.02, 1.05, 0.74, 2.24, 2.10, mats["wall"], 0.080, mats)
    for index, along in enumerate([-2.35, 2.35]):
        door_part(root, side, f"{door_name}_segmented_inner_panel_{index}", along, 0.94, 0.96, 2.60, 0.080, 0.86, mats["recess"], 0.018, mats)
    for index, along in enumerate([-3.50, 3.50]):
        door_part(root, side, f"{door_name}_cyan_status_strip_{index}", along, 1.09, 1.45, 1.42, 0.070, 0.095, mats["cyan"], 0.010, mats)
    door_part(root, side, f"{door_name}_yellow_header_light", 0.0, 1.08, 1.70, 1.80, 0.070, 0.100, mats["yellow"], 0.012, mats)
    for index, along in enumerate([-0.42, 0.0, 0.42]):
        door_part(root, side, f"{door_name}_yellow_chevron_{index}", along, 1.12, 1.25 - abs(along) * 0.12, 0.28, 0.064, 0.070, mats["yellow"], 0.010, mats)


def create_doors_and_spawn_markers(root, mats: dict) -> None:
    for side in ["top", "bottom", "left", "right"]:
        create_door(root, side, mats)
    marker_data = {
        "enemy_spawn_door_top": (0.0, -24.4, 0.10),
        "enemy_spawn_door_bottom": (0.0, 24.4, 0.10),
        "enemy_spawn_door_left": (-24.4, 0.0, 0.10),
        "enemy_spawn_door_right": (24.4, 0.0, 0.10),
    }
    for name, location in marker_data.items():
        marker = bpy.data.objects.new(name, None)
        marker.empty_display_type = "ARROWS"
        marker.empty_display_size = 1.35
        marker.location = location
        marker["marker_type"] = "enemy_spawn_door"
        marker["visual_only_integration"] = True
        bpy.context.collection.objects.link(marker)
        marker.parent = root


def add_tapered_prism(root, name: str, x: float, y: float, height: float, bottom_size, top_size, mat, rotation_z: float):
    bx, by = bottom_size
    tx, ty = top_size
    z0 = 0.52
    z1 = z0 + height
    z2 = z1 + 0.28
    vertices = [
        (-bx * 0.5, -by * 0.5, z0),
        (bx * 0.5, -by * 0.5, z0),
        (bx * 0.5, by * 0.5, z0),
        (-bx * 0.5, by * 0.5, z0),
        (-tx * 0.5, -ty * 0.5, z1),
        (tx * 0.5, -ty * 0.5, z1),
        (tx * 0.5, ty * 0.5, z1),
        (-tx * 0.5, ty * 0.5, z1),
        (0.0, -ty * 0.36, z2),
        (tx * 0.36, 0.0, z2),
        (0.0, ty * 0.36, z2),
        (-tx * 0.36, 0.0, z2),
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
    add_bevel(obj, 0.060, 2)
    return obj


def rotated_offset(x: float, y: float, angle: float) -> tuple[float, float]:
    return (
        x * math.cos(angle) - y * math.sin(angle),
        x * math.sin(angle) + y * math.cos(angle),
    )


def create_pillar(root, name: str, x: float, y: float, rotation_z: float, mats: dict) -> None:
    add_box(root, f"{name}_wide_plinth", (x, y, 0.28), (3.05, 2.62, 0.56), mats["wall"], 0.120, 2, rotation_z)
    pillar = add_tapered_prism(root, name, x, y, 2.55, (2.05, 1.75), (1.20, 1.00), mats["pillar"], rotation_z)
    pillar["mockup_role"] = "tall angled obelisk pillar"
    add_box(root, f"{name}_top_dark_cap", (x, y, 3.33), (1.30, 1.00, 0.150), mats["recess"], 0.040, 1, rotation_z)
    for index, (ox, oy) in enumerate([(-1.08, 0.0), (1.08, 0.0)]):
        rx, ry = rotated_offset(ox, oy, rotation_z)
        add_box(root, f"{name}_yellow_vertical_trim_{index}", (x + rx, y + ry, 1.82), (0.105, 0.085, 1.56), mats["yellow"], 0.012, 1, rotation_z)
    for index, (ox, oy) in enumerate([(0.0, -0.98), (0.0, 0.98)]):
        rx, ry = rotated_offset(ox, oy, rotation_z)
        add_box(root, f"{name}_cyan_side_inset_{index}", (x + rx, y + ry, 1.32), (0.86, 0.070, 0.105), mats["cyan"], 0.010, 1, rotation_z)


def create_pillars(root, mats: dict) -> None:
    create_pillar(root, "pillar_northwest", -15.1, -15.6, math.radians(-18.0), mats)
    create_pillar(root, "pillar_northeast", 15.1, -15.6, math.radians(18.0), mats)
    create_pillar(root, "pillar_southwest", -15.1, 15.6, math.radians(18.0), mats)
    create_pillar(root, "pillar_southeast", 15.1, 15.6, math.radians(-18.0), mats)


def create_cover_wall(root, name: str, x: float, y: float, mats: dict) -> None:
    add_box(root, f"{name}_base_shadow", (x, y, 0.18), (7.25, 2.42, 0.36), mats["recess"], 0.100, 2)
    cover = add_box(root, name, (x, y, 0.62), (6.70, 1.82, 0.92), mats["cover"], 0.095, 2)
    cover["mockup_role"] = "low rectangular interior cover block"
    add_box(root, f"{name}_top_service_plate", (x, y, 1.12), (5.80, 1.25, 0.120), mats["edge"], 0.050, 1)
    add_box(root, f"{name}_front_dark_inset", (x, y - 0.94, 0.66), (5.30, 0.070, 0.360), mats["recess"], 0.016, 1)
    add_box(root, f"{name}_back_dark_inset", (x, y + 0.94, 0.66), (5.30, 0.070, 0.360), mats["recess"], 0.016, 1)
    add_box(root, f"{name}_front_cyan_low_rail", (x, y - 1.02, 0.46), (4.60, 0.060, 0.080), mats["cyan"], 0.010, 1)
    add_box(root, f"{name}_back_cyan_low_rail", (x, y + 1.02, 0.46), (4.60, 0.060, 0.080), mats["cyan"], 0.010, 1)
    for index, sx in enumerate([-1.0, 1.0]):
        add_box(root, f"{name}_yellow_corner_light_{index}", (x + sx * 3.02, y - 0.98, 0.90), (0.54, 0.070, 0.120), mats["yellow"], 0.010, 1)


def create_cover_walls(root, mats: dict) -> None:
    create_cover_wall(root, "cover_wall_northwest", -9.45, -5.55, mats)
    create_cover_wall(root, "cover_wall_northeast", 9.45, -5.55, mats)
    create_cover_wall(root, "cover_wall_southwest", -9.45, 8.65, mats)
    create_cover_wall(root, "cover_wall_southeast", 9.45, 8.65, mats)


def setup_preview_camera_and_lights() -> None:
    camera_data = bpy.data.cameras.new("TopDownComparisonCamera")
    camera = bpy.data.objects.new("TopDownComparisonCamera", camera_data)
    camera.location = (0.0, 0.0, 60.0)
    camera.rotation_euler = (0.0, 0.0, 0.0)
    camera_data.type = "ORTHO"
    camera_data.ortho_scale = 61.5
    bpy.context.collection.objects.link(camera)
    bpy.context.scene.camera = camera

    gameplay_camera_data = bpy.data.cameras.new("ReferenceGameplayCamera")
    gameplay_camera = bpy.data.objects.new("ReferenceGameplayCamera", gameplay_camera_data)
    gameplay_camera.location = (0.0, -34.0, 33.0)
    gameplay_camera.rotation_euler = (math.radians(54.0), 0.0, 0.0)
    gameplay_camera_data.type = "ORTHO"
    gameplay_camera_data.ortho_scale = 47.5
    bpy.context.collection.objects.link(gameplay_camera)

    key_data = bpy.data.lights.new("PreviewLargeSoftbox", "AREA")
    key = bpy.data.objects.new("PreviewLargeSoftbox", key_data)
    key.location = (-9.0, -8.0, 18.0)
    key_data.energy = 450.0
    key_data.size = 22.0
    bpy.context.collection.objects.link(key)

    fill_data = bpy.data.lights.new("PreviewCyanBounce", "POINT")
    fill = bpy.data.objects.new("PreviewCyanBounce", fill_data)
    fill.location = (11.0, 12.0, 9.0)
    fill_data.color = (0.20, 0.82, 1.0)
    fill_data.energy = 170.0
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


def setup_scene() -> None:
    clear_scene()
    bpy.context.scene.unit_settings.system = "METRIC"
    try:
        bpy.context.scene.render.engine = "BLENDER_EEVEE_NEXT"
    except TypeError:
        bpy.context.scene.render.engine = "BLENDER_EEVEE"
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector1_HD_Mockup_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.0, 0.004, 0.012)
    bpy.context.scene.render.resolution_x = 1600
    bpy.context.scene.render.resolution_y = 1600
    bpy.context.scene.eevee.taa_render_samples = 64

    add_reference_plane()

    root = bpy.data.objects.new("Sector1HDMockupArenaRoot", None)
    root.empty_display_type = "CUBE"
    root.empty_display_size = 56.0
    root["neon_swarm_asset"] = "sector_1_hd_mockup_arena"
    root["reference_image"] = str(REFERENCE_IMAGE.relative_to(REPO_ROOT))
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["collision"] = "visual_only_no_collision"
    root["layout_mapping"] = "four edge doors, four obelisk pillars, four low cover blocks, central routing lanes"
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_floor_panels(root, mats)
    create_neon_routes(root, mats)
    create_outer_frame(root, mats)
    create_doors_and_spawn_markers(root, mats)
    create_pillars(root, mats)
    create_cover_walls(root, mats)
    setup_preview_camera_and_lights()
    return root


def save_render() -> None:
    TOPDOWN_RENDER.parent.mkdir(parents=True, exist_ok=True)
    bpy.context.scene.render.filepath = str(TOPDOWN_RENDER)
    bpy.ops.render.render(write_still=True)


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
    print(f"exported_glb={EXPORT_GLB}")
    print(f"topdown_render={TOPDOWN_RENDER}")


if __name__ == "__main__":
    export_root = setup_scene()
    save_render()
    export_assets(export_root)
