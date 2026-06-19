import math
from pathlib import Path

import bpy
from mathutils import Vector


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_1/source/blender/sector_1_subsector_arena_kit.blend"
EXPORT_DIR = REPO_ROOT / "art/arenas/sector_1/exported"

ARENA_HALF_SIZE = 28.0
SURFACE_Z = 0.110

VARIANTS = {
    "relay_yard": {
        "root_name": "Sector1RelayYardVariantRoot",
        "export": "sector_1_relay_yard.glb",
    },
    "data_trench": {
        "root_name": "Sector1DataTrenchVariantRoot",
        "export": "sector_1_data_trench.glb",
    },
    "capacitor_field": {
        "root_name": "Sector1CapacitorFieldVariantRoot",
        "export": "sector_1_capacitor_field.glb",
    },
    "rail_approach": {
        "root_name": "Sector1RailApproachVariantRoot",
        "export": "sector_1_rail_approach.glb",
    },
}


def clear_scene() -> None:
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete()
    for collection in list(bpy.data.collections):
        bpy.data.collections.remove(collection)


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
        "dark_aluminum": make_principled_material(
            "NS_S1_Dark_Brushed_Aluminum_Phase48",
            (0.205, 0.218, 0.232, 1.0),
            0.62,
            0.54,
            (0.025, 0.074, 0.088, 1.0),
            0.120,
        ),
        "raised_gunmetal": make_principled_material(
            "NS_S1_Raised_Gunmetal_Panel_Phase48",
            (0.245, 0.262, 0.274, 1.0),
            0.66,
            0.48,
            (0.030, 0.086, 0.100, 1.0),
            0.145,
        ),
        "edge_metal": make_principled_material(
            "NS_S1_Beveled_Edge_Gunmetal_Phase48",
            (0.145, 0.165, 0.188, 1.0),
            0.62,
            0.58,
            (0.022, 0.068, 0.086, 1.0),
            0.105,
        ),
        "deep_metal": make_principled_material(
            "NS_S1_Recessed_Dark_Depth_Metal_Phase48",
            (0.055, 0.066, 0.084, 1.0),
            0.40,
            0.78,
            (0.010, 0.042, 0.058, 1.0),
            0.048,
        ),
        "black_trim": make_principled_material(
            "NS_S1_Blackened_Service_Trim_Phase48",
            (0.030, 0.038, 0.052, 1.0),
            0.32,
            0.84,
            (0.006, 0.026, 0.040, 1.0),
            0.020,
        ),
        "cyan_channel": make_principled_material(
            "NS_S1_Dim_Cyan_Embedded_Channel_Phase48",
            (0.000, 0.340, 0.470, 1.0),
            0.0,
            0.34,
            (0.000, 0.620, 0.780, 1.0),
            0.68,
        ),
        "cyan_core": make_principled_material(
            "NS_S1_Restrained_Cyan_Rail_Core_Phase48",
            (0.025, 0.460, 0.580, 1.0),
            0.0,
            0.30,
            (0.000, 0.720, 0.900, 1.0),
            0.86,
        ),
        "sheen": make_principled_material(
            "NS_S1_Cool_Aluminum_Sheen_Phase48",
            (0.500, 0.650, 0.700, 1.0),
            0.34,
            0.20,
            (0.070, 0.240, 0.300, 1.0),
            0.160,
        ),
    }


def link_to_collection(obj, collection) -> None:
    collection.objects.link(obj)
    for existing_collection in list(obj.users_collection):
        if existing_collection != collection:
            existing_collection.objects.unlink(obj)


def add_weighted_normals(obj) -> None:
    if hasattr(obj.data, "use_auto_smooth"):
        obj.data.use_auto_smooth = True
    for polygon in obj.data.polygons:
        polygon.use_smooth = True
    weighted = obj.modifiers.new("phase48_weighted_normals", "WEIGHTED_NORMAL")
    weighted.keep_sharp = True


