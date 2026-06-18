import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_2/source/blender/sector_2_prism_rift_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_2/exported/sector_2_prism_rift_arena.glb"

ARENA_HALF_SIZE = 28.0
FLOOR_HALF_SIZE = 27.15
CELL_PITCH = 10.45
CELL_SPAN = 9.42
FLOOR_TOP_Z = 0.0


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
        "rift_backplane": make_principled_material(
            "NS_S2_HR3_Dark_Rift_Backplane_AAA",
            (0.064, 0.040, 0.096, 1.0),
            0.24,
            0.78,
            (0.026, 0.006, 0.056, 1.0),
            0.024,
        ),
        "black_frame": make_principled_material(
            "NS_S2_HR3_Black_Gunmetal_Frame_AAA",
            (0.138, 0.112, 0.178, 1.0),
            0.74,
            0.36,
            (0.056, 0.018, 0.100, 1.0),
            0.066,
        ),
        "graphite_panel": make_principled_material(
            "NS_S2_HR3_Beveled_Graphite_Panel_AAA",
            (0.220, 0.182, 0.278, 1.0),
            0.62,
            0.42,
            (0.078, 0.030, 0.138, 1.0),
            0.086,
        ),
        "dark_groove": make_principled_material(
            "NS_S2_HR3_Recessed_Black_Groove_AAA",
            (0.026, 0.020, 0.042, 1.0),
            0.44,
            0.86,
            (0.010, 0.002, 0.026, 1.0),
            0.010,
        ),
        "amethyst_glass": make_principled_material(
            "NS_S2_HR3_Amethyst_Prism_Glass_AAA",
            (0.470, 0.205, 0.700, 1.0),
            0.04,
            0.16,
            (0.180, 0.052, 0.350, 1.0),
            0.145,
            0.88,
            0.22,
        ),
        "deep_violet_glass": make_principled_material(
            "NS_S2_HR3_Deep_Violet_Glass_AAA",
            (0.280, 0.120, 0.460, 1.0),
            0.06,
            0.24,
            (0.100, 0.028, 0.220, 1.0),
            0.095,
            0.92,
            0.16,
        ),
        "magenta_rim": make_principled_material(
            "NS_S2_HR3_Magenta_Glass_Rim_AAA",
            (0.850, 0.095, 0.780, 1.0),
            0.04,
            0.24,
            (0.980, 0.080, 0.850, 1.0),
            0.360,
        ),
        "pink_crack": make_principled_material(
            "NS_S2_HR3_Pink_Fracture_Core_AAA",
            (1.000, 0.270, 0.930, 1.0),
            0.00,
            0.30,
            (1.000, 0.170, 0.920, 1.0),
            0.520,
        ),
        "violet_sheen": make_principled_material(
            "NS_S2_HR3_Violet_Glass_Sheen_AAA",
            (0.610, 0.330, 0.860, 1.0),
            0.04,
            0.18,
            (0.220, 0.075, 0.410, 1.0),
            0.145,
            0.82,
            0.10,
        ),
        "cyan_micro": make_principled_material(
            "NS_S2_HR3_Cyan_Micro_Accent_AAA",
            (0.070, 0.540, 0.730, 1.0),
            0.02,
            0.32,
            (0.060, 0.760, 0.960, 1.0),
            0.230,
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
    weighted = obj.modifiers.new("weighted_normals_for_reference_floor_faces", "WEIGHTED_NORMAL")
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


def octagon_points(center_x: float, center_y: float, width: float, height: float, cut: float):
    x0 = center_x - width * 0.5
    x1 = center_x + width * 0.5
    y0 = center_y - height * 0.5
    y1 = center_y + height * 0.5
    cut = min(cut, width * 0.30, height * 0.30)
    return [
        (x0 + cut, y0),
        (x1 - cut, y0),
        (x1, y0 + cut),
        (x1, y1 - cut),
        (x1 - cut, y1),
        (x0 + cut, y1),
        (x0, y1 - cut),
        (x0, y0 + cut),
    ]


def inset_points(points, scale: float):
    cx = sum(point[0] for point in points) / float(len(points))
    cy = sum(point[1] for point in points) / float(len(points))
    return [(cx + (x - cx) * scale, cy + (y - cy) * scale) for x, y in points]


def create_understructure(root, mats: dict) -> None:
    add_box(root, "Sector2HR3ReferenceDarkRiftUndertray", (0.0, 0.0, -0.410), (58.6, 58.6, 0.40), mats["rift_backplane"], 0.160, 2)
    add_box(root, "Sector2HR3ContinuousBlackGunmetalFloorBed", (0.0, 0.0, -0.110), (55.2, 55.2, 0.26), mats["black_frame"], 0.105, 2)
    for i, coord in enumerate([-23.2, -11.6, 0.0, 11.6, 23.2]):
        add_bar_between(root, f"Sector2HR3UnderlitLongitudinalRib{i}", (coord, -27.0), (coord, 27.0), 0.30, 0.090, -0.030, mats["dark_groove"], 0.020, 1)
        add_bar_between(root, f"Sector2HR3UnderlitCrossRib{i}", (-27.0, coord), (27.0, coord), 0.30, 0.090, -0.035, mats["dark_groove"], 0.020, 1)


def create_mechanical_grid(root, mats: dict) -> None:
    grid_coords = [-15.675, -5.225, 5.225, 15.675]
    for i, coord in enumerate(grid_coords):
        add_bar_between(root, f"Sector2HR3HeavyVerticalBlackFrameRail{i}", (coord, -26.6), (coord, 26.6), 0.560, 0.170, 0.090, mats["black_frame"], 0.055, 1)
        add_bar_between(root, f"Sector2HR3HeavyHorizontalBlackFrameRail{i}", (-26.6, coord), (26.6, coord), 0.560, 0.170, 0.086, mats["black_frame"], 0.055, 1)
        add_bar_between(root, f"Sector2HR3RecessedVerticalReferenceGroove{i}", (coord + 0.36, -26.1), (coord + 0.36, 26.1), 0.065, 0.030, 0.205, mats["dark_groove"], 0.006, 1)
        add_bar_between(root, f"Sector2HR3RecessedHorizontalReferenceGroove{i}", (-26.1, coord - 0.36), (26.1, coord - 0.36), 0.065, 0.030, 0.204, mats["dark_groove"], 0.006, 1)
    for ix, x in enumerate(grid_coords):
        for iy, y in enumerate(grid_coords):
            add_box(root, f"Sector2HR3MachinedGridIntersectionBlock{ix}_{iy}", (x, y, 0.235), (1.18, 1.18, 0.22), mats["black_frame"], 0.060, 1, math.radians(45.0 if (ix + iy) % 2 == 0 else 0.0))
            add_box(root, f"Sector2HR3TinyCyanServiceNotch{ix}_{iy}", (x, y, 0.370), (0.38, 0.050, 0.032), mats["cyan_micro"], 0.006, 1, math.radians(90.0 if (ix + iy) % 2 == 0 else 0.0))


def add_corner_armor(root, prefix: str, cx: float, cy: float, span: float, mats: dict, top_z: float) -> None:
    corner_size = span * 0.195
    positions = [
        (-1.0, -1.0, 45.0),
        (1.0, -1.0, -45.0),
        (1.0, 1.0, 45.0),
        (-1.0, 1.0, -45.0),
    ]
    for index, (sx, sy, angle) in enumerate(positions):
        add_box(
            root,
            f"{prefix}CornerGraphiteArmorPlate{index}",
            (cx + sx * span * 0.405, cy + sy * span * 0.405, top_z),
            (corner_size, corner_size * 0.52, 0.115),
            mats["graphite_panel"],
            0.030,
            1,
            math.radians(angle),
        )


def add_panel_rims(root, prefix: str, points, z: float, mats: dict, bright: bool) -> None:
    rim_material = mats["magenta_rim"] if bright else mats["graphite_panel"]
    for index in range(len(points)):
        start = points[index]
        end = points[(index + 1) % len(points)]
        add_bar_between(
            root,
            f"{prefix}RaisedOctagonalGlassRim{index}",
            start,
            end,
            0.135 if bright else 0.118,
            0.060,
            z,
            rim_material,
            0.016,
            1,
        )


def add_contained_fractures(root, prefix: str, cx: float, cy: float, panel_w: float, panel_h: float, variant: int, mats: dict, top_z: float) -> None:
    center = (cx + ((variant % 3) - 1) * panel_w * 0.055, cy + (((variant + 1) % 3) - 1) * panel_h * 0.050)
    crack_sets = [
        [(-0.36, -0.18), (-0.08, -0.04), (0.25, -0.34), (0.38, 0.04), (0.10, 0.31), (-0.24, 0.28)],
        [(-0.30, 0.24), (-0.05, 0.02), (0.22, 0.26), (0.36, -0.12), (0.02, -0.30), (-0.34, -0.08)],
        [(-0.22, -0.31), (0.02, -0.03), (0.34, -0.24), (0.20, 0.20), (-0.12, 0.31), (-0.38, 0.05)],
    ]
    points = crack_sets[variant % len(crack_sets)]
    for index, point in enumerate(points):
        if index % 2 == 0:
            start = center
            end = (cx + point[0] * panel_w, cy + point[1] * panel_h)
        else:
            prev = points[index - 1]
            start = (cx + prev[0] * panel_w, cy + prev[1] * panel_h)
            end = (cx + point[0] * panel_w, cy + point[1] * panel_h)
        add_bar_between(
            root,
            f"{prefix}ContainedReferenceGlassCrack{index}",
            start,
            end,
            0.043 if index % 2 == 0 else 0.032,
            0.020,
            top_z,
            mats["pink_crack"],
            0.004,
            1,
        )


def add_glass_sheen(root, prefix: str, cx: float, cy: float, panel_w: float, panel_h: float, variant: int, mats: dict, top_z: float) -> None:
    angle = math.radians([22.0, -18.0, 35.0, -32.0][variant % 4])
    offset_x = [0.14, -0.18, 0.02, 0.20][variant % 4] * panel_w
    offset_y = [-0.10, 0.15, -0.18, 0.08][variant % 4] * panel_h
    add_box(
        root,
        f"{prefix}SoftReferenceVioletGlassReflection",
        (cx + offset_x, cy + offset_y, top_z),
        (panel_w * 0.44, 0.070, 0.024),
        mats["violet_sheen"],
        0.010,
        1,
        angle,
    )


def create_floor_bay(root, row: int, col: int, cx: float, cy: float, mats: dict) -> None:
    prefix = f"Sector2HR3ReferenceFloorBayR{row}C{col}_"
    central = row == 2 and col == 2
    glass_variants = {
        (0, 0), (0, 2), (0, 4),
        (1, 1), (1, 3),
        (2, 0), (2, 2), (2, 3),
        (3, 1), (3, 4),
        (4, 0), (4, 2), (4, 4),
    }
    dark_glass_variants = {(0, 1), (1, 4), (2, 4), (3, 0), (4, 3)}
    is_bright_glass = (row, col) in glass_variants
    is_dark_glass = (row, col) in dark_glass_variants
    top_z = FLOOR_TOP_Z + 0.095 + ((row * 3 + col * 5) % 3) * 0.008

    add_box(root, f"{prefix}MachinedSquareBasePlate", (cx, cy, top_z - 0.030), (CELL_SPAN, CELL_SPAN, 0.200), mats["black_frame"], 0.070, 1)
    add_corner_armor(root, prefix, cx, cy, CELL_SPAN, mats, top_z + 0.105)

    outer_points = octagon_points(cx, cy, CELL_SPAN * 0.755, CELL_SPAN * 0.710, CELL_SPAN * 0.125)
    if is_bright_glass or is_dark_glass:
        under_points = inset_points(outer_points, 1.055)
        add_poly_prism(root, f"{prefix}MagentaUnderGlassGlowShelf", under_points, top_z + 0.148, 0.036, mats["magenta_rim"], mats["black_frame"], 0.030, 1)
        glass_material = mats["amethyst_glass"] if is_bright_glass else mats["deep_violet_glass"]
        add_poly_prism(root, f"{prefix}RaisedOctagonalPrismGlassFace", outer_points, top_z + 0.250, 0.105 if central else 0.082, glass_material, mats["magenta_rim"], 0.052, 2)
        add_panel_rims(root, prefix, outer_points, top_z + 0.330, mats, True)
        add_glass_sheen(root, prefix, cx, cy, CELL_SPAN * 0.58, CELL_SPAN * 0.52, row * 5 + col, mats, top_z + 0.398)
        if is_bright_glass:
            add_contained_fractures(root, prefix, cx, cy, CELL_SPAN * 0.56, CELL_SPAN * 0.50, row * 5 + col, mats, top_z + 0.414)
        if central:
            add_box(root, f"{prefix}DesignedCentralReferenceHotCore", (cx, cy, top_z + 0.438), (CELL_SPAN * 0.28, 0.060, 0.034), mats["pink_crack"], 0.008, 1, math.radians(45.0))
            add_box(root, f"{prefix}DesignedCentralReferenceCyanCounterline", (cx, cy, top_z + 0.444), (CELL_SPAN * 0.22, 0.050, 0.030), mats["cyan_micro"], 0.006, 1, math.radians(-45.0))
    else:
        panel_points = inset_points(outer_points, 0.970)
        add_poly_prism(root, f"{prefix}DarkBeveledOpaqueReferencePanel", panel_points, top_z + 0.184, 0.070, mats["graphite_panel"], mats["dark_groove"], 0.048, 2)
        add_panel_rims(root, prefix, panel_points, top_z + 0.250, mats, False)
        if (row + col) % 2 == 0:
            add_glass_sheen(root, prefix, cx, cy, CELL_SPAN * 0.50, CELL_SPAN * 0.45, row * 5 + col, mats, top_z + 0.302)

    # Small inset groove clusters echo the reference's black machined channels without becoming route lines.
    groove_offsets = [(-0.34, -0.50), (0.34, 0.50)] if (row + col) % 2 == 0 else [(-0.50, 0.34), (0.50, -0.34)]
    for index, (gx, gy) in enumerate(groove_offsets):
        add_box(
            root,
            f"{prefix}ShortMachinedInsetGroove{index}",
            (cx + gx * CELL_SPAN, cy + gy * CELL_SPAN, top_z + 0.190),
            (CELL_SPAN * 0.22, 0.040, 0.026),
            mats["dark_groove"],
            0.005,
            1,
            math.radians(0.0 if index == 0 else 90.0),
        )


def create_reference_floor(root, mats: dict) -> None:
    centers = [-2.0 * CELL_PITCH, -CELL_PITCH, 0.0, CELL_PITCH, 2.0 * CELL_PITCH]
    for row, cy in enumerate(centers):
        for col, cx in enumerate(centers):
            create_floor_bay(root, row, col, cx, cy, mats)


def create_boundary(root, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    for index, center in enumerate([-22.5, -11.25, 0.0, 11.25, 22.5]):
        slot_material = mats["magenta_rim"] if index % 2 == 0 else mats["cyan_micro"]
        add_box(root, f"Sector2HR3NorthReferenceRaisedBoundaryRail{index}", (center, -half + 0.22, 0.500), (9.8, 0.58, 0.70), mats["black_frame"], 0.080, 1)
        add_box(root, f"Sector2HR3SouthReferenceRaisedBoundaryRail{index}", (center, half - 0.22, 0.500), (9.8, 0.58, 0.70), mats["black_frame"], 0.080, 1)
        add_box(root, f"Sector2HR3WestReferenceRaisedBoundaryRail{index}", (-half + 0.22, center, 0.500), (0.58, 9.8, 0.70), mats["black_frame"], 0.080, 1)
        add_box(root, f"Sector2HR3EastReferenceRaisedBoundaryRail{index}", (half - 0.22, center, 0.500), (0.58, 9.8, 0.70), mats["black_frame"], 0.080, 1)
        add_box(root, f"Sector2HR3NorthShortEmbeddedBoundaryGlow{index}", (center, -half + 0.86, 0.690), (2.00, 0.055, 0.046), slot_material, 0.008, 1)
        add_box(root, f"Sector2HR3SouthShortEmbeddedBoundaryGlow{index}", (center, half - 0.86, 0.690), (2.00, 0.055, 0.046), slot_material, 0.008, 1)
        add_box(root, f"Sector2HR3WestShortEmbeddedBoundaryGlow{index}", (-half + 0.86, center, 0.690), (0.055, 2.00, 0.046), slot_material, 0.008, 1)
        add_box(root, f"Sector2HR3EastShortEmbeddedBoundaryGlow{index}", (half - 0.86, center, 0.690), (0.055, 2.00, 0.046), slot_material, 0.008, 1)

    for index, (x, y) in enumerate([(-half, -half), (half, -half), (half, half), (-half, half)]):
        sx = math.copysign(1.0, x)
        sy = math.copysign(1.0, y)
        add_box(root, f"Sector2HR3CornerHeavyReferenceClamp{index}A", (x - sx * 0.72, y, 0.590), (1.50, 3.30, 0.86), mats["black_frame"], 0.090, 1)
        add_box(root, f"Sector2HR3CornerHeavyReferenceClamp{index}B", (x, y - sy * 0.72, 0.590), (3.30, 1.50, 0.86), mats["black_frame"], 0.090, 1)
        cap_points = octagon_points(x - sx * 0.70, y - sy * 0.70, 1.55, 1.55, 0.34)
        add_poly_prism(root, f"Sector2HR3CornerInsetAmethystReferenceCap{index}", cap_points, 1.135, 0.130, mats["deep_violet_glass"], mats["magenta_rim"], 0.036, 1)


def setup_scene() -> None:
    clear_scene()
    bpy.context.preferences.filepaths.save_version = 0
    bpy.context.scene.unit_settings.system = "METRIC"
    bpy.context.scene.render.engine = "CYCLES"
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector2_HR3_UserReference_Prism_Rift_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.010, 0.002, 0.025)

    root = bpy.data.objects.new("Sector2PrismRiftHardRepair3UserReferenceArenaKitRoot", None)
    root.empty_display_type = "CUBE"
    root["neon_swarm_asset"] = "phase_39_hard_repair_3_sector_2_user_original_floor_reference_arena"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["primary_reference"] = "art/reference/user_original_art/sector2_user_original_floor_reference.jpg"
    root["art_direction"] = "premium modular octagonal prism-glass floor bays in a dark machined gunmetal grid with contained magenta fractures"
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_understructure(root, mats)
    create_mechanical_grid(root, mats)
    create_reference_floor(root, mats)
    create_boundary(root, mats)

    camera_data = bpy.data.cameras.new("ReferenceGameplayCamera")
    camera = bpy.data.objects.new("ReferenceGameplayCamera", camera_data)
    camera.location = (0.0, -34.0, 33.0)
    camera.rotation_euler = (math.radians(52.0), 0.0, 0.0)
    camera.data.lens = 24.0
    bpy.context.collection.objects.link(camera)
    bpy.context.scene.camera = camera

    light_data = bpy.data.lights.new("ReferenceSoftPrismPreviewAreaLight", "AREA")
    light = bpy.data.objects.new("ReferenceSoftPrismPreviewAreaLight", light_data)
    light.location = (-8.0, -16.0, 20.0)
    light.rotation_euler = (math.radians(58.0), 0.0, math.radians(-20.0))
    light.data.energy = 420.0
    light.data.size = 18.0
    bpy.context.collection.objects.link(light)

    fill_data = bpy.data.lights.new("ReferenceMagentaGlassFillLight", "POINT")
    fill = bpy.data.objects.new("ReferenceMagentaGlassFillLight", fill_data)
    fill.location = (9.0, 10.0, 9.0)
    fill.data.energy = 95.0
    fill.data.color = (0.88, 0.18, 1.0)
    bpy.context.collection.objects.link(fill)


def export_glb() -> None:
    EXPORT_GLB.parent.mkdir(parents=True, exist_ok=True)
    kwargs = {
        "filepath": str(EXPORT_GLB),
        "export_format": "GLB",
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


def save_blend() -> None:
    SOURCE_BLEND.parent.mkdir(parents=True, exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(SOURCE_BLEND))


def main() -> None:
    setup_scene()
    save_blend()
    export_glb()
    print(f"Saved Sector 2 HR3 Prism Rift user-reference arena source: {SOURCE_BLEND}")
    print(f"Exported Sector 2 HR3 Prism Rift user-reference arena GLB: {EXPORT_GLB}")


if __name__ == "__main__":
    main()
