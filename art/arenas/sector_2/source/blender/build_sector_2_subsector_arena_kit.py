import math
import sys
from pathlib import Path

import bpy


SCRIPT_DIR = Path(__file__).resolve().parent
if str(SCRIPT_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPT_DIR))

import build_sector_2_prism_rift_arena as base


REPO_ROOT = Path(__file__).resolve().parents[5]
SOURCE_BLEND = REPO_ROOT / "art/arenas/sector_2/source/blender/sector_2_subsector_arena_kit.blend"
EXPORT_DIR = REPO_ROOT / "art/arenas/sector_2/exported"

ARENA_HALF_SIZE = 28.0

VARIANTS = {
    "mirror_flats": {
        "root_name": "Sector2MirrorFlatsVariantRoot",
        "export": "sector_2_mirror_flats.glb",
    },
    "fracture_hall": {
        "root_name": "Sector2FractureHallVariantRoot",
        "export": "sector_2_fracture_hall.glb",
    },
    "violet_glassway": {
        "root_name": "Sector2VioletGlasswayVariantRoot",
        "export": "sector_2_violet_glassway.glb",
    },
    "rift_lens": {
        "root_name": "Sector2RiftLensVariantRoot",
        "export": "sector_2_rift_lens.glb",
    },
}


def create_variant_root(key: str):
    root = bpy.data.objects.new(VARIANTS[key]["root_name"], None)
    root.empty_display_type = "CUBE"
    root["neon_swarm_asset"] = "phase_49_sector_2_subsector_arena_variant"
    root["primary_reference"] = "art/reference/sector_2_prism_rift/sector_2_reference_sheet.png"
    root["gameplay_half_size"] = ARENA_HALF_SIZE
    bpy.context.collection.objects.link(root)
    return root


def add_cylinder_disc(root, name: str, location, radius: float, depth: float, material, vertices: int = 48, bevel: float = 0.0):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=radius, depth=depth, location=location)
    obj = bpy.context.object
    obj.name = name
    obj.data.name = f"{name}_Mesh"
    obj.data.materials.append(material)
    base.add_bevel_and_weighted_normals(obj, bevel, 1)
    obj.parent = root
    return obj


def add_ring_stack(root, prefix: str, center, mats: dict, outer_radius: float, inner_radius: float, top_z: float) -> None:
    add_cylinder_disc(root, f"{prefix}OuterMagentaPrismRing", (center[0], center[1], top_z), outer_radius, 0.145, mats["magenta_rim"], 64, 0.030)
    add_cylinder_disc(root, f"{prefix}DarkInnerLensWell", (center[0], center[1], top_z + 0.072), inner_radius, 0.158, mats["dark_groove"], 64, 0.030)
    add_cylinder_disc(root, f"{prefix}VioletGlassLensPlate", (center[0], center[1], top_z + 0.170), inner_radius * 0.80, 0.070, mats["deep_violet_glass"], 64, 0.022)


def add_prism_shard(root, prefix: str, x: float, y: float, rotation_degrees: float, scale: float, mats: dict, top_z: float) -> None:
    points = [
        (-0.42 * scale, -0.52 * scale),
        (0.46 * scale, -0.36 * scale),
        (0.22 * scale, 0.54 * scale),
        (-0.32 * scale, 0.34 * scale),
    ]
    angle = math.radians(rotation_degrees)
    rotated = []
    for px, py in points:
        rx = px * math.cos(angle) - py * math.sin(angle)
        ry = px * math.sin(angle) + py * math.cos(angle)
        rotated.append((x + rx, y + ry))
    base.add_poly_prism(root, f"{prefix}RaisedPrismShardBody", rotated, top_z, 0.42 * scale, mats["amethyst_glass"], mats["magenta_rim"], 0.030, 1)
    base.add_bar_between(root, f"{prefix}PrismShardCoreGlow", (x - math.cos(angle) * scale * 0.20, y - math.sin(angle) * scale * 0.20), (x + math.cos(angle) * scale * 0.24, y + math.sin(angle) * scale * 0.24), 0.060 * scale, 0.052, top_z + 0.120, mats["pink_crack"], 0.006, 1)


