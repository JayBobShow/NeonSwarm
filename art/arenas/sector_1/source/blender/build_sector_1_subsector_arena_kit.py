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


def build_relay_yard(mats: dict) -> None:
    collection, root = create_variant_root("relay_yard")
    z = SURFACE_Z
    relay_points = [
        (-16.0, -14.0),
        (0.0, -17.5),
        (16.0, -14.0),
        (-18.0, 0.0),
        (18.0, 0.0),
        (-16.0, 14.0),
        (0.0, 17.5),
        (16.0, 14.0),
    ]
    for index, (x, y) in enumerate(relay_points):
        add_box(collection, root, f"RelayYardRaisedNodePad{index}", (x, y, z + 0.030), (3.25, 2.25, 0.090), mats["raised_gunmetal"], 0.105, 2, math.radians((index % 3 - 1) * 6.0))
        add_box(collection, root, f"RelayYardInsetCyanCore{index}", (x, y, z + 0.100), (1.84, 0.28, 0.032), mats["cyan_core"], 0.020, 1, math.radians(index * 18.0))
        add_box(collection, root, f"RelayYardBlackServiceClamp{index}", (x, y + 0.72, z + 0.126), (2.22, 0.18, 0.034), mats["black_trim"], 0.016, 1, math.radians(index * -9.0))
    for index, (start, end) in enumerate([
        (relay_points[0], relay_points[1]),
        (relay_points[1], relay_points[2]),
        (relay_points[3], relay_points[1]),
        (relay_points[4], relay_points[1]),
        (relay_points[5], relay_points[6]),
        (relay_points[6], relay_points[7]),
        (relay_points[3], relay_points[6]),
        (relay_points[4], relay_points[6]),
    ]):
        sx, sy = start
        ex, ey = end
        cx = (sx + ex) * 0.5
        cy = (sy + ey) * 0.5
        length = math.hypot(ex - sx, ey - sy)
        angle = math.atan2(ey - sy, ex - sx)
        add_box(collection, root, f"RelayYardReadableSignalLine{index}", (cx, cy, z + 0.062), (length, 0.105, 0.034), mats["cyan_channel"], 0.012, 1, angle)
    add_low_perimeter_machine_bank(collection, root, "North", mats, -ARENA_HALF_SIZE + 1.10, -1)
    add_low_perimeter_machine_bank(collection, root, "South", mats, ARENA_HALF_SIZE - 1.10, 1)


def build_data_trench(mats: dict) -> None:
    collection, root = create_variant_root("data_trench")
    z = SURFACE_Z
    for index, x in enumerate([-14.0, -6.5, 6.5, 14.0]):
        add_box(collection, root, f"DataTrenchDarkChannel{index}", (x, 0.0, z - 0.010), (1.06, 43.0, 0.115), mats["deep_metal"], 0.030, 1)
        add_box(collection, root, f"DataTrenchWestLip{index}", (x - 0.70, 0.0, z + 0.046), (0.22, 42.0, 0.070), mats["edge_metal"], 0.025, 1)
        add_box(collection, root, f"DataTrenchEastLip{index}", (x + 0.70, 0.0, z + 0.046), (0.22, 42.0, 0.070), mats["edge_metal"], 0.025, 1)
        for bridge_index, y in enumerate([-18.0, -7.0, 7.0, 18.0]):
            add_box(collection, root, f"DataTrenchBridgePlate{index}_{bridge_index}", (x, y, z + 0.116), (2.35, 0.56, 0.058), mats["raised_gunmetal"], 0.044, 1)
    for index, y in enumerate([-20.0, -11.0, 0.0, 11.0, 20.0]):
        add_box(collection, root, f"DataTrenchBrokenMemoryStrip{index}", (0.0, y, z + 0.080), (23.0 - index * 1.3, 0.075, 0.034), mats["cyan_channel"], 0.010, 1, math.radians(2.5 if index % 2 == 0 else -2.5))
        add_box(collection, root, f"DataTrenchOffsetDataPlate{index}", (-20.0 + index * 10.0, y + 1.25, z + 0.075), (3.8, 0.42, 0.052), mats["black_trim"], 0.025, 1, math.radians(-5.0 + index * 2.0))
    for index, y in enumerate([-22.5, 22.5]):
        add_box(collection, root, f"DataTrenchEndMemoryBus{index}", (0.0, y, z + 0.135), (35.0, 0.44, 0.120), mats["dark_aluminum"], 0.048, 1)
        add_box(collection, root, f"DataTrenchEndCyanBus{index}", (0.0, y, z + 0.225), (31.0, 0.075, 0.036), mats["cyan_core"], 0.010, 1)