def add_bevel(obj, amount: float, segments: int = 1) -> None:
    if amount > 0.0:
        bevel = obj.modifiers.new("phase48_readable_bevels", "BEVEL")
        bevel.width = amount
        bevel.segments = segments
        bevel.affect = "EDGES"
        bevel.harden_normals = True
    add_weighted_normals(obj)


def add_box(collection, root, name: str, location, size, material, bevel: float = 0.0, segments: int = 1, rotation_z: float = 0.0):
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
    link_to_collection(obj, collection)
    return obj


def add_cylinder_between(collection, root, name: str, start, end, radius: float, material, vertices: int = 14):
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
    link_to_collection(obj, collection)
    return obj


def add_cylinder_disc(collection, root, name: str, location, radius: float, depth: float, material, vertices: int = 24, bevel: float = 0.0):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=radius, depth=depth, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.data.materials.append(material)
    add_bevel(obj, bevel, 1)
    obj.parent = root
    link_to_collection(obj, collection)
    return obj


def create_variant_root(key: str):
    collection = bpy.data.collections.new(f"Phase48_{key}")
    bpy.context.scene.collection.children.link(collection)
    root = bpy.data.objects.new(VARIANTS[key]["root_name"], None)
    collection.objects.link(root)
    return collection, root


def add_low_perimeter_machine_bank(collection, root, prefix: str, mats: dict, y: float, sign: int) -> None:
    for index, x in enumerate([-20.5, -10.0, 10.0, 20.5]):
        add_box(collection, root, f"{prefix}RelayWallBank{index}", (x, y, SURFACE_Z + 0.26), (4.8, 0.54, 0.52), mats["dark_aluminum"], 0.06, 2)
        add_box(collection, root, f"{prefix}RelayCyanSlit{index}", (x, y - sign * 0.035, SURFACE_Z + 0.58), (3.4, 0.075, 0.095), mats["cyan_core"], 0.018, 1)
        add_box(collection, root, f"{prefix}RelayTopBrace{index}", (x, y - sign * 0.09, SURFACE_Z + 0.86), (3.85, 0.19, 0.09), mats["edge_metal"], 0.025, 1)


def add_perimeter_frame(collection, root, prefix: str, mats: dict, north_profile: str = "standard") -> None:
    z = SURFACE_Z
    add_box(collection, root, f"{prefix}WestBoundaryMachineWall", (-27.35, 0.0, z + 0.330), (1.18, 52.0, 0.620), mats["dark_aluminum"], 0.070, 1)
    add_box(collection, root, f"{prefix}EastBoundaryMachineWall", (27.35, 0.0, z + 0.330), (1.18, 52.0, 0.620), mats["dark_aluminum"], 0.070, 1)
    add_box(collection, root, f"{prefix}SouthBoundaryMachineWall", (0.0, 27.35, z + 0.330), (52.0, 1.18, 0.620), mats["dark_aluminum"], 0.070, 1)
    north_height = 0.900 if north_profile == "gate" else 0.620
    north_depth = 1.70 if north_profile == "gate" else 1.18
    add_box(collection, root, f"{prefix}NorthBoundaryMachineWall", (0.0, -27.35, z + north_height * 0.52), (52.0, north_depth, north_height), mats["dark_aluminum"], 0.080, 2)
    for index, (x, y) in enumerate([(-27.0, -27.0), (27.0, -27.0), (-27.0, 27.0), (27.0, 27.0)]):
        add_box(collection, root, f"{prefix}CornerMachineryAnchor{index}", (x, y, z + 0.470), (2.45, 2.45, 0.820), mats["edge_metal"], 0.085, 2)
        add_box(collection, root, f"{prefix}CornerEmbeddedCyanPort{index}", (x, y, z + 0.910), (1.25, 0.105, 0.080), mats["cyan_channel"], 0.010, 1, math.radians(90.0 if index % 2 else 0.0))


def add_large_floor_plate(collection, root, name: str, center, size, mats: dict, material_key: str = "dark_aluminum", z_offset: float = 0.0) -> None:
    add_box(collection, root, name, (center[0], center[1], SURFACE_Z + z_offset), (size[0], size[1], size[2]), mats[material_key], 0.070, 2)