def add_common_prism_boundary(root, prefix: str, mats: dict, gate_bias: bool = False) -> None:
    base.add_box(root, f"{prefix}DarkRiftUndertray", (0.0, 0.0, -0.390), (58.0, 58.0, 0.38), mats["rift_backplane"], 0.150, 2)
    base.add_box(root, f"{prefix}ContinuousGraphiteFloorBed", (0.0, 0.0, -0.105), (55.0, 55.0, 0.24), mats["black_frame"], 0.110, 2)
    base.create_boundary(root, mats)
    if gate_bias:
        base.add_box(root, f"{prefix}NorthBossApproachWallMass", (0.0, -27.0, 0.980), (35.0, 1.45, 1.36), mats["black_frame"], 0.080, 1)
        base.add_box(root, f"{prefix}NorthBossApproachMagentaSlot", (0.0, -27.78, 1.235), (18.0, 0.070, 0.090), mats["magenta_rim"], 0.010, 1)


def build_mirror_flats(mats: dict) -> None:
    root = create_variant_root("mirror_flats")
    add_common_prism_boundary(root, "MirrorFlats", mats)
    base.add_box(root, "MirrorFlatsBroadReflectiveUnderplate", (0.0, 0.0, 0.020), (43.0, 45.0, 0.130), mats["black_frame"], 0.090, 1)
    for row, y in enumerate([-16.2, -5.4, 5.4, 16.2]):
        for column, x in enumerate([-12.8, 0.0, 12.8]):
            index = row * 3 + column
            material = mats["amethyst_glass"] if (row + column) % 2 == 0 else mats["deep_violet_glass"]
            base.add_box(root, f"MirrorFlatsBroadReflectivePrismPlate{index}", (x, y, 0.190), (11.6, 9.4, 0.125), material, 0.075, 2)
            base.add_box(root, f"MirrorFlatsBeveledPanelRim{index}A", (x, y - 4.82, 0.315), (10.4, 0.20, 0.092), mats["magenta_rim"], 0.014, 1)
            base.add_box(root, f"MirrorFlatsBeveledPanelRim{index}B", (x, y + 4.82, 0.315), (10.4, 0.20, 0.092), mats["magenta_rim"], 0.014, 1)
            if column != 1:
                base.add_box(root, f"MirrorFlatsSoftVerticalReflectionBand{index}", (x * 0.96, y, 0.356), (0.20, 6.6, 0.034), mats["violet_sheen"], 0.008, 1)
    for index, x in enumerate([-18.8, 18.8]):
        base.add_box(root, f"MirrorFlatsSideMirrorAnchorRail{index}", (x, 0.0, 0.430), (1.05, 39.5, 0.520), mats["black_frame"], 0.060, 1)
        for y in [-16.8, -5.6, 5.6, 16.8]:
            add_prism_shard(root, f"MirrorFlatsCornerPrismCluster{index}_{int(y)}", x, y, 22.0 if x < 0.0 else -22.0, 1.32, mats, 0.500)
    for index, y in enumerate([-22.8, 22.8]):
        base.add_box(root, f"MirrorFlatsHorizontalMirrorHeader{index}", (0.0, y, 0.390), (32.0, 1.00, 0.540), mats["graphite_panel"], 0.065, 1)
        base.add_box(root, f"MirrorFlatsHeaderMagentaReflectionSlot{index}", (0.0, y, 0.725), (21.0, 0.070, 0.060), mats["pink_crack"], 0.008, 1)


