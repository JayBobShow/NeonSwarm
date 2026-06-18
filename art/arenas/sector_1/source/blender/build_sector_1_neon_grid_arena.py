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
PANEL_THICKNESS = 0.42
FLOOR_TOP_Z = -0.012
PANEL_CENTER_Z = FLOOR_TOP_Z - PANEL_THICKNESS * 0.5
NEON_Z = 0.060

PANEL_VARIANT_MAP = [
    ["service", "vented", "standard", "brace", "standard", "vented", "service"],
    ["brace", "heavy", "vented", "service", "vented", "heavy", "brace"],
    ["standard", "service", "macro", "heavy", "macro", "service", "standard"],
    ["vented", "brace", "heavy", "reactor", "heavy", "brace", "vented"],
    ["standard", "service", "macro", "heavy", "macro", "service", "standard"],
    ["brace", "heavy", "vented", "service", "vented", "heavy", "brace"],
    ["service", "vented", "standard", "brace", "standard", "vented", "service"],
]


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
            "NS_S1_Dark_Brushed_Aluminum_AAA",
            (0.205, 0.218, 0.232, 1.0),
            0.62,
            0.54,
            (0.025, 0.074, 0.088, 1.0),
            0.120,
        ),
        "raised_gunmetal": make_principled_material(
            "NS_S1_Raised_Gunmetal_Panel_AAA",
            (0.245, 0.262, 0.274, 1.0),
            0.66,
            0.48,
            (0.030, 0.086, 0.100, 1.0),
            0.145,
        ),
        "edge_metal": make_principled_material(
            "NS_S1_Beveled_Edge_Gunmetal_AAA",
            (0.145, 0.165, 0.188, 1.0),
            0.62,
            0.58,
            (0.022, 0.068, 0.086, 1.0),
            0.105,
        ),
        "deep_metal": make_principled_material(
            "NS_S1_Recessed_Dark_Depth_Metal_AAA",
            (0.055, 0.066, 0.084, 1.0),
            0.40,
            0.78,
            (0.010, 0.042, 0.058, 1.0),
            0.048,
        ),
        "cyan_neon": make_principled_material(
            "NS_S1_Dim_Cyan_Embedded_Channel_AAA",
            (0.000, 0.340, 0.470, 1.0),
            0.0,
            0.34,
            (0.000, 0.620, 0.780, 1.0),
            0.68,
        ),
        "cyan_core": make_principled_material(
            "NS_S1_Restrained_Cyan_Rail_Core_AAA",
            (0.025, 0.460, 0.580, 1.0),
            0.0,
            0.30,
            (0.000, 0.720, 0.900, 1.0),
            0.86,
        ),
        "sheen": make_principled_material(
            "NS_S1_Cool_Aluminum_Sheen_AAA",
            (0.500, 0.650, 0.700, 1.0),
            0.34,
            0.20,
            (0.070, 0.240, 0.300, 1.0),
            0.160,
        ),
        "black_trim": make_principled_material(
            "NS_S1_Blackened_Service_Trim_AAA",
            (0.030, 0.038, 0.052, 1.0),
            0.32,
            0.84,
            (0.006, 0.026, 0.040, 1.0),
            0.020,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    for polygon in obj.data.polygons:
        polygon.use_smooth = True


def add_bevel(obj, amount: float, segments: int = 2) -> None:
    if amount > 0.0:
        bevel = obj.modifiers.new("real_beveled_edges", "BEVEL")
        bevel.width = amount
        bevel.segments = segments
        bevel.affect = "EDGES"
    smooth_mesh_faces(obj)


def add_box(root, name: str, location, size, material, bevel: float = 0.0, segments: int = 2, rotation_z: float = 0.0):
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
    add_bevel(obj, 0.0, 1)
    obj.parent = root
    return obj


def panel_world_position(row: int, column: int) -> tuple[float, float]:
    offset = float(PANEL_COUNT - 1) * PANEL_STEP * 0.5
    return -offset + float(column) * PANEL_STEP, -offset + float(row) * PANEL_STEP


def panel_height_variation(row: int, column: int) -> float:
    return [-0.052, -0.030, 0.018, 0.046][(row * 3 + column * 2) % 4]


def add_panel_raised_lips(root, name_prefix: str, x: float, y: float, z: float, mats: dict, variant: str) -> None:
    north_south_length = PANEL_SIZE - (1.06 if variant in ["service", "heavy", "reactor"] else 1.46)
    east_west_length = PANEL_SIZE - (1.30 if variant in ["brace", "macro"] else 1.70)
    lip_width = 0.205 if variant in ["heavy", "reactor"] else 0.165
    lip_height = 0.064 if variant in ["heavy", "reactor"] else 0.050
    add_box(root, f"{name_prefix}NorthReadableRaisedLip", (x, y - PANEL_SIZE * 0.5 + 0.43, z), (north_south_length, lip_width, lip_height), mats["edge_metal"], 0.035, 1)
    add_box(root, f"{name_prefix}SouthReadableRaisedLip", (x, y + PANEL_SIZE * 0.5 - 0.43, z), (north_south_length, lip_width, lip_height), mats["edge_metal"], 0.035, 1)
    if variant != "brace":
        add_box(root, f"{name_prefix}WestReadableRaisedLip", (x - PANEL_SIZE * 0.5 + 0.43, y, z + 0.003), (lip_width, east_west_length, lip_height), mats["edge_metal"], 0.035, 1)
        add_box(root, f"{name_prefix}EastReadableRaisedLip", (x + PANEL_SIZE * 0.5 - 0.43, y, z + 0.003), (lip_width, east_west_length, lip_height), mats["edge_metal"], 0.035, 1)


def add_panel_corner_clamps(root, name_prefix: str, x: float, y: float, z: float, mats: dict, large: bool = False) -> None:
    clamp_size = (0.74, 0.42, 0.052) if large else (0.56, 0.34, 0.040)
    for index, (sx, sy) in enumerate([(-2.44, -2.46), (2.44, 2.46)]):
        add_box(root, f"{name_prefix}DarkCornerClamp{index}", (x + sx, y + sy, z), clamp_size, mats["black_trim"], 0.034, 1)
    if large:
        for index, (sx, sy) in enumerate([(2.44, -2.46), (-2.44, 2.46)]):
            add_box(root, f"{name_prefix}GunmetalCornerClamp{index}", (x + sx, y + sy, z + 0.004), (0.54, 0.34, 0.044), mats["edge_metal"], 0.028, 1)


def add_standard_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}InsetTopPlate", (x, y, z), (5.40, 5.16, 0.064), mats["raised_gunmetal"], 0.092, 2)
    add_box(root, f"{name_prefix}OffsetArmorStripA", (x - 0.58, y + 1.08, z + 0.030), (2.70, 0.160, 0.030), mats["black_trim"], 0.016, 1, math.radians(4.5))
    add_box(root, f"{name_prefix}OffsetArmorStripB", (x + 0.66, y - 1.20, z + 0.032), (2.15, 0.145, 0.030), mats["black_trim"], 0.016, 1, math.radians(-4.0))
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.044, mats)