def add_cable_tray_segment(collection, root, name: str, center, length: float, rotation_z: float, mats: dict) -> None:
    x, y = center
    z = SURFACE_Z
    normal_x = -math.sin(rotation_z)
    normal_y = math.cos(rotation_z)
    add_box(collection, root, f"{name}DarkCableTrayBed", (x, y, z + 0.040), (length, 0.58, 0.072), mats["deep_metal"], 0.028, 1, rotation_z)
    add_box(collection, root, f"{name}NorthTrayLip", (x + normal_x * 0.235, y + normal_y * 0.235, z + 0.094), (length * 0.96, 0.105, 0.092), mats["edge_metal"], 0.018, 1, rotation_z)
    add_box(collection, root, f"{name}SouthTrayLip", (x - normal_x * 0.235, y - normal_y * 0.235, z + 0.094), (length * 0.96, 0.105, 0.092), mats["edge_metal"], 0.018, 1, rotation_z)
    for tick_index, offset in enumerate([-0.34, 0.0, 0.34]):
        add_box(collection, root, f"{name}EmbeddedSignalWindow{tick_index}", (x + math.cos(rotation_z) * length * offset, y + math.sin(rotation_z) * length * offset, z + 0.150), (min(length * 0.16, 1.15), 0.090, 0.026), mats["cyan_channel"], 0.010, 1, rotation_z)


def add_relay_hardware_cluster(collection, root, name: str, x: float, y: float, mats: dict, rotation_z: float = 0.0) -> None:
    z = SURFACE_Z
    add_box(collection, root, f"{name}RaisedRelayPadBase", (x, y, z + 0.050), (4.10, 3.05, 0.125), mats["raised_gunmetal"], 0.120, 2, rotation_z)
    add_box(collection, root, f"{name}InsetRelayServicePlate", (x, y, z + 0.142), (2.85, 1.78, 0.052), mats["black_trim"], 0.052, 1, rotation_z)
    add_box(collection, root, f"{name}CyanEmitterWindow", (x, y, z + 0.190), (1.22, 0.34, 0.042), mats["cyan_core"], 0.016, 1, rotation_z)
    add_box(collection, root, f"{name}SignalProjectorBlock", (x + math.cos(rotation_z) * 1.33, y + math.sin(rotation_z) * 1.33, z + 0.300), (0.68, 0.58, 0.310), mats["edge_metal"], 0.035, 1, rotation_z)
    add_cylinder_between(
        collection,
        root,
        f"{name}ShortRelayAntennaMast",
        (x - math.sin(rotation_z) * 1.35, y + math.cos(rotation_z) * 1.35, z + 0.170),
        (x - math.sin(rotation_z) * 1.35, y + math.cos(rotation_z) * 1.35, z + 0.780),
        0.075,
        mats["sheen"],
        12,
    )


