extends RefCounted


static func rarity_order() -> Array:
	return ["Common", "Uncommon", "Rare", "Epic", "Legendary", "Anomaly"]


static func rarity_tiers() -> Dictionary:
	return {
		"Common": {"weight": 44.0, "roll_min": 1, "roll_max": 1, "strength": 0.65, "modifier_chance": 0.00, "modifier_min": 0, "modifier_max": 0, "accent": "7EEBFF", "power": 1.0},
		"Uncommon": {"weight": 28.0, "roll_min": 1, "roll_max": 2, "strength": 0.82, "modifier_chance": 0.14, "modifier_min": 0, "modifier_max": 1, "accent": "45FF9A", "power": 1.12},
		"Rare": {"weight": 16.0, "roll_min": 2, "roll_max": 2, "strength": 1.00, "modifier_chance": 0.34, "modifier_min": 0, "modifier_max": 1, "accent": "36A7FF", "power": 1.28},
		"Epic": {"weight": 8.0, "roll_min": 2, "roll_max": 3, "strength": 1.16, "modifier_chance": 0.62, "modifier_min": 1, "modifier_max": 2, "accent": "D756FF", "power": 1.52},
		"Legendary": {"weight": 3.0, "roll_min": 3, "roll_max": 3, "strength": 1.32, "modifier_chance": 0.86, "modifier_min": 1, "modifier_max": 2, "accent": "FFE45C", "power": 1.82},
		"Anomaly": {"weight": 1.0, "roll_min": 3, "roll_max": 4, "strength": 1.42, "modifier_chance": 1.00, "modifier_min": 2, "modifier_max": 3, "accent": "FF6A28", "power": 2.10}
	}


static func default_loadout_ids() -> Array:
	return [
		"pulse_blaster",
		"orbit_spark",
		"nova_burst",
		"arc_beam",
		"gravity_mine",
		"prism_lance",
		"ring_saw",
		"hex_shatter"
	]


static func content_pack_1_ids() -> Array:
	return [
		"tri_burst_cannon",
		"hex_mortar",
		"vector_spear",
		"orbital_saw_array",
		"prism_chain",
		"gravity_well",
		"nova_needle",
		"fractal_bloom",
		"shield_breaker",
		"star_pulse"
	]