def add_service_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}WideInsetServicePlate", (x, y, z), (5.62, 4.92, 0.060), mats["dark_aluminum"], 0.090, 2)
    add_box(root, f"{name_prefix}ReadableServiceHatch", (x - 0.72, y + 0.20, z + 0.056), (2.72, 1.62, 0.078), mats["raised_gunmetal"], 0.064, 2)
    add_box(root, f"{name_prefix}HatchDarkRecess", (x - 0.72, y + 0.20, z + 0.100), (2.12, 1.02, 0.024), mats["black_trim"], 0.026, 1)
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.044, mats, True)


def add_vented_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}InsetVentedPlate", (x, y, z), (5.26, 5.26, 0.060), mats["dark_aluminum"], 0.082, 2)
    add_box(root, f"{name_prefix}VentedDarkWell", (x, y + 0.18, z + 0.046), (4.10, 1.62, 0.042), mats["black_trim"], 0.038, 1)
    for slat_index in range(5):
        slat_x = x - 1.56 + float(slat_index) * 0.78
        add_box(root, f"{name_prefix}ReadableVentSlat{slat_index}", (slat_x, y + 0.18, z + 0.092), (0.220, 1.36, 0.046), mats["edge_metal"], 0.020, 1)
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.038, mats)


def add_brace_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}InsetBracePlate", (x, y, z), (5.46, 5.00, 0.060), mats["raised_gunmetal"], 0.086, 2)
    add_box(root, f"{name_prefix}DiagonalArmorBraceA", (x - 0.55, y - 0.10, z + 0.072), (0.260, 3.56, 0.060), mats["edge_metal"], 0.030, 1, math.radians(9.0))
    add_box(root, f"{name_prefix}DiagonalArmorBraceB", (x + 0.62, y + 0.06, z + 0.066), (0.220, 3.10, 0.052), mats["black_trim"], 0.026, 1, math.radians(-9.0))
    add_box(root, f"{name_prefix}ShortOffsetSheen", (x - 1.48, y + 1.70, z + 0.084), (1.92, 0.055, 0.016), mats["sheen"], 0.012, 1, math.radians(7.0))
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.038, mats)


