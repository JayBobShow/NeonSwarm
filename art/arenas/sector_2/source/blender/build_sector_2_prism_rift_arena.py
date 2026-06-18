import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_2/source/blender/sector_2_prism_rift_arena.blend"
EXPORT_GLB = REPO_ROOT / "art/arenas/sector_2/exported/sector_2_prism_rift_arena.glb"

ARENA_HALF_SIZE = 28.0
DECK_HALF_SIZE = 27.55
FLOOR_TOP_Z = -0.018
BASE_THICKNESS = 0.34
BASE_CENTER_Z = FLOOR_TOP_Z - BASE_THICKNESS * 0.5
NEON_Z = 0.066


def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete()


def set_input(node, names, value) -> None:
    for name in names:
        if name in node.inputs:
            node.inputs[name].default_value = value
            return


def make_principled_material(name: str, color, metallic: float, roughness: float, emission=None, emission_strength: float = 0.0, alpha: float = 1.0):
    mat = bpy.data.materials.new(name)
    mat.use_nodes = True
    bsdf = mat.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        set_input(bsdf, ["Base Color"], color)
        set_input(bsdf, ["Alpha"], alpha)
        set_input(bsdf, ["Metallic"], metallic)
        set_input(bsdf, ["Roughness"], roughness)
        if emission is not None and emission_strength > 0.0:
            set_input(bsdf, ["Emission Color", "Emission"], emission)
            set_input(bsdf, ["Emission Strength"], emission_strength)
    mat.diffuse_color = (color[0], color[1], color[2], alpha)
    if alpha < 1.0:
        mat.blend_method = "BLEND"
        mat.use_screen_refraction = True
        mat.show_transparent_back = True
    return mat


def make_materials() -> dict:
    return {
        "deep_void": make_principled_material(
            "NS_S2_Deep_Rift_Void_AAA",
            (0.018, 0.006, 0.036, 1.0),
            0.28,
            0.82,
            (0.024, 0.006, 0.060, 1.0),
            0.035,
        ),
        "dark_violet_metal": make_principled_material(
            "NS_S2_Dark_Violet_Metal_AAA",
            (0.118, 0.062, 0.168, 1.0),
            0.56,
            0.58,
            (0.070, 0.014, 0.135, 1.0),
            0.115,
        ),
        "rift_gunmetal": make_principled_material(
            "NS_S2_Rift_Gunmetal_AAA",
            (0.162, 0.108, 0.210, 1.0),
            0.64,
            0.46,
            (0.090, 0.026, 0.160, 1.0),
            0.135,
        ),
        "black_glass_trim": make_principled_material(
            "NS_S2_Black_Glass_Trim_AAA",
            (0.028, 0.012, 0.052, 1.0),
            0.22,
            0.76,
            (0.020, 0.004, 0.050, 1.0),
            0.050,
        ),
        "magenta_channel": make_principled_material(
            "NS_S2_Magenta_Embedded_Channel_AAA",
            (0.600, 0.035, 0.520, 1.0),
            0.0,
            0.32,
            (0.920, 0.070, 0.780, 1.0),
            0.82,
        ),
        "violet_glass": make_principled_material(
            "NS_S2_Violet_Prism_Glass_AAA",
            (0.270, 0.110, 0.620, 1.0),
            0.08,
            0.18,
            (0.170, 0.060, 0.420, 1.0),
            0.34,
            0.62,
        ),
        "cyan_core": make_principled_material(
            "NS_S2_Cyan_Refraction_Core_AAA",
            (0.040, 0.560, 0.770, 1.0),
            0.0,
            0.26,
            (0.060, 0.820, 1.000, 1.0),
            0.74,
        ),
        "rift_sheen": make_principled_material(
            "NS_S2_Rift_Sheen_AAA",
            (0.520, 0.300, 0.780, 1.0),
            0.20,
            0.24,
            (0.200, 0.070, 0.360, 1.0),
            0.190,
        ),
        "outer_rail": make_principled_material(
            "NS_S2_Outer_Rift_Rail_AAA",
            (0.104, 0.050, 0.132, 1.0),
            0.68,
            0.52,
            (0.110, 0.030, 0.190, 1.0),
            0.165,
        ),
    }


