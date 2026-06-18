import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_2/source/blender/sector_2_prism_rift_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_2/exported/sector_2_prism_rift_arena.glb"

ARENA_HALF_SIZE = 28.0
DECK_HALF_SIZE = 27.35
FLOOR_TOP_Z = 0.0
SUPPORT_THICKNESS = 0.34
GLASS_THICKNESS = 0.060
CHANNEL_Z = 0.122


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
    alpha: float = 1.0,
    transmission: float = 0.0,
):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    bsdf = mat.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        set_input(bsdf, ["Base Color"], color)
        set_input(bsdf, ["Metallic"], metallic)
        set_input(bsdf, ["Roughness"], roughness)
        set_input(bsdf, ["Alpha"], alpha)
        set_input(bsdf, ["Transmission Weight", "Transmission"], transmission)
        if emission is not None and emission_strength > 0.0:
            set_input(bsdf, ["Emission Color", "Emission"], emission)
            set_input(bsdf, ["Emission Strength"], emission_strength)
    mat.diffuse_color = (color[0], color[1], color[2], alpha)
    if alpha < 1.0:
        mat.blend_method = "BLEND"
        mat.show_transparent_back = True
        if hasattr(mat, "use_screen_refraction"):
            mat.use_screen_refraction = True
    return mat


