extends RefCounted


static func sector_count() -> int:
	return 4


static func sector_data(index: int) -> Dictionary:
	var sectors := _sector_definitions()
	var clamped_index := clampi(index, 0, sectors.size() - 1)
	return sectors[clamped_index].duplicate(true)


static func level_upgrade_pool() -> Array:
	return [
		{"id": "damage_core", "title": "Damage Core", "description": "+12% weapon damage", "category": "damage", "shape": "Octahedron core", "effects": {"damage_multiplier_add": 0.12}},
		{"id": "rapid_capacitor", "title": "Rapid Capacitor", "description": "+12% fire rate", "category": "fire rate", "shape": "Cylinder capacitor", "effects": {"fire_rate_multiplier_add": 0.12}},
		{"id": "split_lens", "title": "Split Lens", "description": "+1 Pulse Blaster projectile", "category": "projectile count", "shape": "Prism lens", "effects": {"projectile_count_add": 1}},
		{"id": "magnet_annulus", "title": "Magnet Annulus", "description": "+14% pickup range", "category": "pickup range", "shape": "Annulus field", "effects": {"pickup_radius_add": 0.80}},
		{"id": "vector_thrusters", "title": "Vector Thrusters", "description": "+8% movement speed", "category": "movement speed", "shape": "Triangular prism thrust", "effects": {"speed_add": 0.85}},
		{"id": "dense_reactor", "title": "Dense Reactor", "description": "+18 max health and heal", "category": "max health", "shape": "Sphere reactor", "effects": {"max_health_add": 18.0, "heal_add": 18.0}},
		{"id": "orbit_splitter", "title": "Orbit Splitter", "description": "+1 Orbit Spark", "category": "orbit count", "shape": "Sphere plus annulus", "effects": {"orbit_count_add": 1}},
		{"id": "nova_compressor", "title": "Nova Compressor", "description": "-12% Nova cooldown", "category": "nova cooldown", "shape": "Torus compressor", "effects": {"nova_cooldown_multiplier_add": -0.12}},
		{"id": "beam_sustain", "title": "Beam Sustain", "description": "+0.08s Arc Beam duration", "category": "beam duration", "shape": "Cylinder beam tube", "effects": {"beam_duration_add": 0.08}},
		{"id": "mine_well", "title": "Mine Well", "description": "+11% Gravity Mine radius", "category": "mine radius", "shape": "Torus gravity well", "effects": {"mine_radius_add": 0.45}},
		{"id": "lance_refraction", "title": "Lance Refraction", "description": "+16% Prism Lance damage", "category": "lance damage", "shape": "Triangular prism lance", "effects": {"prism_lance_damage_multiplier_add": 0.16}},
		{"id": "lance_aperture", "title": "Lance Aperture", "description": "+1 Prism Lance pierce", "category": "lance pierce", "shape": "Hexagonal prism aperture", "effects": {"prism_lance_pierce_add": 1}},
		{"id": "hex_shatter_core", "title": "Hex Shatter Core", "description": "+18% Hex Shatter damage", "category": "hex shatter damage", "shape": "Hex prism fracture core", "effects": {"hex_shatter_damage_multiplier_add": 0.18}},
		{"id": "hex_shard_splitter", "title": "Shard Splitter", "description": "+2 Hex Shatter split shards", "category": "hex shatter split", "shape": "Six-point shard fan", "effects": {"hex_shatter_split_add": 2}},
		{"id": "hex_rail_capacitor", "title": "Hex Rail Capacitor", "description": "-15% Hex Shatter cooldown", "category": "hex shatter rate", "shape": "Hex capacitor rail", "effects": {"hex_shatter_cooldown_multiplier_add": -0.15}},
		{"id": "fractal_shard_core", "title": "Fractal Core", "description": "Fractal Shard +18% shard damage", "category": "fractal damage", "shape": "Stacked triangle core", "effects": {"fractal_shard_damage_multiplier_add": 0.18}},
		{"id": "fractal_shard_splitter", "title": "Fractal Splitter", "description": "Fractal Shard +2 split shards", "category": "fractal split", "shape": "Triangle shard fan", "effects": {"fractal_shard_split_add": 2}},
		{"id": "fractal_coolant", "title": "Fractal Coolant", "description": "Fractal Shard -14% cooldown", "category": "fractal rate", "shape": "Cyan prism sink", "effects": {"fractal_shard_cooldown_multiplier_add": -0.14}},
		{"id": "fractal_tail", "title": "Fractal Tail", "description": "Fractal Shard +0.22s lifetime", "category": "fractal reach", "shape": "Long shard rail", "effects": {"fractal_shard_life_add": 0.22}},
		{"id": "fractal_aperture", "title": "Fractal Aperture", "description": "Fractal Shard +1 primary pierce", "category": "fractal pierce", "shape": "Diamond aperture", "effects": {"fractal_shard_pierce_add": 1}},
		{"id": "saw_annulus", "title": "Saw Annulus", "description": "+10% Ring Saw radius", "category": "ring saw radius", "shape": "Annulus saw field", "effects": {"ring_saw_radius_add": 0.32}},
		{"id": "saw_gyro", "title": "Saw Gyro", "description": "+12% Ring Saw spin", "category": "ring saw spin", "shape": "Torus gyro", "effects": {"ring_saw_spin_add": 0.12}},
		{"id": "magnet_helix", "title": "Magnet Helix", "description": "+12% XP pull strength", "category": "XP magnet", "shape": "Helix attraction coil", "effects": {"xp_pull_speed_add": 1.50}},
		{"id": "vital_cuboid", "title": "Vital Cuboid", "description": "+14 max health and heal", "category": "max health", "shape": "Cuboid armor cell", "effects": {"max_health_add": 14.0, "heal_add": 14.0}},
		{"id": "reward_sieve", "title": "Reward Sieve", "description": "+1 XP from regular enemies", "category": "XP rewards", "shape": "Pentagonal prism sieve", "effects": {"enemy_xp_bonus_add": 1}},
		{"id": "warden_cache", "title": "Rail Cache", "description": "+6 Sector boss bonus XP", "category": "mini-boss reward", "shape": "Dodecahedron cache", "effects": {"mini_boss_reward_bonus_add": 6}}
	].duplicate(true)