def add_heavy_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}HeavyInsetDeckPlate", (x, y, z), (5.76, 5.76, 0.072), mats["raised_gunmetal"], 0.110, 2)
    add_box(root, f"{name_prefix}RaisedMacroAccessCover", (x + 0.08, y - 0.06, z + 0.076), (3.72, 3.10, 0.070), mats["dark_aluminum"], 0.080, 2)
    add_box(root, f"{name_prefix}AccessCoverDarkInset", (x + 0.08, y - 0.06, z + 0.128), (2.72, 2.06, 0.024), mats["black_trim"], 0.034, 1)
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.050, mats, True)


def add_macro_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}MacroDeckInsetPlate", (x, y, z), (5.68, 5.24, 0.066), mats["dark_aluminum"], 0.100, 2)
    add_box(root, f"{name_prefix}OffsetMacroRibNorth", (x, y - 1.18, z + 0.072), (4.58, 0.220, 0.060), mats["edge_metal"], 0.036, 1)
    add_box(root, f"{name_prefix}OffsetMacroRibSouth", (x - 0.72, y + 1.24, z + 0.070), (3.00, 0.190, 0.052), mats["edge_metal"], 0.030, 1)
    add_box(root, f"{name_prefix}DarkMaintenanceGroove", (x + 1.66, y + 0.10, z + 0.080), (0.190, 2.90, 0.030), mats["black_trim"], 0.018, 1)
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.044, mats)


def add_reactor_panel_detail(root, name_prefix: str, x: float, y: float, z: float, mats: dict) -> None:
    add_box(root, f"{name_prefix}CentralLandingDeckPlate", (x, y, z), (6.00, 6.00, 0.070), mats["raised_gunmetal"], 0.120, 2)
    add_box(root, f"{name_prefix}CentralDarkPowerWell", (x, y, z + 0.052), (3.90, 3.90, 0.038), mats["black_trim"], 0.070, 2)
    add_box(root, f"{name_prefix}LowSquarePowerDeckCover", (x, y, z + 0.098), (2.72, 2.72, 0.042), mats["dark_aluminum"], 0.050, 1)
    add_panel_corner_clamps(root, name_prefix, x, y, z + 0.048, mats, True)


def create_underfloor_and_macro_deck(root, mats: dict) -> None:
    add_box(root, "Sector1AAAContinuousDarkUnderfloorDepthSlab", (0.0, 0.0, -0.420), (58.0, 58.0, 0.30), mats["deep_metal"], 0.120, 2)
    macro_covers = [
        ("NW", -12.0, -12.0, 0.0),
        ("NE", 12.0, -12.0, 0.0),
        ("SW", -12.0, 12.0, 0.0),
        ("SE", 12.0, 12.0, 0.0),
    ]
    for label, x, y, rotation in macro_covers:
        add_box(root, f"Sector1AAAMacroDeckCover{label}", (x, y, FLOOR_TOP_Z + 0.026), (8.60, 3.30, 0.038), mats["raised_gunmetal"], 0.060, 2, rotation)
        add_box(root, f"Sector1AAAMacroDeckDarkInset{label}A", (x - 1.05, y, FLOOR_TOP_Z + 0.052), (4.90, 0.180, 0.018), mats["black_trim"], 0.014, 1, rotation)
        add_box(root, f"Sector1AAAMacroDeckDarkInset{label}B", (x + 1.18, y + 0.54, FLOOR_TOP_Z + 0.054), (3.60, 0.150, 0.016), mats["black_trim"], 0.012, 1, rotation)