def build_relay_yard(mats: dict) -> None:
    collection, root = create_variant_root("relay_yard")
    z = SURFACE_Z
    add_large_floor_plate(collection, root, "RelayYardPrimaryDeckPlate", (0.0, 0.0), (51.0, 51.0, 0.145), mats, "dark_aluminum", -0.060)
    add_perimeter_frame(collection, root, "RelayYard", mats)
    relay_points = [(-18.5, -17.0), (18.5, -17.0), (-18.5, 17.0), (18.5, 17.0)]
    for index, (x, y) in enumerate(relay_points):
        add_box(collection, root, f"RelayYardStationFoundation{index}", (x, y, z + 0.040), (8.20, 6.80, 0.180), mats["raised_gunmetal"], 0.130, 2)
        add_box(collection, root, f"RelayYardStationDarkServiceRecess{index}", (x, y, z + 0.172), (5.75, 4.20, 0.070), mats["black_trim"], 0.060, 1)
        add_relay_hardware_cluster(collection, root, f"RelayYardStationNode{index}", x, y, mats, math.radians((index % 2) * 12.0 - 6.0))
        add_box(collection, root, f"RelayYardStationSideCabinetA{index}", (x - 3.50, y, z + 0.360), (0.78, 3.65, 0.610), mats["edge_metal"], 0.042, 1)
        add_box(collection, root, f"RelayYardStationSideCabinetB{index}", (x + 3.50, y, z + 0.360), (0.78, 3.65, 0.610), mats["edge_metal"], 0.042, 1)
    add_cylinder_disc(collection, root, "RelayYardCentralSignalHubBase", (0.0, 0.0, z + 0.105), 4.65, 0.210, mats["raised_gunmetal"], 24, 0.035)
    add_cylinder_disc(collection, root, "RelayYardCentralDarkReceiverWell", (0.0, 0.0, z + 0.245), 3.20, 0.090, mats["black_trim"], 24, 0.020)
    add_cylinder_disc(collection, root, "RelayYardCentralCyanReceiverCore", (0.0, 0.0, z + 0.325), 1.48, 0.065, mats["cyan_core"], 24, 0.010)
    add_box(collection, root, "RelayYardCentralNorthReceiverBlock", (0.0, -3.90, z + 0.350), (3.2, 0.66, 0.430), mats["edge_metal"], 0.040, 1)
    add_box(collection, root, "RelayYardCentralSouthReceiverBlock", (0.0, 3.90, z + 0.350), (3.2, 0.66, 0.430), mats["edge_metal"], 0.040, 1)
    for index, (x, y) in enumerate(relay_points):
        center_x = x * 0.5
        center_y = y * 0.5
        length = math.hypot(x, y) - 7.0
        angle = math.atan2(y, x)
        add_cable_tray_segment(collection, root, f"RelayYardStationToHubCableTray{index}", (center_x, center_y), length, angle, mats)
    for index, x in enumerate([-22.0, -7.35, 7.35, 22.0]):
        add_box(collection, root, f"RelayYardPerimeterSignalEmitter{index}", (x, -26.20, z + 0.470), (3.40, 0.96, 0.780), mats["dark_aluminum"], 0.065, 2)
        add_box(collection, root, f"RelayYardPerimeterEmitterCyanSlot{index}", (x, -26.73, z + 0.820), (2.0, 0.085, 0.082), mats["cyan_core"], 0.010, 1)
    add_low_perimeter_machine_bank(collection, root, "North", mats, -ARENA_HALF_SIZE + 1.10, -1)
    add_low_perimeter_machine_bank(collection, root, "South", mats, ARENA_HALF_SIZE - 1.10, 1)