def make_materials() -> dict:
    return {
        "void": make_principled_material(
            "NS_S2_HR2_Deep_Amethyst_Void_AAA",
            (0.070, 0.032, 0.110, 1.0),
            0.30,
            0.78,
            (0.035, 0.010, 0.070, 1.0),
            0.020,
        ),
        "gunmetal": make_principled_material(
            "NS_S2_HR2_Gunmetal_Support_AAA",
            (0.285, 0.218, 0.345, 1.0),
            0.66,
            0.38,
            (0.090, 0.035, 0.145, 1.0),
            0.060,
        ),
        "dark_metal": make_principled_material(
            "NS_S2_HR2_Dark_Violet_Subframe_AAA",
            (0.175, 0.105, 0.245, 1.0),
            0.58,
            0.50,
            (0.060, 0.020, 0.110, 1.0),
            0.045,
        ),
        "seam": make_principled_material(
            "NS_S2_HR2_Dark_Recessed_Seam_AAA",
            (0.048, 0.025, 0.074, 1.0),
            0.36,
            0.84,
            (0.018, 0.004, 0.042, 1.0),
            0.012,
        ),
        "prism_glass": make_principled_material(
            "NS_S2_HR2_Violet_Prism_Glass_AAA",
            (0.430, 0.285, 0.620, 1.0),
            0.05,
            0.18,
            (0.145, 0.060, 0.270, 1.0),
            0.105,
            0.90,
            0.18,
        ),
        "frosted_glass": make_principled_material(
            "NS_S2_HR2_Frosted_Amethyst_Glass_AAA",
            (0.535, 0.360, 0.735, 1.0),
            0.08,
            0.30,
            (0.170, 0.070, 0.310, 1.0),
            0.115,
            0.88,
            0.12,
        ),
        "edge_tint": make_principled_material(
            "NS_S2_HR2_Beveled_Edge_Tint_AAA",
            (0.650, 0.430, 0.930, 1.0),
            0.12,
            0.24,
            (0.210, 0.080, 0.390, 1.0),
            0.145,
        ),
        "magenta_channel": make_principled_material(
            "NS_S2_HR2_Embedded_Magenta_Channel_AAA",
            (0.650, 0.070, 0.520, 1.0),
            0.02,
            0.34,
            (0.900, 0.080, 0.720, 1.0),
            0.300,
        ),
        "cyan_channel": make_principled_material(
            "NS_S2_HR2_Cyan_Prism_Core_AAA",
            (0.070, 0.500, 0.680, 1.0),
            0.02,
            0.32,
            (0.070, 0.760, 0.940, 1.0),
            0.240,
        ),
        "boundary": make_principled_material(
            "NS_S2_HR2_Boundary_Rail_AAA",
            (0.235, 0.155, 0.305, 1.0),
            0.72,
            0.36,
            (0.100, 0.034, 0.180, 1.0),
            0.070,
        ),
        "sheen": make_principled_material(
            "NS_S2_HR2_Soft_Prism_Sheen_AAA",
            (0.575, 0.385, 0.795, 1.0),
            0.10,
            0.20,
            (0.190, 0.070, 0.360, 1.0),
            0.120,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    if hasattr(obj.data, "use_auto_smooth"):
        obj.data.use_auto_smooth = True
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
    weighted = obj.modifiers.new("weighted_normals_for_prism_faces", "WEIGHTED_NORMAL")
    weighted.keep_sharp = True
    if hasattr(weighted, "weight"):
        weighted.weight = 50


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


def add_cylinder_between(root, name: str, start, end, radius: float, material, vertices: int = 10):
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
    add_bevel_and_weighted_normals(obj, 0.004, 1)
    obj.parent = root
    return obj


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
    mesh.materials.append(top_material)
    mesh.materials.append(side_material)
    mesh.polygons[0].material_index = 0
    for polygon in mesh.polygons[1:]:
        polygon.material_index = 1
    mesh.update()
    obj = bpy.data.objects.new(name, mesh)
    bpy.context.collection.objects.link(obj)
    obj.parent = root
    add_bevel_and_weighted_normals(obj, bevel, segments)
    return obj


def inset_points(points, scale: float, x_bias: float = 0.0, y_bias: float = 0.0):
    center_x = sum(point[0] for point in points) / float(len(points)) + x_bias
    center_y = sum(point[1] for point in points) / float(len(points)) + y_bias
    return [
        (center_x + (point[0] - center_x) * scale, center_y + (point[1] - center_y) * scale)
        for point in points
    ]


def offset_points(points, x_offset: float, y_offset: float):
    return [(x + x_offset, y + y_offset) for x, y in points]


def create_understructure(root, mats: dict) -> None:
    add_box(root, "Sector2HR2ContinuousAmethystVoidBelowDeck", (0.0, 0.0, -0.410), (58.6, 58.6, 0.38), mats["void"], 0.160, 2)
    add_box(root, "Sector2HR2SunkenCentralGunmetalRib", (0.0, 0.0, -0.125), (20.6, 10.4, 0.15), mats["dark_metal"], 0.100, 2, math.radians(45.0))
    for index, y in enumerate([-22.4, -13.4, -4.5, 4.5, 13.4, 22.4]):
        add_bar_between(root, f"Sector2HR2VisibleUndercarriageCrossbeam{index}", (-25.8, y), (25.8, y), 0.32, 0.115, -0.125, mats["dark_metal"], 0.028, 1)
    for index, x in enumerate([-22.4, -13.4, -4.5, 4.5, 13.4, 22.4]):
        add_bar_between(root, f"Sector2HR2VisibleUndercarriageLongitudinalBeam{index}", (x, -25.8), (x, 25.8), 0.30, 0.105, -0.145, mats["dark_metal"], 0.026, 1)


def fractured_cell_points(x0: float, x1: float, y0: float, y1: float, row: int, col: int):
    width = x1 - x0
    height = y1 - y0
    shift_a = ((row * 13 + col * 7) % 5 - 2) * 0.055
    shift_b = ((row * 5 + col * 11) % 5 - 2) * 0.048
    cut = 0.12 + ((row + col) % 4) * 0.025
    return [
        (x0 + width * (0.06 + max(0.0, shift_a)), y0 + height * (0.04 + max(0.0, -shift_b))),
        (x1 - width * (0.07 + max(0.0, -shift_a)), y0 + height * (0.08 + max(0.0, shift_b))),
        (x1 - width * (0.03 + cut * 0.20), y1 - height * (0.10 + cut * 0.16)),
        (x0 + width * (0.12 + cut * 0.08), y1 - height * (0.05 + cut * 0.12)),
    ]


def create_fractured_deck(root, mats: dict) -> None:
    boundaries = [-DECK_HALF_SIZE, -18.25, -9.05, 0.0, 9.05, 18.25, DECK_HALF_SIZE]
    for row in range(6):
        for col in range(6):
            x0 = boundaries[col] + 0.32
            x1 = boundaries[col + 1] - 0.32
            y0 = boundaries[row] + 0.32
            y1 = boundaries[row + 1] - 0.32
            points = fractured_cell_points(x0, x1, y0, y1, row, col)
            lift = [-0.026, -0.010, 0.010, 0.024][(row + col * 2) % 4]
            top_material = mats["gunmetal"] if (row + col) % 3 != 1 else mats["dark_metal"]
            side_material = mats["dark_metal"] if (row + col) % 2 == 0 else mats["seam"]
            add_poly_prism(
                root,
                f"Sector2HR2GunmetalSupportPanelR{row}C{col}",
                points,
                FLOOR_TOP_Z + lift,
                SUPPORT_THICKNESS + ((row * 7 + col) % 3) * 0.020,
                top_material,
                side_material,
                0.075,
                2,
            )

            glass_scale = 0.60 + ((row * 3 + col * 5) % 4) * 0.030
            glass_points = inset_points(points, glass_scale)
            if (row * 3 + col) % 5 == 0:
                glass_points = offset_points(glass_points, 0.18 if col < 3 else -0.18, -0.12 if row < 3 else 0.12)
            glass_material = mats["prism_glass"] if (row + col) % 2 == 0 else mats["frosted_glass"]
            add_poly_prism(
                root,
                f"Sector2HR2VisiblePrismGlassPanelR{row}C{col}",
                glass_points,
                FLOOR_TOP_Z + lift + 0.106,
                GLASS_THICKNESS,
                glass_material,
                mats["edge_tint"],
                0.040,
                1,
            )

            # Raised lips are short mechanical edges, not glowing decoration.
            lip_pairs = [(0, 1), (2, 3)] if (row + col) % 2 == 0 else [(1, 2), (3, 0)]
            for lip_index, (a, b) in enumerate(lip_pairs):
                p0 = points[a]
                p1 = points[b]
                add_bar_between(
                    root,
                    f"Sector2HR2RaisedPrismTrimR{row}C{col}_{lip_index}",
                    p0,
                    p1,
                    0.090,
                    0.070,
                    FLOOR_TOP_Z + lift + 0.105,
                    mats["boundary"] if lip_index == 0 else mats["dark_metal"],
                    0.018,
                    1,
                )

            if (row + col) % 4 == 0:
                c_x = sum(p[0] for p in glass_points) / len(glass_points)
                c_y = sum(p[1] for p in glass_points) / len(glass_points)
                angle = math.radians(90 if row % 2 == 0 else 0)
                add_box(
                    root,
                    f"Sector2HR2ShortEmbeddedPrismSheenR{row}C{col}",
                    (c_x, c_y, FLOOR_TOP_Z + lift + 0.153),
                    (1.45, 0.045, 0.020),
                    mats["sheen"],
                    0.008,
                    1,
                    angle,
                )


def create_recessed_seams_and_channels(root, mats: dict) -> None:
    for index, coord in enumerate([-18.25, -9.05, 0.0, 9.05, 18.25]):
        add_bar_between(root, f"Sector2HR2RecessedVerticalMechanicalSeam{index}", (coord, -26.8), (coord, 26.8), 0.210, 0.070, 0.038, mats["seam"], 0.016, 1)
        add_bar_between(root, f"Sector2HR2RecessedHorizontalMechanicalSeam{index}", (-26.8, coord), (26.8, coord), 0.210, 0.070, 0.036, mats["seam"], 0.016, 1)

    channel_specs = [
        ("NorthWestShortMagenta", (-13.6, -15.8), (-8.4, -15.8), "magenta_channel"),
        ("NorthEastShortCyan", (8.0, -14.6), (14.2, -14.6), "cyan_channel"),
        ("SouthWestShortCyan", (-14.2, 14.0), (-8.0, 14.0), "cyan_channel"),
        ("SouthEastShortMagenta", (8.4, 15.4), (13.6, 15.4), "magenta_channel"),
        ("WestMidShortMagenta", (-21.4, -4.6), (-21.4, 3.6), "magenta_channel"),
        ("EastMidShortCyan", (21.4, -3.8), (21.4, 4.8), "cyan_channel"),
        ("CentralNorthRiftSocket", (-3.8, -5.7), (3.8, -5.7), "magenta_channel"),
        ("CentralSouthRiftSocket", (-3.8, 5.7), (3.8, 5.7), "cyan_channel"),
    ]
    for name, start, end, material_key in channel_specs:
        add_bar_between(
            root,
            f"Sector2HR2EmbeddedNeonChannel{name}",
            start,
            end,
            0.105,
            0.035,
            CHANNEL_Z,
            mats[material_key],
            0.010,
            1,
        )

    diamond = [(0.0, -8.8, CHANNEL_Z + 0.016), (8.8, 0.0, CHANNEL_Z + 0.016), (0.0, 8.8, CHANNEL_Z + 0.016), (-8.8, 0.0, CHANNEL_Z + 0.016)]
    for index in range(len(diamond)):
        material = mats["magenta_channel"] if index % 2 == 0 else mats["cyan_channel"]
        add_cylinder_between(root, f"Sector2HR2CentralPrismSocketShortTube{index}", diamond[index], diamond[(index + 1) % len(diamond)], 0.024, material, 8)


def create_central_prism_core(root, mats: dict) -> None:
    outer = [(0.0, -6.6), (6.6, 0.0), (0.0, 6.6), (-6.6, 0.0)]
    inner = inset_points(outer, 0.58)
    add_poly_prism(root, "Sector2HR2CentralRaisedGunmetalDiamondFrame", outer, 0.145, 0.160, mats["boundary"], mats["dark_metal"], 0.080, 2)
    add_poly_prism(root, "Sector2HR2CentralFrostedPrismGlassLens", inner, 0.238, 0.070, mats["frosted_glass"], mats["edge_tint"], 0.050, 1)
    add_bar_between(root, "Sector2HR2CentralLensNorthAnchorGroove", (-3.7, -2.0), (3.7, -2.0), 0.078, 0.040, 0.325, mats["seam"], 0.008, 1)
    add_bar_between(root, "Sector2HR2CentralLensSouthAnchorGroove", (-3.7, 2.0), (3.7, 2.0), 0.078, 0.040, 0.325, mats["seam"], 0.008, 1)
    add_box(root, "Sector2HR2CentralContainedMagentaRefractionSlot", (0.0, 0.0, 0.350), (3.8, 0.055, 0.040), mats["magenta_channel"], 0.008, 1, math.radians(45.0))
    add_box(root, "Sector2HR2CentralContainedCyanRefractionSlot", (0.0, 0.0, 0.355), (3.1, 0.050, 0.036), mats["cyan_channel"], 0.008, 1, math.radians(-45.0))


def add_boundary_segment(root, name: str, center: float, side: str, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    if side in ["north", "south"]:
        sign = -1.0 if side == "north" else 1.0
        y = sign * half
        add_box(root, f"{name}OuterGunmetalFooting", (center, y + sign * 0.52, 0.18), (7.35, 1.14, 0.36), mats["dark_metal"], 0.080, 1)
        add_box(root, f"{name}RaisedAngularBoundaryRail", (center, y + sign * 0.18, 0.62), (6.62, 0.48, 0.82), mats["boundary"], 0.095, 2)
        add_box(root, f"{name}InsetAmethystGlassArmorFace", (center, y - sign * 0.105, 0.73), (4.72, 0.060, 0.44), mats["prism_glass"], 0.025, 1)
        add_box(root, f"{name}InnerLowGunmetalCurb", (center, y - sign * 0.54, 0.175), (6.90, 0.36, 0.34), mats["gunmetal"], 0.050, 1)
        slot_material = mats["magenta_channel"] if int(abs(center)) % 16 == 0 else mats["cyan_channel"]
        add_box(root, f"{name}ShortEmbeddedBoundaryEnergySlot", (center, y - sign * 0.76, 0.46), (1.22, 0.050, 0.052), slot_material, 0.008, 1)
    else:
        sign = -1.0 if side == "west" else 1.0
        x = sign * half
        add_box(root, f"{name}OuterGunmetalFooting", (x + sign * 0.52, center, 0.18), (1.14, 7.35, 0.36), mats["dark_metal"], 0.080, 1)
        add_box(root, f"{name}RaisedAngularBoundaryRail", (x + sign * 0.18, center, 0.62), (0.48, 6.62, 0.82), mats["boundary"], 0.095, 2)
        add_box(root, f"{name}InsetAmethystGlassArmorFace", (x - sign * 0.105, center, 0.73), (0.060, 4.72, 0.44), mats["prism_glass"], 0.025, 1)
        add_box(root, f"{name}InnerLowGunmetalCurb", (x - sign * 0.54, center, 0.175), (0.36, 6.90, 0.34), mats["gunmetal"], 0.050, 1)
        slot_material = mats["cyan_channel"] if int(abs(center)) % 16 == 0 else mats["magenta_channel"]
        add_box(root, f"{name}ShortEmbeddedBoundaryEnergySlot", (x - sign * 0.76, center, 0.46), (0.050, 1.22, 0.052), slot_material, 0.008, 1)


def add_corner_anchor(root, name: str, x: float, y: float, mats: dict) -> None:
    sx = math.copysign(1.0, x)
    sy = math.copysign(1.0, y)
    add_box(root, f"{name}LayeredCornerSupportBaseX", (x - sx * 0.58, y, 0.28), (1.55, 3.10, 0.52), mats["dark_metal"], 0.090, 1)
    add_box(root, f"{name}LayeredCornerSupportBaseY", (x, y - sy * 0.58, 0.28), (3.10, 1.55, 0.52), mats["dark_metal"], 0.090, 1)
    add_box(root, f"{name}CutPrismAnchorCore", (x - sx * 0.15, y - sy * 0.15, 0.88), (1.15, 1.15, 1.14), mats["boundary"], 0.080, 2, math.radians(45.0))
    tri = [(x, y + sy * 0.92), (x - sx * 0.82, y - sy * 0.46), (x + sx * 0.82, y - sy * 0.46)]
    add_poly_prism(root, f"{name}ReadableAmethystPrismCap", tri, 1.50, 0.18, mats["frosted_glass"], mats["edge_tint"], 0.040, 1)


def add_prism_fin(root, name: str, location, radius: float, height: float, mats: dict, rotation_z: float) -> None:
    bpy.ops.mesh.primitive_cone_add(vertices=4, radius1=radius, radius2=radius * 0.18, depth=height, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.rotation_euler.z = rotation_z
    obj.data.materials.append(mats["frosted_glass"])
    add_bevel_and_weighted_normals(obj, 0.020, 1)
    obj.parent = root
    add_cylinder_between(
        root,
        f"{name}ContainedCyanPrismEdge",
        (location[0], location[1], location[2] - height * 0.28),
        (location[0], location[1], location[2] + height * 0.25),
        radius * 0.055,
        mats["cyan_channel"],
        4,
    )


def create_boundary_and_outer_prisms(root, mats: dict) -> None:
    segment_centers = [-24.0, -16.0, -8.0, 0.0, 8.0, 16.0, 24.0]
    for side in ["north", "south", "west", "east"]:
        for index, center in enumerate(segment_centers):
            add_boundary_segment(root, f"Sector2HR2Boundary_{side}_{index}_", center, side, mats)

    for index, (x, y) in enumerate([
        (-ARENA_HALF_SIZE, -ARENA_HALF_SIZE),
        (ARENA_HALF_SIZE, -ARENA_HALF_SIZE),
        (ARENA_HALF_SIZE, ARENA_HALF_SIZE),
        (-ARENA_HALF_SIZE, ARENA_HALF_SIZE),
    ]):
        add_corner_anchor(root, f"Sector2HR2CornerAnchor{index}_", x, y, mats)

    fin_specs = [
        ("NorthWestTall", -31.0, -23.0, 0.78, 0.38, 1.46, -0.30),
        ("NorthWestLow", -29.4, -25.7, 0.54, 0.25, 0.88, 0.42),
        ("NorthEastTall", 30.8, -22.4, 0.76, 0.36, 1.40, 0.22),
        ("SouthWestTall", -30.4, 22.7, 0.74, 0.36, 1.38, -0.16),
        ("SouthEastTall", 31.1, 23.5, 0.80, 0.40, 1.52, 0.34),
        ("NorthSmall", -5.8, -31.0, 0.50, 0.24, 0.86, 0.05),
        ("SouthSmall", 6.6, 31.0, 0.52, 0.25, 0.90, -0.08),
    ]
    for name, x, y, z, radius, height, rotation in fin_specs:
        add_prism_fin(root, f"Sector2HR2OuterGlassPrismFin{name}", (x, y, z), radius, height, mats, rotation)


def setup_scene() -> None:
    clear_scene()
    bpy.context.preferences.filepaths.save_version = 0
    bpy.context.scene.unit_settings.system = "METRIC"
    bpy.context.scene.render.engine = "CYCLES"
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector2_HR2_Prism_Rift_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.012, 0.002, 0.030)

    root = bpy.data.objects.new("Sector2PrismRiftHardRepair2BlenderArenaKitRoot", None)
    root.empty_display_type = "CUBE"
    root["neon_swarm_asset"] = "phase_39_hard_repair_2_sector_2_prism_rift_blender_arena"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["art_direction"] = "broken prism glass sci-fi deck with built gunmetal support, raised glass panels, recessed seams, and restrained embedded neon"
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_understructure(root, mats)
    create_fractured_deck(root, mats)
    create_recessed_seams_and_channels(root, mats)
    create_central_prism_core(root, mats)
    create_boundary_and_outer_prisms(root, mats)

    camera_data = bpy.data.cameras.new("ReferenceGameplayCamera")
    camera = bpy.data.objects.new("ReferenceGameplayCamera", camera_data)
    camera.location = (0.0, -34.0, 33.0)
    camera.rotation_euler = (math.radians(54.0), 0.0, 0.0)
    camera_data.type = "ORTHO"
    camera_data.ortho_scale = 47.5
    bpy.context.collection.objects.link(camera)

    light_data = bpy.data.lights.new("ReferenceSoftPrismPreviewAreaLight", "AREA")
    light = bpy.data.objects.new("ReferenceSoftPrismPreviewAreaLight", light_data)
    light.location = (0.0, -8.0, 14.0)
    light_data.energy = 420.0
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
            export_normals=True,
            export_materials="EXPORT",
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