def create_floor_panels(root, mats: dict) -> None:
    create_underfloor_and_macro_deck(root, mats)
    for row in range(PANEL_COUNT):
        for column in range(PANEL_COUNT):
            x, y = panel_world_position(row, column)
            variation = panel_height_variation(row, column)
            variant = PANEL_VARIANT_MAP[row][column]
            base_material = mats["raised_gunmetal"] if variant in ["heavy", "reactor", "macro"] else mats["dark_aluminum"]
            add_box(
                root,
                f"Sector1AAAPanelBaseR{row}C{column}_{variant}",
                (x, y, PANEL_CENTER_Z + variation),
                (PANEL_SIZE, PANEL_SIZE, PANEL_THICKNESS),
                base_material,
                0.185,
                3,
            )
            detail_z = FLOOR_TOP_Z + 0.035 + variation
            lip_z = FLOOR_TOP_Z + 0.056 + variation
            add_panel_raised_lips(root, f"Sector1AAAPanelR{row}C{column}_{variant}_", x, y, lip_z, mats, variant)
            if variant == "service":
                add_service_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)
            elif variant == "vented":
                add_vented_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)
            elif variant == "brace":
                add_brace_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)
            elif variant == "heavy":
                add_heavy_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)
            elif variant == "macro":
                add_macro_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)
            elif variant == "reactor":
                add_reactor_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)
            else:
                add_standard_panel_detail(root, f"Sector1AAAPanelR{row}C{column}_", x, y, detail_z, mats)


def add_seam_bridge(root, name: str, location, size, mats: dict, rotation_z: float = 0.0) -> None:
    add_box(root, f"{name}DarkBridgePlate", location, size, mats["edge_metal"], 0.030, 1, rotation_z)
    add_box(root, f"{name}InsetBridgeStripe", (location[0], location[1], location[2] + 0.034), (size[0] * 0.72, max(0.045, size[1] * 0.22), 0.014), mats["black_trim"], 0.010, 1, rotation_z)


def create_neon_seams(root, mats: dict) -> None:
    boundaries = [-ARENA_HALF_SIZE + i * PANEL_STEP for i in range(PANEL_COUNT + 1)]
    bridge_centers = [-24.0, -16.0, -8.0, 0.0, 8.0, 16.0, 24.0]
    for index, p in enumerate(boundaries):
        is_perimeter = index in [0, len(boundaries) - 1]
        bed_width = 0.360 if is_perimeter else 0.285
        bed_z = -0.060 if is_perimeter else -0.070
        add_box(root, f"Sector1AAARecessedTrenchX{index}", (0.0, p, bed_z), (ARENA_HALF_SIZE * 2.0, bed_width, 0.060), mats["black_trim"], 0.028, 1)
        add_box(root, f"Sector1AAARecessedTrenchY{index}", (p, 0.0, bed_z - 0.002), (bed_width, ARENA_HALF_SIZE * 2.0, 0.060), mats["black_trim"], 0.028, 1)
        for side in [-1.0, 1.0]:
            rail_offset = side * (bed_width * 0.5 + 0.075)
            add_box(root, f"Sector1AAASeamChamferRailX{index}_{int(side)}", (0.0, p + rail_offset, FLOOR_TOP_Z + 0.018), (ARENA_HALF_SIZE * 2.0, 0.082, 0.034), mats["edge_metal"], 0.020, 1)
            add_box(root, f"Sector1AAASeamChamferRailY{index}_{int(side)}", (p + rail_offset, 0.0, FLOOR_TOP_Z + 0.020), (0.082, ARENA_HALF_SIZE * 2.0, 0.034), mats["edge_metal"], 0.020, 1)
        for segment_index, segment_center in enumerate(bridge_centers):
            if not is_perimeter and (index + segment_index) % 3 == 0:
                add_seam_bridge(
                    root,
                    f"Sector1AAASeamBridgePlateX{index}_{segment_index}",
                    (segment_center, p, FLOOR_TOP_Z + 0.040),
                    (1.55, bed_width + 0.34, 0.046),
                    mats,
                )
            if not is_perimeter and (index + segment_index) % 3 == 1:
                add_seam_bridge(
                    root,
                    f"Sector1AAASeamBridgePlateY{index}_{segment_index}",
                    (p, segment_center, FLOOR_TOP_Z + 0.044),
                    (bed_width + 0.34, 1.55, 0.046),
                    mats,
                )