static func sector_reward_pool() -> Array:
	return [
		{"id": "sector_overclock_core", "title": "Overclock Core", "description": "Weapons hit +16%, fire +10% faster", "category": "damage route", "shape": "Prism overclock core", "effects": {"damage_multiplier_add": 0.16, "fire_rate_multiplier_add": 0.10}},
		{"id": "sector_rebuild_cell", "title": "Rebuild Cell", "description": "+24 max health, restore 70 health", "category": "survival route", "shape": "Cuboid rebuild cell", "effects": {"max_health_add": 24.0, "heal_add": 70.0}},
		{"id": "sector_magnet_geometry", "title": "Magnet Geometry", "description": "+1.45 pickup range, stronger XP pull", "category": "collection route", "shape": "Annulus field lattice", "effects": {"pickup_radius_add": 1.45, "xp_pull_speed_add": 2.60}},
		{"id": "sector_prism_splitter", "title": "Prism Splitter", "description": "+1 Pulse shot, Prism Lance +18%", "category": "pierce route", "shape": "Split triangular prism", "effects": {"projectile_count_add": 1, "prism_lance_damage_multiplier_add": 0.18}},
		{"id": "sector_fracture_saw", "title": "Fracture Saw", "description": "Ring Saw +16% spin, +2 Hex shards", "category": "crowd route", "shape": "Hex saw annulus", "effects": {"ring_saw_spin_add": 0.16, "hex_shatter_split_add": 2}},
		{"id": "sector_null_buffer", "title": "Null Buffer", "description": "+18 max health, heal 32, wider Mine", "category": "defense route", "shape": "Octagon buffer shell", "effects": {"max_health_add": 18.0, "heal_add": 32.0, "mine_radius_add": 0.60}},
		{"id": "sector_cache_sieve", "title": "Cache Sieve", "description": "Enemies +1 XP, bosses release +10 XP", "category": "economy route", "shape": "Pentagonal cache gate", "effects": {"enemy_xp_bonus_add": 1, "mini_boss_reward_bonus_add": 10}}
	].duplicate(true)