def smooth_mesh_faces(obj) -> None:
    if hasattr(obj.data, "polygons"):
        for polygon in obj.data.polygons:
            polygon.use_smooth = True


def add_bevel(obj, amount: float, segments: int = 2) -> None:
    if amount > 0.0:
        bevel = obj.modifiers.new("real_beveled_prism_edges", "BEVEL")
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
    smooth_mesh_faces(obj)
    obj.parent = root
    return obj


def add_poly_plate(root, name: str, points, top_z: float, thickness: float, material, bevel: float = 0.0, segments: int = 2):
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
    obj.data.materials.append(material)
    bpy.context.collection.objects.link(obj)
    obj.parent = root
    add_bevel(obj, bevel, segments)
    return obj


def add_triangle_glass_shard(root, name: str, center, radius: float, top_z: float, thickness: float, material, rotation: float = 0.0):
    points = []
    for i in range(3):
        angle = rotation + math.tau * float(i) / 3.0
        points.append((center[0] + math.cos(angle) * radius, center[1] + math.sin(angle) * radius))
    return add_poly_plate(root, name, points, top_z, thickness, material, 0.030, 1)


def create_underfloor(root, mats: dict) -> None:
    add_box(root, "Sector2PrismRiftContinuousDarkUnderfloorSlab", (0.0, 0.0, -0.365), (58.4, 58.4, 0.34), mats["deep_void"], 0.120, 2)
    add_box(root, "Sector2PrismRiftCentralSunkenRiftWell", (0.0, 0.0, -0.148), (18.4, 9.2, 0.120), mats["black_glass_trim"], 0.090, 2, math.radians(-28.0))
    add_box(root, "Sector2PrismRiftOffsetShadowWellA", (-15.2, 10.2, -0.116), (10.2, 3.6, 0.080), mats["deep_void"], 0.070, 1, math.radians(-23.0))
    add_box(root, "Sector2PrismRiftOffsetShadowWellB", (14.4, -9.8, -0.118), (11.4, 3.8, 0.080), mats["deep_void"], 0.070, 1, math.radians(-23.0))


def create_fractured_floor(root, mats: dict) -> None:
    boundaries = [-DECK_HALF_SIZE, -18.35, -9.15, 0.0, 9.15, 18.35, DECK_HALF_SIZE]
    gap = 0.185
    for row in range(6):
        for col in range(6):
            x0 = boundaries[col] + gap
            x1 = boundaries[col + 1] - gap
            y0 = boundaries[row] + gap
            y1 = boundaries[row + 1] - gap
            center_x = (x0 + x1) * 0.5
            center_y = (y0 + y1) * 0.5
            lift = [-0.045, -0.018, 0.012, 0.035][(row * 2 + col * 3) % 4]
            material = mats["rift_gunmetal"] if (row + col) % 3 == 0 else mats["dark_violet_metal"]
            trim_material = mats["black_glass_trim"] if (row + col) % 2 == 0 else mats["outer_rail"]
            if (row + col) % 2 == 0:
                plate_a = [(x0, y0), (x1, y0 + 0.25), (x0 + 0.34, y1)]
                plate_b = [(x1, y0 + 0.25), (x1, y1), (x0 + 0.34, y1)]
            else:
                plate_a = [(x0, y0), (x1 - 0.28, y0), (x1, y1)]
                plate_b = [(x0, y0), (x1, y1), (x0, y1 - 0.26)]
            add_poly_plate(root, f"Sector2FracturedPrismDeckR{row}C{col}A", plate_a, FLOOR_TOP_Z + lift, BASE_THICKNESS, material, 0.070, 2)
            add_poly_plate(root, f"Sector2FracturedPrismDeckR{row}C{col}B", plate_b, FLOOR_TOP_Z + lift + 0.012, BASE_THICKNESS * 0.88, material, 0.060, 2)
            if (row + col) % 4 != 1:
                add_box(
                    root,
                    f"Sector2FracturedDeckR{row}C{col}DarkInsetSpine",
                    (center_x, center_y, FLOOR_TOP_Z + lift + 0.052),
                    (5.4, 0.132, 0.032),
                    trim_material,
                    0.014,
                    1,
                    math.radians(-24.0 if (row + col) % 2 == 0 else 24.0),
                )
            if (row * 5 + col) % 5 == 0:
                add_box(
                    root,
                    f"Sector2FracturedDeckR{row}C{col}SoftRiftSheen",
                    (center_x + 0.78, center_y - 0.72, FLOOR_TOP_Z + lift + 0.082),
                    (2.35, 0.062, 0.016),
                    mats["rift_sheen"],
                    0.010,
                    1,
                    math.radians(-22.0),
                )