def build_data_trench(mats: dict) -> None:
    collection, root = create_variant_root("data_trench")
    z = SURFACE_Z
    add_large_floor_plate(collection, root, "DataTrenchLeftRaisedDeckIsland", (-22.0, 0.0), (7.5, 51.0, 0.175), mats, "raised_gunmetal", -0.040)
    add_large_floor_plate(collection, root, "DataTrenchCenterLeftDeckIsland", (-7.5, 0.0), (7.2, 51.0, 0.175), mats, "dark_aluminum", -0.040)
    add_large_floor_plate(collection, root, "DataTrenchCenterRightDeckIsland", (7.5, 0.0), (7.2, 51.0, 0.175), mats, "dark_aluminum", -0.040)
    add_large_floor_plate(collection, root, "DataTrenchRightRaisedDeckIsland", (22.0, 0.0), (7.5, 51.0, 0.175), mats, "raised_gunmetal", -0.040)
    add_perimeter_frame(collection, root, "DataTrench", mats)
    for index, x in enumerate([-15.0, 0.0, 15.0]):
        add_box(collection, root, f"DataTrenchMajorRecessedLane{index}", (x, 0.0, z - 0.090), (4.85, 47.0, 0.245), mats["deep_metal"], 0.055, 1)
        add_box(collection, root, f"DataTrenchLeftRaisedRim{index}", (x - 2.72, 0.0, z + 0.075), (0.52, 46.2, 0.160), mats["edge_metal"], 0.040, 1)
        add_box(collection, root, f"DataTrenchRightRaisedRim{index}", (x + 2.72, 0.0, z + 0.075), (0.52, 46.2, 0.160), mats["edge_metal"], 0.040, 1)
        for conduit_index, y in enumerate([-17.5, -6.5, 6.5, 17.5]):
            add_box(collection, root, f"DataTrenchContainedCyanConduit{index}_{conduit_index}", (x, y, z + 0.026), (2.75, 0.190, 0.040), mats["cyan_channel"], 0.010, 1)
        for bridge_index, y in enumerate([-20.5, -10.0, 0.0, 10.0, 20.5]):
            add_box(collection, root, f"DataTrenchHeavyBridgePlate{index}_{bridge_index}", (x, y, z + 0.160), (6.55, 1.22, 0.135), mats["raised_gunmetal"], 0.060, 1)
            add_box(collection, root, f"DataTrenchBridgeBoltedClamp{index}_{bridge_index}", (x, y, z + 0.250), (4.70, 0.280, 0.060), mats["black_trim"], 0.020, 1)
    add_box(collection, root, "DataTrenchCrossCutServiceChannel", (0.0, 0.0, z - 0.038), (42.0, 2.35, 0.170), mats["deep_metal"], 0.040, 1)
    add_box(collection, root, "DataTrenchCrossCutNorthLip", (0.0, -1.12, z + 0.056), (36.0, 0.265, 0.098), mats["edge_metal"], 0.026, 1)
    add_box(collection, root, "DataTrenchCrossCutSouthLip", (0.0, 1.12, z + 0.056), (36.0, 0.265, 0.098), mats["edge_metal"], 0.026, 1)
    for index, (x, y) in enumerate([(-21.0, -16.5), (21.0, -12.0), (-21.0, 5.5), (21.0, 15.5)]):
        add_box(collection, root, f"DataTrenchBrokenMemoryPanel{index}", (x, y, z + 0.082), (4.65, 2.10, 0.082), mats["dark_aluminum"], 0.056, 1, math.radians(3.0 if index % 2 == 0 else -3.0))
        add_box(collection, root, f"DataTrenchPanelDataSocket{index}", (x, y, z + 0.148), (1.30, 0.45, 0.036), mats["black_trim"], 0.018, 1)
    for index, y in enumerate([-23.2, 23.2]):
        add_box(collection, root, f"DataTrenchEndMemoryBus{index}", (0.0, y, z + 0.170), (36.0, 0.70, 0.180), mats["dark_aluminum"], 0.055, 1)
        add_box(collection, root, f"DataTrenchEndEmbeddedCyanPort{index}", (0.0, y, z + 0.310), (21.0, 0.095, 0.050), mats["cyan_core"], 0.010, 1)