static func _sector_definitions() -> Array:
	return [
		{
			"name": "Neon Grid",
			"intro_wave": "GRID IGNITION",
			"pressure_wave": "PRISM PRESSURE",
			"peak_wave": "GRID OVERDRIVE",
			"warning_wave": "RAIL BUTCHER WARNING",
			"boss_wave": "GRIX THE RAIL BUTCHER",
			"boss_type": "mini_boss",
			"boss_name": "GRIX THE RAIL BUTCHER",
			"warning_time": 54.0,
			"boss_time": 72.0,
			"transition_message": "PRISM RIFT VECTOR OPEN",
			"clear_condition": "Defeat Grix the Rail Butcher",
			"boss_trim_keep": 18,
			"spawn_profile": [1.06, 0.88, 0.80, 0.88, 1.08, 0.82],
			"spawn_extra_chance": [0.04, 0.16, 0.22, 0.20, 0.04, 0.18],
			"surge_extra_chance": 0.0,
			"enemy_mixes": _sector_1_enemy_mixes()
		},
		{
			"name": "Prism Rift",
			"intro_wave": "RIFT ENTRY",
			"pressure_wave": "HEX FRACTURE",
			"peak_wave": "SPLIT-SHARD PRESSURE",
			"warning_wave": "PRISM WIDOW WARNING",
			"boss_wave": "VEYRAXIS, PRISM WIDOW",
			"boss_type": "fractal_crown",
			"boss_name": "VEYRAXIS, PRISM WIDOW",
			"warning_time": 66.0,
			"boss_time": 90.0,
			"transition_message": "EMBER CIRCUIT GATE UNSEALED",
			"clear_condition": "Defeat Veyraxis, Prism Widow",
			"boss_trim_keep": 16,
			"spawn_profile": [0.88, 0.68, 0.62, 0.70, 0.98, 0.64],
			"spawn_extra_chance": [0.12, 0.32, 0.42, 0.36, 0.10, 0.36],
			"surge_extra_chance": 0.0,
			"enemy_mixes": _sector_2_enemy_mixes()
		},
		{
			"name": "Ember Circuit",
			"intro_wave": "EMBER CIRCUIT ENTRY",
			"pressure_wave": "COBALT FACTORY PRESSURE",
			"peak_wave": "MOLTEN MEMORY SURGE",
			"warning_wave": "COBALT HEX WARNING",
			"boss_wave": "LORD COBALT HEX",
			"boss_type": "null_octagon",
			"boss_name": "LORD COBALT HEX",
			"warning_time": 72.0,
			"boss_time": 98.0,
			"transition_message": "HYPER GRID VECTOR CHARGED",
			"clear_condition": "Defeat Lord Cobalt Hex",
			"boss_trim_keep": 14,
			"spawn_profile": [0.84, 0.66, 0.60, 0.70, 0.96, 0.60],
			"spawn_extra_chance": [0.14, 0.38, 0.50, 0.40, 0.12, 0.44],
			"surge_extra_chance": 0.12,
			"enemy_mixes": _sector_3_enemy_mixes()
		},
		{
			"name": "Hyper Grid",
			"intro_wave": "HYPER GRID ENTRY",
			"pressure_wave": "RAIL PRESSURE",
			"peak_wave": "OVERCLOCK SWARM",
			"warning_wave": "HOLLOW WARDEN WARNING",
			"boss_wave": "THE HOLLOW WARDEN",
			"boss_type": "final_null_octagon",
			"boss_name": "THE HOLLOW WARDEN",
			"warning_time": 64.0,
			"boss_time": 88.0,
			"transition_message": "RUN COMPLETE VECTOR",
			"clear_condition": "Defeat The Hollow Warden",
			"boss_trim_keep": 12,
			"spawn_profile": [0.72, 0.56, 0.51, 0.62, 0.92, 0.53],
			"spawn_extra_chance": [0.18, 0.36, 0.46, 0.34, 0.14, 0.40],
			"surge_extra_chance": 0.08,
			"enemy_mixes": _sector_4_enemy_mixes()
		}
	]