def create_refraction_channels(root, mats: dict) -> None:
    channel_specs = [
        ("PrimaryRiftA", (-20.0, -14.6, NEON_Z), (21.5, 11.4, NEON_Z), 0.075, "magenta_channel"),
        ("PrimaryRiftB", (-18.4, 15.2, NEON_Z + 0.004), (19.0, -11.8, NEON_Z + 0.004), 0.060, "cyan_core"),
        ("OuterPrismLaneNorth", (-23.6, -18.8, NEON_Z), (23.6, -18.8, NEON_Z), 0.044, "magenta_channel"),
        ("OuterPrismLaneSouth", (-23.6, 18.8, NEON_Z), (23.6, 18.8, NEON_Z), 0.044, "magenta_channel"),
        ("OuterPrismLaneWest", (-18.8, -23.6, NEON_Z), (-18.8, 23.6, NEON_Z), 0.040, "cyan_core"),
        ("OuterPrismLaneEast", (18.8, -23.6, NEON_Z), (18.8, 23.6, NEON_Z), 0.040, "cyan_core"),
    ]
    for name, start, end, radius, material_key in channel_specs:
        add_cylinder_between(root, f"Sector2{name}ReadableEmbeddedTube", start, end, radius, mats[material_key], 12)

    diamond = [(0.0, -16.2, NEON_Z + 0.010), (16.2, 0.0, NEON_Z + 0.010), (0.0, 16.2, NEON_Z + 0.010), (-16.2, 0.0, NEON_Z + 0.010)]
    for index in range(len(diamond)):
        add_cylinder_between(root, f"Sector2CentralDiamondRefractionEdge{index}", diamond[index], diamond[(index + 1) % len(diamond)], 0.042, mats["magenta_channel"], 10)
    inner = [(0.0, -7.2, NEON_Z + 0.020), (7.2, 0.0, NEON_Z + 0.020), (0.0, 7.2, NEON_Z + 0.020), (-7.2, 0.0, NEON_Z + 0.020)]
    for index in range(len(inner)):
        material = mats["cyan_core"] if index % 2 == 0 else mats["magenta_channel"]
        add_cylinder_between(root, f"Sector2InnerRiftDiamondHotEdge{index}", inner[index], inner[(index + 1) % len(inner)], 0.038, material, 10)

    for index, x in enumerate([-18.3, -9.1, 9.1, 18.3]):
        add_box(root, f"Sector2VerticalPrismSeamDarkBed{index}", (x, 0.0, FLOOR_TOP_Z + 0.022), (0.185, 52.6, 0.034), mats["black_glass_trim"], 0.014, 1)
    for index, y in enumerate([-18.3, -9.1, 9.1, 18.3]):
        add_box(root, f"Sector2HorizontalPrismSeamDarkBed{index}", (0.0, y, FLOOR_TOP_Z + 0.020), (52.6, 0.185, 0.034), mats["black_glass_trim"], 0.014, 1)