def build_capacitor_field(mats: dict) -> None:
    collection, root = create_variant_root("capacitor_field")
    z = SURFACE_Z
    add_large_floor_plate(collection, root, "CapacitorFieldPrimaryPowerDeck", (0.0, 0.0), (51.0, 51.0, 0.155), mats, "dark_aluminum", -0.055)
    add_perimeter_frame(collection, root, "CapacitorField", mats)
    for row, y in enumerate([-16.5, -5.5, 5.5, 16.5]):
        for column, x in enumerate([-18.0, -6.0, 6.0, 18.0]):
            index = row * 4 + column
            add_box(collection, root, f"CapacitorFieldStorageCellBase{index}", (x, y, z + 0.075), (6.90, 5.90, 0.190), mats["raised_gunmetal"], 0.125, 2)
            add_box(collection, root, f"CapacitorFieldRecessedChargeWell{index}", (x, y, z + 0.220), (4.82, 3.70, 0.095), mats["black_trim"], 0.065, 1)
            add_box(collection, root, f"CapacitorFieldGlassChargePlate{index}", (x, y, z + 0.300), (2.82, 1.82, 0.052), mats["cyan_core"], 0.022, 1)
            add_box(collection, root, f"CapacitorFieldPositiveTerminal{index}", (x - 3.05, y, z + 0.302), (0.55, 2.30, 0.200), mats["edge_metal"], 0.034, 1)
            add_box(collection, root, f"CapacitorFieldNegativeTerminal{index}", (x + 3.05, y, z + 0.302), (0.55, 2.30, 0.200), mats["edge_metal"], 0.034, 1)
            if (row + column) % 2 == 0:
                add_box(collection, root, f"CapacitorFieldContainedVerticalTrace{index}", (x, y, z + 0.260), (0.135, 1.76, 0.030), mats["cyan_channel"], 0.010, 1)
            else:
                add_box(collection, root, f"CapacitorFieldContainedHorizontalTrace{index}", (x, y, z + 0.260), (1.76, 0.135, 0.030), mats["cyan_channel"], 0.010, 1)
    for index, x in enumerate([-22.5, -7.5, 7.5, 22.5]):
        add_box(collection, root, f"CapacitorFieldNorthChargeBankBody{index}", (x, -25.0, z + 0.360), (6.2, 1.05, 0.700), mats["dark_aluminum"], 0.075, 2)
        add_box(collection, root, f"CapacitorFieldSouthChargeBankBody{index}", (x, 25.0, z + 0.360), (6.2, 1.05, 0.700), mats["dark_aluminum"], 0.075, 2)
        add_box(collection, root, f"CapacitorFieldNorthMeterFace{index}", (x, -25.58, z + 0.710), (4.0, 0.105, 0.105), mats["cyan_channel"], 0.012, 1)
        add_box(collection, root, f"CapacitorFieldSouthMeterFace{index}", (x, 25.58, z + 0.710), (4.0, 0.105, 0.105), mats["cyan_channel"], 0.012, 1)
        add_box(collection, root, f"CapacitorFieldNorthBankTopPlate{index}", (x, -24.75, z + 0.850), (5.35, 0.32, 0.110), mats["edge_metal"], 0.026, 1)
        add_box(collection, root, f"CapacitorFieldSouthBankTopPlate{index}", (x, 24.75, z + 0.850), (5.35, 0.32, 0.110), mats["edge_metal"], 0.026, 1)
    for index, x in enumerate([-24.8, 24.8]):
        add_box(collection, root, f"CapacitorFieldSidePowerBus{index}", (x, 0.0, z + 0.230), (0.78, 36.0, 0.320), mats["dark_aluminum"], 0.052, 1)
        for socket_index, y in enumerate([-15.5, -5.5, 5.5, 15.5]):
            add_box(collection, root, f"CapacitorFieldSideSocket{index}_{socket_index}", (x, y, z + 0.455), (0.105, 1.72, 0.070), mats["cyan_channel"], 0.010, 1)