def build_capacitor_field(mats: dict) -> None:
    collection, root = create_variant_root("capacitor_field")
    z = SURFACE_Z
    for row, y in enumerate([-16.0, -8.0, 8.0, 16.0]):
        for column, x in enumerate([-18.0, -9.0, 9.0, 18.0]):
            index = row * 4 + column
            add_box(collection, root, f"CapacitorFieldStorageCell{index}", (x, y, z + 0.045), (4.25, 3.65, 0.100), mats["raised_gunmetal"], 0.088, 2)
            add_box(collection, root, f"CapacitorFieldDarkWell{index}", (x, y, z + 0.118), (2.85, 2.10, 0.042), mats["black_trim"], 0.044, 1)
            add_box(collection, root, f"CapacitorFieldCyanChargeBar{index}", (x, y, z + 0.160), (2.34, 0.155, 0.032), mats["cyan_core"], 0.014, 1, math.radians(90.0 if index % 2 else 0.0))
    for index, x in enumerate([-22.5, -7.5, 7.5, 22.5]):
        add_box(collection, root, f"CapacitorFieldNorthChargeBank{index}", (x, -25.0, z + 0.300), (5.6, 0.74, 0.56), mats["dark_aluminum"], 0.065, 2)
        add_box(collection, root, f"CapacitorFieldSouthChargeBank{index}", (x, 25.0, z + 0.300), (5.6, 0.74, 0.56), mats["dark_aluminum"], 0.065, 2)
        add_box(collection, root, f"CapacitorFieldNorthCyanMeter{index}", (x, -25.28, z + 0.605), (3.8, 0.075, 0.065), mats["cyan_channel"], 0.010, 1)
        add_box(collection, root, f"CapacitorFieldSouthCyanMeter{index}", (x, 25.28, z + 0.605), (3.8, 0.075, 0.065), mats["cyan_channel"], 0.010, 1)
    for index, angle in enumerate([0.0, math.pi * 0.5, math.pi, math.pi * 1.5]):
        add_cylinder_between(
            collection,
            root,
            f"CapacitorFieldLowEnergyConduit{index}",
            (math.cos(angle) * 6.2, math.sin(angle) * 6.2, z + 0.118),
            (math.cos(angle) * 22.0, math.sin(angle) * 22.0, z + 0.118),
            0.045,
            mats["cyan_channel"],
            12,
        )


def build_rail_approach(mats: dict) -> None:
    collection, root = create_variant_root("rail_approach")
    z = SURFACE_Z
    for index, x in enumerate([-10.5, -6.8, 6.8, 10.5]):
        add_box(collection, root, f"RailApproachLongRail{index}", (x, 0.0, z + 0.110), (0.42, 47.0, 0.170), mats["edge_metal"], 0.040, 1)
        add_box(collection, root, f"RailApproachCyanRailCore{index}", (x, 0.0, z + 0.220), (0.115, 42.5, 0.048), mats["cyan_core"], 0.012, 1)
    for index, y in enumerate([-20.0, -14.0, -8.0, -2.0, 4.0, 10.0, 16.0, 22.0]):
        add_box(collection, root, f"RailApproachSleeperPlate{index}", (0.0, y, z + 0.055), (27.0, 0.48, 0.090), mats["black_trim"], 0.030, 1)
        add_box(collection, root, f"RailApproachCoolWarningStrip{index}", (-15.8, y, z + 0.122), (3.4, 0.075, 0.038), mats["cyan_channel"], 0.010, 1, math.radians(-11.0))
        add_box(collection, root, f"RailApproachCoolWarningStripMirror{index}", (15.8, y, z + 0.122), (3.4, 0.075, 0.038), mats["cyan_channel"], 0.010, 1, math.radians(11.0))
    add_box(collection, root, "RailApproachNorthDefenseGateBase", (0.0, -26.15, z + 0.365), (31.0, 1.25, 0.72), mats["dark_aluminum"], 0.072, 2)
    add_box(collection, root, "RailApproachNorthDefenseGateTopBrace", (0.0, -26.46, z + 0.915), (25.5, 0.34, 0.180), mats["edge_metal"], 0.040, 1)
    for index, x in enumerate([-12.0, -4.0, 4.0, 12.0]):
        add_box(collection, root, f"RailApproachGateCyanLock{index}", (x, -26.82, z + 0.740), (2.7, 0.080, 0.092), mats["cyan_core"], 0.012, 1)
        add_box(collection, root, f"RailApproachGateVerticalArmor{index}", (x, -25.64, z + 0.410), (0.45, 1.02, 0.500), mats["raised_gunmetal"], 0.036, 1)
    add_box(collection, root, "RailApproachSouthRunupPlate", (0.0, 24.2, z + 0.080), (26.0, 1.2, 0.105), mats["raised_gunmetal"], 0.055, 1)


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