def add_border_wall_segment(root, name: str, center: float, side: str, mats: dict) -> None:
    half = ARENA_HALF_SIZE
    if side in ["north", "south"]:
        sign = -1.0 if side == "north" else 1.0
        y = sign * half
        add_box(root, f"{name}DarkOuterRiftPlinth", (center, y + sign * 0.42, 0.20), (7.35, 1.20, 0.40), mats["deep_void"], 0.090, 1)
        add_box(root, f"{name}AngledVioletArmorFace", (center, y + sign * 0.56, 0.78), (6.72, 0.54, 1.06), mats["outer_rail"], 0.110, 2, math.radians(0.0))
        add_box(root, f"{name}InsetBlackGlassPanel", (center, y + sign * 0.23, 0.82), (4.86, 0.070, 0.58), mats["black_glass_trim"], 0.020, 1)
        add_box(root, f"{name}LowInnerPrismCurb", (center, y - sign * 0.46, 0.18), (6.90, 0.33, 0.32), mats["rift_gunmetal"], 0.048, 1)
        add_box(root, f"{name}MagentaWarningSlot", (center - 1.26, y - sign * 0.66, 0.55), (1.68, 0.048, 0.082), mats["magenta_channel"], 0.010, 1)
        add_box(root, f"{name}CyanRefractionSlot", (center + 1.32, y - sign * 0.66, 0.86), (1.24, 0.044, 0.070), mats["cyan_core"], 0.010, 1)
        add_cylinder_between(root, f"{name}VioletTopPrismRail", (center - 2.72, y - sign * 0.08, 1.44), (center + 2.72, y - sign * 0.08, 1.44), 0.040, mats["violet_glass"], 12)
    else:
        sign = -1.0 if side == "west" else 1.0
        x = sign * half
        add_box(root, f"{name}DarkOuterRiftPlinth", (x + sign * 0.42, center, 0.20), (1.20, 7.35, 0.40), mats["deep_void"], 0.090, 1)
        add_box(root, f"{name}AngledVioletArmorFace", (x + sign * 0.56, center, 0.78), (0.54, 6.72, 1.06), mats["outer_rail"], 0.110, 2)
        add_box(root, f"{name}InsetBlackGlassPanel", (x + sign * 0.23, center, 0.82), (0.070, 4.86, 0.58), mats["black_glass_trim"], 0.020, 1)
        add_box(root, f"{name}LowInnerPrismCurb", (x - sign * 0.46, center, 0.18), (0.33, 6.90, 0.32), mats["rift_gunmetal"], 0.048, 1)
        add_box(root, f"{name}MagentaWarningSlot", (x - sign * 0.66, center - 1.26, 0.55), (0.048, 1.68, 0.082), mats["magenta_channel"], 0.010, 1)
        add_box(root, f"{name}CyanRefractionSlot", (x - sign * 0.66, center + 1.32, 0.86), (0.044, 1.24, 0.070), mats["cyan_core"], 0.010, 1)
        add_cylinder_between(root, f"{name}VioletTopPrismRail", (x - sign * 0.08, center - 2.72, 1.44), (x - sign * 0.08, center + 2.72, 1.44), 0.040, mats["violet_glass"], 12)


def add_prism_corner_anchor(root, name: str, x: float, y: float, mats: dict) -> None:
    add_box(root, f"{name}LShapedDarkRiftBaseX", (x - math.copysign(0.42, x), y, 0.27), (1.42, 2.62, 0.54), mats["deep_void"], 0.115, 2)
    add_box(root, f"{name}LShapedDarkRiftBaseY", (x, y - math.copysign(0.42, y), 0.27), (2.62, 1.42, 0.54), mats["deep_void"], 0.115, 2)
    add_box(root, f"{name}VioletAnchorCore", (x, y, 0.96), (1.12, 1.12, 1.26), mats["outer_rail"], 0.105, 2, math.radians(45.0))
    add_triangle_glass_shard(root, f"{name}RaisedTriangularPrismCap", (x, y), 0.98, 1.72, 0.16, mats["violet_glass"], math.radians(30.0))
    add_box(root, f"{name}MagentaBeaconSlotX", (x, y - math.copysign(0.72, y), 1.12), (0.58, 0.052, 0.110), mats["magenta_channel"], 0.010, 1)
    add_box(root, f"{name}CyanBeaconSlotY", (x - math.copysign(0.72, x), y, 1.12), (0.052, 0.58, 0.110), mats["cyan_core"], 0.010, 1)