static func _sector_1_enemy_mixes() -> Array:
	return [
		[{"type": "chaser", "weight": 0.62}, {"type": "tank", "weight": 0.20}, {"type": "spiral_drifter", "weight": 0.18}],
		[{"type": "chaser", "weight": 0.39}, {"type": "tank", "weight": 0.19}, {"type": "shooter", "weight": 0.13}, {"type": "spiral_drifter", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.08}, {"type": "triad_splitter", "weight": 0.06}],
		[{"type": "chaser", "weight": 0.29}, {"type": "tank", "weight": 0.16}, {"type": "shooter", "weight": 0.15}, {"type": "spiral_drifter", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.11}, {"type": "shield_node", "weight": 0.06}, {"type": "triad_splitter", "weight": 0.08}],
		[{"type": "chaser", "weight": 0.29}, {"type": "tank", "weight": 0.16}, {"type": "shooter", "weight": 0.15}, {"type": "spiral_drifter", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.11}, {"type": "shield_node", "weight": 0.06}, {"type": "triad_splitter", "weight": 0.08}],
		[{"type": "chaser", "weight": 0.27}, {"type": "tank", "weight": 0.14}, {"type": "shooter", "weight": 0.15}, {"type": "spiral_drifter", "weight": 0.13}, {"type": "hex_slicer", "weight": 0.11}, {"type": "shield_node", "weight": 0.08}, {"type": "triad_splitter", "weight": 0.08}, {"type": "exploder", "weight": 0.04}],
		[{"type": "chaser", "weight": 0.27}, {"type": "tank", "weight": 0.14}, {"type": "shooter", "weight": 0.15}, {"type": "spiral_drifter", "weight": 0.13}, {"type": "hex_slicer", "weight": 0.11}, {"type": "shield_node", "weight": 0.08}, {"type": "triad_splitter", "weight": 0.08}, {"type": "exploder", "weight": 0.04}]
	]


static func _sector_2_enemy_mixes() -> Array:
	return [
		[{"type": "chaser", "weight": 0.18}, {"type": "hex_slicer", "weight": 0.22}, {"type": "spiral_drifter", "weight": 0.17}, {"type": "shooter", "weight": 0.14}, {"type": "tank", "weight": 0.08}, {"type": "prism_leech", "weight": 0.08}, {"type": "triad_splitter", "weight": 0.08}, {"type": "hex_pulser", "weight": 0.05}],
		[{"type": "hex_slicer", "weight": 0.21}, {"type": "prism_leech", "weight": 0.16}, {"type": "shooter", "weight": 0.15}, {"type": "spiral_drifter", "weight": 0.13}, {"type": "shield_node", "weight": 0.10}, {"type": "hex_pulser", "weight": 0.11}, {"type": "triad_splitter", "weight": 0.08}, {"type": "tank", "weight": 0.04}, {"type": "exploder", "weight": 0.02}],
		[{"type": "hex_slicer", "weight": 0.20}, {"type": "prism_leech", "weight": 0.17}, {"type": "shield_node", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.14}, {"type": "triad_splitter", "weight": 0.10}, {"type": "shooter", "weight": 0.11}, {"type": "spiral_drifter", "weight": 0.08}, {"type": "exploder", "weight": 0.05}, {"type": "tank", "weight": 0.02}],
		[{"type": "hex_slicer", "weight": 0.20}, {"type": "prism_leech", "weight": 0.17}, {"type": "shield_node", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.14}, {"type": "triad_splitter", "weight": 0.10}, {"type": "shooter", "weight": 0.11}, {"type": "spiral_drifter", "weight": 0.08}, {"type": "exploder", "weight": 0.05}, {"type": "tank", "weight": 0.02}],
		[{"type": "hex_slicer", "weight": 0.18}, {"type": "prism_leech", "weight": 0.16}, {"type": "shield_node", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.14}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.10}, {"type": "shooter", "weight": 0.10}, {"type": "spiral_drifter", "weight": 0.06}, {"type": "tank", "weight": 0.02}],
		[{"type": "hex_slicer", "weight": 0.18}, {"type": "prism_leech", "weight": 0.16}, {"type": "shield_node", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.14}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.10}, {"type": "shooter", "weight": 0.10}, {"type": "spiral_drifter", "weight": 0.06}, {"type": "tank", "weight": 0.02}]
	]