def build_fracture_hall(mats: dict) -> None:
    root = create_variant_root("fracture_hall")
    add_common_prism_boundary(root, "FractureHall", mats)
    base.add_box(root, "FractureHallLongHallFoundation", (0.0, 0.0, 0.010), (43.5, 49.0, 0.140), mats["black_frame"], 0.085, 1)
    left_points = [(-20.5, -23.0), (-4.5, -21.2), (-7.2, -9.0), (-3.5, 1.4), (-8.5, 12.2), (-5.8, 23.0), (-21.5, 23.0), (-21.5, -23.0)]
    right_points = [(20.5, -23.0), (5.0, -21.0), (7.8, -8.4), (3.8, 2.0), (9.2, 12.8), (6.0, 23.0), (21.5, 23.0), (21.5, -23.0)]
    center_points = [(-3.8, -21.5), (3.8, -21.5), (2.0, -10.4), (5.8, -3.0), (0.0, 5.8), (3.6, 15.2), (-3.0, 22.0), (-5.8, 11.0), (-2.0, 1.4), (-5.6, -9.5)]
    base.add_poly_prism(root, "FractureHallLeftSplitFloorPlate", left_points, 0.220, 0.160, mats["graphite_panel"], mats["dark_groove"], 0.060, 2)
    base.add_poly_prism(root, "FractureHallRightSplitFloorPlate", right_points, 0.220, 0.160, mats["graphite_panel"], mats["dark_groove"], 0.060, 2)
    base.add_poly_prism(root, "FractureHallCentralBrokenGlassPath", center_points, 0.280, 0.120, mats["deep_violet_glass"], mats["magenta_rim"], 0.055, 2)
    crack_path = [(-2.4, -22.0), (2.2, -14.0), (-1.4, -7.2), (3.8, -1.2), (-0.8, 5.8), (2.7, 12.4), (-1.9, 22.0)]
    for index in range(len(crack_path) - 1):
        width = 0.30 if index % 2 == 0 else 0.22
        base.add_bar_between(root, f"FractureHallCentralMagentaRiftSplit{index}", crack_path[index], crack_path[index + 1], width, 0.080, 0.420, mats["pink_crack"], 0.010, 1)
    for index, y in enumerate([-17.0, -9.0, 0.0, 9.0, 17.0]):
        base.add_box(root, f"FractureHallBrokenCrossRibLeft{index}", (-13.5, y, 0.450), (9.0, 0.52, 0.390), mats["black_frame"], 0.045, 1, math.radians(10.0 if index % 2 == 0 else -8.0))
        base.add_box(root, f"FractureHallBrokenCrossRibRight{index}", (13.5, y, 0.450), (9.0, 0.52, 0.390), mats["black_frame"], 0.045, 1, math.radians(-10.0 if index % 2 == 0 else 8.0))
    for index, (x, y, rot) in enumerate([(-18, -18, -28), (18, -14, 24), (-18, 7, 18), (18, 17, -18)]):
        add_prism_shard(root, f"FractureHallWallPrismRib{index}", x, y, rot, 1.65, mats, 0.520)


def build_violet_glassway(mats: dict) -> None:
    root = create_variant_root("violet_glassway")
    add_common_prism_boundary(root, "VioletGlassway", mats)
    base.add_box(root, "VioletGlasswayLongRouteFoundation", (0.0, 0.0, 0.012), (33.5, 50.0, 0.140), mats["black_frame"], 0.080, 1)
    base.add_box(root, "VioletGlasswayCentralGlassChannel", (0.0, 0.0, 0.230), (6.4, 46.5, 0.145), mats["amethyst_glass"], 0.070, 2)
    base.add_box(root, "VioletGlasswayCentralMagentaRouteCore", (0.0, 0.0, 0.386), (0.62, 42.0, 0.055), mats["pink_crack"], 0.010, 1)
    for index, y in enumerate([-18.0, 0.0, 18.0]):
        add_ring_stack(root, f"VioletGlasswayRouteLensNode{index}", (0.0, y), mats, 5.1, 3.8, 0.310)
        base.add_box(root, f"VioletGlasswayNodeBridgeCollar{index}", (0.0, y, 0.560), (8.4, 0.42, 0.150), mats["magenta_rim"], 0.018, 1)
    for side_index, x in enumerate([-13.2, 13.2]):
        base.add_box(root, f"VioletGlasswayRaisedSideStructure{side_index}", (x, 0.0, 0.430), (2.0, 42.0, 0.700), mats["graphite_panel"], 0.072, 1)
        for y in [-17.0, -5.8, 5.8, 17.0]:
            base.add_box(root, f"VioletGlasswaySideVioletWindow{side_index}_{int(y)}", (x, y, 0.835), (1.12, 3.2, 0.082), mats["violet_sheen"], 0.014, 1)
    for index, y in enumerate([-22.8, 22.8]):
        base.add_box(root, f"VioletGlasswayRouteEndFrame{index}", (0.0, y, 0.470), (18.0, 0.92, 0.620), mats["black_frame"], 0.060, 1)