def add_crystal_spire(root, name: str, location, radius: float, height: float, mats: dict, rotation_z: float = 0.0) -> None:
    bpy.ops.mesh.primitive_cone_add(vertices=5, radius1=radius, radius2=radius * 0.24, depth=height, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.rotation_euler.z = rotation_z
    obj.data.materials.append(mats["violet_glass"])
    add_bevel(obj, 0.020, 1)
    obj.parent = root
    add_cylinder_between(root, f"{name}DimCyanInternalEdge", (location[0], location[1], location[2] - height * 0.34), (location[0], location[1], location[2] + height * 0.34), radius * 0.080, mats["cyan_core"], 5)


def create_border_and_crystals(root, mats: dict) -> None:
    segment_centers = [-24.0, -16.0, -8.0, 0.0, 8.0, 16.0, 24.0]
    for side in ["north", "south", "west", "east"]:
        for index, center in enumerate(segment_centers):
            add_border_wall_segment(root, f"Sector2PrismRiftBoundary_{side}_{index}_", center, side, mats)

    for index, (x, y) in enumerate([(-ARENA_HALF_SIZE, -ARENA_HALF_SIZE), (ARENA_HALF_SIZE, -ARENA_HALF_SIZE), (ARENA_HALF_SIZE, ARENA_HALF_SIZE), (-ARENA_HALF_SIZE, ARENA_HALF_SIZE)]):
        add_prism_corner_anchor(root, f"Sector2PrismRiftCornerAnchor{index}_", x, y, mats)

    crystal_specs = [
        ("NWClusterTall", -31.0, -22.5, 0.82, 0.46, 1.62, -18.0),
        ("NWClusterShort", -29.6, -25.0, 0.58, 0.30, 1.04, 14.0),
        ("NEClusterTall", 30.8, -20.2, 0.78, 0.42, 1.50, 20.0),
        ("NEClusterLow", 29.2, -25.3, 0.48, 0.28, 0.92, -12.0),
        ("SWClusterTall", -30.2, 21.8, 0.80, 0.44, 1.58, 10.0),
        ("SEClusterTall", 31.0, 23.0, 0.86, 0.48, 1.72, -24.0),
        ("NorthRiftShard", -5.6, -31.0, 0.54, 0.30, 1.02, 4.0),
        ("SouthRiftShard", 7.4, 31.0, 0.56, 0.32, 1.12, -8.0),
    ]
    for name, x, y, z, radius, height, rotation in crystal_specs:
        add_crystal_spire(root, f"Sector2OuterCrystal{name}", (x, y, z), radius, height, mats, math.radians(rotation))


def create_readability_guides(root, mats: dict) -> None:
    for index, radius in enumerate([9.4, 18.8, 26.4]):
        points = []
        for segment in range(6):
            angle = math.radians(30.0) + math.tau * float(segment) / 6.0
            points.append((math.cos(angle) * radius, math.sin(angle) * radius, NEON_Z + 0.018 + index * 0.004))
        for segment in range(len(points)):
            material = mats["magenta_channel"] if (segment + index) % 2 == 0 else mats["cyan_core"]
            add_cylinder_between(root, f"Sector2SparseHexReadabilityRoute{index}_{segment}", points[segment], points[(segment + 1) % len(points)], 0.020 + index * 0.003, material, 8)

    for index, (x, y, rot) in enumerate([(-13.6, -4.0, -22.0), (13.8, 4.2, -22.0), (-4.0, 13.8, 24.0), (4.2, -13.6, 24.0)]):
        add_triangle_glass_shard(root, f"Sector2LowInsetGlassPrismShard{index}", (x, y), 1.32, FLOOR_TOP_Z + 0.092, 0.045, mats["violet_glass"], math.radians(rot))


def setup_scene() -> None:
    clear_scene()
    bpy.context.preferences.filepaths.save_version = 0
    bpy.context.scene.unit_settings.system = "METRIC"
    bpy.context.scene.render.engine = "CYCLES"
    bpy.context.scene.world = bpy.data.worlds.new("NS_Sector2_Prism_Rift_World") if bpy.context.scene.world is None else bpy.context.scene.world
    bpy.context.scene.world.color = (0.010, 0.000, 0.024)

    root = bpy.data.objects.new("Sector2PrismRiftBlenderArenaKitRoot", None)
    root.empty_display_type = "CUBE"
    root["neon_swarm_asset"] = "phase_39_sector_2_prism_rift_blender_arena"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    root["art_direction"] = "fractured dark prism deck with magenta violet rift rails and readable glass structures"
    bpy.context.collection.objects.link(root)

    mats = make_materials()
    create_underfloor(root, mats)
    create_fractured_floor(root, mats)
    create_refraction_channels(root, mats)
    create_border_and_crystals(root, mats)
    create_readability_guides(root, mats)

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