def build_rail_approach(mats: dict) -> None:
    collection, root = create_variant_root("rail_approach")
    z = SURFACE_Z
    add_large_floor_plate(collection, root, "RailApproachCorridorDeckBase", (0.0, 0.0), (49.0, 51.0, 0.150), mats, "dark_aluminum", -0.060)
    add_perimeter_frame(collection, root, "RailApproach", mats, "gate")
    add_box(collection, root, "RailApproachCentralRunwayRecess", (0.0, 0.0, z - 0.040), (25.0, 48.0, 0.185), mats["deep_metal"], 0.060, 1)
    for lane_index, lane_center in enumerate([-7.8, 7.8]):
        add_box(collection, root, f"RailApproachLaneBasePlate{lane_index}", (lane_center, 0.0, z + 0.070), (5.25, 48.0, 0.135), mats["deep_metal"], 0.045, 1)
        for side_index, rail_offset in enumerate([-1.52, 1.52]):
            rail_x = lane_center + rail_offset
            add_box(collection, root, f"RailApproachPhysicalRailFoot{lane_index}_{side_index}", (rail_x, 0.0, z + 0.150), (0.78, 47.0, 0.150), mats["edge_metal"], 0.042, 1)
            add_box(collection, root, f"RailApproachRaisedRailCap{lane_index}_{side_index}", (rail_x, 0.0, z + 0.275), (0.42, 45.2, 0.090), mats["sheen"], 0.028, 1)
        add_box(collection, root, f"RailApproachEmbeddedLanePowerCore{lane_index}", (lane_center, 0.0, z + 0.220), (0.160, 39.0, 0.046), mats["cyan_core"], 0.012, 1)
    for index, y in enumerate([-20.0, -14.0, -8.0, -2.0, 4.0, 10.0, 16.0, 22.0]):
        add_box(collection, root, f"RailApproachHeavySleeperPlate{index}", (0.0, y, z + 0.095), (24.0, 0.74, 0.130), mats["black_trim"], 0.038, 1)
        for bracket_index, x in enumerate([-9.32, -6.28, 6.28, 9.32]):
            add_box(collection, root, f"RailApproachRailBracket{index}_{bracket_index}", (x, y, z + 0.250), (0.82, 0.34, 0.115), mats["raised_gunmetal"], 0.024, 1)
    for side_index, x in enumerate([-19.5, 19.5]):
        add_box(collection, root, f"RailApproachDefenseCorridorWall{side_index}", (x, -1.5, z + 0.360), (0.92, 43.0, 0.640), mats["dark_aluminum"], 0.060, 1)
        for y in [-18.0, -6.0, 6.0, 18.0]:
            add_box(collection, root, f"RailApproachWallWarningPanel{side_index}_{int(y)}", (x, y, z + 0.720), (0.105, 3.2, 0.130), mats["cyan_channel"], 0.012, 1)
    add_box(collection, root, "RailApproachNorthDefenseGateBase", (0.0, -26.15, z + 0.450), (33.0, 1.55, 0.900), mats["dark_aluminum"], 0.082, 2)
    add_box(collection, root, "RailApproachNorthDefenseGateTopBrace", (0.0, -26.52, z + 1.110), (27.5, 0.44, 0.240), mats["edge_metal"], 0.044, 1)
    add_box(collection, root, "RailApproachNorthGateCrossBeam", (0.0, -25.45, z + 0.810), (21.5, 0.38, 0.200), mats["raised_gunmetal"], 0.034, 1)
    for index, x in enumerate([-12.0, -4.0, 4.0, 12.0]):
        add_box(collection, root, f"RailApproachGateEmbeddedLockWindow{index}", (x, -26.86, z + 0.875), (2.7, 0.090, 0.115), mats["cyan_core"], 0.012, 1)
        add_box(collection, root, f"RailApproachGateVerticalArmor{index}", (x, -25.60, z + 0.495), (0.62, 1.20, 0.650), mats["raised_gunmetal"], 0.042, 1)
    add_box(collection, root, "RailApproachSouthRunupPlate", (0.0, 24.2, z + 0.110), (26.0, 1.45, 0.150), mats["raised_gunmetal"], 0.065, 1)
    add_box(collection, root, "RailApproachSouthRunupEmbeddedWarningPanel", (0.0, 24.86, z + 0.230), (14.5, 0.110, 0.050), mats["cyan_channel"], 0.010, 1)


def variant_objects(root) -> list:
    objects = [root]
    objects.extend(root.children_recursive)
    return objects


def export_variant(key: str, root) -> None:
    bpy.ops.object.select_all(action="DESELECT")
    for obj in variant_objects(root):
        obj.select_set(True)
    bpy.context.view_layer.objects.active = root
    export_path = EXPORT_DIR / VARIANTS[key]["export"]
    bpy.ops.export_scene.gltf(
        filepath=str(export_path),
        export_format="GLB",
        use_selection=True,
        export_apply=True,
        export_cameras=False,
        export_lights=False,
        export_extras=True,
    )
    print(f"Exported {export_path}")


def main() -> None:
    EXPORT_DIR.mkdir(parents=True, exist_ok=True)
    bpy.context.preferences.filepaths.save_version = 0
    clear_scene()
    mats = make_materials()
    builders = {
        "relay_yard": build_relay_yard,
        "data_trench": build_data_trench,
        "capacitor_field": build_capacitor_field,
        "rail_approach": build_rail_approach,
    }
    roots = {}
    for key, builder in builders.items():
        builder(mats)
        roots[key] = bpy.data.objects[VARIANTS[key]["root_name"]]
    bpy.ops.wm.save_as_mainfile(filepath=str(SOURCE_BLEND))
    for key, root in roots.items():
        export_variant(key, root)


if __name__ == "__main__":
    main()