static func _sector_3_enemy_mixes() -> Array:
	return [
		[{"type": "hex_slicer", "weight": 0.18}, {"type": "prism_leech", "weight": 0.14}, {"type": "shield_node", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.13}, {"type": "triad_splitter", "weight": 0.11}, {"type": "shooter", "weight": 0.10}, {"type": "spiral_drifter", "weight": 0.06}, {"type": "exploder", "weight": 0.07}, {"type": "rail_skimmer", "weight": 0.04}, {"type": "grid_splitter", "weight": 0.02}, {"type": "tank", "weight": 0.02}],
		[{"type": "prism_leech", "weight": 0.16}, {"type": "hex_slicer", "weight": 0.18}, {"type": "shield_node", "weight": 0.15}, {"type": "hex_pulser", "weight": 0.14}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.08}, {"type": "shooter", "weight": 0.07}, {"type": "spiral_drifter", "weight": 0.03}, {"type": "rail_skimmer", "weight": 0.05}, {"type": "grid_splitter", "weight": 0.03}],
		[{"type": "prism_leech", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.17}, {"type": "shield_node", "weight": 0.15}, {"type": "hex_pulser", "weight": 0.15}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.10}, {"type": "shooter", "weight": 0.06}, {"type": "spiral_drifter", "weight": 0.01}, {"type": "rail_skimmer", "weight": 0.06}, {"type": "grid_splitter", "weight": 0.04}],
		[{"type": "prism_leech", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.17}, {"type": "shield_node", "weight": 0.15}, {"type": "hex_pulser", "weight": 0.16}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.09}, {"type": "shooter", "weight": 0.06}, {"type": "spiral_drifter", "weight": 0.01}, {"type": "rail_skimmer", "weight": 0.06}, {"type": "grid_splitter", "weight": 0.04}],
		[{"type": "prism_leech", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.18}, {"type": "shield_node", "weight": 0.15}, {"type": "hex_pulser", "weight": 0.16}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.10}, {"type": "shooter", "weight": 0.06}, {"type": "spiral_drifter", "weight": 0.02}, {"type": "rail_skimmer", "weight": 0.04}, {"type": "grid_splitter", "weight": 0.03}],
		[{"type": "prism_leech", "weight": 0.15}, {"type": "hex_slicer", "weight": 0.17}, {"type": "shield_node", "weight": 0.15}, {"type": "hex_pulser", "weight": 0.15}, {"type": "triad_splitter", "weight": 0.11}, {"type": "exploder", "weight": 0.10}, {"type": "shooter", "weight": 0.06}, {"type": "spiral_drifter", "weight": 0.02}, {"type": "rail_skimmer", "weight": 0.05}, {"type": "grid_splitter", "weight": 0.04}]
	]


static func _sector_4_enemy_mixes() -> Array:
	return [
		[{"type": "rail_skimmer", "weight": 0.24}, {"type": "grid_splitter", "weight": 0.16}, {"type": "hex_slicer", "weight": 0.16}, {"type": "spiral_drifter", "weight": 0.12}, {"type": "hex_pulser", "weight": 0.10}, {"type": "shield_node", "weight": 0.08}, {"type": "shooter", "weight": 0.06}, {"type": "triad_splitter", "weight": 0.05}, {"type": "prism_leech", "weight": 0.03}],
		[{"type": "rail_skimmer", "weight": 0.26}, {"type": "grid_splitter", "weight": 0.18}, {"type": "hex_slicer", "weight": 0.15}, {"type": "hex_pulser", "weight": 0.12}, {"type": "shield_node", "weight": 0.10}, {"type": "triad_splitter", "weight": 0.08}, {"type": "spiral_drifter", "weight": 0.06}, {"type": "prism_leech", "weight": 0.05}],
		[{"type": "rail_skimmer", "weight": 0.30}, {"type": "grid_splitter", "weight": 0.20}, {"type": "hex_slicer", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.13}, {"type": "shield_node", "weight": 0.10}, {"type": "prism_leech", "weight": 0.06}, {"type": "triad_splitter", "weight": 0.05}, {"type": "exploder", "weight": 0.03}],
		[{"type": "rail_skimmer", "weight": 0.32}, {"type": "grid_splitter", "weight": 0.19}, {"type": "hex_slicer", "weight": 0.13}, {"type": "hex_pulser", "weight": 0.12}, {"type": "shield_node", "weight": 0.10}, {"type": "prism_leech", "weight": 0.06}, {"type": "triad_splitter", "weight": 0.05}, {"type": "exploder", "weight": 0.03}],
		[{"type": "rail_skimmer", "weight": 0.24}, {"type": "grid_splitter", "weight": 0.16}, {"type": "hex_slicer", "weight": 0.17}, {"type": "hex_pulser", "weight": 0.15}, {"type": "shield_node", "weight": 0.12}, {"type": "triad_splitter", "weight": 0.07}, {"type": "prism_leech", "weight": 0.05}, {"type": "exploder", "weight": 0.04}],
		[{"type": "rail_skimmer", "weight": 0.26}, {"type": "grid_splitter", "weight": 0.18}, {"type": "hex_slicer", "weight": 0.16}, {"type": "hex_pulser", "weight": 0.14}, {"type": "shield_node", "weight": 0.12}, {"type": "triad_splitter", "weight": 0.06}, {"type": "prism_leech", "weight": 0.05}, {"type": "exploder", "weight": 0.03}]
	]