def build_rift_lens(mats: dict) -> None:
    root = create_variant_root("rift_lens")
    add_common_prism_boundary(root, "RiftLens", mats, True)
    base.add_box(root, "RiftLensFocusingDeckFoundation", (0.0, 0.0, 0.012), (48.0, 48.0, 0.150), mats["black_frame"], 0.090, 1)
    add_ring_stack(root, "RiftLensPrimaryFocal", (0.0, 0.0), mats, 13.0, 9.6, 0.300)
    add_cylinder_disc(root, "RiftLensCentralMagentaEyeCore", (0.0, 0.0, 0.625), 3.45, 0.125, mats["pink_crack"], 64, 0.030)
    add_cylinder_disc(root, "RiftLensCentralCyanCounterPrism", (0.0, 0.0, 0.735), 1.55, 0.072, mats["cyan_micro"], 48, 0.020)
    for index, angle_degrees in enumerate([0.0, 45.0, 90.0, 135.0]):
        angle = math.radians(angle_degrees)
        base.add_box(root, f"RiftLensRadialFocusingRib{index}", (math.cos(angle) * 8.6, math.sin(angle) * 8.6, 0.545), (14.8, 0.58, 0.330), mats["graphite_panel"], 0.044, 1, angle)
        base.add_box(root, f"RiftLensEmbeddedRadialMagentaChannel{index}", (math.cos(angle) * 8.6, math.sin(angle) * 8.6, 0.760), (10.5, 0.090, 0.060), mats["magenta_rim"], 0.008, 1, angle)
    for index, (x, y, rot) in enumerate([(-15.5, -16.0, -22), (15.5, -16.0, 22), (-15.5, 16.0, 22), (15.5, 16.0, -22)]):
        add_prism_shard(root, f"RiftLensFocusingPrismTower{index}", x, y, rot, 2.05, mats, 0.560)
        base.add_box(root, f"RiftLensTowerBaseClamp{index}", (x, y, 0.420), (4.2, 2.7, 0.340), mats["black_frame"], 0.040, 1, math.radians(rot * 0.35))
    for index, y in enumerate([-22.2, 22.2]):
        base.add_box(root, f"RiftLensApproachArcFrame{index}", (0.0, y, 0.520), (28.0, 1.10, 0.740), mats["graphite_panel"], 0.075, 1)
        base.add_box(root, f"RiftLensApproachFramePrismSlot{index}", (0.0, y, 0.935), (15.5, 0.085, 0.080), mats["pink_crack"], 0.010, 1)


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
        export_materials="EXPORT",
        export_animations=False,
        export_extras=True,
    )
    print(f"Exported {export_path}")


def setup_preview_camera_and_lights() -> None:
    camera_data = bpy.data.cameras.new("Sector2SubsectorReferenceGameplayCamera")
    camera = bpy.data.objects.new("Sector2SubsectorReferenceGameplayCamera", camera_data)
    camera.location = (0.0, -34.0, 33.0)
    camera.rotation_euler = (math.radians(52.0), 0.0, 0.0)
    camera.data.lens = 24.0
    bpy.context.collection.objects.link(camera)
    bpy.context.scene.camera = camera

    light_data = bpy.data.lights.new("Sector2SubsectorPrismPreviewAreaLight", "AREA")
    light = bpy.data.objects.new("Sector2SubsectorPrismPreviewAreaLight", light_data)
    light.location = (-8.0, -16.0, 20.0)
    light.rotation_euler = (math.radians(58.0), 0.0, math.radians(-20.0))
    light.data.energy = 430.0
    light.data.size = 18.0
    bpy.context.collection.objects.link(light)


def main() -> None:
    EXPORT_DIR.mkdir(parents=True, exist_ok=True)
    bpy.context.preferences.filepaths.save_version = 0
    base.clear_scene()
    bpy.context.scene.unit_settings.system = "METRIC"
    mats = base.make_materials()
    builders = {
        "mirror_flats": build_mirror_flats,
        "fracture_hall": build_fracture_hall,
        "violet_glassway": build_violet_glassway,
        "rift_lens": build_rift_lens,
    }
    roots = {}
    for key, builder in builders.items():
        builder(mats)
        roots[key] = bpy.data.objects[VARIANTS[key]["root_name"]]
    setup_preview_camera_and_lights()
    bpy.ops.wm.save_as_mainfile(filepath=str(SOURCE_BLEND))
    for key, root in roots.items():
        export_variant(key, root)


if __name__ == "__main__":
    main()