static func weapon_definitions() -> Dictionary:
	return {
		"pulse_blaster": {
			"name": "Pulse Blaster",
			"family": "Pulse Blaster",
			"archetype": "Rapid projectile",
			"shape": "Cyan capsule bolt",
			"base_stats": {"damage": 27.0, "cooldown": 0.30, "projectiles": 1, "speed": 23.0, "lifetime": 1.25},
			"stat_pool": _projectile_stat_pool(true, false, false),
			"modifier_pool": _standard_modifier_pool()
		},
		"orbit_spark": {
			"name": "Orbit Spark",
			"family": "Orbit Spark",
			"archetype": "Orbit contact",
			"shape": "Sphere plus annulus path",
			"base_stats": {"damage": 16.0, "cooldown": 0.16, "orbits": 1, "radius": 2.35},
			"stat_pool": _orbit_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"nova_burst": {
			"name": "Nova Burst",
			"family": "Nova Burst",
			"archetype": "Area pulse",
			"shape": "Expanding torus shockwave",
			"base_stats": {"damage": 46.0, "cooldown": 8.5, "radius": 6.2},
			"stat_pool": _area_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"arc_beam": {
			"name": "Arc Beam",
			"family": "Arc Beam",
			"archetype": "Chain beam",
			"shape": "Cyan tube chain",
			"base_stats": {"damage": 32.0, "cooldown": 1.35, "chains": 3, "range": 8.2},
			"stat_pool": _chain_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"gravity_mine": {
			"name": "Gravity Mine",
			"family": "Gravity Mine",
			"archetype": "Placed gravity field",
			"shape": "Torus gravity well",
			"base_stats": {"damage": 42.0, "cooldown": 4.8, "radius": 4.1, "lifetime": 2.55},
			"stat_pool": _area_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"prism_lance": {
			"name": "Prism Lance",
			"family": "Prism Lance",
			"archetype": "Piercing projectile",
			"shape": "Violet lance tube",
			"base_stats": {"damage": 64.0, "cooldown": 2.05, "pierce": 4, "speed": 29.0, "lifetime": 1.08},
			"stat_pool": _projectile_stat_pool(false, true, false),
			"modifier_pool": _standard_modifier_pool()
		},
		"ring_saw": {
			"name": "Ring Saw",
			"family": "Ring Saw",
			"archetype": "Persistent orbit blade",
			"shape": "Large torus blade",
			"base_stats": {"damage": 11.0, "cooldown": 0.24, "radius": 3.22, "spin": 15.5},
			"stat_pool": _area_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"hex_shatter": {
			"name": "Hex Shatter",
			"family": "Hex Shatter",
			"archetype": "Split projectile",
			"shape": "Hex prism shard",
			"base_stats": {"damage": 44.0, "cooldown": 2.60, "splits": 5, "speed": 20.5, "lifetime": 1.18},
			"stat_pool": _projectile_stat_pool(false, false, true),
			"modifier_pool": _standard_modifier_pool()
		},
		"fractal_shard": {
			"name": "Fractal Shard",
			"family": "Fractal Shard",
			"archetype": "Heavy split projectile",
			"shape": "Dark diamond shard",
			"base_stats": {"damage": 58.0, "cooldown": 3.10, "splits": 5, "speed": 18.8, "lifetime": 1.32},
			"stat_pool": _projectile_stat_pool(false, true, true),
			"modifier_pool": _standard_modifier_pool()
		},
		"tri_burst_cannon": {
			"name": "Tri-Burst Cannon",
			"family": "Tri-Burst Cannon",
			"archetype": "Spread projectile",
			"shape": "Three triangular neon bolts",
			"base_stats": {"damage": 24.0, "cooldown": 0.82, "projectiles": 3, "speed": 22.5, "lifetime": 1.02},
			"stat_pool": _projectile_stat_pool(true, false, false),
			"modifier_pool": _standard_modifier_pool()
		},
		"hex_mortar": {
			"name": "Hex Mortar",
			"family": "Hex Mortar",
			"archetype": "Arcing burst shell",
			"shape": "Hexagon shell and shard fan",
			"base_stats": {"damage": 42.0, "cooldown": 2.85, "splits": 6, "speed": 13.4, "lifetime": 1.18},
			"stat_pool": _projectile_stat_pool(false, false, true),
			"modifier_pool": _standard_modifier_pool()
		},
		"vector_spear": {
			"name": "Vector Spear",
			"family": "Vector Spear",
			"archetype": "Rail pierce projectile",
			"shape": "Arrow rail line",
			"base_stats": {"damage": 54.0, "cooldown": 1.72, "pierce": 3, "speed": 31.0, "lifetime": 1.12},
			"stat_pool": _projectile_stat_pool(false, true, false),
			"modifier_pool": _standard_modifier_pool()
		},
		"orbital_saw_array": {
			"name": "Orbital Saw Array",
			"family": "Orbital Saw Array",
			"archetype": "Rotating orbit blades",
			"shape": "Rotating ring blades",
			"base_stats": {"damage": 13.0, "cooldown": 0.34, "orbits": 3, "radius": 3.45},
			"stat_pool": _orbit_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"prism_chain": {
			"name": "Prism Chain",
			"family": "Prism Chain",
			"archetype": "Segmented chain beam",
			"shape": "Angular prism links",
			"base_stats": {"damage": 28.0, "cooldown": 1.62, "chains": 4, "range": 8.8},
			"stat_pool": _chain_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"gravity_well": {
			"name": "Gravity Well",
			"family": "Gravity Well",
			"archetype": "Singularity pull field",
			"shape": "Ring and void circle",
			"base_stats": {"damage": 38.0, "cooldown": 5.35, "radius": 4.45, "lifetime": 2.35},
			"stat_pool": _area_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		},
		"nova_needle": {
			"name": "Nova Needle",
			"family": "Nova Needle",
			"archetype": "Rapid needle projectile",
			"shape": "Thin diamond needle",
			"base_stats": {"damage": 15.0, "cooldown": 0.18, "projectiles": 1, "speed": 33.0, "lifetime": 0.82},
			"stat_pool": _projectile_stat_pool(true, false, false),
			"modifier_pool": _standard_modifier_pool()
		},
		"fractal_bloom": {
			"name": "Fractal Bloom",
			"family": "Fractal Bloom",
			"archetype": "Controlled split bloom",
			"shape": "Fractal triangle bloom",
			"base_stats": {"damage": 48.0, "cooldown": 3.45, "splits": 6, "speed": 16.6, "lifetime": 1.26},
			"stat_pool": _projectile_stat_pool(false, false, true),
			"modifier_pool": _standard_modifier_pool()
		},
		"shield_breaker": {
			"name": "Shield Breaker",
			"family": "Shield Breaker",
			"archetype": "Heavy armor pierce",
			"shape": "Square diamond hammer shard",
			"base_stats": {"damage": 82.0, "cooldown": 2.40, "pierce": 2, "speed": 19.2, "lifetime": 1.24},
			"stat_pool": _projectile_stat_pool(false, true, false),
			"modifier_pool": _standard_modifier_pool()
		},
		"star_pulse": {
			"name": "Star Pulse",
			"family": "Star Pulse",
			"archetype": "Timed radial starburst",
			"shape": "Star polygon pulse",
			"base_stats": {"damage": 34.0, "cooldown": 4.65, "radius": 5.25},
			"stat_pool": _area_stat_pool(),
			"modifier_pool": _standard_modifier_pool()
		}
	}.duplicate(true)


static func has_definition(definition_id: String) -> bool:
	return weapon_definitions().has(definition_id)


static func weapon_definition(definition_id: String) -> Dictionary:
	var definitions := weapon_definitions()
	if definitions.has(definition_id):
		return definitions[definition_id].duplicate(true)
	return {}


static func default_weapon_instance(definition_id: String, instance_id: String) -> Dictionary:
	var definition := weapon_definition(definition_id)
	return {
		"instance_id": instance_id,
		"definition_id": definition_id,
		"name": str(definition.get("name", definition_id.capitalize())),
		"family": str(definition.get("family", definition_id.capitalize())),
		"archetype": str(definition.get("archetype", "Weapon")),
		"shape": str(definition.get("shape", "Weapon geometry")),
		"rarity": "Common",
		"seed": 0,
		"stat_rolls": [],
		"modifier_rolls": [],
		"source": "baseline",
		"equipped": true,
		"favorite": false,
		"locked": false,
		"forge_power_rank": 0,
		"forge_power_stats": {},
		"forge_dust_spent": 0,
		"evolution_rank": 0,
		"evolution_stats": {},
		"fusion_history": [],
		"fusion_dust_spent": 0,
		"power_score": estimate_power({"rarity": "Common", "stat_rolls": [], "modifier_rolls": []})
	}


static func roll_weapon_instance(rng: RandomNumberGenerator, sector_index: int, instance_id: String) -> Dictionary:
	var definition_id := _pick_definition_id(rng, sector_index)
	var rarity := _pick_rarity(rng, sector_index)
	var seed := int(rng.randi())
	return generate_weapon_instance(definition_id, rarity, seed, instance_id, "sector_reward")


static func generate_weapon_instance(definition_id: String, rarity: String, seed: int, instance_id: String, source: String) -> Dictionary:
	var definition := weapon_definition(definition_id)
	if definition.is_empty():
		definition_id = "pulse_blaster"
		definition = weapon_definition(definition_id)
	var tiers := rarity_tiers()
	if not tiers.has(rarity):
		rarity = "Common"
	var rarity_data: Dictionary = tiers[rarity]
	var rng := RandomNumberGenerator.new()
	rng.seed = seed
	var stat_pool: Array = definition.get("stat_pool", []).duplicate(true)
	var roll_min := int(rarity_data.get("roll_min", 1))
	var roll_max := int(rarity_data.get("roll_max", roll_min))
	var roll_count := clampi(rng.randi_range(roll_min, roll_max), 1, 4)
	var strength := float(rarity_data.get("strength", 1.0))
	var stat_rolls: Array = []
	while stat_rolls.size() < roll_count and stat_pool.size() > 0:
		var index := rng.randi_range(0, stat_pool.size() - 1)
		var stat: Dictionary = stat_pool[index]
		stat_pool.remove_at(index)
		stat_rolls.append(_roll_stat(stat, strength, rng))
	var modifier_rolls: Array = []
	var modifier_pool: Array = definition.get("modifier_pool", [])
	if modifier_pool.size() > 0 and rng.randf() <= float(rarity_data.get("modifier_chance", 0.0)):
		var modifier_min := int(rarity_data.get("modifier_min", 0))
		var modifier_max := int(rarity_data.get("modifier_max", 1))
		var modifier_count := clampi(rng.randi_range(modifier_min, modifier_max), 0, 3)
		if modifier_count <= 0:
			modifier_count = 1
		while modifier_rolls.size() < modifier_count and modifier_pool.size() > 0:
			var modifier_index := rng.randi_range(0, modifier_pool.size() - 1)
			var modifier: Dictionary = modifier_pool[modifier_index]
			modifier_pool.remove_at(modifier_index)
			modifier_rolls.append(modifier.duplicate(true))
	var instance := {
		"instance_id": instance_id,
		"definition_id": definition_id,
		"name": str(definition.get("name", definition_id.capitalize())),
		"family": str(definition.get("family", definition_id.capitalize())),
		"archetype": str(definition.get("archetype", "Weapon")),
		"shape": str(definition.get("shape", "Weapon geometry")),
		"rarity": rarity,
		"seed": seed,
		"stat_rolls": stat_rolls,
		"modifier_rolls": modifier_rolls,
		"source": source,
		"equipped": false,
		"favorite": false,
		"locked": false,
		"forge_power_rank": 0,
		"forge_power_stats": {},
		"forge_dust_spent": 0,
		"evolution_rank": 0,
		"evolution_stats": {},
		"fusion_history": [],
		"fusion_dust_spent": 0
	}
	instance["power_score"] = estimate_power(instance)
	return instance


static func estimate_power(instance: Dictionary) -> float:
	var rarity := str(instance.get("rarity", "Common"))
	var rarity_data: Dictionary = rarity_tiers().get(rarity, rarity_tiers()["Common"])
	var power := float(rarity_data.get("power", 1.0))
	for roll in instance.get("stat_rolls", []):
		var stat: Dictionary = roll
		var value := float(stat.get("value", 0.0))
		var stat_id := str(stat.get("id", ""))
		if stat_id.ends_with("_bonus") or stat_id == "cooldown_reduction":
			power += value * 3.0
		else:
			power += value * 0.18
	for modifier in instance.get("modifier_rolls", []):
		power += float(Dictionary(modifier).get("power", 0.16))
	var forge_stats: Dictionary = instance.get("forge_power_stats", {})
	for key in forge_stats.keys():
		var value := float(forge_stats[key])
		if str(key).ends_with("_bonus") or str(key) == "cooldown_reduction":
			power += value * 2.2
		else:
			power += value * 0.14
	var evolution_stats: Dictionary = instance.get("evolution_stats", {})
	for key in evolution_stats.keys():
		var value := float(evolution_stats[key])
		if str(key).ends_with("_bonus") or str(key) == "cooldown_reduction":
			power += value * 2.4
		else:
			power += value * 0.16
	return snappedf(power, 0.01)


static func stat_totals(instance: Dictionary) -> Dictionary:
	var totals := {}
	for roll in instance.get("stat_rolls", []):
		var stat: Dictionary = roll
		var key := str(stat.get("id", ""))
		totals[key] = float(totals.get(key, 0.0)) + float(stat.get("value", 0.0))
	for modifier in instance.get("modifier_rolls", []):
		var modifier_dict: Dictionary = modifier
		var stats: Dictionary = modifier_dict.get("stats", {})
		for key in stats.keys():
			totals[str(key)] = float(totals.get(str(key), 0.0)) + float(stats[key])
	var forge_stats: Dictionary = instance.get("forge_power_stats", {})
	for key in forge_stats.keys():
		totals[str(key)] = float(totals.get(str(key), 0.0)) + float(forge_stats[key])
	var evolution_stats: Dictionary = instance.get("evolution_stats", {})
	for key in evolution_stats.keys():
		totals[str(key)] = float(totals.get(str(key), 0.0)) + float(evolution_stats[key])
	return totals


static func primary_modifier_text(instance: Dictionary) -> String:
	var modifiers: Array = instance.get("modifier_rolls", [])
	if modifiers.is_empty():
		var rolls: Array = instance.get("stat_rolls", [])
		if rolls.is_empty():
			return "Baseline calibration"
		var first: Dictionary = rolls[0]
		return "%s %s" % [first.get("label", "Stat"), format_stat(first)]
	var modifier: Dictionary = modifiers[0]
	return str(modifier.get("name", "Special modifier"))


static func comparison_data(candidate: Dictionary, current: Dictionary) -> Dictionary:
	var candidate_power := estimate_power(candidate)
	var current_power := estimate_power(current) if not current.is_empty() else 0.0
	var candidate_totals := stat_totals(candidate)
	var current_totals := stat_totals(current) if not current.is_empty() else {}
	var stat_deltas := {}
	for key in candidate_totals.keys():
		stat_deltas[str(key)] = float(candidate_totals[key]) - float(current_totals.get(str(key), 0.0))
	for key in current_totals.keys():
		if not stat_deltas.has(str(key)):
			stat_deltas[str(key)] = -float(current_totals[key])
	return {
		"candidate_power": candidate_power,
		"current_power": current_power,
		"power_delta": snappedf(candidate_power - current_power, 0.01),
		"stat_deltas": stat_deltas,
		"relation": "NEW" if current.is_empty() else "UP" if candidate_power >= current_power else "DOWN"
	}


static func format_stat(stat: Dictionary) -> String:
	var value := float(stat.get("value", 0.0))
	var format := str(stat.get("format", "percent"))
	match format:
		"int":
			return "+%d" % int(round(value))
		"seconds":
			return "+%.2fs" % value
		_:
			return "+%d%%" % int(round(value * 100.0))


static func rarity_accent_hex(rarity: String) -> String:
	var rarity_data: Dictionary = rarity_tiers().get(rarity, rarity_tiers()["Common"])
	return str(rarity_data.get("accent", "7EEBFF"))


static func _pick_definition_id(rng: RandomNumberGenerator, sector_index: int) -> String:
	var pool := default_loadout_ids().duplicate()
	for definition_id in ["tri_burst_cannon", "vector_spear", "nova_needle", "shield_breaker", "star_pulse"]:
		pool.append(definition_id)
	if sector_index >= 1:
		pool.append("fractal_shard")
		for definition_id in ["hex_mortar", "prism_chain", "orbital_saw_array", "fractal_bloom"]:
			pool.append(definition_id)
	if sector_index >= 2:
		pool.append("gravity_well")
	if pool.is_empty():
		return "pulse_blaster"
	return str(pool[rng.randi_range(0, pool.size() - 1)])


static func _pick_rarity(rng: RandomNumberGenerator, sector_index: int) -> String:
	var tiers := rarity_tiers()
	var total := 0.0
	var sector_bonus := clampf(float(sector_index) * 0.08, 0.0, 0.28)
	for rarity in rarity_order():
		var data: Dictionary = tiers[rarity]
		var weight := float(data["weight"])
		if rarity in ["Rare", "Epic", "Legendary", "Anomaly"]:
			weight *= 1.0 + sector_bonus
		total += weight
	var roll := rng.randf() * total
	var cursor := 0.0
	for rarity in rarity_order():
		var data: Dictionary = tiers[rarity]
		var weight := float(data["weight"])
		if rarity in ["Rare", "Epic", "Legendary", "Anomaly"]:
			weight *= 1.0 + sector_bonus
		cursor += weight
		if roll <= cursor:
			return rarity
	return "Common"


static func _roll_stat(stat: Dictionary, strength: float, rng: RandomNumberGenerator) -> Dictionary:
	var roll := stat.duplicate(true)
	var format := str(stat.get("format", "percent"))
	if format == "int":
		roll["value"] = int(clampi(rng.randi_range(int(stat.get("min", 1)), int(stat.get("max", 1))), 1, int(stat.get("cap", 2))))
	else:
		var min_value := float(stat.get("min", 0.02)) * strength
		var max_value := float(stat.get("max", 0.08)) * strength
		roll["value"] = snappedf(clampf(rng.randf_range(min_value, max_value), 0.0, float(stat.get("cap", 0.22))), 0.001)
	return roll


static func _projectile_stat_pool(allow_projectile_count: bool, allow_pierce: bool, allow_split: bool) -> Array:
	var pool := [
		{"id": "damage_bonus", "label": "Damage", "min": 0.045, "max": 0.120, "cap": 0.18, "format": "percent"},
		{"id": "fire_rate_bonus", "label": "Fire Rate", "min": 0.035, "max": 0.095, "cap": 0.14, "format": "percent"},
		{"id": "cooldown_reduction", "label": "Cooldown", "min": 0.030, "max": 0.085, "cap": 0.13, "format": "percent"},
		{"id": "projectile_speed_bonus", "label": "Shot Speed", "min": 0.035, "max": 0.110, "cap": 0.16, "format": "percent"},
		{"id": "lifetime_bonus", "label": "Lifetime", "min": 0.035, "max": 0.100, "cap": 0.16, "format": "percent"}
	]
	if allow_projectile_count:
		pool.append({"id": "projectile_count_bonus", "label": "Projectiles", "min": 1, "max": 1, "cap": 1, "format": "int"})
	if allow_pierce:
		pool.append({"id": "pierce_bonus", "label": "Pierce", "min": 1, "max": 1, "cap": 1, "format": "int"})
	if allow_split:
		pool.append({"id": "split_count_bonus", "label": "Split Count", "min": 1, "max": 2, "cap": 2, "format": "int"})
	return pool


static func _orbit_stat_pool() -> Array:
	return [
		{"id": "damage_bonus", "label": "Damage", "min": 0.040, "max": 0.110, "cap": 0.18, "format": "percent"},
		{"id": "fire_rate_bonus", "label": "Pulse Rate", "min": 0.030, "max": 0.085, "cap": 0.13, "format": "percent"},
		{"id": "orbit_count_bonus", "label": "Orbit Count", "min": 1, "max": 1, "cap": 1, "format": "int"},
		{"id": "range_bonus", "label": "Orbit Radius", "min": 0.030, "max": 0.080, "cap": 0.12, "format": "percent"}
	]


static func _area_stat_pool() -> Array:
	return [
		{"id": "damage_bonus", "label": "Damage", "min": 0.040, "max": 0.115, "cap": 0.18, "format": "percent"},
		{"id": "cooldown_reduction", "label": "Cooldown", "min": 0.030, "max": 0.080, "cap": 0.12, "format": "percent"},
		{"id": "range_bonus", "label": "Area", "min": 0.030, "max": 0.085, "cap": 0.13, "format": "percent"},
		{"id": "lifetime_bonus", "label": "Lifetime", "min": 0.025, "max": 0.075, "cap": 0.11, "format": "percent"}
	]


static func _chain_stat_pool() -> Array:
	return [
		{"id": "damage_bonus", "label": "Damage", "min": 0.040, "max": 0.110, "cap": 0.18, "format": "percent"},
		{"id": "fire_rate_bonus", "label": "Fire Rate", "min": 0.030, "max": 0.080, "cap": 0.13, "format": "percent"},
		{"id": "range_bonus", "label": "Range", "min": 0.035, "max": 0.095, "cap": 0.14, "format": "percent"},
		{"id": "chain_count_bonus", "label": "Chain Count", "min": 1, "max": 1, "cap": 1, "format": "int"}
	]


static func _standard_modifier_pool() -> Array:
	return [
		{"id": "split_shot", "name": "Split Shot", "description": "+1 split/projectile geometry where supported", "stats": {"split_count_bonus": 1.0, "projectile_count_bonus": 1.0}, "power": 0.20},
		{"id": "piercing", "name": "Piercing", "description": "+1 pierce", "stats": {"pierce_bonus": 1.0}, "power": 0.18},
		{"id": "ricochet", "name": "Ricochet", "description": "+1 safe wall bounce where supported", "stats": {"ricochet_bonus": 1.0, "projectile_speed_bonus": 0.025}, "power": 0.17},
		{"id": "chain", "name": "Chain", "description": "+1 beam chain where supported", "stats": {"chain_count_bonus": 1.0, "range_bonus": 0.025}, "power": 0.18},
		{"id": "overclocked", "name": "Overclocked", "description": "+5% fire rate, -3% cooldown", "stats": {"fire_rate_bonus": 0.05, "cooldown_reduction": 0.03}, "power": 0.19},
		{"id": "heavy_core", "name": "Heavy Core", "description": "+8% damage, slower shot control", "stats": {"damage_bonus": 0.08, "projectile_speed_bonus": -0.025}, "power": 0.18},
		{"id": "lightweight", "name": "Lightweight", "description": "+8% shot speed, +3% rate", "stats": {"projectile_speed_bonus": 0.08, "fire_rate_bonus": 0.03}, "power": 0.16},
		{"id": "magnetized", "name": "Magnetized", "description": "+4% damage, +6% pickup pull", "stats": {"damage_bonus": 0.04, "pickup_bonus": 0.06}, "power": 0.15},
		{"id": "wide_pattern", "name": "Wide Pattern", "description": "+1 projectile/split, +3% range", "stats": {"projectile_count_bonus": 1.0, "split_count_bonus": 1.0, "range_bonus": 0.03}, "power": 0.20},
		{"id": "focused_beam", "name": "Focused Beam", "description": "+6% damage, +4% range", "stats": {"damage_bonus": 0.06, "range_bonus": 0.04}, "power": 0.18},
		{"id": "volatile", "name": "Volatile", "description": "+7% damage, +5% area", "stats": {"damage_bonus": 0.07, "range_bonus": 0.05}, "power": 0.20},
		{"id": "twin_orbit", "name": "Twin Orbit", "description": "+1 orbit where supported", "stats": {"orbit_count_bonus": 1.0}, "power": 0.18},
		{"id": "shard_bloom", "name": "Shard Bloom", "description": "+2 split shards", "stats": {"split_count_bonus": 2.0}, "power": 0.20},
		{"id": "critical_geometry", "name": "Critical Geometry", "description": "+7% damage, +3% rate", "stats": {"damage_bonus": 0.07, "fire_rate_bonus": 0.03}, "power": 0.20},
		{"id": "sector_tuned", "name": "Sector-Tuned", "description": "+4% damage, +4% range, +3% cooldown", "stats": {"damage_bonus": 0.04, "range_bonus": 0.04, "cooldown_reduction": 0.03}, "power": 0.18}
	]