def add_wall_segment(root, name: str, center: float, side: str, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    if side in ["north", "south"]:
        y_sign = -1.0 if side == "north" else 1.0
        y = y_sign * half
        add_box(root, f"{name}BasePlinth", (center, y + y_sign * 0.36, 0.15), (7.46, 1.22, 0.30), mats["deep_metal"], 0.070, 1)
        add_box(root, f"{name}InsetWallBody", (center, y + y_sign * 0.52, 0.72), (7.06, 0.64, 1.02), mats["edge_metal"], 0.120, 2)
        add_box(root, f"{name}DarkWallInsetPanel", (center, y + y_sign * 0.18, 0.74), (5.58, 0.090, 0.54), mats["black_trim"], 0.026, 1)
        add_box(root, f"{name}TopArmorCap", (center, y + y_sign * 0.42, 1.34), (7.78, 1.08, 0.18), mats["raised_gunmetal"], 0.080, 1)
        add_box(root, f"{name}InnerCurbGuard", (center, y - y_sign * 0.56, 0.22), (7.22, 0.34, 0.34), mats["edge_metal"], 0.052, 1)
        add_box(root, f"{name}CyanSideSlit", (center, y - y_sign * 0.74, 0.58), (1.42, 0.054, 0.075), mats["cyan_neon"], 0.012, 1)
        add_cylinder_between(root, f"{name}SegmentedCyanTopRail", (center - 2.82, y - y_sign * 0.10, 1.50), (center + 2.82, y - y_sign * 0.10, 1.50), 0.034, mats["cyan_core"], 12)
        for bracket in [-1.0, 1.0]:
            add_box(root, f"{name}RailBracket{int(bracket)}", (center + bracket * 3.48, y - y_sign * 0.05, 1.26), (0.32, 0.52, 0.32), mats["black_trim"], 0.035, 1)
    else:
        x_sign = -1.0 if side == "west" else 1.0
        x = x_sign * half
        add_box(root, f"{name}BasePlinth", (x + x_sign * 0.36, center, 0.15), (1.22, 7.46, 0.30), mats["deep_metal"], 0.070, 1)
        add_box(root, f"{name}InsetWallBody", (x + x_sign * 0.52, center, 0.72), (0.64, 7.06, 1.02), mats["edge_metal"], 0.120, 2)
        add_box(root, f"{name}DarkWallInsetPanel", (x + x_sign * 0.18, center, 0.74), (0.090, 5.58, 0.54), mats["black_trim"], 0.026, 1)
        add_box(root, f"{name}TopArmorCap", (x + x_sign * 0.42, center, 1.34), (1.08, 7.78, 0.18), mats["raised_gunmetal"], 0.080, 1)
        add_box(root, f"{name}InnerCurbGuard", (x - x_sign * 0.56, center, 0.22), (0.34, 7.22, 0.34), mats["edge_metal"], 0.052, 1)
        add_box(root, f"{name}CyanSideSlit", (x - x_sign * 0.74, center, 0.58), (0.054, 1.42, 0.075), mats["cyan_neon"], 0.012, 1)
        add_cylinder_between(root, f"{name}SegmentedCyanTopRail", (x - x_sign * 0.10, center - 2.82, 1.50), (x - x_sign * 0.10, center + 2.82, 1.50), 0.034, mats["cyan_core"], 12)
        for bracket in [-1.0, 1.0]:
            add_box(root, f"{name}RailBracket{int(bracket)}", (x - x_sign * 0.05, center + bracket * 3.48, 1.26), (0.52, 0.32, 0.32), mats["black_trim"], 0.035, 1)


def add_corner_anchor(root, name: str, x: float, y: float, mats: dict) -> None:
    add_box(root, f"{name}LBaseX", (x - math.copysign(0.38, x), y, 0.28), (1.28, 2.46, 0.56), mats["deep_metal"], 0.120, 2)
    add_box(root, f"{name}LBaseY", (x, y - math.copysign(0.38, y), 0.28), (2.46, 1.28, 0.56), mats["deep_metal"], 0.120, 2)
    add_box(root, f"{name}VerticalMachineryCore", (x, y, 1.04), (1.18, 1.18, 1.42), mats["edge_metal"], 0.115, 2)
    add_box(root, f"{name}DarkInsetTopCap", (x, y, 1.82), (1.32, 1.32, 0.18), mats["black_trim"], 0.060, 1)
    add_box(root, f"{name}CyanSideSlitX", (x, y - math.copysign(0.70, y), 1.22), (0.62, 0.050, 0.110), mats["cyan_neon"], 0.010, 1)
    add_box(root, f"{name}CyanSideSlitY", (x - math.copysign(0.70, x), y, 1.22), (0.050, 0.62, 0.110), mats["cyan_neon"], 0.010, 1)
    add_box(root, f"{name}SideButtressX", (x - math.copysign(1.02, x), y, 0.74), (0.44, 1.46, 0.78), mats["black_trim"], 0.060, 1)
    add_box(root, f"{name}SideButtressY", (x, y - math.copysign(1.02, y), 0.74), (1.46, 0.44, 0.78), mats["black_trim"], 0.060, 1)


def add_mid_wall_pylon(root, name: str, position: float, side: str, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    if side in ["north", "south"]:
        sign = -1.0 if side == "north" else 1.0
        y = sign * half
        add_box(root, f"{name}MidWallMachineryBase", (position, y + sign * 0.42, 0.34), (1.22, 1.52, 0.68), mats["deep_metal"], 0.075, 1)
        add_box(root, f"{name}MidWallMachineryCore", (position, y + sign * 0.34, 1.08), (0.82, 0.92, 0.96), mats["edge_metal"], 0.070, 1)
        add_box(root, f"{name}CyanInset", (position, y - sign * 0.34, 0.88), (0.46, 0.054, 0.095), mats["cyan_neon"], 0.010, 1)
    else:
        sign = -1.0 if side == "west" else 1.0
        x = sign * half
        add_box(root, f"{name}MidWallMachineryBase", (x + sign * 0.42, position, 0.34), (1.52, 1.22, 0.68), mats["deep_metal"], 0.075, 1)
        add_box(root, f"{name}MidWallMachineryCore", (x + sign * 0.34, position, 1.08), (0.92, 0.82, 0.96), mats["edge_metal"], 0.070, 1)
        add_box(root, f"{name}CyanInset", (x - sign * 0.34, position, 0.88), (0.054, 0.46, 0.095), mats["cyan_neon"], 0.010, 1)


def create_border_and_pylons(root, mats: dict) -> None:
    segment_centers = [-24.0, -16.0, -8.0, 0.0, 8.0, 16.0, 24.0]
    for side in ["north", "south", "west", "east"]:
        for index, center in enumerate(segment_centers):
            add_wall_segment(root, f"Sector1AAASegmentedWall_{side}_{index}_", center, side, mats)
    for index, (x, y) in enumerate([(-ARENA_HALF_SIZE, -ARENA_HALF_SIZE), (ARENA_HALF_SIZE, -ARENA_HALF_SIZE), (ARENA_HALF_SIZE, ARENA_HALF_SIZE), (-ARENA_HALF_SIZE, ARENA_HALF_SIZE)]):
        add_corner_anchor(root, f"Sector1AAACornerMachineryAnchor{index}_", x, y, mats)
    for side in ["north", "south", "west", "east"]:
        for index, position in enumerate([-16.0, 0.0, 16.0]):
            add_mid_wall_pylon(root, f"Sector1AAAMidWallPylon_{side}_{index}_", position, side, mats)


def create_depth_and_detail(root, mats: dict) -> None:
    for i, p in enumerate([-24.0, -8.0, 8.0, 24.0]):
        add_box(root, f"Sector1AAAPerimeterServiceTrenchNorth{i}", (p, -25.70, -0.015), (5.6, 0.56, 0.050), mats["black_trim"], 0.030, 1)
        add_box(root, f"Sector1AAAPerimeterServiceTrenchSouth{i}", (p, 25.70, -0.015), (5.6, 0.56, 0.050), mats["black_trim"], 0.030, 1)
        add_box(root, f"Sector1AAAPerimeterServiceTrenchWest{i}", (-25.70, p, -0.015), (0.56, 5.6, 0.050), mats["black_trim"], 0.030, 1)
        add_box(root, f"Sector1AAAPerimeterServiceTrenchEast{i}", (25.70, p, -0.015), (0.56, 5.6, 0.050), mats["black_trim"], 0.030, 1)


def setup_scene() -> None:
    clear_scene()
    bpy.context.scene.unit_settings.system = "METRIC"
    bpy.context.scene.render.engine = "CYCLES"
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector1_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.0, 0.004, 0.012)

    root = bpy.data.objects.new("Sector1BlenderArenaKitRoot", None)
    root.empty_display_type = "CUBE"
    root["neon_swarm_asset"] = "phase_38_sector_1_blender_arena_kit_hard_repair_4_visibility"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["art_direction"] = "AAA-style hard-surface metal power deck with restrained embedded cyan"
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
