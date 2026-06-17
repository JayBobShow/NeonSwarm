extends Node3D

const InputMapConfig := preload("res://scripts/InputMapConfig.gd")
const ContentCatalog := preload("res://scripts/content/NeonContentCatalog.gd")
const WeaponCatalog := preload("res://scripts/content/NeonWeaponCatalog.gd")
const Kit := preload("res://scripts/visuals/Neon3DVisualKit.gd")
const NeonHudPanel := preload("res://scripts/ui/NeonHudPanel.gd")
const NeonSegmentGauge := preload("res://scripts/ui/NeonSegmentGauge.gd")
const NeonFramePanel := preload("res://scripts/ui/NeonFramePanel.gd")
const NeonStatChip := preload("res://scripts/ui/NeonStatChip.gd")
const NeonMenuButton := preload("res://scripts/ui/NeonMenuButton.gd")
const NeonSelectionCursor := preload("res://scripts/ui/NeonSelectionCursor.gd")
const NeonTitleVignette := preload("res://scripts/ui/NeonTitleVignette.gd")
const NeonWeaponIcon := preload("res://scripts/ui/NeonWeaponIcon.gd")
const COVER_ART := preload("res://art/branding/neonswarm_cover.png")

const PLAYER_SCENE := preload("res://scenes/visuals/Player3D.tscn")
const CHASER_SCENE := preload("res://scenes/visuals/Chaser3D.tscn")
const TANK_SCENE := preload("res://scenes/visuals/Tank3D.tscn")
const SHOOTER_SCENE := preload("res://scenes/visuals/Shooter3D.tscn")
const EXPLODER_SCENE := preload("res://scenes/visuals/Exploder3D.tscn")
const SPIRAL_DRIFTER_SCENE := preload("res://scenes/visuals/SpiralDrifter3D.tscn")
const SHIELD_NODE_SCENE := preload("res://scenes/visuals/ShieldNode3D.tscn")
const MINI_BOSS_SCENE := preload("res://scenes/visuals/MiniBoss3D.tscn")
const HEX_SLICER_SCENE := preload("res://scenes/visuals/HexSlicer3D.tscn")
const PRISM_LEECH_SCENE := preload("res://scenes/visuals/PrismLeech3D.tscn")
const NULL_OCTAGON_SCENE := preload("res://scenes/visuals/NullOctagon3D.tscn")
const PROJECTILE_SCENE := preload("res://scenes/visuals/Projectile3D.tscn")

const ARENA_HALF_SIZE := 28.0
const PLAYER_SPEED := 10.5
const PLAYER_ACCELERATION := 48.0
const PLAYER_DECELERATION := 60.0
const PLAYER_RADIUS := 0.72
const PLAYER_MAX_HEALTH := 100.0
const PLAYER_INVULN_TIME := 0.42
const SCREEN_SHAKE_MAX := 0.32
const SFX_PLAYER_CAP := 12
const MUSIC_MIX_RATE := 22050
const UI_RIGHT_STICK_SCROLL_SPEED := 720.0
const UI_RIGHT_STICK_STASH_DEADZONE := 0.34
const UI_RIGHT_STICK_STASH_FAST_THRESHOLD := 0.78
const UI_RIGHT_STICK_STASH_SLOW_REPEAT := 0.24
const UI_RIGHT_STICK_STASH_FAST_REPEAT := 0.075

const ENEMY_CAP := 54
const XP_CAP := 100
const PLAYER_PROJECTILE_CAP := 36
const ENEMY_PROJECTILE_CAP := 28
const BURST_CAP := 18
const BEAM_EFFECT_CAP := 8
const CHAIN_VFX_OUTER_RADIUS := 0.084
const CHAIN_VFX_CORE_RADIUS := 0.032
const CHAIN_VFX_TICK_RADIUS := 0.024
const CHAIN_VFX_LIFETIME := 0.26
const CHAIN_VFX_MAX_SEGMENT_LENGTH := 9.25
const CHAIN_VFX_ALPHA := 0.82
const CHAIN_VFX_CORE_ALPHA := 0.92
const CHAIN_VFX_OUTER_EMISSION := 5.8
const CHAIN_VFX_CORE_EMISSION := 6.9
const CHAIN_VFX_PRISM_EMISSION := 5.9
const BOSS_TELEGRAPH_CAP := 8
const MINE_CAP := 6
const HAZARD_TRAIL_CAP := 10
const ORBIT_VISUAL_CAP := 5
const DUST_COUNT := 64
const XP_TRAIL_VISUAL_CAP := 20
const PLAYER_PRESENTATION_RIPPLE_PERIOD := 0.92
const PLAYER_PRESENTATION_RIPPLE_RADIUS := 2.72
const PLAYER_PRESENTATION_RIPPLE_WAVE_SPEED := 1.08
const PLAYER_PRESENTATION_RIPPLE_WAVE_FREQUENCY := 5.35
const PLAYER_PRESENTATION_FLOOR_Y := 0.092
const PLAYER_SPOTLIGHT_HEIGHT := 11.2
const PLAYER_SPOTLIGHT_Z_OFFSET := 3.65
const PLAYER_SPOTLIGHT_BEAM_BOTTOM_RADIUS := 1.46
const PLAYER_SPOTLIGHT_BEAM_TOP_RADIUS := 0.18
const PLAYER_SPOTLIGHT_BEAM_SHEET_COUNT := 5
const PLAYER_SPOTLIGHT_BASE_ENERGY := 3.35

const PULSE_COOLDOWN := 0.30
const PULSE_DAMAGE := 27.0
const PULSE_SPEED := 23.0
const PULSE_LIFE := 1.25
const AUTO_TARGET_RANGE := 26.0
const ORBIT_COOLDOWN := 0.16
const ORBIT_DAMAGE := 16.0
const ORBIT_RADIUS := 2.35
const NOVA_COOLDOWN := 8.5
const NOVA_DAMAGE := 46.0
const NOVA_RADIUS := 6.2
const ARC_BEAM_COOLDOWN := 1.35
const ARC_BEAM_DAMAGE := 32.0
const ARC_BEAM_RANGE := 8.2
const GRAVITY_MINE_COOLDOWN := 4.8
const GRAVITY_MINE_DAMAGE := 42.0
const GRAVITY_MINE_RADIUS := 4.1
const GRAVITY_MINE_LIFE := 2.55
const GRAVITY_PULL_SPEED := 4.4
const PRISM_LANCE_COOLDOWN := 2.05
const PRISM_LANCE_DAMAGE := 64.0
const PRISM_LANCE_SPEED := 29.0
const PRISM_LANCE_LIFE := 1.08
const PRISM_LANCE_PIERCE := 4
const RING_SAW_COOLDOWN := 0.24
const RING_SAW_DAMAGE := 11.0
const RING_SAW_RADIUS := 3.22
const RING_SAW_WIDTH := 0.68
const RING_SAW_SPIN_SPEED := 15.5
const MINI_BOSS_WARNING_TIME := 75.0
const MINI_BOSS_SPAWN_TIME := 90.0
const MINI_BOSS_XP_BONUS := 18
const NULL_OCTAGON_WARNING_TIME := 214.0
const NULL_OCTAGON_SPAWN_TIME := 238.0
const NULL_OCTAGON_XP_BONUS := 34
const RUN_SUCCESS_TIME := 300.0
const SECTOR_COUNT := 4
const HEX_SHATTER_COOLDOWN := 2.60
const HEX_SHATTER_DAMAGE := 44.0
const HEX_SHATTER_SPEED := 20.5
const HEX_SHATTER_LIFE := 1.18
const HEX_SHATTER_SPLIT_DAMAGE := 20.0
const HEX_SHATTER_SPLIT_SPEED := 17.5
const HEX_SHATTER_SPLIT_LIFE := 0.58
const FRACTAL_SHARD_COOLDOWN := 3.10
const FRACTAL_SHARD_DAMAGE := 58.0
const FRACTAL_SHARD_SPEED := 18.8
const FRACTAL_SHARD_LIFE := 1.32
const FRACTAL_SHARD_SPLIT_DAMAGE := 18.0
const FRACTAL_SHARD_SPLIT_SPEED := 18.6
const FRACTAL_SHARD_SPLIT_LIFE := 0.62
const TRI_BURST_COOLDOWN := 0.82
const TRI_BURST_DAMAGE := 24.0
const TRI_BURST_SPEED := 22.5
const TRI_BURST_LIFE := 1.02
const HEX_MORTAR_COOLDOWN := 2.85
const HEX_MORTAR_DAMAGE := 42.0
const HEX_MORTAR_SPEED := 13.4
const HEX_MORTAR_LIFE := 1.18
const VECTOR_SPEAR_COOLDOWN := 1.72
const VECTOR_SPEAR_DAMAGE := 54.0
const VECTOR_SPEAR_SPEED := 31.0
const VECTOR_SPEAR_LIFE := 1.12
const ORBITAL_SAW_ARRAY_COOLDOWN := 0.34
const ORBITAL_SAW_ARRAY_DAMAGE := 13.0
const ORBITAL_SAW_ARRAY_RADIUS := 3.45
const PRISM_CHAIN_COOLDOWN := 1.62
const PRISM_CHAIN_DAMAGE := 28.0
const PRISM_CHAIN_RANGE := 8.8
const GRAVITY_WELL_COOLDOWN := 5.35
const GRAVITY_WELL_DAMAGE := 38.0
const GRAVITY_WELL_RADIUS := 4.45
const GRAVITY_WELL_LIFE := 2.35
const NOVA_NEEDLE_COOLDOWN := 0.18
const NOVA_NEEDLE_DAMAGE := 15.0
const NOVA_NEEDLE_SPEED := 33.0
const NOVA_NEEDLE_LIFE := 0.82
const FRACTAL_BLOOM_COOLDOWN := 3.45
const FRACTAL_BLOOM_DAMAGE := 48.0
const FRACTAL_BLOOM_SPEED := 16.6
const FRACTAL_BLOOM_LIFE := 1.26
const SHIELD_BREAKER_COOLDOWN := 2.40
const SHIELD_BREAKER_DAMAGE := 82.0
const SHIELD_BREAKER_SPEED := 19.2
const SHIELD_BREAKER_LIFE := 1.24
const STAR_PULSE_COOLDOWN := 4.65
const STAR_PULSE_DAMAGE := 34.0
const STAR_PULSE_RADIUS := 5.25

const XP_ATTRACT_RADIUS := 6.25
const XP_COLLECT_RADIUS := 1.35
const XP_PULL_SPEED := 14.0
const XP_PULSE_SPEED := 4.2
const XP_PULSE_MIN := 0.78
const XP_PULSE_MAX := 1.0
const HUD_DESIGN_SIZE := Vector2(1920.0, 1080.0)
const SETTINGS_PATH := "user://neon_swarm_settings.cfg"
const WEAPON_SAVE_PATH := "user://neon_swarm_weapon_inventory.cfg"
const VFX_INTENSITY_NAMES := ["LOW", "NORMAL", "HIGH"]
const TUTORIAL_HINT_KEYS := ["armory", "xp", "weapons", "sectors", "weapon_loot"]
const EQUIPPED_WEAPON_SLOT_CAP := 8
const STASH_WEAPON_CAP := 48
const NEON_DUST_RARITY_VALUES := {
	"Common": 8,
	"Uncommon": 16,
	"Rare": 30,
	"Epic": 55,
	"Legendary": 95,
	"Anomaly": 150
}
const NEON_DUST_SECTOR_CLEAR_BASE := 10
const NEON_DUST_SECTOR_CLEAR_STEP := 4
const NEON_DUST_RUN_COMPLETE_BONUS := 70
const NEON_DUST_DEATH_KILL_DIVISOR := 32
const FORGE_POWER_MAX_RANK := 5
const FORGE_POWER_BASE_COST := 20
const FORGE_POWER_COST_STEP := 18
const FORGE_STAT_REROLL_BASE_COST := 24
const FORGE_MODIFIER_REROLL_BASE_COST := 42
const FORGE_RARITY_COST_MULTIPLIERS := {
	"Common": 1.0,
	"Uncommon": 1.25,
	"Rare": 1.65,
	"Epic": 2.15,
	"Legendary": 3.0,
	"Anomaly": 4.0
}
const FORGE_POWER_STAT_STEP := {
	"damage_bonus": 0.012,
	"cooldown_reduction": 0.004,
	"range_bonus": 0.004
}
const EVOLUTION_MAX_RANK := 3
const EVOLUTION_BASE_COST := 60
const EVOLUTION_COST_STEP := 42
const EVOLUTION_STAT_STEP := {
	"damage_bonus": 0.018,
	"cooldown_reduction": 0.006,
	"range_bonus": 0.006,
	"lifetime_bonus": 0.004
}
const RUN_EVENT_START_DELAY := [24.0, 22.0, 20.0, 18.0]
const RUN_EVENT_COOLDOWN := [48.0, 42.0, 36.0, 32.0]
const RUN_EVENT_MAX_PER_SECTOR := [1, 2, 2, 2]
const RUN_EVENT_BOSS_BUFFER := 18.0
const RUN_EVENT_CACHE_HOLD_TIME := 4.0
const RUN_EVENT_CACHE_DURATION := 18.0
const RUN_EVENT_RIFT_WARNING_TIME := 2.4
const RUN_EVENT_RIFT_DURATION := 14.0
const RUN_EVENT_ELITE_HUNT_DURATION := 23.0
const RUN_EVENT_SHRINE_ARM_DURATION := 20.0
const RUN_EVENT_SHRINE_TRIGGER_TIME := 1.35
const RUN_EVENT_SHRINE_OVERLOAD_DURATION := 11.0
const RUN_EVENT_INTERACTION_RADIUS := 4.1
const RUN_EVENT_AUTO_REWARD_POSITION := Vector3(99999.0, 99999.0, 99999.0)
const RUN_EVENT_TEST_TYPES := ["data_cache", "rift_surge", "elite_hunt", "overload_shrine"]
const WAVE_DIRECTOR_ELITE_MIN_TIME := [38.0, 28.0, 22.0, 18.0]
const WAVE_DIRECTOR_ELITE_COOLDOWN := [18.0, 15.0, 13.0, 11.0]
const WAVE_DIRECTOR_MAX_ELITES := [1, 2, 2, 3]
const WAVE_DIRECTOR_ELITE_CHANCES := [
	[0.0, 0.015, 0.030, 0.040, 0.0, 0.030],
	[0.0, 0.035, 0.060, 0.070, 0.0, 0.055],
	[0.0, 0.050, 0.080, 0.090, 0.0, 0.070],
	[0.0, 0.060, 0.100, 0.110, 0.0, 0.085]
]

var _materials: Dictionary = {}
var _gameplay_root: Node3D
var _fx_root: Node3D
var _camera: Camera3D
var _camera_base_position := Vector3.ZERO
var _shake_time := 0.0
var _shake_duration := 0.0
var _shake_strength := 0.0
var _player_area: Area3D
var _player_visual: Node3D
var _player_velocity := Vector3.ZERO
var _player_health := PLAYER_MAX_HEALTH
var _player_max_health := PLAYER_MAX_HEALTH
var _player_invuln := 0.0
var _player_level := 1
var _player_xp := 0
var _xp_required := 10
var _damage_multiplier := 1.0
var _fire_rate_multiplier := 1.0
var _projectile_count_bonus := 0
var _pickup_radius_bonus := 0.0
var _speed_bonus := 0.0
var _orbit_count := 1
var _nova_cooldown_multiplier := 1.0
var _beam_duration_bonus := 0.0
var _mine_radius_bonus := 0.0
var _prism_lance_damage_multiplier := 1.0
var _prism_lance_pierce_bonus := 0
var _ring_saw_radius_bonus := 0.0
var _ring_saw_spin_bonus := 0.0
var _hex_shatter_damage_multiplier := 1.0
var _hex_shatter_cooldown_multiplier := 1.0
var _hex_shatter_split_bonus := 0
var _fractal_shard_enabled := false
var _fractal_shard_damage_multiplier := 1.0
var _fractal_shard_cooldown_multiplier := 1.0
var _fractal_shard_split_bonus := 0
var _fractal_shard_life_bonus := 0.0
var _fractal_shard_pierce_bonus := 0
var _xp_pull_speed_bonus := 0.0
var _enemy_xp_reward_bonus := 0
var _mini_boss_reward_bonus := 0

var _enemies: Array[Dictionary] = []
var _player_projectiles: Array[Dictionary] = []
var _enemy_projectiles: Array[Dictionary] = []
var _xp_orbs: Array[Dictionary] = []
var _bursts: Array[Dictionary] = []
var _beam_effects: Array[Dictionary] = []
var _boss_telegraphs: Array[Dictionary] = []
var _mines: Array[Dictionary] = []
var _hazard_trails: Array[Dictionary] = []
var _orbit_visual_root: Node3D
var _orbit_nodes: Array[Node3D] = []
var _ring_saw_root: Node3D
var _dust_batch: MultiMeshInstance3D
var _dust_data: Array[Dictionary] = []
var _player_presentation_root: Node3D
var _player_spotlight: SpotLight3D
var _player_spotlight_beam_sheets: Array[MeshInstance3D] = []
var _player_spotlight_beam_material: ShaderMaterial
var _player_ripple_root: Node3D
var _player_propulsion_ripple: MeshInstance3D
var _player_propulsion_ripple_material: ShaderMaterial
var _player_ripple_time := 0.0
var _weapon_state: Dictionary = {}
var _equipped_weapon_instances: Array[Dictionary] = []
var _stash_weapon_instances: Array[Dictionary] = []
var _discovered_weapon_families: Array[String] = []
var _weapon_family_stat_bonuses: Dictionary = {}
var _weapon_instance_counter := 0
var _neon_dust := 0
var _core_upgrade_ranks: Dictionary = {}
var _core_max_health_bonus := 0.0
var _core_pickup_radius_bonus := 0.0
var _core_damage_multiplier := 1.0
var _core_cooldown_multiplier := 1.0
var _weapon_loot_rng := RandomNumberGenerator.new()
var _run_event_rng := RandomNumberGenerator.new()
var _upgrade_pool: Array[Dictionary] = []
var _upgrade_rng := RandomNumberGenerator.new()
var _sfx: Dictionary = {}
var _sfx_volume_db: Dictionary = {}
var _sfx_players: Array[AudioStreamPlayer] = []
var _sfx_player_index := 0
var _sfx_cooldowns: Dictionary = {}
var _music_streams: Dictionary = {}
var _music_stings: Dictionary = {}
var _music_player: AudioStreamPlayer
var _music_sting_player: AudioStreamPlayer
var _music_state := "none"
var _audio_muted := false
var _master_volume := 1.0
var _sfx_volume := 1.0
var _music_volume := 0.85
var _screen_shake_enabled := true
var _vfx_intensity := 1
var _fullscreen_enabled := false

var _survival_time := 0.0
var _sector_index := 0
var _sector_elapsed := 0.0
var _sector_boss_spawned := false
var _sector_boss_active := false
var _sector_boss_warning_played := false
var _sector_reward_active := false
var _sector_transition_cleanup_pending := false
var _sector_transition_message := "NEON GRID ONLINE"
var _spawn_timer := 0.0
var _wave_index := 0
var _wave_name := "IGNITION"
var _wave_director_elite_cooldown := 0.0
var _elite_notice_timer := 0.0
var _run_event_active := false
var _run_event_type := ""
var _run_event_stage := ""
var _run_event_timer := 0.0
var _run_event_duration := 0.0
var _run_event_cooldown := 16.0
var _run_event_sector_count := 0
var _run_event_progress := 0.0
var _run_event_notice_step := -1
var _run_event_spawn_timer := 0.0
var _run_event_hazard_timer := 0.0
var _run_event_node: Node3D
var _run_event_target_node: Node3D
var _run_event_target_instance_id := 0
var _enemy_instance_counter := 0
var _run_event_test_enabled := false
var _run_event_test_selected_index := 0
var _run_event_test_panel: Control
var _run_event_test_label: Label
var _run_event_objective_panel: Control
var _run_event_objective_label: Label
var _mini_boss_spawned := false
var _mini_boss_active := false
var _mini_boss_warning_played := false
var _null_octagon_spawned := false
var _null_octagon_active := false
var _null_octagon_warning_played := false
var _null_octagon_warning_start := -1.0
var _null_octagon_defeated := false
var _kills := 0
var _score := 0
var _run_neon_dust_gained := 0
var _run_weapons_gained := 0
var _run_economy_finalized := false
var _game_over := false
var _run_success := false
var _manual_pause := false
var _pause_options_visible := false
var _pause_menu_selected_index := 0
var _pause_options_selected_index := 0
var _pause_nav_cooldown := 0.0
var _armory_visible := false
var _armory_selected_section := "equipped"
var _armory_equipped_selected_index := 0
var _armory_stash_selected_index := 0
var _armory_action_mode := "browse"
var _armory_action_selected_index := 0
var _armory_nav_cooldown := 0.0
var _armory_status_text := "SELECT STORED WEAPON TO COMPARE"
var _armory_stash_rs_repeat_timer := 0.0
var _armory_stash_rs_last_direction := 0
var _armory_forge_pending_action := ""
var _armory_forge_pending_cost := 0
var _armory_forge_preview_instance: Dictionary = {}
var _armory_fusion_primary_section := ""
var _armory_fusion_primary_index := -1
var _armory_fusion_primary_instance: Dictionary = {}
var _armory_fusion_material_index := -1
var _armory_fusion_material_instance: Dictionary = {}
var _help_scroll_focus := "body"
var _title_menu_active := true
var _title_menu_nav_cooldown := 0.0
var _title_menu_selected_index := 0
var _title_options_visible := false
var _title_options_selected_index := 0
var _core_upgrades_visible := false
var _core_upgrade_selected_index := 0
var _core_upgrade_confirm_pending_id := ""
var _core_upgrade_nav_cooldown := 0.0
var _core_upgrade_status_text := "SELECT CORE UPGRADE"
var _help_visible := false
var _help_context := "title"
var _help_selected_index := 0
var _help_nav_cooldown := 0.0
var _level_up_active := false
var _level_nav_cooldown := 0.0
var _upgrade_choices: Array[Dictionary] = []
var _upgrade_selected_index := 0
var _weapon_reward_decision_active := false
var _weapon_reward_mode := "actions"
var _weapon_reward_was_sector_reward := false
var _weapon_reward_pending_upgrade: Dictionary = {}
var _weapon_reward_pending_instance: Dictionary = {}
var _weapon_reward_action_selected_index := 0
var _weapon_reward_slot_selected_index := 0
var _weapon_reward_status_text := "CHOOSE A LOOT ROUTE"
var _weapon_reward_last_result_text := ""
var _tutorial_hints_seen: Dictionary = {}
var _tutorial_prompt_queue: Array[String] = []
var _tutorial_prompt_key := ""
var _tutorial_prompt_timer := 0.0
var _tutorial_prompt_duration := 4.2
var _stress_logged := false

var _hud_layer: CanvasLayer
var _hud_root: Control
var _hud_design_root: Control
var _last_viewport_size := Vector2.ZERO
var _gameplay_hud_root: Control
var _arena_root: Node3D
var _grid_minor_instance: MeshInstance3D
var _grid_major_instance: MeshInstance3D
var _grid_axis_instance: MeshInstance3D
var _arena_border_instance: MeshInstance3D
var _arena_border_core_instance: MeshInstance3D
var _sector_background_root: Node3D
var _sector_geometry_root: Node3D
var _sector_transition_root: Node3D
var _sector_hd_background_plate: MeshInstance3D
var _sector_hd_background_material: StandardMaterial3D
var _sector_motion_nodes: Array[Dictionary] = []
var _sector_flow_lines: Array[Dictionary] = []
var _sector_pulse_nodes: Array[Dictionary] = []
var _sector_sweep_nodes: Array[Dictionary] = []
var _sector_transition_nodes: Array[Dictionary] = []
var _sector_transition_timer := 0.0
var _sector_transition_duration := 0.82
var _sector_background_reaction := 0.0
var _sector_background_reaction_decay := 0.0
var _blender_asset_scene_cache: Dictionary = {}
var _world_environment: WorldEnvironment
var _world_environment_data: Environment
var _health_bar
var _xp_bar
var _health_text_label: Label
var _xp_text_label: Label
var _timer_label: Label
var _sector_label: Label
var _kills_label: Label
var _score_label: Label
var _audio_label: Label
var _level_label: Label
var _enemy_label: Label
var _boss_label: Label
var _boss_bar
var _boss_panel: Control
var _combat_notice_panel: Control
var _combat_notice_label: Label
var _pause_panel: Control
var _pause_options_panel: Control
var _pause_options_label: Label
var _pause_menu_buttons: Array[Button] = []
var _pause_options_buttons: Array[Button] = []
var _pause_selection_cursor: Control
var _game_over_panel: Control
var _success_panel: Control
var _game_over_summary_label: Label
var _success_summary_label: Label
var _level_up_panel: PanelContainer
var _level_up_title: Label
var _level_up_prompt: Label
var _upgrade_buttons: Array[Button] = []
var _upgrade_choice_icons: Array[Control] = []
var _weapon_reward_panel: PanelContainer
var _weapon_reward_title: Label
var _weapon_reward_prompt: Label
var _weapon_reward_detail_label: Label
var _weapon_reward_compare_label: Label
var _weapon_reward_preview_icon: Control
var _weapon_reward_compare_current_icon: Control
var _weapon_reward_compare_candidate_icon: Control
var _weapon_reward_status_label: Label
var _weapon_reward_action_row: Control
var _weapon_reward_slot_grid: Control
var _weapon_reward_action_buttons: Array[Button] = []
var _weapon_reward_slot_buttons: Array[Button] = []
var _weapon_reward_slot_icons: Array[Control] = []
var _weapon_reward_selection_cursor: Control
var _title_menu_panel: Control
var _title_modal_scrim: ColorRect
var _title_options_panel: Control
var _title_options_label: Label
var _title_menu_buttons: Array[Button] = []
var _title_options_buttons: Array[Button] = []
var _title_selection_cursor: Control
var _core_upgrades_panel: Control
var _core_upgrade_buttons: Array[Button] = []
var _core_upgrade_dust_label: Label
var _core_upgrade_status_label: Label
var _core_upgrade_selection_cursor: Control
var _help_panel: Control
var _help_modal_scrim: ColorRect
var _help_title_label: Label
var _help_prompt_label: Label
var _help_body_label: Label
var _help_icon_row: Control
var _help_tab_scroll: ScrollContainer
var _help_body_scroll: ScrollContainer
var _help_icon_scroll: ScrollContainer
var _help_example_icons: Array[Control] = []
var _help_buttons: Array[Button] = []
var _help_selection_cursor: Control
var _armory_panel: Control
var _armory_equipped_scroll: ScrollContainer
var _armory_stash_scroll: ScrollContainer
var _armory_detail_scroll: ScrollContainer
var _armory_compare_scroll: ScrollContainer
var _armory_equipped_buttons: Array[Button] = []
var _armory_stash_buttons: Array[Button] = []
var _armory_equipped_icons: Array[Control] = []
var _armory_stash_icons: Array[Control] = []
var _armory_selection_cursor: Control
var _armory_detail_label: Label
var _armory_compare_label: Label
var _armory_preview_icon: Control
var _armory_compare_current_icon: Control
var _armory_compare_candidate_icon: Control
var _armory_status_label: Label
var _armory_help_label: Label
var _armory_dust_label: Label
var _armory_equipped_title_label: Label
var _armory_stash_title_label: Label
var _armory_action_row: HBoxContainer
var _armory_action_buttons: Array[Button] = []
var _weapon_reward_detail_scroll: ScrollContainer
var _weapon_reward_compare_scroll: ScrollContainer
var _weapon_reward_slot_scroll: ScrollContainer
var _tutorial_prompt_panel: Control
var _tutorial_prompt_title_label: Label
var _tutorial_prompt_body_label: Label
var _loadout_chips: Dictionary = {}
var _presentation_flash: ColorRect
var _presentation_flash_color := Color(0.0, 0.94, 1.0, 0.0)
var _presentation_flash_alpha := 0.0
var _presentation_flash_decay := 0.0


func _ready() -> void:
	name = "Official3DNeonSwarmBuild"
	process_mode = Node.PROCESS_MODE_ALWAYS
	InputMapConfig.ensure_actions()
	_upgrade_rng.randomize()
	_weapon_loot_rng.randomize()
	_run_event_rng.randomize()
	_load_settings()
	_initialize_weapon_framework()
	_initialize_weapon_inventory()
	_initialize_upgrade_pool()
	_create_audio_foundation()
	_create_materials()
	_setup_world_environment()
	_create_camera()
	_create_gameplay_root()
	_create_arena()
	_create_atmosphere()
	_create_player()
	_create_player_presentation_effects()
	_create_orbit_visuals()
	_create_ring_saw_visual()
	_create_hud()
	_apply_sector_visual_identity()
	for i in range(8):
		_spawn_enemy(_enemy_type_for_sector_phase(0, 0), _spawn_position_on_edge())
	_update_hud()
	_enter_title_menu()
	print("Neon Swarm active development build ready: version=0.17.0-dev sector=%s enemies=%d xp=%d player_projectiles=%d enemy_projectiles=%d visual_scene_assets=14 music_states=%d" % [_current_sector_name(), _enemies.size(), _xp_orbs.size(), _player_projectiles.size(), _enemy_projectiles.size(), _music_streams.size()])


func _exit_tree() -> void:
	for player in _sfx_players.duplicate():
		if is_instance_valid(player):
			player.stop()
			player.stream = null
			if player.get_parent():
				player.get_parent().remove_child(player)
			player.free()
	_sfx_players.clear()
	_sfx.clear()
	_sfx_cooldowns.clear()
	for player in [_music_player, _music_sting_player]:
		if is_instance_valid(player):
			player.stop()
			player.stream = null
			if player.get_parent():
				player.get_parent().remove_child(player)
			player.free()
	_music_streams.clear()
	_music_stings.clear()
	var bus_index := AudioServer.get_bus_index("Master")
	if bus_index >= 0:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, 0.0)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mute_audio"):
		_toggle_audio_mute()
		get_viewport().set_input_as_handled()
		return
	if _handle_run_event_test_input(event):
		return
	if _help_visible:
		_handle_help_input(event)
		return
	if _title_menu_active:
		_handle_title_menu_input(event)
		return
	if _game_over or _run_success:
		if event.is_action_pressed("confirm") or _is_start_button_event(event):
			_restart_run()
			get_viewport().set_input_as_handled()
		return
	if _weapon_reward_decision_active:
		_handle_weapon_reward_decision_input(event)
		return
	if _level_up_active:
		_handle_level_up_input(event)
		return
	if _manual_pause:
		_handle_pause_menu_input(event)
		return
	if event.is_action_pressed("pause"):
		_toggle_pause()


func _handle_run_event_test_input(event: InputEvent) -> bool:
	if not event is InputEventKey:
		return false
	var key_event := event as InputEventKey
	if not key_event.pressed or key_event.echo:
		return false
	match key_event.keycode:
		KEY_F6:
			if not _run_event_test_input_allowed():
				return false
			_toggle_run_event_test_mode()
		KEY_F7:
			if not _run_event_test_enabled or not _run_event_test_input_allowed():
				return false
			_cycle_run_event_test_selection()
		KEY_F8:
			if not _run_event_test_enabled or not _run_event_test_input_allowed():
				return false
			_force_spawn_selected_run_event_test()
		KEY_F9:
			if not _run_event_test_enabled or not _run_event_test_input_allowed():
				return false
			_clear_run_event_test_spawn()
		KEY_F10:
			if not _run_event_test_enabled or not _run_event_test_input_allowed():
				return false
			_jump_to_sector4_test_state()
		_:
			return false
	get_viewport().set_input_as_handled()
	return true


func _run_event_test_input_allowed() -> bool:
	if not _run_event_gameplay_allowed():
		return false
	if _title_options_visible or _help_visible or _armory_visible or _core_upgrades_visible:
		return false
	if _pause_options_visible:
		return false
	return true


func _toggle_run_event_test_mode() -> void:
	_run_event_test_enabled = not _run_event_test_enabled
	_show_combat_notice("EVENT TEST MODE %s" % ("ON" if _run_event_test_enabled else "OFF"), Color(1.0, 0.94, 0.18), 1.10)
	_update_run_event_test_hud()


func _cycle_run_event_test_selection() -> void:
	_run_event_test_selected_index = wrapi(_run_event_test_selected_index + 1, 0, RUN_EVENT_TEST_TYPES.size())
	_show_combat_notice("EVENT TEST SELECT // %s" % _run_event_display_name(_run_event_test_selected_type()).to_upper(), Color(0.0, 0.96, 1.0), 1.05)
	_update_run_event_test_hud()


func _force_spawn_selected_run_event_test() -> void:
	if _run_event_blocked_by_boss():
		_show_combat_notice("EVENT TEST BLOCKED // BOSS WINDOW ACTIVE", Color(1.0, 0.58, 0.04), 1.20)
		return
	if _run_event_active:
		_clear_run_event_state()
	_run_event_cooldown = 0.0
	var event_type := _run_event_test_selected_type()
	_start_run_event(event_type)
	_show_combat_notice("EVENT TEST SPAWN // %s" % _run_event_display_name(event_type).to_upper(), _run_event_notice_color(event_type), 1.20)
	_update_run_event_test_hud()


func _clear_run_event_test_spawn() -> void:
	if _run_event_active:
		_clear_run_event_state(true)
		_run_event_cooldown = 0.0
	else:
		_show_combat_notice("EVENT TEST CLEAR // NO ACTIVE EVENT", Color(0.82, 0.96, 1.0), 0.95)
	_update_run_event_test_hud()


func _jump_to_sector4_test_state() -> void:
	_clear_transition_combat_state()
	for i in range(_enemies.size() - 1, -1, -1):
		var enemy := _enemies[i]
		var node: Node3D = enemy.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
		_enemies.remove_at(i)
	_sector_index = SECTOR_COUNT - 1
	_sector_elapsed = 0.0
	_sector_boss_spawned = false
	_sector_boss_active = false
	_sector_boss_warning_played = false
	_mini_boss_spawned = false
	_mini_boss_active = false
	_mini_boss_warning_played = false
	_null_octagon_spawned = false
	_null_octagon_active = false
	_null_octagon_warning_played = false
	_null_octagon_warning_start = -1.0
	_wave_index = 0
	_wave_name = str(_current_sector()["intro_wave"])
	_spawn_timer = 0.35
	_player_invuln = maxf(_player_invuln, 1.10)
	_reset_run_event_director_for_sector()
	_apply_sector_visual_identity()
	_trigger_sector_transition_scan()
	_spawn_sector_opening_wave()
	_update_hud()
	_set_music_state("gameplay")
	_show_combat_notice("EVENT TEST MODE // SECTOR 4 HYPER GRID", Color(0.72, 0.96, 1.0), 1.50)
	_update_run_event_test_hud()


func _run_event_test_selected_type() -> String:
	if RUN_EVENT_TEST_TYPES.is_empty():
		return "data_cache"
	return str(RUN_EVENT_TEST_TYPES[clampi(_run_event_test_selected_index, 0, RUN_EVENT_TEST_TYPES.size() - 1)])


func _update_run_event_test_hud() -> void:
	if not is_instance_valid(_run_event_test_panel) or not is_instance_valid(_run_event_test_label):
		return
	var visible := _run_event_test_enabled and _run_event_test_input_allowed()
	_run_event_test_panel.visible = visible
	if not visible:
		return
	var active_text := "NONE"
	if _run_event_active:
		active_text = "%s // %s // %.0fs" % [_run_event_display_name(_run_event_type).to_upper(), _run_event_stage.to_upper(), _run_event_timer]
	_run_event_test_label.text = "EVENT TEST MODE  //  SELECTED: %s\nF7 CYCLE  |  F8 SPAWN  |  F9 CLEAR  |  F10 S4  //  ACTIVE: %s" % [
		_run_event_display_name(_run_event_test_selected_type()).to_upper(),
		active_text
	]
	var frame := _run_event_test_panel as NeonFramePanel
	if frame:
		frame.accent_primary = Color(1.0, 0.94, 0.18, 0.90)
		frame.accent_secondary = _run_event_notice_color(_run_event_test_selected_type())
		frame.animated = true
		frame.queue_redraw()


func _update_run_event_objective_panel() -> void:
	if not is_instance_valid(_run_event_objective_panel) or not is_instance_valid(_run_event_objective_label):
		return
	var blocked_ui := _title_menu_active or _manual_pause or _game_over or _run_success or _weapon_reward_decision_active or _level_up_active
	if blocked_ui or not _run_event_active:
		_run_event_objective_panel.visible = false
		return
	var color := _run_event_notice_color(_run_event_type)
	_run_event_objective_panel.visible = true
	_run_event_objective_label.text = _run_event_objective_text()
	_run_event_objective_label.add_theme_color_override("font_color", color)
	var frame := _run_event_objective_panel as NeonFramePanel
	if frame:
		frame.accent_primary = color
		frame.accent_secondary = Color(1.0, 0.94, 0.18, 0.72)
		frame.animated = true
		frame.queue_redraw()


func _run_event_objective_text() -> String:
	match _run_event_type:
		"data_cache":
			return _data_cache_objective_text()
		"rift_surge":
			return _rift_surge_objective_text()
		"elite_hunt":
			return _elite_hunt_objective_text()
		"overload_shrine":
			return _overload_node_objective_text()
		_:
			return "OBJECTIVE ACTIVE\nFOLLOW THE MARKER\nTIME LEFT: %.0f" % _run_event_timer


func _data_cache_objective_text() -> String:
	var required_hold := _data_cache_required_hold_time()
	var progress := int(round(clampf(_run_event_progress / required_hold, 0.0, 1.0) * 100.0))
	var near_cache := is_instance_valid(_run_event_node) and _xz_distance(_player_area.position, _run_event_node.position) <= RUN_EVENT_INTERACTION_RADIUS
	var title := "HYPER DATA CACHE" if _sector_index >= 3 else "DATA CACHE FOUND"
	if near_cache:
		return "%s\nSTAND INSIDE THE RING TO SYNC\nSYNCING: %d%%  //  FAILS IN: %.0f" % [title, progress, _run_event_timer]
	return "%s\nSTAND INSIDE THE RING TO SYNC\nRETURN TO THE CACHE RING  //  FAILS IN: %.0f" % [title, _run_event_timer]


func _data_cache_required_hold_time() -> float:
	return RUN_EVENT_CACHE_HOLD_TIME * (0.82 if _sector_index >= 3 else 1.0)


func _rift_surge_objective_text() -> String:
	var elapsed := RUN_EVENT_RIFT_DURATION - _run_event_timer
	if _run_event_stage == "warning":
		var countdown := maxf(0.0, RUN_EVENT_RIFT_WARNING_TIME - elapsed)
		return "RIFT SURGE WARNING\nLEAVE THE RED RIFT ZONE\nSURGE IN: %.1f" % countdown
	return "RIFT SURGE ACTIVE\nDODGE THE PULSES\nTIME LEFT: %.0f" % _run_event_timer


func _elite_hunt_objective_text() -> String:
	return "ELITE HUNT\nDESTROY THE MARKED TARGET\nTIME LEFT: %.0f" % _run_event_timer


func _overload_node_objective_text() -> String:
	if _run_event_stage == "armed":
		var progress := int(round(clampf(_run_event_progress / RUN_EVENT_SHRINE_TRIGGER_TIME, 0.0, 1.0) * 100.0))
		var near_node := is_instance_valid(_run_event_node) and _xz_distance(_player_area.position, _run_event_node.position) <= RUN_EVENT_INTERACTION_RADIUS
		if near_node:
			return "OVERLOAD STARTED\nSURVIVE UNTIL THE NODE DISCHARGES\nPRESSURE BUILDING: %d%%" % progress
		return "OVERLOAD NODE\nOPTIONAL: ENTER THE RING TO START CHALLENGE\nEXPIRES IN: %.0f" % _run_event_timer
	return "OVERLOAD ACTIVE: SURVIVE\nSURVIVE UNTIL THE NODE DISCHARGES\nTIME LEFT: %.0f" % _run_event_timer


func _process(delta: float) -> void:
	_update_sfx_cooldowns(delta)
	_sync_hud_design_scale()
	_update_presentation_flash(delta)
	_update_tutorial_prompt(delta)
	_update_combat_notice(delta)
	_update_run_event_objective_panel()
	_update_run_event_test_hud()
	_update_music_state()
	_update_sector_transition_effect(delta)
	_update_right_stick_ui_scroll(delta)
	_sync_player_presentation_visibility()
	if _title_menu_active:
		_title_menu_nav_cooldown = maxf(0.0, _title_menu_nav_cooldown - delta)
		if _help_visible:
			_help_nav_cooldown = maxf(0.0, _help_nav_cooldown - delta)
			_update_help_cursor_position(false)
		elif _armory_visible:
			_armory_nav_cooldown = maxf(0.0, _armory_nav_cooldown - delta)
			_update_armory_cursor_position(false)
		elif _core_upgrades_visible:
			_core_upgrade_nav_cooldown = maxf(0.0, _core_upgrade_nav_cooldown - delta)
			_update_core_upgrade_cursor_position(false)
		else:
			_update_title_cursor_position(false)
		return
	if get_tree().paused:
		if _manual_pause:
			_pause_nav_cooldown = maxf(0.0, _pause_nav_cooldown - delta)
			if _help_visible:
				_help_nav_cooldown = maxf(0.0, _help_nav_cooldown - delta)
				_update_help_cursor_position(false)
			else:
				_update_pause_cursor_position(false)
		if _sector_transition_cleanup_pending:
			_sector_transition_cleanup_pending = false
			_clear_transition_combat_state()
			_update_hud()
		if _level_up_active:
			_level_nav_cooldown = maxf(0.0, _level_nav_cooldown - delta)
			if _weapon_reward_decision_active:
				_update_weapon_reward_cursor_position(false)
		return
	if _game_over or _run_success:
		return

	_survival_time += delta
	_sector_elapsed += delta
	_player_invuln = maxf(0.0, _player_invuln - delta)
	_update_player(delta)
	_update_wave_director(delta)
	_update_run_event_director(delta)
	_update_weapons(delta)
	_update_enemies(delta)
	_update_boss_telegraphs(delta)
	_update_projectiles(delta)
	_update_mines(delta)
	_update_hazard_trails(delta)
	_update_beam_effects(delta)
	_update_xp_orbs(delta)
	_update_bursts(delta)
	_update_camera_shake(delta)
	_update_atmosphere()
	_update_sector_background_motion(delta)
	_update_hud()
	_check_run_goal()

	if not _stress_logged and _survival_time >= 12.0:
		_stress_logged = true
		print(get_review_build_summary())


func get_review_build_summary() -> String:
	return "Neon Swarm runtime summary: time=%.1f sector=%d:%s sector_time=%.1f wave=%s enemies=%d/%d xp=%d/%d player_projectiles=%d/%d enemy_projectiles=%d/%d mines=%d/%d beams=%d/%d bursts=%d/%d kills=%d score=%d sector_boss_active=%s" % [
		_survival_time,
		_sector_index + 1,
		_current_sector_name(),
		_sector_elapsed,
		_wave_name,
		_enemies.size(),
		ENEMY_CAP,
		_xp_orbs.size(),
		XP_CAP,
		_player_projectiles.size(),
		PLAYER_PROJECTILE_CAP,
		_enemy_projectiles.size(),
		ENEMY_PROJECTILE_CAP,
		_mines.size(),
		MINE_CAP,
		_beam_effects.size(),
		BEAM_EFFECT_CAP,
		_bursts.size(),
		BURST_CAP,
		_kills,
		_score,
		str(_sector_boss_active)
	]


func _initialize_weapon_framework() -> void:
	_weapon_state = {
		"pulse_blaster": {"timer": 0.18, "cooldown": PULSE_COOLDOWN, "enabled": false},
		"orbit_spark": {"timer": 0.0, "cooldown": ORBIT_COOLDOWN, "enabled": false, "angle": 0.0},
		"nova_burst": {"timer": 3.25, "cooldown": NOVA_COOLDOWN, "enabled": false},
		"arc_beam": {"timer": 1.05, "cooldown": ARC_BEAM_COOLDOWN, "enabled": false},
		"gravity_mine": {"timer": 2.10, "cooldown": GRAVITY_MINE_COOLDOWN, "enabled": false},
		"prism_lance": {"timer": 1.55, "cooldown": PRISM_LANCE_COOLDOWN, "enabled": false},
		"ring_saw": {"timer": 0.0, "cooldown": RING_SAW_COOLDOWN, "enabled": false, "angle": 0.0},
		"hex_shatter": {"timer": 1.80, "cooldown": HEX_SHATTER_COOLDOWN, "enabled": false},
		"fractal_shard": {"timer": 2.35, "cooldown": FRACTAL_SHARD_COOLDOWN, "enabled": false},
		"tri_burst_cannon": {"timer": 0.42, "cooldown": TRI_BURST_COOLDOWN, "enabled": false},
		"hex_mortar": {"timer": 1.35, "cooldown": HEX_MORTAR_COOLDOWN, "enabled": false},
		"vector_spear": {"timer": 0.90, "cooldown": VECTOR_SPEAR_COOLDOWN, "enabled": false},
		"orbital_saw_array": {"timer": 0.18, "cooldown": ORBITAL_SAW_ARRAY_COOLDOWN, "enabled": false, "angle": 0.0},
		"prism_chain": {"timer": 1.10, "cooldown": PRISM_CHAIN_COOLDOWN, "enabled": false},
		"gravity_well": {"timer": 2.20, "cooldown": GRAVITY_WELL_COOLDOWN, "enabled": false},
		"nova_needle": {"timer": 0.08, "cooldown": NOVA_NEEDLE_COOLDOWN, "enabled": false},
		"fractal_bloom": {"timer": 1.70, "cooldown": FRACTAL_BLOOM_COOLDOWN, "enabled": false},
		"shield_breaker": {"timer": 1.15, "cooldown": SHIELD_BREAKER_COOLDOWN, "enabled": false},
		"star_pulse": {"timer": 2.00, "cooldown": STAR_PULSE_COOLDOWN, "enabled": false}
	}


func _initialize_upgrade_pool() -> void:
	_upgrade_pool.clear()
	_upgrade_pool.assign(ContentCatalog.level_upgrade_pool())


func _initialize_weapon_inventory() -> void:
	if not _load_weapon_inventory():
		_neon_dust = 0
		_core_upgrade_ranks = _default_core_upgrade_ranks()
		_create_default_weapon_loadout()
		_save_weapon_inventory()
	_normalize_core_upgrade_ranks()
	_rebuild_weapon_stat_bonuses()
	_apply_core_upgrade_bonuses()


func _create_default_weapon_loadout() -> void:
	_equipped_weapon_instances.clear()
	_stash_weapon_instances.clear()
	_discovered_weapon_families.clear()
	_weapon_instance_counter = 0
	for definition_id in WeaponCatalog.default_loadout_ids():
		_weapon_instance_counter += 1
		var instance := WeaponCatalog.default_weapon_instance(str(definition_id), _next_weapon_instance_id())
		instance = _normalize_weapon_instance(instance, true)
		_equipped_weapon_instances.append(instance)
		_remember_discovered_weapon(instance)


func _load_weapon_inventory() -> bool:
	var config := ConfigFile.new()
	var error := config.load(WEAPON_SAVE_PATH)
	if error != OK:
		return false
	_neon_dust = maxi(0, int(config.get_value("economy", "neon_dust", 0)))
	_core_upgrade_ranks.clear()
	var loaded_upgrade_ranks = config.get_value("core_upgrades", "ranks", {})
	if loaded_upgrade_ranks is Dictionary:
		for upgrade_id in Dictionary(loaded_upgrade_ranks).keys():
			_core_upgrade_ranks[str(upgrade_id)] = maxi(0, int(Dictionary(loaded_upgrade_ranks)[upgrade_id]))
	_weapon_instance_counter = maxi(0, int(config.get_value("inventory", "instance_counter", 0)))
	_equipped_weapon_instances.clear()
	_stash_weapon_instances.clear()
	_discovered_weapon_families.clear()
	var loaded_equipped: Array = config.get_value("inventory", "equipped", [])
	var loaded_stash: Array = config.get_value("inventory", "stash", [])
	var loaded_discovered: Array = config.get_value("inventory", "discovered_families", [])
	for item in loaded_equipped:
		if item is Dictionary and WeaponCatalog.has_definition(str(Dictionary(item).get("definition_id", ""))):
			var instance := _normalize_weapon_instance(Dictionary(item).duplicate(true), true)
			_equipped_weapon_instances.append(instance)
			_remember_discovered_weapon(instance)
	for item in loaded_stash:
		if item is Dictionary and WeaponCatalog.has_definition(str(Dictionary(item).get("definition_id", ""))):
			var instance := _normalize_weapon_instance(Dictionary(item).duplicate(true), false)
			_stash_weapon_instances.append(instance)
			_remember_discovered_weapon(instance)
	for family in loaded_discovered:
		var family_name := str(family)
		if family_name != "" and not _discovered_weapon_families.has(family_name):
			_discovered_weapon_families.append(family_name)
	if _equipped_weapon_instances.is_empty():
		return false
	while _equipped_weapon_instances.size() > EQUIPPED_WEAPON_SLOT_CAP:
		_equipped_weapon_instances.pop_back()
	while _stash_weapon_instances.size() > STASH_WEAPON_CAP:
		_stash_weapon_instances.pop_back()
	return true


func _normalize_weapon_instance(instance: Dictionary, equipped: bool) -> Dictionary:
	if instance.is_empty():
		return {}
	var definition_id := str(instance.get("definition_id", ""))
	var definition := WeaponCatalog.weapon_definition(definition_id)
	if definition.is_empty():
		return {}
	instance["name"] = str(instance.get("name", definition.get("name", definition_id.capitalize())))
	instance["family"] = str(instance.get("family", definition.get("family", definition_id.capitalize())))
	instance["archetype"] = str(instance.get("archetype", definition.get("archetype", "Weapon")))
	instance["shape"] = str(instance.get("shape", definition.get("shape", "Weapon geometry")))
	instance["rarity"] = str(instance.get("rarity", "Common"))
	instance["stat_rolls"] = Array(instance.get("stat_rolls", [])).duplicate(true)
	instance["modifier_rolls"] = Array(instance.get("modifier_rolls", [])).duplicate(true)
	instance["forge_power_rank"] = clampi(int(instance.get("forge_power_rank", 0)), 0, FORGE_POWER_MAX_RANK)
	instance["forge_power_stats"] = Dictionary(instance.get("forge_power_stats", {})).duplicate(true)
	if int(instance["forge_power_rank"]) > 0 and Dictionary(instance["forge_power_stats"]).is_empty():
		instance["forge_power_stats"] = _forge_power_stats_for_rank(int(instance["forge_power_rank"]))
	instance["forge_dust_spent"] = maxi(0, int(instance.get("forge_dust_spent", 0)))
	instance["evolution_rank"] = clampi(int(instance.get("evolution_rank", 0)), 0, EVOLUTION_MAX_RANK)
	instance["evolution_stats"] = Dictionary(instance.get("evolution_stats", {})).duplicate(true)
	if int(instance["evolution_rank"]) > 0 and Dictionary(instance["evolution_stats"]).is_empty():
		instance["evolution_stats"] = _evolution_stats_for_rank(int(instance["evolution_rank"]))
	instance["fusion_history"] = Array(instance.get("fusion_history", [])).duplicate(true)
	instance["fusion_dust_spent"] = maxi(0, int(instance.get("fusion_dust_spent", 0)))
	instance["equipped"] = equipped
	instance["power_score"] = WeaponCatalog.estimate_power(instance)
	return instance


func _save_weapon_inventory() -> void:
	var config := ConfigFile.new()
	config.set_value("inventory", "schema_version", 3)
	config.set_value("inventory", "instance_counter", _weapon_instance_counter)
	config.set_value("inventory", "equipped", _equipped_weapon_instances)
	config.set_value("inventory", "stash", _stash_weapon_instances)
	config.set_value("inventory", "discovered_families", _discovered_weapon_families)
	config.set_value("economy", "neon_dust", _neon_dust)
	config.set_value("core_upgrades", "ranks", _core_upgrade_ranks)
	var error := config.save(WEAPON_SAVE_PATH)
	if error != OK:
		push_warning("Failed to save Neon Swarm weapon inventory. Error code: %d" % error)


func _core_upgrade_definitions() -> Array[Dictionary]:
	return [
		{
			"id": "core_vitality",
			"name": "CORE VITALITY",
			"summary": "+6 max health per rank",
			"base_cost": 40,
			"cost_step": 35,
			"max_rank": 5
		},
		{
			"id": "magnetic_field",
			"name": "MAGNETIC FIELD",
			"summary": "+0.35 XP pickup range per rank",
			"base_cost": 35,
			"cost_step": 30,
			"max_rank": 5
		},
		{
			"id": "weapon_tuning",
			"name": "WEAPON TUNING",
			"summary": "+2% global weapon damage per rank",
			"base_cost": 55,
			"cost_step": 45,
			"max_rank": 5
		},
		{
			"id": "coolant_flow",
			"name": "COOLANT FLOW",
			"summary": "-1.5% weapon cooldown per rank",
			"base_cost": 55,
			"cost_step": 45,
			"max_rank": 5
		}
	]


func _default_core_upgrade_ranks() -> Dictionary:
	var ranks := {}
	for definition in _core_upgrade_definitions():
		ranks[str(definition["id"])] = 0
	return ranks


func _normalize_core_upgrade_ranks() -> void:
	for definition in _core_upgrade_definitions():
		var upgrade_id := str(definition["id"])
		var max_rank := int(definition.get("max_rank", 5))
		_core_upgrade_ranks[upgrade_id] = clampi(int(_core_upgrade_ranks.get(upgrade_id, 0)), 0, max_rank)


func _core_upgrade_definition_for_id(upgrade_id: String) -> Dictionary:
	for definition in _core_upgrade_definitions():
		if str(definition["id"]) == upgrade_id:
			return definition
	return {}


func _core_upgrade_rank(upgrade_id: String) -> int:
	var definition := _core_upgrade_definition_for_id(upgrade_id)
	var max_rank := int(definition.get("max_rank", 5)) if not definition.is_empty() else 5
	return clampi(int(_core_upgrade_ranks.get(upgrade_id, 0)), 0, max_rank)


func _core_upgrade_cost(definition: Dictionary) -> int:
	var upgrade_id := str(definition.get("id", ""))
	var rank := _core_upgrade_rank(upgrade_id)
	var max_rank := int(definition.get("max_rank", 5))
	if rank >= max_rank:
		return 0
	return int(definition.get("base_cost", 40)) + rank * int(definition.get("cost_step", 30))


func _core_upgrade_effect_text(definition: Dictionary) -> String:
	var upgrade_id := str(definition.get("id", ""))
	var rank := _core_upgrade_rank(upgrade_id)
	match upgrade_id:
		"core_vitality":
			return "MAX HEALTH +%d" % int(rank * 6)
		"magnetic_field":
			return "PICKUP RANGE +%.2f" % (float(rank) * 0.35)
		"weapon_tuning":
			return "GLOBAL DAMAGE +%d%%" % int(round(float(rank) * 2.0))
		"coolant_flow":
			return "COOLDOWN -%d%%" % int(round(float(rank) * 1.5))
		_:
			return "NO ACTIVE EFFECT"


func _apply_core_upgrade_bonuses() -> void:
	var previous_max_health := _player_max_health
	_core_max_health_bonus = float(_core_upgrade_rank("core_vitality")) * 6.0
	_core_pickup_radius_bonus = float(_core_upgrade_rank("magnetic_field")) * 0.35
	_core_damage_multiplier = 1.0 + float(_core_upgrade_rank("weapon_tuning")) * 0.02
	_core_cooldown_multiplier = clampf(1.0 - float(_core_upgrade_rank("coolant_flow")) * 0.015, 0.90, 1.0)
	_player_max_health = PLAYER_MAX_HEALTH + _core_max_health_bonus
	if _title_menu_active or _player_health >= previous_max_health - 0.01:
		_player_health = _player_max_health
	else:
		_player_health = minf(_player_health, _player_max_health)
	_update_hud()


func _neon_dust_value_for_weapon(instance: Dictionary) -> int:
	var rarity := str(instance.get("rarity", "Common"))
	return int(NEON_DUST_RARITY_VALUES.get(rarity, NEON_DUST_RARITY_VALUES["Common"]))


func _grant_neon_dust(amount: int, count_for_run := false) -> void:
	if amount <= 0:
		return
	_neon_dust = maxi(0, _neon_dust + amount)
	if count_for_run:
		_run_neon_dust_gained += amount
	_save_weapon_inventory()
	_update_armory_ui()
	_update_core_upgrades_ui()


func _next_weapon_instance_id() -> String:
	return "W%05d" % _weapon_instance_counter


func _generate_weapon_instance_id() -> String:
	_weapon_instance_counter += 1
	return _next_weapon_instance_id()


func _remember_discovered_weapon(instance: Dictionary) -> void:
	var family := str(instance.get("family", instance.get("definition_id", "")))
	if family != "" and not _discovered_weapon_families.has(family):
		_discovered_weapon_families.append(family)


func _rebuild_weapon_stat_bonuses() -> void:
	_weapon_family_stat_bonuses.clear()
	var active_families := {}
	for instance in _equipped_weapon_instances:
		var definition_id := str(instance.get("definition_id", ""))
		if definition_id == "":
			continue
		active_families[definition_id] = true
		var totals: Dictionary = WeaponCatalog.stat_totals(instance)
		var current: Dictionary = _weapon_family_stat_bonuses.get(definition_id, {})
		for stat_id in totals.keys():
			current[str(stat_id)] = float(current.get(str(stat_id), 0.0)) + float(totals[stat_id])
		_weapon_family_stat_bonuses[definition_id] = current
		_remember_discovered_weapon(instance)
	for definition_id in _weapon_state.keys():
		var state: Dictionary = _weapon_state[definition_id]
		state["enabled"] = bool(active_families.get(definition_id, false))
		_weapon_state[definition_id] = state
	_fractal_shard_enabled = _is_weapon_family_equipped("fractal_shard")
	_update_orbit_visual_visibility()
	if is_instance_valid(_ring_saw_root):
		_ring_saw_root.visible = _is_weapon_family_equipped("ring_saw")


func _is_weapon_family_equipped(definition_id: String) -> bool:
	return _weapon_family_stat_bonuses.has(definition_id)


func _equipped_weapon_index_for_definition(definition_id: String) -> int:
	for i in range(_equipped_weapon_instances.size()):
		if str(_equipped_weapon_instances[i].get("definition_id", "")) == definition_id:
			return i
	return -1


func _weapon_stat_bonus(definition_id: String, stat_id: String) -> float:
	var stats: Dictionary = _weapon_family_stat_bonuses.get(definition_id, {})
	return float(stats.get(stat_id, 0.0))


func _weapon_int_stat_bonus(definition_id: String, stat_id: String, cap: int) -> int:
	return clampi(int(round(_weapon_stat_bonus(definition_id, stat_id))), 0, cap)


func _weapon_damage_multiplier(definition_id: String) -> float:
	return clampf(1.0 + _weapon_stat_bonus(definition_id, "damage_bonus"), 0.80, 1.45)


func _weapon_rate_multiplier(definition_id: String) -> float:
	return clampf(1.0 + _weapon_stat_bonus(definition_id, "fire_rate_bonus"), 0.80, 1.35)


func _weapon_cooldown_multiplier(definition_id: String) -> float:
	return clampf((1.0 - _weapon_stat_bonus(definition_id, "cooldown_reduction")) * _core_cooldown_multiplier, 0.66, 1.0)


func _weapon_speed_multiplier(definition_id: String) -> float:
	return clampf(1.0 + _weapon_stat_bonus(definition_id, "projectile_speed_bonus"), 0.85, 1.32)


func _weapon_lifetime_multiplier(definition_id: String) -> float:
	return clampf(1.0 + _weapon_stat_bonus(definition_id, "lifetime_bonus"), 0.90, 1.24)


func _weapon_range_multiplier(definition_id: String) -> float:
	return clampf(1.0 + _weapon_stat_bonus(definition_id, "range_bonus"), 0.90, 1.20)


func _weapon_choice_action(instance: Dictionary) -> String:
	var definition_id := str(instance.get("definition_id", ""))
	var equipped_index := _equipped_weapon_index_for_definition(definition_id)
	if equipped_index >= 0:
		var current_power := float(_equipped_weapon_instances[equipped_index].get("power_score", 1.0))
		var candidate_power := float(instance.get("power_score", 1.0))
		return "UPGRADE" if candidate_power >= current_power else "REPLACE"
	if _equipped_weapon_instances.size() < EQUIPPED_WEAPON_SLOT_CAP:
		return "NEW"
	if _stash_weapon_instances.size() < STASH_WEAPON_CAP:
		return "STASH"
	return "STASH FULL"


func _make_weapon_reward_choice() -> Dictionary:
	var instance := WeaponCatalog.roll_weapon_instance(_weapon_loot_rng, _sector_index, _generate_weapon_instance_id())
	var action := _weapon_choice_action(instance)
	var equipped_index := _equipped_weapon_index_for_definition(str(instance.get("definition_id", "")))
	var current := _equipped_weapon_instances[equipped_index] if equipped_index >= 0 else {}
	return {
		"kind": "weapon_loot",
		"title": str(instance["name"]),
		"description": _weapon_reward_description(instance, action),
		"category": action,
		"shape": str(WeaponCatalog.weapon_definition(str(instance["definition_id"])).get("shape", "Weapon geometry")),
		"effects": {},
		"weapon_instance": instance,
		"comparison": WeaponCatalog.comparison_data(instance, current),
		"weapon_action": action
	}


func _weapon_reward_description(instance: Dictionary, action: String) -> String:
	var rarity := str(instance.get("rarity", "Common")).to_upper()
	var power := float(instance.get("power_score", 1.0))
	var modifier := WeaponCatalog.primary_modifier_text(instance)
	return "%s // PWR %.2f\n%s\n%s" % [rarity, power, modifier, _weapon_stat_summary(instance)]


func _weapon_stat_summary(instance: Dictionary) -> String:
	var rolls: Array = instance.get("stat_rolls", [])
	if rolls.is_empty():
		return "Baseline stats"
	var pieces: Array[String] = []
	for i in range(mini(2, rolls.size())):
		var roll: Dictionary = rolls[i]
		pieces.append("%s %s" % [str(roll.get("label", "Stat")), WeaponCatalog.format_stat(roll)])
	return "  ".join(pieces)


func _apply_weapon_reward(upgrade: Dictionary) -> void:
	var instance: Dictionary = Dictionary(upgrade.get("weapon_instance", {})).duplicate(true)
	if instance.is_empty():
		return
	var action := str(upgrade.get("weapon_action", _weapon_choice_action(instance)))
	var definition_id := str(instance.get("definition_id", ""))
	instance["equipped"] = false
	match action:
		"UPGRADE", "REPLACE":
			var equipped_index := _equipped_weapon_index_for_definition(definition_id)
			if equipped_index >= 0:
				instance["equipped"] = true
				_equipped_weapon_instances[equipped_index] = instance
			elif _equipped_weapon_instances.size() < EQUIPPED_WEAPON_SLOT_CAP:
				instance["equipped"] = true
				_equipped_weapon_instances.append(instance)
			elif _stash_weapon_instances.size() < STASH_WEAPON_CAP:
				_stash_weapon_instances.append(instance)
		"NEW":
			if _equipped_weapon_instances.size() < EQUIPPED_WEAPON_SLOT_CAP:
				instance["equipped"] = true
				_equipped_weapon_instances.append(instance)
			elif _stash_weapon_instances.size() < STASH_WEAPON_CAP:
				_stash_weapon_instances.append(instance)
		"STASH":
			if _stash_weapon_instances.size() < STASH_WEAPON_CAP:
				_stash_weapon_instances.append(instance)
		"STASH FULL":
			pass
		_:
			if _stash_weapon_instances.size() < STASH_WEAPON_CAP:
				_stash_weapon_instances.append(instance)
	_remember_discovered_weapon(instance)
	_rebuild_weapon_stat_bonuses()
	_save_weapon_inventory()
	_run_weapons_gained += 1
	_spawn_burst(_player_area.position, 1.12, "burst_cyan")
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.09, 0.18)


func _create_audio_foundation() -> void:
	_sfx = {
		"shoot": _make_tone_sfx(1040.0, 0.044, 0.280, -0.16),
		"lance": _make_tone_sfx(1360.0, 0.078, 0.270, 0.28),
		"hit": _make_tone_sfx(520.0, 0.048, 0.240, -0.34),
		"death": _make_tone_sfx(190.0, 0.155, 0.320, -0.46),
		"xp": _make_tone_sfx(1680.0, 0.038, 0.170, 0.42),
		"level": _make_tone_sfx(760.0, 0.220, 0.310, 0.86),
		"damage": _make_tone_sfx(128.0, 0.135, 0.300, -0.54),
		"warning": _make_tone_sfx(280.0, 0.260, 0.290, 0.12),
		"boss_warning": _make_tone_sfx(210.0, 0.420, 0.340, -0.08),
		"boss_death": _make_tone_sfx(82.0, 0.500, 0.350, -0.44),
		"sector": _make_tone_sfx(520.0, 0.460, 0.320, 0.64),
		"reward": _make_tone_sfx(940.0, 0.180, 0.270, 0.52),
		"run_complete": _make_tone_sfx(620.0, 0.520, 0.340, 0.90),
		"ui": _make_tone_sfx(660.0, 0.050, 0.180, 0.18),
		"ui_move": _make_tone_sfx(740.0, 0.036, 0.160, 0.12),
		"ui_select": _make_tone_sfx(880.0, 0.070, 0.210, 0.30),
		"ui_back": _make_tone_sfx(420.0, 0.072, 0.200, -0.24),
		"ui_adjust": _make_tone_sfx(980.0, 0.045, 0.150, 0.20),
		"pause": _make_tone_sfx(500.0, 0.120, 0.210, -0.20),
		"mute": _make_tone_sfx(330.0, 0.070, 0.180, -0.25)
	}
	_sfx_volume_db = {
		"shoot": -7.0,
		"lance": -6.2,
		"hit": -7.2,
		"death": -3.8,
		"xp": -9.0,
		"level": -3.8,
		"damage": -4.0,
		"warning": -4.4,
		"boss_warning": -2.8,
		"boss_death": -2.6,
		"sector": -3.4,
		"reward": -5.2,
		"run_complete": -2.8,
		"ui": -8.0,
		"ui_move": -9.0,
		"ui_select": -7.0,
		"ui_back": -7.8,
		"ui_adjust": -9.0,
		"pause": -6.8,
		"mute": -7.5
	}
	for i in range(SFX_PLAYER_CAP):
		var player := AudioStreamPlayer.new()
		player.name = "ProceduralSFXPlayer%d" % i
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		player.volume_db = -9.0
		add_child(player)
		_sfx_players.append(player)
	_music_streams = {
		"title": _make_music_loop("title", 112.0, 8.0, 55.0),
		"gameplay": _make_music_loop("gameplay", 146.0, 8.0, 61.735),
		"boss": _make_music_loop("boss", 164.0, 6.0, 46.25)
	}
	_music_stings = {
		"run_complete": _make_music_sting("run_complete"),
		"death": _make_music_sting("death")
	}
	_music_player = AudioStreamPlayer.new()
	_music_player.name = "ProceduralMusicLoopPlayer"
	_music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	_music_player.volume_db = -15.0
	add_child(_music_player)
	_music_sting_player = AudioStreamPlayer.new()
	_music_sting_player.name = "ProceduralMusicStingPlayer"
	_music_sting_player.process_mode = Node.PROCESS_MODE_ALWAYS
	_music_sting_player.volume_db = -10.0
	add_child(_music_sting_player)
	_apply_audio_mute()
	_apply_music_mix()


func _make_tone_sfx(frequency: float, duration: float, volume: float, sweep: float) -> AudioStreamWAV:
	var mix_rate := 22050
	var sample_count := int(float(mix_rate) * duration)
	var bytes := PackedByteArray()
	bytes.resize(sample_count * 2)
	var phase := 0.0
	for i in range(sample_count):
		var t := float(i) / float(maxi(1, sample_count - 1))
		var envelope := sin(t * PI)
		var current_frequency := frequency * (1.0 + sweep * t)
		phase += TAU * current_frequency / float(mix_rate)
		var tone := sin(phase) * 0.78 + sin(phase * 2.01) * 0.22
		var sample := int(clampf(tone * envelope * volume, -1.0, 1.0) * 32767.0)
		if sample < 0:
			sample += 65536
		bytes[i * 2] = sample & 0xff
		bytes[i * 2 + 1] = (sample >> 8) & 0xff
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = mix_rate
	stream.stereo = false
	stream.data = bytes
	return stream


func _make_music_loop(kind: String, bpm: float, duration: float, root_frequency: float) -> AudioStreamWAV:
	var sample_count := int(float(MUSIC_MIX_RATE) * duration)
	var bytes := PackedByteArray()
	bytes.resize(sample_count * 2)
	var minor_steps := [0, 3, 5, 7, 10, 12, 15, 17]
	var bass_pattern := [0, 0, 3, 0, 5, 3, 7, 5]
	var arp_pattern := [12, 15, 19, 22, 19, 15, 12, 10]
	var drive := 1.0
	var pad_gain := 0.050
	var bass_gain := 0.145
	var arp_gain := 0.070
	var kick_gain := 0.115
	var hat_gain := 0.024
	var output_gain := 1.48
	match kind:
		"title":
			drive = 0.74
			pad_gain = 0.072
			bass_gain = 0.090
			arp_gain = 0.050
			kick_gain = 0.070
			hat_gain = 0.012
			output_gain = 1.62
		"boss":
			drive = 1.08
			pad_gain = 0.060
			bass_gain = 0.175
			arp_gain = 0.082
			kick_gain = 0.138
			hat_gain = 0.032
			output_gain = 1.38
	for i in range(sample_count):
		var t := float(i) / float(MUSIC_MIX_RATE)
		var normalized := float(i) / float(maxi(1, sample_count - 1))
		var fade := minf(1.0, minf(normalized * 12.0, (1.0 - normalized) * 12.0))
		var beat := t * bpm / 60.0
		var step := int(floor(beat * 4.0))
		var step_phase := fposmod(beat * 4.0, 1.0)
		var eighth_phase := fposmod(beat * 2.0, 1.0)
		var bar_phase := fposmod(beat / 4.0, 1.0)
		var bass_step: int = bass_pattern[step % bass_pattern.size()]
		var arp_step: int = arp_pattern[(step + (0 if kind != "boss" else 2)) % arp_pattern.size()]
		var bass_frequency := root_frequency * pow(2.0, float(bass_step) / 12.0)
		var arp_frequency := root_frequency * pow(2.0, float(arp_step) / 12.0)
		var pad_frequency := root_frequency * pow(2.0, float(minor_steps[int(floor(bar_phase * float(minor_steps.size()))) % minor_steps.size()]) / 12.0)
		var bass_env := pow(1.0 - step_phase, 1.8)
		var arp_env := sin(step_phase * PI)
		var kick_env := exp(-step_phase * 9.5) if step % 4 == 0 else 0.0
		var hat_env := exp(-eighth_phase * 18.0) if step % 2 == 1 else 0.0
		var kick_frequency := 48.0 + 46.0 * kick_env
		var kick := sin(TAU * kick_frequency * t) * kick_env * kick_gain
		var bass := (sin(TAU * bass_frequency * t) * 0.72 + sin(TAU * bass_frequency * 2.0 * t) * 0.22) * bass_env * bass_gain
		var arp := (sin(TAU * arp_frequency * t) * 0.70 + sin(TAU * arp_frequency * 2.005 * t) * 0.18) * arp_env * arp_gain
		var pad := (sin(TAU * pad_frequency * 0.5 * t) + sin(TAU * pad_frequency * 0.75 * t + 0.8)) * pad_gain
		var noise := (fposmod(sin(float(i) * 12.9898) * 43758.5453, 1.0) * 2.0 - 1.0) * hat_env * hat_gain
		var boss_pulse := 0.0
		if kind == "boss" and step % 8 in [0, 3, 6]:
			boss_pulse = sin(TAU * (root_frequency * 8.0) * t) * exp(-step_phase * 10.0) * 0.045
		var title_chime := 0.0
		if kind == "title" and step % 16 in [0, 6, 10]:
			title_chime = sin(TAU * (arp_frequency * 1.5) * t) * exp(-step_phase * 8.0) * 0.038
		var sample_value := tanh((kick + bass + arp + pad + noise + boss_pulse + title_chime) * drive) * fade * output_gain
		_write_pcm16(bytes, i, sample_value)
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = MUSIC_MIX_RATE
	stream.stereo = false
	stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	stream.loop_begin = 0
	stream.loop_end = sample_count
	stream.data = bytes
	return stream


func _make_music_sting(kind: String) -> AudioStreamWAV:
	var duration := 2.25 if kind == "run_complete" else 1.85
	var sample_count := int(float(MUSIC_MIX_RATE) * duration)
	var bytes := PackedByteArray()
	bytes.resize(sample_count * 2)
	var notes := [392.0, 493.88, 587.33, 783.99] if kind == "run_complete" else [196.0, 146.83, 110.0, 82.41]
	for i in range(sample_count):
		var t := float(i) / float(MUSIC_MIX_RATE)
		var normalized := float(i) / float(maxi(1, sample_count - 1))
		var envelope := sin(normalized * PI)
		var note_index := clampi(int(floor(normalized * float(notes.size()))), 0, notes.size() - 1)
		var frequency: float = notes[note_index]
		var sparkle := 0.0
		if kind == "run_complete":
			sparkle = sin(TAU * frequency * 2.0 * t) * pow(envelope, 1.4) * 0.055
		else:
			sparkle = sin(TAU * frequency * 0.5 * t) * pow(envelope, 0.8) * 0.060
		var chord := sin(TAU * frequency * t) * 0.12 + sin(TAU * frequency * 1.5 * t) * 0.055 + sparkle
		var thump := 0.0
		if normalized < 0.18:
			thump = sin(TAU * (72.0 if kind == "run_complete" else 58.0) * t) * exp(-normalized * 18.0) * 0.11
		_write_pcm16(bytes, i, tanh((chord + thump) * 1.55) * envelope)
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = MUSIC_MIX_RATE
	stream.stereo = false
	stream.loop_mode = AudioStreamWAV.LOOP_DISABLED
	stream.data = bytes
	return stream


func _write_pcm16(bytes: PackedByteArray, sample_index: int, value: float) -> void:
	var sample := int(clampf(value, -0.92, 0.92) * 32767.0)
	if sample < 0:
		sample += 65536
	bytes[sample_index * 2] = sample & 0xff
	bytes[sample_index * 2 + 1] = (sample >> 8) & 0xff


func _play_sfx(key: String, min_interval := 0.035) -> void:
	if DisplayServer.get_name() == "headless":
		return
	if _audio_muted or _sfx_volume <= 0.001 or _sfx_players.is_empty() or not _sfx.has(key):
		return
	if float(_sfx_cooldowns.get(key, 0.0)) > 0.0:
		return
	var player := _sfx_players[_sfx_player_index]
	_sfx_player_index = (_sfx_player_index + 1) % _sfx_players.size()
	player.stop()
	player.stream = _sfx[key]
	player.volume_db = float(_sfx_volume_db.get(key, -9.0)) + _volume_to_db(_sfx_volume)
	player.play()
	_sfx_cooldowns[key] = min_interval


func _update_sfx_cooldowns(delta: float) -> void:
	for key in _sfx_cooldowns.keys():
		_sfx_cooldowns[key] = maxf(0.0, float(_sfx_cooldowns[key]) - delta)


func _toggle_audio_mute() -> void:
	var next_muted := not _audio_muted
	if next_muted:
		_play_sfx("mute", 0.08)
	_audio_muted = next_muted
	_apply_audio_mute()
	if not _audio_muted:
		_play_sfx("mute", 0.08)
	_update_hud()
	_update_title_menu_labels()
	_save_settings()


func _apply_audio_mute() -> void:
	var bus_index := AudioServer.get_bus_index("Master")
	if bus_index >= 0:
		AudioServer.set_bus_volume_db(bus_index, _volume_to_db(_master_volume))
		AudioServer.set_bus_mute(bus_index, _audio_muted)
	_apply_music_mix()


func _apply_music_mix() -> void:
	var loop_volume := -4.2 + _volume_to_db(_music_volume)
	var sting_volume := -1.8 + _volume_to_db(_music_volume)
	if is_instance_valid(_music_player):
		_music_player.volume_db = loop_volume
		if DisplayServer.get_name() != "headless" and _music_state != "none" and _music_player.stream != null and not _music_player.playing:
			_music_player.play()
	if is_instance_valid(_music_sting_player):
		_music_sting_player.volume_db = sting_volume


func _set_music_state(state: String) -> void:
	if state == _music_state and state != "none":
		_apply_music_mix()
		return
	_music_state = state
	if not is_instance_valid(_music_player):
		return
	if state == "none" or not _music_streams.has(state):
		_music_player.stop()
		_music_player.stream = null
		_apply_music_mix()
		return
	_music_player.stop()
	_music_player.stream = _music_streams[state]
	_apply_music_mix()
	if DisplayServer.get_name() != "headless":
		_music_player.play()


func _update_music_state() -> void:
	if _run_success or _game_over:
		return
	if _title_menu_active:
		_set_music_state("title")
	elif _sector_boss_active or (_sector_boss_warning_played and not _sector_boss_spawned):
		_set_music_state("boss")
	else:
		_set_music_state("gameplay")


func _play_music_sting(key: String) -> void:
	if not _music_stings.has(key) or not is_instance_valid(_music_sting_player):
		return
	_music_sting_player.stop()
	_music_sting_player.stream = _music_stings[key]
	_apply_music_mix()
	if DisplayServer.get_name() != "headless":
		_music_sting_player.play()


func _volume_to_db(value: float) -> float:
	if value <= 0.001:
		return -80.0
	return linear_to_db(clampf(value, 0.0, 1.0))


func _load_settings() -> void:
	var config := ConfigFile.new()
	_tutorial_hints_seen.clear()
	for key in TUTORIAL_HINT_KEYS:
		_tutorial_hints_seen[key] = false
	var error := config.load(SETTINGS_PATH)
	if error != OK:
		_fullscreen_enabled = _is_fullscreen_active()
		_apply_settings_runtime()
		return
	_master_volume = clampf(float(config.get_value("audio", "master_volume", _master_volume)), 0.0, 1.0)
	_sfx_volume = clampf(float(config.get_value("audio", "sfx_volume", _sfx_volume)), 0.0, 1.0)
	_music_volume = clampf(float(config.get_value("audio", "music_volume", _music_volume)), 0.0, 1.0)
	_audio_muted = bool(config.get_value("audio", "muted", _audio_muted))
	_screen_shake_enabled = bool(config.get_value("video", "screen_shake", _screen_shake_enabled))
	_vfx_intensity = clampi(int(config.get_value("video", "vfx_intensity", _vfx_intensity)), 0, VFX_INTENSITY_NAMES.size() - 1)
	_fullscreen_enabled = bool(config.get_value("video", "fullscreen", _is_fullscreen_active()))
	for key in TUTORIAL_HINT_KEYS:
		_tutorial_hints_seen[key] = bool(config.get_value("tutorial", str(key), false))
	_apply_settings_runtime()


func _save_settings() -> void:
	var config := ConfigFile.new()
	config.set_value("audio", "master_volume", _master_volume)
	config.set_value("audio", "sfx_volume", _sfx_volume)
	config.set_value("audio", "music_volume", _music_volume)
	config.set_value("audio", "muted", _audio_muted)
	config.set_value("video", "screen_shake", _screen_shake_enabled)
	config.set_value("video", "vfx_intensity", _vfx_intensity)
	config.set_value("video", "fullscreen", _fullscreen_enabled)
	for key in TUTORIAL_HINT_KEYS:
		config.set_value("tutorial", str(key), bool(_tutorial_hints_seen.get(str(key), false)))
	var error := config.save(SETTINGS_PATH)
	if error != OK:
		push_warning("Failed to save Neon Swarm settings. Error code: %d" % error)


func _queue_tutorial_prompt(key: String) -> void:
	if not TUTORIAL_HINT_KEYS.has(key):
		return
	if bool(_tutorial_hints_seen.get(key, false)):
		return
	if _tutorial_prompt_key == key or _tutorial_prompt_queue.has(key):
		return
	_tutorial_prompt_queue.append(key)


func _update_tutorial_prompt(delta: float) -> void:
	if not is_instance_valid(_tutorial_prompt_panel):
		return
	if _help_visible or _armory_visible or _title_options_visible or _pause_options_visible or _manual_pause or _weapon_reward_decision_active or _level_up_active or _game_over or _run_success:
		_tutorial_prompt_panel.visible = false
		return
	if _tutorial_prompt_key == "" and not _tutorial_prompt_queue.is_empty():
		_show_next_tutorial_prompt()
	if _tutorial_prompt_key == "":
		_tutorial_prompt_panel.visible = false
		return
	_tutorial_prompt_timer = maxf(0.0, _tutorial_prompt_timer - delta)
	_tutorial_prompt_panel.visible = _tutorial_prompt_timer > 0.0
	if _tutorial_prompt_timer <= 0.0:
		_tutorial_prompt_key = ""
		_tutorial_prompt_panel.visible = false


func _sector_color_for_index(index: int) -> Color:
	match clampi(index, 0, SECTOR_COUNT - 1):
		0:
			return Color(1.0, 0.94, 0.18)
		1:
			return Color(0.0, 0.96, 1.0)
		2:
			return Color(0.88, 0.55, 1.0)
		_:
			return Color(0.68, 0.92, 1.0)


func _sector_display_title(index: int) -> String:
	var sector := _sector_data(index)
	return "SECTOR %02d // %s" % [clampi(index, 0, SECTOR_COUNT - 1) + 1, str(sector.get("name", "SECTOR")).to_upper()]


func _sector_identity_text(index: int) -> String:
	match clampi(index, 0, SECTOR_COUNT - 1):
		0:
			return "BASELINE SWARM PRESSURE"
		1:
			return "DISTORTED PRISM FORMATIONS"
		2:
			return "VOID PRESSURE RISING"
		_:
			return "OVERCLOCKED RAIL NETWORK"


func _show_sector_entry_notice(index: int, run_start := false) -> void:
	var prefix := "RUN START" if run_start else "SECTOR ENTRY"
	_show_combat_notice("%s // %s // %s" % [prefix, _sector_display_title(index), _sector_identity_text(index)], _sector_color_for_index(index), 2.15)


func _show_combat_notice(text: String, color := Color(1.0, 0.94, 0.18), duration := 1.45) -> void:
	_elite_notice_timer = duration
	if _combat_notice_label:
		_combat_notice_label.text = text
		_combat_notice_label.add_theme_color_override("font_color", color)
	if _combat_notice_panel:
		var frame := _combat_notice_panel as NeonFramePanel
		if frame:
			frame.accent_primary = color
			frame.animated = true
			frame.queue_redraw()
		_combat_notice_panel.visible = true


func _update_combat_notice(delta: float) -> void:
	if not is_instance_valid(_combat_notice_panel):
		return
	if _title_menu_active or _manual_pause or _game_over or _run_success or _weapon_reward_decision_active or _level_up_active:
		_combat_notice_panel.visible = false
		return
	_elite_notice_timer = maxf(0.0, _elite_notice_timer - delta)
	_combat_notice_panel.visible = _elite_notice_timer > 0.0
	var frame := _combat_notice_panel as NeonFramePanel
	if _combat_notice_panel.visible and frame:
		frame.animated = true
		frame.queue_redraw()


func _show_next_tutorial_prompt() -> void:
	while not _tutorial_prompt_queue.is_empty():
		var key := str(_tutorial_prompt_queue.pop_front())
		if bool(_tutorial_hints_seen.get(key, false)):
			continue
		var data := _tutorial_prompt_data(key)
		if data.is_empty():
			_tutorial_hints_seen[key] = true
			continue
		_tutorial_prompt_key = key
		_tutorial_prompt_timer = _tutorial_prompt_duration
		_tutorial_hints_seen[key] = true
		_save_settings()
		if _tutorial_prompt_title_label:
			_tutorial_prompt_title_label.text = str(data.get("title", "FIELD NOTE"))
		if _tutorial_prompt_body_label:
			_tutorial_prompt_body_label.text = str(data.get("body", ""))
		if _tutorial_prompt_panel:
			_tutorial_prompt_panel.visible = true
		return


func _tutorial_prompt_data(key: String) -> Dictionary:
	match key:
		"armory":
			return {"title": "LOADOUT NOTE", "body": "Use ARMORY from the title screen to inspect equipped weapons and stashed weapons."}
		"xp":
			return {"title": "XP SHARDS", "body": "Collect XP shards to level up. XP is not weapon loot."}
		"weapons":
			return {"title": "AUTO WEAPONS", "body": "Equipped weapons fire automatically. Aim if you want to steer projectile shots."}
		"sectors":
			return {"title": "SECTOR FLOW", "body": "Clear sectors to earn rewards. Sector weapon rewards can be equipped, stashed, or scrapped."}
		"weapon_loot":
			return {"title": "WEAPON LOOT", "body": "Generated weapons are random systems with rarity and stat rolls."}
		_:
			return {}


func _apply_settings_runtime() -> void:
	_apply_audio_mute()
	_apply_music_mix()
	_apply_fullscreen_setting()
	_update_hd_sector_background_intensity()
	_update_player_presentation_effects(0.0)


func _is_fullscreen_active() -> bool:
	if DisplayServer.get_name() == "headless":
		return false
	var mode := DisplayServer.window_get_mode()
	return mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN


func _apply_fullscreen_setting() -> void:
	if DisplayServer.get_name() == "headless":
		return
	var target := DisplayServer.WINDOW_MODE_FULLSCREEN if _fullscreen_enabled else DisplayServer.WINDOW_MODE_WINDOWED
	if DisplayServer.window_get_mode() != target:
		DisplayServer.window_set_mode(target)


func _create_materials() -> void:
	_materials["white"] = Kit.make_emissive_material(Color(1.0, 0.99, 0.86, 1.0), 6.8, false)
	_materials["soft_white"] = Kit.make_emissive_material(Color(0.90, 0.98, 1.0, 0.64), 3.5, true)
	_materials["enemy_dark_body"] = Kit.make_neon_body_material(Color(0.02, 0.018, 0.038, 1.0), 0.72)
	_materials["grid_minor"] = Kit.make_emissive_material(Color(0.03, 0.16, 0.40, 0.16), 0.34, true)
	_materials["grid_major"] = Kit.make_emissive_material(Color(0.06, 0.34, 0.80, 0.27), 0.76, true)
	_materials["grid_axis"] = Kit.make_emissive_material(Color(0.54, 0.08, 0.94, 0.32), 0.98, true)
	_materials["border"] = Kit.make_emissive_material(Color(0.0, 0.84, 1.0, 0.58), 2.10, true)
	_materials["sector1_grid_minor"] = Kit.make_emissive_material(Color(0.02, 0.24, 0.48, 0.16), 0.38, true)
	_materials["sector1_grid_major"] = Kit.make_emissive_material(Color(0.0, 0.76, 1.0, 0.30), 0.86, true)
	_materials["sector1_grid_axis"] = Kit.make_emissive_material(Color(1.0, 0.08, 0.86, 0.32), 0.95, true)
	_materials["sector1_border"] = Kit.make_emissive_material(Color(0.0, 0.92, 1.0, 0.62), 2.16, true)
	_materials["sector1_shape"] = Kit.make_emissive_material(Color(1.0, 0.88, 0.08, 0.62), 2.80, true)
	_materials["sector1_shape_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.86, 0.90), 5.6, true)
	_materials["sector1_dust"] = Kit.make_emissive_material(Color(0.12, 0.52, 1.0, 0.18), 0.52, true)
	_materials["sector1_floor_haze"] = Kit.make_emissive_material(Color(0.0, 0.46, 1.0, 0.055), 0.32, true)
	_materials["sector1_far_structure"] = Kit.make_emissive_material(Color(0.0, 0.70, 1.0, 0.30), 1.10, true)
	_materials["sector1_dark_glass"] = Kit.make_neon_body_material(Color(0.012, 0.040, 0.085, 1.0), 0.34)
	_materials["sector1_floor_grid"] = Kit.make_emissive_material(Color(0.0, 0.54, 1.0, 0.26), 0.78, true)
	_materials["sector1_floor_path"] = Kit.make_emissive_material(Color(0.0, 0.88, 1.0, 0.46), 1.36, true)
	_materials["sector1_floor_core"] = Kit.make_emissive_material(Color(0.86, 1.0, 1.0, 0.72), 3.2, true)
	_materials["sector1_floor_edge"] = Kit.make_emissive_material(Color(0.0, 0.76, 1.0, 0.42), 1.42, true)
	_materials["sector1_floor_atmosphere"] = Kit.make_emissive_material(Color(0.0, 0.24, 0.62, 0.038), 0.22, true)
	_materials["sector2_grid_minor"] = Kit.make_emissive_material(Color(0.20, 0.06, 0.44, 0.16), 0.42, true)
	_materials["sector2_grid_major"] = Kit.make_emissive_material(Color(1.0, 0.05, 0.86, 0.28), 0.90, true)
	_materials["sector2_grid_axis"] = Kit.make_emissive_material(Color(0.0, 0.92, 1.0, 0.34), 1.00, true)
	_materials["sector2_border"] = Kit.make_emissive_material(Color(1.0, 0.08, 0.78, 0.60), 2.22, true)
	_materials["sector2_shape"] = Kit.make_emissive_material(Color(0.0, 0.98, 1.0, 0.58), 2.86, true)
	_materials["sector2_shape_core"] = Kit.make_emissive_material(Color(1.0, 0.96, 0.18, 0.86), 5.8, true)
	_materials["sector2_dust"] = Kit.make_emissive_material(Color(1.0, 0.10, 0.86, 0.15), 0.50, true)
	_materials["sector2_floor_haze"] = Kit.make_emissive_material(Color(0.82, 0.04, 1.0, 0.060), 0.34, true)
	_materials["sector2_far_structure"] = Kit.make_emissive_material(Color(1.0, 0.08, 0.86, 0.32), 1.16, true)
	_materials["sector2_dark_glass"] = Kit.make_neon_body_material(Color(0.050, 0.014, 0.080, 1.0), 0.38)
	_materials["sector2_floor_grid"] = Kit.make_emissive_material(Color(0.86, 0.06, 1.0, 0.25), 0.78, true)
	_materials["sector2_floor_secondary"] = Kit.make_emissive_material(Color(0.0, 0.78, 1.0, 0.20), 0.62, true)
	_materials["sector2_floor_path"] = Kit.make_emissive_material(Color(1.0, 0.08, 0.86, 0.45), 1.38, true)
	_materials["sector2_floor_core"] = Kit.make_emissive_material(Color(0.86, 1.0, 1.0, 0.72), 3.15, true)
	_materials["sector2_floor_edge"] = Kit.make_emissive_material(Color(0.78, 0.08, 1.0, 0.40), 1.34, true)
	_materials["sector2_floor_atmosphere"] = Kit.make_emissive_material(Color(0.42, 0.0, 0.70, 0.042), 0.22, true)
	_materials["sector3_grid_minor"] = Kit.make_emissive_material(Color(0.08, 0.02, 0.18, 0.18), 0.34, true)
	_materials["sector3_grid_major"] = Kit.make_emissive_material(Color(0.0, 0.64, 1.0, 0.24), 0.82, true)
	_materials["sector3_grid_axis"] = Kit.make_emissive_material(Color(0.74, 0.02, 1.0, 0.30), 0.96, true)
	_materials["sector3_border"] = Kit.make_emissive_material(Color(0.0, 0.90, 1.0, 0.52), 2.30, true)
	_materials["sector3_shape"] = Kit.make_emissive_material(Color(0.82, 0.04, 1.0, 0.58), 2.92, true)
	_materials["sector3_shape_core"] = Kit.make_emissive_material(Color(0.82, 1.0, 1.0, 0.84), 5.9, true)
	_materials["sector3_dust"] = Kit.make_emissive_material(Color(0.50, 0.08, 1.0, 0.13), 0.46, true)
	_materials["sector3_floor_haze"] = Kit.make_emissive_material(Color(0.10, 0.015, 0.24, 0.070), 0.28, true)
	_materials["sector3_far_structure"] = Kit.make_emissive_material(Color(0.52, 0.04, 1.0, 0.28), 1.04, true)
	_materials["sector3_dark_glass"] = Kit.make_neon_body_material(Color(0.006, 0.004, 0.022, 1.0), 0.26)
	_materials["sector3_floor_grid"] = Kit.make_emissive_material(Color(0.42, 0.04, 1.0, 0.24), 0.70, true)
	_materials["sector3_floor_secondary"] = Kit.make_emissive_material(Color(0.0, 0.66, 1.0, 0.18), 0.54, true)
	_materials["sector3_floor_path"] = Kit.make_emissive_material(Color(0.68, 0.08, 1.0, 0.42), 1.12, true)
	_materials["sector3_floor_core"] = Kit.make_emissive_material(Color(0.74, 1.0, 1.0, 0.62), 2.65, true)
	_materials["sector3_floor_edge"] = Kit.make_emissive_material(Color(0.20, 0.76, 1.0, 0.34), 1.00, true)
	_materials["sector3_floor_atmosphere"] = Kit.make_emissive_material(Color(0.035, 0.0, 0.11, 0.060), 0.18, true)
	_materials["sector4_grid_minor"] = Kit.make_emissive_material(Color(0.03, 0.16, 0.36, 0.16), 0.42, true)
	_materials["sector4_grid_major"] = Kit.make_emissive_material(Color(0.0, 0.90, 1.0, 0.30), 0.96, true)
	_materials["sector4_grid_axis"] = Kit.make_emissive_material(Color(0.72, 0.96, 1.0, 0.36), 1.08, true)
	_materials["sector4_border"] = Kit.make_emissive_material(Color(0.10, 0.68, 1.0, 0.64), 2.36, true)
	_materials["sector4_shape"] = Kit.make_emissive_material(Color(0.60, 0.92, 1.0, 0.62), 3.00, true)
	_materials["sector4_shape_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 1.0, 0.88), 6.1, true)
	_materials["sector4_dust"] = Kit.make_emissive_material(Color(0.24, 0.72, 1.0, 0.15), 0.54, true)
	_materials["sector4_floor_haze"] = Kit.make_emissive_material(Color(0.42, 0.86, 1.0, 0.062), 0.36, true)
	_materials["sector4_far_structure"] = Kit.make_emissive_material(Color(0.62, 0.94, 1.0, 0.34), 1.28, true)
	_materials["sector4_dark_glass"] = Kit.make_neon_body_material(Color(0.010, 0.035, 0.070, 1.0), 0.36)
	_materials["sector4_floor_grid"] = Kit.make_emissive_material(Color(0.0, 0.76, 1.0, 0.26), 0.86, true)
	_materials["sector4_floor_secondary"] = Kit.make_emissive_material(Color(0.78, 0.96, 1.0, 0.20), 0.70, true)
	_materials["sector4_floor_path"] = Kit.make_emissive_material(Color(0.52, 0.94, 1.0, 0.48), 1.54, true)
	_materials["sector4_floor_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 1.0, 0.74), 3.45, true)
	_materials["sector4_floor_edge"] = Kit.make_emissive_material(Color(0.32, 0.84, 1.0, 0.46), 1.60, true)
	_materials["sector4_floor_atmosphere"] = Kit.make_emissive_material(Color(0.0, 0.28, 0.72, 0.042), 0.24, true)
	_materials["sector_transition_scan"] = Kit.make_emissive_material(Color(0.82, 1.0, 1.0, 0.62), 3.2, true)
	_materials["enemy_projectile"] = Kit.make_emissive_material(Color(1.0, 0.12, 0.04, 0.90), 6.2, true)
	_materials["enemy_projectile_core"] = Kit.make_emissive_material(Color(1.0, 0.99, 0.76, 1.0), 8.2, false)
	_materials["arc_beam"] = Kit.make_emissive_material(Color(0.02, 1.0, 1.0, CHAIN_VFX_ALPHA), CHAIN_VFX_OUTER_EMISSION, true)
	_materials["arc_beam_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.84, CHAIN_VFX_CORE_ALPHA), CHAIN_VFX_CORE_EMISSION, false)
	_materials["mine_body"] = Kit.make_emissive_material(Color(0.84, 0.04, 1.0, 0.90), 6.5, true)
	_materials["mine_core"] = Kit.make_emissive_material(Color(1.0, 0.99, 0.78, 1.0), 8.4, false)
	_materials["mine_field"] = Kit.make_emissive_material(Color(0.50, 0.02, 1.0, 0.22), 2.35, true)
	_materials["orbit_spark"] = Kit.make_emissive_material(Color(0.0, 1.0, 1.0, 0.95), 7.2, true)
	_materials["nova"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.66), 5.6, true)
	_materials["prism_lance"] = Kit.make_emissive_material(Color(0.78, 0.08, 1.0, 0.92), 7.0, true)
	_materials["prism_lance_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.88, 1.0), 8.8, false)
	_materials["ring_saw"] = Kit.make_emissive_material(Color(0.0, 1.0, 0.92, 0.88), 6.8, true)
	_materials["hex_shatter"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.92), 7.2, true)
	_materials["hex_shatter_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.82, 1.0), 8.8, false)
	_materials["hex_shatter_shard"] = Kit.make_emissive_material(Color(1.0, 0.05, 0.86, 0.88), 6.8, true)
	_materials["fractal_shard"] = Kit.make_emissive_material(Color(0.0, 0.98, 1.0, 0.90), 7.4, true)
	_materials["fractal_shard_core"] = Kit.make_emissive_material(Color(1.0, 0.96, 0.78, 1.0), 9.0, false)
	_materials["fractal_shard_split"] = Kit.make_emissive_material(Color(1.0, 0.18, 0.78, 0.88), 6.9, true)
	_materials["tri_burst"] = Kit.make_emissive_material(Color(1.0, 0.16, 0.72, 0.90), 7.2, true)
	_materials["hex_mortar"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.92), 7.1, true)
	_materials["vector_spear"] = Kit.make_emissive_material(Color(0.56, 0.92, 1.0, 0.92), 7.4, true)
	_materials["orbital_saw_array"] = Kit.make_emissive_material(Color(0.0, 1.0, 0.72, 0.88), 6.9, true)
	_materials["prism_chain"] = Kit.make_emissive_material(Color(0.90, 0.08, 1.0, CHAIN_VFX_ALPHA), CHAIN_VFX_PRISM_EMISSION, true)
	_materials["gravity_well"] = Kit.make_emissive_material(Color(0.46, 0.04, 1.0, 0.86), 7.0, true)
	_materials["nova_needle"] = Kit.make_emissive_material(Color(0.0, 1.0, 0.94, 0.92), 7.0, true)
	_materials["fractal_bloom"] = Kit.make_emissive_material(Color(1.0, 0.34, 0.04, 0.90), 7.2, true)
	_materials["shield_breaker"] = Kit.make_emissive_material(Color(1.0, 0.88, 0.04, 0.92), 7.2, true)
	_materials["star_pulse"] = Kit.make_emissive_material(Color(1.0, 0.96, 0.18, 0.90), 7.1, true)
	_materials["null_shard"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.88), 7.0, true)
	_materials["null_shard_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.86, 1.0), 8.6, false)
	_materials["hazard_leech"] = Kit.make_emissive_material(Color(0.72, 0.04, 1.0, 0.34), 3.8, true)
	_materials["hazard_null"] = Kit.make_emissive_material(Color(0.0, 0.86, 1.0, 0.30), 3.6, true)
	_materials["hazard_pulse"] = Kit.make_emissive_material(Color(1.0, 0.48, 0.02, 0.34), 3.9, true)
	_materials["event_cache_body"] = Kit.make_neon_body_material(Color(0.025, 0.090, 0.145, 1.0), 0.58)
	_materials["event_cache_edge"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.96), 7.4, true)
	_materials["event_cache_core"] = Kit.make_emissive_material(Color(1.0, 0.94, 0.20, 0.96), 8.2, true)
	_materials["event_rift"] = Kit.make_emissive_material(Color(1.0, 0.08, 0.86, 0.54), 5.3, true)
	_materials["event_rift_core"] = Kit.make_emissive_material(Color(0.0, 0.94, 1.0, 0.78), 6.4, true)
	_materials["event_rift_warning"] = Kit.make_emissive_material(Color(1.0, 0.04, 0.14, 0.74), 7.0, true)
	_materials["event_elite_hunt"] = Kit.make_emissive_material(Color(1.0, 0.58, 0.04, 0.94), 7.2, true)
	_materials["event_shrine_body"] = Kit.make_neon_body_material(Color(0.055, 0.035, 0.105, 1.0), 0.60)
	_materials["event_shrine_edge"] = Kit.make_emissive_material(Color(1.0, 0.24, 0.92, 0.94), 7.0, true)
	_materials["event_shrine_core"] = Kit.make_emissive_material(Color(0.86, 1.0, 1.0, 0.94), 7.8, true)
	_materials["boss_telegraph_prism"] = Kit.make_emissive_material(Color(1.0, 0.08, 0.88, 0.42), 4.4, true)
	_materials["boss_telegraph_null"] = Kit.make_emissive_material(Color(0.0, 0.76, 1.0, 0.40), 4.2, true)
	_materials["boss_telegraph_prime"] = Kit.make_emissive_material(Color(0.72, 0.96, 1.0, 0.44), 4.7, true)
	_materials["boss_telegraph_fractal"] = Kit.make_emissive_material(Color(1.0, 0.34, 0.02, 0.42), 4.5, true)
	_materials["boss_telegraph_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.86, 0.72), 5.4, true)
	_materials["mini_boss"] = Kit.make_emissive_material(Color(0.86, 0.06, 1.0, 0.92), 7.0, true)
	_materials["triad_splitter"] = Kit.make_emissive_material(Color(1.0, 0.18, 0.72, 0.88), 6.8, true)
	_materials["triad_fragment"] = Kit.make_emissive_material(Color(1.0, 0.58, 0.02, 0.88), 6.6, true)
	_materials["hex_pulser"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.88), 6.9, true)
	_materials["rail_skimmer"] = Kit.make_emissive_material(Color(0.52, 0.94, 1.0, 0.92), 7.0, true)
	_materials["rail_skimmer_warning"] = Kit.make_emissive_material(Color(1.0, 0.96, 0.18, 0.76), 6.2, true)
	_materials["grid_splitter"] = Kit.make_emissive_material(Color(0.06, 0.72, 1.0, 0.88), 6.7, true)
	_materials["grid_fragment"] = Kit.make_emissive_material(Color(0.58, 0.96, 1.0, 0.84), 6.1, true)
	_materials["fractal_crown"] = Kit.make_emissive_material(Color(0.88, 0.05, 1.0, 0.90), 7.3, true)
	_materials["fractal_orange"] = Kit.make_emissive_material(Color(1.0, 0.42, 0.02, 0.88), 7.1, true)
	_materials["elite_overcharged"] = Kit.make_emissive_material(Color(0.0, 0.98, 1.0, 0.88), 6.2, true)
	_materials["elite_armored"] = Kit.make_emissive_material(Color(1.0, 0.80, 0.10, 0.90), 6.0, true)
	_materials["elite_shielded"] = Kit.make_emissive_material(Color(0.18, 0.66, 1.0, 0.88), 5.8, true)
	_materials["elite_volatile"] = Kit.make_emissive_material(Color(1.0, 0.28, 0.04, 0.90), 6.4, true)
	_materials["elite_splitter"] = Kit.make_emissive_material(Color(1.0, 0.12, 0.86, 0.90), 6.1, true)
	_materials["elite_hypercharged"] = Kit.make_emissive_material(Color(0.58, 0.96, 1.0, 0.92), 6.8, true)
	_materials["elite_rail_armored"] = Kit.make_emissive_material(Color(0.92, 0.98, 1.0, 0.90), 6.3, true)
	_materials["elite_overclocked_splitter"] = Kit.make_emissive_material(Color(1.0, 0.74, 0.10, 0.92), 6.5, true)
	_materials["burst"] = Kit.make_emissive_material(Color(1.0, 0.62, 0.02, 0.92), 7.0, true)
	_materials["burst_cyan"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.92), 7.0, true)
	_materials["burst_green"] = Kit.make_emissive_material(Color(0.05, 1.0, 0.34, 0.92), 6.8, true)
	_materials["burst_gold"] = Kit.make_emissive_material(Color(1.0, 0.82, 0.02, 0.92), 6.9, true)
	_materials["burst_violet"] = Kit.make_emissive_material(Color(0.92, 0.04, 1.0, 0.92), 7.1, true)
	_materials["burst_red"] = Kit.make_emissive_material(Color(1.0, 0.04, 0.06, 0.94), 7.2, true)
	_materials["burst_shield"] = Kit.make_emissive_material(Color(0.05, 0.62, 1.0, 0.92), 6.8, true)
	_materials["burst_hex"] = Kit.make_emissive_material(Color(0.0, 0.96, 1.0, 0.92), 7.2, true)
	_materials["burst_null"] = Kit.make_emissive_material(Color(0.0, 0.88, 1.0, 0.92), 7.4, true)
	_materials["burst_leech"] = Kit.make_emissive_material(Color(0.72, 0.04, 1.0, 0.90), 6.8, true)
	_materials["burst_fractal"] = Kit.make_emissive_material(Color(1.0, 0.34, 0.02, 0.92), 7.3, true)
	_materials["burst_xp"] = Kit.make_emissive_material(Color(1.0, 0.96, 0.02, 0.96), 7.4, true)
	_materials["burst_ring"] = Kit.make_emissive_material(Color(1.0, 0.18, 0.78, 0.52), 4.6, true)
	_materials["burst_hot_core"] = Kit.make_emissive_material(Color(1.0, 1.0, 0.90, 1.0), 9.4, false)
	_materials["burst_magenta"] = Kit.make_emissive_material(Color(1.0, 0.05, 0.92, 0.66), 5.4, true)
	_materials["xp_trail"] = Kit.make_emissive_material(Color(1.0, 0.92, 0.02, 0.58), 5.1, true)
	_materials["dust"] = Kit.make_emissive_material(Color(0.12, 0.46, 1.0, 0.16), 0.46, true)


func _setup_world_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.0, 0.001, 0.008, 1.0)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.018, 0.026, 0.060, 1.0)
	environment.ambient_light_energy = 0.20
	environment.glow_enabled = true
	environment.glow_intensity = 0.74
	environment.glow_strength = 1.02
	environment.glow_bloom = 0.16
	environment.glow_hdr_threshold = 0.31
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 0.96
	world_environment.environment = environment
	_world_environment = world_environment
	_world_environment_data = environment
	add_child(world_environment)


func _create_camera() -> void:
	_camera = Camera3D.new()
	_camera.name = "GameplayCamera"
	_camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	_camera.size = 35.0
	_camera.position = Vector3(0.0, 31.0, 24.0)
	_camera_base_position = _camera.position
	_camera.current = true
	add_child(_camera)
	_camera.look_at(Vector3.ZERO, Vector3.UP)


func _create_gameplay_root() -> void:
	_gameplay_root = Node3D.new()
	_gameplay_root.name = "GameplayRoot3D"
	_gameplay_root.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(_gameplay_root)
	_fx_root = Node3D.new()
	_fx_root.name = "GameplayVFXRoot"
	_gameplay_root.add_child(_fx_root)


func _create_arena() -> void:
	var arena := Node3D.new()
	arena.name = "Playable3DNeonArena"
	_gameplay_root.add_child(arena)
	_arena_root = arena
	var minor := ImmediateMesh.new()
	var major := ImmediateMesh.new()
	var axis := ImmediateMesh.new()
	_build_grid_surface(minor, 1.0, _materials["grid_minor"], false)
	_build_grid_surface(major, 4.0, _materials["grid_major"], false)
	_build_grid_surface(axis, ARENA_HALF_SIZE, _materials["grid_axis"], true)
	_grid_minor_instance = Kit.add_mesh(arena, "ArenaGridMinorLines", minor, null)
	_grid_major_instance = Kit.add_mesh(arena, "ArenaGridMajorLines", major, null)
	_grid_axis_instance = Kit.add_mesh(arena, "ArenaGridAxisLines", axis, null)
	var points: Array = [
		Vector3(-ARENA_HALF_SIZE, 0.025, -ARENA_HALF_SIZE),
		Vector3(ARENA_HALF_SIZE, 0.025, -ARENA_HALF_SIZE),
		Vector3(ARENA_HALF_SIZE, 0.025, ARENA_HALF_SIZE),
		Vector3(-ARENA_HALF_SIZE, 0.025, ARENA_HALF_SIZE)
	]
	var edges: Array = [[0, 1], [1, 2], [2, 3], [3, 0]]
	_arena_border_instance = Kit.add_mesh(arena, "ArenaBorderColoredTube", Kit.tube_edge_mesh(points, edges, 0.116, 8), _materials["border"])
	_arena_border_core_instance = Kit.add_mesh(arena, "ArenaBorderWhiteHotCore", Kit.tube_edge_mesh(points, edges, 0.034, 6), _materials["soft_white"])
	_sector_background_root = Node3D.new()
	_sector_background_root.name = "SectorBackgroundDepthRoot"
	arena.add_child(_sector_background_root)
	_sector_geometry_root = Node3D.new()
	_sector_geometry_root.name = "SectorGeometryIdentityRoot"
	arena.add_child(_sector_geometry_root)
	_sector_transition_root = Node3D.new()
	_sector_transition_root.name = "SectorTransitionScanlineRoot"
	arena.add_child(_sector_transition_root)


func _sector_data(index: int) -> Dictionary:
	return ContentCatalog.sector_data(clampi(index, 0, SECTOR_COUNT - 1))


func _current_sector() -> Dictionary:
	return _sector_data(_sector_index)


func _current_sector_name() -> String:
	return str(_current_sector()["name"])


func _sector_material_prefix() -> String:
	return "sector%d" % clampi(_sector_index + 1, 1, SECTOR_COUNT)


func _apply_sector_visual_identity() -> void:
	var prefix := _sector_material_prefix()
	if is_instance_valid(_grid_minor_instance):
		_grid_minor_instance.material_override = _materials["%s_grid_minor" % prefix]
		_grid_minor_instance.visible = false
	if is_instance_valid(_grid_major_instance):
		_grid_major_instance.material_override = _materials["%s_grid_major" % prefix]
		_grid_major_instance.visible = false
	if is_instance_valid(_grid_axis_instance):
		_grid_axis_instance.material_override = _materials["%s_grid_axis" % prefix]
		_grid_axis_instance.visible = false
	if is_instance_valid(_arena_border_instance):
		_arena_border_instance.material_override = _materials["%s_border" % prefix]
	if is_instance_valid(_arena_border_core_instance):
		_arena_border_core_instance.material_override = _materials["soft_white"]
	if is_instance_valid(_dust_batch):
		_dust_batch.material_override = _materials["%s_dust" % prefix]
	_apply_sector_environment_tone()
	_rebuild_sector_background_identity()
	_rebuild_sector_geometry_identity()
	_trigger_sector_background_reaction(0.46, 0.80)


func _rebuild_sector_geometry_identity() -> void:
	if not is_instance_valid(_sector_geometry_root):
		return
	for child in _sector_geometry_root.get_children():
		_sector_geometry_root.remove_child(child)
		child.queue_free()
	# Phase 26 Hard Reset: HD art plates carry sector identity.
	# Legacy loose floor markers are kept as inert utilities but no longer spawned here.


func _apply_sector_environment_tone() -> void:
	if not is_instance_valid(_world_environment) or _world_environment_data == null:
		return
	match _sector_index:
		0:
			_world_environment_data.background_color = Color(0.0, 0.004, 0.018, 1.0)
			_world_environment_data.ambient_light_color = Color(0.020, 0.040, 0.085, 1.0)
			_world_environment_data.ambient_light_energy = 0.22
		1:
			_world_environment_data.background_color = Color(0.010, 0.000, 0.024, 1.0)
			_world_environment_data.ambient_light_color = Color(0.060, 0.020, 0.082, 1.0)
			_world_environment_data.ambient_light_energy = 0.24
		2:
			_world_environment_data.background_color = Color(0.0, 0.0, 0.010, 1.0)
			_world_environment_data.ambient_light_color = Color(0.018, 0.008, 0.038, 1.0)
			_world_environment_data.ambient_light_energy = 0.16
		_:
			_world_environment_data.background_color = Color(0.0, 0.006, 0.020, 1.0)
			_world_environment_data.ambient_light_color = Color(0.030, 0.052, 0.085, 1.0)
			_world_environment_data.ambient_light_energy = 0.22


func _rebuild_sector_background_identity() -> void:
	if not is_instance_valid(_sector_background_root):
		return
	for child in _sector_background_root.get_children():
		_sector_background_root.remove_child(child)
		child.queue_free()
	_sector_hd_background_plate = null
	_sector_hd_background_material = null
	_sector_motion_nodes.clear()
	_sector_flow_lines.clear()
	_sector_pulse_nodes.clear()
	_sector_sweep_nodes.clear()
	match _sector_index:
		0:
			_create_neon_grid_background_depth()
		1:
			_create_prism_rift_background_depth()
		2:
			_create_null_zone_background_depth()
		_:
			_create_hyper_grid_background_depth()


func _create_neon_grid_background_depth() -> void:
	_build_hd_sector_background(0)


func _create_prism_rift_background_depth() -> void:
	_build_hd_sector_background(1)


func _create_null_zone_background_depth() -> void:
	_build_hd_sector_background(2)


func _create_hyper_grid_background_depth() -> void:
	_build_hd_sector_background(3)


func _sector_hd_background_design(index: int) -> Dictionary:
	var prefix := "sector%d" % clampi(index + 1, 1, SECTOR_COUNT)
	var base := {
		"sector": index,
		"material_prefix": prefix,
		"path_material": "%s_floor_path" % prefix,
		"core_material": "%s_floor_core" % prefix,
		"edge_material": "%s_floor_edge" % prefix,
		"texture": "res://art/sectors/exported/sector_1_neon_grid_hd.png",
		"name": "Neon Grid",
		"primary_shape": "square",
		"secondary_shape": "rectangle",
		"composition": "HD square/rectangle arcade floor plate",
		"runners": []
	}
	match index:
		0:
			base.merge({
				"texture": "res://art/sectors/exported/sector_1_neon_grid_hd.png",
				"name": "Neon Grid",
				"primary_shape": "square",
				"secondary_shape": "rectangle",
				"composition": "HD cyan/blue square circuit arena floor",
				"runners": [
					{"name": "NeonGridHDNorthCircuit", "center": Vector3(-12.0, 0.145, 9.0), "direction": Vector3(0.0, 0.0, -1.0), "length": 7.4, "speed": 4.8, "wrap": 42.0, "radius": 0.022, "phase": 1.0},
					{"name": "NeonGridHDCenterCircuit", "center": Vector3(0.0, 0.148, 8.0), "direction": Vector3(0.0, 0.0, -1.0), "length": 8.2, "speed": 5.4, "wrap": 44.0, "radius": 0.024, "phase": 9.0},
					{"name": "NeonGridHDEastCircuit", "center": Vector3(12.0, 0.145, 9.0), "direction": Vector3(0.0, 0.0, -1.0), "length": 7.4, "speed": 4.8, "wrap": 42.0, "radius": 0.022, "phase": 17.0},
					{"name": "NeonGridHDHorizontalReturn", "center": Vector3(0.0, 0.142, -9.0), "direction": Vector3(1.0, 0.0, 0.0), "length": 9.0, "speed": 3.2, "wrap": 42.0, "radius": 0.018, "phase": 5.5}
				]
			}, true)
		1:
			base.merge({
				"texture": "res://art/sectors/exported/sector_2_prism_rift_hd.png",
				"name": "Prism Rift",
				"primary_shape": "diamond",
				"secondary_shape": "triangle",
				"composition": "HD magenta/purple/cyan prism lattice floor",
				"runners": [
					{"name": "PrismRiftHDPrismRouteA", "center": Vector3(-15.0, 0.148, 13.0), "direction": Vector3(1.0, 0.0, -0.34), "length": 7.8, "speed": 4.4, "wrap": 40.0, "radius": 0.022, "phase": 2.0},
					{"name": "PrismRiftHDPrismRouteB", "center": Vector3(-2.0, 0.150, 4.0), "direction": Vector3(1.0, 0.0, 0.42), "length": 8.0, "speed": 4.1, "wrap": 38.0, "radius": 0.023, "phase": 11.0},
					{"name": "PrismRiftHDPrismRouteC", "center": Vector3(13.0, 0.148, -8.0), "direction": Vector3(1.0, 0.0, -0.38), "length": 7.4, "speed": 4.7, "wrap": 39.0, "radius": 0.021, "phase": 19.0},
					{"name": "PrismRiftHDDiamondCore", "center": Vector3(0.0, 0.152, 0.0), "direction": Vector3(1.0, 0.0, -0.68), "length": 6.4, "speed": 3.7, "wrap": 30.0, "radius": 0.018, "phase": 7.0}
				]
			}, true)
		2:
			base.merge({
				"texture": "res://art/sectors/exported/sector_3_null_zone_hd.png",
				"name": "Null Zone",
				"primary_shape": "octagon",
				"secondary_shape": "hexagon",
				"composition": "HD black-glass octagon/hex void floor",
				"runners": [
					{"name": "NullZoneHDOctagonNorth", "center": Vector3(0.0, 0.146, -14.0), "direction": Vector3(1.0, 0.0, 0.0), "length": 5.4, "speed": 1.55, "wrap": 20.0, "radius": 0.018, "phase": 1.0},
					{"name": "NullZoneHDOctagonEast", "center": Vector3(14.0, 0.146, 0.0), "direction": Vector3(0.0, 0.0, 1.0), "length": 5.4, "speed": 1.35, "wrap": 20.0, "radius": 0.018, "phase": 6.0},
					{"name": "NullZoneHDOctagonSouth", "center": Vector3(0.0, 0.146, 14.0), "direction": Vector3(-1.0, 0.0, 0.0), "length": 5.4, "speed": 1.55, "wrap": 20.0, "radius": 0.018, "phase": 11.0},
					{"name": "NullZoneHDOctagonWest", "center": Vector3(-14.0, 0.146, 0.0), "direction": Vector3(0.0, 0.0, -1.0), "length": 5.4, "speed": 1.35, "wrap": 20.0, "radius": 0.018, "phase": 16.0}
				]
			}, true)
		_:
			base.merge({
				"texture": "res://art/sectors/exported/sector_4_hyper_grid_hd.png",
				"name": "Hyper Grid",
				"primary_shape": "stretched_diamond",
				"secondary_shape": "rail",
				"composition": "HD cyan/white rail and stretched-diamond hyperlane floor",
				"runners": [
					{"name": "HyperGridHDRailLaneA", "center": Vector3(-17.0, 0.150, 12.0), "direction": Vector3(0.10, 0.0, -1.0), "length": 9.8, "speed": 11.5, "wrap": 52.0, "radius": 0.024, "phase": 0.0},
					{"name": "HyperGridHDRailLaneB", "center": Vector3(-6.0, 0.153, 10.0), "direction": Vector3(-0.06, 0.0, -1.0), "length": 10.6, "speed": 13.2, "wrap": 54.0, "radius": 0.026, "phase": 8.0},
					{"name": "HyperGridHDRailLaneC", "center": Vector3(7.0, 0.153, 11.0), "direction": Vector3(0.06, 0.0, -1.0), "length": 10.6, "speed": 12.6, "wrap": 54.0, "radius": 0.026, "phase": 15.0},
					{"name": "HyperGridHDRailLaneD", "center": Vector3(18.0, 0.150, 12.0), "direction": Vector3(-0.10, 0.0, -1.0), "length": 9.8, "speed": 11.5, "wrap": 52.0, "radius": 0.024, "phase": 22.0}
				]
			}, true)
	return base


func _build_hd_sector_background(index: int) -> void:
	var design := _sector_hd_background_design(index)
	var texture := _load_hd_sector_background_texture(str(design["texture"]))
	if texture == null:
		push_warning("Missing HD sector background texture: %s" % str(design["texture"]))
		return
	var plate_mesh := PlaneMesh.new()
	plate_mesh.size = Vector2(ARENA_HALF_SIZE * 2.28, ARENA_HALF_SIZE * 2.28)
	var material := StandardMaterial3D.new()
	material.resource_name = "%sHDBackgroundMaterial" % str(design["name"]).replace(" ", "")
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.blend_mode = BaseMaterial3D.BLEND_MODE_MIX
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	material.albedo_texture = texture
	material.albedo_color = Color(1.0, 1.0, 1.0, _hd_sector_background_alpha())
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	var plate := MeshInstance3D.new()
	plate.name = "HDArtSectorBackgroundPlate_%s" % str(design["name"]).replace(" ", "")
	plate.mesh = plate_mesh
	plate.material_override = material
	plate.position = Vector3(0.0, -0.090, 0.0)
	plate.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	_sector_background_root.add_child(plate)
	_sector_hd_background_plate = plate
	_sector_hd_background_material = material
	for runner in design["runners"]:
		_add_hd_background_light_runner(runner, str(design["path_material"]), str(design["core_material"]))


func _load_hd_sector_background_texture(path: String) -> Texture2D:
	var image := Image.load_from_file(path)
	if image == null or image.is_empty():
		return null
	return ImageTexture.create_from_image(image)


func _hide_existing_visual_children(root: Node3D) -> void:
	for child in root.get_children():
		if child is Node3D:
			(child as Node3D).visible = false


func _load_blender_asset_scene(path: String):
	if _blender_asset_scene_cache.has(path):
		return (_blender_asset_scene_cache[path] as PackedScene).instantiate()
	var gltf := GLTFDocument.new()
	var state := GLTFState.new()
	var error := gltf.append_from_file(ProjectSettings.globalize_path(path), state)
	if error == OK:
		var scene := gltf.generate_scene(state)
		if scene is Node:
			var packed := PackedScene.new()
			var pack_error := packed.pack(scene)
			(scene as Node).free()
			if pack_error == OK:
				_blender_asset_scene_cache[path] = packed
				return packed.instantiate()
	push_warning("Missing or unloadable Blender gameplay asset: %s" % path)
	return null


func _asset_scale_vector(scale_value) -> Vector3:
	if scale_value is Vector3:
		return scale_value
	if scale_value is Vector2:
		return Vector3(scale_value.x, 1.0, scale_value.y)
	if typeof(scale_value) == TYPE_FLOAT or typeof(scale_value) == TYPE_INT:
		return Vector3.ONE * float(scale_value)
	return Vector3.ONE


func _add_blender_asset_instance(parent: Node3D, node_name: String, path: String, scale_value = 1.0, local_position := Vector3.ZERO, yaw := 0.0, hide_existing := true):
	if hide_existing:
		_hide_existing_visual_children(parent)
	var instance := _load_blender_asset_scene(path) as Node3D
	if instance == null:
		return null
	instance.name = node_name
	instance.position = local_position
	instance.rotation.y = yaw
	instance.scale = _asset_scale_vector(scale_value)
	parent.add_child(instance)
	return instance


func _apply_player_blender_model(root: Node3D) -> void:
	_add_blender_asset_instance(root, "Blender3DPlayerCoreModel", "res://art/player/exported/3d/player_core.glb", 1.18, Vector3(0.0, 0.05, 0.0), 0.0, true)


func _apply_xp_blender_model(root: Node3D) -> void:
	_add_blender_asset_instance(root, "Blender3DXPPickupModel", "res://art/xp/exported/3d/xp_shard.glb", 1.0, Vector3.ZERO, 0.0, true)


func _prepare_xp_pulse_materials(root: Node) -> Array:
	var pulse_materials: Array = []
	_collect_xp_pulse_materials(root, pulse_materials)
	return pulse_materials


func _collect_xp_pulse_materials(node: Node, pulse_materials: Array) -> void:
	if node is MeshInstance3D:
		var mesh_instance := node as MeshInstance3D
		var mesh := mesh_instance.mesh
		if mesh != null:
			for surface_index in range(mesh.get_surface_count()):
				var material := mesh_instance.get_surface_override_material(surface_index)
				if material == null:
					material = mesh.surface_get_material(surface_index)
				if material is StandardMaterial3D:
					var pulse_material := (material as StandardMaterial3D).duplicate() as StandardMaterial3D
					mesh_instance.set_surface_override_material(surface_index, pulse_material)
					if pulse_material.emission_enabled and pulse_material.emission_energy_multiplier > 0.0:
						pulse_materials.append({
							"material": pulse_material,
							"base_emission": pulse_material.emission_energy_multiplier
						})
	for child in node.get_children():
		_collect_xp_pulse_materials(child, pulse_materials)


func _apply_xp_brightness_pulse(pulse_materials: Array, pulse_amount: float) -> void:
	for entry in pulse_materials:
		var material := entry.get("material", null) as StandardMaterial3D
		if material != null:
			material.emission_energy_multiplier = float(entry.get("base_emission", 1.0)) * pulse_amount


func _enemy_blender_asset_id(enemy_type: String) -> String:
	match enemy_type:
		"mini_boss":
			return "prism_warden"
		"final_null_octagon":
			return "null_octagon_prime"
		_:
			return enemy_type


func _enemy_blender_scale(asset_id: String) -> float:
	match asset_id:
		"prism_warden":
			return 1.55
		"null_octagon":
			return 1.70
		"null_octagon_prime":
			return 1.86
		"fractal_crown":
			return 1.66
		"rail_skimmer":
			return 1.10
		"grid_splitter":
			return 1.18
		"grid_fragment":
			return 0.86
		"triad_fragment":
			return 0.82
		"tank", "shield_node", "hex_pulser", "prism_leech":
			return 1.12
		"exploder", "shooter", "triad_splitter", "hex_slicer", "spiral_drifter":
			return 1.02
		_:
			return 0.96


func _enemy_blender_asset_path(asset_id: String) -> String:
	if asset_id in ["prism_warden", "null_octagon", "null_octagon_prime", "fractal_crown"]:
		return "res://art/bosses/exported/3d/%s.glb" % asset_id
	return "res://art/enemies/exported/3d/%s.glb" % asset_id


func _apply_enemy_blender_model(root: Node3D, enemy_type: String) -> void:
	var asset_id := _enemy_blender_asset_id(enemy_type)
	_add_blender_asset_instance(
		root,
		"Blender3DEnemyModel_%s" % asset_id.to_pascal_case(),
		_enemy_blender_asset_path(asset_id),
		_enemy_blender_scale(asset_id),
		Vector3(0.0, 0.05, 0.0),
		0.0,
		true
	)


func _enemy_visual_scale_for_gameplay(enemy_type: String, base_scale: float) -> float:
	if _is_boss_type(enemy_type) or enemy_type == "mini_boss":
		return base_scale
	if enemy_type == "triad_fragment" or enemy_type == "grid_fragment":
		return maxf(base_scale, 0.68)
	return maxf(base_scale, 0.88)


func _weapon_blender_asset_id(definition_id: String) -> String:
	match definition_id:
		"hex_mortar_shard":
			return "hex_mortar"
		"fractal_bloom_child":
			return "fractal_bloom"
		"fractal_shard_child":
			return "fractal_shard"
		"hex_shatter_shard":
			return "hex_shatter"
		_:
			return definition_id


func _weapon_blender_asset_path(definition_id: String) -> String:
	return "res://art/weapons/exported/3d/%s.glb" % _weapon_blender_asset_id(definition_id)


func _weapon_projectile_blender_scale(definition_id: String) -> Vector3:
	match _weapon_blender_asset_id(definition_id):
		"vector_spear", "prism_lance":
			return Vector3(1.34, 1.34, 1.34)
		"shield_breaker":
			return Vector3(1.08, 1.08, 1.08)
		"hex_mortar", "fractal_bloom", "fractal_shard":
			return Vector3(1.02, 1.02, 1.02)
		"pulse_blaster", "tri_burst_cannon", "nova_needle":
			return Vector3(0.86, 0.86, 0.86)
		"hex_shatter":
			return Vector3(0.94, 0.94, 0.94)
		_:
			return Vector3.ONE


func _apply_weapon_projectile_blender_model(projectile: Node3D, definition_id: String) -> void:
	var asset_id := _weapon_blender_asset_id(definition_id)
	_add_blender_asset_instance(
		projectile,
		"Blender3DWeaponProjectile_%s" % asset_id.to_pascal_case(),
		_weapon_blender_asset_path(asset_id),
		_weapon_projectile_blender_scale(asset_id),
		Vector3(0.0, 0.06, 0.0),
		0.0,
		true
	)


func _add_weapon_blender_model(parent: Node3D, definition_id: String, scale_value = 1.0, local_position := Vector3.ZERO, yaw := 0.0, hide_existing := false):
	var asset_id := _weapon_blender_asset_id(definition_id)
	return _add_blender_asset_instance(
		parent,
		"Blender3DWeaponModel_%s" % asset_id.to_pascal_case(),
		_weapon_blender_asset_path(asset_id),
		scale_value,
		local_position,
		yaw,
		hide_existing
	)


func _hd_sector_background_alpha() -> float:
	match _vfx_intensity:
		0:
			return 0.50
		2:
			return 0.72
		_:
			return 0.62


func _update_hd_sector_background_intensity() -> void:
	if _sector_hd_background_material == null:
		return
	var reaction_boost := clampf(_sector_background_reaction * 0.05, 0.0, 0.06)
	_sector_hd_background_material.albedo_color.a = clampf(_hd_sector_background_alpha() + reaction_boost, 0.42, 0.78)


func _add_hd_background_light_runner(runner: Dictionary, material_key: String, core_material_key: String) -> void:
	var direction: Vector3 = runner.get("direction", Vector3.FORWARD)
	if direction.length_squared() < 0.001:
		direction = Vector3.FORWARD
	direction = direction.normalized()
	var center: Vector3 = runner.get("center", Vector3.ZERO)
	var half_segment := direction * maxf(0.8, float(runner.get("length", 6.0)) * 0.5)
	_add_dynamic_flow_line(
		"HDLightRunner_%s" % str(runner.get("name", "SectorPath")),
		center - half_segment,
		center + half_segment,
		direction,
		float(runner.get("speed", 4.0)),
		float(runner.get("wrap", 36.0)),
		float(runner.get("radius", 0.020)),
		material_key,
		core_material_key,
		float(runner.get("phase", 0.0)),
		0.72,
		0.055
	)


func _sector_floor_design(index: int) -> Dictionary:
	var prefix := "sector%d" % clampi(index + 1, 1, SECTOR_COUNT)
	var base := {
		"sector": index,
		"material_prefix": prefix,
		"line_material": "%s_floor_grid" % prefix,
		"secondary_material": "%s_floor_secondary" % prefix,
		"path_material": "%s_floor_path" % prefix,
		"core_material": "%s_floor_core" % prefix,
		"edge_material": "%s_floor_edge" % prefix,
		"atmosphere_material": "%s_floor_atmosphere" % prefix,
		"grid_y": 0.054,
		"runner_y": 0.122,
		"line_radius": 0.013,
		"path_radius": 0.020,
		"depth_scroll_speed": 2.0,
		"runner_speed": 5.0,
		"pulse_speed": 1.0,
		"intensity_cap": 0.72,
		"forbidden_clutter": ["floating_shards", "rings", "breathing_glyphs", "random_diagonals", "monoliths", "pylons", "gates"]
	}
	match index:
		0:
			base.merge({
				"name": "Neon Grid",
				"primary_shape": "square",
				"secondary_shape": "rectangle",
				"grid_pattern": "orthogonal_square",
				"grid_spacing": 6.0,
				"runner_speed": 5.2,
				"depth_scroll_speed": 2.3,
				"pulse_speed": 0.95
			}, true)
		1:
			base.merge({
				"name": "Prism Rift",
				"primary_shape": "diamond",
				"secondary_shape": "triangle",
				"grid_pattern": "prism_diamond_lattice",
				"grid_spacing": 9.0,
				"runner_speed": 4.2,
				"depth_scroll_speed": 1.45,
				"pulse_speed": 1.12
			}, true)
		2:
			base.merge({
				"name": "Null Zone",
				"primary_shape": "octagon",
				"secondary_shape": "hexagon",
				"grid_pattern": "null_polygon_cells",
				"grid_spacing": 10.0,
				"runner_speed": 1.45,
				"depth_scroll_speed": 0.72,
				"pulse_speed": 0.58
			}, true)
		_:
			base.merge({
				"name": "Hyper Grid",
				"primary_shape": "stretched_diamond",
				"secondary_shape": "rail",
				"grid_pattern": "hyper_rail_lattice",
				"grid_spacing": 7.0,
				"runner_speed": 11.8,
				"depth_scroll_speed": 8.4,
				"pulse_speed": 1.85
			}, true)
	return base


func _build_sector_arena_floor(design: Dictionary) -> void:
	_add_sector_floor_atmosphere(design)
	match str(design.get("grid_pattern", "")):
		"orthogonal_square":
			_build_neon_grid_floor(design)
		"prism_diamond_lattice":
			_build_prism_rift_floor(design)
		"null_polygon_cells":
			_build_null_zone_floor(design)
		"hyper_rail_lattice":
			_build_hyper_grid_floor(design)
	_build_sector_floor_edge_system(design)


func _add_sector_floor_atmosphere(design: Dictionary) -> void:
	var material_key := str(design["atmosphere_material"])
	match str(design["grid_pattern"]):
		"null_polygon_cells":
			_add_floor_disc("%sBaseAtmospherePlate" % str(design["name"]).replace(" ", ""), 8, ARENA_HALF_SIZE * 0.92, Vector3(0.0, -0.044, 0.0), PI / 8.0, material_key)
		"prism_diamond_lattice":
			_add_floor_diamond("%sBaseAtmosphereDiamond" % str(design["name"]).replace(" ", ""), Vector3(0.0, -0.044, 0.0), Vector2(ARENA_HALF_SIZE * 0.78, ARENA_HALF_SIZE * 0.78), PI * 0.25, material_key)
		_:
			_add_floor_fill_polygon("%sBaseAtmospherePanel" % str(design["name"]).replace(" ", ""), [
				Vector3(-ARENA_HALF_SIZE, -0.046, -ARENA_HALF_SIZE),
				Vector3(ARENA_HALF_SIZE, -0.046, -ARENA_HALF_SIZE),
				Vector3(ARENA_HALF_SIZE, -0.046, ARENA_HALF_SIZE),
				Vector3(-ARENA_HALF_SIZE, -0.046, ARENA_HALF_SIZE)
			], material_key)


func _build_neon_grid_floor(design: Dictionary) -> void:
	var line_material := str(design["line_material"])
	var path_material := str(design["path_material"])
	var core_material := str(design["core_material"])
	var y := float(design["grid_y"])
	var spacing := float(design["grid_spacing"])
	var steps := int((ARENA_HALF_SIZE * 2.0) / spacing)
	for i in range(steps + 1):
		var offset := -ARENA_HALF_SIZE + float(i) * spacing
		var radius := 0.015 if i % 2 == 0 else 0.010
		_add_sector_grid_segment("NeonGridSquareRow%d" % i, Vector3(-ARENA_HALF_SIZE, y, offset), Vector3(ARENA_HALF_SIZE, y, offset), line_material, radius)
		_add_sector_grid_segment("NeonGridSquareColumn%d" % i, Vector3(offset, y, -ARENA_HALF_SIZE), Vector3(offset, y, ARENA_HALF_SIZE), line_material, radius)
	for half_size in [12.0, 24.0]:
		_add_sector_grid_rect_loop("NeonGridCircuitLoop%d" % int(half_size), Vector3.ZERO, Vector2(half_size, half_size), path_material, 0.016, core_material)
	for x in [-24.0, -12.0, 0.0, 12.0, 24.0]:
		_add_sector_grid_light_runner("NeonGridVerticalCircuitRunner%.0f" % x, Vector3(x, float(design["runner_y"]), 0.0), Vector3(0.0, 0.0, -1.0), 7.2, float(design["runner_speed"]), ARENA_HALF_SIZE * 2.0, 0.024, path_material, core_material, x + 15.0, float(design["pulse_speed"]), 0.08)
	for z in [-18.0, 0.0, 18.0]:
		_add_sector_grid_light_runner("NeonGridHorizontalCircuitRunner%.0f" % z, Vector3(0.0, float(design["runner_y"]) + 0.004, z), Vector3(1.0, 0.0, 0.0), 6.4, 3.1, ARENA_HALF_SIZE * 2.0, 0.018, path_material, core_material, z + 8.0, float(design["pulse_speed"]), 0.07)
	for row in range(7):
		var z := -27.0 + float(row) * 9.0
		_add_dynamic_flow_line("NeonGridDepthRow%d" % row, Vector3(-ARENA_HALF_SIZE, 0.084, z), Vector3(ARENA_HALF_SIZE, 0.084, z), Vector3(0.0, 0.0, -1.0), float(design["depth_scroll_speed"]), ARENA_HALF_SIZE * 2.0, 0.010, line_material, core_material, float(row) * 6.0, 0.62, 0.05)


func _build_prism_rift_floor(design: Dictionary) -> void:
	var line_material := str(design["line_material"])
	var secondary_material := str(design["secondary_material"])
	var path_material := str(design["path_material"])
	var core_material := str(design["core_material"])
	var y := float(design["grid_y"])
	var centers_x := [-21.0, -10.5, 0.0, 10.5, 21.0]
	var centers_z := [-20.0, -10.0, 0.0, 10.0, 20.0]
	for row in range(centers_z.size()):
		for column in range(centers_x.size()):
			var offset_x := 5.25 if row % 2 == 1 else 0.0
			var center := Vector3(float(centers_x[column]) + offset_x, y, float(centers_z[row]))
			if absf(center.x) > 26.5:
				continue
			_add_sector_grid_diamond_cell("PrismRiftDiamondCell%d%d" % [row, column], center, Vector2(5.2, 4.0), line_material, 0.013)
			var split_material := secondary_material if (row + column) % 2 == 0 else path_material
			_add_sector_grid_segment("PrismRiftTriangleSplit%d%d" % [row, column], center + Vector3(-5.2, 0.006, 0.0), center + Vector3(5.2, 0.006, 0.0), split_material, 0.009)
	for row in range(centers_z.size()):
		var z := float(centers_z[row])
		_add_sector_grid_polyline("PrismRiftMainCircuitA%d" % row, [
			Vector3(-25.5, y + 0.014, z),
			Vector3(-15.0, y + 0.014, z - 4.0),
			Vector3(-4.5, y + 0.014, z),
			Vector3(6.0, y + 0.014, z - 4.0),
			Vector3(16.5, y + 0.014, z),
			Vector3(27.0, y + 0.014, z - 4.0)
		], path_material, 0.014, core_material)
	for i in range(9):
		var center := Vector3(-21.0 + float(i % 5) * 10.5, float(design["runner_y"]), -16.0 + float(i / 5) * 20.0)
		var direction := Vector3(1.0, 0.0, -0.72) if i % 2 == 0 else Vector3(1.0, 0.0, 0.72)
		_add_sector_grid_light_runner("PrismRiftDiamondCircuitRunner%d" % i, center, direction, 5.0, float(design["runner_speed"]), 34.0, 0.022, path_material, core_material, float(i) * 3.8, float(design["pulse_speed"]), 0.10)
	for row in range(5):
		var z := -22.0 + float(row) * 11.0
		_add_dynamic_flow_line("PrismRiftDepthLatticeRow%d" % row, Vector3(-24.0, 0.086, z), Vector3(24.0, 0.086, z), Vector3(0.0, 0.0, -1.0), float(design["depth_scroll_speed"]), 44.0, 0.009, secondary_material, core_material, float(row) * 5.2, 0.52, 0.05)


func _build_null_zone_floor(design: Dictionary) -> void:
	var line_material := str(design["line_material"])
	var secondary_material := str(design["secondary_material"])
	var path_material := str(design["path_material"])
	var core_material := str(design["core_material"])
	var y := float(design["grid_y"])
	var center_positions: Array[Vector3] = [Vector3.ZERO]
	for angle_index in range(8):
		var angle := TAU * float(angle_index) / 8.0
		center_positions.append(Vector3(cos(angle) * 16.0, 0.0, sin(angle) * 16.0))
	for i in range(center_positions.size()):
		var center := Vector3(center_positions[i].x, y, center_positions[i].z)
		_add_sector_grid_polygon_cell("NullZoneOctagonCell%d" % i, 8, center, 5.0 if i == 0 else 3.7, PI / 8.0, line_material, 0.013)
	for angle_index in range(8):
		var angle := TAU * (float(angle_index) + 0.5) / 8.0
		var center := Vector3(cos(angle) * 9.2, y + 0.006, sin(angle) * 9.2)
		_add_sector_grid_polygon_cell("NullZoneHexConnector%d" % angle_index, 6, center, 2.5, PI / 6.0, secondary_material, 0.010)
	for i in range(8):
		var angle := TAU * float(i) / 8.0 + PI / 8.0
		var edge_center := Vector3(cos(angle) * 16.0, float(design["runner_y"]), sin(angle) * 16.0)
		var edge_direction := Vector3(-sin(angle), 0.0, cos(angle))
		_add_sector_grid_light_runner("NullZoneOctagonEdgeRunner%d" % i, edge_center, edge_direction, 2.7, float(design["runner_speed"]), 12.0, 0.020, path_material, core_material, float(i) * 1.9, float(design["pulse_speed"]), 0.07)
	for row in range(5):
		var z := -22.0 + float(row) * 11.0
		_add_dynamic_flow_line("NullZoneDepthPolygonRow%d" % row, Vector3(-24.0, 0.082, z), Vector3(24.0, 0.082, z), Vector3(0.0, 0.0, -1.0), float(design["depth_scroll_speed"]), 42.0, 0.008, secondary_material, core_material, float(row) * 7.0, 0.42, 0.04)


func _build_hyper_grid_floor(design: Dictionary) -> void:
	var line_material := str(design["line_material"])
	var secondary_material := str(design["secondary_material"])
	var path_material := str(design["path_material"])
	var core_material := str(design["core_material"])
	var y := float(design["grid_y"])
	var rail_offsets := [-24.0, -16.0, -8.0, 0.0, 8.0, 16.0, 24.0]
	for i in range(rail_offsets.size()):
		var x := float(rail_offsets[i])
		var lean := 4.8 if i % 2 == 0 else -4.8
		_add_sector_grid_segment("HyperGridRailLane%d" % i, Vector3(x, y, -ARENA_HALF_SIZE), Vector3(x + lean, y, ARENA_HALF_SIZE), line_material, 0.014)
	for row in range(7):
		var z := -27.0 + float(row) * 9.0
		_add_sector_grid_segment("HyperGridConnectedCrossbar%d" % row, Vector3(-ARENA_HALF_SIZE, y + 0.006, z), Vector3(ARENA_HALF_SIZE, y + 0.006, z + 3.4), secondary_material, 0.010)
	for row in range(5):
		for column in range(4):
			var center := Vector3(-18.0 + float(column) * 12.0, y + 0.012, -22.0 + float(row) * 11.0)
			_add_sector_grid_diamond_cell("HyperGridRailDiamond%d%d" % [row, column], center, Vector2(5.8, 2.2), path_material if row == 2 else secondary_material, 0.011)
	for i in range(9):
		var x := -22.0 + float(i) * 5.5
		_add_sector_grid_light_runner("HyperGridLaneLightRunner%d" % i, Vector3(x, float(design["runner_y"]), 5.0 - float(i % 3) * 5.0), Vector3(0.08, 0.0, -1.0), 8.8, float(design["runner_speed"]), ARENA_HALF_SIZE * 2.0, 0.026, path_material, core_material, float(i) * 2.6, float(design["pulse_speed"]), 0.09)
	for row in range(8):
		var z := -30.0 + float(row) * 8.0
		_add_dynamic_flow_line("HyperGridDepthRailBand%d" % row, Vector3(-ARENA_HALF_SIZE, 0.084, z), Vector3(ARENA_HALF_SIZE, 0.084, z + 3.4), Vector3(0.0, 0.0, -1.0), float(design["depth_scroll_speed"]), ARENA_HALF_SIZE * 2.0, 0.011, secondary_material, core_material, float(row) * 3.6, 0.75, 0.05)


func _build_sector_floor_edge_system(design: Dictionary) -> void:
	var edge_material := str(design["edge_material"])
	var core_material := str(design["core_material"])
	var inset := ARENA_HALF_SIZE - 1.15
	var y := 0.072
	var corners: Array[Vector3] = [
		Vector3(-inset, y, -inset),
		Vector3(inset, y, -inset),
		Vector3(inset, y, inset),
		Vector3(-inset, y, inset)
	]
	for i in range(corners.size()):
		_add_sector_grid_segment("%sEdgeRail%d" % [str(design["name"]).replace(" ", ""), i], corners[i], corners[(i + 1) % corners.size()], edge_material, 0.020, core_material)
	var runner_speed := maxf(2.2, float(design["runner_speed"]) * 0.55)
	_add_sector_grid_light_runner("%sNorthEdgeRunner" % str(design["name"]).replace(" ", ""), Vector3(0.0, 0.124, -inset), Vector3(1.0, 0.0, 0.0), 7.8, runner_speed, inset * 2.0, 0.020, edge_material, core_material, 2.0, float(design["pulse_speed"]), 0.06)
	_add_sector_grid_light_runner("%sSouthEdgeRunner" % str(design["name"]).replace(" ", ""), Vector3(0.0, 0.124, inset), Vector3(-1.0, 0.0, 0.0), 7.8, runner_speed, inset * 2.0, 0.020, edge_material, core_material, 9.0, float(design["pulse_speed"]), 0.06)
	_add_sector_grid_light_runner("%sWestEdgeRunner" % str(design["name"]).replace(" ", ""), Vector3(-inset, 0.124, 0.0), Vector3(0.0, 0.0, -1.0), 7.8, runner_speed, inset * 2.0, 0.020, edge_material, core_material, 5.0, float(design["pulse_speed"]), 0.06)
	_add_sector_grid_light_runner("%sEastEdgeRunner" % str(design["name"]).replace(" ", ""), Vector3(inset, 0.124, 0.0), Vector3(0.0, 0.0, 1.0), 7.8, runner_speed, inset * 2.0, 0.020, edge_material, core_material, 12.0, float(design["pulse_speed"]), 0.06)


func _create_neon_grid_sector_marks() -> void:
	_add_floor_polygon_marker("NeonGridNorthTriangle", 3, 2.4, Vector3(0.0, 0.0, -18.0), -PI * 0.5, "sector1_shape")
	_add_floor_polygon_marker("NeonGridSouthTriangle", 3, 2.4, Vector3(0.0, 0.0, 18.0), PI * 0.5, "sector1_shape")
	_add_floor_polygon_marker("NeonGridWestPrismMarker", 3, 1.8, Vector3(-18.0, 0.0, 0.0), PI, "sector1_shape")
	_add_floor_polygon_marker("NeonGridEastPrismMarker", 3, 1.8, Vector3(18.0, 0.0, 0.0), 0.0, "sector1_shape")


func _create_prism_rift_sector_marks() -> void:
	_add_floor_polygon_marker("PrismRiftCenterHex", 6, 4.0, Vector3.ZERO, PI / 6.0, "sector2_shape")
	_add_floor_polygon_marker("PrismRiftNorthHex", 6, 2.2, Vector3(-11.0, 0.0, -14.0), PI / 6.0, "sector2_shape")
	_add_floor_polygon_marker("PrismRiftSouthHex", 6, 2.2, Vector3(12.0, 0.0, 14.0), PI / 6.0, "sector2_shape")
	_add_floor_fracture("PrismRiftSplitShardA", Vector3(-21.0, 0.08, -8.0), Vector3(-5.0, 0.08, 7.0), "sector2_shape")
	_add_floor_fracture("PrismRiftSplitShardB", Vector3(6.0, 0.08, -12.0), Vector3(22.0, 0.08, 3.0), "sector2_shape")


func _create_null_zone_sector_marks() -> void:
	_add_floor_polygon_marker("NullZoneCenterOctagon", 8, 4.7, Vector3.ZERO, PI / 8.0, "sector3_shape")
	_add_floor_polygon_marker("NullZoneNorthVoid", 8, 2.5, Vector3(13.0, 0.0, -15.0), PI / 8.0, "sector3_shape")
	_add_floor_polygon_marker("NullZoneSouthVoid", 8, 2.5, Vector3(-13.0, 0.0, 15.0), PI / 8.0, "sector3_shape")
	_add_floor_fracture("NullZoneDarkRailA", Vector3(-22.0, 0.08, 11.0), Vector3(22.0, 0.08, -11.0), "sector3_shape")
	_add_floor_fracture("NullZoneDarkRailB", Vector3(-17.0, 0.08, -18.0), Vector3(17.0, 0.08, 18.0), "sector3_shape")


func _create_hyper_grid_sector_marks() -> void:
	_add_floor_rect_marker("HyperGridCenterSpeedDiamond", Vector2(6.2, 2.2), Vector3.ZERO, PI * 0.25, "sector4_shape")
	_add_floor_rect_marker("HyperGridWestRailPlate", Vector2(7.8, 1.0), Vector3(-13.0, 0.0, -8.0), PI * 0.08, "sector4_shape")
	_add_floor_rect_marker("HyperGridEastRailPlate", Vector2(7.8, 1.0), Vector3(13.0, 0.0, 8.0), PI * 0.08, "sector4_shape")
	_add_floor_polygon_marker("HyperGridNorthSpeedDiamond", 4, 2.0, Vector3(0.0, 0.0, -18.0), PI * 0.25, "sector4_shape")
	_add_floor_polygon_marker("HyperGridSouthSpeedDiamond", 4, 2.0, Vector3(0.0, 0.0, 18.0), PI * 0.25, "sector4_shape")
	_add_floor_fracture("HyperGridRailA", Vector3(-22.0, 0.08, -15.0), Vector3(22.0, 0.08, -7.0), "sector4_shape")
	_add_floor_fracture("HyperGridRailB", Vector3(-22.0, 0.08, 7.0), Vector3(22.0, 0.08, 15.0), "sector4_shape")
	_add_floor_fracture("HyperGridArrowSpine", Vector3(-10.0, 0.08, 0.0), Vector3(10.0, 0.08, 0.0), "sector4_shape")


func _add_floor_polygon_marker(marker_name: String, sides: int, radius: float, center: Vector3, rotation_offset: float, material_key: String) -> void:
	if not is_instance_valid(_sector_geometry_root):
		return
	var points: Array = []
	var edges: Array = []
	var side_count := maxi(3, sides)
	for i in range(side_count):
		var angle := rotation_offset + TAU * float(i) / float(side_count)
		points.append(Vector3(center.x + cos(angle) * radius, 0.075, center.z + sin(angle) * radius))
		edges.append([i, (i + 1) % side_count])
	var core_key := "%s_core" % material_key
	var core_material: Material = _materials[core_key] if _materials.has(core_key) else _materials["soft_white"]
	Kit.add_mesh(_sector_geometry_root, "%sOuterTube" % marker_name, Kit.tube_edge_mesh(points, edges, 0.046, 8), _materials[material_key])
	Kit.add_mesh(_sector_geometry_root, "%sWhiteHotCore" % marker_name, Kit.tube_edge_mesh(points, edges, 0.016, 6), core_material)


func _add_floor_rect_marker(marker_name: String, size: Vector2, center: Vector3, rotation_offset: float, material_key: String) -> void:
	if not is_instance_valid(_sector_geometry_root):
		return
	var half := size * 0.5
	var local_points := [
		Vector2(-half.x, -half.y),
		Vector2(half.x, -half.y),
		Vector2(half.x, half.y),
		Vector2(-half.x, half.y)
	]
	var points: Array = []
	for point in local_points:
		var rotated: Vector2 = Vector2(point).rotated(rotation_offset)
		points.append(Vector3(center.x + rotated.x, 0.075, center.z + rotated.y))
	var edges: Array = [[0, 1], [1, 2], [2, 3], [3, 0]]
	var core_key := "%s_core" % material_key
	var core_material: Material = _materials[core_key] if _materials.has(core_key) else _materials["soft_white"]
	Kit.add_mesh(_sector_geometry_root, "%sOuterTube" % marker_name, Kit.tube_edge_mesh(points, edges, 0.044, 8), _materials[material_key])
	Kit.add_mesh(_sector_geometry_root, "%sWhiteHotCore" % marker_name, Kit.tube_edge_mesh(points, edges, 0.015, 6), core_material)


func _add_floor_fracture(fracture_name: String, start: Vector3, end: Vector3, material_key: String) -> void:
	if not is_instance_valid(_sector_geometry_root):
		return
	var core_key := "%s_core" % material_key
	var core_material: Material = _materials[core_key] if _materials.has(core_key) else _materials["soft_white"]
	Kit.tube_between(_sector_geometry_root, "%sOuterTube" % fracture_name, start, end, 0.050, _materials[material_key], 8)
	Kit.tube_between(_sector_geometry_root, "%sWhiteHotCore" % fracture_name, start, end, 0.016, core_material, 6)


func _add_sector_grid_segment(node_name: String, start: Vector3, end: Vector3, material_key: String, radius := 0.014, core_material_key := "") -> void:
	if not is_instance_valid(_sector_background_root):
		return
	if not _materials.has(material_key):
		return
	Kit.tube_between(_sector_background_root, "%sGridTube" % node_name, start, end, radius, _materials[material_key], 6)
	if core_material_key != "" and _materials.has(core_material_key):
		Kit.tube_between(_sector_background_root, "%sGridCore" % node_name, start + Vector3(0.0, 0.006, 0.0), end + Vector3(0.0, 0.006, 0.0), maxf(0.005, radius * 0.34), _materials[core_material_key], 5)


func _add_sector_grid_polyline(node_name: String, points: Array, material_key: String, radius := 0.014, core_material_key := "") -> void:
	if points.size() < 2:
		return
	for i in range(points.size() - 1):
		_add_sector_grid_segment("%sSegment%d" % [node_name, i], Vector3(points[i]), Vector3(points[i + 1]), material_key, radius, core_material_key)


func _add_sector_grid_rect_loop(node_name: String, center: Vector3, half_size: Vector2, material_key: String, radius := 0.014, core_material_key := "") -> void:
	var points: Array = [
		Vector3(center.x - half_size.x, center.y + 0.066, center.z - half_size.y),
		Vector3(center.x + half_size.x, center.y + 0.066, center.z - half_size.y),
		Vector3(center.x + half_size.x, center.y + 0.066, center.z + half_size.y),
		Vector3(center.x - half_size.x, center.y + 0.066, center.z + half_size.y),
		Vector3(center.x - half_size.x, center.y + 0.066, center.z - half_size.y)
	]
	_add_sector_grid_polyline(node_name, points, material_key, radius, core_material_key)


func _add_sector_grid_diamond_cell(node_name: String, center: Vector3, half_size: Vector2, material_key: String, radius := 0.014, core_material_key := "") -> void:
	var points: Array = [
		Vector3(center.x, center.y, center.z - half_size.y),
		Vector3(center.x + half_size.x, center.y, center.z),
		Vector3(center.x, center.y, center.z + half_size.y),
		Vector3(center.x - half_size.x, center.y, center.z),
		Vector3(center.x, center.y, center.z - half_size.y)
	]
	_add_sector_grid_polyline(node_name, points, material_key, radius, core_material_key)


func _add_sector_grid_polygon_cell(node_name: String, sides: int, center: Vector3, radius: float, rotation_offset: float, material_key: String, tube_radius := 0.014, core_material_key := "") -> void:
	if not is_instance_valid(_sector_background_root) or not _materials.has(material_key):
		return
	var points: Array = []
	var edges: Array = []
	var side_count := maxi(3, sides)
	for i in range(side_count):
		var angle := rotation_offset + TAU * float(i) / float(side_count)
		points.append(Vector3(center.x + cos(angle) * radius, center.y, center.z + sin(angle) * radius))
		edges.append([i, (i + 1) % side_count])
	Kit.add_mesh(_sector_background_root, "%sGridCell" % node_name, Kit.tube_edge_mesh(points, edges, tube_radius, 6), _materials[material_key])
	if core_material_key != "" and _materials.has(core_material_key):
		var raised_points: Array = []
		for point in points:
			raised_points.append(Vector3(point) + Vector3(0.0, 0.006, 0.0))
		Kit.add_mesh(_sector_background_root, "%sGridCellCore" % node_name, Kit.tube_edge_mesh(raised_points, edges, maxf(0.005, tube_radius * 0.34), 5), _materials[core_material_key])


func _add_sector_grid_diagonal_family(node_prefix: String, slope: float, spacing: float, y: float, material_key: String, radius := 0.014) -> void:
	if absf(slope) < 0.001:
		return
	var limit := ARENA_HALF_SIZE
	var count := int((limit * 4.0) / spacing) + 1
	for i in range(count):
		var c := -limit * 2.0 + float(i) * spacing
		var intersections: Array[Vector3] = []
		for x_value in [-limit, limit]:
			var x := float(x_value)
			var z := slope * x + c
			if z >= -limit and z <= limit:
				intersections.append(Vector3(x, y, z))
		for z_value in [-limit, limit]:
			var z := float(z_value)
			var x := (z - c) / slope
			if x >= -limit and x <= limit:
				intersections.append(Vector3(x, y, z))
		if intersections.size() >= 2:
			_add_sector_grid_segment("%s%d" % [node_prefix, i], intersections[0], intersections[1], material_key, radius)


func _add_sector_grid_light_runner(node_name: String, center: Vector3, direction: Vector3, length: float, speed: float, wrap_distance: float, radius: float, material_key: String, core_material_key: String, phase: float, pulse_speed := 1.0, pulse_amount := 0.10) -> void:
	var travel_direction := direction.normalized()
	if travel_direction.length_squared() < 0.001:
		travel_direction = Vector3.FORWARD
	var half_segment := travel_direction * maxf(0.2, length * 0.5)
	_add_dynamic_flow_line(node_name, center - half_segment, center + half_segment, travel_direction, speed, wrap_distance, radius, material_key, core_material_key, phase, pulse_speed, pulse_amount)


func _add_floor_lane_fill(node_name: String, start: Vector3, end: Vector3, width: float, material_key: String) -> void:
	var delta := end - start
	delta.y = 0.0
	if delta.length_squared() < 0.001:
		return
	var direction := delta.normalized()
	var side := Vector3(-direction.z, 0.0, direction.x) * width * 0.5
	_add_floor_fill_polygon(node_name, [
		start + side,
		end + side,
		end - side,
		start - side
	], material_key)


func _add_floor_diamond(node_name: String, center: Vector3, size: Vector2, rotation_offset: float, material_key: String) -> void:
	var points: Array = []
	var local_points := [
		Vector2(0.0, -size.x),
		Vector2(size.y, 0.0),
		Vector2(0.0, size.x),
		Vector2(-size.y, 0.0)
	]
	for point in local_points:
		var rotated := Vector2(point).rotated(rotation_offset)
		points.append(Vector3(center.x + rotated.x, center.y, center.z + rotated.y))
	_add_floor_fill_polygon(node_name, points, material_key)


func _add_floor_disc(node_name: String, sides: int, radius: float, center: Vector3, rotation_offset: float, material_key: String) -> void:
	var points: Array = []
	var side_count := maxi(3, sides)
	for i in range(side_count):
		var angle := rotation_offset + TAU * float(i) / float(side_count)
		points.append(Vector3(center.x + cos(angle) * radius, center.y - 0.038, center.z + sin(angle) * radius))
	_add_floor_fill_polygon(node_name, points, material_key)


func _add_floor_fill_polygon(node_name: String, points: Array, material_key: String) -> void:
	if not is_instance_valid(_sector_background_root) or points.size() < 3:
		return
	var center := Vector3.ZERO
	for point in points:
		center += Vector3(point)
	center /= float(points.size())
	var mesh := ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES, _materials[material_key])
	for i in range(points.size()):
		mesh.surface_add_vertex(center)
		mesh.surface_add_vertex(points[i])
		mesh.surface_add_vertex(points[(i + 1) % points.size()])
	mesh.surface_end()
	Kit.add_mesh(_sector_background_root, node_name, mesh, null)


func _add_background_pylon(node_name: String, center: Vector3, size: Vector3, body_material_key: String, edge_material_key: String) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var root := Node3D.new()
	root.name = node_name
	root.position = center
	_sector_background_root.add_child(root)
	Kit.add_mesh(root, "%sDarkGlassBody" % node_name, Kit.box_mesh(size), _materials[body_material_key])
	Kit.add_glowing_edges(root, "%sNeonEdge" % node_name, Kit.box_points(size), Kit.box_edges(), 0.030, 0.010, _materials[edge_material_key], _materials["soft_white"])


func _add_background_shard(node_name: String, center: Vector3, size: Vector3, rotation_y: float, body_material_key: String, edge_material_key: String, phase: float) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var root := Node3D.new()
	root.name = node_name
	root.position = center
	root.rotation = Vector3(0.18, rotation_y, 0.38)
	_sector_background_root.add_child(root)
	Kit.add_mesh(root, "%sDarkPrismBody" % node_name, Kit.box_mesh(size), _materials[body_material_key])
	Kit.add_glowing_edges(root, "%sNeonEdge" % node_name, Kit.box_points(size), Kit.box_edges(), 0.024, 0.009, _materials[edge_material_key], _materials["soft_white"])
	_register_sector_motion_node(root, center, Vector3(0.0, 1.0, 0.0), 0.22, 0.55, phase, Vector3(0.0, 0.18, 0.08))


func _add_far_rail_arch(node_name: String, start: Vector3, end: Vector3, support_height: float, edge_material_key: String, core_material_key: String) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	Kit.tube_between(_sector_background_root, "%sOuterRail" % node_name, start, end, 0.045, _materials[edge_material_key], 8)
	Kit.tube_between(_sector_background_root, "%sCoreRail" % node_name, start, end, 0.014, _materials[core_material_key], 6)
	for pair in [[start, "%sStartSupport" % node_name], [end, "%sEndSupport" % node_name]]:
		var base: Vector3 = pair[0]
		var top := base + Vector3(0.0, support_height, 0.0)
		Kit.tube_between(_sector_background_root, "%sOuter" % str(pair[1]), base, top, 0.035, _materials[edge_material_key], 8)
		Kit.tube_between(_sector_background_root, "%sCore" % str(pair[1]), base, top, 0.011, _materials[core_material_key], 6)


func _add_wall_polygon_marker(node_name: String, sides: int, radius: float, center: Vector3, plane: String, rotation_offset: float, material_key: String) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var points: Array = []
	var edges: Array = []
	var side_count := maxi(3, sides)
	for i in range(side_count):
		var angle := rotation_offset + TAU * float(i) / float(side_count)
		match plane:
			"east", "west":
				points.append(Vector3(center.x, center.y + sin(angle) * radius, center.z + cos(angle) * radius))
			_:
				points.append(Vector3(center.x + cos(angle) * radius, center.y + sin(angle) * radius, center.z))
		edges.append([i, (i + 1) % side_count])
	Kit.add_mesh(_sector_background_root, "%sOuterWallGlyph" % node_name, Kit.tube_edge_mesh(points, edges, 0.040, 8), _materials[material_key])
	Kit.add_mesh(_sector_background_root, "%sCoreWallGlyph" % node_name, Kit.tube_edge_mesh(points, edges, 0.013, 6), _materials["soft_white"])


func _add_dynamic_flow_line(node_name: String, base_start: Vector3, base_end: Vector3, direction: Vector3, speed: float, wrap_distance: float, radius: float, material_key: String, core_material_key: String, phase: float, pulse_speed := 1.0, pulse_amount := 0.25) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var normalized_direction := direction.normalized()
	if normalized_direction.length_squared() < 0.001:
		normalized_direction = Vector3.FORWARD
	var outer := Kit.tube_between(_sector_background_root, "%sOuterFlow" % node_name, base_start, base_end, radius, _materials[material_key], 8)
	var core := Kit.tube_between(_sector_background_root, "%sCoreFlow" % node_name, base_start, base_end, maxf(0.007, radius * 0.34), _materials[core_material_key], 6)
	_sector_flow_lines.append({
		"outer": outer,
		"core": core,
		"base_start": base_start,
		"base_end": base_end,
		"direction": normalized_direction,
		"speed": speed,
		"wrap": maxf(1.0, wrap_distance),
		"phase": phase,
		"radius": radius,
		"pulse_speed": pulse_speed,
		"pulse_amount": pulse_amount
	})


func _add_dynamic_pulse_ring(node_name: String, center: Vector3, radius: float, material_key: String, core_material_key: String, pulse_speed: float, phase: float, spin_speed: float, scale_amount: float) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var root := Node3D.new()
	root.name = node_name
	root.position = center + Vector3(0.0, 0.135, 0.0)
	_sector_background_root.add_child(root)
	var outer := Kit.add_mesh(root, "%sOuterPulseRing" % node_name, Kit.torus_mesh(radius, 0.035, 72, 5), _materials[material_key])
	var core := Kit.add_mesh(root, "%sCorePulseRing" % node_name, Kit.torus_mesh(radius, 0.010, 72, 4), _materials[core_material_key])
	_sector_pulse_nodes.append({
		"root": root,
		"outer": outer,
		"core": core,
		"base_scale": Vector3.ONE,
		"pulse_speed": pulse_speed,
		"phase": phase,
		"spin": spin_speed,
		"scale_amount": scale_amount,
		"mode": "ring"
	})


func _add_dynamic_polygon_glyph(node_name: String, sides: int, radius: float, center: Vector3, plane: String, rotation_offset: float, material_key: String, spin_speed: float, pulse_speed: float, phase: float, scale_amount: float) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var root := Node3D.new()
	root.name = node_name
	root.position = center
	_sector_background_root.add_child(root)
	var points: Array = []
	var edges: Array = []
	var side_count := maxi(3, sides)
	for i in range(side_count):
		var angle := rotation_offset + TAU * float(i) / float(side_count)
		match plane:
			"north", "south":
				points.append(Vector3(cos(angle) * radius, sin(angle) * radius, 0.0))
			"east", "west":
				points.append(Vector3(0.0, sin(angle) * radius, cos(angle) * radius))
			_:
				points.append(Vector3(cos(angle) * radius, 0.0, sin(angle) * radius))
		edges.append([i, (i + 1) % side_count])
	var outer := Kit.add_mesh(root, "%sOuterDynamicGlyph" % node_name, Kit.tube_edge_mesh(points, edges, 0.038, 8), _materials[material_key])
	var core := Kit.add_mesh(root, "%sCoreDynamicGlyph" % node_name, Kit.tube_edge_mesh(points, edges, 0.012, 6), _materials["soft_white"])
	_sector_pulse_nodes.append({
		"root": root,
		"outer": outer,
		"core": core,
		"base_scale": Vector3.ONE,
		"pulse_speed": pulse_speed,
		"phase": phase,
		"spin": spin_speed,
		"scale_amount": scale_amount,
		"mode": "glyph"
	})


func _add_dynamic_sweeping_polygon(node_name: String, sides: int, radius: float, center: Vector3, direction: Vector3, speed: float, wrap_distance: float, material_key: String, phase: float, rotation_offset: float) -> void:
	if not is_instance_valid(_sector_background_root):
		return
	var root := Node3D.new()
	root.name = node_name
	root.position = center
	_sector_background_root.add_child(root)
	var points: Array = []
	var edges: Array = []
	var side_count := maxi(3, sides)
	for i in range(side_count):
		var angle := rotation_offset + TAU * float(i) / float(side_count)
		points.append(Vector3(cos(angle) * radius, 0.0, sin(angle) * radius))
		edges.append([i, (i + 1) % side_count])
	Kit.add_mesh(root, "%sOuterSweepGlyph" % node_name, Kit.tube_edge_mesh(points, edges, 0.034, 8), _materials[material_key])
	Kit.add_mesh(root, "%sCoreSweepGlyph" % node_name, Kit.tube_edge_mesh(points, edges, 0.011, 6), _materials["soft_white"])
	var normalized_direction := direction.normalized()
	if normalized_direction.length_squared() < 0.001:
		normalized_direction = Vector3.FORWARD
	_sector_sweep_nodes.append({
		"root": root,
		"base": center,
		"direction": normalized_direction,
		"speed": speed,
		"wrap": maxf(1.0, wrap_distance),
		"phase": phase,
		"spin": 0.8 + speed * 0.035
	})


func _register_sector_motion_node(node: Node3D, base_position: Vector3, axis: Vector3, amplitude: float, speed: float, phase: float, spin: Vector3) -> void:
	_sector_motion_nodes.append({
		"node": node,
		"base": base_position,
		"axis": axis.normalized(),
		"amplitude": amplitude,
		"speed": speed,
		"phase": phase,
		"base_rotation": node.rotation,
		"spin": spin
	})


func _trigger_sector_transition_scan() -> void:
	if not is_instance_valid(_sector_transition_root):
		return
	for child in _sector_transition_root.get_children():
		_sector_transition_root.remove_child(child)
		child.queue_free()
	_sector_transition_nodes.clear()
	_sector_transition_timer = _sector_transition_duration
	var prefix := _sector_material_prefix()
	var outer_material: Material = _materials["%s_shape" % prefix] if _materials.has("%s_shape" % prefix) else _materials["sector_transition_scan"]
	for i in range(4):
		var outer := Kit.tube_between(_sector_transition_root, "SectorTransitionScanOuter%d" % i, Vector3(-ARENA_HALF_SIZE, 0.18, -ARENA_HALF_SIZE), Vector3(ARENA_HALF_SIZE, 0.18, -ARENA_HALF_SIZE), 0.038, outer_material, 8)
		var core := Kit.tube_between(_sector_transition_root, "SectorTransitionScanCore%d" % i, Vector3(-ARENA_HALF_SIZE, 0.19, -ARENA_HALF_SIZE), Vector3(ARENA_HALF_SIZE, 0.19, -ARENA_HALF_SIZE), 0.012, _materials["sector_transition_scan"], 6)
		_sector_transition_nodes.append({"outer": outer, "core": core, "offset": float(i) * 0.10})
	_update_sector_transition_effect(0.0)


func _update_sector_background_motion(delta: float) -> void:
	if _sector_background_reaction > 0.0:
		_sector_background_reaction = maxf(0.0, _sector_background_reaction - _sector_background_reaction_decay * delta)
	var reaction := _sector_background_reaction
	_update_hd_sector_background_intensity()
	for data in _sector_motion_nodes:
		var node: Node3D = data.get("node", null)
		if not is_instance_valid(node):
			continue
		var phase := float(data.get("phase", 0.0)) + _survival_time * float(data.get("speed", 0.5))
		var base: Vector3 = data.get("base", Vector3.ZERO)
		var axis: Vector3 = data.get("axis", Vector3.UP)
		node.position = base + axis * sin(phase) * float(data.get("amplitude", 0.0)) * (1.0 + reaction * 0.45)
		var base_rotation: Vector3 = data.get("base_rotation", Vector3.ZERO)
		var spin: Vector3 = data.get("spin", Vector3.ZERO)
		node.rotation = base_rotation + spin * sin(phase * 0.85 + reaction * 0.8)
	for data in _sector_flow_lines:
		var outer: MeshInstance3D = data.get("outer", null)
		var core: MeshInstance3D = data.get("core", null)
		var base_start: Vector3 = data.get("base_start", Vector3.ZERO)
		var base_end: Vector3 = data.get("base_end", Vector3.ZERO)
		var direction: Vector3 = data.get("direction", Vector3.FORWARD)
		var wrap := float(data.get("wrap", ARENA_HALF_SIZE * 2.0))
		var offset := fposmod(_survival_time * float(data.get("speed", 1.0)) + float(data.get("phase", 0.0)), wrap) - wrap * 0.5
		var pulse := 1.0 + sin(_survival_time * float(data.get("pulse_speed", 1.0)) + float(data.get("phase", 0.0))) * float(data.get("pulse_amount", 0.2)) + reaction * 0.40
		var radius := float(data.get("radius", 0.02)) * clampf(pulse, 0.45, 1.85)
		var shift := direction * offset
		if is_instance_valid(outer):
			Kit.update_tube(outer, base_start + shift, base_end + shift, radius)
		if is_instance_valid(core):
			Kit.update_tube(core, base_start + shift + Vector3(0.0, 0.012, 0.0), base_end + shift + Vector3(0.0, 0.012, 0.0), maxf(0.006, radius * 0.32))
	for data in _sector_pulse_nodes:
		var root: Node3D = data.get("root", null)
		if not is_instance_valid(root):
			continue
		var phase := _survival_time * float(data.get("pulse_speed", 1.0)) + float(data.get("phase", 0.0))
		var scale_amount := float(data.get("scale_amount", 0.1))
		var scale := 1.0 + sin(phase) * scale_amount + reaction * 0.22
		root.scale = Vector3.ONE * clampf(scale, 0.72, 1.42)
		root.rotation.y += float(data.get("spin", 0.0)) * delta * (1.0 + reaction * 0.8)
	for data in _sector_sweep_nodes:
		var root: Node3D = data.get("root", null)
		if not is_instance_valid(root):
			continue
		var base: Vector3 = data.get("base", Vector3.ZERO)
		var direction: Vector3 = data.get("direction", Vector3.FORWARD)
		var wrap := float(data.get("wrap", ARENA_HALF_SIZE * 2.0))
		var offset := fposmod(_survival_time * float(data.get("speed", 1.0)) + float(data.get("phase", 0.0)), wrap) - wrap * 0.5
		root.position = base + direction * offset
		root.rotation.y += float(data.get("spin", 1.0)) * delta * (1.0 + reaction)
		root.scale = Vector3.ONE * (1.0 + reaction * 0.18)


func _trigger_sector_background_reaction(strength: float, duration := 0.55) -> void:
	var vfx_multiplier := 0.55 if _vfx_intensity == 0 else 1.12 if _vfx_intensity == 2 else 1.0
	_sector_background_reaction = minf(1.0, maxf(_sector_background_reaction, strength * vfx_multiplier))
	_sector_background_reaction_decay = _sector_background_reaction / maxf(0.08, duration)


func _update_sector_transition_effect(delta: float) -> void:
	if _sector_transition_timer <= 0.0:
		return
	_sector_transition_timer = maxf(0.0, _sector_transition_timer - delta)
	var progress := 1.0 - (_sector_transition_timer / maxf(0.001, _sector_transition_duration))
	for data in _sector_transition_nodes:
		var outer: MeshInstance3D = data.get("outer", null)
		var core: MeshInstance3D = data.get("core", null)
		var offset := float(data.get("offset", 0.0))
		var local_progress := clampf((progress - offset) / 0.72, 0.0, 1.0)
		var visible := local_progress > 0.0 and local_progress < 1.0 and _sector_transition_timer > 0.0
		var z := lerpf(-ARENA_HALF_SIZE - 4.0, ARENA_HALF_SIZE + 4.0, local_progress)
		var start := Vector3(-ARENA_HALF_SIZE - 1.5, 0.20, z)
		var end := Vector3(ARENA_HALF_SIZE + 1.5, 0.20, z)
		if is_instance_valid(outer):
			outer.visible = visible
			Kit.update_tube(outer, start, end, 0.038)
		if is_instance_valid(core):
			core.visible = visible
			Kit.update_tube(core, start + Vector3(0.0, 0.014, 0.0), end + Vector3(0.0, 0.014, 0.0), 0.012)
	if _sector_transition_timer <= 0.0 and is_instance_valid(_sector_transition_root):
		for child in _sector_transition_root.get_children():
			child.visible = false


func _create_atmosphere() -> void:
	_dust_batch = Kit.create_spark_multimesh(_gameplay_root, "LowPriorityBatchedNeonDust", Kit.sphere_mesh(0.026, 6, 3), _materials["dust"], DUST_COUNT)
	for i in range(DUST_COUNT):
		_dust_data.append({
			"position": Vector3(randf_range(-ARENA_HALF_SIZE, ARENA_HALF_SIZE), randf_range(0.18, 1.15), randf_range(-ARENA_HALF_SIZE, ARENA_HALF_SIZE)),
			"phase": randf() * TAU,
			"speed": randf_range(0.18, 0.46)
		})
	_update_atmosphere()


func _update_atmosphere() -> void:
	if not is_instance_valid(_dust_batch):
		return
	for i in range(_dust_data.size()):
		var data: Dictionary = _dust_data[i]
		var position: Vector3 = data["position"]
		var phase: float = data["phase"] + _survival_time * float(data["speed"])
		var drift := Vector3(sin(phase) * 0.22, sin(phase * 0.7) * 0.10, cos(phase) * 0.22)
		var scale := 0.62 + sin(phase * 1.9) * 0.24
		_dust_batch.multimesh.set_instance_transform(i, Transform3D(Basis.IDENTITY.scaled(Vector3.ONE * scale), position + drift))


func _build_grid_surface(mesh: ImmediateMesh, spacing: float, material: Material, axis_only: bool) -> void:
	mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	if axis_only:
		mesh.surface_add_vertex(Vector3(-ARENA_HALF_SIZE, -0.015, 0.0))
		mesh.surface_add_vertex(Vector3(ARENA_HALF_SIZE, -0.015, 0.0))
		mesh.surface_add_vertex(Vector3(0.0, -0.015, -ARENA_HALF_SIZE))
		mesh.surface_add_vertex(Vector3(0.0, -0.015, ARENA_HALF_SIZE))
	else:
		var steps := int((ARENA_HALF_SIZE * 2.0) / spacing)
		for i in range(steps + 1):
			var offset := -ARENA_HALF_SIZE + float(i) * spacing
			if absf(offset) < 0.001:
				continue
			mesh.surface_add_vertex(Vector3(-ARENA_HALF_SIZE, -0.015, offset))
			mesh.surface_add_vertex(Vector3(ARENA_HALF_SIZE, -0.015, offset))
			mesh.surface_add_vertex(Vector3(offset, -0.015, -ARENA_HALF_SIZE))
			mesh.surface_add_vertex(Vector3(offset, -0.015, ARENA_HALF_SIZE))
	mesh.surface_end()


func _create_player() -> void:
	_player_area = Area3D.new()
	_player_area.name = "PlayerGameplayArea3D"
	_player_area.position = Vector3(0.0, 1.05, 0.0)
	_player_area.collision_layer = 1
	_player_area.collision_mask = 2 | 4
	_gameplay_root.add_child(_player_area)
	_add_sphere_collision(_player_area, "PlayerCollisionSphere", PLAYER_RADIUS)
	_player_visual = PLAYER_SCENE.instantiate() as Node3D
	_player_visual.name = "Player3DVisualAsset"
	_player_area.add_child(_player_visual)
	_apply_player_blender_model(_player_visual)


func _make_player_spotlight_beam_sheet_mesh(angle: float, bottom_radius: float, top_radius: float, length: float) -> ArrayMesh:
	var width_axis := Vector3(cos(angle), 0.0, sin(angle))
	var bottom_center := Vector3(0.0, -length * 0.5, 0.0)
	var top_center := Vector3(0.0, length * 0.5, 0.0)
	var vertices := PackedVector3Array([
		bottom_center - width_axis * bottom_radius,
		bottom_center + width_axis * bottom_radius,
		top_center + width_axis * top_radius,
		top_center - width_axis * top_radius
	])
	var uvs := PackedVector2Array([
		Vector2(0.0, 0.0),
		Vector2(1.0, 0.0),
		Vector2(1.0, 1.0),
		Vector2(0.0, 1.0)
	])
	var indices := PackedInt32Array([0, 1, 2, 0, 2, 3])
	var arrays: Array = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices
	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh


func _make_player_spotlight_beam_material(color: Color, emission_strength: float) -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_add, depth_draw_never, cull_disabled;

uniform vec4 beam_color : source_color = vec4(1.0, 0.985, 0.94, 0.115);
uniform float alpha_scale = 1.0;
uniform float emission_strength = 3.0;
uniform float beam_time = 0.0;
uniform float movement_boost = 0.0;

void fragment() {
	float center = 1.0 - abs(UV.x * 2.0 - 1.0);
	float soft_edge = smoothstep(0.0, 0.72, center);
	float center_core = pow(max(center, 0.0), 3.8);
	float side_sheet = pow(max(center, 0.0), 0.92) * 0.18;
	float source_fade = smoothstep(0.04, 0.20, UV.y);
	float floor_fade = 1.0 - smoothstep(0.80, 1.0, UV.y);
	float end_fade = source_fade * floor_fade;
	float strand = 0.76 + 0.24 * sin((UV.y * 6.5 - beam_time * 0.52) * 6.2831853);
	float pulse = 0.91 + 0.09 * sin((UV.y * 1.7 + beam_time * 0.36) * 6.2831853);
	float beam = (center_core + side_sheet * soft_edge) * end_fade * strand * pulse * (1.0 + movement_boost * 0.12);
	if (beam < 0.012) {
		discard;
	}
	ALBEDO = beam_color.rgb;
	EMISSION = beam_color.rgb * emission_strength * beam;
	ALPHA = beam_color.a * alpha_scale * beam;
}
"""
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("beam_color", color)
	material.set_shader_parameter("alpha_scale", 1.0)
	material.set_shader_parameter("emission_strength", emission_strength)
	material.set_shader_parameter("beam_time", 0.0)
	material.set_shader_parameter("movement_boost", 0.0)
	return material


func _make_player_propulsion_ripple_material() -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_add, depth_draw_never, cull_disabled;

uniform vec4 ripple_color : source_color = vec4(0.0, 0.92, 1.0, 0.72);
uniform vec4 core_color : source_color = vec4(0.05, 0.36, 1.0, 0.42);
uniform float ripple_time = 0.0;
uniform float wave_speed = 1.08;
uniform float wave_frequency = 5.35;
uniform float intensity = 1.0;
uniform float movement_boost = 0.0;

float ring_band(float dist_to_ring, float width) {
	return 1.0 - smoothstep(width * 0.24, width, abs(dist_to_ring));
}

void fragment() {
	vec2 p = UV - vec2(0.5, 0.5);
	p *= 2.0;
	float r = length(p);
	if (r > 1.02) {
		discard;
	}
	float angle = atan(p.y, p.x);
	float wobble = sin(angle * 8.0 + ripple_time * 2.2) * 0.005 + sin(angle * 13.0 - ripple_time * 1.45) * 0.003;
	float rw = max(r + wobble, 0.0);
	float outer_fade = 1.0 - smoothstep(0.78, 1.0, rw);
	float angular_gate = 0.72 + 0.28 * smoothstep(-0.35, 0.82, sin(angle * 7.0 + ripple_time * 3.1));
	float rings = 0.0;
	for (int i = 0; i < 5; i++) {
		float progress = fract(ripple_time * wave_speed + float(i) * 0.20);
		float radius = progress * 0.92;
		float width = mix(0.016, 0.048, progress);
		float band = ring_band(rw - radius, width);
		float trailing = ring_band(rw - max(radius - 0.052, 0.0), width * 1.75) * 0.22;
		float fade_in = smoothstep(-0.015, 0.08, progress);
		float fade_out = pow(max(1.0 - progress, 0.0), 1.55);
		rings += (band + trailing) * fade_in * fade_out * angular_gate;
	}
	float radial_wave = fract(rw * wave_frequency - ripple_time * wave_speed);
	float flow_lines = ring_band(radial_wave - 0.030, 0.040) * outer_fade * angular_gate * 0.18;
	float center_seed = (1.0 - smoothstep(0.0, 0.055, rw)) * (0.10 + movement_boost * 0.10);
	float propulsion = rings + flow_lines + center_seed;
	float alpha = clamp(propulsion * outer_fade * intensity, 0.0, 0.62);
	if (alpha < 0.008) {
		discard;
	}
	vec3 color = mix(core_color.rgb, ripple_color.rgb, clamp(rings + flow_lines, 0.0, 1.0));
	ALBEDO = color;
	EMISSION = color * (2.0 + rings * 7.4 + flow_lines * 3.2 + movement_boost * 1.4) * alpha;
	ALPHA = alpha * ripple_color.a;
}
"""
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("ripple_color", Color(0.0, 0.92, 1.0, 0.72))
	material.set_shader_parameter("core_color", Color(0.05, 0.36, 1.0, 0.42))
	material.set_shader_parameter("ripple_time", 0.0)
	material.set_shader_parameter("wave_speed", PLAYER_PRESENTATION_RIPPLE_WAVE_SPEED)
	material.set_shader_parameter("wave_frequency", PLAYER_PRESENTATION_RIPPLE_WAVE_FREQUENCY)
	material.set_shader_parameter("intensity", 1.0)
	material.set_shader_parameter("movement_boost", 0.0)
	return material


func _update_player_spotlight_beam_transform(node: MeshInstance3D, start: Vector3, end: Vector3) -> void:
	if not is_instance_valid(node):
		return
	var delta := end - start
	var length := delta.length()
	if length < 0.001:
		node.visible = false
		return
	node.visible = true
	node.transform = Transform3D(Kit.basis_from_y_axis(delta.normalized()), (start + end) * 0.5)


func _create_player_presentation_effects() -> void:
	_player_presentation_root = Node3D.new()
	_player_presentation_root.name = "PlayerPresentationSpotlightAndPropulsionRipple"
	_player_presentation_root.process_mode = Node.PROCESS_MODE_PAUSABLE
	_player_presentation_root.visible = false
	_gameplay_root.add_child(_player_presentation_root)

	_player_spotlight = SpotLight3D.new()
	_player_spotlight.name = "PlayerFocusedWhiteSpotlight"
	_player_spotlight.light_color = Color(1.0, 0.985, 0.94, 1.0)
	_player_spotlight.light_energy = PLAYER_SPOTLIGHT_BASE_ENERGY
	_player_spotlight.spot_range = 12.0
	_player_spotlight.spot_angle = 25.0
	_player_spotlight.spot_attenuation = 1.92
	_player_spotlight.shadow_enabled = false
	_player_spotlight.light_bake_mode = Light3D.BAKE_DISABLED
	_player_presentation_root.add_child(_player_spotlight)

	var beam_length := Vector3(0.0, PLAYER_SPOTLIGHT_HEIGHT, PLAYER_SPOTLIGHT_Z_OFFSET).distance_to(Vector3(0.0, 0.42, 0.0))
	_player_spotlight_beam_material = _make_player_spotlight_beam_material(Color(1.0, 0.985, 0.94, 0.115), 2.85)
	_player_spotlight_beam_sheets.clear()
	for i in range(PLAYER_SPOTLIGHT_BEAM_SHEET_COUNT):
		var angle := TAU * float(i) / float(PLAYER_SPOTLIGHT_BEAM_SHEET_COUNT)
		var sheet := Kit.add_mesh(
			_player_presentation_root,
			"PlayerSpotlightVolumetricBeamSheet%02d" % i,
			_make_player_spotlight_beam_sheet_mesh(angle, PLAYER_SPOTLIGHT_BEAM_BOTTOM_RADIUS, PLAYER_SPOTLIGHT_BEAM_TOP_RADIUS, beam_length),
			_player_spotlight_beam_material
		)
		_player_spotlight_beam_sheets.append(sheet)

	_player_ripple_root = Node3D.new()
	_player_ripple_root.name = "PlayerPropulsionShaderRippleRoot"
	_player_presentation_root.add_child(_player_ripple_root)
	_player_propulsion_ripple_material = _make_player_propulsion_ripple_material()
	var ripple_mesh := PlaneMesh.new()
	ripple_mesh.size = Vector2(PLAYER_PRESENTATION_RIPPLE_RADIUS * 2.0, PLAYER_PRESENTATION_RIPPLE_RADIUS * 2.0)
	_player_propulsion_ripple = Kit.add_mesh(
		_player_ripple_root,
		"PlayerPropulsionRadialShaderRippleDisk",
		ripple_mesh,
		_player_propulsion_ripple_material,
		Vector3(0.0, 0.028, 0.0)
	)
	_update_player_presentation_effects(0.0)
	_set_player_presentation_visible(false)


func _set_player_presentation_visible(visible: bool) -> void:
	if is_instance_valid(_player_presentation_root):
		_player_presentation_root.visible = visible
	if is_instance_valid(_player_spotlight):
		_player_spotlight.visible = visible
		if not visible:
			_player_spotlight.light_energy = 0.0
	for sheet in _player_spotlight_beam_sheets:
		if is_instance_valid(sheet):
			sheet.visible = visible
	if is_instance_valid(_player_propulsion_ripple):
		_player_propulsion_ripple.visible = visible


func _sync_player_presentation_visibility() -> void:
	_set_player_presentation_visible(not _combat_overlay_active())


func _reset_player_presentation_effects() -> void:
	_player_ripple_time = 0.0
	_update_player_presentation_effects(0.0)


func _player_presentation_vfx_multiplier() -> float:
	return 0.55 if _vfx_intensity == 0 else 1.12 if _vfx_intensity == 2 else 1.0


func _update_player_presentation_effects(delta: float) -> void:
	if not is_instance_valid(_player_area) or not is_instance_valid(_player_presentation_root):
		return
	_player_presentation_root.position = Vector3(_player_area.position.x, PLAYER_PRESENTATION_FLOOR_Y, _player_area.position.z)
	var vfx_multiplier := _player_presentation_vfx_multiplier()
	var movement_strength := clampf(_player_velocity.length() / maxf(_current_player_speed(), 0.01), 0.0, 1.0)
	var light_source := Vector3(0.0, PLAYER_SPOTLIGHT_HEIGHT, PLAYER_SPOTLIGHT_Z_OFFSET)
	var light_target := Vector3(0.0, 0.42, 0.0)
	if is_instance_valid(_player_spotlight):
		_player_spotlight.light_color = Color(1.0, 0.985, 0.94, 1.0)
		_player_spotlight.light_energy = PLAYER_SPOTLIGHT_BASE_ENERGY * vfx_multiplier * lerpf(0.94, 1.12, movement_strength)
		_player_spotlight.spot_range = light_source.distance_to(light_target) + 2.2
		_player_spotlight.spot_angle = lerpf(23.5, 27.0, movement_strength)
		_player_spotlight.position = light_source
		_player_spotlight.look_at(_player_presentation_root.to_global(light_target), Vector3.UP)
	_player_ripple_time = fposmod(_player_ripple_time + delta, PLAYER_PRESENTATION_RIPPLE_PERIOD * 64.0)
	for sheet in _player_spotlight_beam_sheets:
		_update_player_spotlight_beam_transform(sheet, light_target, light_source)
	var beam_alpha := vfx_multiplier * lerpf(0.88, 1.12, movement_strength)
	if _player_spotlight_beam_material:
		_player_spotlight_beam_material.set_shader_parameter("alpha_scale", beam_alpha)
		_player_spotlight_beam_material.set_shader_parameter("beam_time", _player_ripple_time)
		_player_spotlight_beam_material.set_shader_parameter("movement_boost", movement_strength)
	if _player_propulsion_ripple_material:
		_player_propulsion_ripple_material.set_shader_parameter("ripple_time", _player_ripple_time)
		_player_propulsion_ripple_material.set_shader_parameter("intensity", vfx_multiplier * lerpf(0.86, 1.18, movement_strength))
		_player_propulsion_ripple_material.set_shader_parameter("movement_boost", movement_strength)


func _create_orbit_visuals() -> void:
	_orbit_visual_root = Node3D.new()
	_orbit_visual_root.name = "OrbitSparkWeaponVisuals"
	_gameplay_root.add_child(_orbit_visual_root)
	for i in range(ORBIT_VISUAL_CAP):
		var node := Node3D.new()
		node.name = "OrbitSparkNode%d" % i
		node.visible = false
		_orbit_visual_root.add_child(node)
		Kit.add_mesh(node, "OrbitSparkCore", Kit.sphere_mesh(0.19, 10, 5), _materials["white"])
		Kit.add_mesh(node, "OrbitSparkCyanShell", Kit.sphere_mesh(0.28, 10, 5), _materials["orbit_spark"])
		var ring := Kit.add_mesh(node, "OrbitSparkAnnulusTrace", Kit.torus_mesh(0.35, 0.026, 28, 4), _materials["orbit_spark"])
		ring.rotation.x = PI * 0.5
		_add_blender_asset_instance(node, "Blender3DWeaponVisual_OrbitSpark", _weapon_blender_asset_path("orbit_spark"), 0.82, Vector3(0.0, 0.02, 0.0), 0.0, true)
		_orbit_nodes.append(node)


func _create_ring_saw_visual() -> void:
	_ring_saw_root = Node3D.new()
	_ring_saw_root.name = "RingSawNeonTubeWeaponVisual"
	_ring_saw_root.visible = _is_weapon_family_equipped("ring_saw")
	_gameplay_root.add_child(_ring_saw_root)
	var outer := Kit.add_mesh(_ring_saw_root, "RingSawCyanOuterTube", Kit.torus_mesh(RING_SAW_RADIUS, 0.050, 64, 6), _materials["ring_saw"])
	var core := Kit.add_mesh(_ring_saw_root, "RingSawWhiteHotInnerTube", Kit.torus_mesh(RING_SAW_RADIUS, 0.018, 64, 5), _materials["white"])
	var cutter := Kit.add_mesh(_ring_saw_root, "RingSawVioletCutterOffset", Kit.torus_mesh(RING_SAW_RADIUS + 0.18, 0.024, 54, 5), _materials["prism_lance"])
	outer.rotation.x = PI * 0.5
	core.rotation.x = PI * 0.5
	cutter.rotation.x = PI * 0.5
	_add_weapon_blender_model(_ring_saw_root, "ring_saw", RING_SAW_RADIUS / 0.75, Vector3(0.0, 0.14, 0.0), 0.0, false)


func _add_sphere_collision(parent: Node3D, node_name: String, radius: float) -> CollisionShape3D:
	var collision := CollisionShape3D.new()
	collision.name = node_name
	var shape := SphereShape3D.new()
	shape.radius = radius
	collision.shape = shape
	parent.add_child(collision)
	return collision


func _sync_hud_design_scale() -> void:
	if not is_instance_valid(_hud_design_root):
		return
	var viewport_size := Vector2(get_viewport().get_visible_rect().size)
	if viewport_size.x <= 0.0 or viewport_size.y <= 0.0:
		return
	if viewport_size == _last_viewport_size:
		return
	_last_viewport_size = viewport_size
	var scale_factor := minf(viewport_size.x / HUD_DESIGN_SIZE.x, viewport_size.y / HUD_DESIGN_SIZE.y)
	_hud_design_root.size = HUD_DESIGN_SIZE
	_hud_design_root.scale = Vector2.ONE * scale_factor
	_hud_design_root.position = (viewport_size - HUD_DESIGN_SIZE * scale_factor) * 0.5


func _place_design_control(control: Control, rect: Rect2) -> void:
	control.set_anchors_preset(Control.PRESET_TOP_LEFT)
	control.position = rect.position
	control.size = rect.size
	control.custom_minimum_size = rect.size


func _make_frame(kind: int, rect: Rect2, primary: Color, secondary: Color, cut := 22.0, tube := 2.4, margin := Vector4(18.0, 12.0, 18.0, 12.0)) -> NeonFramePanel:
	var panel := NeonFramePanel.new()
	panel.configure(kind, primary, secondary, rect.size, cut, tube, margin)
	_place_design_control(panel, rect)
	return panel


func _create_hud() -> void:
	_hud_layer = CanvasLayer.new()
	_hud_layer.name = "GameplayHUD3D"
	_hud_layer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_hud_layer)

	_hud_root = Control.new()
	_hud_root.name = "HUDRoot"
	_hud_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_hud_layer.add_child(_hud_root)

	_hud_design_root = Control.new()
	_hud_design_root.name = "HUDDesignScaleRoot1920x1080"
	_hud_design_root.size = HUD_DESIGN_SIZE
	_hud_design_root.custom_minimum_size = HUD_DESIGN_SIZE
	_hud_root.add_child(_hud_design_root)
	_sync_hud_design_scale()

	_gameplay_hud_root = Control.new()
	_gameplay_hud_root.name = "GameplayBlueprintReadoutRoot"
	_place_design_control(_gameplay_hud_root, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_hud_design_root.add_child(_gameplay_hud_root)

	var core_panel := _make_frame(NeonFramePanel.FrameKind.LEFT_WEDGE, Rect2(24, 28, 360, 132), Color(0.0, 0.95, 1.0, 0.96), Color(1.0, 0.05, 0.86, 0.78), 26.0, 2.2, Vector4(20, 10, 22, 10))
	_gameplay_hud_root.add_child(core_panel)
	var core_column := VBoxContainer.new()
	core_column.add_theme_constant_override("separation", 2)
	core_panel.add_child(core_column)

	var core_title_row := HBoxContainer.new()
	core_title_row.add_theme_constant_override("separation", 8)
	core_column.add_child(core_title_row)
	var brand_label := _make_hud_label("NEON SWARM")
	brand_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	brand_label.add_theme_font_size_override("font_size", 22)
	brand_label.add_theme_color_override("font_color", Color(0.90, 1.0, 1.0))
	core_title_row.add_child(brand_label)
	_level_label = _make_hud_label("LV 01")
	_level_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_level_label.custom_minimum_size = Vector2(72, 24)
	_level_label.add_theme_font_size_override("font_size", 18)
	_level_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	core_title_row.add_child(_level_label)

	var core_header := _make_hud_label("CORE VITALS")
	core_header.add_theme_font_size_override("font_size", 11)
	core_header.add_theme_color_override("font_color", Color(1.0, 0.18, 0.88))
	core_column.add_child(core_header)

	_health_text_label = _make_hud_label("HEALTH  100 / 100")
	_health_text_label.add_theme_font_size_override("font_size", 11)
	core_column.add_child(_health_text_label)
	_health_bar = _make_bar("HEALTH", Color(1.0, 0.06, 0.20, 0.96), PLAYER_MAX_HEALTH, Vector2(314, 14), Color(1.0, 0.06, 0.86, 0.72))
	_health_bar.set("segment_count", 18)
	core_column.add_child(_health_bar)
	_xp_text_label = _make_hud_label("SYNC XP 000 / 010")
	_xp_text_label.add_theme_font_size_override("font_size", 11)
	core_column.add_child(_xp_text_label)
	_xp_bar = _make_bar("XP", Color(0.0, 0.86, 1.0, 0.96), float(_xp_required), Vector2(314, 14), Color(0.0, 0.95, 1.0, 0.78))
	_xp_bar.set("segment_count", 18)
	core_column.add_child(_xp_bar)

	var telemetry_panel := _make_frame(NeonFramePanel.FrameKind.RIGHT_WEDGE, Rect2(1536, 28, 360, 132), Color(1.0, 0.06, 0.86, 0.88), Color(0.0, 0.88, 1.0, 0.70), 26.0, 2.2, Vector4(22, 10, 20, 10))
	_gameplay_hud_root.add_child(telemetry_panel)
	var telemetry_column := VBoxContainer.new()
	telemetry_column.add_theme_constant_override("separation", 4)
	telemetry_panel.add_child(telemetry_column)
	_timer_label = _make_hud_label("00:00")
	_timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_timer_label.add_theme_font_size_override("font_size", 36)
	_timer_label.add_theme_color_override("font_color", Color.WHITE)
	telemetry_column.add_child(_timer_label)
	_sector_label = _make_hud_label("SECTOR 01   NEON GRID")
	_sector_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_sector_label.add_theme_font_size_override("font_size", 11)
	_sector_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	_kills_label = _make_hud_label("KILLS       000")
	_score_label = _make_hud_label("SCORE       000000")
	_enemy_label = _make_hud_label("HOSTILES    000 / 054")
	_audio_label = _make_hud_label("AUDIO       ONLINE")
	for label in [_sector_label, _kills_label, _score_label, _enemy_label, _audio_label]:
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		label.add_theme_font_size_override("font_size", 12)
		telemetry_column.add_child(label)

	var chip_rail := _make_frame(NeonFramePanel.FrameKind.RAIL, Rect2(420, 980, 1080, 72), Color(0.0, 0.95, 1.0, 0.92), Color(1.0, 0.06, 0.86, 0.78), 22.0, 2.0, Vector4(22, 12, 22, 12))
	_gameplay_hud_root.add_child(chip_rail)
	var chip_row := HBoxContainer.new()
	chip_row.alignment = BoxContainer.ALIGNMENT_CENTER
	chip_row.add_theme_constant_override("separation", 8)
	chip_rail.add_child(chip_row)
	_loadout_chips.clear()
	_add_loadout_chip(chip_row, "DMG", "damage", "diamond", Color(1.0, 0.10, 0.86, 0.90))
	_add_loadout_chip(chip_row, "RATE", "rate", "bolt", Color(0.0, 0.95, 1.0, 0.90))
	_add_loadout_chip(chip_row, "SPD", "speed", "speed", Color(0.0, 0.95, 1.0, 0.90))
	_add_loadout_chip(chip_row, "PICKUP", "pickup", "pickup", Color(1.0, 0.90, 0.08, 0.90))
	_add_loadout_chip(chip_row, "ORBIT", "orbit", "ring", Color(0.0, 1.0, 0.92, 0.90))
	_add_loadout_chip(chip_row, "LANCE", "lance", "triangle", Color(0.82, 0.10, 1.0, 0.90))
	_add_loadout_chip(chip_row, "SAW", "saw", "ring", Color(0.0, 0.95, 1.0, 0.90))
	_add_loadout_chip(chip_row, "MINE", "mine", "mine", Color(1.0, 0.12, 0.86, 0.90))

	_boss_panel = _make_frame(NeonFramePanel.FrameKind.ALERT_RAIL, Rect2(560, 24, 800, 48), Color(1.0, 0.06, 0.86, 0.92), Color(0.0, 0.95, 1.0, 0.75), 18.0, 2.0, Vector4(18, 8, 18, 8))
	_gameplay_hud_root.add_child(_boss_panel)
	var boss_row := HBoxContainer.new()
	boss_row.add_theme_constant_override("separation", 12)
	_boss_panel.add_child(boss_row)
	_boss_label = _make_hud_label("PRISM WARDEN")
	_boss_label.custom_minimum_size = Vector2(190, 28)
	_boss_label.add_theme_font_size_override("font_size", 15)
	_boss_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	boss_row.add_child(_boss_label)
	_boss_bar = _make_bar("PRISM WARDEN", Color(0.86, 0.04, 1.0, 0.96), 100.0, Vector2(550, 20), Color(1.0, 0.92, 0.06, 0.74))
	_boss_bar.set("segment_count", 32)
	_boss_bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	boss_row.add_child(_boss_bar)
	_boss_panel.visible = false

	_combat_notice_panel = _make_frame(NeonFramePanel.FrameKind.ALERT_RAIL, Rect2(560, 76, 800, 44), Color(1.0, 0.94, 0.18, 0.88), Color(0.0, 0.95, 1.0, 0.62), 16.0, 1.6, Vector4(16, 7, 16, 7))
	_combat_notice_panel.name = "EliteWaveDirectorNoticeRail"
	_combat_notice_panel.visible = false
	_gameplay_hud_root.add_child(_combat_notice_panel)
	_combat_notice_label = _make_hud_label("ELITE DETECTED")
	_combat_notice_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_combat_notice_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_combat_notice_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_combat_notice_label.custom_minimum_size = Vector2(760, 34)
	_combat_notice_label.add_theme_font_size_override("font_size", 15)
	_combat_notice_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	_combat_notice_panel.add_child(_combat_notice_label)

	_run_event_objective_panel = _make_frame(NeonFramePanel.FrameKind.ALERT_RAIL, Rect2(520, 124, 880, 104), Color(0.0, 0.96, 1.0, 0.90), Color(1.0, 0.94, 0.18, 0.72), 22.0, 2.0, Vector4(22, 10, 22, 10))
	_run_event_objective_panel.name = "RunEventObjectiveInstructionPanel"
	_run_event_objective_panel.visible = false
	_gameplay_hud_root.add_child(_run_event_objective_panel)
	_run_event_objective_label = _make_hud_label("")
	_run_event_objective_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_run_event_objective_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_run_event_objective_label.add_theme_font_size_override("font_size", 18)
	_run_event_objective_label.add_theme_color_override("font_color", Color(0.88, 1.0, 1.0))
	_run_event_objective_panel.add_child(_run_event_objective_label)

	_run_event_test_panel = _make_frame(NeonFramePanel.FrameKind.ALERT_RAIL, Rect2(610, 238, 700, 72), Color(1.0, 0.94, 0.18, 0.90), Color(0.0, 0.95, 1.0, 0.70), 18.0, 1.8, Vector4(18, 8, 18, 8))
	_run_event_test_panel.name = "Phase34RunEventTestModeRail"
	_run_event_test_panel.visible = false
	_gameplay_hud_root.add_child(_run_event_test_panel)
	_run_event_test_label = _make_hud_label("EVENT TEST MODE")
	_run_event_test_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_run_event_test_label.add_theme_font_size_override("font_size", 14)
	_run_event_test_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	_run_event_test_panel.add_child(_run_event_test_label)

	_create_level_up_panel(_hud_design_root)
	_create_weapon_reward_decision_panel(_hud_design_root)
	_create_pause_menu(_hud_design_root)
	_game_over_panel = _make_center_panel("CORE DESTROYED\nRUN TERMINATED\nA / START: RESTART\nENTER / SPACE: RESTART", true)
	_game_over_panel.visible = false
	_hud_design_root.add_child(_game_over_panel)
	_game_over_summary_label = _game_over_panel.find_child("RunEconomySummaryLabel", true, false) as Label
	_success_panel = _make_center_panel("RUN COMPLETE\nSECTOR 04 // HYPER GRID CLEARED\nA / START: RESTART\nENTER / SPACE: RESTART", true)
	_success_panel.visible = false
	_hud_design_root.add_child(_success_panel)
	_success_summary_label = _success_panel.find_child("RunEconomySummaryLabel", true, false) as Label

	_create_title_menu(_hud_design_root)
	_create_tutorial_prompt_panel(_hud_design_root)
	_create_help_menu(_hud_design_root)
	_create_presentation_flash_overlay()


func _create_presentation_flash_overlay() -> void:
	_presentation_flash = ColorRect.new()
	_presentation_flash.name = "PresentationJuiceNeonFlashOverlay"
	_presentation_flash.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_presentation_flash.process_mode = Node.PROCESS_MODE_ALWAYS
	_presentation_flash.color = Color(0.0, 0.94, 1.0, 0.0)
	_presentation_flash.visible = false
	_place_design_control(_presentation_flash, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_hud_design_root.add_child(_presentation_flash)


func _trigger_presentation_flash(color: Color, strength: float, duration := 0.24) -> void:
	if not is_instance_valid(_presentation_flash):
		return
	var vfx_multiplier := 0.55 if _vfx_intensity == 0 else 1.12 if _vfx_intensity == 2 else 1.0
	_presentation_flash_color = color
	_presentation_flash_alpha = minf(0.26, maxf(_presentation_flash_alpha, strength * vfx_multiplier))
	_presentation_flash_decay = _presentation_flash_alpha / maxf(0.06, duration)
	_presentation_flash.color = Color(color.r, color.g, color.b, _presentation_flash_alpha)
	_presentation_flash.visible = true


func _update_presentation_flash(delta: float) -> void:
	if not is_instance_valid(_presentation_flash):
		return
	if _presentation_flash_alpha <= 0.0:
		_presentation_flash.visible = false
		return
	_presentation_flash_alpha = maxf(0.0, _presentation_flash_alpha - delta * _presentation_flash_decay)
	_presentation_flash.color = Color(_presentation_flash_color.r, _presentation_flash_color.g, _presentation_flash_color.b, _presentation_flash_alpha)
	if _presentation_flash_alpha <= 0.0:
		_presentation_flash.visible = false


func _create_title_menu(root: Control) -> void:
	_title_menu_panel = Control.new()
	_title_menu_panel.name = "TitleMenuRoot"
	_title_menu_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_place_design_control(_title_menu_panel, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	root.add_child(_title_menu_panel)

	var background_cover := TextureRect.new()
	background_cover.name = "NeonSwarmCoverArtAtmosphere"
	background_cover.texture = COVER_ART
	background_cover.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	background_cover.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	background_cover.modulate = Color(0.34, 0.36, 0.46, 0.74)
	background_cover.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_place_design_control(background_cover, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_title_menu_panel.add_child(background_cover)

	var scrim := ColorRect.new()
	scrim.name = "TitleMenuDarkGlassScrim"
	scrim.color = Color(0.0, 0.0, 0.014, 0.50)
	scrim.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_place_design_control(scrim, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_title_menu_panel.add_child(scrim)

	var cover := TextureRect.new()
	cover.name = "NeonSwarmCoverArtCenteredSharp"
	cover.texture = COVER_ART
	cover.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	cover.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	cover.modulate = Color(1.0, 1.0, 1.0, 0.98)
	cover.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_place_design_control(cover, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_title_menu_panel.add_child(cover)

	var vignette := NeonTitleVignette.new()
	vignette.name = "NeonTitleVignetteAndCompositionRails"
	_place_design_control(vignette, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_title_menu_panel.add_child(vignette)

	var menu_panel := _make_frame(NeonFramePanel.FrameKind.MENU_PANEL, Rect2(150, 500, 520, 530), Color(0.0, 0.96, 1.0, 0.98), Color(1.0, 0.05, 0.86, 0.86), 30.0, 2.6, Vector4(34, 24, 34, 24))
	menu_panel.name = "TitleMenuCommandPanel"
	menu_panel.animated = true
	_title_menu_panel.add_child(menu_panel)
	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 10)
	menu_panel.add_child(layout)

	var title_label := _make_hud_label("START VECTOR")
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 18)
	title_label.add_theme_color_override("font_color", Color(0.92, 1.0, 1.0))
	title_label.add_theme_color_override("font_shadow_color", Color(0.0, 0.96, 1.0, 1.0))
	layout.add_child(title_label)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(0.0, 0.94, 1.0, 0.40)
	layout.add_child(divider)

	var button_column := VBoxContainer.new()
	button_column.alignment = BoxContainer.ALIGNMENT_CENTER
	button_column.add_theme_constant_override("separation", 10)
	button_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(button_column)

	_title_menu_buttons.clear()
	_add_title_menu_button(button_column, "START GAME", Callable(self, "_start_title_run"))
	_add_title_menu_button(button_column, "ARMORY", Callable(self, "_open_armory"))
	_add_title_menu_button(button_column, "CORE UPGRADES", Callable(self, "_open_core_upgrades"))
	_add_title_menu_button(button_column, "OPTIONS", Callable(self, "_toggle_title_options"))
	_add_title_menu_button(button_column, "HOW TO PLAY", Callable(self, "_open_title_help"))
	_add_title_menu_button(button_column, "QUIT", Callable(self, "_quit_game"))

	var status_label := _make_hud_label("ACTIVE DEVELOPMENT // v0.17")
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.add_theme_font_size_override("font_size", 10)
	status_label.add_theme_color_override("font_color", Color(0.66, 0.92, 0.96, 0.78))
	layout.add_child(status_label)

	_title_modal_scrim = ColorRect.new()
	_title_modal_scrim.name = "TitleMenuModalDepthScrim"
	_title_modal_scrim.visible = false
	_title_modal_scrim.mouse_filter = Control.MOUSE_FILTER_STOP
	_title_modal_scrim.color = Color(0.0, 0.0, 0.020, 0.60)
	_place_design_control(_title_modal_scrim, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	_title_menu_panel.add_child(_title_modal_scrim)

	_create_title_options_menu()
	_create_armory_menu()
	_create_core_upgrades_menu()

	_title_selection_cursor = NeonSelectionCursor.new()
	_title_selection_cursor.name = "NeonShipCoreSelectionCursor"
	_title_selection_cursor.size = Vector2(58, 38)
	_title_selection_cursor.custom_minimum_size = Vector2(58, 38)
	_title_menu_panel.add_child(_title_selection_cursor)

	_update_title_menu_labels()


func _create_title_options_menu() -> void:
	_title_options_panel = _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, Rect2(740, 380, 560, 520), Color(1.0, 0.08, 0.86, 0.90), Color(0.0, 0.92, 1.0, 0.74), 24.0, 2.2, Vector4(28, 20, 28, 20))
	_title_options_panel.name = "TitleOptionsSettingsPanel"
	_title_options_panel.visible = false
	_title_options_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_title_menu_panel.add_child(_title_options_panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 6)
	_title_options_panel.add_child(layout)

	_title_options_label = _make_hud_label("OPTIONS")
	_title_options_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title_options_label.add_theme_font_size_override("font_size", 22)
	_title_options_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_title_options_label)

	var prompt := _make_hud_label("UP/DOWN SELECT  |  LEFT/RIGHT ADJUST  |  A CONFIRM  |  B BACK")
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt.add_theme_font_size_override("font_size", 10)
	prompt.add_theme_color_override("font_color", Color(0.76, 0.98, 1.0, 0.88))
	layout.add_child(prompt)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(0.0, 0.94, 1.0, 0.36)
	layout.add_child(divider)

	var option_column := VBoxContainer.new()
	option_column.alignment = BoxContainer.ALIGNMENT_CENTER
	option_column.add_theme_constant_override("separation", 6)
	option_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(option_column)

	_title_options_buttons.clear()
	_add_title_options_button(option_column, "master_volume")
	_add_title_options_button(option_column, "sfx_volume")
	_add_title_options_button(option_column, "music_volume")
	_add_title_options_button(option_column, "mute")
	_add_title_options_button(option_column, "screen_shake")
	_add_title_options_button(option_column, "vfx_intensity")
	_add_title_options_button(option_column, "fullscreen")
	_add_title_options_button(option_column, "back")


func _create_armory_menu() -> void:
	_armory_panel = _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, Rect2(620, 150, 1240, 840), Color(0.0, 0.96, 1.0, 0.94), Color(1.0, 0.06, 0.86, 0.82), 28.0, 2.4, Vector4(28, 22, 28, 22))
	_armory_panel.name = "ArmoryStashCommandConsole"
	_armory_panel.visible = false
	_armory_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_title_menu_panel.add_child(_armory_panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_BEGIN
	layout.add_theme_constant_override("separation", 8)
	_armory_panel.add_child(layout)

	var header := _make_hud_label("ARMORY / STASH")
	header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	header.add_theme_font_size_override("font_size", 26)
	header.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(header)

	var prompt := _make_hud_label("LEFT STICK / D-PAD: SELECT  |  RIGHT STICK: SCROLL ACTIVE PANEL  |  A / ENTER: CONFIRM  |  B / ESC: BACK")
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt.add_theme_font_size_override("font_size", 10)
	prompt.add_theme_color_override("font_color", Color(0.76, 0.98, 1.0, 0.88))
	layout.add_child(prompt)

	_armory_dust_label = _make_hud_label("NEON DUST: 0")
	_armory_dust_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_armory_dust_label.add_theme_font_size_override("font_size", 15)
	_armory_dust_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_armory_dust_label)

	_armory_help_label = _make_hud_label("EQUIPPED LOADOUT = ACTIVE WEAPONS  |  INVENTORY / STASH = STORED WEAPONS  |  FORGE SPENDS NEON DUST  |  SCRAP STORED WEAPONS FOR NEON DUST")
	_armory_help_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_armory_help_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_armory_help_label.custom_minimum_size = Vector2(1000, 30)
	_armory_help_label.add_theme_font_size_override("font_size", 10)
	_armory_help_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18, 0.92))
	layout.add_child(_armory_help_label)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(0.0, 0.94, 1.0, 0.36)
	layout.add_child(divider)

	var columns := HBoxContainer.new()
	columns.add_theme_constant_override("separation", 12)
	columns.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	columns.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(columns)

	var equipped_column := VBoxContainer.new()
	equipped_column.custom_minimum_size = Vector2(286, 610)
	equipped_column.add_theme_constant_override("separation", 6)
	columns.add_child(equipped_column)

	_armory_equipped_title_label = _make_hud_label("EQUIPPED LOADOUT")
	_armory_equipped_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_armory_equipped_title_label.add_theme_font_size_override("font_size", 17)
	_armory_equipped_title_label.add_theme_color_override("font_color", Color(0.0, 0.96, 1.0))
	equipped_column.add_child(_armory_equipped_title_label)

	var equipped_rows := VBoxContainer.new()
	equipped_rows.name = "EquippedLoadoutFixedRows"
	equipped_rows.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	equipped_rows.custom_minimum_size = Vector2(286, 520)
	equipped_rows.add_theme_constant_override("separation", 6)
	equipped_column.add_child(equipped_rows)

	_armory_equipped_buttons.clear()
	_armory_equipped_icons.clear()
	for i in range(EQUIPPED_WEAPON_SLOT_CAP):
		var button := _make_armory_row_button(Vector2(270, 58), 11)
		var icon := _make_weapon_icon_control(Vector2(48, 48))
		icon.position = Vector2(12, 5)
		button.add_child(icon)
		button.set_meta("armory_section", "equipped")
		button.set_meta("armory_index", i)
		button.focus_entered.connect(func() -> void:
			_armory_selected_section = "equipped"
			_armory_equipped_selected_index = int(button.get_meta("armory_index"))
			_update_armory_cursor_position(true)
			_update_armory_ui()
		)
		button.pressed.connect(func() -> void:
			_activate_armory_selection()
		)
		equipped_rows.add_child(button)
		_armory_equipped_buttons.append(button)
		_armory_equipped_icons.append(icon)

	var stash_column := VBoxContainer.new()
	stash_column.custom_minimum_size = Vector2(352, 610)
	stash_column.add_theme_constant_override("separation", 6)
	columns.add_child(stash_column)

	_armory_stash_title_label = _make_hud_label("INVENTORY / STASH")
	_armory_stash_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_armory_stash_title_label.add_theme_font_size_override("font_size", 17)
	_armory_stash_title_label.add_theme_color_override("font_color", Color(1.0, 0.08, 0.86))
	stash_column.add_child(_armory_stash_title_label)

	_armory_stash_scroll = _make_ui_scroll_area(Vector2(352, 548))
	stash_column.add_child(_armory_stash_scroll)
	var stash_rows := VBoxContainer.new()
	stash_rows.name = "InventoryStashScrollableRows"
	stash_rows.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	stash_rows.add_theme_constant_override("separation", 6)
	_armory_stash_scroll.add_child(stash_rows)

	_armory_stash_buttons.clear()
	_armory_stash_icons.clear()
	for i in range(STASH_WEAPON_CAP):
		var button := _make_armory_row_button(Vector2(336, 64), 12)
		var icon := _make_weapon_icon_control(Vector2(52, 52))
		icon.position = Vector2(12, 6)
		button.add_child(icon)
		button.set_meta("armory_section", "stash")
		button.set_meta("armory_index", i)
		button.focus_entered.connect(func() -> void:
			_armory_selected_section = "stash"
			_armory_stash_selected_index = int(button.get_meta("armory_index"))
			_update_armory_cursor_position(true)
			_update_armory_ui()
		)
		button.pressed.connect(func() -> void:
			_activate_armory_selection()
		)
		stash_rows.add_child(button)
		_armory_stash_buttons.append(button)
		_armory_stash_icons.append(icon)

	var detail_column := VBoxContainer.new()
	detail_column.custom_minimum_size = Vector2(500, 610)
	detail_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	detail_column.add_theme_constant_override("separation", 6)
	columns.add_child(detail_column)

	var detail_title := _make_hud_label("WEAPON DETAIL")
	detail_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	detail_title.add_theme_font_size_override("font_size", 17)
	detail_title.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	detail_column.add_child(detail_title)

	var preview_center := CenterContainer.new()
	preview_center.custom_minimum_size = Vector2(480, 104)
	detail_column.add_child(preview_center)
	_armory_preview_icon = _make_weapon_icon_control(Vector2(96, 96))
	preview_center.add_child(_armory_preview_icon)

	_armory_detail_label = _make_hud_label("")
	_armory_detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_armory_detail_label.custom_minimum_size = Vector2(470, 260)
	_armory_detail_label.add_theme_font_size_override("font_size", 12)
	_armory_detail_scroll = _make_ui_scroll_area(Vector2(480, 178))
	_armory_detail_scroll.add_child(_armory_detail_label)
	detail_column.add_child(_armory_detail_scroll)

	var compare_title := _make_hud_label("COMPARISON")
	compare_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	compare_title.add_theme_font_size_override("font_size", 17)
	compare_title.add_theme_color_override("font_color", Color(0.0, 0.96, 1.0))
	detail_column.add_child(compare_title)

	var compare_icon_row := HBoxContainer.new()
	compare_icon_row.alignment = BoxContainer.ALIGNMENT_CENTER
	compare_icon_row.custom_minimum_size = Vector2(480, 78)
	compare_icon_row.add_theme_constant_override("separation", 18)
	detail_column.add_child(compare_icon_row)
	_armory_compare_current_icon = _make_weapon_icon_control(Vector2(72, 72))
	_armory_compare_candidate_icon = _make_weapon_icon_control(Vector2(72, 72))
	compare_icon_row.add_child(_armory_compare_current_icon)
	compare_icon_row.add_child(_armory_compare_candidate_icon)

	_armory_compare_label = _make_hud_label("")
	_armory_compare_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_armory_compare_label.custom_minimum_size = Vector2(470, 230)
	_armory_compare_label.add_theme_font_size_override("font_size", 12)
	_armory_compare_scroll = _make_ui_scroll_area(Vector2(480, 150))
	_armory_compare_scroll.add_child(_armory_compare_label)
	detail_column.add_child(_armory_compare_scroll)

	_armory_action_row = HBoxContainer.new()
	_armory_action_row.name = "ArmoryStashActionConfirmRow"
	_armory_action_row.visible = false
	_armory_action_row.alignment = BoxContainer.ALIGNMENT_CENTER
	_armory_action_row.add_theme_constant_override("separation", 12)
	layout.add_child(_armory_action_row)
	_armory_action_buttons.clear()
	for i in range(5):
		var action_button := _make_weapon_reward_button(Vector2(214, 52), 10)
		action_button.name = "ArmoryAction%d" % i
		action_button.set_meta("armory_action_index", i)
		action_button.pressed.connect(func() -> void:
			_armory_action_selected_index = int(action_button.get_meta("armory_action_index"))
			_activate_armory_action_selection()
		)
		_armory_action_row.add_child(action_button)
		_armory_action_buttons.append(action_button)

	_armory_status_label = _make_hud_label("")
	_armory_status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_armory_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_armory_status_label.custom_minimum_size = Vector2(1000, 44)
	_armory_status_label.add_theme_font_size_override("font_size", 12)
	_armory_status_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_armory_status_label)

	_armory_selection_cursor = NeonSelectionCursor.new()
	_armory_selection_cursor.name = "NeonArmoryShipCoreSelectionCursor"
	_armory_selection_cursor.size = Vector2(52, 34)
	_armory_selection_cursor.custom_minimum_size = Vector2(52, 34)
	_armory_selection_cursor.visible = false
	_title_menu_panel.add_child(_armory_selection_cursor)


func _create_core_upgrades_menu() -> void:
	_core_upgrades_panel = _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, Rect2(710, 230, 760, 650), Color(1.0, 0.94, 0.18, 0.92), Color(0.0, 0.96, 1.0, 0.82), 26.0, 2.3, Vector4(30, 22, 30, 22))
	_core_upgrades_panel.name = "CoreUpgradesNeonDustTerminal"
	_core_upgrades_panel.visible = false
	_core_upgrades_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_title_menu_panel.add_child(_core_upgrades_panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_BEGIN
	layout.add_theme_constant_override("separation", 10)
	_core_upgrades_panel.add_child(layout)

	var title := _make_hud_label("CORE UPGRADES")
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 26)
	title.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(title)

	_core_upgrade_dust_label = _make_hud_label("NEON DUST: 0")
	_core_upgrade_dust_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_core_upgrade_dust_label.add_theme_font_size_override("font_size", 16)
	_core_upgrade_dust_label.add_theme_color_override("font_color", Color(0.0, 0.96, 1.0))
	layout.add_child(_core_upgrade_dust_label)

	var prompt := _make_hud_label("D-PAD / LEFT STICK: SELECT  |  A / ENTER: CONFIRM  |  B / ESC: BACK")
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt.add_theme_font_size_override("font_size", 10)
	prompt.add_theme_color_override("font_color", Color(0.76, 0.98, 1.0, 0.88))
	layout.add_child(prompt)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(1.0, 0.94, 0.18, 0.40)
	layout.add_child(divider)

	var button_column := VBoxContainer.new()
	button_column.alignment = BoxContainer.ALIGNMENT_CENTER
	button_column.add_theme_constant_override("separation", 8)
	button_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(button_column)

	_core_upgrade_buttons.clear()
	for i in range(_core_upgrade_definitions().size()):
		var button := _make_weapon_reward_button(Vector2(680, 82), 13, 18)
		button.name = "CoreUpgradeButton%d" % i
		button.set_meta("core_upgrade_index", i)
		button.pressed.connect(func() -> void:
			_core_upgrade_selected_index = int(button.get_meta("core_upgrade_index"))
			_activate_core_upgrade_selection()
		)
		button_column.add_child(button)
		_core_upgrade_buttons.append(button)

	var back_button := _make_weapon_reward_button(Vector2(680, 56), 14, 18)
	back_button.name = "CoreUpgradeBackButton"
	back_button.set_meta("core_upgrade_index", _core_upgrade_buttons.size())
	back_button.pressed.connect(func() -> void:
		_core_upgrade_selected_index = int(back_button.get_meta("core_upgrade_index"))
		_activate_core_upgrade_selection()
	)
	button_column.add_child(back_button)
	_core_upgrade_buttons.append(back_button)

	_core_upgrade_status_label = _make_hud_label("")
	_core_upgrade_status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_core_upgrade_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_core_upgrade_status_label.custom_minimum_size = Vector2(700, 76)
	_core_upgrade_status_label.add_theme_font_size_override("font_size", 12)
	_core_upgrade_status_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_core_upgrade_status_label)

	_core_upgrade_selection_cursor = NeonSelectionCursor.new()
	_core_upgrade_selection_cursor.name = "CoreUpgradesShipCoreSelectionCursor"
	_core_upgrade_selection_cursor.size = Vector2(52, 34)
	_core_upgrade_selection_cursor.custom_minimum_size = Vector2(52, 34)
	_core_upgrade_selection_cursor.visible = false
	_title_menu_panel.add_child(_core_upgrade_selection_cursor)


func _create_tutorial_prompt_panel(root: Control) -> void:
	_tutorial_prompt_panel = NeonHudPanel.new()
	_tutorial_prompt_panel.name = "FirstRunTutorialHintPlate"
	_tutorial_prompt_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_tutorial_prompt_panel.visible = false
	_tutorial_prompt_panel.configure(Color(0.0, 0.96, 1.0, 0.92), Color(1.0, 0.06, 0.86, 0.78), Vector2(500, 118), 18.0, 2.0)
	_tutorial_prompt_panel.set_anchors_preset(Control.PRESET_TOP_LEFT)
	_tutorial_prompt_panel.offset_left = 1268
	_tutorial_prompt_panel.offset_top = 784
	_tutorial_prompt_panel.offset_right = 1768
	_tutorial_prompt_panel.offset_bottom = 902
	root.add_child(_tutorial_prompt_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_bottom", 12)
	_tutorial_prompt_panel.add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 6)
	margin.add_child(layout)

	_tutorial_prompt_title_label = _make_hud_label("FIELD NOTE")
	_tutorial_prompt_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	_tutorial_prompt_title_label.add_theme_font_size_override("font_size", 14)
	_tutorial_prompt_title_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_tutorial_prompt_title_label)

	_tutorial_prompt_body_label = _make_hud_label("")
	_tutorial_prompt_body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_tutorial_prompt_body_label.custom_minimum_size = Vector2(454, 56)
	_tutorial_prompt_body_label.add_theme_font_size_override("font_size", 13)
	_tutorial_prompt_body_label.add_theme_color_override("font_color", Color(0.84, 1.0, 1.0))
	layout.add_child(_tutorial_prompt_body_label)


func _create_help_menu(root: Control) -> void:
	_help_modal_scrim = ColorRect.new()
	_help_modal_scrim.name = "HowToPlayModalBackdropScrim"
	_help_modal_scrim.visible = false
	_help_modal_scrim.mouse_filter = Control.MOUSE_FILTER_STOP
	_help_modal_scrim.process_mode = Node.PROCESS_MODE_ALWAYS
	_help_modal_scrim.color = Color(0.0, 0.0, 0.018, 0.82)
	_help_modal_scrim.z_index = 80
	_place_design_control(_help_modal_scrim, Rect2(Vector2.ZERO, HUD_DESIGN_SIZE))
	root.add_child(_help_modal_scrim)

	_help_panel = _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, Rect2(330, 148, 1260, 784), Color(0.0, 0.96, 1.0, 0.96), Color(1.0, 0.06, 0.86, 0.82), 28.0, 2.4, Vector4(34, 26, 34, 26))
	_help_panel.name = "HowToPlayInstructionConsole"
	_help_panel.visible = false
	_help_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_help_panel.z_index = 90
	root.add_child(_help_panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_BEGIN
	layout.add_theme_constant_override("separation", 10)
	_help_panel.add_child(layout)

	_help_title_label = _make_hud_label("HOW TO PLAY")
	_help_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_help_title_label.add_theme_font_size_override("font_size", 28)
	_help_title_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_help_title_label)

	_help_prompt_label = _make_hud_label("UP/DOWN SELECT SECTION  |  LEFT/RIGHT SCROLL FOCUS  |  RS SCROLL  |  A / ENTER SELECT  |  B / ESC BACK")
	_help_prompt_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_help_prompt_label.add_theme_font_size_override("font_size", 10)
	_help_prompt_label.add_theme_color_override("font_color", Color(0.76, 0.98, 1.0, 0.88))
	layout.add_child(_help_prompt_label)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(0.0, 0.94, 1.0, 0.36)
	layout.add_child(divider)

	var body := HBoxContainer.new()
	body.add_theme_constant_override("separation", 24)
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(body)

	var tab_column := VBoxContainer.new()
	tab_column.custom_minimum_size = Vector2(336, 596)
	tab_column.add_theme_constant_override("separation", 10)
	_help_tab_scroll = _make_ui_scroll_area(Vector2(342, 596))
	body.add_child(_help_tab_scroll)
	_help_tab_scroll.add_child(tab_column)

	_help_buttons.clear()
	for i in range(_help_page_data().size()):
		var page: Dictionary = _help_page_data()[i]
		var button := _make_menu_button(str(page.get("title", "HELP")))
		button.custom_minimum_size = Vector2(324, 58)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.set_meta("left_text_padding", 20.0)
		button.set_meta("help_index", i)
		button.ready.connect(func() -> void:
			button.custom_minimum_size = Vector2(324, 58)
			button.add_theme_font_size_override("font_size", 13)
			button.set_meta("left_text_padding", 20.0)
		)
		button.focus_entered.connect(func() -> void:
			_help_selected_index = int(button.get_meta("help_index"))
			_update_help_ui()
			_update_help_cursor_position(true)
		)
		button.pressed.connect(func() -> void:
			_help_selected_index = int(button.get_meta("help_index"))
			_activate_help_selection()
		)
		tab_column.add_child(button)
		_help_buttons.append(button)

	var copy_column := VBoxContainer.new()
	copy_column.custom_minimum_size = Vector2(820, 596)
	copy_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	copy_column.add_theme_constant_override("separation", 10)
	body.add_child(copy_column)

	var copy_title := _make_hud_label("PLAYER BRIEFING")
	copy_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	copy_title.add_theme_font_size_override("font_size", 18)
	copy_title.add_theme_color_override("font_color", Color(0.0, 0.96, 1.0))
	copy_column.add_child(copy_title)

	_help_body_label = _make_hud_label("")
	_help_body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_help_body_label.custom_minimum_size = Vector2(786, 520)
	_help_body_label.add_theme_font_size_override("font_size", 17)
	_help_body_label.add_theme_color_override("font_color", Color(0.84, 1.0, 1.0))
	_help_body_scroll = _make_ui_scroll_area(Vector2(804, 424))
	_help_body_scroll.add_child(_help_body_label)
	copy_column.add_child(_help_body_scroll)

	_help_icon_row = HBoxContainer.new()
	_help_icon_row.alignment = BoxContainer.ALIGNMENT_CENTER
	_help_icon_row.custom_minimum_size = Vector2(786, 108)
	_help_icon_row.add_theme_constant_override("separation", 18)
	_help_icon_scroll = _make_ui_scroll_area(Vector2(804, 116), true)
	_help_icon_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_help_icon_scroll.add_child(_help_icon_row)
	copy_column.add_child(_help_icon_scroll)
	_help_example_icons.clear()
	for i in range(6):
		var icon := _make_weapon_icon_control(Vector2(88, 88))
		_help_icon_row.add_child(icon)
		_help_example_icons.append(icon)

	_help_selection_cursor = NeonSelectionCursor.new()
	_help_selection_cursor.name = "HowToPlayShipCoreSelectionCursor"
	_help_selection_cursor.size = Vector2(52, 34)
	_help_selection_cursor.custom_minimum_size = Vector2(52, 34)
	_help_selection_cursor.visible = false
	_help_selection_cursor.z_index = 91
	root.add_child(_help_selection_cursor)


func _help_page_data() -> Array[Dictionary]:
	return [
		{
			"title": "BASIC CONTROLS",
			"body": "MOVE\nKeyboard: WASD / arrows. Controller: left stick / D-pad.\n\nAIM\nUse right stick or aim keys if mapped. If you do not aim, projectile weapons auto-target the nearest enemy.\n\nMENUS\nA / Enter confirms. B / Esc backs out. D-pad / arrows move selection.\n\nPAUSE\nPress Start, P, or Esc during a run."
		},
		{
			"title": "CORE LOOP",
			"body": "SURVIVE WAVES\nEnemies pressure the arena while your equipped weapons fire automatically.\n\nKILL ENEMIES\nDestroy enemies to create XP shards and clear pressure.\n\nCOLLECT XP\nXP fills the level bar. Level-ups improve the current run.\n\nCLEAR SECTORS\nDefeat sector events, choose rewards, push to the final boss, then reach RUN COMPLETE."
		},
		{
			"title": "XP AND LEVEL-UPS",
			"body": "XP IS NOT WEAPON LOOT\nEnemies currently drop XP shards, not weapons.\n\nXP FILLS THE BAR\nMove near XP shards to pull them in and collect them.\n\nLEVEL-UP UPGRADES\nWhen the XP bar fills, choose a run upgrade such as damage, fire rate, health, pickup range, or weapon tuning.\n\nLEVEL-UP CHOICES APPLY TO THE CURRENT RUN."
		},
		{
			"title": "WEAPON SYSTEMS",
			"body": "WEAPONS ARE AUTOMATIC\nEquipped weapon systems fire or trigger by themselves. You do not press a separate fire button.\n\nEQUIPPED LOADOUT\nStart Game uses the weapons in your equipped slots.\n\nWEAPON ICONS\nIcons show the weapon family behavior: pulse, orbit, spear, chain, saw, well, bloom, and other geometry roles.\n\nRANDOM WEAPONS\nGenerated weapons can have rarity, random stats, and modifiers.\n\nARMORY\nUse Armory from the title screen to inspect, compare, and swap stored weapons."
		},
		{
			"title": "SECTOR REWARDS",
			"body": "SECTOR-CLEAR REWARDS\nAfter a sector boss or major event, choose a reward before moving on. Clearing sectors also banks a small Neon Dust bonus.\n\nGENERATED WEAPON SYSTEMS\nWeapon rewards are random weapons with rarity and stat rolls.\n\nLOOT ROUTES\nEquip Now adds to an open slot. Replace Slot swaps with an equipped weapon. Send To Stash stores it. Scrap / Skip converts the weapon into Neon Dust.\n\nENEMIES CURRENTLY DROP XP, NOT WEAPONS."
		},
		{
			"title": "ARMORY / STASH",
			"body": "EQUIPPED\nWeapons in equipped slots are active during gameplay.\n\nSTASH\nStashed weapons are stored only. They do not fire until equipped.\n\nSWAP\nSelecting a stash weapon equips it into the selected equipped slot. The old equipped weapon moves to stash.\n\nSCRAP\nStored weapons can be scrapped for Neon Dust. Equipped weapons cannot be scrapped from this screen.\n\nCORE UPGRADES\nUse Neon Dust to buy modest permanent core upgrades.\n\nSTART GAME USES THE EQUIPPED LOADOUT."
		},
		{
			"title": "SECTORS / BOSSES",
			"body": "SECTORS\nEach sector changes pressure, enemy mix, pacing, and visual identity.\n\nBOSSES AND EVENTS\nSector bosses or major events unlock reward choices.\n\nRUN COMPLETE\nPush through all active sectors and defeat the final event to trigger RUN COMPLETE.\n\nCURRENT BUILD\nThe game is still in active development, so future sectors and progression are not final."
		}
	]


func _help_icon_families_for_page(index: int) -> Array[String]:
	match index:
		3:
			return ["pulse_blaster", "ring_saw", "tri_burst_cannon", "gravity_well", "star_pulse", "prism_chain"]
		4:
			return ["hex_mortar", "vector_spear", "fractal_bloom", "shield_breaker", "nova_needle", "unknown_weapon"]
		5:
			return ["pulse_blaster", "gravity_mine", "ring_saw", "fractal_shard", "star_pulse", "unknown_weapon"]
		_:
			return []


func _make_ui_scroll_area(minimum_size: Vector2, horizontal := false) -> ScrollContainer:
	var scroll := ScrollContainer.new()
	scroll.custom_minimum_size = minimum_size
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.clip_contents = true
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO if horizontal else ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	return scroll


func _ensure_scroll_visible(scroll: ScrollContainer, item: Control) -> void:
	if not is_instance_valid(scroll) or not is_instance_valid(item) or not item.visible:
		return
	scroll.call_deferred("ensure_control_visible", item)


func _update_right_stick_ui_scroll(delta: float) -> void:
	var stick := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down", InputMapConfig.AIM_DEADZONE)
	if _sync_armory_stash_selection_with_right_stick(stick, delta):
		return
	if stick.length() < 0.22:
		return
	var containers := _active_right_stick_scroll_containers()
	if containers.is_empty():
		return
	for scroll in containers:
		_scroll_ui_container_with_stick(scroll, stick, delta)


func _sync_armory_stash_selection_with_right_stick(stick: Vector2, delta := 0.016) -> bool:
	if not _armory_visible or not (_armory_action_mode in ["browse", "fusion_materials"]) or _armory_selected_section != "stash":
		_reset_armory_stash_right_stick_scroll()
		return false
	var strength := absf(stick.y)
	if strength < UI_RIGHT_STICK_STASH_DEADZONE:
		_reset_armory_stash_right_stick_scroll()
		return true
	if _stash_weapon_instances.is_empty():
		return true
	var direction := 1 if stick.y > 0.0 else -1
	var repeat_delay := UI_RIGHT_STICK_STASH_FAST_REPEAT if strength >= UI_RIGHT_STICK_STASH_FAST_THRESHOLD else UI_RIGHT_STICK_STASH_SLOW_REPEAT
	if direction != _armory_stash_rs_last_direction:
		_armory_stash_rs_last_direction = direction
		_armory_stash_rs_repeat_timer = 0.0
	else:
		_armory_stash_rs_repeat_timer = maxf(0.0, _armory_stash_rs_repeat_timer - delta)
		if _armory_stash_rs_repeat_timer > 0.0:
			return true
	var previous_index := _armory_stash_selected_index
	if _armory_action_mode == "fusion_materials":
		_move_armory_fusion_material_selection(direction, false)
	else:
		_armory_stash_selected_index = clampi(_armory_stash_selected_index + direction, 0, _stash_weapon_instances.size() - 1)
	_armory_stash_rs_repeat_timer = repeat_delay
	if _armory_stash_selected_index != previous_index:
		if _armory_action_mode == "fusion_materials":
			_armory_status_text = "FUSION MATERIAL %02d / %02d // A CONFIRMS // B CANCELS" % [_armory_stash_selected_index + 1, _stash_weapon_instances.size()]
		else:
			_armory_status_text = "RIGHT STICK SELECTED STORED WEAPON %02d / %02d" % [_armory_stash_selected_index + 1, _stash_weapon_instances.size()]
		_update_armory_ui()
		_focus_armory_choice()
		_play_sfx("ui_move", 0.035)
	else:
		_focus_armory_choice()
	return true


func _reset_armory_stash_right_stick_scroll() -> void:
	_armory_stash_rs_repeat_timer = 0.0
	_armory_stash_rs_last_direction = 0


func _active_right_stick_scroll_containers() -> Array:
	var containers: Array = []
	if _help_visible:
		match _help_scroll_focus:
			"tabs":
				containers.append(_help_tab_scroll)
			"icons":
				containers.append(_help_icon_scroll)
			_:
				containers.append(_help_body_scroll)
		return containers
	if _armory_visible:
		if _armory_action_mode != "browse":
			return containers
		if _armory_selected_section == "stash":
			containers.append(_armory_stash_scroll)
		else:
			containers.append(_armory_detail_scroll)
			containers.append(_armory_compare_scroll)
		return containers
	if _weapon_reward_decision_active:
		containers.append(_weapon_reward_detail_scroll)
		containers.append(_weapon_reward_compare_scroll)
		if _weapon_reward_mode == "slots":
			containers.append(_weapon_reward_slot_scroll)
		return containers
	return containers


func _scroll_ui_container_with_stick(scroll, stick: Vector2, delta: float) -> void:
	if not is_instance_valid(scroll) or not scroll.visible or not scroll.is_visible_in_tree():
		return
	if absf(stick.y) >= 0.18 and scroll.vertical_scroll_mode != ScrollContainer.SCROLL_MODE_DISABLED:
		scroll.scroll_vertical = maxi(0, scroll.scroll_vertical + int(round(stick.y * UI_RIGHT_STICK_SCROLL_SPEED * delta)))
	if absf(stick.x) >= 0.18 and scroll.horizontal_scroll_mode != ScrollContainer.SCROLL_MODE_DISABLED:
		scroll.scroll_horizontal = maxi(0, scroll.scroll_horizontal + int(round(stick.x * UI_RIGHT_STICK_SCROLL_SPEED * delta)))


func _compact_weapon_name(instance: Dictionary, max_chars := 18) -> String:
	var text := str(instance.get("name", "WEAPON")).to_upper()
	if text.length() <= max_chars:
		return text
	return "%s.." % text.substr(0, maxi(1, max_chars - 2))


func _rarity_display_code(rarity: String) -> String:
	match rarity:
		"Uncommon":
			return "U"
		"Rare":
			return "R"
		"Epic":
			return "E"
		"Legendary":
			return "L"
		"Anomaly":
			return "A"
		_:
			return "C"


func _update_title_modal_scrim() -> void:
	if not is_instance_valid(_title_modal_scrim):
		return
	var active := _title_menu_active and (_title_options_visible or _armory_visible or _core_upgrades_visible)
	_title_modal_scrim.visible = active
	_title_modal_scrim.color = Color(0.0, 0.0, 0.020, 0.52)


func _make_armory_row_button(minimum_size := Vector2(292, 48), font_size := 12) -> Button:
	var button := NeonMenuButton.new()
	button.custom_minimum_size = minimum_size
	button.set_meta("left_text_padding", 78.0)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.ready.connect(func() -> void:
		button.custom_minimum_size = minimum_size
		button.add_theme_font_size_override("font_size", font_size)
		button.set_meta("left_text_padding", 78.0)
	)
	return button


func _add_title_options_button(parent: Control, option_key: String) -> void:
	var button := _make_menu_button("")
	button.custom_minimum_size = Vector2(490, 42)
	button.ready.connect(func() -> void:
		button.custom_minimum_size = Vector2(490, 42)
		button.add_theme_font_size_override("font_size", 18)
	)
	button.set_meta("option_key", option_key)
	button.set_meta("option_index", _title_options_buttons.size())
	button.focus_entered.connect(func() -> void:
		_title_options_selected_index = int(button.get_meta("option_index"))
		_update_title_cursor_position(true)
	)
	button.pressed.connect(func() -> void:
		_activate_title_options_selection()
	)
	parent.add_child(button)
	_title_options_buttons.append(button)


func _add_title_menu_button(parent: Control, text: String, callback: Callable) -> void:
	var button := _make_menu_button(text)
	button.set_meta("menu_index", _title_menu_buttons.size())
	button.focus_entered.connect(func() -> void:
		_title_menu_selected_index = int(button.get_meta("menu_index"))
		_update_title_cursor_position(true)
	)
	button.pressed.connect(callback)
	parent.add_child(button)
	_title_menu_buttons.append(button)


func _make_menu_button(text: String) -> Button:
	var button := NeonMenuButton.new()
	button.text = text
	button.custom_minimum_size = Vector2(390, 58)
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	return button


func _make_weapon_icon_control(minimum_size := Vector2(52, 52), show_frame := true) -> Control:
	var icon := NeonWeaponIcon.new()
	icon.custom_minimum_size = minimum_size
	icon.size = minimum_size
	icon.show_frame = show_frame
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return icon


func _set_weapon_icon(icon: Control, instance_or_id, visible := true) -> void:
	if not is_instance_valid(icon):
		return
	icon.visible = visible
	if not visible:
		return
	var definition_id := "unknown_weapon"
	var rarity := "Common"
	if instance_or_id is Dictionary:
		var instance: Dictionary = instance_or_id
		definition_id = str(instance.get("definition_id", "unknown_weapon"))
		rarity = str(instance.get("rarity", "Common"))
	else:
		definition_id = str(instance_or_id)
	if icon is NeonWeaponIcon:
		icon.weapon_id = definition_id
		icon.rarity = rarity
		icon.accent = Color.html("#%s" % WeaponCatalog.rarity_accent_hex(rarity)) if WeaponCatalog.rarity_tiers().has(rarity) else Color(0.0, 0.95, 1.0, 0.96)
		icon.secondary = Color(1.0, 0.06, 0.86, 0.86)


func _weapon_icon_resource_path(definition_id: String) -> String:
	return NeonWeaponIcon.icon_resource_path(definition_id)


func _create_pause_menu(root: Control) -> void:
	_pause_panel = _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, Rect2(660, 324, 600, 440), Color(0.0, 0.96, 1.0, 0.96), Color(1.0, 0.06, 0.86, 0.82), 28.0, 2.4, Vector4(34, 24, 34, 24))
	_pause_panel.name = "PauseCommandMenuPanel"
	_pause_panel.visible = false
	_pause_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_pause_panel.animated = true
	root.add_child(_pause_panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 10)
	_pause_panel.add_child(layout)

	var title_label := _make_hud_label("SYSTEM PAUSED")
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 30)
	title_label.add_theme_color_override("font_color", Color(0.94, 1.0, 1.0))
	layout.add_child(title_label)

	var subtitle_label := _make_hud_label("SIMULATION HELD")
	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle_label.add_theme_font_size_override("font_size", 15)
	subtitle_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(subtitle_label)

	var prompt := _make_hud_label("UP/DOWN SELECT  |  A / ENTER CONFIRM  |  B / ESC RESUME")
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt.add_theme_font_size_override("font_size", 10)
	prompt.add_theme_color_override("font_color", Color(0.76, 0.98, 1.0, 0.88))
	layout.add_child(prompt)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(0.0, 0.94, 1.0, 0.36)
	layout.add_child(divider)

	var button_column := VBoxContainer.new()
	button_column.alignment = BoxContainer.ALIGNMENT_CENTER
	button_column.add_theme_constant_override("separation", 10)
	button_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(button_column)

	_pause_menu_buttons.clear()
	_add_pause_menu_button(button_column, "RESUME", "resume")
	_add_pause_menu_button(button_column, "OPTIONS", "options")
	_add_pause_menu_button(button_column, "HOW TO PLAY", "help")
	_add_pause_menu_button(button_column, "RETURN TO TITLE", "return_title")
	_add_pause_menu_button(button_column, "QUIT GAME", "quit")

	_create_pause_options_menu(root)

	_pause_selection_cursor = NeonSelectionCursor.new()
	_pause_selection_cursor.name = "NeonPauseShipCoreSelectionCursor"
	_pause_selection_cursor.size = Vector2(58, 38)
	_pause_selection_cursor.custom_minimum_size = Vector2(58, 38)
	_pause_selection_cursor.visible = false
	root.add_child(_pause_selection_cursor)


func _create_pause_options_menu(root: Control) -> void:
	_pause_options_panel = _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, Rect2(680, 282, 560, 520), Color(1.0, 0.08, 0.86, 0.90), Color(0.0, 0.92, 1.0, 0.74), 24.0, 2.2, Vector4(28, 20, 28, 20))
	_pause_options_panel.name = "PauseOptionsSettingsPanel"
	_pause_options_panel.visible = false
	_pause_options_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	root.add_child(_pause_options_panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 6)
	_pause_options_panel.add_child(layout)

	_pause_options_label = _make_hud_label("OPTIONS")
	_pause_options_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_pause_options_label.add_theme_font_size_override("font_size", 22)
	_pause_options_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_pause_options_label)

	var prompt := _make_hud_label("UP/DOWN SELECT  |  LEFT/RIGHT ADJUST  |  A CONFIRM  |  B BACK")
	prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt.add_theme_font_size_override("font_size", 10)
	prompt.add_theme_color_override("font_color", Color(0.76, 0.98, 1.0, 0.88))
	layout.add_child(prompt)

	var divider := ColorRect.new()
	divider.custom_minimum_size = Vector2(1, 2)
	divider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	divider.color = Color(0.0, 0.94, 1.0, 0.36)
	layout.add_child(divider)

	var option_column := VBoxContainer.new()
	option_column.alignment = BoxContainer.ALIGNMENT_CENTER
	option_column.add_theme_constant_override("separation", 6)
	option_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_child(option_column)

	_pause_options_buttons.clear()
	_add_pause_options_button(option_column, "master_volume")
	_add_pause_options_button(option_column, "sfx_volume")
	_add_pause_options_button(option_column, "music_volume")
	_add_pause_options_button(option_column, "mute")
	_add_pause_options_button(option_column, "screen_shake")
	_add_pause_options_button(option_column, "vfx_intensity")
	_add_pause_options_button(option_column, "fullscreen")
	_add_pause_options_button(option_column, "back")


func _add_pause_menu_button(parent: Control, text: String, action: String) -> void:
	var button := _make_menu_button(text)
	button.set_meta("pause_index", _pause_menu_buttons.size())
	button.set_meta("pause_action", action)
	button.focus_entered.connect(func() -> void:
		_pause_menu_selected_index = int(button.get_meta("pause_index"))
		_update_pause_cursor_position(true)
	)
	button.pressed.connect(func() -> void:
		_activate_pause_menu_selection()
	)
	parent.add_child(button)
	_pause_menu_buttons.append(button)


func _add_pause_options_button(parent: Control, option_key: String) -> void:
	var button := _make_menu_button("")
	button.custom_minimum_size = Vector2(490, 42)
	button.ready.connect(func() -> void:
		button.custom_minimum_size = Vector2(490, 42)
		button.add_theme_font_size_override("font_size", 18)
	)
	button.set_meta("option_key", option_key)
	button.set_meta("pause_option_index", _pause_options_buttons.size())
	button.focus_entered.connect(func() -> void:
		_pause_options_selected_index = int(button.get_meta("pause_option_index"))
		_update_pause_cursor_position(true)
	)
	button.pressed.connect(func() -> void:
		_activate_pause_options_selection()
	)
	parent.add_child(button)
	_pause_options_buttons.append(button)
	_update_pause_menu_labels()


func _add_loadout_chip(parent: Control, title: String, key: String, icon: String, color: Color) -> void:
	var chip := NeonStatChip.new()
	chip.configure(title, "--", icon, color)
	chip.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	chip.custom_minimum_size = Vector2(122, 42)
	parent.add_child(chip)
	_loadout_chips[key] = chip


func _enter_title_menu() -> void:
	_title_menu_active = true
	_title_menu_nav_cooldown = 0.0
	_title_menu_selected_index = 0
	_title_options_visible = false
	_help_visible = false
	_armory_visible = false
	_core_upgrades_visible = false
	_core_upgrade_confirm_pending_id = ""
	_manual_pause = false
	_pause_options_visible = false
	_pause_menu_selected_index = 0
	_pause_options_selected_index = 0
	_clear_weapon_reward_decision_state()
	_clear_chain_link_effects()
	get_tree().paused = true
	_set_gameplay_hud_visible(false)
	if _pause_panel:
		_pause_panel.visible = false
	if _pause_options_panel:
		_pause_options_panel.visible = false
	if _pause_selection_cursor:
		_pause_selection_cursor.visible = false
	if _game_over_panel:
		_game_over_panel.visible = false
	if _success_panel:
		_success_panel.visible = false
	if _level_up_panel:
		_level_up_panel.visible = false
	if _title_menu_panel:
		_title_menu_panel.visible = true
	if _title_selection_cursor:
		_title_selection_cursor.visible = true
	if _help_panel:
		_help_panel.visible = false
	if _help_modal_scrim:
		_help_modal_scrim.visible = false
	if _help_selection_cursor:
		_help_selection_cursor.visible = false
	if _armory_panel:
		_armory_panel.visible = false
	if _armory_selection_cursor:
		_armory_selection_cursor.visible = false
	if _core_upgrades_panel:
		_core_upgrades_panel.visible = false
	if _core_upgrade_selection_cursor:
		_core_upgrade_selection_cursor.visible = false
	_set_player_presentation_visible(false)
	_update_title_menu_labels()
	_set_music_state("title")
	_queue_tutorial_prompt("armory")
	call_deferred("_focus_title_menu_choice")


func _start_title_run() -> void:
	if not _title_menu_active:
		return
	_title_menu_active = false
	_title_options_visible = false
	_help_visible = false
	_armory_visible = false
	_core_upgrades_visible = false
	_core_upgrade_confirm_pending_id = ""
	_manual_pause = false
	_pause_options_visible = false
	_clear_weapon_reward_decision_state()
	_reset_run_event_director_for_run()
	get_tree().paused = false
	_set_gameplay_hud_visible(true)
	if _title_menu_panel:
		_title_menu_panel.visible = false
	if _title_selection_cursor:
		_title_selection_cursor.visible = false
	if _help_panel:
		_help_panel.visible = false
	if _help_selection_cursor:
		_help_selection_cursor.visible = false
	if _armory_panel:
		_armory_panel.visible = false
	if _armory_selection_cursor:
		_armory_selection_cursor.visible = false
	if _core_upgrades_panel:
		_core_upgrades_panel.visible = false
	if _core_upgrade_selection_cursor:
		_core_upgrade_selection_cursor.visible = false
	if _pause_panel:
		_pause_panel.visible = false
	if _pause_options_panel:
		_pause_options_panel.visible = false
	if _pause_selection_cursor:
		_pause_selection_cursor.visible = false
	_set_player_presentation_visible(true)
	_reset_player_presentation_effects()
	_update_title_modal_scrim()
	_update_hud()
	_set_music_state("gameplay")
	_queue_tutorial_prompt("xp")
	_queue_tutorial_prompt("weapons")
	_queue_tutorial_prompt("sectors")
	_play_sfx("ui_select", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.08, 0.18)
	_show_sector_entry_notice(_sector_index, true)


func _toggle_title_options() -> void:
	if _title_options_visible:
		_close_title_options()
	else:
		_open_title_options()
	_play_sfx("ui_select", 0.08)


func _open_title_options() -> void:
	_title_options_visible = true
	_core_upgrades_visible = false
	_armory_visible = false
	_core_upgrade_confirm_pending_id = ""
	_title_options_selected_index = 0
	_update_title_menu_labels()
	_trigger_presentation_flash(Color(1.0, 0.08, 0.86), 0.05, 0.16)
	call_deferred("_focus_title_options_choice")


func _close_title_options() -> void:
	_title_options_visible = false
	_save_settings()
	_update_title_menu_labels()
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.035, 0.14)
	call_deferred("_focus_title_menu_choice")


func _open_armory() -> void:
	if not _title_menu_active:
		return
	_title_options_visible = false
	_core_upgrades_visible = false
	_core_upgrade_confirm_pending_id = ""
	_armory_visible = true
	_armory_nav_cooldown = 0.0
	_armory_action_mode = "browse"
	_armory_action_selected_index = 0
	_clear_armory_forge_pending()
	_armory_selected_section = "equipped"
	_armory_equipped_selected_index = clampi(_armory_equipped_selected_index, 0, maxi(0, _equipped_weapon_instances.size() - 1))
	_armory_stash_selected_index = clampi(_armory_stash_selected_index, 0, maxi(0, _stash_weapon_instances.size() - 1))
	_armory_status_text = "SELECT STORED WEAPON TO COMPARE OR EQUIP"
	_update_title_menu_labels()
	_update_armory_ui()
	_play_sfx("ui_select", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.06, 0.16)
	call_deferred("_focus_armory_choice")


func _close_armory() -> void:
	_armory_visible = false
	_armory_action_mode = "browse"
	_armory_action_selected_index = 0
	_clear_armory_forge_pending()
	_save_weapon_inventory()
	if _armory_panel:
		_armory_panel.visible = false
	if _armory_selection_cursor:
		_armory_selection_cursor.visible = false
	_update_title_menu_labels()
	_play_sfx("ui_back", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.035, 0.12)
	call_deferred("_focus_title_menu_choice")


func _open_core_upgrades() -> void:
	if not _title_menu_active:
		return
	_title_options_visible = false
	_armory_visible = false
	_core_upgrades_visible = true
	_core_upgrade_selected_index = 0
	_core_upgrade_nav_cooldown = 0.0
	_core_upgrade_confirm_pending_id = ""
	_core_upgrade_status_text = "SELECT AN UPGRADE // PURCHASES USE SAVED NEON DUST"
	if _armory_panel:
		_armory_panel.visible = false
	if _armory_selection_cursor:
		_armory_selection_cursor.visible = false
	_update_title_menu_labels()
	_update_core_upgrades_ui()
	_play_sfx("ui_select", 0.08)
	_trigger_presentation_flash(Color(1.0, 0.94, 0.18), 0.06, 0.16)
	call_deferred("_focus_core_upgrade_choice")


func _close_core_upgrades() -> void:
	_core_upgrades_visible = false
	_core_upgrade_confirm_pending_id = ""
	_save_weapon_inventory()
	if _core_upgrades_panel:
		_core_upgrades_panel.visible = false
	if _core_upgrade_selection_cursor:
		_core_upgrade_selection_cursor.visible = false
	_update_title_menu_labels()
	_play_sfx("ui_back", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.035, 0.12)
	call_deferred("_focus_title_menu_choice")


func _open_title_help() -> void:
	if not _title_menu_active:
		return
	_open_help_menu("title")


func _open_pause_help() -> void:
	if not _manual_pause:
		return
	_open_help_menu("pause")


func _open_help_menu(context: String) -> void:
	_help_visible = true
	_help_context = context
	_help_selected_index = 0
	_help_scroll_focus = "body"
	_help_nav_cooldown = 0.0
	if context == "title":
		_title_options_visible = false
		_armory_visible = false
		_core_upgrades_visible = false
		_core_upgrade_confirm_pending_id = ""
		if _armory_panel:
			_armory_panel.visible = false
		if _armory_selection_cursor:
			_armory_selection_cursor.visible = false
		if _core_upgrades_panel:
			_core_upgrades_panel.visible = false
		if _core_upgrade_selection_cursor:
			_core_upgrade_selection_cursor.visible = false
		_update_title_menu_labels()
		if _title_menu_panel:
			_title_menu_panel.visible = false
	elif context == "pause":
		_pause_options_visible = false
		_update_pause_menu_labels()
	if _title_selection_cursor:
		_title_selection_cursor.visible = false
	if _pause_selection_cursor:
		_pause_selection_cursor.visible = false
	if _tutorial_prompt_panel:
		_tutorial_prompt_panel.visible = false
	if _help_panel:
		_help_panel.visible = true
	_update_help_ui()
	_play_sfx("ui_select", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.05, 0.16)
	call_deferred("_focus_help_choice")


func _close_help_menu() -> void:
	var context := _help_context
	_help_visible = false
	if _help_panel:
		_help_panel.visible = false
	if _help_modal_scrim:
		_help_modal_scrim.visible = false
	if _help_selection_cursor:
		_help_selection_cursor.visible = false
	_play_sfx("ui_back", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.035, 0.12)
	if context == "pause":
		_update_pause_menu_labels()
		call_deferred("_focus_pause_menu_choice")
	else:
		if _title_menu_panel:
			_title_menu_panel.visible = true
		_update_title_menu_labels()
		call_deferred("_focus_title_menu_choice")


func _open_pause_options() -> void:
	if not _manual_pause:
		return
	_pause_options_visible = true
	_pause_options_selected_index = 0
	_update_pause_menu_labels()
	_trigger_presentation_flash(Color(1.0, 0.08, 0.86), 0.05, 0.16)
	_play_sfx("ui_select", 0.08)
	call_deferred("_focus_pause_options_choice")


func _close_pause_options(refocus_menu := true) -> void:
	_pause_options_visible = false
	_save_settings()
	_update_pause_menu_labels()
	if refocus_menu:
		_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.035, 0.14)
		call_deferred("_focus_pause_menu_choice")


func _resume_gameplay_from_pause() -> void:
	if not _manual_pause:
		return
	_pause_options_visible = false
	_help_visible = false
	_manual_pause = false
	get_tree().paused = false
	if _pause_panel:
		_pause_panel.visible = false
	if _pause_options_panel:
		_pause_options_panel.visible = false
	if _pause_selection_cursor:
		_pause_selection_cursor.visible = false
	if _help_panel:
		_help_panel.visible = false
	if _help_selection_cursor:
		_help_selection_cursor.visible = false
	_play_sfx("pause", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.035, 0.12)


func _return_to_title_from_pause() -> void:
	_save_settings()
	_save_weapon_inventory()
	_pause_options_visible = false
	_help_visible = false
	_manual_pause = false
	_level_up_active = false
	_sector_reward_active = false
	_clear_weapon_reward_decision_state()
	_clear_run_event_state()
	_title_menu_active = true
	_clear_enemy_projectiles_and_hazards()
	_set_music_state("none")
	if _pause_panel:
		_pause_panel.visible = false
	if _pause_options_panel:
		_pause_options_panel.visible = false
	if _pause_selection_cursor:
		_pause_selection_cursor.visible = false
	if _help_panel:
		_help_panel.visible = false
	if _help_selection_cursor:
		_help_selection_cursor.visible = false
	_play_sfx("ui_back", 0.08)
	get_tree().paused = false
	call_deferred("_reload_official_scene")


func _quit_game() -> void:
	_save_settings()
	_save_weapon_inventory()
	_play_sfx("ui_select", 0.08)
	get_tree().quit()


func _handle_title_menu_input(event: InputEvent) -> void:
	if _armory_visible:
		_handle_armory_input(event)
		return
	if _core_upgrades_visible:
		_handle_core_upgrades_input(event)
		return
	if _title_options_visible:
		_handle_title_options_input(event)
		return
	if event.is_action_pressed("cancel"):
		if _title_options_visible:
			_close_title_options()
			_play_sfx("ui_back", 0.08)
		get_viewport().set_input_as_handled()
		return
	if _is_start_button_event(event):
		_start_title_run()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_title_menu_selection()
		get_viewport().set_input_as_handled()
		return
	if _title_menu_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_title_menu_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_title_menu_selection(1)
		get_viewport().set_input_as_handled()


func _handle_title_options_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel") or _is_start_button_event(event):
		_close_title_options()
		_play_sfx("ui_back", 0.08)
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_title_options_selection()
		get_viewport().set_input_as_handled()
		return
	if _title_menu_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_title_options_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_title_options_selection(1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_left"):
		_adjust_title_option(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_right"):
		_adjust_title_option(1)
		get_viewport().set_input_as_handled()


func _handle_core_upgrades_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel") or _is_start_button_event(event):
		if _core_upgrade_confirm_pending_id != "":
			_core_upgrade_confirm_pending_id = ""
			_core_upgrade_status_text = "PURCHASE CANCELLED"
			_update_core_upgrades_ui()
			_play_sfx("ui_back", 0.08)
		else:
			_close_core_upgrades()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_core_upgrade_selection()
		get_viewport().set_input_as_handled()
		return
	if _core_upgrade_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_core_upgrade_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_core_upgrade_selection(1)
		get_viewport().set_input_as_handled()


func _handle_armory_input(event: InputEvent) -> void:
	if _armory_action_mode != "browse":
		_handle_armory_action_input(event)
		return
	if event.is_action_pressed("cancel") or _is_start_button_event(event):
		_close_armory()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_armory_selection()
		get_viewport().set_input_as_handled()
		return
	if _armory_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_armory_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_armory_selection(1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		_switch_armory_section()
		get_viewport().set_input_as_handled()


func _handle_armory_action_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel") or _is_start_button_event(event):
		if _armory_action_mode == "forge_confirm":
			_open_armory_forge_actions("FORGE ACTION CANCELLED")
		elif _armory_action_mode == "fusion_confirm":
			_open_armory_fusion_materials("FUSION CONFIRM CANCELLED")
		elif _armory_action_mode == "fusion_materials":
			_restore_fusion_primary_selection()
			_open_armory_forge_actions("FUSION CANCELLED")
		else:
			_close_armory_action_mode()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		if _armory_action_mode == "fusion_materials":
			_confirm_armory_fusion_material()
			get_viewport().set_input_as_handled()
			return
		_activate_armory_action_selection()
		get_viewport().set_input_as_handled()
		return
	if _armory_nav_cooldown > 0.0:
		return
	if _armory_action_mode == "fusion_materials":
		if event.is_action_pressed("move_left") or event.is_action_pressed("move_up"):
			_move_armory_fusion_material_selection(-1)
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("move_right") or event.is_action_pressed("move_down"):
			_move_armory_fusion_material_selection(1)
			get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_up"):
		_move_armory_action_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_right") or event.is_action_pressed("move_down"):
		_move_armory_action_selection(1)
		get_viewport().set_input_as_handled()


func _handle_pause_menu_input(event: InputEvent) -> void:
	if _pause_options_visible:
		_handle_pause_options_input(event)
		return
	if event.is_action_pressed("cancel") or event.is_action_pressed("pause") or _is_start_button_event(event):
		_resume_gameplay_from_pause()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_pause_menu_selection()
		get_viewport().set_input_as_handled()
		return
	if _pause_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_pause_menu_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_pause_menu_selection(1)
		get_viewport().set_input_as_handled()


func _handle_pause_options_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		_close_pause_options()
		_play_sfx("ui_back", 0.08)
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("pause") or _is_start_button_event(event):
		_close_pause_options(false)
		_resume_gameplay_from_pause()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_pause_options_selection()
		get_viewport().set_input_as_handled()
		return
	if _pause_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_pause_options_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_pause_options_selection(1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_left"):
		_adjust_pause_option(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_right"):
		_adjust_pause_option(1)
		get_viewport().set_input_as_handled()


func _handle_help_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel") or _is_start_button_event(event):
		_close_help_menu()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("confirm"):
		_activate_help_selection()
		get_viewport().set_input_as_handled()
		return
	if _help_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_up"):
		_move_help_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_help_selection(1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_left"):
		_cycle_help_scroll_focus(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_right"):
		_cycle_help_scroll_focus(1)
		get_viewport().set_input_as_handled()


func _move_title_menu_selection(direction: int) -> void:
	if _title_menu_buttons.is_empty():
		return
	_title_menu_selected_index = wrapi(_title_menu_selected_index + direction, 0, _title_menu_buttons.size())
	_title_menu_nav_cooldown = 0.16
	_focus_title_menu_choice()
	_play_sfx("ui_move", 0.04)


func _move_title_options_selection(direction: int) -> void:
	if _title_options_buttons.is_empty():
		return
	_title_options_selected_index = wrapi(_title_options_selected_index + direction, 0, _title_options_buttons.size())
	_title_menu_nav_cooldown = 0.14
	_focus_title_options_choice()
	_play_sfx("ui_move", 0.04)


func _move_core_upgrade_selection(direction: int) -> void:
	if _core_upgrade_buttons.is_empty():
		return
	_core_upgrade_selected_index = wrapi(_core_upgrade_selected_index + direction, 0, _core_upgrade_buttons.size())
	_core_upgrade_confirm_pending_id = ""
	_core_upgrade_nav_cooldown = 0.14
	_update_core_upgrades_ui()
	_focus_core_upgrade_choice()
	_play_sfx("ui_move", 0.04)


func _move_armory_selection(direction: int) -> void:
	if _armory_selected_section == "equipped":
		if _equipped_weapon_instances.is_empty():
			return
		_armory_equipped_selected_index = wrapi(_armory_equipped_selected_index + direction, 0, _equipped_weapon_instances.size())
	else:
		if _stash_weapon_instances.is_empty():
			_armory_status_text = "NO STORED WEAPONS // CLEAR SECTORS TO GENERATE WEAPON REWARDS"
			_update_armory_ui()
			return
		_armory_stash_selected_index = wrapi(_armory_stash_selected_index + direction, 0, _stash_weapon_instances.size())
	_armory_nav_cooldown = 0.14
	_update_armory_ui()
	_focus_armory_choice()
	_play_sfx("ui_move", 0.04)


func _switch_armory_section() -> void:
	_armory_selected_section = "stash" if _armory_selected_section == "equipped" else "equipped"
	if _armory_selected_section == "stash" and _stash_weapon_instances.is_empty():
		_armory_status_text = "NO STORED WEAPONS // CLEAR SECTORS TO GENERATE WEAPON REWARDS"
	else:
		_armory_status_text = "STASH ACTIONS: A OPENS EQUIP / FORGE / SCRAP OPTIONS" if _armory_selected_section == "stash" else "EQUIPPED LOADOUT ACTIVE // A OPENS FORGE OPTIONS"
	_armory_nav_cooldown = 0.14
	_update_armory_ui()
	_focus_armory_choice()
	_play_sfx("ui_move", 0.04)


func _move_armory_action_selection(direction: int) -> void:
	var visible_buttons := _visible_armory_action_buttons()
	if visible_buttons.is_empty():
		return
	_armory_action_selected_index = wrapi(_armory_action_selected_index + direction, 0, visible_buttons.size())
	_armory_nav_cooldown = 0.12
	_focus_armory_action_choice()
	_update_armory_ui()
	_play_sfx("ui_move", 0.04)


func _move_armory_fusion_material_selection(direction: int, play_feedback := true) -> void:
	if _stash_weapon_instances.is_empty() or _armory_fusion_primary_instance.is_empty():
		return
	var next_index := _next_fusion_material_index(_armory_stash_selected_index, direction)
	if next_index < 0:
		if play_feedback:
			_play_sfx("ui_back", 0.045)
		return
	_armory_stash_selected_index = next_index
	_armory_fusion_material_index = next_index
	_armory_fusion_material_instance = Dictionary(_stash_weapon_instances[next_index]).duplicate(true)
	_armory_nav_cooldown = 0.12
	_armory_status_text = "FUSION MATERIAL SELECTED // %s // %s" % [
		str(_armory_fusion_material_instance.get("name", "WEAPON")).to_upper(),
		_fusion_compatibility_text(_armory_fusion_primary_instance, _armory_fusion_material_instance).to_upper()
	]
	_update_armory_ui()
	_focus_armory_choice()
	if play_feedback:
		_play_sfx("ui_move", 0.04)


func _visible_armory_action_buttons() -> Array[Button]:
	var buttons: Array[Button] = []
	for button in _armory_action_buttons:
		if is_instance_valid(button) and button.visible:
			buttons.append(button)
	return buttons


func _open_armory_stash_actions() -> void:
	if _stash_weapon_instances.is_empty():
		_armory_status_text = "NO STORED WEAPONS // CLEAR SECTORS TO GENERATE WEAPON REWARDS"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	_armory_action_mode = "stash_actions"
	_armory_action_selected_index = 0
	_clear_armory_forge_pending()
	_armory_status_text = "CHOOSE STASH ACTION // EQUIP/SWAP, FORGE, OR SCRAP STORED WEAPON"
	_update_armory_ui()
	call_deferred("_focus_armory_action_choice")
	_play_sfx("ui_select", 0.08)


func _open_armory_equipped_actions() -> void:
	if _equipped_weapon_instances.is_empty():
		_armory_status_text = "NO EQUIPPED WEAPON SELECTED"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	_armory_action_mode = "equipped_actions"
	_armory_action_selected_index = 0
	_clear_armory_forge_pending()
	_armory_status_text = "EQUIPPED WEAPON SELECTED // OPEN FORGE TO SPEND NEON DUST"
	_update_armory_ui()
	call_deferred("_focus_armory_action_choice")
	_play_sfx("ui_select", 0.08)


func _open_armory_scrap_confirm() -> void:
	if _stash_weapon_instances.is_empty():
		_close_armory_action_mode()
		return
	_armory_action_mode = "scrap_confirm"
	_armory_action_selected_index = 0
	var instance: Dictionary = _stash_weapon_instances[clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)]
	var dust_amount := _neon_dust_value_for_weapon(instance)
	_armory_status_text = "SCRAP THIS WEAPON FOR %d NEON DUST? %s // THIS REMOVES IT FROM STASH" % [dust_amount, str(instance.get("name", "WEAPON")).to_upper()]
	_update_armory_ui()
	call_deferred("_focus_armory_action_choice")
	_play_sfx("ui_select", 0.08)


func _open_armory_forge_actions(status := "") -> void:
	var instance := _armory_selected_weapon_instance()
	if instance.is_empty():
		_close_armory_action_mode()
		return
	_armory_action_mode = "forge_actions"
	_armory_action_selected_index = 0
	_clear_armory_forge_pending()
	_armory_status_text = status if status != "" else "WEAPON FORGE // CHOOSE AN ACTION // NEON DUST %d" % _neon_dust
	_update_armory_ui()
	call_deferred("_focus_armory_action_choice")
	_play_sfx("ui_select", 0.08)


func _open_armory_forge_confirm(action: String) -> void:
	var instance := _armory_selected_weapon_instance()
	if instance.is_empty():
		_open_armory_forge_actions("NO WEAPON SELECTED FOR FORGE")
		return
	var cost := _forge_action_cost(action, instance)
	if cost < 0:
		_open_armory_forge_actions("%s IS LOCKED FOR THIS WEAPON" % _forge_action_title(action))
		_play_sfx("ui_back", 0.08)
		return
	if _neon_dust < cost:
		_open_armory_forge_actions("NOT ENOUGH NEON DUST // NEED %d MORE FOR %s" % [cost - _neon_dust, _forge_action_title(action)])
		_play_sfx("ui_back", 0.08)
		return
	var preview := _forge_preview_instance(action, instance)
	if preview.is_empty():
		_open_armory_forge_actions("FORGE PREVIEW FAILED // ACTION BLOCKED")
		_play_sfx("ui_back", 0.08)
		return
	_armory_forge_pending_action = action
	_armory_forge_pending_cost = cost
	_armory_forge_preview_instance = preview
	_armory_action_mode = "forge_confirm"
	_armory_action_selected_index = 0
	_armory_status_text = "CONFIRM %s // COST %d NEON DUST // REMAINING %d // OLD ROLLS CHANGE ONLY AFTER CONFIRM" % [_forge_action_title(action), cost, _neon_dust - cost]
	_update_armory_ui()
	call_deferred("_focus_armory_action_choice")
	_play_sfx("ui_select", 0.08)


func _open_armory_fusion_materials(status := "") -> void:
	var primary := _fusion_primary_or_selected_weapon()
	if primary.is_empty():
		_open_armory_forge_actions("NO PRIMARY WEAPON SELECTED FOR FUSION")
		_play_sfx("ui_back", 0.08)
		return
	if _evolution_rank(primary) >= EVOLUTION_MAX_RANK:
		_open_armory_forge_actions("%s IS ALREADY EVOLVED III" % str(primary.get("name", "WEAPON")).to_upper())
		_play_sfx("ui_back", 0.08)
		return
	if _armory_fusion_primary_instance.is_empty():
		_capture_fusion_primary(primary)
	else:
		primary = _armory_fusion_primary_instance
	var material_index := _best_fusion_material_index(primary)
	if material_index < 0:
		_open_armory_forge_actions("NO COMPATIBLE STASH MATERIAL // SAME FAMILY OR GEOMETRY GROUP REQUIRED")
		_play_sfx("ui_back", 0.08)
		return
	_armory_action_mode = "fusion_materials"
	_armory_action_selected_index = 0
	_armory_selected_section = "stash"
	_armory_stash_selected_index = material_index
	_armory_fusion_material_index = material_index
	_armory_fusion_material_instance = Dictionary(_stash_weapon_instances[material_index]).duplicate(true)
	_armory_status_text = status if status != "" else "SELECT FUSION MATERIAL // A CONFIRMS // FUSION CONSUMES MATERIAL WEAPON"
	_update_armory_ui()
	call_deferred("_focus_armory_choice")
	_play_sfx("ui_select", 0.08)


func _confirm_armory_fusion_material() -> void:
	if _armory_fusion_primary_instance.is_empty() or _stash_weapon_instances.is_empty():
		_open_armory_forge_actions("FUSION CANCELLED // MISSING PRIMARY OR MATERIAL")
		return
	_armory_fusion_material_index = clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)
	var material := Dictionary(_stash_weapon_instances[_armory_fusion_material_index]).duplicate(true)
	if not _is_valid_fusion_material_index(_armory_fusion_primary_instance, _armory_fusion_material_index):
		_armory_status_text = "INCOMPATIBLE MATERIAL // SAME FAMILY OR GEOMETRY GROUP REQUIRED"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	var cost := _fusion_action_cost(_armory_fusion_primary_instance, material)
	if cost < 0:
		_armory_status_text = "FUSION LOCKED // PRIMARY IS MAX EVOLUTION OR MATERIAL INVALID"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	if _neon_dust < cost:
		_armory_status_text = "NOT ENOUGH NEON DUST // NEED %d MORE FOR FUSION" % [cost - _neon_dust]
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	var preview := _fusion_preview_instance(_armory_fusion_primary_instance, material, cost)
	if preview.is_empty():
		_armory_status_text = "FUSION PREVIEW FAILED // ACTION BLOCKED"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	_armory_fusion_material_instance = material
	_armory_forge_pending_action = "evolve_fuse"
	_armory_forge_pending_cost = cost
	_armory_forge_preview_instance = preview
	_armory_action_mode = "fusion_confirm"
	_armory_action_selected_index = 0
	_armory_status_text = "CONFIRM EVOLVE / FUSE // COST %d NEON DUST // REMAINING %d // MATERIAL WILL BE CONSUMED" % [cost, _neon_dust - cost]
	_update_armory_ui()
	call_deferred("_focus_armory_action_choice")
	_play_sfx("ui_select", 0.08)


func _close_armory_action_mode() -> void:
	if _armory_action_mode in ["fusion_materials", "fusion_confirm"]:
		_restore_fusion_primary_selection()
	_armory_action_mode = "browse"
	_armory_action_selected_index = 0
	_clear_armory_forge_pending()
	_armory_status_text = "STASH ACTION CANCELLED" if _armory_selected_section == "stash" else "EQUIPPED LOADOUT ACTIVE"
	_update_armory_ui()
	call_deferred("_focus_armory_choice")
	_play_sfx("ui_back", 0.08)


func _focus_armory_action_choice() -> void:
	var buttons := _visible_armory_action_buttons()
	if buttons.is_empty():
		return
	_armory_action_selected_index = clampi(_armory_action_selected_index, 0, buttons.size() - 1)
	var button := buttons[_armory_action_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
	_update_armory_cursor_position(true)


func _activate_armory_action_selection() -> void:
	var buttons := _visible_armory_action_buttons()
	if buttons.is_empty():
		_close_armory_action_mode()
		return
	_armory_action_selected_index = clampi(_armory_action_selected_index, 0, buttons.size() - 1)
	var action := str(buttons[_armory_action_selected_index].get_meta("armory_action", "cancel"))
	match action:
		"equip":
			_armory_action_mode = "browse"
			_equip_selected_stash_weapon()
		"forge":
			_open_armory_forge_actions()
		"forge_power", "reroll_stats", "reroll_modifier":
			_open_armory_forge_confirm(action)
		"evolve_fuse":
			_open_armory_fusion_materials()
		"confirm_forge":
			_apply_pending_forge_action()
		"cancel_forge_confirm":
			_open_armory_forge_actions("FORGE ACTION CANCELLED")
		"confirm_fusion_material":
			_confirm_armory_fusion_material()
		"cancel_fusion_material":
			_restore_fusion_primary_selection()
			_open_armory_forge_actions("FUSION CANCELLED")
		"confirm_fusion":
			_apply_pending_forge_action()
		"cancel_fusion_confirm":
			_open_armory_fusion_materials("FUSION CONFIRM CANCELLED")
		"scrap":
			_open_armory_scrap_confirm()
		"confirm_scrap":
			_scrap_selected_stash_weapon()
		_:
			_close_armory_action_mode()


func _move_pause_menu_selection(direction: int) -> void:
	if _pause_menu_buttons.is_empty():
		return
	_pause_menu_selected_index = wrapi(_pause_menu_selected_index + direction, 0, _pause_menu_buttons.size())
	_pause_nav_cooldown = 0.16
	_focus_pause_menu_choice()
	_play_sfx("ui_move", 0.04)


func _move_pause_options_selection(direction: int) -> void:
	if _pause_options_buttons.is_empty():
		return
	_pause_options_selected_index = wrapi(_pause_options_selected_index + direction, 0, _pause_options_buttons.size())
	_pause_nav_cooldown = 0.14
	_focus_pause_options_choice()
	_play_sfx("ui_move", 0.04)


func _move_help_selection(direction: int) -> void:
	if _help_buttons.is_empty():
		return
	_help_selected_index = wrapi(_help_selected_index + direction, 0, _help_buttons.size())
	_help_nav_cooldown = 0.14
	_update_help_ui()
	_focus_help_choice()
	_play_sfx("ui_move", 0.04)


func _cycle_help_scroll_focus(direction: int) -> void:
	var order := ["tabs", "body", "icons"]
	var index := order.find(_help_scroll_focus)
	if index < 0:
		index = 1
	_help_scroll_focus = order[wrapi(index + direction, 0, order.size())]
	_help_nav_cooldown = 0.12
	_update_help_ui()
	_play_sfx("ui_move", 0.04)


func _focus_title_menu_choice() -> void:
	if _title_menu_buttons.is_empty():
		return
	_title_menu_selected_index = clampi(_title_menu_selected_index, 0, _title_menu_buttons.size() - 1)
	var button := _title_menu_buttons[_title_menu_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
	_update_title_cursor_position(true)


func _focus_title_options_choice() -> void:
	if _title_options_buttons.is_empty():
		return
	_title_options_selected_index = clampi(_title_options_selected_index, 0, _title_options_buttons.size() - 1)
	var button := _title_options_buttons[_title_options_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
	_update_title_cursor_position(true)


func _focus_core_upgrade_choice() -> void:
	if not _core_upgrades_visible or _core_upgrade_buttons.is_empty():
		return
	_core_upgrade_selected_index = clampi(_core_upgrade_selected_index, 0, _core_upgrade_buttons.size() - 1)
	var button := _core_upgrade_buttons[_core_upgrade_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
	_update_core_upgrade_cursor_position(true)


func _focus_armory_choice() -> void:
	if not _armory_visible:
		return
	if _armory_action_mode != "browse":
		_focus_armory_action_choice()
		return
	var button: Button
	if _armory_selected_section == "stash":
		button = _armory_stash_button_for_index(_armory_stash_selected_index)
		if not is_instance_valid(button):
			button = _armory_equipped_button_for_index(_armory_equipped_selected_index)
	else:
		button = _armory_equipped_button_for_index(_armory_equipped_selected_index)
	if is_instance_valid(button) and not button.disabled:
		button.grab_focus()
		if _armory_selected_section == "stash":
			_ensure_scroll_visible(_armory_stash_scroll, button)
	_update_armory_cursor_position(true)
	call_deferred("_update_armory_cursor_position", true)


func _focus_pause_menu_choice() -> void:
	if _pause_menu_buttons.is_empty():
		return
	_pause_menu_selected_index = clampi(_pause_menu_selected_index, 0, _pause_menu_buttons.size() - 1)
	var button := _pause_menu_buttons[_pause_menu_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
	_update_pause_cursor_position(true)


func _focus_pause_options_choice() -> void:
	if _pause_options_buttons.is_empty():
		return
	_pause_options_selected_index = clampi(_pause_options_selected_index, 0, _pause_options_buttons.size() - 1)
	var button := _pause_options_buttons[_pause_options_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
	_update_pause_cursor_position(true)


func _focus_help_choice() -> void:
	if not _help_visible or _help_buttons.is_empty():
		return
	_help_selected_index = clampi(_help_selected_index, 0, _help_buttons.size() - 1)
	var button := _help_buttons[_help_selected_index]
	if is_instance_valid(button):
		button.grab_focus()
		_ensure_scroll_visible(_help_tab_scroll, button)
	_update_help_cursor_position(true)
	call_deferred("_update_help_cursor_position", true)


func _activate_title_menu_selection() -> void:
	match _title_menu_selected_index:
		0:
			_start_title_run()
		1:
			_open_armory()
		2:
			_open_core_upgrades()
		3:
			_toggle_title_options()
		4:
			_open_title_help()
		5:
			_quit_game()


func _activate_armory_selection() -> void:
	if _armory_selected_section == "stash":
		_open_armory_stash_actions()
	else:
		_open_armory_equipped_actions()


func _activate_core_upgrade_selection() -> void:
	if _core_upgrade_buttons.is_empty():
		return
	_core_upgrade_selected_index = clampi(_core_upgrade_selected_index, 0, _core_upgrade_buttons.size() - 1)
	var definitions := _core_upgrade_definitions()
	if _core_upgrade_selected_index >= definitions.size():
		_close_core_upgrades()
		return
	var definition: Dictionary = definitions[_core_upgrade_selected_index]
	var upgrade_id := str(definition["id"])
	var rank := _core_upgrade_rank(upgrade_id)
	var max_rank := int(definition.get("max_rank", 5))
	if rank >= max_rank:
		_core_upgrade_confirm_pending_id = ""
		_core_upgrade_status_text = "%s IS MAXED" % str(definition.get("name", "UPGRADE"))
		_update_core_upgrades_ui()
		_play_sfx("ui_back", 0.08)
		return
	var cost := _core_upgrade_cost(definition)
	if _neon_dust < cost:
		_core_upgrade_confirm_pending_id = ""
		_core_upgrade_status_text = "NOT ENOUGH NEON DUST // NEED %d MORE" % [cost - _neon_dust]
		_update_core_upgrades_ui()
		_play_sfx("ui_back", 0.08)
		return
	if _core_upgrade_confirm_pending_id != upgrade_id:
		_core_upgrade_confirm_pending_id = upgrade_id
		_core_upgrade_status_text = "CONFIRM %s RANK %d -> %d // COST %d NEON DUST // REMAINING %d" % [str(definition.get("name", "UPGRADE")), rank, rank + 1, cost, _neon_dust - cost]
		_update_core_upgrades_ui()
		_play_sfx("ui_select", 0.08)
		return
	_neon_dust = maxi(0, _neon_dust - cost)
	_core_upgrade_ranks[upgrade_id] = rank + 1
	_core_upgrade_confirm_pending_id = ""
	_core_upgrade_status_text = "PURCHASED %s RANK %d // -%d NEON DUST // REMAINING %d" % [str(definition.get("name", "UPGRADE")), rank + 1, cost, _neon_dust]
	_apply_core_upgrade_bonuses()
	_save_weapon_inventory()
	_update_core_upgrades_ui()
	_update_armory_ui()
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(Color(1.0, 0.94, 0.18), 0.08, 0.18)


func _activate_pause_menu_selection() -> void:
	if _pause_menu_buttons.is_empty():
		return
	_pause_menu_selected_index = clampi(_pause_menu_selected_index, 0, _pause_menu_buttons.size() - 1)
	var action := str(_pause_menu_buttons[_pause_menu_selected_index].get_meta("pause_action", "resume"))
	match action:
		"resume":
			_resume_gameplay_from_pause()
		"options":
			_open_pause_options()
		"help":
			_open_pause_help()
		"return_title":
			_return_to_title_from_pause()
		"quit":
			_quit_game()


func _activate_help_selection() -> void:
	if _help_buttons.is_empty():
		return
	_help_selected_index = clampi(_help_selected_index, 0, _help_buttons.size() - 1)
	_update_help_ui()
	_focus_help_choice()
	_play_sfx("ui_select", 0.08)


func _activate_title_options_selection() -> void:
	if _title_options_buttons.is_empty():
		return
	_title_options_selected_index = clampi(_title_options_selected_index, 0, _title_options_buttons.size() - 1)
	var key := str(_title_options_buttons[_title_options_selected_index].get_meta("option_key", ""))
	match key:
		"mute", "screen_shake", "fullscreen":
			_adjust_title_option(1)
		"back":
			_close_title_options()
			_play_sfx("ui_back", 0.08)
		_:
			_adjust_title_option(1)


func _activate_pause_options_selection() -> void:
	if _pause_options_buttons.is_empty():
		return
	_pause_options_selected_index = clampi(_pause_options_selected_index, 0, _pause_options_buttons.size() - 1)
	var key := str(_pause_options_buttons[_pause_options_selected_index].get_meta("option_key", ""))
	match key:
		"mute", "screen_shake", "fullscreen":
			_adjust_pause_option(1)
		"back":
			_close_pause_options()
			_play_sfx("ui_back", 0.08)
		_:
			_adjust_pause_option(1)


func _adjust_title_option(direction: int) -> void:
	if _title_options_buttons.is_empty():
		return
	_title_options_selected_index = clampi(_title_options_selected_index, 0, _title_options_buttons.size() - 1)
	var key := str(_title_options_buttons[_title_options_selected_index].get_meta("option_key", ""))
	match key:
		"master_volume":
			_master_volume = clampf(_master_volume + float(direction) * 0.05, 0.0, 1.0)
		"sfx_volume":
			_sfx_volume = clampf(_sfx_volume + float(direction) * 0.05, 0.0, 1.0)
		"music_volume":
			_music_volume = clampf(_music_volume + float(direction) * 0.05, 0.0, 1.0)
		"mute":
			_audio_muted = not _audio_muted
		"screen_shake":
			_screen_shake_enabled = not _screen_shake_enabled
			if not _screen_shake_enabled:
				_shake_time = 0.0
				_shake_strength = 0.0
				_shake_duration = 0.0
				if is_instance_valid(_camera):
					_camera.position = _camera_base_position
		"vfx_intensity":
			_vfx_intensity = wrapi(_vfx_intensity + direction, 0, VFX_INTENSITY_NAMES.size())
		"fullscreen":
			_fullscreen_enabled = not _fullscreen_enabled
		"back":
			_close_title_options()
			return
		_:
			return
	_apply_settings_runtime()
	_save_settings()
	_update_title_menu_labels()
	_play_sfx("ui_adjust", 0.045)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.025, 0.10)


func _adjust_pause_option(direction: int) -> void:
	if _pause_options_buttons.is_empty():
		return
	_pause_options_selected_index = clampi(_pause_options_selected_index, 0, _pause_options_buttons.size() - 1)
	var key := str(_pause_options_buttons[_pause_options_selected_index].get_meta("option_key", ""))
	match key:
		"master_volume":
			_master_volume = clampf(_master_volume + float(direction) * 0.05, 0.0, 1.0)
		"sfx_volume":
			_sfx_volume = clampf(_sfx_volume + float(direction) * 0.05, 0.0, 1.0)
		"music_volume":
			_music_volume = clampf(_music_volume + float(direction) * 0.05, 0.0, 1.0)
		"mute":
			_audio_muted = not _audio_muted
		"screen_shake":
			_screen_shake_enabled = not _screen_shake_enabled
			if not _screen_shake_enabled:
				_shake_time = 0.0
				_shake_strength = 0.0
				_shake_duration = 0.0
				if is_instance_valid(_camera):
					_camera.position = _camera_base_position
		"vfx_intensity":
			_vfx_intensity = wrapi(_vfx_intensity + direction, 0, VFX_INTENSITY_NAMES.size())
		"fullscreen":
			_fullscreen_enabled = not _fullscreen_enabled
		"back":
			_close_pause_options()
			return
		_:
			return
	_apply_settings_runtime()
	_save_settings()
	_update_title_menu_labels()
	_update_pause_menu_labels()
	_play_sfx("ui_adjust", 0.045)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.025, 0.10)


func _update_title_menu_labels() -> void:
	if _title_options_panel:
		_title_options_panel.visible = _title_options_visible
	if _title_options_label:
		_title_options_label.text = "OPTIONS"
	if _core_upgrades_panel:
		_core_upgrades_panel.visible = _core_upgrades_visible
	if _title_menu_buttons.size() > 3:
		_title_menu_buttons[3].text = "OPTIONS"
	for button in _title_options_buttons:
		if is_instance_valid(button):
			button.text = _option_button_text(str(button.get_meta("option_key", "")))
	_update_title_modal_scrim()
	_update_title_cursor_position(true)
	_update_core_upgrades_ui()


func _update_core_upgrades_ui() -> void:
	if not is_instance_valid(_core_upgrades_panel):
		return
	_core_upgrades_panel.visible = _core_upgrades_visible
	if not _core_upgrades_visible:
		if _core_upgrade_selection_cursor:
			_core_upgrade_selection_cursor.visible = false
		return
	if _core_upgrade_dust_label:
		_core_upgrade_dust_label.text = "NEON DUST: %d" % _neon_dust
	var definitions := _core_upgrade_definitions()
	_core_upgrade_selected_index = clampi(_core_upgrade_selected_index, 0, maxi(0, _core_upgrade_buttons.size() - 1))
	for i in range(_core_upgrade_buttons.size()):
		var button := _core_upgrade_buttons[i]
		if not is_instance_valid(button):
			continue
		if i >= definitions.size():
			button.text = "BACK"
			button.disabled = false
			_apply_weapon_reward_button_accent(button, i == _core_upgrade_selected_index, Color(0.0, 0.96, 1.0, 0.92))
			continue
		var definition: Dictionary = definitions[i]
		var upgrade_id := str(definition["id"])
		var rank := _core_upgrade_rank(upgrade_id)
		var max_rank := int(definition.get("max_rank", 5))
		var cost := _core_upgrade_cost(definition)
		var status := "MAX" if rank >= max_rank else "COST %d DUST" % cost
		var confirm := " // CONFIRM?" if _core_upgrade_confirm_pending_id == upgrade_id else ""
		button.text = "%s%s\nRANK %d / %d  //  %s\n%s\nCURRENT: %s" % [
			str(definition.get("name", "UPGRADE")),
			confirm,
			rank,
			max_rank,
			status,
			str(definition.get("summary", "")),
			_core_upgrade_effect_text(definition)
		]
		button.disabled = false
		var accent := Color(1.0, 0.94, 0.18, 0.94) if _neon_dust >= cost or rank >= max_rank else Color(0.0, 0.96, 1.0, 0.76)
		_apply_weapon_reward_button_accent(button, i == _core_upgrade_selected_index, accent)
	if _core_upgrade_status_label:
		_core_upgrade_status_label.text = _core_upgrade_status_text
	_update_core_upgrade_cursor_position(true)


func _update_pause_menu_labels() -> void:
	if _pause_panel:
		_pause_panel.visible = _manual_pause and not _pause_options_visible and not (_help_visible and _help_context == "pause")
	if _pause_options_panel:
		_pause_options_panel.visible = _manual_pause and _pause_options_visible and not (_help_visible and _help_context == "pause")
	if _pause_options_label:
		_pause_options_label.text = "OPTIONS"
	for button in _pause_options_buttons:
		if is_instance_valid(button):
			button.text = _option_button_text(str(button.get_meta("option_key", "")))
	_update_pause_cursor_position(true)


func _update_help_ui() -> void:
	if not is_instance_valid(_help_panel):
		return
	_help_panel.visible = _help_visible
	if is_instance_valid(_help_modal_scrim):
		_help_modal_scrim.visible = _help_visible
	_update_title_modal_scrim()
	if not _help_visible:
		if _help_selection_cursor:
			_help_selection_cursor.visible = false
		return
	var pages := _help_page_data()
	if pages.is_empty():
		return
	_help_selected_index = clampi(_help_selected_index, 0, pages.size() - 1)
	var page: Dictionary = pages[_help_selected_index]
	if _help_title_label:
		_help_title_label.text = "HOW TO PLAY // %s" % str(page.get("title", "HELP"))
	if _help_prompt_label:
		_help_prompt_label.text = "UP/DOWN SELECT SECTION  |  LEFT/RIGHT SCROLL FOCUS: %s  |  RS SCROLL  |  A / ENTER SELECT  |  B / ESC BACK" % _help_scroll_focus.to_upper()
	if _help_body_label:
		_help_body_label.text = str(page.get("body", ""))
	var example_icons := _help_icon_families_for_page(_help_selected_index)
	if is_instance_valid(_help_icon_row):
		_help_icon_row.visible = not example_icons.is_empty()
	for i in range(_help_example_icons.size()):
		var icon := _help_example_icons[i]
		if i < example_icons.size():
			_set_weapon_icon(icon, example_icons[i], true)
		else:
			_set_weapon_icon(icon, "unknown_weapon", false)
	for i in range(_help_buttons.size()):
		var button := _help_buttons[i]
		if not is_instance_valid(button):
			continue
		var button_page: Dictionary = pages[i] if i < pages.size() else {}
		button.text = str(button_page.get("title", "HELP"))
		var selected := i == _help_selected_index
		if button is NeonMenuButton:
			button.accent = Color(1.0, 0.94, 0.18, 1.0) if selected else Color(0.0, 0.92, 1.0, 0.88)
			button.secondary = Color(1.0, 0.06, 0.86, 0.78)
			button.queue_redraw()
		button.add_theme_color_override("font_color", Color.TRANSPARENT)
		button.add_theme_color_override("font_focus_color", Color.TRANSPARENT)
	_update_help_cursor_position(true)


func _option_button_text(key: String) -> String:
	match key:
		"master_volume":
			return "MASTER VOLUME   %03d%%" % int(round(_master_volume * 100.0))
		"sfx_volume":
			return "SFX VOLUME      %03d%%" % int(round(_sfx_volume * 100.0))
		"music_volume":
			return "MUSIC VOLUME    %03d%%" % int(round(_music_volume * 100.0))
		"mute":
			return "MUTE            %s" % ("ON" if _audio_muted else "OFF")
		"screen_shake":
			return "SCREEN SHAKE    %s" % ("ON" if _screen_shake_enabled else "OFF")
		"vfx_intensity":
			return "VFX INTENSITY   %s" % VFX_INTENSITY_NAMES[clampi(_vfx_intensity, 0, VFX_INTENSITY_NAMES.size() - 1)]
		"fullscreen":
			return "FULLSCREEN      %s" % ("ON" if _fullscreen_enabled else "OFF")
		"back":
			return "BACK"
		_:
			return key.to_upper()


func _update_armory_ui() -> void:
	if not is_instance_valid(_armory_panel):
		return
	_armory_panel.visible = _armory_visible
	_update_title_modal_scrim()
	if not _armory_visible:
		if _armory_selection_cursor:
			_armory_selection_cursor.visible = false
		return
	_armory_equipped_selected_index = clampi(_armory_equipped_selected_index, 0, maxi(0, _equipped_weapon_instances.size() - 1))
	_armory_stash_selected_index = clampi(_armory_stash_selected_index, 0, maxi(0, _stash_weapon_instances.size() - 1))
	if _armory_dust_label:
		_armory_dust_label.text = "NEON DUST: %d" % _neon_dust
	if _armory_equipped_title_label:
		_armory_equipped_title_label.text = "EQUIPPED LOADOUT %d / %d" % [_equipped_weapon_instances.size(), EQUIPPED_WEAPON_SLOT_CAP]
		_armory_equipped_title_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18) if _armory_selected_section == "equipped" else Color(0.0, 0.96, 1.0))
	if _armory_stash_title_label:
		_armory_stash_title_label.text = "INVENTORY / STASH %d / %d" % [_stash_weapon_instances.size(), STASH_WEAPON_CAP]
		_armory_stash_title_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18) if _armory_selected_section == "stash" else Color(1.0, 0.08, 0.86))
	_update_armory_equipped_rows()
	_update_armory_stash_rows()
	var selected := _armory_selected_weapon_instance()
	if selected.is_empty() and not _equipped_weapon_instances.is_empty():
		selected = _equipped_weapon_instances[_armory_equipped_selected_index]
	_set_weapon_icon(_armory_preview_icon, selected, not selected.is_empty())
	if _armory_action_mode == "forge_confirm" and not _armory_forge_preview_instance.is_empty():
		_set_weapon_icon(_armory_compare_current_icon, selected, not selected.is_empty())
		_set_weapon_icon(_armory_compare_candidate_icon, _armory_forge_preview_instance, true)
	elif _armory_action_mode == "fusion_confirm" and not _armory_forge_preview_instance.is_empty():
		_set_weapon_icon(_armory_compare_current_icon, _armory_fusion_primary_instance, not _armory_fusion_primary_instance.is_empty())
		_set_weapon_icon(_armory_compare_candidate_icon, _armory_forge_preview_instance, true)
	elif _armory_action_mode == "fusion_materials":
		var material := _armory_fusion_selected_material()
		_set_weapon_icon(_armory_compare_current_icon, _armory_fusion_primary_instance, not _armory_fusion_primary_instance.is_empty())
		_set_weapon_icon(_armory_compare_candidate_icon, material, not material.is_empty())
	elif _armory_selected_section == "stash" and not selected.is_empty():
		var equipped_index := _armory_comparison_equipped_index(selected)
		var current := _equipped_weapon_instances[equipped_index] if equipped_index >= 0 else {}
		_set_weapon_icon(_armory_compare_current_icon, current, not current.is_empty())
		_set_weapon_icon(_armory_compare_candidate_icon, selected, true)
	else:
		_set_weapon_icon(_armory_compare_current_icon, selected, not selected.is_empty())
		_set_weapon_icon(_armory_compare_candidate_icon, "unknown_weapon", false)
	if _armory_detail_label:
		_armory_detail_label.text = _armory_weapon_detail_text(selected)
	if _armory_compare_label:
		_armory_compare_label.text = _armory_compare_text_for_selection()
	if _armory_status_label:
		_armory_status_label.text = _armory_status_text
	_update_armory_action_buttons()
	_update_armory_cursor_position(true)


func _update_armory_equipped_rows() -> void:
	for i in range(_armory_equipped_buttons.size()):
		var button := _armory_equipped_buttons[i]
		if not is_instance_valid(button):
			continue
		button.set_meta("armory_index", i)
		if i < _equipped_weapon_instances.size():
			var instance: Dictionary = _equipped_weapon_instances[i]
			button.visible = true
			button.disabled = false
			button.text = _armory_weapon_row_text(instance, i, true)
			if i < _armory_equipped_icons.size():
				_set_weapon_icon(_armory_equipped_icons[i], instance, true)
			_apply_armory_button_accent(button, instance, _armory_selected_section == "equipped" and i == _armory_equipped_selected_index)
		else:
			button.visible = true
			button.disabled = true
			button.text = "%02d EMPTY SLOT" % [i + 1]
			if i < _armory_equipped_icons.size():
				_set_weapon_icon(_armory_equipped_icons[i], "unknown_weapon", false)
			_apply_armory_button_accent(button, {}, false)


func _update_armory_stash_rows() -> void:
	for i in range(_armory_stash_buttons.size()):
		var button := _armory_stash_buttons[i]
		if not is_instance_valid(button):
			continue
		var stash_index := i
		button.set_meta("armory_index", stash_index)
		if _stash_weapon_instances.is_empty() and i == 0:
			button.visible = true
			button.disabled = true
			button.text = "NO STORED WEAPONS"
			if i < _armory_stash_icons.size():
				_set_weapon_icon(_armory_stash_icons[i], "unknown_weapon", false)
			_apply_armory_button_accent(button, {}, false)
		elif stash_index < _stash_weapon_instances.size():
			var instance: Dictionary = _stash_weapon_instances[stash_index]
			button.visible = true
			button.disabled = false
			button.text = _armory_weapon_row_text(instance, stash_index, false)
			if i < _armory_stash_icons.size():
				_set_weapon_icon(_armory_stash_icons[i], instance, true)
			_apply_armory_button_accent(button, instance, _armory_selected_section == "stash" and stash_index == _armory_stash_selected_index)
		else:
			button.visible = false
			button.disabled = true
			if i < _armory_stash_icons.size():
				_set_weapon_icon(_armory_stash_icons[i], "unknown_weapon", false)


func _update_armory_action_buttons() -> void:
	if not is_instance_valid(_armory_action_row):
		return
	var specs: Array[Dictionary] = []
	match _armory_action_mode:
		"equipped_actions":
			specs = [
				{"id": "forge", "text": "FORGE SELECTED\nSPEND NEON DUST", "color": Color(1.0, 0.94, 0.18, 0.95)},
				{"id": "cancel", "text": "CANCEL\nBACK TO LOADOUT", "color": Color(0.0, 0.96, 1.0, 0.92)}
			]
		"stash_actions":
			var scrap_amount := 0
			if not _stash_weapon_instances.is_empty():
				var selected_instance: Dictionary = _stash_weapon_instances[clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)]
				scrap_amount = _neon_dust_value_for_weapon(selected_instance)
			specs = [
				{"id": "equip", "text": "EQUIP / SWAP\nOLD EQUIPPED MOVES TO STASH", "color": Color(0.0, 0.96, 1.0, 0.92)},
				{"id": "forge", "text": "FORGE SELECTED\nSPEND NEON DUST", "color": Color(1.0, 0.94, 0.18, 0.95)},
				{"id": "scrap", "text": "SCRAP FOR\n+%d NEON DUST" % scrap_amount, "color": Color(1.0, 0.94, 0.18, 0.95)},
				{"id": "cancel", "text": "CANCEL\nBACK TO STASH", "color": Color(1.0, 0.08, 0.86, 0.86)}
			]
		"forge_actions":
			var selected := _armory_selected_weapon_instance()
			specs = [
				{"id": "forge_power", "text": "UPGRADE POWER\n%s" % _forge_action_summary("forge_power", selected), "color": Color(1.0, 0.94, 0.18, 0.95)},
				{"id": "reroll_stats", "text": "REROLL STATS\n%s" % _forge_action_summary("reroll_stats", selected), "color": Color(0.0, 0.96, 1.0, 0.92)},
				{"id": "reroll_modifier", "text": "REROLL MOD\n%s" % _forge_action_summary("reroll_modifier", selected), "color": Color(1.0, 0.08, 0.86, 0.90)},
				{"id": "evolve_fuse", "text": "EVOLVE / FUSE\n%s" % _forge_action_summary("evolve_fuse", selected), "color": Color(1.0, 0.58, 0.06, 0.95)},
				{"id": "forge_cancel", "text": "CANCEL\nBACK", "color": Color(0.75, 0.98, 1.0, 0.82)}
			]
		"forge_confirm":
			specs = [
				{"id": "confirm_forge", "text": "CONFIRM\n-%d NEON DUST" % _armory_forge_pending_cost, "color": Color(1.0, 0.94, 0.18, 0.95)},
				{"id": "cancel_forge_confirm", "text": "CANCEL\nKEEP CURRENT", "color": Color(0.0, 0.96, 1.0, 0.92)}
			]
		"fusion_materials":
			specs = [
				{"id": "confirm_fusion_material", "text": "USE MATERIAL\n%s" % _fusion_material_button_summary(), "color": Color(1.0, 0.58, 0.06, 0.95)},
				{"id": "cancel_fusion_material", "text": "CANCEL\nBACK TO FORGE", "color": Color(0.0, 0.96, 1.0, 0.92)}
			]
		"fusion_confirm":
			specs = [
				{"id": "confirm_fusion", "text": "CONFIRM FUSION\n-%d NEON DUST" % _armory_forge_pending_cost, "color": Color(1.0, 0.58, 0.06, 0.95)},
				{"id": "cancel_fusion_confirm", "text": "CANCEL\nKEEP BOTH", "color": Color(0.0, 0.96, 1.0, 0.92)}
			]
		"scrap_confirm":
			var confirm_amount := 0
			if not _stash_weapon_instances.is_empty():
				var confirm_instance: Dictionary = _stash_weapon_instances[clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)]
				confirm_amount = _neon_dust_value_for_weapon(confirm_instance)
			specs = [
				{"id": "confirm_scrap", "text": "CONFIRM SCRAP\n+%d NEON DUST" % confirm_amount, "color": Color(1.0, 0.94, 0.18, 0.95)},
				{"id": "cancel", "text": "CANCEL\nKEEP WEAPON", "color": Color(0.0, 0.96, 1.0, 0.92)}
			]
		_:
			specs = []
	_armory_action_row.visible = not specs.is_empty()
	if specs.is_empty():
		for button in _armory_action_buttons:
			if is_instance_valid(button):
				button.visible = false
		return
	_armory_action_selected_index = clampi(_armory_action_selected_index, 0, specs.size() - 1)
	for i in range(_armory_action_buttons.size()):
		var button := _armory_action_buttons[i]
		if not is_instance_valid(button):
			continue
		if i >= specs.size():
			button.visible = false
			button.disabled = true
			continue
		var spec: Dictionary = specs[i]
		button.visible = true
		button.disabled = false
		button.text = str(spec.get("text", "ACTION"))
		button.set_meta("armory_action", str(spec.get("id", "cancel")))
		var color: Color = spec.get("color", Color(0.0, 0.96, 1.0, 0.92))
		_apply_weapon_reward_button_accent(button, i == _armory_action_selected_index, color)


func _apply_armory_button_accent(button: Button, instance: Dictionary, selected: bool) -> void:
	var color := Color(0.0, 0.92, 1.0, 0.88)
	if not instance.is_empty():
		color = Color.html("#%s" % WeaponCatalog.rarity_accent_hex(str(instance.get("rarity", "Common"))))
		if _evolution_rank(instance) > 0 and not selected:
			color = color.lerp(Color(1.0, 0.58, 0.06, 1.0), 0.38)
	if selected:
		color = Color(1.0, 0.94, 0.18, 1.0)
	if button is NeonMenuButton:
		button.accent = color
		button.secondary = Color(1.0, 0.06, 0.86, 0.78)
		if instance.is_empty():
			button.set_meta("rarity_strip_color", Color.TRANSPARENT)
			button.set_meta("rarity_code", "")
		else:
			var rarity := str(instance.get("rarity", "Common"))
			var rarity_color := Color.html("#%s" % WeaponCatalog.rarity_accent_hex(rarity))
			if _evolution_rank(instance) > 0:
				rarity_color = rarity_color.lerp(Color(1.0, 0.58, 0.06, 1.0), 0.45)
			button.set_meta("rarity_strip_color", rarity_color)
			button.set_meta("rarity_code", _rarity_display_code(rarity))
		button.queue_redraw()


func _armory_weapon_row_text(instance: Dictionary, index: int, equipped: bool) -> String:
	var rarity := str(instance.get("rarity", "Common"))
	var rarity_code := _rarity_display_code(rarity)
	var power := float(instance.get("power_score", WeaponCatalog.estimate_power(instance)))
	var prefix := "E" if equipped else "S"
	var forge_rank := clampi(int(instance.get("forge_power_rank", 0)), 0, FORGE_POWER_MAX_RANK)
	var forge_label := " F%d" % forge_rank if forge_rank > 0 else ""
	var evolution_label := " EV%d" % _evolution_rank(instance) if _evolution_rank(instance) > 0 else ""
	return "%s%02d  %s  %s%s%s  PWR %.2f" % [prefix, index + 1, _compact_weapon_name(instance, 12 if equipped else 14), rarity_code, forge_label, evolution_label, power]


func _armory_stash_window_start() -> int:
	if _stash_weapon_instances.is_empty():
		return 0
	var row_count := maxi(1, _armory_stash_buttons.size())
	var max_start := maxi(0, _stash_weapon_instances.size() - row_count)
	var start := _armory_stash_selected_index - row_count / 2
	return clampi(start, 0, max_start)


func _armory_equipped_button_for_index(index: int) -> Button:
	if index >= 0 and index < _armory_equipped_buttons.size():
		return _armory_equipped_buttons[index]
	return null


func _armory_stash_button_for_index(stash_index: int) -> Button:
	for button in _armory_stash_buttons:
		if is_instance_valid(button) and button.visible and int(button.get_meta("armory_index", -1)) == stash_index:
			return button
	return null


func _armory_selected_weapon_instance() -> Dictionary:
	if _armory_selected_section == "stash":
		if _armory_stash_selected_index >= 0 and _armory_stash_selected_index < _stash_weapon_instances.size():
			return _stash_weapon_instances[_armory_stash_selected_index]
		return {}
	if _armory_equipped_selected_index >= 0 and _armory_equipped_selected_index < _equipped_weapon_instances.size():
		return _equipped_weapon_instances[_armory_equipped_selected_index]
	return {}


func _set_armory_selected_weapon_instance(instance: Dictionary) -> void:
	if instance.is_empty():
		return
	instance["power_score"] = WeaponCatalog.estimate_power(instance)
	if _armory_selected_section == "stash":
		if _armory_stash_selected_index >= 0 and _armory_stash_selected_index < _stash_weapon_instances.size():
			instance["equipped"] = false
			_stash_weapon_instances[_armory_stash_selected_index] = instance
	else:
		if _armory_equipped_selected_index >= 0 and _armory_equipped_selected_index < _equipped_weapon_instances.size():
			instance["equipped"] = true
			_equipped_weapon_instances[_armory_equipped_selected_index] = instance
	_remember_discovered_weapon(instance)


func _clear_armory_forge_pending() -> void:
	_armory_forge_pending_action = ""
	_armory_forge_pending_cost = 0
	_armory_forge_preview_instance.clear()
	_armory_fusion_primary_section = ""
	_armory_fusion_primary_index = -1
	_armory_fusion_primary_instance.clear()
	_armory_fusion_material_index = -1
	_armory_fusion_material_instance.clear()


func _evolution_rank(instance: Dictionary) -> int:
	return clampi(int(instance.get("evolution_rank", 0)), 0, EVOLUTION_MAX_RANK)


func _evolution_label(instance: Dictionary) -> String:
	var rank := _evolution_rank(instance)
	if rank <= 0:
		return "NONE"
	var roman := ["", "I", "II", "III"]
	return "EVOLVED %s" % roman[clampi(rank, 0, roman.size() - 1)]


func _evolution_stats_for_rank(rank: int) -> Dictionary:
	var stats := {}
	var safe_rank := clampi(rank, 0, EVOLUTION_MAX_RANK)
	for stat_id in EVOLUTION_STAT_STEP.keys():
		stats[str(stat_id)] = snappedf(float(EVOLUTION_STAT_STEP[stat_id]) * float(safe_rank), 0.001)
	return stats


func _fusion_compatibility_groups() -> Dictionary:
	return {
		"Projectile": ["pulse_blaster", "tri_burst_cannon", "nova_needle", "vector_spear", "shield_breaker"],
		"Orbit": ["orbit_spark", "ring_saw", "orbital_saw_array"],
		"Area / Field": ["nova_burst", "gravity_mine", "gravity_well", "star_pulse"],
		"Chain / Beam": ["arc_beam", "prism_chain", "prism_lance"],
		"Shard / Split": ["fractal_shard", "fractal_bloom", "hex_mortar", "hex_shatter"]
	}


func _fusion_group_for_definition(definition_id: String) -> String:
	var groups := _fusion_compatibility_groups()
	for group_name in groups.keys():
		var ids: Array = groups[group_name]
		if ids.has(definition_id):
			return str(group_name)
	return "Unclassified"


func _weapons_are_fusion_compatible(primary: Dictionary, material: Dictionary) -> bool:
	if primary.is_empty() or material.is_empty():
		return false
	var primary_id := str(primary.get("definition_id", ""))
	var material_id := str(material.get("definition_id", ""))
	if primary_id == "" or material_id == "":
		return false
	if primary_id == material_id:
		return true
	var primary_group := _fusion_group_for_definition(primary_id)
	var material_group := _fusion_group_for_definition(material_id)
	return primary_group != "Unclassified" and primary_group == material_group


func _fusion_compatibility_text(primary: Dictionary, material: Dictionary) -> String:
	if primary.is_empty() or material.is_empty():
		return "NO MATERIAL"
	if str(primary.get("definition_id", "")) == str(material.get("definition_id", "")):
		return "SAME FAMILY"
	if _weapons_are_fusion_compatible(primary, material):
		return "%s GROUP" % _fusion_group_for_definition(str(primary.get("definition_id", ""))).to_upper()
	return "INCOMPATIBLE"


func _fusion_primary_or_selected_weapon() -> Dictionary:
	if not _armory_fusion_primary_instance.is_empty():
		return _armory_fusion_primary_instance
	return _armory_selected_weapon_instance()


func _capture_fusion_primary(primary: Dictionary) -> void:
	_armory_fusion_primary_section = _armory_selected_section
	_armory_fusion_primary_index = _armory_stash_selected_index if _armory_selected_section == "stash" else _armory_equipped_selected_index
	_armory_fusion_primary_instance = Dictionary(primary).duplicate(true)


func _restore_fusion_primary_selection() -> void:
	if _armory_fusion_primary_section == "":
		return
	_armory_selected_section = _armory_fusion_primary_section
	if _armory_selected_section == "stash":
		_armory_stash_selected_index = clampi(_armory_fusion_primary_index, 0, maxi(0, _stash_weapon_instances.size() - 1))
	else:
		_armory_equipped_selected_index = clampi(_armory_fusion_primary_index, 0, maxi(0, _equipped_weapon_instances.size() - 1))


func _armory_fusion_selected_material() -> Dictionary:
	if _armory_fusion_material_index >= 0 and _armory_fusion_material_index < _stash_weapon_instances.size():
		return _stash_weapon_instances[_armory_fusion_material_index]
	if _armory_stash_selected_index >= 0 and _armory_stash_selected_index < _stash_weapon_instances.size():
		return _stash_weapon_instances[_armory_stash_selected_index]
	return {}


func _best_fusion_material_index(primary: Dictionary) -> int:
	if _stash_weapon_instances.is_empty():
		return -1
	var start := clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)
	for offset in range(_stash_weapon_instances.size()):
		var index := (start + offset) % _stash_weapon_instances.size()
		if _is_valid_fusion_material_index(primary, index):
			return index
	return -1


func _next_fusion_material_index(start_index: int, direction: int) -> int:
	if _stash_weapon_instances.is_empty() or _armory_fusion_primary_instance.is_empty():
		return -1
	var step := 1 if direction >= 0 else -1
	var index := clampi(start_index + step, 0, _stash_weapon_instances.size() - 1)
	while index >= 0 and index < _stash_weapon_instances.size():
		if _is_valid_fusion_material_index(_armory_fusion_primary_instance, index):
			return index
		index += step
	return clampi(start_index, 0, _stash_weapon_instances.size() - 1)


func _is_valid_fusion_material_index(primary: Dictionary, index: int) -> bool:
	if index < 0 or index >= _stash_weapon_instances.size():
		return false
	if _armory_fusion_primary_section == "stash" and index == _armory_fusion_primary_index:
		return false
	var material: Dictionary = _stash_weapon_instances[index]
	if str(primary.get("instance_id", "")) != "" and str(primary.get("instance_id", "")) == str(material.get("instance_id", "")):
		return false
	return _weapons_are_fusion_compatible(primary, material)


func _fusion_action_cost(primary: Dictionary, material: Dictionary) -> int:
	if primary.is_empty() or material.is_empty():
		return -1
	var rank := _evolution_rank(primary)
	if rank >= EVOLUTION_MAX_RANK:
		return -1
	if not _weapons_are_fusion_compatible(primary, material):
		return -1
	var rarity_multiplier := _forge_rarity_cost_multiplier(primary)
	var material_bonus := 0.85 if str(primary.get("definition_id", "")) == str(material.get("definition_id", "")) else 1.0
	return maxi(1, int(round(float(EVOLUTION_BASE_COST + EVOLUTION_COST_STEP * rank) * rarity_multiplier * material_bonus)))


func _fusion_preview_instance(primary: Dictionary, material: Dictionary, cost: int) -> Dictionary:
	if _fusion_action_cost(primary, material) < 0:
		return {}
	var preview := Dictionary(primary).duplicate(true)
	var next_rank := clampi(_evolution_rank(preview) + 1, 0, EVOLUTION_MAX_RANK)
	preview["evolution_rank"] = next_rank
	preview["evolution_stats"] = _evolution_stats_for_rank(next_rank)
	preview["fusion_dust_spent"] = int(preview.get("fusion_dust_spent", 0)) + maxi(0, cost)
	var history: Array = Array(preview.get("fusion_history", [])).duplicate(true)
	history.append({
		"material_instance_id": str(material.get("instance_id", "")),
		"material_definition_id": str(material.get("definition_id", "")),
		"material_rarity": str(material.get("rarity", "Common")),
		"compatibility": _fusion_compatibility_text(primary, material),
		"rank_after": next_rank,
		"cost": cost
	})
	while history.size() > 8:
		history.pop_front()
	preview["fusion_history"] = history
	preview["source"] = "evolve_fuse"
	preview["power_score"] = WeaponCatalog.estimate_power(preview)
	return preview


func _fusion_material_button_summary() -> String:
	var material := _armory_fusion_selected_material()
	if material.is_empty():
		return "NO MATERIAL"
	var cost := _fusion_action_cost(_armory_fusion_primary_instance, material)
	if cost < 0:
		return "INCOMPATIBLE"
	return "%d DUST // %s" % [cost, _fusion_compatibility_text(_armory_fusion_primary_instance, material).to_upper()]


func _forge_rarity_cost_multiplier(instance: Dictionary) -> float:
	var rarity := str(instance.get("rarity", "Common"))
	return float(FORGE_RARITY_COST_MULTIPLIERS.get(rarity, 1.0))


func _forge_action_title(action: String) -> String:
	match action:
		"forge_power":
			return "UPGRADE POWER"
		"reroll_stats":
			return "REROLL STATS"
		"reroll_modifier":
			return "REROLL MODIFIER"
		"evolve_fuse":
			return "EVOLVE / FUSE"
		_:
			return "FORGE ACTION"


func _forge_action_cost(action: String, instance: Dictionary) -> int:
	if instance.is_empty():
		return -1
	var multiplier := _forge_rarity_cost_multiplier(instance)
	match action:
		"forge_power":
			var rank := clampi(int(instance.get("forge_power_rank", 0)), 0, FORGE_POWER_MAX_RANK)
			if rank >= FORGE_POWER_MAX_RANK:
				return -1
			return maxi(1, int(round(float(FORGE_POWER_BASE_COST + FORGE_POWER_COST_STEP * rank) * multiplier)))
		"reroll_stats":
			return maxi(1, int(round(float(FORGE_STAT_REROLL_BASE_COST) * multiplier)))
		"reroll_modifier":
			if not _forge_modifier_reroll_supported(instance):
				return -1
			return maxi(1, int(round(float(FORGE_MODIFIER_REROLL_BASE_COST) * multiplier)))
		"evolve_fuse":
			if _evolution_rank(instance) >= EVOLUTION_MAX_RANK:
				return -1
			var material_index := _best_fusion_material_index(instance)
			if material_index < 0:
				return -1
			return _fusion_action_cost(instance, _stash_weapon_instances[material_index])
		_:
			return -1


func _forge_power_stats_for_rank(rank: int) -> Dictionary:
	var stats := {}
	var safe_rank := clampi(rank, 0, FORGE_POWER_MAX_RANK)
	for stat_id in FORGE_POWER_STAT_STEP.keys():
		stats[str(stat_id)] = snappedf(float(FORGE_POWER_STAT_STEP[stat_id]) * float(safe_rank), 0.001)
	return stats


func _forge_seed_for_action(action: String, instance: Dictionary) -> int:
	var base_seed := int(instance.get("seed", 0))
	var dust_spent := int(instance.get("forge_dust_spent", 0))
	var id_hash := str(instance.get("instance_id", "")).hash()
	return int(abs(id_hash + base_seed + dust_spent * 131 + int(Time.get_ticks_msec()) + action.hash()))


func _forge_preview_instance(action: String, instance: Dictionary) -> Dictionary:
	var preview := Dictionary(instance).duplicate(true)
	match action:
		"forge_power":
			var next_rank := clampi(int(preview.get("forge_power_rank", 0)) + 1, 0, FORGE_POWER_MAX_RANK)
			if next_rank <= int(preview.get("forge_power_rank", 0)):
				return {}
			preview["forge_power_rank"] = next_rank
			preview["forge_power_stats"] = _forge_power_stats_for_rank(next_rank)
			preview["source"] = "forge_power"
		"reroll_stats":
			var generated := WeaponCatalog.generate_weapon_instance(
				str(preview.get("definition_id", "pulse_blaster")),
				str(preview.get("rarity", "Common")),
				_forge_seed_for_action(action, preview),
				str(preview.get("instance_id", "")),
				"forge_stat_reroll"
			)
			preview["seed"] = int(generated.get("seed", preview.get("seed", 0)))
			preview["stat_rolls"] = Array(generated.get("stat_rolls", [])).duplicate(true)
			preview["source"] = "forge_stat_reroll"
		"reroll_modifier":
			if not _forge_modifier_reroll_supported(preview):
				return {}
			preview["modifier_rolls"] = _forge_reroll_modifiers(preview, _forge_seed_for_action(action, preview))
			preview["source"] = "forge_modifier_reroll"
		_:
			return {}
	preview["power_score"] = WeaponCatalog.estimate_power(preview)
	return preview


func _forge_modifier_reroll_supported(instance: Dictionary) -> bool:
	var rarity := str(instance.get("rarity", "Common"))
	var tiers := WeaponCatalog.rarity_tiers()
	var rarity_data: Dictionary = tiers.get(rarity, tiers["Common"])
	if int(rarity_data.get("modifier_max", 0)) <= 0:
		return false
	var definition := WeaponCatalog.weapon_definition(str(instance.get("definition_id", "")))
	var modifier_pool: Array = definition.get("modifier_pool", [])
	return modifier_pool.size() > 0


func _forge_reroll_modifiers(instance: Dictionary, seed: int) -> Array:
	var definition := WeaponCatalog.weapon_definition(str(instance.get("definition_id", "")))
	var modifier_pool: Array = Array(definition.get("modifier_pool", [])).duplicate(true)
	if modifier_pool.is_empty():
		return []
	var rarity := str(instance.get("rarity", "Common"))
	var tiers := WeaponCatalog.rarity_tiers()
	var rarity_data: Dictionary = tiers.get(rarity, tiers["Common"])
	var modifier_min := int(rarity_data.get("modifier_min", 0))
	var modifier_max := int(rarity_data.get("modifier_max", 1))
	var current_modifiers: Array = instance.get("modifier_rolls", [])
	var modifier_count := current_modifiers.size()
	if modifier_count <= 0:
		modifier_count = maxi(1, modifier_min)
	modifier_count = clampi(modifier_count, 1, mini(3, modifier_max))
	var rng := RandomNumberGenerator.new()
	rng.seed = seed
	var results: Array = []
	while results.size() < modifier_count and not modifier_pool.is_empty():
		var index := rng.randi_range(0, modifier_pool.size() - 1)
		var modifier: Dictionary = modifier_pool[index]
		modifier_pool.remove_at(index)
		results.append(modifier.duplicate(true))
	return results


func _forge_action_summary(action: String, instance: Dictionary) -> String:
	var cost := _forge_action_cost(action, instance)
	if cost < 0:
		if action == "forge_power":
			return "MAX RANK"
		if action == "evolve_fuse":
			if _evolution_rank(instance) >= EVOLUTION_MAX_RANK:
				return "EVOLVED III"
			return "NEED MATERIAL"
		return "LOCKED"
	var state := "READY" if _neon_dust >= cost else "NEED %d" % [cost - _neon_dust]
	return "%d DUST // %s" % [cost, state]


func _apply_pending_forge_action() -> void:
	if _armory_forge_pending_action == "" or _armory_forge_preview_instance.is_empty():
		_open_armory_forge_actions("NO FORGE ACTION PENDING")
		return
	var cost := _armory_forge_pending_cost
	if cost <= 0 or _neon_dust < cost:
		_open_armory_forge_actions("FORGE BLOCKED // NOT ENOUGH NEON DUST")
		_play_sfx("ui_back", 0.08)
		return
	if _armory_forge_pending_action == "evolve_fuse":
		_apply_pending_fusion_action(cost)
		return
	var forged := Dictionary(_armory_forge_preview_instance).duplicate(true)
	forged["forge_dust_spent"] = int(forged.get("forge_dust_spent", 0)) + cost
	forged["power_score"] = WeaponCatalog.estimate_power(forged)
	_neon_dust = maxi(0, _neon_dust - cost)
	_set_armory_selected_weapon_instance(forged)
	_rebuild_weapon_stat_bonuses()
	_save_weapon_inventory()
	_update_orbit_visual_visibility()
	var action_name := _forge_action_title(_armory_forge_pending_action)
	_armory_action_mode = "browse"
	_clear_armory_forge_pending()
	_armory_status_text = "%s COMPLETE // %s // -%d NEON DUST // REMAINING %d" % [action_name, _weapon_progression_summary(forged), cost, _neon_dust]
	_update_armory_ui()
	_focus_armory_choice()
	_update_hud()
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(Color(1.0, 0.94, 0.18), 0.08, 0.18)


func _apply_pending_fusion_action(cost: int) -> void:
	if _armory_fusion_primary_instance.is_empty() or _armory_fusion_material_index < 0 or _armory_fusion_material_index >= _stash_weapon_instances.size():
		_open_armory_forge_actions("FUSION BLOCKED // MISSING MATERIAL")
		_play_sfx("ui_back", 0.08)
		return
	var material := Dictionary(_stash_weapon_instances[_armory_fusion_material_index]).duplicate(true)
	if not _is_valid_fusion_material_index(_armory_fusion_primary_instance, _armory_fusion_material_index):
		_open_armory_forge_actions("FUSION BLOCKED // MATERIAL INCOMPATIBLE")
		_play_sfx("ui_back", 0.08)
		return
	var forged := Dictionary(_armory_forge_preview_instance).duplicate(true)
	forged["equipped"] = _armory_fusion_primary_section == "equipped"
	forged["power_score"] = WeaponCatalog.estimate_power(forged)
	_neon_dust = maxi(0, _neon_dust - cost)
	var primary_section := _armory_fusion_primary_section
	var primary_index := _armory_fusion_primary_index
	var material_index := _armory_fusion_material_index
	if primary_section == "equipped":
		primary_index = clampi(primary_index, 0, _equipped_weapon_instances.size() - 1)
		forged["equipped"] = true
		_equipped_weapon_instances[primary_index] = forged
		_stash_weapon_instances.remove_at(material_index)
		_armory_selected_section = "equipped"
		_armory_equipped_selected_index = primary_index
	else:
		primary_index = clampi(primary_index, 0, _stash_weapon_instances.size() - 1)
		forged["equipped"] = false
		_stash_weapon_instances[primary_index] = forged
		_stash_weapon_instances.remove_at(material_index)
		if material_index < primary_index:
			primary_index -= 1
		_armory_selected_section = "stash"
		_armory_stash_selected_index = clampi(primary_index, 0, maxi(0, _stash_weapon_instances.size() - 1))
	_remember_discovered_weapon(forged)
	_rebuild_weapon_stat_bonuses()
	_save_weapon_inventory()
	_update_orbit_visual_visibility()
	var rank := _evolution_rank(forged)
	var material_name := str(material.get("name", "WEAPON")).to_upper()
	_armory_action_mode = "browse"
	_clear_armory_forge_pending()
	_armory_status_text = "EVOLVE / FUSE COMPLETE // %s // %s CONSUMED // EVOLVED %d / %d // -%d NEON DUST // REMAINING %d" % [_weapon_progression_summary(forged), material_name, rank, EVOLUTION_MAX_RANK, cost, _neon_dust]
	_update_armory_ui()
	_focus_armory_choice()
	_update_hud()
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(Color(1.0, 0.58, 0.06), 0.08, 0.18)


func _armory_weapon_detail_text(instance: Dictionary) -> String:
	if instance.is_empty():
		return "NO WEAPON SELECTED\n\nNO STORED WEAPONS\nClear sectors to generate weapon rewards."
	var definition_id := str(instance.get("definition_id", ""))
	var definition := WeaponCatalog.weapon_definition(definition_id)
	var lines: Array[String] = []
	lines.append("%s // %s" % [str(instance.get("rarity", "Common")).to_upper(), str(instance.get("family", instance.get("name", "Weapon"))).to_upper()])
	lines.append("TYPE: %s" % str(instance.get("archetype", definition.get("archetype", "Weapon"))).to_upper())
	lines.append("SHAPE: %s" % str(definition.get("shape", "Weapon geometry")).to_upper())
	lines.append("POWER: %.2f" % float(instance.get("power_score", WeaponCatalog.estimate_power(instance))))
	var forge_rank := clampi(int(instance.get("forge_power_rank", 0)), 0, FORGE_POWER_MAX_RANK)
	lines.append("FORGE POWER: RANK %d / %d" % [forge_rank, FORGE_POWER_MAX_RANK])
	lines.append("EVOLUTION: %s  RANK %d / %d" % [_evolution_label(instance), _evolution_rank(instance), EVOLUTION_MAX_RANK])
	lines.append("FUSION GROUP: %s" % _fusion_group_for_definition(definition_id).to_upper())
	lines.append("MOD: %s" % WeaponCatalog.primary_modifier_text(instance).to_upper())
	var rolls: Array = instance.get("stat_rolls", [])
	if rolls.is_empty():
		lines.append("STATS: BASELINE CALIBRATION")
	else:
		lines.append("STATS:")
		for i in range(mini(5, rolls.size())):
			var roll: Dictionary = rolls[i]
			lines.append("  %s %s" % [str(roll.get("label", "Stat")).to_upper(), WeaponCatalog.format_stat(roll)])
	var modifiers: Array = instance.get("modifier_rolls", [])
	if not modifiers.is_empty():
		lines.append("SPECIAL:")
		for modifier in modifiers:
			lines.append("  %s" % str(Dictionary(modifier).get("name", "Modifier")).to_upper())
	var forge_stats: Dictionary = instance.get("forge_power_stats", {})
	if not forge_stats.is_empty():
		lines.append("FORGE BONUSES:")
		for stat_id in forge_stats.keys():
			lines.append("  %s %s" % [_weapon_stat_display_label(str(stat_id)), _format_armory_stat_delta(str(stat_id), float(forge_stats[stat_id]))])
	var evolution_stats: Dictionary = instance.get("evolution_stats", {})
	if not evolution_stats.is_empty():
		lines.append("EVOLUTION BONUSES:")
		for stat_id in evolution_stats.keys():
			lines.append("  %s %s" % [_weapon_stat_display_label(str(stat_id)), _format_armory_stat_delta(str(stat_id), float(evolution_stats[stat_id]))])
	var dust_spent := int(instance.get("forge_dust_spent", 0))
	var fusion_spent := int(instance.get("fusion_dust_spent", 0))
	if dust_spent + fusion_spent > 0:
		lines.append("NEON DUST INVESTED: %d" % (dust_spent + fusion_spent))
	var fusion_history: Array = instance.get("fusion_history", [])
	if not fusion_history.is_empty():
		var latest: Dictionary = fusion_history[fusion_history.size() - 1]
		lines.append("LAST FUSION: %s // RANK %d" % [str(latest.get("material_definition_id", "material")).to_upper(), int(latest.get("rank_after", _evolution_rank(instance)))])
	return "\n".join(lines)


func _armory_compare_text_for_selection() -> String:
	if _armory_action_mode in ["forge_actions", "forge_confirm", "fusion_materials", "fusion_confirm"]:
		return _armory_forge_compare_text(_fusion_primary_or_selected_weapon())
	if _armory_selected_section != "stash":
		var current := _armory_selected_weapon_instance()
		if current.is_empty():
			return "SELECT A STASHED WEAPON TO COMPARE."
		return "CURRENTLY EQUIPPED\n%s\n\nSwitch to STASH to compare stored weapons." % _armory_weapon_brief(current)
	if _stash_weapon_instances.is_empty():
		return "NO STORED WEAPONS\nClear sectors to generate weapon rewards."
	var candidate: Dictionary = _armory_selected_weapon_instance()
	var equipped_index := _armory_comparison_equipped_index(candidate)
	var current := _equipped_weapon_instances[equipped_index] if equipped_index >= 0 else {}
	return _armory_comparison_text(candidate, current, equipped_index)


func _armory_forge_compare_text(instance: Dictionary) -> String:
	if instance.is_empty():
		return "NO WEAPON SELECTED FOR FORGE."
	var lines: Array[String] = []
	lines.append("WEAPON FORGE")
	lines.append("CURRENT: %s" % _armory_weapon_brief(instance))
	lines.append("NEON DUST: %d" % _neon_dust)
	lines.append("")
	if _armory_action_mode == "forge_confirm" and not _armory_forge_preview_instance.is_empty():
		var preview := _armory_forge_preview_instance
		lines.append("ACTION: %s" % _forge_action_title(_armory_forge_pending_action))
		lines.append("COST: %d NEON DUST" % _armory_forge_pending_cost)
		lines.append("PREVIEW: %s" % _armory_weapon_brief(preview))
		var comparison: Dictionary = WeaponCatalog.comparison_data(preview, instance)
		var power_delta := float(comparison.get("power_delta", 0.0))
		lines.append("POWER %s %+.2f" % [_armory_arrow(power_delta), power_delta])
		var deltas: Dictionary = comparison.get("stat_deltas", {})
		var shown := 0
		for stat_id in ["damage_bonus", "fire_rate_bonus", "cooldown_reduction", "range_bonus", "lifetime_bonus", "projectile_speed_bonus", "projectile_count_bonus", "pierce_bonus", "split_count_bonus", "chain_count_bonus", "orbit_count_bonus"]:
			if not deltas.has(stat_id):
				continue
			var delta := float(deltas[stat_id])
			if absf(delta) < 0.0005:
				continue
			lines.append("%s %s %s" % [_weapon_stat_display_label(stat_id), _armory_arrow(delta), _format_armory_stat_delta(stat_id, delta)])
			shown += 1
			if shown >= 7:
				break
		if shown == 0:
			lines.append("STAT DELTAS: EVEN")
		lines.append("")
		lines.append("CONFIRM SPENDS NEON DUST AND SAVES THIS WEAPON.")
		lines.append("CANCEL KEEPS CURRENT ROLLS.")
	elif _armory_action_mode == "fusion_materials":
		var material := _armory_fusion_selected_material()
		lines.append("EVOLVE / FUSE MATERIAL SELECT")
		lines.append("PRIMARY: %s" % _armory_weapon_brief(_armory_fusion_primary_instance))
		if material.is_empty():
			lines.append("NO MATERIAL SELECTED.")
		else:
			var compatible := _weapons_are_fusion_compatible(_armory_fusion_primary_instance, material)
			lines.append("MATERIAL: %s" % _armory_weapon_brief(material))
			lines.append("COMPATIBILITY: %s" % _fusion_compatibility_text(_armory_fusion_primary_instance, material).to_upper())
			var fusion_cost := _fusion_action_cost(_armory_fusion_primary_instance, material)
			lines.append("COST: %s" % ("%d NEON DUST" % fusion_cost if fusion_cost >= 0 else "LOCKED"))
			lines.append("RESULT: %s -> EVOLVED %d / %d" % [
				str(_armory_fusion_primary_instance.get("name", "WEAPON")).to_upper(),
				mini(EVOLUTION_MAX_RANK, _evolution_rank(_armory_fusion_primary_instance) + (1 if compatible else 0)),
				EVOLUTION_MAX_RANK
			])
			lines.append("")
			lines.append("Fusion consumes the material weapon after final confirmation.")
		lines.append("D-PAD / LEFT STICK: SELECT MATERIAL")
		lines.append("RIGHT STICK: SCROLL MATERIAL LIST")
		lines.append("A / ENTER: PREVIEW FUSION")
		lines.append("B / ESC: BACK")
	elif _armory_action_mode == "fusion_confirm" and not _armory_forge_preview_instance.is_empty():
		var preview := _armory_forge_preview_instance
		var material := _armory_fusion_material_instance
		lines.append("CONFIRM EVOLVE / FUSE")
		lines.append("PRIMARY: %s" % _armory_weapon_brief(_armory_fusion_primary_instance))
		lines.append("MATERIAL CONSUMED: %s" % _armory_weapon_brief(material))
		lines.append("COMPATIBILITY: %s" % _fusion_compatibility_text(_armory_fusion_primary_instance, material).to_upper())
		lines.append("COST: %d NEON DUST" % _armory_forge_pending_cost)
		lines.append("AFTER: %s" % _armory_weapon_brief(preview))
		var comparison: Dictionary = WeaponCatalog.comparison_data(preview, _armory_fusion_primary_instance)
		var power_delta := float(comparison.get("power_delta", 0.0))
		lines.append("POWER %s %+.2f" % [_armory_arrow(power_delta), power_delta])
		var deltas: Dictionary = comparison.get("stat_deltas", {})
		for stat_id in ["damage_bonus", "cooldown_reduction", "range_bonus", "lifetime_bonus"]:
			if deltas.has(stat_id):
				var delta := float(deltas[stat_id])
				if absf(delta) >= 0.0005:
					lines.append("%s %s %s" % [_weapon_stat_display_label(stat_id), _armory_arrow(delta), _format_armory_stat_delta(stat_id, delta)])
		lines.append("")
		lines.append("WARNING: Fusion consumes the material weapon from stash.")
		lines.append("A / ENTER: CONFIRM")
		lines.append("B / ESC: CANCEL")
	else:
		lines.append("AVAILABLE ACTIONS:")
		lines.append("UPGRADE POWER: %s" % _forge_action_summary("forge_power", instance))
		lines.append("REROLL STATS: %s" % _forge_action_summary("reroll_stats", instance))
		lines.append("REROLL MODIFIER: %s" % _forge_action_summary("reroll_modifier", instance))
		lines.append("EVOLVE / FUSE: %s" % _forge_action_summary("evolve_fuse", instance))
		lines.append("")
		lines.append("A / ENTER: CHOOSE ACTION")
		lines.append("B / ESC: BACK")
	return "\n".join(lines)


func _armory_comparison_equipped_index(candidate: Dictionary) -> int:
	if candidate.is_empty() or _equipped_weapon_instances.is_empty():
		return -1
	return clampi(_armory_equipped_selected_index, 0, _equipped_weapon_instances.size() - 1)


func _armory_comparison_text(candidate: Dictionary, current: Dictionary, equipped_index: int) -> String:
	if candidate.is_empty():
		return "NO STORED WEAPON SELECTED."
	var lines: Array[String] = []
	if current.is_empty():
		lines.append("NO EQUIPPED COMPARISON SLOT")
	else:
		lines.append("CURRENT E%02d: %s" % [equipped_index + 1, _armory_weapon_brief(current)])
	lines.append("STASHED: %s" % _armory_weapon_brief(candidate))
	if not current.is_empty():
		var comparison: Dictionary = WeaponCatalog.comparison_data(candidate, current)
		var power_delta := float(comparison.get("power_delta", 0.0))
		lines.append("POWER %s %+.2f" % [_armory_arrow(power_delta), power_delta])
		var deltas: Dictionary = comparison.get("stat_deltas", {})
		var shown := 0
		for stat_id in ["damage_bonus", "fire_rate_bonus", "cooldown_reduction", "range_bonus", "lifetime_bonus", "projectile_speed_bonus", "projectile_count_bonus", "pierce_bonus", "split_count_bonus", "chain_count_bonus", "orbit_count_bonus"]:
			if not deltas.has(stat_id):
				continue
			var delta := float(deltas[stat_id])
			if absf(delta) < 0.0005:
				continue
			lines.append("%s %s %s" % [_weapon_stat_display_label(stat_id), _armory_arrow(delta), _format_armory_stat_delta(stat_id, delta)])
			shown += 1
			if shown >= 5:
				break
		if shown == 0:
			lines.append("ROLL DELTAS: EVEN")
	var target_index := _armory_comparison_equipped_index(candidate)
	var matching := _equipped_weapon_index_for_definition(str(candidate.get("definition_id", "")))
	if target_index >= 0:
		lines.append("")
		lines.append("A: EQUIP INTO E%02d" % [target_index + 1])
		lines.append("Current slot weapon moves to stash.")
		if matching >= 0 and matching != target_index:
			lines.append("Duplicate family stats stack safely.")
	elif _equipped_weapon_instances.size() < EQUIPPED_WEAPON_SLOT_CAP:
		lines.append("")
		lines.append("A: EQUIP INTO EMPTY SLOT")
	else:
		lines.append("")
		lines.append("NO EQUIPPED SLOT AVAILABLE")
	return "\n".join(lines)


func _armory_weapon_brief(instance: Dictionary) -> String:
	if instance.is_empty():
		return "NONE"
	var evolution := " %s" % _evolution_label(instance) if _evolution_rank(instance) > 0 else ""
	return "%s %s%s PWR %.2f" % [
		str(instance.get("rarity", "Common")).to_upper(),
		str(instance.get("name", "WEAPON")).to_upper(),
		evolution,
		float(instance.get("power_score", WeaponCatalog.estimate_power(instance)))
	]


func _armory_arrow(value: float) -> String:
	if value > 0.0005:
		return "↑"
	if value < -0.0005:
		return "↓"
	return "="


func _format_armory_stat_delta(stat_id: String, value: float) -> String:
	if stat_id in ["projectile_count_bonus", "pierce_bonus", "split_count_bonus", "chain_count_bonus", "orbit_count_bonus"]:
		return "%+d" % int(round(value))
	return "%+d%%" % int(round(value * 100.0))


func _weapon_stat_display_label(stat_id: String) -> String:
	match stat_id:
		"damage_bonus":
			return "DAMAGE"
		"fire_rate_bonus":
			return "RATE"
		"cooldown_reduction":
			return "COOLDOWN"
		"projectile_speed_bonus":
			return "SHOT SPD"
		"lifetime_bonus":
			return "LIFETIME"
		"range_bonus":
			return "RANGE"
		"projectile_count_bonus":
			return "PROJECTILES"
		"pierce_bonus":
			return "PIERCE"
		"split_count_bonus":
			return "SPLIT"
		"chain_count_bonus":
			return "CHAIN"
		"orbit_count_bonus":
			return "ORBIT"
		"pickup_bonus":
			return "PICKUP"
		_:
			return stat_id.to_upper()


func _equip_selected_stash_weapon() -> void:
	if _stash_weapon_instances.is_empty():
		_armory_status_text = "NO STORED WEAPONS // CLEAR SECTORS TO GENERATE WEAPON REWARDS"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	_armory_stash_selected_index = clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)
	var candidate: Dictionary = Dictionary(_stash_weapon_instances[_armory_stash_selected_index]).duplicate(true)
	if not WeaponCatalog.has_definition(str(candidate.get("definition_id", ""))):
		_armory_status_text = "INVALID WEAPON FAMILY // EQUIP BLOCKED"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	if not _equipped_weapon_instances.is_empty():
		var target_index := clampi(_armory_equipped_selected_index, 0, _equipped_weapon_instances.size() - 1)
		var previous: Dictionary = Dictionary(_equipped_weapon_instances[target_index]).duplicate(true)
		candidate["equipped"] = true
		previous["equipped"] = false
		_equipped_weapon_instances[target_index] = candidate
		_stash_weapon_instances[_armory_stash_selected_index] = previous
		_armory_equipped_selected_index = target_index
		_armory_selected_section = "equipped"
		_armory_status_text = "EQUIPPED %s INTO E%02d // OLD WEAPON SENT TO STASH" % [str(candidate.get("name", "WEAPON")).to_upper(), target_index + 1]
	elif _equipped_weapon_instances.size() < EQUIPPED_WEAPON_SLOT_CAP:
		candidate["equipped"] = true
		_equipped_weapon_instances.append(candidate)
		_stash_weapon_instances.remove_at(_armory_stash_selected_index)
		_armory_equipped_selected_index = _equipped_weapon_instances.size() - 1
		_armory_stash_selected_index = clampi(_armory_stash_selected_index, 0, maxi(0, _stash_weapon_instances.size() - 1))
		_armory_selected_section = "equipped"
		_armory_status_text = "EQUIPPED %s INTO EMPTY SLOT" % str(candidate.get("name", "WEAPON")).to_upper()
	else:
		_armory_status_text = "NO EQUIPPED SLOT AVAILABLE // EQUIP BLOCKED"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	_remember_discovered_weapon(candidate)
	_rebuild_weapon_stat_bonuses()
	_save_weapon_inventory()
	_update_orbit_visual_visibility()
	_update_armory_ui()
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.08, 0.18)


func _scrap_selected_stash_weapon() -> void:
	if _stash_weapon_instances.is_empty():
		_armory_action_mode = "browse"
		_armory_status_text = "NO STORED WEAPON TO SCRAP"
		_update_armory_ui()
		_play_sfx("ui_back", 0.08)
		return
	_armory_stash_selected_index = clampi(_armory_stash_selected_index, 0, _stash_weapon_instances.size() - 1)
	var removed: Dictionary = Dictionary(_stash_weapon_instances[_armory_stash_selected_index]).duplicate(true)
	_stash_weapon_instances.remove_at(_armory_stash_selected_index)
	_armory_stash_selected_index = clampi(_armory_stash_selected_index, 0, maxi(0, _stash_weapon_instances.size() - 1))
	var dust_amount := _neon_dust_value_for_weapon(removed)
	_grant_neon_dust(dust_amount, false)
	_armory_action_mode = "browse"
	_armory_selected_section = "stash" if not _stash_weapon_instances.is_empty() else "equipped"
	_armory_status_text = "SCRAPPED %s // +%d NEON DUST // TOTAL %d" % [str(removed.get("name", "WEAPON")).to_upper(), dust_amount, _neon_dust]
	_save_weapon_inventory()
	_update_hud()
	_update_armory_ui()
	_focus_armory_choice()
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(Color(1.0, 0.94, 0.18), 0.07, 0.16)


func _open_weapon_reward_decision(upgrade: Dictionary, was_sector_reward: bool) -> void:
	_weapon_reward_pending_upgrade = upgrade.duplicate(true)
	_weapon_reward_pending_instance = Dictionary(upgrade.get("weapon_instance", {})).duplicate(true)
	if _weapon_reward_pending_instance.is_empty():
		_apply_weapon_reward(upgrade)
		_finish_level_up_choice(was_sector_reward)
		return
	_weapon_reward_was_sector_reward = was_sector_reward
	_weapon_reward_decision_active = true
	_weapon_reward_mode = "actions"
	_clear_chain_link_effects()
	_weapon_reward_action_selected_index = 0
	_weapon_reward_slot_selected_index = clampi(_armory_equipped_selected_index, 0, maxi(0, _equipped_weapon_instances.size() - 1))
	_weapon_reward_status_text = "CHOOSE A ROUTE FOR %s" % str(_weapon_reward_pending_instance.get("name", "WEAPON")).to_upper()
	_weapon_reward_last_result_text = ""
	if _level_up_panel:
		_level_up_panel.visible = false
	if _weapon_reward_panel:
		_weapon_reward_panel.visible = true
	_update_weapon_reward_ui()
	_queue_tutorial_prompt("weapon_loot")
	_focus_weapon_reward_choice()
	_play_sfx("ui_select", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.05, 0.15)


func _handle_weapon_reward_decision_input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		_activate_weapon_reward_selection()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("cancel"):
		_cancel_weapon_reward_selection()
		get_viewport().set_input_as_handled()
		return
	if _level_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_left"):
		_move_weapon_reward_selection(Vector2i(-1, 0))
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_right"):
		_move_weapon_reward_selection(Vector2i(1, 0))
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_up"):
		_move_weapon_reward_selection(Vector2i(0, -1))
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		_move_weapon_reward_selection(Vector2i(0, 1))
		get_viewport().set_input_as_handled()


func _move_weapon_reward_selection(direction: Vector2i) -> void:
	if not _weapon_reward_decision_active or _weapon_reward_mode == "result":
		return
	if _weapon_reward_mode == "slots":
		var count := mini(EQUIPPED_WEAPON_SLOT_CAP, _equipped_weapon_instances.size())
		if count <= 0:
			return
		var step := direction.x
		if direction.y != 0:
			step = direction.y * 2
		_weapon_reward_slot_selected_index = wrapi(_weapon_reward_slot_selected_index + step, 0, count)
	else:
		var step := direction.x
		if direction.y != 0:
			step = direction.y
		_weapon_reward_action_selected_index = wrapi(_weapon_reward_action_selected_index + step, 0, _weapon_reward_action_buttons.size())
	_level_nav_cooldown = 0.16
	_update_weapon_reward_ui()
	_focus_weapon_reward_choice()
	_play_sfx("ui_move", 0.04)


func _activate_weapon_reward_selection() -> void:
	if not _weapon_reward_decision_active:
		return
	if _weapon_reward_mode == "result":
		_finish_weapon_reward_decision()
		return
	if _weapon_reward_mode == "slots":
		_replace_pending_weapon_reward_slot(_weapon_reward_slot_selected_index)
		return
	var action := _weapon_reward_action_id(_weapon_reward_action_selected_index)
	match action:
		"equip":
			if _find_open_weapon_slot_index() >= 0:
				_equip_pending_weapon_reward_now()
			else:
				_open_weapon_reward_slot_picker("LOADOUT FULL // CHOOSE A SLOT TO REPLACE")
		"replace":
			_open_weapon_reward_slot_picker("CHOOSE EQUIPPED SLOT TO REPLACE")
		"stash":
			_send_pending_weapon_reward_to_stash()
		"scrap":
			_scrap_pending_weapon_reward()


func _cancel_weapon_reward_selection() -> void:
	if not _weapon_reward_decision_active:
		return
	if _weapon_reward_mode == "slots":
		_weapon_reward_mode = "actions"
		_weapon_reward_status_text = "BACK TO LOOT ROUTE // SELECT EQUIP, REPLACE, STASH, OR SCRAP"
		_update_weapon_reward_ui()
		_focus_weapon_reward_choice()
		_play_sfx("ui_back", 0.08)
		return
	if _weapon_reward_mode == "result":
		_finish_weapon_reward_decision()
		return
	_weapon_reward_decision_active = false
	_weapon_reward_mode = "actions"
	if _weapon_reward_panel:
		_weapon_reward_panel.visible = false
	if _weapon_reward_selection_cursor:
		_weapon_reward_selection_cursor.visible = false
	if _level_up_panel:
		_level_up_panel.visible = true
	_focus_upgrade_choice()
	_play_sfx("ui_back", 0.08)


func _open_weapon_reward_slot_picker(status_text: String) -> void:
	if _equipped_weapon_instances.is_empty():
		if _find_open_weapon_slot_index() >= 0:
			_equip_pending_weapon_reward_now()
		else:
			_weapon_reward_status_text = "NO EQUIPPED SLOT AVAILABLE // SEND TO STASH OR SCRAP"
			_update_weapon_reward_ui()
			_play_sfx("ui_back", 0.08)
		return
	_weapon_reward_mode = "slots"
	_weapon_reward_slot_selected_index = clampi(_weapon_reward_slot_selected_index, 0, _equipped_weapon_instances.size() - 1)
	_weapon_reward_status_text = status_text
	_update_weapon_reward_ui()
	_focus_weapon_reward_choice()
	_play_sfx("ui_select", 0.08)


func _equip_pending_weapon_reward_now() -> void:
	if _weapon_reward_pending_instance.is_empty():
		return
	var open_index := _find_open_weapon_slot_index()
	if open_index < 0:
		_open_weapon_reward_slot_picker("LOADOUT FULL // CHOOSE A SLOT TO REPLACE")
		return
	var instance := _weapon_reward_pending_instance.duplicate(true)
	instance["equipped"] = true
	_equipped_weapon_instances.append(instance)
	_remember_discovered_weapon(instance)
	_rebuild_weapon_stat_bonuses()
	_save_weapon_inventory()
	_run_weapons_gained += 1
	_weapon_reward_last_result_text = "EQUIPPED %s INTO E%02d // ACTIVE THIS RUN" % [_weapon_progression_summary(instance), open_index + 1]
	_show_weapon_reward_result(_weapon_reward_last_result_text, Color(0.0, 0.94, 1.0))


func _replace_pending_weapon_reward_slot(slot_index: int) -> void:
	if _weapon_reward_pending_instance.is_empty() or _equipped_weapon_instances.is_empty():
		return
	slot_index = clampi(slot_index, 0, _equipped_weapon_instances.size() - 1)
	if _stash_weapon_instances.size() >= STASH_WEAPON_CAP:
		_weapon_reward_status_text = "STASH FULL // CANNOT STORE OLD E%02d WEAPON" % [slot_index + 1]
		_update_weapon_reward_ui()
		_focus_weapon_reward_choice()
		_play_sfx("ui_back", 0.08)
		return
	var instance := _weapon_reward_pending_instance.duplicate(true)
	var previous := Dictionary(_equipped_weapon_instances[slot_index]).duplicate(true)
	instance["equipped"] = true
	previous["equipped"] = false
	_equipped_weapon_instances[slot_index] = instance
	_stash_weapon_instances.append(previous)
	_remember_discovered_weapon(instance)
	_remember_discovered_weapon(previous)
	_rebuild_weapon_stat_bonuses()
	_save_weapon_inventory()
	_run_weapons_gained += 1
	_weapon_reward_last_result_text = "REPLACED E%02d // NEW: %s // OLD WEAPON SENT TO STASH" % [slot_index + 1, _weapon_progression_summary(instance)]
	_show_weapon_reward_result(_weapon_reward_last_result_text, Color(1.0, 0.08, 0.86))


func _send_pending_weapon_reward_to_stash() -> void:
	if _weapon_reward_pending_instance.is_empty():
		return
	if _stash_weapon_instances.size() >= STASH_WEAPON_CAP:
		_weapon_reward_status_text = "STASH FULL // CHOOSE EQUIP, REPLACE, OR SCRAP"
		_update_weapon_reward_ui()
		_focus_weapon_reward_choice()
		_play_sfx("ui_back", 0.08)
		return
	var instance := _weapon_reward_pending_instance.duplicate(true)
	instance["equipped"] = false
	_stash_weapon_instances.append(instance)
	_remember_discovered_weapon(instance)
	_save_weapon_inventory()
	_run_weapons_gained += 1
	_weapon_reward_last_result_text = "STASHED %s // STORED %d / %d // INACTIVE UNTIL EQUIPPED" % [_weapon_progression_summary(instance), _stash_weapon_instances.size(), STASH_WEAPON_CAP]
	_show_weapon_reward_result(_weapon_reward_last_result_text, Color(0.0, 0.94, 1.0))


func _scrap_pending_weapon_reward() -> void:
	if _weapon_reward_pending_instance.is_empty():
		return
	var dust_amount := _neon_dust_value_for_weapon(_weapon_reward_pending_instance)
	_grant_neon_dust(dust_amount, true)
	_save_weapon_inventory()
	_spawn_burst(_player_area.position, 0.92, "burst_yellow")
	_weapon_reward_last_result_text = "SCRAPPED %s // +%d NEON DUST // TOTAL %d // WEAPON NOT STORED" % [_weapon_progression_summary(_weapon_reward_pending_instance), dust_amount, _neon_dust]
	_show_weapon_reward_result(_weapon_reward_last_result_text, Color(1.0, 0.94, 0.18))


func _weapon_progression_summary(instance: Dictionary) -> String:
	if instance.is_empty():
		return "UNKNOWN WEAPON"
	var parts: Array[String] = [
		str(instance.get("rarity", "Common")).to_upper(),
		str(instance.get("name", "WEAPON")).to_upper(),
		"PWR %.2f" % float(instance.get("power_score", WeaponCatalog.estimate_power(instance)))
	]
	var forge_rank := clampi(int(instance.get("forge_power_rank", 0)), 0, FORGE_POWER_MAX_RANK)
	if forge_rank > 0:
		parts.append("FORGE %d" % forge_rank)
	var evolved := _evolution_rank(instance)
	if evolved > 0:
		parts.append("EVOLVED %d" % evolved)
	return " // ".join(parts)


func _show_weapon_reward_result(result_text: String, flash_color: Color) -> void:
	_weapon_reward_mode = "result"
	_weapon_reward_status_text = "RESULT: %s\nA / ENTER: CONTINUE" % result_text
	_update_weapon_reward_ui()
	_play_sfx("reward", 0.12)
	_trigger_presentation_flash(flash_color, 0.09, 0.18)
	_add_screen_shake(0.045, 0.10)
	_update_hud()


func _finish_weapon_reward_decision() -> void:
	var was_sector_reward := _weapon_reward_was_sector_reward
	_clear_weapon_reward_decision_state()
	_finish_level_up_choice(was_sector_reward)


func _clear_weapon_reward_decision_state() -> void:
	_weapon_reward_decision_active = false
	_weapon_reward_mode = "actions"
	_weapon_reward_was_sector_reward = false
	_weapon_reward_pending_upgrade.clear()
	_weapon_reward_pending_instance.clear()
	_weapon_reward_action_selected_index = 0
	_weapon_reward_slot_selected_index = 0
	_weapon_reward_status_text = "CHOOSE A LOOT ROUTE"
	if _weapon_reward_panel:
		_weapon_reward_panel.visible = false
	if _weapon_reward_selection_cursor:
		_weapon_reward_selection_cursor.visible = false


func _update_weapon_reward_ui() -> void:
	if not is_instance_valid(_weapon_reward_panel):
		return
	_weapon_reward_panel.visible = _weapon_reward_decision_active
	if not _weapon_reward_decision_active:
		if _weapon_reward_selection_cursor:
			_weapon_reward_selection_cursor.visible = false
		return
	var instance := _weapon_reward_pending_instance
	var rarity := str(instance.get("rarity", "Common"))
	var accent := Color.html("#%s" % WeaponCatalog.rarity_accent_hex(rarity))
	if _weapon_reward_title:
		_weapon_reward_title.text = "GENERATED WEAPON SYSTEM // %s" % rarity.to_upper()
		_weapon_reward_title.add_theme_color_override("font_color", accent)
	if _weapon_reward_prompt:
		match _weapon_reward_mode:
			"slots":
				_weapon_reward_prompt.text = "Choose the equipped weapon to replace. Old weapon moves to stash.\nA / Enter: Replace Slot    B / Esc: Back To Actions    D-Pad / Arrows: Select Slot    RS: Scroll"
			"result":
				_weapon_reward_prompt.text = "A / Enter: Continue    B / Esc: Continue"
			_:
				_weapon_reward_prompt.text = "Equipped weapons auto-fire. Stashed weapons can be managed in Armory. Scrap converts the weapon to Neon Dust.\nA / Enter: Select Route    B / Esc: Back To Reward Card    D-Pad / Arrows: Navigate    RS: Scroll"
	if _weapon_reward_detail_label:
		_weapon_reward_detail_label.text = _weapon_reward_detail_text(instance)
	if _weapon_reward_compare_label:
		_weapon_reward_compare_label.text = _weapon_reward_compare_text(instance)
	_set_weapon_icon(_weapon_reward_preview_icon, instance, not instance.is_empty())
	if instance.is_empty():
		_set_weapon_icon(_weapon_reward_compare_current_icon, "unknown_weapon", false)
		_set_weapon_icon(_weapon_reward_compare_candidate_icon, "unknown_weapon", false)
	elif _equipped_weapon_instances.is_empty():
		_set_weapon_icon(_weapon_reward_compare_current_icon, "unknown_weapon", false)
		_set_weapon_icon(_weapon_reward_compare_candidate_icon, instance, true)
	else:
		var compare_slot := clampi(_weapon_reward_slot_selected_index, 0, _equipped_weapon_instances.size() - 1)
		_set_weapon_icon(_weapon_reward_compare_current_icon, _equipped_weapon_instances[compare_slot], true)
		_set_weapon_icon(_weapon_reward_compare_candidate_icon, instance, true)
	if _weapon_reward_action_row:
		_weapon_reward_action_row.visible = _weapon_reward_mode == "actions"
	if _weapon_reward_slot_grid:
		_weapon_reward_slot_grid.visible = _weapon_reward_mode == "slots"
	if _weapon_reward_slot_scroll:
		_weapon_reward_slot_scroll.visible = _weapon_reward_mode == "slots"
	_update_weapon_reward_action_buttons(accent)
	_update_weapon_reward_slot_buttons(instance, accent)
	if _weapon_reward_status_label:
		_weapon_reward_status_label.text = _weapon_reward_status_text
	_update_weapon_reward_cursor_position(true)


func _update_weapon_reward_action_buttons(accent: Color) -> void:
	for i in range(_weapon_reward_action_buttons.size()):
		var button := _weapon_reward_action_buttons[i]
		button.visible = _weapon_reward_mode == "actions"
		button.disabled = false
		button.text = _weapon_reward_action_text(_weapon_reward_action_id(i))
		_apply_weapon_reward_button_accent(button, i == _weapon_reward_action_selected_index, accent)


func _update_weapon_reward_slot_buttons(instance: Dictionary, accent: Color) -> void:
	for i in range(_weapon_reward_slot_buttons.size()):
		var button := _weapon_reward_slot_buttons[i]
		if _weapon_reward_mode != "slots" or i >= _equipped_weapon_instances.size():
			button.visible = false
			if i < _weapon_reward_slot_icons.size():
				_set_weapon_icon(_weapon_reward_slot_icons[i], "unknown_weapon", false)
			continue
		button.visible = true
		button.disabled = false
		button.text = _weapon_reward_slot_button_text(i, instance)
		if i < _weapon_reward_slot_icons.size():
			_set_weapon_icon(_weapon_reward_slot_icons[i], _equipped_weapon_instances[i], true)
		_apply_weapon_reward_button_accent(button, i == _weapon_reward_slot_selected_index, accent)


func _weapon_reward_action_id(index: int) -> String:
	match clampi(index, 0, 3):
		0:
			return "equip"
		1:
			return "replace"
		2:
			return "stash"
		_:
			return "scrap"


func _weapon_reward_action_text(action: String) -> String:
	match action:
		"equip":
			var open_index := _find_open_weapon_slot_index()
			return "EQUIP NOW\n%s" % ("OPEN SLOT E%02d" % [open_index + 1] if open_index >= 0 else "LOADOUT FULL")
		"replace":
			return "REPLACE SLOT\nPICK EQUIPPED SLOT"
		"stash":
			return "SEND TO STASH\n%d / %d STORED" % [_stash_weapon_instances.size(), STASH_WEAPON_CAP]
		_:
			return "SCRAP / SKIP\n+%d NEON DUST" % _neon_dust_value_for_weapon(_weapon_reward_pending_instance)


func _weapon_reward_detail_text(instance: Dictionary) -> String:
	if instance.is_empty():
		return "NO WEAPON DATA"
	var lines: Array[String] = []
	lines.append("%s %s" % [str(instance.get("rarity", "Common")).to_upper(), str(instance.get("name", "WEAPON")).to_upper()])
	lines.append("FAMILY: %s" % str(instance.get("family", instance.get("definition_id", "weapon"))).to_upper())
	lines.append("ARCHETYPE: %s" % str(instance.get("archetype", "weapon")).to_upper())
	lines.append("SHAPE: %s" % str(instance.get("shape", WeaponCatalog.weapon_definition(str(instance.get("definition_id", ""))).get("shape", "Weapon geometry"))).to_upper())
	lines.append("POWER: %.2f" % float(instance.get("power_score", WeaponCatalog.estimate_power(instance))))
	lines.append("SPECIAL: %s" % WeaponCatalog.primary_modifier_text(instance).to_upper())
	var rolls: Array = instance.get("stat_rolls", [])
	if rolls.is_empty():
		lines.append("STATS: BASELINE")
	else:
		lines.append("KEY STATS:")
		for i in range(mini(4, rolls.size())):
			var roll: Dictionary = rolls[i]
			lines.append("  %s %s" % [str(roll.get("label", "Stat")).to_upper(), WeaponCatalog.format_stat(roll)])
	return "\n".join(lines)


func _weapon_reward_compare_text(instance: Dictionary) -> String:
	if instance.is_empty():
		return "NO WEAPON SELECTED"
	if _weapon_reward_mode == "result":
		return "%s\n\n%s" % [_weapon_reward_last_result_text, _weapon_reward_detail_text(instance)]
	if _equipped_weapon_instances.is_empty():
		return "NO EQUIPPED WEAPON TO COMPARE.\nEQUIP NOW WILL USE THE FIRST OPEN SLOT."
	var slot_index := clampi(_weapon_reward_slot_selected_index, 0, _equipped_weapon_instances.size() - 1)
	var current: Dictionary = _equipped_weapon_instances[slot_index]
	var comparison: Dictionary = WeaponCatalog.comparison_data(instance, current)
	var power_delta := float(comparison.get("power_delta", 0.0))
	var lines: Array[String] = []
	lines.append("CURRENT E%02d: %s" % [slot_index + 1, _armory_weapon_brief(current)])
	lines.append("NEW: %s" % _armory_weapon_brief(instance))
	lines.append("FAMILY: %s -> %s" % [str(current.get("family", current.get("definition_id", ""))).to_upper(), str(instance.get("family", instance.get("definition_id", ""))).to_upper()])
	lines.append("RARITY: %s -> %s" % [str(current.get("rarity", "Common")).to_upper(), str(instance.get("rarity", "Common")).to_upper()])
	lines.append("POWER %s %+.2f" % [_armory_arrow(power_delta), power_delta])
	var deltas: Dictionary = comparison.get("stat_deltas", {})
	var shown := 0
	for stat_id in ["damage_bonus", "fire_rate_bonus", "cooldown_reduction", "range_bonus", "lifetime_bonus", "projectile_speed_bonus", "projectile_count_bonus", "pierce_bonus", "split_count_bonus", "chain_count_bonus", "orbit_count_bonus"]:
		if not deltas.has(stat_id):
			continue
		var delta := float(deltas[stat_id])
		if absf(delta) < 0.0005:
			continue
		lines.append("%s %s %s" % [_weapon_stat_display_label(stat_id), _armory_arrow(delta), _format_armory_stat_delta(stat_id, delta)])
		shown += 1
		if shown >= 5:
			break
	if shown == 0:
		lines.append("ROLL DELTAS: EVEN / DIFFERENT")
	lines.append("SPECIAL: %s" % WeaponCatalog.primary_modifier_text(instance).to_upper())
	return "\n".join(lines)


func _weapon_reward_slot_button_text(slot_index: int, candidate: Dictionary) -> String:
	var current: Dictionary = _equipped_weapon_instances[slot_index]
	var comparison: Dictionary = WeaponCatalog.comparison_data(candidate, current)
	var power_delta := float(comparison.get("power_delta", 0.0))
	var deltas: Dictionary = comparison.get("stat_deltas", {})
	var stat_bits: Array[String] = []
	for stat_id in ["damage_bonus", "fire_rate_bonus", "cooldown_reduction", "range_bonus"]:
		if deltas.has(stat_id):
			var delta := float(deltas[stat_id])
			if absf(delta) >= 0.0005:
				stat_bits.append("%s %s" % [_weapon_stat_display_label(stat_id), _armory_arrow(delta)])
		if stat_bits.size() >= 2:
			break
	if stat_bits.is_empty():
		stat_bits.append("DIFFERENT BUILD")
	return "E%02d  %s\nPWR %.2f -> %.2f  %s %+.2f\n%s" % [
		slot_index + 1,
		_armory_weapon_brief(current),
		float(current.get("power_score", WeaponCatalog.estimate_power(current))),
		float(candidate.get("power_score", WeaponCatalog.estimate_power(candidate))),
		_armory_arrow(power_delta),
		power_delta,
		"  ".join(stat_bits)
	]


func _apply_weapon_reward_button_accent(button: Button, selected: bool, accent: Color) -> void:
	var content_margin_left := int(button.get_meta("content_margin_left", 10))
	button.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18) if selected else accent)
	if selected:
		button.add_theme_stylebox_override("normal", _button_style(Color(0.030, 0.012, 0.044, 0.96), Color(1.0, 0.92, 0.06, 1.0), 3, content_margin_left))
		button.add_theme_stylebox_override("focus", _button_style(Color(0.030, 0.012, 0.044, 0.96), Color(1.0, 0.92, 0.06, 1.0), 3, content_margin_left))
	else:
		button.add_theme_stylebox_override("normal", _button_style(Color(0.0, 0.010, 0.032, 0.86), Color(accent.r, accent.g, accent.b, 0.82), 2, content_margin_left))
		button.add_theme_stylebox_override("focus", _button_style(Color(0.030, 0.012, 0.044, 0.96), Color(1.0, 0.92, 0.06, 1.0), 3, content_margin_left))


func _focus_weapon_reward_choice() -> void:
	if not _weapon_reward_decision_active:
		return
	var button := _weapon_reward_focus_button()
	if button != null and is_instance_valid(button):
		button.grab_focus()
		if _weapon_reward_mode == "slots":
			_ensure_scroll_visible(_weapon_reward_slot_scroll, button)
	_update_weapon_reward_cursor_position(true)
	call_deferred("_update_weapon_reward_cursor_position", true)


func _weapon_reward_focus_button() -> Button:
	if _weapon_reward_mode == "slots":
		if _weapon_reward_slot_selected_index >= 0 and _weapon_reward_slot_selected_index < _weapon_reward_slot_buttons.size():
			return _weapon_reward_slot_buttons[_weapon_reward_slot_selected_index]
	elif _weapon_reward_mode == "actions":
		if _weapon_reward_action_selected_index >= 0 and _weapon_reward_action_selected_index < _weapon_reward_action_buttons.size():
			return _weapon_reward_action_buttons[_weapon_reward_action_selected_index]
	return null


func _update_weapon_reward_cursor_position(immediate: bool) -> void:
	if not is_instance_valid(_weapon_reward_selection_cursor) or not is_instance_valid(_hud_design_root):
		return
	var button := _weapon_reward_focus_button()
	if not _weapon_reward_decision_active or _weapon_reward_mode == "result" or not is_instance_valid(button) or not button.visible:
		_weapon_reward_selection_cursor.visible = false
		return
	_weapon_reward_selection_cursor.visible = true
	var local_transform := _hud_design_root.get_global_transform_with_canvas().affine_inverse()
	var target_rect := button.get_global_rect()
	var target := local_transform * Vector2(target_rect.position.x - 44.0, target_rect.position.y + target_rect.size.y * 0.5 - _weapon_reward_selection_cursor.size.y * 0.5)
	if immediate or _weapon_reward_selection_cursor.position.distance_to(target) > 140.0:
		_weapon_reward_selection_cursor.position = target
	else:
		_weapon_reward_selection_cursor.position = _weapon_reward_selection_cursor.position.lerp(target, 0.34)


func _find_open_weapon_slot_index() -> int:
	return _equipped_weapon_instances.size() if _equipped_weapon_instances.size() < EQUIPPED_WEAPON_SLOT_CAP else -1


func _update_title_cursor_position(immediate: bool) -> void:
	if not is_instance_valid(_title_selection_cursor) or not is_instance_valid(_title_menu_panel):
		return
	if _armory_visible or _core_upgrades_visible or (_help_visible and _help_context == "title"):
		_title_selection_cursor.visible = false
		return
	var active_buttons := _title_options_buttons if _title_options_visible else _title_menu_buttons
	var selected_index := _title_options_selected_index if _title_options_visible else _title_menu_selected_index
	if active_buttons.is_empty():
		_title_selection_cursor.visible = false
		return
	selected_index = clampi(selected_index, 0, active_buttons.size() - 1)
	if _title_options_visible:
		_title_options_selected_index = selected_index
	else:
		_title_menu_selected_index = selected_index
	var button := active_buttons[selected_index]
	if not is_instance_valid(button):
		_title_selection_cursor.visible = false
		return
	_title_selection_cursor.visible = _title_menu_active and _title_menu_panel.visible
	var local_transform := _title_menu_panel.get_global_transform_with_canvas().affine_inverse()
	var button_global := button.get_global_rect()
	var button_position := local_transform * button_global.position
	var cursor_size := _title_selection_cursor.size
	if cursor_size.x <= 0.0 or cursor_size.y <= 0.0:
		cursor_size = Vector2(58, 38)
	_title_selection_cursor.size = cursor_size
	var target := button_position + Vector2(-88.0, button.size.y * 0.5 - cursor_size.y * 0.5)
	if immediate or _title_selection_cursor.position.distance_to(target) > 140.0:
		_title_selection_cursor.position = target
	else:
		_title_selection_cursor.position = _title_selection_cursor.position.lerp(target, 0.34)


func _update_core_upgrade_cursor_position(immediate: bool) -> void:
	if not is_instance_valid(_core_upgrade_selection_cursor) or not is_instance_valid(_title_menu_panel):
		return
	if not _core_upgrades_visible or _core_upgrade_buttons.is_empty():
		_core_upgrade_selection_cursor.visible = false
		return
	_core_upgrade_selected_index = clampi(_core_upgrade_selected_index, 0, _core_upgrade_buttons.size() - 1)
	var button := _core_upgrade_buttons[_core_upgrade_selected_index]
	if not is_instance_valid(button) or not button.visible:
		_core_upgrade_selection_cursor.visible = false
		return
	_core_upgrade_selection_cursor.visible = true
	var local_transform := _title_menu_panel.get_global_transform_with_canvas().affine_inverse()
	var button_global := button.get_global_rect()
	var button_position := local_transform * button_global.position
	var cursor_size := _core_upgrade_selection_cursor.size
	if cursor_size.x <= 0.0 or cursor_size.y <= 0.0:
		cursor_size = Vector2(52, 34)
	_core_upgrade_selection_cursor.size = cursor_size
	var target := button_position + Vector2(-72.0, button.size.y * 0.5 - cursor_size.y * 0.5)
	if immediate or _core_upgrade_selection_cursor.position.distance_to(target) > 140.0:
		_core_upgrade_selection_cursor.position = target
	else:
		_core_upgrade_selection_cursor.position = _core_upgrade_selection_cursor.position.lerp(target, 0.34)


func _update_armory_cursor_position(immediate: bool) -> void:
	if not is_instance_valid(_armory_selection_cursor) or not is_instance_valid(_title_menu_panel):
		return
	if not _armory_visible:
		_armory_selection_cursor.visible = false
		return
	var button: Button
	if _armory_action_mode != "browse":
		var action_buttons := _visible_armory_action_buttons()
		if _armory_action_selected_index >= 0 and _armory_action_selected_index < action_buttons.size():
			button = action_buttons[_armory_action_selected_index]
	elif _armory_selected_section == "stash":
		button = _armory_stash_button_for_index(_armory_stash_selected_index)
	else:
		button = _armory_equipped_button_for_index(_armory_equipped_selected_index)
	if not is_instance_valid(button) or button.disabled or not button.visible:
		_armory_selection_cursor.visible = false
		return
	_armory_selection_cursor.visible = true
	var local_transform := _title_menu_panel.get_global_transform_with_canvas().affine_inverse()
	var button_global := button.get_global_rect()
	var button_position := local_transform * button_global.position
	var cursor_size := _armory_selection_cursor.size
	if cursor_size.x <= 0.0 or cursor_size.y <= 0.0:
		cursor_size = Vector2(52, 34)
	_armory_selection_cursor.size = cursor_size
	var target := button_position + Vector2(-72.0, button.size.y * 0.5 - cursor_size.y * 0.5)
	if immediate or _armory_selection_cursor.position.distance_to(target) > 140.0:
		_armory_selection_cursor.position = target
	else:
		_armory_selection_cursor.position = _armory_selection_cursor.position.lerp(target, 0.34)


func _update_pause_cursor_position(immediate: bool) -> void:
	if not is_instance_valid(_pause_selection_cursor) or not is_instance_valid(_hud_design_root):
		return
	if _help_visible and _help_context == "pause":
		_pause_selection_cursor.visible = false
		return
	var active_buttons := _pause_options_buttons if _pause_options_visible else _pause_menu_buttons
	var selected_index := _pause_options_selected_index if _pause_options_visible else _pause_menu_selected_index
	if not _manual_pause or active_buttons.is_empty():
		_pause_selection_cursor.visible = false
		return
	selected_index = clampi(selected_index, 0, active_buttons.size() - 1)
	if _pause_options_visible:
		_pause_options_selected_index = selected_index
	else:
		_pause_menu_selected_index = selected_index
	var button := active_buttons[selected_index]
	if not is_instance_valid(button):
		_pause_selection_cursor.visible = false
		return
	_pause_selection_cursor.visible = true
	var local_transform := _hud_design_root.get_global_transform_with_canvas().affine_inverse()
	var button_global := button.get_global_rect()
	var button_position := local_transform * button_global.position
	var cursor_size := _pause_selection_cursor.size
	if cursor_size.x <= 0.0 or cursor_size.y <= 0.0:
		cursor_size = Vector2(58, 38)
	_pause_selection_cursor.size = cursor_size
	var target := button_position + Vector2(-88.0, button.size.y * 0.5 - cursor_size.y * 0.5)
	if immediate or _pause_selection_cursor.position.distance_to(target) > 140.0:
		_pause_selection_cursor.position = target
	else:
		_pause_selection_cursor.position = _pause_selection_cursor.position.lerp(target, 0.34)


func _update_help_cursor_position(immediate: bool) -> void:
	if not is_instance_valid(_help_selection_cursor) or not is_instance_valid(_hud_design_root):
		return
	if not _help_visible or _help_buttons.is_empty():
		_help_selection_cursor.visible = false
		return
	_help_selected_index = clampi(_help_selected_index, 0, _help_buttons.size() - 1)
	var button := _help_buttons[_help_selected_index]
	if not is_instance_valid(button) or not button.visible:
		_help_selection_cursor.visible = false
		return
	_help_selection_cursor.visible = true
	var local_transform := _hud_design_root.get_global_transform_with_canvas().affine_inverse()
	var button_global := button.get_global_rect()
	var button_position := local_transform * button_global.position
	var cursor_size := _help_selection_cursor.size
	if cursor_size.x <= 0.0 or cursor_size.y <= 0.0:
		cursor_size = Vector2(52, 34)
	_help_selection_cursor.size = cursor_size
	var target := button_position + Vector2(-72.0, button.size.y * 0.5 - cursor_size.y * 0.5)
	if immediate or _help_selection_cursor.position.distance_to(target) > 140.0:
		_help_selection_cursor.position = target
	else:
		_help_selection_cursor.position = _help_selection_cursor.position.lerp(target, 0.34)


func _set_gameplay_hud_visible(visible: bool) -> void:
	if _gameplay_hud_root:
		_gameplay_hud_root.visible = visible


func _create_level_up_panel(root: Control) -> void:
	_level_up_panel = NeonHudPanel.new()
	_level_up_panel.name = "LevelUpChoicePanel"
	_level_up_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_level_up_panel.visible = false
	_level_up_panel.configure(Color(0.0, 0.95, 1.0, 0.96), Color(1.0, 0.06, 0.86, 0.86), Vector2(842, 282), 22.0, 2.5)
	_level_up_panel.set_anchors_preset(Control.PRESET_CENTER)
	_level_up_panel.offset_left = -421
	_level_up_panel.offset_top = -141
	_level_up_panel.offset_right = 421
	_level_up_panel.offset_bottom = 141
	root.add_child(_level_up_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_bottom", 14)
	_level_up_panel.add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	margin.add_child(layout)

	_level_up_title = _make_hud_label("LEVEL UP")
	_level_up_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_level_up_title.add_theme_font_size_override("font_size", 22)
	_level_up_title.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_level_up_title)

	_level_up_prompt = _make_hud_label("D-Pad / Left Stick: Select    A / Enter: Confirm")
	_level_up_prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_level_up_prompt.add_theme_font_size_override("font_size", 12)
	_level_up_prompt.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_level_up_prompt.custom_minimum_size = Vector2(790, 34)
	layout.add_child(_level_up_prompt)

	var choices := HBoxContainer.new()
	choices.add_theme_constant_override("separation", 10)
	layout.add_child(choices)
	_upgrade_choice_icons.clear()
	for i in range(3):
		var button := Button.new()
		button.name = "UpgradeChoice%d" % i
		button.set_meta("choice_index", i)
		button.custom_minimum_size = Vector2(242, 116)
		button.focus_mode = Control.FOCUS_ALL
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		button.add_theme_font_size_override("font_size", 13)
		button.add_theme_color_override("font_color", Color(0.86, 1.0, 1.0))
		button.add_theme_color_override("font_focus_color", Color.WHITE)
		button.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.90))
		button.add_theme_constant_override("outline_size", 2)
		button.add_theme_stylebox_override("normal", _button_style(Color(0.0, 0.010, 0.032, 0.84), Color(0.0, 0.82, 1.0, 0.72), 1, 84))
		button.add_theme_stylebox_override("focus", _button_style(Color(0.030, 0.012, 0.044, 0.94), Color(1.0, 0.92, 0.06, 1.0), 3, 84))
		button.add_theme_stylebox_override("hover", _button_style(Color(0.018, 0.006, 0.038, 0.92), Color(1.0, 0.08, 0.88, 0.88), 2, 84))
		button.pressed.connect(func() -> void:
			_upgrade_selected_index = int(button.get_meta("choice_index"))
			_confirm_level_up_choice()
		)
		var icon := _make_weapon_icon_control(Vector2(64, 64))
		icon.position = Vector2(9, 8)
		button.add_child(icon)
		choices.add_child(button)
		_upgrade_buttons.append(button)
		_upgrade_choice_icons.append(icon)


func _create_weapon_reward_decision_panel(root: Control) -> void:
	_weapon_reward_panel = NeonHudPanel.new()
	_weapon_reward_panel.name = "InRunWeaponRewardDecisionConsole"
	_weapon_reward_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	_weapon_reward_panel.visible = false
	_weapon_reward_panel.configure(Color(0.0, 0.96, 1.0, 0.96), Color(1.0, 0.06, 0.86, 0.86), Vector2(1080, 640), 26.0, 2.5)
	_weapon_reward_panel.set_anchors_preset(Control.PRESET_CENTER)
	_weapon_reward_panel.offset_left = -540
	_weapon_reward_panel.offset_top = -320
	_weapon_reward_panel.offset_right = 540
	_weapon_reward_panel.offset_bottom = 320
	root.add_child(_weapon_reward_panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 22)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 22)
	margin.add_theme_constant_override("margin_bottom", 18)
	_weapon_reward_panel.add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 9)
	margin.add_child(layout)

	_weapon_reward_title = _make_hud_label("WEAPON LOOT ROUTE")
	_weapon_reward_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_weapon_reward_title.add_theme_font_size_override("font_size", 22)
	_weapon_reward_title.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_weapon_reward_title)

	_weapon_reward_prompt = _make_hud_label("A / Enter: Select    B / Esc: Back    D-Pad / Arrows: Navigate    RS: Scroll")
	_weapon_reward_prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_weapon_reward_prompt.add_theme_font_size_override("font_size", 12)
	_weapon_reward_prompt.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_weapon_reward_prompt.custom_minimum_size = Vector2(1000, 46)
	layout.add_child(_weapon_reward_prompt)

	var body := HBoxContainer.new()
	body.add_theme_constant_override("separation", 12)
	layout.add_child(body)

	var detail_column := VBoxContainer.new()
	detail_column.custom_minimum_size = Vector2(404, 246)
	detail_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	detail_column.add_theme_constant_override("separation", 5)
	body.add_child(detail_column)

	var detail_title := _make_hud_label("NEW WEAPON")
	detail_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	detail_title.add_theme_font_size_override("font_size", 15)
	detail_title.add_theme_color_override("font_color", Color(0.0, 0.96, 1.0))
	detail_column.add_child(detail_title)

	var reward_preview_center := CenterContainer.new()
	reward_preview_center.custom_minimum_size = Vector2(404, 98)
	detail_column.add_child(reward_preview_center)
	_weapon_reward_preview_icon = _make_weapon_icon_control(Vector2(92, 92))
	reward_preview_center.add_child(_weapon_reward_preview_icon)

	_weapon_reward_detail_label = _make_hud_label("")
	_weapon_reward_detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_weapon_reward_detail_label.custom_minimum_size = Vector2(386, 150)
	_weapon_reward_detail_label.add_theme_font_size_override("font_size", 12)
	_weapon_reward_detail_scroll = _make_ui_scroll_area(Vector2(404, 104))
	_weapon_reward_detail_scroll.add_child(_weapon_reward_detail_label)
	detail_column.add_child(_weapon_reward_detail_scroll)

	var compare_column := VBoxContainer.new()
	compare_column.custom_minimum_size = Vector2(604, 246)
	compare_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	compare_column.add_theme_constant_override("separation", 5)
	body.add_child(compare_column)

	var compare_title := _make_hud_label("COMPARISON")
	compare_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	compare_title.add_theme_font_size_override("font_size", 15)
	compare_title.add_theme_color_override("font_color", Color(1.0, 0.08, 0.86))
	compare_column.add_child(compare_title)

	var reward_compare_icon_row := HBoxContainer.new()
	reward_compare_icon_row.alignment = BoxContainer.ALIGNMENT_CENTER
	reward_compare_icon_row.custom_minimum_size = Vector2(604, 84)
	reward_compare_icon_row.add_theme_constant_override("separation", 18)
	compare_column.add_child(reward_compare_icon_row)
	_weapon_reward_compare_current_icon = _make_weapon_icon_control(Vector2(78, 78))
	_weapon_reward_compare_candidate_icon = _make_weapon_icon_control(Vector2(78, 78))
	reward_compare_icon_row.add_child(_weapon_reward_compare_current_icon)
	reward_compare_icon_row.add_child(_weapon_reward_compare_candidate_icon)

	_weapon_reward_compare_label = _make_hud_label("")
	_weapon_reward_compare_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_weapon_reward_compare_label.custom_minimum_size = Vector2(586, 154)
	_weapon_reward_compare_label.add_theme_font_size_override("font_size", 12)
	_weapon_reward_compare_scroll = _make_ui_scroll_area(Vector2(604, 108))
	_weapon_reward_compare_scroll.add_child(_weapon_reward_compare_label)
	compare_column.add_child(_weapon_reward_compare_scroll)

	_weapon_reward_action_row = HBoxContainer.new()
	_weapon_reward_action_row.add_theme_constant_override("separation", 10)
	layout.add_child(_weapon_reward_action_row)
	_weapon_reward_action_buttons.clear()
	for i in range(4):
		var button := _make_weapon_reward_button(Vector2(246, 82), 12)
		button.name = "WeaponRewardAction%d" % i
		button.set_meta("reward_action_index", i)
		button.pressed.connect(func() -> void:
			_weapon_reward_action_selected_index = int(button.get_meta("reward_action_index"))
			_activate_weapon_reward_selection()
		)
		_weapon_reward_action_row.add_child(button)
		_weapon_reward_action_buttons.append(button)

	_weapon_reward_slot_grid = GridContainer.new()
	_weapon_reward_slot_grid.set("columns", 2)
	_weapon_reward_slot_grid.add_theme_constant_override("h_separation", 10)
	_weapon_reward_slot_grid.add_theme_constant_override("v_separation", 8)
	_weapon_reward_slot_scroll = _make_ui_scroll_area(Vector2(1010, 170))
	_weapon_reward_slot_scroll.add_child(_weapon_reward_slot_grid)
	layout.add_child(_weapon_reward_slot_scroll)
	_weapon_reward_slot_buttons.clear()
	_weapon_reward_slot_icons.clear()
	for i in range(EQUIPPED_WEAPON_SLOT_CAP):
		var button := _make_weapon_reward_button(Vector2(486, 78), 11, 88)
		var icon := _make_weapon_icon_control(Vector2(58, 58))
		icon.position = Vector2(14, 10)
		button.add_child(icon)
		button.name = "WeaponRewardSlot%d" % i
		button.set_meta("reward_slot_index", i)
		button.pressed.connect(func() -> void:
			_weapon_reward_slot_selected_index = int(button.get_meta("reward_slot_index"))
			_activate_weapon_reward_selection()
		)
		_weapon_reward_slot_grid.add_child(button)
		_weapon_reward_slot_buttons.append(button)
		_weapon_reward_slot_icons.append(icon)

	_weapon_reward_status_label = _make_hud_label("")
	_weapon_reward_status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_weapon_reward_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_weapon_reward_status_label.custom_minimum_size = Vector2(1000, 42)
	_weapon_reward_status_label.add_theme_font_size_override("font_size", 12)
	_weapon_reward_status_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
	layout.add_child(_weapon_reward_status_label)

	_weapon_reward_selection_cursor = NeonSelectionCursor.new()
	_weapon_reward_selection_cursor.name = "WeaponRewardShipCoreSelectionCursor"
	_weapon_reward_selection_cursor.size = Vector2(50, 32)
	_weapon_reward_selection_cursor.custom_minimum_size = Vector2(50, 32)
	_weapon_reward_selection_cursor.visible = false
	root.add_child(_weapon_reward_selection_cursor)


func _make_weapon_reward_button(minimum_size: Vector2, font_size: int, content_margin_left := 10) -> Button:
	var button := Button.new()
	button.custom_minimum_size = minimum_size
	button.set_meta("content_margin_left", content_margin_left)
	button.focus_mode = Control.FOCUS_ALL
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT if content_margin_left > 10 else HORIZONTAL_ALIGNMENT_CENTER
	button.add_theme_font_size_override("font_size", font_size)
	button.add_theme_color_override("font_color", Color(0.86, 1.0, 1.0))
	button.add_theme_color_override("font_focus_color", Color.WHITE)
	button.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.90))
	button.add_theme_constant_override("outline_size", 2)
	button.add_theme_stylebox_override("normal", _button_style(Color(0.0, 0.010, 0.032, 0.86), Color(0.0, 0.82, 1.0, 0.72), 1, content_margin_left))
	button.add_theme_stylebox_override("focus", _button_style(Color(0.030, 0.012, 0.044, 0.96), Color(1.0, 0.92, 0.06, 1.0), 3, content_margin_left))
	button.add_theme_stylebox_override("hover", _button_style(Color(0.018, 0.006, 0.038, 0.92), Color(1.0, 0.08, 0.88, 0.88), 2, content_margin_left))
	return button


func _button_style(fill_color: Color, border_color: Color, border_width: int, content_margin_left := 10) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill_color
	style.border_color = border_color
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width
	style.corner_radius_top_left = 0
	style.corner_radius_top_right = 8
	style.corner_radius_bottom_left = 8
	style.corner_radius_bottom_right = 0
	style.shadow_color = Color(border_color.r, border_color.g, border_color.b, 0.30)
	style.shadow_size = border_width * 5
	style.content_margin_left = content_margin_left
	style.content_margin_top = 7
	style.content_margin_right = 10
	style.content_margin_bottom = 7
	return style


func _make_hud_label(text: String) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 12)
	label.add_theme_color_override("font_color", Color(0.82, 0.96, 1.0))
	label.add_theme_color_override("font_shadow_color", Color(0.0, 0.84, 1.0, 0.60))
	label.add_theme_constant_override("shadow_offset_x", 0)
	label.add_theme_constant_override("shadow_offset_y", 0)
	label.add_theme_constant_override("outline_size", 1)
	label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.85))
	return label


func _make_bar(label_text: String, color: Color, max_value: float, minimum_size := Vector2(236, 12), accent := Color(0.0, 0.92, 1.0, 0.82)):
	var bar := NeonSegmentGauge.new()
	bar.configure(color, accent, max_value, minimum_size)
	bar.tooltip_text = label_text
	return bar


func _make_center_panel(text: String, include_summary := false) -> PanelContainer:
	var panel_rect := Rect2(620, 374, 680, 332) if include_summary else Rect2(660, 410, 600, 210)
	var panel := _make_frame(NeonFramePanel.FrameKind.COMMAND_PLATE, panel_rect, Color(0.0, 0.96, 1.0, 0.96), Color(1.0, 0.06, 0.86, 0.82), 28.0, 2.4, Vector4(34, 26, 34, 26))
	panel.animated = true

	var lines := text.split("\n")
	var title := str(lines[0]) if lines.size() > 0 else text
	var subtitle := str(lines[1]) if lines.size() > 1 else ""
	var prompt_a := str(lines[2]) if lines.size() > 2 else ""
	var prompt_b := str(lines[3]) if lines.size() > 3 else ""

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 9)
	panel.add_child(layout)

	var title_label := _make_hud_label(title)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 31)
	title_label.add_theme_color_override("font_color", Color(0.94, 1.0, 1.0))
	layout.add_child(title_label)

	if subtitle != "":
		var subtitle_label := _make_hud_label(subtitle)
		subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		subtitle_label.add_theme_font_size_override("font_size", 16)
		subtitle_label.add_theme_color_override("font_color", Color(1.0, 0.94, 0.18))
		layout.add_child(subtitle_label)

	if include_summary:
		var summary_label := _make_hud_label("")
		summary_label.name = "RunEconomySummaryLabel"
		summary_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		summary_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		summary_label.custom_minimum_size = Vector2(590, 86)
		summary_label.add_theme_font_size_override("font_size", 13)
		summary_label.add_theme_color_override("font_color", Color(0.82, 1.0, 1.0))
		layout.add_child(summary_label)

	var prompt_spacer := Control.new()
	prompt_spacer.custom_minimum_size = Vector2(1, 4 if include_summary else 10)
	layout.add_child(prompt_spacer)

	for prompt in [prompt_a, prompt_b]:
		if prompt == "":
			continue
		var prompt_label := _make_hud_label(prompt)
		prompt_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		prompt_label.add_theme_font_size_override("font_size", 13)
		prompt_label.add_theme_color_override("font_color", Color(0.82, 0.98, 1.0))
		layout.add_child(prompt_label)
	return panel


func _update_player(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down", InputMapConfig.MOVE_DEADZONE)
	var movement := Vector3(input_vector.x, 0.0, input_vector.y)
	if movement.length_squared() > 0.001:
		movement = movement.normalized()
	var target_velocity := movement * _current_player_speed()
	var acceleration := PLAYER_ACCELERATION if movement.length_squared() > 0.001 else PLAYER_DECELERATION
	_player_velocity = _player_velocity.move_toward(target_velocity, acceleration * delta)
	if _player_velocity.length_squared() > 0.0001:
		var new_position := _player_area.position + _player_velocity * delta
		new_position.x = clampf(new_position.x, -ARENA_HALF_SIZE + 1.0, ARENA_HALF_SIZE - 1.0)
		new_position.z = clampf(new_position.z, -ARENA_HALF_SIZE + 1.0, ARENA_HALF_SIZE - 1.0)
		_player_area.position = new_position
		if _player_velocity.length_squared() > 0.35:
			_player_area.rotation.y = _yaw_for_direction(_player_velocity.normalized())
	if is_instance_valid(_player_visual):
		var flash_scale := 1.0 + (0.22 if _player_invuln > 0.0 and int(_survival_time * 18.0) % 2 == 0 else 0.0)
		_player_visual.scale = Vector3.ONE * flash_scale
	_update_player_presentation_effects(delta)


func _current_player_speed() -> float:
	return PLAYER_SPEED + _speed_bonus


func _current_pickup_radius() -> float:
	return XP_ATTRACT_RADIUS + _pickup_radius_bonus + _core_pickup_radius_bonus


func _scaled_damage(base_damage: float) -> float:
	return base_damage * _damage_multiplier * _core_damage_multiplier


func _update_wave_director(delta: float) -> void:
	_update_wave_state()
	_wave_director_elite_cooldown = maxf(0.0, _wave_director_elite_cooldown - delta)
	var sector := _current_sector()
	if not _sector_boss_warning_played and not _sector_boss_spawned and _sector_elapsed >= float(sector["warning_time"]):
		_sector_boss_warning_played = true
		var boss_type := str(sector["boss_type"])
		if boss_type == "mini_boss":
			_mini_boss_warning_played = true
		elif _is_null_boss_type(boss_type):
			_null_octagon_warning_played = true
			_null_octagon_warning_start = _survival_time
		_set_music_state("boss")
		_show_combat_notice("FINAL BOSS WARNING // NULL OCTAGON PRIME // RUN COMPLETE ON DEFEAT" if _sector_index >= 3 else "BOSS WARNING // %s // DEFEAT TO CLEAR SECTOR" % _boss_name_for_type(boss_type), _boss_notice_color(boss_type), 1.85)
		_play_sfx("boss_warning", 0.40)
		_trigger_presentation_flash(Color(0.72, 0.96, 1.0) if _sector_index >= 3 else Color(1.0, 0.08, 0.86), 0.12 if _sector_index >= 3 else 0.10, 0.26 if _sector_index >= 3 else 0.24)
		_trigger_sector_background_reaction(0.86 if _sector_index >= 3 else 0.70, 0.90 if _sector_index >= 3 else 0.78)
		_add_screen_shake(0.070 if _sector_index >= 3 else 0.055, 0.18 if _sector_index >= 3 else 0.16)
	if not _sector_boss_spawned and _sector_elapsed >= float(sector["boss_time"]):
		_spawn_sector_boss()

	_spawn_timer -= delta
	var spawn_interval := _spawn_interval_for_wave()
	if _sector_boss_active:
		spawn_interval += 0.22
	if _enemies.size() >= ENEMY_CAP:
		return
	if _spawn_timer <= 0.0:
		_spawn_timer = spawn_interval
		var spawn_count := _spawn_count_for_wave()
		if _wave_index >= 4 and randf() < 0.16:
			spawn_count += 1
		for i in range(spawn_count):
			if _enemies.size() >= ENEMY_CAP:
				break
			var enemy_type := _enemy_type_for_current_wave()
			var elite_variant := _elite_variant_for_spawn(enemy_type)
			_spawn_enemy(enemy_type, _spawn_position_on_edge(), elite_variant)


func _update_wave_state() -> void:
	var sector := _current_sector()
	if _sector_boss_active:
		_wave_index = 4
		_wave_name = str(sector["boss_wave"])
	elif _sector_boss_spawned:
		_wave_index = 5
		_wave_name = "SECTOR CLEANUP"
	elif _sector_boss_warning_played or _sector_elapsed >= float(sector["warning_time"]):
		_wave_index = 3
		_wave_name = str(sector["warning_wave"])
	elif _sector_elapsed < float(sector["warning_time"]) * 0.38:
		_wave_index = 0
		_wave_name = str(sector["intro_wave"])
	elif _sector_elapsed < float(sector["warning_time"]) * 0.72:
		_wave_index = 1
		_wave_name = str(sector["pressure_wave"])
	else:
		_wave_index = 2
		_wave_name = str(sector["peak_wave"])


func _spawn_interval_for_wave() -> float:
	var profile: Array = _current_sector().get("spawn_profile", [0.90, 0.72, 0.66, 0.74, 1.0, 0.68])
	var interval := float(profile[clampi(_wave_index, 0, profile.size() - 1)])
	var intensity := _wave_director_intensity()
	interval *= 1.0 - intensity * 0.10
	if _wave_index == 0:
		interval += maxf(0.02, 0.14 - float(_sector_index) * 0.030)
	if _sector_boss_warning_played and not _sector_boss_spawned:
		interval *= 1.06
	return clampf(interval, 0.46, 1.24)


func _spawn_count_for_wave() -> int:
	var sector := _current_sector()
	var chances: Array = sector.get("spawn_extra_chance", [0.10, 0.24, 0.30, 0.28, 0.08, 0.24])
	var extra_chance := float(chances[clampi(_wave_index, 0, chances.size() - 1)])
	extra_chance += _wave_director_intensity() * 0.08
	var count := 1 + (1 if randf() < extra_chance else 0)
	var surge_extra_chance := float(sector.get("surge_extra_chance", 0.0))
	if _wave_index >= 2 and randf() < surge_extra_chance and not _sector_boss_active:
		count += 1
	if _sector_index >= 3 and _wave_index >= 2 and not _sector_boss_active and randf() < 0.10:
		count += 1
	if _sector_boss_active:
		count = maxi(1, count - 1)
	return clampi(count, 1, 4)


func _wave_director_intensity() -> float:
	var sector := _current_sector()
	var warning_time := maxf(1.0, float(sector.get("warning_time", 60.0)))
	var time_ramp := clampf(_sector_elapsed / warning_time, 0.0, 1.0)
	var wave_boosts := [0.0, 0.14, 0.26, 0.18, 0.06, 0.20]
	var wave_boost := float(wave_boosts[clampi(_wave_index, 0, wave_boosts.size() - 1)])
	var sector_boost := float(_sector_index) * 0.075
	if _sector_boss_active:
		sector_boost *= 0.45
	return clampf(time_ramp * 0.66 + wave_boost + sector_boost, 0.0, 1.0)


func _enemy_type_for_current_wave() -> String:
	return _enemy_type_for_sector_phase(_sector_index, _wave_index)


func _enemy_type_for_time(time: float) -> String:
	var phase := 0
	if time > 42.0:
		phase = 2
	elif time > 18.0:
		phase = 1
	return _enemy_type_for_sector_phase(0, phase)


func _enemy_type_for_sector_phase(sector: int, phase: int) -> String:
	var phase_index := clampi(phase, 0, 5)
	var sector_data := _sector_data(sector)
	var mixes: Array = sector_data.get("enemy_mixes", [])
	var mix: Array = mixes[clampi(phase_index, 0, mixes.size() - 1)] if not mixes.is_empty() else [{"type": "chaser", "weight": 1.0}]
	return _pick_weighted_enemy(mix)


func _pick_weighted_enemy(mix: Array) -> String:
	var total_weight := 0.0
	for entry in mix:
		total_weight += float(entry["weight"])
	if total_weight <= 0.0:
		return "chaser"
	var roll := randf() * total_weight
	var cursor := 0.0
	for entry in mix:
		cursor += float(entry["weight"])
		if roll <= cursor:
			return str(entry["type"])
	return str(mix.back()["type"]) if not mix.is_empty() else "chaser"


func _elite_variant_for_spawn(enemy_type: String) -> String:
	if not _can_spawn_elite(enemy_type):
		return ""
	var chances: Array = WAVE_DIRECTOR_ELITE_CHANCES[clampi(_sector_index, 0, WAVE_DIRECTOR_ELITE_CHANCES.size() - 1)]
	var chance := float(chances[clampi(_wave_index, 0, chances.size() - 1)])
	chance *= 0.75 + _wave_director_intensity() * 0.65
	if randf() > chance:
		return ""
	var pool := _elite_variant_pool(enemy_type)
	if pool.is_empty():
		return ""
	var variant := _pick_weighted_elite_variant(pool)
	if variant != "":
		_wave_director_elite_cooldown = float(WAVE_DIRECTOR_ELITE_COOLDOWN[clampi(_sector_index, 0, WAVE_DIRECTOR_ELITE_COOLDOWN.size() - 1)])
	return variant


func _can_spawn_elite(enemy_type: String) -> bool:
	if _is_boss_type(enemy_type) or enemy_type == "triad_fragment" or enemy_type == "grid_fragment":
		return false
	if _sector_boss_active:
		return false
	if _wave_index <= 0:
		return false
	if _sector_elapsed < float(WAVE_DIRECTOR_ELITE_MIN_TIME[clampi(_sector_index, 0, WAVE_DIRECTOR_ELITE_MIN_TIME.size() - 1)]):
		return false
	if _wave_director_elite_cooldown > 0.0:
		return false
	return _active_elite_count() < int(WAVE_DIRECTOR_MAX_ELITES[clampi(_sector_index, 0, WAVE_DIRECTOR_MAX_ELITES.size() - 1)])


func _elite_variant_pool(enemy_type: String) -> Array[Dictionary]:
	if _sector_index >= 3:
		match enemy_type:
			"rail_skimmer":
				return [
					{"variant": "hypercharged", "weight": 0.54},
					{"variant": "rail_armored", "weight": 0.30},
					{"variant": "volatile", "weight": 0.16}
				]
			"grid_splitter":
				return [
					{"variant": "overclocked_splitter", "weight": 0.48},
					{"variant": "rail_armored", "weight": 0.24},
					{"variant": "shielded", "weight": 0.16},
					{"variant": "volatile", "weight": 0.12}
				]
			"hex_slicer", "spiral_drifter", "hex_pulser":
				return [
					{"variant": "hypercharged", "weight": 0.38},
					{"variant": "rail_armored", "weight": 0.24},
					{"variant": "overcharged", "weight": 0.18},
					{"variant": "volatile", "weight": 0.12},
					{"variant": "shielded", "weight": 0.08}
				]
	match enemy_type:
		"triad_splitter":
			return [
				{"variant": "splitter_elite", "weight": 0.46},
				{"variant": "overcharged", "weight": 0.26},
				{"variant": "volatile", "weight": 0.18},
				{"variant": "armored", "weight": 0.10}
			]
		"shield_node":
			return [
				{"variant": "shielded", "weight": 0.54},
				{"variant": "armored", "weight": 0.30},
				{"variant": "overcharged", "weight": 0.16}
			]
		"hex_pulser":
			return [
				{"variant": "shielded", "weight": 0.36},
				{"variant": "volatile", "weight": 0.34},
				{"variant": "overcharged", "weight": 0.30}
			]
		"tank":
			return [
				{"variant": "armored", "weight": 0.60},
				{"variant": "shielded", "weight": 0.24},
				{"variant": "volatile", "weight": 0.16}
			]
		"exploder":
			return [
				{"variant": "volatile", "weight": 0.64},
				{"variant": "overcharged", "weight": 0.36}
			]
		_:
			return [
				{"variant": "overcharged", "weight": 0.42},
				{"variant": "armored", "weight": 0.26},
				{"variant": "volatile", "weight": 0.18},
				{"variant": "shielded", "weight": 0.14}
			]


func _pick_weighted_elite_variant(pool: Array[Dictionary]) -> String:
	var total_weight := 0.0
	for entry in pool:
		total_weight += float(entry.get("weight", 0.0))
	if total_weight <= 0.0:
		return ""
	var roll := randf() * total_weight
	var cursor := 0.0
	for entry in pool:
		cursor += float(entry.get("weight", 0.0))
		if roll <= cursor:
			return str(entry.get("variant", ""))
	return str(pool.back().get("variant", "")) if not pool.is_empty() else ""


func _active_elite_count() -> int:
	var count := 0
	for enemy in _enemies:
		if str(enemy.get("elite_variant", "")) != "":
			count += 1
	return count


func _update_run_event_director(delta: float) -> void:
	if not _run_event_gameplay_allowed():
		return
	if _run_event_blocked_by_boss():
		if _run_event_active:
			_finish_run_event(false, "OBJECTIVE CLEARED // BOSS PRIORITY", false)
		return
	if _run_event_active:
		_update_active_run_event(delta)
		return
	_run_event_cooldown = maxf(0.0, _run_event_cooldown - delta)
	if _can_start_run_event():
		_start_run_event(_pick_run_event_type())


func _run_event_gameplay_allowed() -> bool:
	if _title_menu_active or get_tree().paused or _game_over or _run_success:
		return false
	if _level_up_active or _sector_reward_active or _weapon_reward_decision_active:
		return false
	return true


func _run_event_blocked_by_boss() -> bool:
	var sector := _current_sector()
	var boss_time := float(sector.get("boss_time", 90.0))
	if _sector_boss_active or _sector_boss_spawned or _sector_boss_warning_played:
		return true
	return boss_time - _sector_elapsed <= RUN_EVENT_BOSS_BUFFER


func _can_start_run_event() -> bool:
	if _run_event_active or _run_event_cooldown > 0.0:
		return false
	var sector_index := clampi(_sector_index, 0, RUN_EVENT_START_DELAY.size() - 1)
	if _sector_elapsed < float(RUN_EVENT_START_DELAY[sector_index]):
		return false
	if _run_event_sector_count >= int(RUN_EVENT_MAX_PER_SECTOR[sector_index]):
		return false
	if _run_event_blocked_by_boss():
		return false
	return true


func _run_event_display_name(event_type: String) -> String:
	match event_type:
		"data_cache":
			return "Data Cache"
		"rift_surge":
			return "Rift Surge"
		"elite_hunt":
			return "Elite Hunt"
		"overload_shrine":
			return "Overload Node"
		_:
			return "Objective"


func _run_event_notice_color(event_type: String) -> Color:
	match event_type:
		"data_cache":
			return Color(0.0, 0.96, 1.0)
		"rift_surge":
			return Color(1.0, 0.08, 0.86)
		"elite_hunt":
			return Color(1.0, 0.58, 0.04)
		"overload_shrine":
			return Color(1.0, 0.72, 0.10)
		_:
			return Color(1.0, 0.94, 0.18)


func _pick_run_event_type() -> String:
	var pool: Array[Dictionary] = []
	match _sector_index:
		0:
			pool = [
				{"type": "data_cache", "weight": 0.58},
				{"type": "elite_hunt", "weight": 0.30},
				{"type": "overload_shrine", "weight": 0.12}
			]
		1:
			pool = [
				{"type": "data_cache", "weight": 0.30},
				{"type": "rift_surge", "weight": 0.28},
				{"type": "elite_hunt", "weight": 0.24},
				{"type": "overload_shrine", "weight": 0.18}
			]
		2:
			pool = [
				{"type": "data_cache", "weight": 0.20},
				{"type": "rift_surge", "weight": 0.32},
				{"type": "elite_hunt", "weight": 0.22},
				{"type": "overload_shrine", "weight": 0.26}
			]
		_:
			pool = [
				{"type": "data_cache", "weight": 0.16},
				{"type": "rift_surge", "weight": 0.36},
				{"type": "elite_hunt", "weight": 0.20},
				{"type": "overload_shrine", "weight": 0.28}
			]
	if _enemies.size() >= ENEMY_CAP - 2:
		pool = pool.filter(func(entry: Dictionary) -> bool:
			return str(entry.get("type", "")) != "elite_hunt"
		)
	if pool.is_empty():
		return "data_cache"
	var total := 0.0
	for entry in pool:
		total += float(entry.get("weight", 0.0))
	var roll := _run_event_rng.randf() * maxf(0.001, total)
	var cursor := 0.0
	for entry in pool:
		cursor += float(entry.get("weight", 0.0))
		if roll <= cursor:
			return str(entry.get("type", "data_cache"))
	return str(pool.back().get("type", "data_cache"))


func _start_run_event(event_type: String) -> void:
	if _run_event_active:
		return
	_run_event_active = true
	_run_event_type = event_type
	_run_event_stage = "active"
	_run_event_progress = 0.0
	_run_event_notice_step = -1
	_run_event_spawn_timer = 0.0
	_run_event_hazard_timer = 0.0
	_run_event_sector_count += 1
	_run_event_node = null
	_run_event_target_node = null
	_run_event_target_instance_id = 0
	match event_type:
		"data_cache":
			_run_event_duration = RUN_EVENT_CACHE_DURATION
			_run_event_timer = _run_event_duration
			_run_event_stage = "sync"
			_run_event_spawn_timer = 1.35 if _sector_index >= 3 else 0.0
			_run_event_node = _create_run_event_marker("data_cache", _run_event_spawn_position())
			_show_combat_notice("HYPER DATA CACHE // STAND INSIDE THE RING TO SYNC" if _sector_index >= 3 else "DATA CACHE FOUND // STAND INSIDE THE RING TO SYNC", _run_event_notice_color("data_cache"), 1.95)
		"rift_surge":
			_run_event_duration = RUN_EVENT_RIFT_DURATION
			_run_event_timer = _run_event_duration
			_run_event_stage = "warning"
			_run_event_node = _create_run_event_marker("rift_surge", _run_event_spawn_position())
			_show_combat_notice("RIFT SURGE WARNING // LEAVE THE RED RIFT ZONE", _run_event_notice_color("rift_surge"), 2.05)
			_play_sfx("warning", 0.12)
		"elite_hunt":
			_run_event_duration = RUN_EVENT_ELITE_HUNT_DURATION
			_run_event_timer = _run_event_duration
			_run_event_stage = "hunt"
			_spawn_run_event_elite_target()
		"overload_shrine":
			_run_event_duration = RUN_EVENT_SHRINE_ARM_DURATION
			_run_event_timer = _run_event_duration
			_run_event_stage = "armed"
			_run_event_node = _create_run_event_marker("overload_shrine", _run_event_spawn_position())
			_show_combat_notice("OVERLOAD NODE // OPTIONAL: ENTER RING TO START CHALLENGE", _run_event_notice_color("overload_shrine"), 2.10)
		_:
			_run_event_type = "data_cache"
			_run_event_duration = RUN_EVENT_CACHE_DURATION
			_run_event_timer = _run_event_duration
			_run_event_stage = "sync"
			_run_event_node = _create_run_event_marker("data_cache", _run_event_spawn_position())
	_trigger_sector_background_reaction(0.30, 0.34)


func _update_active_run_event(delta: float) -> void:
	_run_event_timer = maxf(0.0, _run_event_timer - delta)
	_update_run_event_marker_animation(delta)
	match _run_event_type:
		"data_cache":
			_update_data_cache_event(delta)
		"rift_surge":
			_update_rift_surge_event(delta)
		"elite_hunt":
			_update_elite_hunt_event(delta)
		"overload_shrine":
			_update_overload_shrine_event(delta)
		_:
			_finish_run_event(false, "OBJECTIVE ERROR // EVENT CLEARED", false)


func _update_data_cache_event(delta: float) -> void:
	if not is_instance_valid(_run_event_node):
		_finish_run_event(false, "DATA CACHE LOST", false)
		return
	var near_cache := _xz_distance(_player_area.position, _run_event_node.position) <= RUN_EVENT_INTERACTION_RADIUS
	var required_hold := _data_cache_required_hold_time()
	if near_cache:
		_run_event_progress = minf(required_hold, _run_event_progress + delta)
	else:
		_run_event_progress = maxf(0.0, _run_event_progress - delta * 0.38)
	if _sector_index >= 3:
		_run_event_spawn_timer -= delta
		if _run_event_spawn_timer <= 0.0 and _enemies.size() < ENEMY_CAP - 2:
			_run_event_spawn_timer = 2.45
			_spawn_enemy(_hyper_grid_pressure_enemy_type(), _spawn_position_on_edge())
	_show_run_event_progress_notice("HYPER CACHE SYNCING" if _sector_index >= 3 else "DATA CACHE SYNCING", _run_event_progress / required_hold, _run_event_notice_color("data_cache"))
	if _run_event_progress >= required_hold:
		_finish_run_event(true, "DATA CACHE SECURED", true)
	elif _run_event_timer <= 0.0:
		_finish_run_event(false, "DATA CACHE FAILED // RETURN TO CACHE RING NEXT TIME", false)


func _update_rift_surge_event(delta: float) -> void:
	if not is_instance_valid(_run_event_node):
		_finish_run_event(false, "RIFT SURGE COLLAPSED", false)
		return
	var elapsed := RUN_EVENT_RIFT_DURATION - _run_event_timer
	if _run_event_stage == "warning":
		var countdown := maxf(0.0, RUN_EVENT_RIFT_WARNING_TIME - elapsed)
		_show_combat_notice("RIFT SURGE WARNING // %.1f SEC" % countdown, _run_event_notice_color("rift_surge"), 0.34)
	if _run_event_stage == "warning" and elapsed >= RUN_EVENT_RIFT_WARNING_TIME:
		_run_event_stage = "surge"
		_run_event_hazard_timer = 0.0
		_run_event_spawn_timer = 1.0
		_show_combat_notice("RIFT SURGE ACTIVE // DODGE THE PULSES", _run_event_notice_color("rift_surge"), 1.45)
	if _run_event_stage == "surge":
		_run_event_hazard_timer -= delta
		if _run_event_hazard_timer <= 0.0:
			_run_event_hazard_timer = clampf(1.85 - float(_sector_index) * 0.18 - (0.12 if _sector_index >= 3 else 0.0), 1.05, 1.85)
			var offset := Vector3(_run_event_rng.randf_range(-5.2, 5.2), 0.0, _run_event_rng.randf_range(-5.2, 5.2))
			var target := _clamp_to_arena(_player_area.position + offset, 2.8)
			_spawn_pressure_hazard(target, 1.75 + float(_sector_index) * 0.16 + (0.12 if _sector_index >= 3 else 0.0), 1.35, "hazard_pulse", 7.0 + float(_sector_index) * 1.2, 0.42, "run_event")
		_run_event_spawn_timer -= delta
		if _run_event_spawn_timer <= 0.0 and _enemies.size() < ENEMY_CAP - 1:
			_run_event_spawn_timer = clampf(3.1 - float(_sector_index) * 0.25 - (0.18 if _sector_index >= 3 else 0.0), 2.0, 3.1)
			var spawn_type := _hyper_grid_pressure_enemy_type() if _sector_index >= 3 else _enemy_type_for_sector_phase(_sector_index, maxi(1, _wave_index))
			_spawn_enemy(spawn_type, _spawn_position_on_edge())
	if _run_event_timer <= 0.0:
		_finish_run_event(true, "RIFT SURGE SURVIVED", true)


func _update_elite_hunt_event(delta: float) -> void:
	if not is_instance_valid(_run_event_target_node):
		_finish_run_event(false, "ELITE HUNT FAILED // TARGET LOST", false)
		return
	if _run_event_timer <= 0.0:
		_demote_run_event_target()
		_finish_run_event(false, "ELITE ESCAPED", false)
		return
	if _run_event_timer <= 8.0:
		_show_run_event_progress_notice("ELITE HUNT TIMER", 1.0 - _run_event_timer / 8.0, _run_event_notice_color("elite_hunt"))


func _update_overload_shrine_event(delta: float) -> void:
	if not is_instance_valid(_run_event_node):
		_finish_run_event(false, "POWER NODE LOST", false)
		return
	if _run_event_stage == "armed":
		var near_node := _xz_distance(_player_area.position, _run_event_node.position) <= RUN_EVENT_INTERACTION_RADIUS
		if near_node:
			_run_event_progress = minf(RUN_EVENT_SHRINE_TRIGGER_TIME, _run_event_progress + delta)
		else:
			_run_event_progress = maxf(0.0, _run_event_progress - delta * 0.45)
		_show_run_event_progress_notice("OVERLOAD NODE APPROACH", _run_event_progress / RUN_EVENT_SHRINE_TRIGGER_TIME, _run_event_notice_color("overload_shrine"))
		if _run_event_progress >= RUN_EVENT_SHRINE_TRIGGER_TIME:
			_run_event_stage = "overload"
			_run_event_timer = RUN_EVENT_SHRINE_OVERLOAD_DURATION
			_run_event_hazard_timer = 0.0
			_run_event_spawn_timer = 0.65
			_show_combat_notice("OVERLOAD STARTED // SURVIVE UNTIL THE NODE DISCHARGES", _run_event_notice_color("overload_shrine"), 1.65)
			_spawn_burst(_run_event_node.position, 1.24, "burst_gold")
			_play_sfx("sector", 0.16)
		elif _run_event_timer <= 0.0:
			_finish_run_event(false, "OVERLOAD ENDED", false)
	elif _run_event_stage == "overload":
		_run_event_hazard_timer -= delta
		if _run_event_hazard_timer <= 0.0:
			_run_event_hazard_timer = clampf(2.05 - float(_sector_index) * 0.18 - (0.16 if _sector_index >= 3 else 0.0), 1.18, 2.05)
			var angle := _run_event_rng.randf() * TAU
			var target := _clamp_to_arena(_run_event_node.position + Vector3(cos(angle), 0.0, sin(angle)) * _run_event_rng.randf_range(2.2, 6.2), 2.8)
			_spawn_pressure_hazard(target, 1.48 + float(_sector_index) * 0.12 + (0.10 if _sector_index >= 3 else 0.0), 1.25, "hazard_leech", 6.0 + float(_sector_index), 0.38, "run_event")
		_run_event_spawn_timer -= delta
		if _run_event_spawn_timer <= 0.0 and _enemies.size() < ENEMY_CAP - 1:
			_run_event_spawn_timer = clampf(3.25 - float(_sector_index) * 0.24 - (0.18 if _sector_index >= 3 else 0.0), 2.10, 3.25)
			var overload_spawn_type := _hyper_grid_pressure_enemy_type() if _sector_index >= 3 else _enemy_type_for_sector_phase(_sector_index, maxi(1, _wave_index))
			_spawn_enemy(overload_spawn_type, _spawn_position_on_edge())
		if _run_event_timer <= 0.0:
			_finish_run_event(true, "POWER NODE STABILIZED", true)


func _show_run_event_progress_notice(label: String, progress: float, color: Color) -> void:
	var step := clampi(int(floor(clampf(progress, 0.0, 1.0) * 4.0)), 0, 4)
	if step <= 0 or step == _run_event_notice_step:
		return
	_run_event_notice_step = step
	_show_combat_notice("%s %d%%" % [label, step * 25], color, 0.78)


func _spawn_run_event_elite_target() -> void:
	if _enemies.size() >= ENEMY_CAP - 1:
		_finish_run_event(false, "ELITE HUNT BLOCKED // HOSTILE CAP", false)
		return
	var enemy_type := _run_event_elite_type_for_sector()
	var elite_variant := _run_event_elite_variant_for_sector(enemy_type)
	var enemy_index := _spawn_enemy(enemy_type, _spawn_position_on_edge(), elite_variant)
	if enemy_index < 0:
		_finish_run_event(false, "ELITE HUNT BLOCKED // SPAWN FAILED", false)
		return
	_run_event_target_instance_id += 1
	var enemy := _enemies[enemy_index]
	enemy["run_event_target"] = true
	enemy["run_event_target_id"] = _run_event_target_instance_id
	enemy["run_event_target_marker"] = _apply_run_event_target_marker(enemy)
	_enemies[enemy_index] = enemy
	_run_event_target_node = enemy.get("node", null)
	_show_combat_notice("ELITE HUNT // DESTROY THE MARKED TARGET", _run_event_notice_color("elite_hunt"), 1.70)
	_play_sfx("warning", 0.12)


func _hyper_grid_pressure_enemy_type() -> String:
	var roll := _run_event_rng.randf()
	if roll < 0.48:
		return "rail_skimmer"
	if roll < 0.78:
		return "grid_splitter"
	return "hex_slicer"


func _run_event_elite_type_for_sector() -> String:
	match _sector_index:
		0:
			return "chaser"
		1:
			return "triad_splitter" if _run_event_rng.randf() < 0.45 else "hex_slicer"
		2:
			return "shield_node" if _run_event_rng.randf() < 0.55 else "hex_pulser"
		_:
			return "rail_skimmer" if _run_event_rng.randf() < 0.58 else "grid_splitter"


func _run_event_elite_variant_for_sector(enemy_type: String) -> String:
	var pool := _elite_variant_pool(enemy_type)
	if pool.is_empty():
		return "overcharged"
	return _pick_weighted_elite_variant(pool)


func _apply_run_event_target_marker(enemy: Dictionary) -> Node3D:
	var visual: Node3D = enemy.get("visual", null)
	if not is_instance_valid(visual):
		return null
	var marker := Node3D.new()
	marker.name = "RunEventEliteHuntTargetMarker"
	visual.add_child(marker)
	var ring := Kit.add_mesh(marker, "EliteHuntGoldTargetRing", Kit.torus_mesh(1.34, 0.052, 56, 5), _materials["event_elite_hunt"])
	ring.rotation.x = PI * 0.5
	var vertical := Kit.add_mesh(marker, "EliteHuntVerticalTargetRing", Kit.torus_mesh(1.02, 0.032, 40, 4), _materials["event_elite_hunt"])
	vertical.rotation.z = PI * 0.5
	var core := Kit.add_mesh(marker, "EliteHuntWhiteHotCoreDot", Kit.sphere_mesh(0.14, 10, 5), _materials["burst_hot_core"], Vector3(0.0, 0.68, 0.0))
	core.scale = Vector3(1.0, 0.40, 1.0)
	_add_run_event_label(marker, "ELITE HUNT", _run_event_notice_color("elite_hunt"), 1.58)
	return marker


func _handle_run_event_target_enemy_killed(enemy: Dictionary, position: Vector3) -> void:
	if not _run_event_active or _run_event_type != "elite_hunt":
		return
	if not bool(enemy.get("run_event_target", false)):
		return
	_show_combat_notice("ELITE HUNT // TARGET DOWN", _run_event_notice_color("elite_hunt"), 0.80)
	_finish_run_event(true, "ELITE HUNT COMPLETE", true, position)


func _add_run_event_label(parent: Node3D, text: String, color: Color, height := 1.42) -> Label3D:
	var label := Kit.add_label(parent, text, Vector3(0.0, height, 0.0))
	label.font_size = 32
	label.pixel_size = 0.026
	label.modulate = color
	label.outline_size = 10
	label.outline_modulate = Color(0.0, 0.02, 0.06, 0.96)
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	return label


func _create_run_event_marker(event_type: String, position: Vector3) -> Node3D:
	var root := Node3D.new()
	root.name = "RunObjective%sMarker3D" % event_type.capitalize()
	root.position = Vector3(position.x, 0.82, position.z)
	_fx_root.add_child(root)
	match event_type:
		"data_cache":
			Kit.add_mesh(root, "DataCacheTerminalLowDarkBody", Kit.box_mesh(Vector3(2.05, 0.62, 1.35)), _materials["event_cache_body"], Vector3(0.0, -0.10, 0.0))
			Kit.add_mesh(root, "DataCacheSlantedCyanCircuitPanelA", Kit.box_mesh(Vector3(1.56, 0.08, 0.12)), _materials["event_cache_edge"], Vector3(0.0, 0.29, -0.70))
			Kit.add_mesh(root, "DataCacheSlantedCyanCircuitPanelB", Kit.box_mesh(Vector3(1.56, 0.08, 0.12)), _materials["event_cache_edge"], Vector3(0.0, 0.29, 0.70))
			Kit.add_glowing_edges(root, "DataCacheTerminal", Kit.box_points(Vector3(2.12, 0.68, 1.42)), Kit.box_edges(), 0.030, 0.012, _materials["event_cache_edge"], _materials["burst_hot_core"])
			var capture_ring := Kit.add_mesh(root, "DataCacheCaptureSyncFloorRing", Kit.torus_mesh(RUN_EVENT_INTERACTION_RADIUS, 0.034, 72, 5), _materials["event_cache_edge"], Vector3(0.0, -0.68, 0.0))
			capture_ring.rotation.x = PI * 0.5
			Kit.tube_between(root, "DataCacheVerticalDataBeam", Vector3(0.0, 0.38, 0.0), Vector3(0.0, 3.10, 0.0), 0.060, _materials["event_cache_edge"], 10)
			Kit.add_mesh(root, "DataCacheGoldCore", Kit.sphere_mesh(0.32, 14, 7), _materials["event_cache_core"], Vector3(0.0, 0.35, 0.0))
			for i in range(4):
				var angle := TAU * float(i) / 4.0 + PI * 0.25
				var segment := Kit.add_mesh(root, "DataCacheProgressSegment%d" % i, Kit.box_mesh(Vector3(0.80, 0.10, 0.10)), _materials["event_cache_core"], Vector3(cos(angle) * 1.42, 0.56, sin(angle) * 1.42))
				segment.rotation.y = -angle
				segment.visible = false
			_add_run_event_label(root, "DATA CACHE\nSTAND IN RING", _run_event_notice_color("data_cache"), 3.28)
		"rift_surge":
			var outer := Kit.add_mesh(root, "RiftSurgeRedDangerFloorZone", Kit.torus_mesh(3.62, 0.078, 80, 5), _materials["event_rift_warning"], Vector3(0.0, -0.68, 0.0))
			outer.rotation.x = PI * 0.5
			var warning := Kit.add_mesh(root, "RiftSurgeWarningZoneRing", Kit.torus_mesh(2.35, 0.040, 54, 4), _materials["event_rift"], Vector3(0.0, -0.66, 0.0))
			warning.rotation.x = PI * 0.5
			var inner := Kit.add_mesh(root, "RiftSurgeInnerPrismRing", Kit.torus_mesh(1.48, 0.048, 6, 4), _materials["event_rift_core"])
			inner.rotation.x = PI * 0.5
			for i in range(12):
				var stripe_angle := TAU * float(i) / 12.0
				var start := Vector3(cos(stripe_angle) * 2.15, -0.62, sin(stripe_angle) * 2.15)
				var end := Vector3(cos(stripe_angle) * 3.45, -0.62, sin(stripe_angle) * 3.45)
				Kit.tube_between(root, "RiftSurgeDangerStripe%d" % i, start, end, 0.034, _materials["event_rift_warning"], 8)
			var tear_points := [
				Vector3(-0.34, -0.10, 0.0),
				Vector3(0.28, 0.56, 0.0),
				Vector3(-0.20, 1.16, 0.0),
				Vector3(0.36, 1.92, 0.0),
				Vector3(-0.14, 2.70, 0.0)
			]
			for i in range(tear_points.size() - 1):
				Kit.tube_between(root, "RiftSurgeCrackedPortalTear%d" % i, tear_points[i], tear_points[i + 1], 0.060, _materials["event_rift"], 9)
			Kit.add_mesh(root, "RiftSurgeDarkCrackedAnchor", Kit.octahedron_mesh(0.76), _materials["sector2_dark_glass"], Vector3(0.0, 0.54, 0.0))
			_add_run_event_label(root, "RIFT SURGE\nLEAVE RED ZONE", _run_event_notice_color("rift_surge"), 3.18)
		"overload_shrine":
			Kit.add_mesh(root, "OverloadNodeTallDarkPowerPylon", Kit.hex_prism_mesh(0.72, 2.15), _materials["event_shrine_body"], Vector3(0.0, 0.58, 0.0))
			Kit.add_glowing_edges(root, "OverloadNodePylon", Kit.hex_prism_points(0.76, 2.20), Kit.hex_prism_edges(), 0.034, 0.014, _materials["event_shrine_edge"], _materials["burst_hot_core"])
			Kit.add_mesh(root, "OverloadNodeWhiteGoldCore", Kit.sphere_mesh(0.42, 18, 8), _materials["event_shrine_core"], Vector3(0.0, 0.84, 0.0))
			var shrine_ring := Kit.add_mesh(root, "OverloadNodeHexActivationRing", Kit.torus_mesh(1.78, 0.060, 6, 5), _materials["event_shrine_edge"], Vector3(0.0, -0.66, 0.0))
			shrine_ring.rotation.x = PI * 0.5
			var proximity := Kit.add_mesh(root, "OverloadNodeOptionalChallengeRadius", Kit.torus_mesh(RUN_EVENT_INTERACTION_RADIUS, 0.034, 72, 4), _materials["event_shrine_core"], Vector3(0.0, -0.68, 0.0))
			proximity.rotation.x = PI * 0.5
			for i in range(6):
				var angle := TAU * float(i) / 6.0 + PI / 6.0
				Kit.tube_between(root, "OverloadNodePowerConduit%d" % i, Vector3(cos(angle) * 0.72, -0.10, sin(angle) * 0.72), Vector3(cos(angle) * 1.74, -0.54, sin(angle) * 1.74), 0.030, _materials["event_shrine_edge"], 8)
			_add_run_event_label(root, "OVERLOAD NODE\nOPTIONAL CHALLENGE", _run_event_notice_color("overload_shrine"), 3.20)
		_:
			Kit.add_mesh(root, "RunEventFallbackCore", Kit.sphere_mesh(0.36, 12, 6), _materials["event_cache_edge"])
	return root


func _update_run_event_marker_animation(delta: float) -> void:
	if is_instance_valid(_run_event_node):
		var pulse := 1.0 + sin(_survival_time * 5.0) * 0.035
		match _run_event_type:
			"data_cache":
				_run_event_node.scale = Vector3.ONE * pulse
				var filled_segments := clampi(int(ceil(clampf(_run_event_progress / _data_cache_required_hold_time(), 0.0, 1.0) * 4.0)), 0, 4)
				for i in range(4):
					var segment := _run_event_node.get_node_or_null("DataCacheProgressSegment%d" % i) as MeshInstance3D
					if is_instance_valid(segment):
						segment.visible = i < filled_segments
						segment.scale = Vector3.ONE * (1.0 + sin(_survival_time * 7.0 + float(i)) * 0.05)
			"rift_surge":
				_run_event_node.scale = Vector3.ONE * (1.0 + sin(_survival_time * 8.0) * (0.045 if _run_event_stage == "warning" else 0.075))
				var danger_strength := 0.45 if _run_event_stage == "warning" else 1.0
				for child in _run_event_node.get_children():
					if str(child.name).begins_with("RiftSurgeDangerStripe"):
						child.visible = sin(_survival_time * 9.0 + float(child.get_index())) > -0.25
						child.scale = Vector3.ONE * (0.90 + danger_strength * 0.16)
			"overload_shrine":
				var pressure := clampf(_run_event_progress / RUN_EVENT_SHRINE_TRIGGER_TIME, 0.0, 1.0) if _run_event_stage == "armed" else 1.0
				_run_event_node.scale = Vector3.ONE * (1.0 + pressure * 0.08 + sin(_survival_time * 6.5) * 0.025)
			_:
				_run_event_node.scale = Vector3.ONE * pulse
	if is_instance_valid(_run_event_target_node):
		var target_marker := _run_event_target_marker_node()
		if is_instance_valid(target_marker):
			target_marker.rotation.y += delta * 2.4
			target_marker.scale = Vector3.ONE * (1.0 + sin(_survival_time * 8.0) * 0.045)


func _run_event_target_marker_node() -> Node3D:
	for enemy in _enemies:
		if bool(enemy.get("run_event_target", false)):
			var marker: Node3D = enemy.get("run_event_target_marker", null)
			if is_instance_valid(marker):
				return marker
	return null


func _finish_run_event(success: bool, message: String, grant_reward: bool, reward_position := RUN_EVENT_AUTO_REWARD_POSITION) -> void:
	if not _run_event_active:
		return
	var event_type := _run_event_type
	var position := reward_position
	if position == RUN_EVENT_AUTO_REWARD_POSITION:
		if is_instance_valid(_run_event_node):
			position = _run_event_node.position
		elif is_instance_valid(_run_event_target_node):
			position = _run_event_target_node.position
		else:
			position = _player_area.position
	if success and grant_reward:
		_grant_run_event_reward(event_type, position)
	else:
		_show_combat_notice(message, Color(0.82, 0.96, 1.0), 1.15)
	_clear_run_event_state()
	_run_event_cooldown = _run_event_cooldown_for_sector()


func _grant_run_event_reward(event_type: String, position: Vector3, force_dust := false) -> Dictionary:
	var sector_bonus := _sector_index
	var xp_orbs := 5 + sector_bonus
	var score_bonus := 220 + sector_bonus * 80
	var dust_chance := 0.12 + float(sector_bonus) * 0.035
	var dust_amount := 3 + sector_bonus * 2
	var reward_label := "OBJECTIVE COMPLETE"
	match event_type:
		"data_cache":
			xp_orbs += 2
			score_bonus += 80
			dust_chance += 0.03
			reward_label = "CACHE COMPLETE: XP + SCORE"
		"rift_surge":
			xp_orbs += 3
			score_bonus += 130
			dust_chance += 0.06
			reward_label = "RIFT SURGE SURVIVED: BONUS XP"
		"elite_hunt":
			xp_orbs += 4
			score_bonus += 180
			dust_chance += 0.07
			reward_label = "ELITE DESTROYED: BONUS REWARD"
		"overload_shrine":
			xp_orbs += 5
			score_bonus += 210
			dust_chance += 0.08
			reward_label = "OVERLOAD COMPLETE: NEON DUST CHANCE"
	_score += score_bonus
	for i in range(xp_orbs):
		var angle := TAU * float(i) / float(maxi(1, xp_orbs))
		_drop_xp(position + Vector3(cos(angle), 0.0, sin(angle)) * (0.85 + float(i % 3) * 0.28), 2)
	var dust_awarded := 0
	if force_dust or _run_event_rng.randf() < clampf(dust_chance, 0.0, 0.42):
		dust_awarded = dust_amount
		_grant_neon_dust(dust_awarded, true)
	var dust_text := "  +%d DUST" % dust_awarded if dust_awarded > 0 else ""
	var xp_total := xp_orbs * 2
	_show_combat_notice("%s // +%d XP // +%d SCORE%s" % [reward_label, xp_total, score_bonus, dust_text], Color(1.0, 0.94, 0.18), 1.70)
	_spawn_burst(position, 1.12, "burst_gold" if dust_awarded > 0 else "burst_cyan")
	_play_sfx("reward", 0.12)
	_update_hud()
	return {"xp_orbs": xp_orbs, "score": score_bonus, "dust": dust_awarded}


func _clear_run_event_state(show_notice := false) -> void:
	if is_instance_valid(_run_event_node):
		_run_event_node.queue_free()
	_run_event_node = null
	_demote_run_event_target()
	_clear_run_event_hazards()
	_run_event_active = false
	_run_event_type = ""
	_run_event_stage = ""
	_run_event_timer = 0.0
	_run_event_duration = 0.0
	_run_event_progress = 0.0
	_run_event_notice_step = -1
	_run_event_spawn_timer = 0.0
	_run_event_hazard_timer = 0.0
	_run_event_target_node = null
	_run_event_target_instance_id = 0
	if is_instance_valid(_run_event_objective_panel):
		_run_event_objective_panel.visible = false
	if show_notice:
		_show_combat_notice("OBJECTIVE CLEARED", Color(0.82, 0.96, 1.0), 0.9)


func _demote_run_event_target() -> void:
	for i in range(_enemies.size()):
		var enemy := _enemies[i]
		if not bool(enemy.get("run_event_target", false)):
			continue
		var marker: Node3D = enemy.get("run_event_target_marker", null)
		if is_instance_valid(marker):
			marker.queue_free()
		enemy["run_event_target"] = false
		enemy["run_event_target_id"] = 0
		enemy["run_event_target_marker"] = null
		_enemies[i] = enemy


func _clear_run_event_hazards() -> void:
	for i in range(_hazard_trails.size() - 1, -1, -1):
		var hazard := _hazard_trails[i]
		if str(hazard.get("source", "")) != "run_event":
			continue
		var node: Node3D = hazard.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
		_hazard_trails.remove_at(i)


func _run_event_cooldown_for_sector() -> float:
	return float(RUN_EVENT_COOLDOWN[clampi(_sector_index, 0, RUN_EVENT_COOLDOWN.size() - 1)])


func _reset_run_event_director_for_run() -> void:
	_clear_run_event_state()
	_run_event_sector_count = 0
	_run_event_cooldown = float(RUN_EVENT_START_DELAY[clampi(_sector_index, 0, RUN_EVENT_START_DELAY.size() - 1)])


func _reset_run_event_director_for_sector() -> void:
	_clear_run_event_state()
	_run_event_sector_count = 0
	_run_event_cooldown = float(RUN_EVENT_START_DELAY[clampi(_sector_index, 0, RUN_EVENT_START_DELAY.size() - 1)]) * 0.55


func _run_event_spawn_position() -> Vector3:
	var origin := _player_area.position if is_instance_valid(_player_area) else Vector3.ZERO
	for i in range(8):
		var angle := _run_event_rng.randf() * TAU
		var distance := _run_event_rng.randf_range(7.0, 15.0)
		var candidate := _clamp_to_arena(origin + Vector3(cos(angle), 0.0, sin(angle)) * distance, 4.0)
		if _xz_distance(candidate, origin) >= 5.5:
			return Vector3(candidate.x, 0.82, candidate.z)
	return Vector3(clampf(origin.x + 8.0, -ARENA_HALF_SIZE + 4.0, ARENA_HALF_SIZE - 4.0), 0.82, clampf(origin.z, -ARENA_HALF_SIZE + 4.0, ARENA_HALF_SIZE - 4.0))


func _clamp_to_arena(position: Vector3, margin: float) -> Vector3:
	return Vector3(clampf(position.x, -ARENA_HALF_SIZE + margin, ARENA_HALF_SIZE - margin), position.y, clampf(position.z, -ARENA_HALF_SIZE + margin, ARENA_HALF_SIZE - margin))


func _spawn_position_on_edge() -> Vector3:
	var side := randi() % 4
	var offset := randf_range(-ARENA_HALF_SIZE + 2.0, ARENA_HALF_SIZE - 2.0)
	match side:
		0:
			return Vector3(offset, 0.95, -ARENA_HALF_SIZE + 1.5)
		1:
			return Vector3(offset, 0.95, ARENA_HALF_SIZE - 1.5)
		2:
			return Vector3(-ARENA_HALF_SIZE + 1.5, 0.95, offset)
		_:
			return Vector3(ARENA_HALF_SIZE - 1.5, 0.95, offset)


func _spawn_mini_boss() -> void:
	_spawn_sector_boss()


func _spawn_null_octagon() -> void:
	_spawn_sector_boss()


func _spawn_sector_boss() -> void:
	if _sector_boss_spawned:
		return
	var sector := _current_sector()
	var boss_type := str(sector["boss_type"])
	_clear_run_event_state()
	_trim_non_boss_enemies(int(sector.get("boss_trim_keep", 14)))
	_clear_enemy_projectiles_and_hazards()
	_sector_boss_spawned = true
	_sector_boss_active = true
	if boss_type == "mini_boss":
		_mini_boss_spawned = true
		_mini_boss_active = true
	elif _is_null_boss_type(boss_type):
		_null_octagon_spawned = true
		_null_octagon_active = true
	var spawn_position := _sector_boss_spawn_position()
	_spawn_enemy(boss_type, spawn_position)
	_spawn_burst(spawn_position, 2.35 if _is_null_boss_type(boss_type) else 1.90, _burst_key_for_enemy(boss_type))
	_show_combat_notice("FINAL BOSS ARRIVAL // %s // SURVIVE AND DESTROY" % _boss_name_for_type(boss_type) if _sector_index >= 3 else "BOSS ARRIVAL // %s // REWARD UNLOCKS ON DEFEAT" % _boss_name_for_type(boss_type), _boss_notice_color(boss_type), 1.85 if _sector_index >= 3 else 1.70)
	_spawn_timer = 1.35
	_player_invuln = maxf(_player_invuln, 0.55)
	_set_music_state("boss")
	_play_sfx("boss_warning", 0.50)
	_trigger_presentation_flash(Color(0.72, 0.96, 1.0) if _sector_index >= 3 else Color(1.0, 0.08, 0.86), 0.16 if _sector_index >= 3 else 0.14, 0.30 if _sector_index >= 3 else 0.28)
	_trigger_sector_background_reaction(1.0 if _sector_index >= 3 else 0.86, 1.08 if _sector_index >= 3 else 0.95)
	_add_screen_shake(0.20 if _sector_index >= 3 else 0.18 if _is_null_boss_type(boss_type) else 0.12, 0.36 if _sector_index >= 3 else 0.34 if _is_null_boss_type(boss_type) else 0.25)


func _sector_boss_spawn_position() -> Vector3:
	match _sector_index:
		0:
			return Vector3(0.0, 1.18, -ARENA_HALF_SIZE + 4.0)
		1:
			return Vector3(ARENA_HALF_SIZE - 5.0, 1.28, 0.0)
		2:
			return Vector3(0.0, 1.32, ARENA_HALF_SIZE - 5.0)
		_:
			return Vector3(-ARENA_HALF_SIZE + 5.0, 1.32, 0.0)


func _trim_non_boss_enemies(max_keep: int) -> void:
	while _count_non_boss_enemies() > max_keep:
		var remove_index := -1
		var farthest := -1.0
		for i in range(_enemies.size()):
			var enemy := _enemies[i]
			if _is_boss_type(str(enemy["type"])):
				continue
			var node: Node3D = enemy["node"]
			if not is_instance_valid(node):
				remove_index = i
				break
			var distance := _xz_distance(node.position, _player_area.position)
			if distance > farthest:
				farthest = distance
				remove_index = i
		if remove_index < 0:
			return
		var remove_node: Node3D = _enemies[remove_index]["node"]
		if is_instance_valid(remove_node):
			remove_node.queue_free()
		_enemies.remove_at(remove_index)


func _count_non_boss_enemies() -> int:
	var count := 0
	for enemy in _enemies:
		if not _is_boss_type(str(enemy["type"])):
			count += 1
	return count


func _clear_enemy_projectiles_and_hazards() -> void:
	for projectile in _enemy_projectiles:
		var node: Node3D = projectile.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
	_enemy_projectiles.clear()
	for hazard in _hazard_trails:
		var node: Node3D = hazard.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
	_hazard_trails.clear()
	for telegraph in _boss_telegraphs:
		var node: Node3D = telegraph.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
	_boss_telegraphs.clear()


func _spawn_enemy(enemy_type: String, position: Vector3, elite_variant := "") -> int:
	if _enemies.size() >= ENEMY_CAP:
		return -1
	var stats := _enemy_stats(enemy_type)
	var elite_data := _elite_variant_data(elite_variant)
	if not elite_data.is_empty() and not _is_boss_type(enemy_type):
		stats = _apply_elite_variant_stats(stats, elite_data)
	var enemy := Area3D.new()
	enemy.name = "%s%sGameplayEnemy3D" % [str(elite_data.get("label", "")).replace(" ", ""), enemy_type.capitalize()]
	enemy.position = position
	enemy.collision_layer = 2
	enemy.collision_mask = 1 | 8
	_gameplay_root.add_child(enemy)
	_add_sphere_collision(enemy, "EnemyCollisionSphere", stats.radius)
	var visual := _create_enemy_visual(enemy_type)
	visual.name = "%s3DVisualAsset" % enemy_type.capitalize()
	var gameplay_visual_scale := _enemy_visual_scale_for_gameplay(enemy_type, float(stats.visual_scale))
	visual.scale = Vector3.ONE * gameplay_visual_scale
	enemy.add_child(visual)
	_apply_enemy_blender_model(visual, enemy_type)
	var elite_marker := _apply_elite_visual_marker(visual, elite_variant, enemy_type)
	_enemy_instance_counter += 1
	_enemies.append({
		"node": enemy,
		"instance_id": _enemy_instance_counter,
		"type": enemy_type,
		"elite_variant": elite_variant,
		"elite_label": str(elite_data.get("label", "")),
		"elite_marker": elite_marker,
		"hp": stats.hp,
		"max_hp": stats.hp,
		"speed": stats.speed,
		"radius": stats.radius,
		"damage": stats.damage,
		"score": int(stats.score),
		"xp": int(stats.xp),
		"elite_dust_chance": float(elite_data.get("dust_chance", 0.0)),
		"elite_dust": int(elite_data.get("dust", 0)),
		"visual": visual,
		"visual_scale": gameplay_visual_scale,
		"flash": 0.0,
		"contact_cd": 0.0,
		"shoot_cd": randf_range(1.0, 2.2),
		"explode_cd": 0.20,
		"boss_attack_cd": randf_range(1.2, 2.0),
		"boss_attack_pending": false,
		"dash_cd": randf_range(1.2, 2.4),
		"dash_windup": 0.0,
		"dash_time": 0.0,
		"dash_dir": Vector3.ZERO,
		"hazard_cd": randf_range(0.4, 1.1),
		"pulse_cd": randf_range(1.4, 2.6),
		"pulse_windup": 0.0,
		"fractal_attack_index": 0,
		"phase2": false,
		"null_attack_index": 0,
		"phase": randf() * TAU,
		"shield_hp": float(stats.get("shield_hp", 0.0))
	})
	if not elite_data.is_empty():
		_show_elite_spawn_feedback(position, elite_variant, elite_data)
	return _enemies.size() - 1


func _elite_variant_data(variant: String) -> Dictionary:
	match variant:
		"overcharged":
			return {"label": "OVERCHARGED", "hp_mult": 1.22, "speed_mult": 1.18, "score_mult": 1.45, "xp_bonus": 2, "dust_chance": 0.10, "dust": 3, "material": "elite_overcharged", "burst": "burst_cyan", "scale_mult": 1.10}
		"armored":
			return {"label": "ARMORED", "hp_mult": 1.62, "speed_mult": 0.90, "score_mult": 1.60, "xp_bonus": 3, "dust_chance": 0.14, "dust": 4, "material": "elite_armored", "burst": "burst_gold", "scale_mult": 1.14}
		"shielded":
			return {"label": "SHIELDED", "hp_mult": 1.20, "speed_mult": 0.96, "shield_add": 46.0, "score_mult": 1.55, "xp_bonus": 3, "dust_chance": 0.12, "dust": 4, "material": "elite_shielded", "burst": "burst_shield", "scale_mult": 1.12}
		"volatile":
			return {"label": "VOLATILE", "hp_mult": 1.14, "speed_mult": 1.08, "score_mult": 1.42, "xp_bonus": 2, "dust_chance": 0.10, "dust": 3, "material": "elite_volatile", "burst": "burst_red", "scale_mult": 1.10}
		"splitter_elite":
			return {"label": "SPLITTER ELITE", "hp_mult": 1.34, "speed_mult": 1.05, "score_mult": 1.70, "xp_bonus": 4, "dust_chance": 0.16, "dust": 5, "material": "elite_splitter", "burst": "burst_magenta", "scale_mult": 1.15}
		"hypercharged":
			return {"label": "HYPERCHARGED", "hp_mult": 1.24, "speed_mult": 1.24, "score_mult": 1.64, "xp_bonus": 3, "dust_chance": 0.14, "dust": 5, "material": "elite_hypercharged", "burst": "rail_skimmer", "scale_mult": 1.12}
		"rail_armored":
			return {"label": "RAIL-ARMORED", "hp_mult": 1.56, "speed_mult": 0.96, "score_mult": 1.76, "xp_bonus": 4, "dust_chance": 0.16, "dust": 6, "material": "elite_rail_armored", "burst": "burst_cyan", "scale_mult": 1.16}
		"overclocked_splitter":
			return {"label": "OVERCLOCKED SPLITTER", "hp_mult": 1.32, "speed_mult": 1.08, "score_mult": 1.82, "xp_bonus": 5, "dust_chance": 0.18, "dust": 6, "material": "elite_overclocked_splitter", "burst": "grid_splitter", "scale_mult": 1.16}
		_:
			return {}


func _apply_elite_variant_stats(stats: Dictionary, elite_data: Dictionary) -> Dictionary:
	var tuned := stats.duplicate(true)
	tuned["hp"] = float(tuned.get("hp", 1.0)) * float(elite_data.get("hp_mult", 1.0))
	tuned["speed"] = float(tuned.get("speed", 1.0)) * float(elite_data.get("speed_mult", 1.0))
	tuned["visual_scale"] = float(tuned.get("visual_scale", 1.0)) * float(elite_data.get("scale_mult", 1.0))
	tuned["score"] = int(round(float(tuned.get("score", 0)) * float(elite_data.get("score_mult", 1.0))))
	tuned["xp"] = int(tuned.get("xp", 0)) + int(elite_data.get("xp_bonus", 0))
	if elite_data.has("shield_add"):
		tuned["shield_hp"] = float(tuned.get("shield_hp", 0.0)) + float(elite_data.get("shield_add", 0.0))
	return tuned


func _apply_elite_visual_marker(visual: Node3D, elite_variant: String, enemy_type: String) -> Node3D:
	var elite_data := _elite_variant_data(elite_variant)
	if elite_data.is_empty() or _is_boss_type(enemy_type):
		return null
	var marker := Node3D.new()
	marker.name = "%sElite3DMarker" % str(elite_data.get("label", "Elite")).replace(" ", "")
	visual.add_child(marker)
	var material_key := str(elite_data.get("material", "elite_overcharged"))
	var material: Material = _materials[material_key] if _materials.has(material_key) else _materials["elite_overcharged"]
	var radius := 0.78
	match elite_variant:
		"armored":
			radius = 0.92
		"shielded":
			radius = 0.96
		"splitter_elite":
			radius = 0.86
		"hypercharged":
			radius = 0.90
		"rail_armored":
			radius = 1.00
		"overclocked_splitter":
			radius = 0.94
	var ring := Kit.add_mesh(marker, "EliteReadableOuterNeonRing", Kit.torus_mesh(radius, 0.032, 42, 5), material)
	ring.rotation.x = PI * 0.5
	var cross := Kit.add_mesh(marker, "EliteVerticalNeonProfileRing", Kit.torus_mesh(radius * 0.82, 0.018, 34, 4), material)
	cross.rotation.z = PI * 0.5
	if elite_variant == "armored":
		Kit.add_mesh(marker, "EliteArmoredGoldFrame", Kit.box_mesh(Vector3(radius * 1.18, 0.055, radius * 1.18)), material, Vector3(0.0, -0.20, 0.0))
	elif elite_variant == "volatile":
		var warning := Kit.add_mesh(marker, "EliteVolatileWarningCore", Kit.torus_mesh(radius * 1.10, 0.018, 30, 4), material)
		warning.rotation.x = PI * 0.5
	elif elite_variant == "rail_armored":
		Kit.add_mesh(marker, "EliteRailArmoredWhiteRailFrame", Kit.box_mesh(Vector3(radius * 1.44, 0.050, radius * 0.42)), material, Vector3(0.0, -0.18, 0.0))
	elif elite_variant == "overclocked_splitter":
		Kit.add_mesh(marker, "EliteOverclockedSplitterSquareFrame", Kit.box_mesh(Vector3(radius * 1.18, 0.050, radius * 1.18)), material, Vector3(0.0, -0.18, 0.0))
	return marker


func _show_elite_spawn_feedback(position: Vector3, elite_variant: String, elite_data: Dictionary) -> void:
	var burst_key := str(elite_data.get("burst", "burst_cyan"))
	_spawn_burst(position, 1.10, burst_key)
	_show_combat_notice("%s ELITE DETECTED" % str(elite_data.get("label", "ELITE")), _elite_notice_color(elite_variant), 1.35)
	_play_sfx("warning", 0.10)
	_trigger_presentation_flash(_elite_notice_color(elite_variant), 0.035, 0.12)


func _elite_notice_color(elite_variant: String) -> Color:
	match elite_variant:
		"armored":
			return Color(1.0, 0.86, 0.12)
		"shielded":
			return Color(0.22, 0.72, 1.0)
		"volatile":
			return Color(1.0, 0.30, 0.04)
		"splitter_elite":
			return Color(1.0, 0.08, 0.86)
		"hypercharged":
			return Color(0.58, 0.96, 1.0)
		"rail_armored":
			return Color(0.92, 0.98, 1.0)
		"overclocked_splitter":
			return Color(1.0, 0.74, 0.10)
		_:
			return Color(0.0, 0.96, 1.0)


func _enemy_stats(enemy_type: String) -> Dictionary:
	match enemy_type:
		"fractal_crown":
			return {"hp": 1180.0, "speed": 1.38, "radius": 1.96, "damage": 25.0, "visual_scale": 1.20, "score": 2200, "xp": 42}
		"final_null_octagon":
			return {"hp": 1480.0, "speed": 1.38, "radius": 2.18, "damage": 28.0, "visual_scale": 1.28, "score": 2600, "xp": NULL_OCTAGON_XP_BONUS + 14}
		"null_octagon":
			return {"hp": 1080.0, "speed": 1.30, "radius": 2.06, "damage": 24.0, "visual_scale": 1.12, "score": 1800, "xp": NULL_OCTAGON_XP_BONUS}
		"mini_boss":
			return {"hp": 620.0, "speed": 1.66, "radius": 1.72, "damage": 21.0, "visual_scale": 1.18, "score": 900, "xp": MINI_BOSS_XP_BONUS}
		"hex_slicer":
			return {"hp": 60.0, "speed": 3.45, "radius": 0.88, "damage": 14.0, "visual_scale": 0.72, "score": 70, "xp": 4}
		"triad_splitter":
			return {"hp": 72.0, "speed": 2.72, "radius": 0.94, "damage": 12.0, "visual_scale": 0.78, "score": 82, "xp": 4}
		"triad_fragment":
			return {"hp": 22.0, "speed": 4.85, "radius": 0.52, "damage": 6.0, "visual_scale": 0.52, "score": 16, "xp": 1}
		"hex_pulser":
			return {"hp": 86.0, "speed": 2.08, "radius": 1.02, "damage": 13.0, "visual_scale": 0.82, "score": 96, "xp": 5}
		"rail_skimmer":
			return {"hp": 66.0, "speed": 3.35, "radius": 0.88, "damage": 15.0, "visual_scale": 0.86, "score": 92, "xp": 5}
		"grid_splitter":
			return {"hp": 92.0, "speed": 2.54, "radius": 1.02, "damage": 14.0, "visual_scale": 0.90, "score": 108, "xp": 5}
		"grid_fragment":
			return {"hp": 28.0, "speed": 4.35, "radius": 0.54, "damage": 7.0, "visual_scale": 0.58, "score": 18, "xp": 1}
		"prism_leech":
			return {"hp": 78.0, "speed": 2.48, "radius": 0.98, "damage": 10.0, "visual_scale": 0.76, "score": 76, "xp": 4}
		"spiral_drifter":
			return {"hp": 46.0, "speed": 3.35, "radius": 0.82, "damage": 10.0, "visual_scale": 0.72, "score": 50, "xp": 3}
		"shield_node":
			return {"hp": 68.0, "shield_hp": 50.0, "speed": 2.28, "radius": 1.04, "damage": 13.0, "visual_scale": 0.78, "score": 72, "xp": 4}
		"tank":
			return {"hp": 104.0, "speed": 2.15, "radius": 1.05, "damage": 16.0, "visual_scale": 0.76, "score": 65, "xp": 4}
		"shooter":
			return {"hp": 54.0, "speed": 2.55, "radius": 0.88, "damage": 11.0, "visual_scale": 0.78, "score": 55, "xp": 3}
		"exploder":
			return {"hp": 42.0, "speed": 3.10, "radius": 0.92, "damage": 22.0, "visual_scale": 0.72, "score": 60, "xp": 3}
		_:
			return {"hp": 36.0, "speed": 4.00, "radius": 0.78, "damage": 9.0, "visual_scale": 0.72, "score": 35, "xp": 2}


func _create_enemy_visual(enemy_type: String) -> Node3D:
	match enemy_type:
		"triad_splitter":
			return _create_triad_splitter_visual()
		"triad_fragment":
			return _create_triad_fragment_visual()
		"hex_pulser":
			return _create_hex_pulser_visual()
		"rail_skimmer":
			return _create_rail_skimmer_visual()
		"grid_splitter":
			return _create_grid_splitter_visual()
		"grid_fragment":
			return _create_grid_fragment_visual()
		"fractal_crown":
			return _create_fractal_crown_visual()
		_:
			return _enemy_scene(enemy_type).instantiate() as Node3D


func _create_triad_splitter_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "TriadSplitterProceduralVisual"
	for i in range(3):
		var shard := Node3D.new()
		shard.name = "TriadSplitterShard%d" % i
		var angle := TAU * float(i) / 3.0
		shard.position = Vector3(cos(angle) * 0.34, 0.0, sin(angle) * 0.34)
		shard.rotation.y = angle + PI
		shard.scale = Vector3.ONE * 0.56
		root.add_child(shard)
		Kit.add_mesh(shard, "DarkTriangleShardBody", Kit.tetrahedron_arrow_mesh(), _materials["enemy_dark_body"])
		Kit.add_glowing_edges(shard, "TriadSplitterShard", _scaled_points(Kit.tetrahedron_arrow_points(), 1.0), Kit.tetrahedron_edges(), 0.038, 0.014, _materials["triad_splitter"], _materials["soft_white"])
	var core := Kit.add_mesh(root, "TriadSplitterHotCenter", Kit.sphere_mesh(0.18, 10, 5), _materials["fractal_orange"])
	core.position.y = 0.08
	return root


func _create_triad_fragment_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "TriadFragmentProceduralVisual"
	Kit.add_mesh(root, "TriadFragmentDarkShardBody", Kit.tetrahedron_arrow_mesh(), _materials["enemy_dark_body"])
	Kit.add_glowing_edges(root, "TriadFragment", _scaled_points(Kit.tetrahedron_arrow_points(), 0.98), Kit.tetrahedron_edges(), 0.040, 0.014, _materials["triad_fragment"], _materials["soft_white"])
	return root


func _create_hex_pulser_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "HexPulserProceduralVisual"
	var body := Kit.add_mesh(root, "HexPulserDarkHexCore", Kit.hex_prism_mesh(0.78, 0.42), _materials["enemy_dark_body"])
	body.rotation.x = PI * 0.5
	Kit.add_glowing_edges(root, "HexPulserCore", Kit.hex_prism_points(0.80, 0.44), Kit.hex_prism_edges(), 0.036, 0.013, _materials["hex_pulser"], _materials["soft_white"])
	var ring := Kit.add_mesh(root, "HexPulserCyanPulseRing", Kit.torus_mesh(0.98, 0.034, 42, 5), _materials["hex_pulser"])
	ring.rotation.x = PI * 0.5
	var warning := Kit.add_mesh(root, "HexPulserOrangeWarningRing", Kit.torus_mesh(1.20, 0.020, 42, 4), _materials["fractal_orange"])
	warning.rotation.x = PI * 0.5
	return root


func _create_rail_skimmer_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "RailSkimmerHyperGridFallbackVisual"
	var body := Kit.add_mesh(root, "RailSkimmerDarkArrowBody", Kit.tetrahedron_arrow_mesh(), _materials["enemy_dark_body"])
	body.scale = Vector3(0.86, 0.42, 1.48)
	Kit.add_glowing_edges(root, "RailSkimmerArrow", _scaled_points(Kit.tetrahedron_arrow_points(), 1.10), Kit.tetrahedron_edges(), 0.046, 0.016, _materials["rail_skimmer"], _materials["soft_white"])
	for side in [-1.0, 1.0]:
		var rail := Kit.add_mesh(root, "RailSkimmerSideRail%.0f" % side, Kit.box_mesh(Vector3(0.12, 0.08, 1.42)), _materials["rail_skimmer"], Vector3(side * 0.44, 0.02, -0.05))
		rail.rotation.y = side * 0.10
	var warning := Kit.add_mesh(root, "RailSkimmerDashTelegraphHotNose", Kit.box_mesh(Vector3(0.14, 0.10, 0.48)), _materials["rail_skimmer_warning"], Vector3(0.0, 0.08, -0.70))
	warning.rotation.y = 0.0
	return root


func _create_grid_splitter_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "GridSplitterHyperGridFallbackVisual"
	Kit.add_mesh(root, "GridSplitterDarkSquareCore", Kit.box_mesh(Vector3(1.24, 0.42, 1.24)), _materials["enemy_dark_body"], Vector3.ZERO)
	Kit.add_glowing_edges(root, "GridSplitterSquareFrame", Kit.box_points(Vector3(1.32, 0.48, 1.32)), Kit.box_edges(), 0.038, 0.014, _materials["grid_splitter"], _materials["soft_white"])
	for offset in [-0.34, 0.34]:
		Kit.add_mesh(root, "GridSplitterHorizontalCircuit%.0f" % (offset * 100.0), Kit.box_mesh(Vector3(1.10, 0.064, 0.070)), _materials["grid_splitter"], Vector3(0.0, 0.28, offset))
		Kit.add_mesh(root, "GridSplitterVerticalCircuit%.0f" % (offset * 100.0), Kit.box_mesh(Vector3(0.070, 0.064, 1.10)), _materials["grid_splitter"], Vector3(offset, 0.28, 0.0))
	Kit.add_mesh(root, "GridSplitterWhiteCore", Kit.sphere_mesh(0.17, 10, 5), _materials["burst_hot_core"], Vector3(0.0, 0.32, 0.0))
	return root


func _create_grid_fragment_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "GridFragmentHyperGridFallbackVisual"
	Kit.add_mesh(root, "GridFragmentDarkRectBody", Kit.box_mesh(Vector3(0.74, 0.28, 0.48)), _materials["enemy_dark_body"], Vector3.ZERO)
	Kit.add_glowing_edges(root, "GridFragmentRectFrame", Kit.box_points(Vector3(0.80, 0.32, 0.52)), Kit.box_edges(), 0.034, 0.012, _materials["grid_fragment"], _materials["soft_white"])
	return root


func _create_fractal_crown_visual() -> Node3D:
	var root := Node3D.new()
	root.name = "FractalCrownProceduralVisual"
	var body := Kit.add_mesh(root, "FractalCrownDarkGlassCommandBody", Kit.octahedron_mesh(0.92), _materials["enemy_dark_body"])
	body.scale = Vector3(1.0, 0.78, 1.0)
	Kit.add_glowing_edges(root, "FractalCrownBody", _scaled_points(Kit.octahedron_points(0.92), 1.0), Kit.octahedron_edges(), 0.052, 0.018, _materials["fractal_crown"], _materials["soft_white"])
	for i in range(5):
		var spike := Node3D.new()
		spike.name = "FractalCrownStackedTriangle%d" % i
		var offset := float(i - 2) * 0.34
		spike.position = Vector3(offset, 0.62 + absf(float(i - 2)) * 0.06, -0.36 + absf(float(i - 2)) * 0.04)
		spike.rotation.y = PI + offset * 0.28
		spike.scale = Vector3.ONE * (0.42 - absf(float(i - 2)) * 0.035)
		root.add_child(spike)
		Kit.add_mesh(spike, "DarkCrownTriangleBody", Kit.tetrahedron_arrow_mesh(), _materials["enemy_dark_body"])
		var edge_material: Material = _materials["fractal_orange"] if i % 2 == 0 else _materials["hex_pulser"]
		Kit.add_glowing_edges(spike, "FractalCrownSpike", _scaled_points(Kit.tetrahedron_arrow_points(), 1.0), Kit.tetrahedron_edges(), 0.046, 0.016, edge_material, _materials["soft_white"])
	var halo := Kit.add_mesh(root, "FractalCrownBrokenHalo", Kit.torus_mesh(1.24, 0.030, 48, 5), _materials["fractal_crown"])
	halo.rotation.x = PI * 0.5
	halo.position.y = 0.24
	return root


func _scaled_points(points: Array, scale: float) -> Array:
	var scaled: Array = []
	for point in points:
		scaled.append(Vector3(point) * scale)
	return scaled


func _enemy_scene(enemy_type: String) -> PackedScene:
	match enemy_type:
		"final_null_octagon":
			return NULL_OCTAGON_SCENE
		"null_octagon":
			return NULL_OCTAGON_SCENE
		"mini_boss":
			return MINI_BOSS_SCENE
		"hex_slicer":
			return HEX_SLICER_SCENE
		"prism_leech":
			return PRISM_LEECH_SCENE
		"tank":
			return TANK_SCENE
		"shooter":
			return SHOOTER_SCENE
		"exploder":
			return EXPLODER_SCENE
		"spiral_drifter":
			return SPIRAL_DRIFTER_SCENE
		"shield_node":
			return SHIELD_NODE_SCENE
		_:
			return CHASER_SCENE


func _burst_key_for_enemy(enemy_type: String) -> String:
	match enemy_type:
		"fractal_crown":
			return "burst_fractal"
		"final_null_octagon":
			return "burst_null"
		"null_octagon":
			return "burst_null"
		"mini_boss":
			return "mini_boss"
		"hex_slicer":
			return "burst_hex"
		"triad_splitter":
			return "triad_splitter"
		"triad_fragment":
			return "triad_fragment"
		"hex_pulser":
			return "hex_pulser"
		"rail_skimmer":
			return "rail_skimmer"
		"grid_splitter":
			return "grid_splitter"
		"grid_fragment":
			return "grid_fragment"
		"prism_leech":
			return "burst_leech"
		"tank":
			return "burst_gold"
		"shooter":
			return "burst_violet"
		"exploder":
			return "burst_red"
		"spiral_drifter":
			return "burst_cyan"
		"shield_node":
			return "burst_shield"
		_:
			return "burst_green"


func _is_null_boss_type(enemy_type: String) -> bool:
	return enemy_type == "null_octagon" or enemy_type == "final_null_octagon"


func _is_boss_type(enemy_type: String) -> bool:
	return enemy_type == "mini_boss" or enemy_type == "fractal_crown" or _is_null_boss_type(enemy_type)


func _boss_name_for_type(enemy_type: String) -> String:
	match enemy_type:
		"fractal_crown":
			return "FRACTAL CROWN"
		"final_null_octagon":
			return "NULL OCTAGON PRIME"
		"null_octagon":
			return "NULL OCTAGON"
		"mini_boss":
			return "PRISM WARDEN"
		_:
			return str(_current_sector().get("boss_name", "BOSS"))


func _update_weapons(delta: float) -> void:
	_update_pulse_blaster(delta)
	_update_hex_shatter(delta)
	_update_fractal_shard(delta)
	_update_orbit_spark(delta)
	_update_nova_burst(delta)
	_update_arc_beam(delta)
	_update_gravity_mine(delta)
	_update_prism_lance(delta)
	_update_ring_saw(delta)
	_update_tri_burst_cannon(delta)
	_update_hex_mortar(delta)
	_update_vector_spear(delta)
	_update_orbital_saw_array(delta)
	_update_prism_chain(delta)
	_update_gravity_well(delta)
	_update_nova_needle(delta)
	_update_fractal_bloom(delta)
	_update_shield_breaker(delta)
	_update_star_pulse(delta)


func _update_pulse_blaster(delta: float) -> void:
	var state: Dictionary = _weapon_state["pulse_blaster"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["pulse_blaster"] = state
		return
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["pulse_blaster"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["pulse_blaster"] = state
		return
	var shot_count := clampi(1 + _projectile_count_bonus + _weapon_int_stat_bonus("pulse_blaster", "projectile_count_bonus", 1), 1, 4)
	var shot_room := PLAYER_PROJECTILE_CAP - _player_projectiles.size()
	shot_count = mini(shot_count, shot_room)
	for i in range(shot_count):
		var spread := 0.0
		if shot_count > 1:
			spread = deg_to_rad(-8.0 + 16.0 * float(i) / float(maxi(1, shot_count - 1)))
		var shot_direction := direction.rotated(Vector3.UP, spread).normalized()
		_spawn_player_projectile(_player_area.position + shot_direction * 1.15, shot_direction)
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("pulse_blaster") / (_fire_rate_multiplier * _weapon_rate_multiplier("pulse_blaster"))
	_weapon_state["pulse_blaster"] = state


func _update_hex_shatter(delta: float) -> void:
	var state: Dictionary = _weapon_state["hex_shatter"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["hex_shatter"] = state
		return
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["hex_shatter"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["hex_shatter"] = state
		return
	_spawn_hex_shatter_projectile(_player_area.position + direction * 1.18, direction)
	state["timer"] = float(state["cooldown"]) * _hex_shatter_cooldown_multiplier * _weapon_cooldown_multiplier("hex_shatter") / _weapon_rate_multiplier("hex_shatter")
	_weapon_state["hex_shatter"] = state


func _update_fractal_shard(delta: float) -> void:
	var state: Dictionary = _weapon_state["fractal_shard"]
	if not _fractal_shard_enabled and not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["fractal_shard"] = state
		return
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["fractal_shard"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["fractal_shard"] = state
		return
	_spawn_fractal_shard_projectile(_player_area.position + direction * 1.34, direction)
	state["timer"] = float(state["cooldown"]) * _fractal_shard_cooldown_multiplier * _weapon_cooldown_multiplier("fractal_shard") / (_fire_rate_multiplier * _weapon_rate_multiplier("fractal_shard"))
	_weapon_state["fractal_shard"] = state


func _update_orbit_spark(delta: float) -> void:
	var state: Dictionary = _weapon_state["orbit_spark"]
	if not bool(state.get("enabled", false)):
		for node in _orbit_nodes:
			if is_instance_valid(node):
				node.visible = false
		return
	state["timer"] = float(state["timer"]) - delta
	state["angle"] = float(state["angle"]) + delta * 2.85
	var count := clampi(_orbit_count + _weapon_int_stat_bonus("orbit_spark", "orbit_count_bonus", 1), 1, ORBIT_VISUAL_CAP)
	var orbit_radius := ORBIT_RADIUS * _weapon_range_multiplier("orbit_spark")
	for i in range(_orbit_nodes.size()):
		var node := _orbit_nodes[i]
		node.visible = i < count
		if not node.visible:
			continue
		var angle := float(state["angle"]) + TAU * float(i) / float(count)
		node.position = _player_area.position + Vector3(cos(angle) * orbit_radius, 0.08, sin(angle) * orbit_radius)
		node.rotation.y += delta * 2.4
		node.rotation.x = sin(_survival_time * 1.6 + float(i)) * 0.20
	if float(state["timer"]) <= 0.0:
		for enemy_index in range(_enemies.size() - 1, -1, -1):
			var enemy := _enemies[enemy_index]
			var enemy_node: Area3D = enemy["node"]
			if not is_instance_valid(enemy_node):
				continue
			if absf(_xz_distance(_player_area.position, enemy_node.position) - orbit_radius) <= float(enemy["radius"]) + 0.58:
				_damage_enemy_at(enemy_index, _scaled_damage(ORBIT_DAMAGE) * _weapon_damage_multiplier("orbit_spark"), "burst_cyan")
		state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("orbit_spark") / _weapon_rate_multiplier("orbit_spark")
	_weapon_state["orbit_spark"] = state


func _update_nova_burst(delta: float) -> void:
	var state: Dictionary = _weapon_state["nova_burst"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["nova_burst"] = state
		return
	for enemy_index in range(_enemies.size() - 1, -1, -1):
		var enemy := _enemies[enemy_index]
		var enemy_node: Area3D = enemy["node"]
		if not is_instance_valid(enemy_node):
			continue
		if _xz_distance(_player_area.position, enemy_node.position) <= NOVA_RADIUS * _weapon_range_multiplier("nova_burst") + float(enemy["radius"]):
			_damage_enemy_at(enemy_index, _scaled_damage(NOVA_DAMAGE) * _weapon_damage_multiplier("nova_burst"), _burst_key_for_enemy(enemy["type"]))
	_spawn_nova_effect(_player_area.position)
	state["timer"] = float(state["cooldown"]) * _nova_cooldown_multiplier * _weapon_cooldown_multiplier("nova_burst")
	_weapon_state["nova_burst"] = state


func _update_arc_beam(delta: float) -> void:
	var state: Dictionary = _weapon_state["arc_beam"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["arc_beam"] = state
		return
	var target_indices := _chain_target_indices(_player_area.position, ARC_BEAM_RANGE * _weapon_range_multiplier("arc_beam"), 3 + _weapon_int_stat_bonus("arc_beam", "chain_count_bonus", 1))
	var previous_position := _player_area.position
	for enemy_index in target_indices:
		if enemy_index < 0 or enemy_index >= _enemies.size():
			continue
		var enemy := _enemies[enemy_index]
		var enemy_node: Area3D = enemy["node"]
		if not is_instance_valid(enemy_node):
			continue
		_spawn_beam_effect(previous_position, enemy_node.position, 0.18 + _beam_duration_bonus)
		_damage_enemy_at(enemy_index, _scaled_damage(ARC_BEAM_DAMAGE) * _weapon_damage_multiplier("arc_beam"), _burst_key_for_enemy(enemy["type"]))
		previous_position = enemy_node.position
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("arc_beam") / (_fire_rate_multiplier * _weapon_rate_multiplier("arc_beam"))
	_weapon_state["arc_beam"] = state


func _update_gravity_mine(delta: float) -> void:
	var state: Dictionary = _weapon_state["gravity_mine"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) <= 0.0 and _mines.size() < MINE_CAP:
		_spawn_gravity_mine(_player_area.position)
		state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("gravity_mine")
	_weapon_state["gravity_mine"] = state


func _update_prism_lance(delta: float) -> void:
	var state: Dictionary = _weapon_state["prism_lance"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["prism_lance"] = state
		return
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["prism_lance"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["prism_lance"] = state
		return
	_spawn_prism_lance_projectile(_player_area.position + direction * 1.28, direction)
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("prism_lance") / (_fire_rate_multiplier * _weapon_rate_multiplier("prism_lance"))
	_weapon_state["prism_lance"] = state


func _update_ring_saw(delta: float) -> void:
	var state: Dictionary = _weapon_state["ring_saw"]
	if not bool(state.get("enabled", false)):
		if is_instance_valid(_ring_saw_root):
			_ring_saw_root.visible = false
		return
	if is_instance_valid(_ring_saw_root):
		_ring_saw_root.visible = true
	state["timer"] = float(state["timer"]) - delta
	state["angle"] = float(state["angle"]) + delta * (RING_SAW_SPIN_SPEED * (1.0 + _ring_saw_spin_bonus))
	var radius := (RING_SAW_RADIUS + _ring_saw_radius_bonus) * _weapon_range_multiplier("ring_saw")
	if is_instance_valid(_ring_saw_root):
		_ring_saw_root.position = Vector3(_player_area.position.x, 0.88, _player_area.position.z)
		_ring_saw_root.rotation.y = float(state["angle"])
		var scale := radius / RING_SAW_RADIUS
		_ring_saw_root.scale = Vector3.ONE * scale
	if float(state["timer"]) <= 0.0:
		for enemy_index in range(_enemies.size() - 1, -1, -1):
			var enemy := _enemies[enemy_index]
			var enemy_node: Area3D = enemy["node"]
			if not is_instance_valid(enemy_node):
				continue
			var distance := _xz_distance(_player_area.position, enemy_node.position)
			if absf(distance - radius) <= float(enemy["radius"]) + RING_SAW_WIDTH:
				_damage_enemy_at(enemy_index, _scaled_damage(RING_SAW_DAMAGE) * _weapon_damage_multiplier("ring_saw"), "burst_cyan")
		state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("ring_saw") / ((1.0 + _ring_saw_spin_bonus) * _weapon_rate_multiplier("ring_saw"))
	_weapon_state["ring_saw"] = state


func _update_tri_burst_cannon(delta: float) -> void:
	var state: Dictionary = _weapon_state["tri_burst_cannon"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0 or _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["tri_burst_cannon"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["tri_burst_cannon"] = state
		return
	var shot_count := mini(3 + _weapon_int_stat_bonus("tri_burst_cannon", "projectile_count_bonus", 1), PLAYER_PROJECTILE_CAP - _player_projectiles.size())
	for i in range(shot_count):
		var spread := deg_to_rad(-13.0 + 26.0 * float(i) / float(maxi(1, shot_count - 1)))
		var shot_direction := direction.rotated(Vector3.UP, spread).normalized()
		_spawn_weapon_projectile("tri_burst_cannon", _player_area.position + shot_direction * 1.18, shot_direction, "tri_burst", "triangle", TRI_BURST_DAMAGE, TRI_BURST_SPEED, TRI_BURST_LIFE, 1, 0.30, "tri_burst", {"burst_key": "triad_splitter"})
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("tri_burst_cannon") / (_fire_rate_multiplier * _weapon_rate_multiplier("tri_burst_cannon"))
	_weapon_state["tri_burst_cannon"] = state


func _update_hex_mortar(delta: float) -> void:
	var state: Dictionary = _weapon_state["hex_mortar"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0 or _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["hex_mortar"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["hex_mortar"] = state
		return
	_spawn_weapon_projectile("hex_mortar", _player_area.position + direction * 1.12, direction, "hex_mortar", "hex", HEX_MORTAR_DAMAGE, HEX_MORTAR_SPEED, HEX_MORTAR_LIFE, 1, 0.46, "hex_mortar", {"burst_key": "burst_hex", "arc_height": 1.05, "split_count": 6 + _weapon_int_stat_bonus("hex_mortar", "split_count_bonus", 2)})
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("hex_mortar") / _weapon_rate_multiplier("hex_mortar")
	_weapon_state["hex_mortar"] = state


func _update_vector_spear(delta: float) -> void:
	var state: Dictionary = _weapon_state["vector_spear"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0 or _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["vector_spear"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["vector_spear"] = state
		return
	_spawn_weapon_projectile("vector_spear", _player_area.position + direction * 1.36, direction, "vector_spear", "spear", VECTOR_SPEAR_DAMAGE, VECTOR_SPEAR_SPEED, VECTOR_SPEAR_LIFE, 3 + _weapon_int_stat_bonus("vector_spear", "pierce_bonus", 2), 0.34, "vector_spear", {"burst_key": "burst_cyan", "bounce": _weapon_int_stat_bonus("vector_spear", "ricochet_bonus", 1)})
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("vector_spear") / (_fire_rate_multiplier * _weapon_rate_multiplier("vector_spear"))
	_weapon_state["vector_spear"] = state


func _update_orbital_saw_array(delta: float) -> void:
	var state: Dictionary = _weapon_state["orbital_saw_array"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	state["angle"] = float(state.get("angle", 0.0)) + delta * 5.4
	if float(state["timer"]) > 0.0:
		_weapon_state["orbital_saw_array"] = state
		return
	var count := clampi(3 + _weapon_int_stat_bonus("orbital_saw_array", "orbit_count_bonus", 2), 3, ORBIT_VISUAL_CAP)
	var radius := ORBITAL_SAW_ARRAY_RADIUS * _weapon_range_multiplier("orbital_saw_array")
	for i in range(count):
		var angle := float(state["angle"]) + TAU * float(i) / float(count)
		var saw_position := _player_area.position + Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)
		_spawn_burst(saw_position, 0.38, "orbital_saw_array")
	for enemy_index in range(_enemies.size() - 1, -1, -1):
		var enemy := _enemies[enemy_index]
		var enemy_node: Area3D = enemy["node"]
		if not is_instance_valid(enemy_node):
			continue
		if absf(_xz_distance(_player_area.position, enemy_node.position) - radius) <= float(enemy["radius"]) + 0.62:
			_damage_enemy_at(enemy_index, _scaled_damage(ORBITAL_SAW_ARRAY_DAMAGE) * _weapon_damage_multiplier("orbital_saw_array"), "orbital_saw_array")
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("orbital_saw_array") / _weapon_rate_multiplier("orbital_saw_array")
	_weapon_state["orbital_saw_array"] = state


func _update_prism_chain(delta: float) -> void:
	var state: Dictionary = _weapon_state["prism_chain"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["prism_chain"] = state
		return
	var target_indices := _chain_target_indices(_player_area.position, PRISM_CHAIN_RANGE * _weapon_range_multiplier("prism_chain"), 4 + _weapon_int_stat_bonus("prism_chain", "chain_count_bonus", 2))
	var previous_position := _player_area.position
	for enemy_index in target_indices:
		if enemy_index < 0 or enemy_index >= _enemies.size():
			continue
		var enemy := _enemies[enemy_index]
		var enemy_node: Area3D = enemy["node"]
		if not is_instance_valid(enemy_node):
			continue
		_spawn_colored_beam_effect(previous_position, enemy_node.position, 0.16, "prism_chain")
		_damage_enemy_at(enemy_index, _scaled_damage(PRISM_CHAIN_DAMAGE) * _weapon_damage_multiplier("prism_chain"), "prism_chain")
		previous_position = enemy_node.position
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("prism_chain") / (_fire_rate_multiplier * _weapon_rate_multiplier("prism_chain"))
	_weapon_state["prism_chain"] = state


func _update_gravity_well(delta: float) -> void:
	var state: Dictionary = _weapon_state["gravity_well"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) <= 0.0 and _mines.size() < MINE_CAP:
		_spawn_weapon_gravity_well(_player_area.position)
		state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("gravity_well")
	_weapon_state["gravity_well"] = state


func _update_nova_needle(delta: float) -> void:
	var state: Dictionary = _weapon_state["nova_needle"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0 or _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["nova_needle"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["nova_needle"] = state
		return
	var count := mini(1 + _weapon_int_stat_bonus("nova_needle", "projectile_count_bonus", 1), PLAYER_PROJECTILE_CAP - _player_projectiles.size())
	for i in range(count):
		var spread := 0.0 if count == 1 else deg_to_rad(-4.0 + 8.0 * float(i) / float(maxi(1, count - 1)))
		var shot_direction := direction.rotated(Vector3.UP, spread).normalized()
		_spawn_weapon_projectile("nova_needle", _player_area.position + shot_direction * 1.10, shot_direction, "nova_needle", "needle", NOVA_NEEDLE_DAMAGE, NOVA_NEEDLE_SPEED, NOVA_NEEDLE_LIFE, 1, 0.20, "nova_needle", {"burst_key": "nova_needle", "bounce": _weapon_int_stat_bonus("nova_needle", "ricochet_bonus", 1)})
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("nova_needle") / (_fire_rate_multiplier * _weapon_rate_multiplier("nova_needle"))
	_weapon_state["nova_needle"] = state


func _update_fractal_bloom(delta: float) -> void:
	var state: Dictionary = _weapon_state["fractal_bloom"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0 or _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["fractal_bloom"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["fractal_bloom"] = state
		return
	_spawn_weapon_projectile("fractal_bloom", _player_area.position + direction * 1.28, direction, "fractal_bloom", "bloom", FRACTAL_BLOOM_DAMAGE, FRACTAL_BLOOM_SPEED, FRACTAL_BLOOM_LIFE, 1, 0.42, "fractal_bloom", {"burst_key": "fractal_bloom", "split_count": 6 + _weapon_int_stat_bonus("fractal_bloom", "split_count_bonus", 2)})
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("fractal_bloom") / _weapon_rate_multiplier("fractal_bloom")
	_weapon_state["fractal_bloom"] = state


func _update_shield_breaker(delta: float) -> void:
	var state: Dictionary = _weapon_state["shield_breaker"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0 or _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		_weapon_state["shield_breaker"] = state
		return
	var direction := _get_primary_fire_direction()
	if direction.length_squared() < 0.01:
		_weapon_state["shield_breaker"] = state
		return
	_spawn_weapon_projectile("shield_breaker", _player_area.position + direction * 1.30, direction, "shield_breaker", "hammer", SHIELD_BREAKER_DAMAGE, SHIELD_BREAKER_SPEED, SHIELD_BREAKER_LIFE, 2 + _weapon_int_stat_bonus("shield_breaker", "pierce_bonus", 1), 0.48, "shield_breaker", {"burst_key": "shield_breaker"})
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("shield_breaker") / _weapon_rate_multiplier("shield_breaker")
	_weapon_state["shield_breaker"] = state


func _update_star_pulse(delta: float) -> void:
	var state: Dictionary = _weapon_state["star_pulse"]
	if not bool(state.get("enabled", false)):
		return
	state["timer"] = float(state["timer"]) - delta
	if float(state["timer"]) > 0.0:
		_weapon_state["star_pulse"] = state
		return
	var radius := STAR_PULSE_RADIUS * _weapon_range_multiplier("star_pulse")
	for enemy_index in range(_enemies.size() - 1, -1, -1):
		var enemy := _enemies[enemy_index]
		var enemy_node: Area3D = enemy["node"]
		if not is_instance_valid(enemy_node):
			continue
		if _xz_distance(_player_area.position, enemy_node.position) <= radius + float(enemy["radius"]):
			_damage_enemy_at(enemy_index, _scaled_damage(STAR_PULSE_DAMAGE) * _weapon_damage_multiplier("star_pulse"), "star_pulse")
	_spawn_star_pulse_effect(_player_area.position, radius)
	state["timer"] = float(state["cooldown"]) * _weapon_cooldown_multiplier("star_pulse") / _weapon_rate_multiplier("star_pulse")
	_weapon_state["star_pulse"] = state


func _get_primary_fire_direction() -> Vector3:
	var direction := _get_aim_direction()
	if direction.length_squared() >= 0.01:
		return direction
	var target := _nearest_enemy()
	if target.is_empty():
		return Vector3.ZERO
	direction = (target["node"].position - _player_area.position)
	direction.y = 0.0
	return direction.normalized() if direction.length_squared() >= 0.01 else Vector3.ZERO


func _get_aim_direction() -> Vector3:
	var aim := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down", InputMapConfig.AIM_DEADZONE)
	if aim.length() < InputMapConfig.AIM_DEADZONE:
		return Vector3.ZERO
	return Vector3(aim.x, 0.0, aim.y).normalized()


func _nearest_enemy() -> Dictionary:
	var best: Dictionary = {}
	var best_distance := AUTO_TARGET_RANGE
	for enemy in _enemies:
		var node: Node3D = enemy["node"]
		if not is_instance_valid(node):
			continue
		var distance := _xz_distance(_player_area.position, node.position)
		if distance < best_distance:
			best_distance = distance
			best = enemy
	return best


func _spawn_player_projectile(position: Vector3, direction: Vector3) -> void:
	var projectile := Area3D.new()
	projectile.name = "PulseBlaster3DProjectile"
	projectile.position = Vector3(position.x, 0.92, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "ProjectileCollisionSphere", 0.30)
	var visual := PROJECTILE_SCENE.instantiate() as Node3D
	visual.name = "Projectile3DVisualAsset"
	visual.scale = Vector3.ONE * 0.72
	projectile.add_child(visual)
	_apply_weapon_projectile_blender_model(projectile, "pulse_blaster")
	_player_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": PULSE_LIFE * _weapon_lifetime_multiplier("pulse_blaster"),
		"damage": _scaled_damage(PULSE_DAMAGE) * _weapon_damage_multiplier("pulse_blaster"),
		"pierce": 1,
		"speed": PULSE_SPEED * _weapon_speed_multiplier("pulse_blaster")
	})
	_play_sfx("shoot", 0.055)


func _spawn_hex_shatter_projectile(position: Vector3, direction: Vector3) -> void:
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "HexShatterPrimaryProjectile"
	projectile.position = Vector3(position.x, 0.96, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "HexShatterCollisionSphere", 0.36)
	var body := Kit.add_mesh(projectile, "HexShatterCyanHexPrismBody", Kit.hex_prism_mesh(0.28, 0.18), _materials["hex_shatter"])
	body.rotation.x = PI * 0.5
	Kit.add_glowing_edges(projectile, "HexShatterProjectile", Kit.hex_prism_points(0.30, 0.20), Kit.hex_prism_edges(), 0.026, 0.010, _materials["hex_shatter"], _materials["hex_shatter_core"])
	var nose := Kit.add_mesh(projectile, "HexShatterForwardShardNose", Kit.triangular_prism_mesh(0.24, 0.18, 0.46), _materials["hex_shatter_shard"], Vector3(0.0, 0.0, -0.42))
	nose.rotation.x = PI * 0.5
	_apply_weapon_projectile_blender_model(projectile, "hex_shatter")
	_player_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": HEX_SHATTER_LIFE * _weapon_lifetime_multiplier("hex_shatter"),
		"damage": _scaled_damage(HEX_SHATTER_DAMAGE) * _hex_shatter_damage_multiplier * _weapon_damage_multiplier("hex_shatter"),
		"pierce": 1,
		"speed": HEX_SHATTER_SPEED * _weapon_speed_multiplier("hex_shatter"),
		"radius": 0.38,
		"burst_key": "burst_hex",
		"kind": "hex_shatter",
		"split_count": 5 + _hex_shatter_split_bonus + _weapon_int_stat_bonus("hex_shatter", "split_count_bonus", 2)
	})
	_play_sfx("lance", 0.075)


func _spawn_hex_shatter_split(position: Vector3, incoming_direction: Vector3, split_count: int) -> void:
	var room := PLAYER_PROJECTILE_CAP - _player_projectiles.size()
	var count := mini(clampi(split_count, 3, 11), room)
	if count <= 0:
		return
	var base_angle := atan2(incoming_direction.x, incoming_direction.z)
	for i in range(count):
		var spread := deg_to_rad(-62.0 + 124.0 * float(i) / float(maxi(1, count - 1)))
		var angle := base_angle + spread
		var direction := Vector3(sin(angle), 0.0, cos(angle)).normalized()
		_spawn_hex_shatter_shard(position + direction * 0.35, direction)


func _spawn_hex_shatter_shard(position: Vector3, direction: Vector3) -> void:
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "HexShatterSplitShardProjectile"
	projectile.position = Vector3(position.x, 0.94, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "HexShatterShardCollisionSphere", 0.22)
	var shard := Kit.add_mesh(projectile, "HexShatterMagentaShardBody", Kit.triangular_prism_mesh(0.22, 0.16, 0.52), _materials["hex_shatter_shard"])
	shard.rotation.x = PI * 0.5
	Kit.tube_between(projectile, "HexShatterShardWhiteCore", Vector3(0.0, 0.0, 0.22), Vector3(0.0, 0.0, -0.34), 0.016, _materials["hex_shatter_core"], 5)
	_apply_weapon_projectile_blender_model(projectile, "hex_shatter_shard")
	_player_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": HEX_SHATTER_SPLIT_LIFE * _weapon_lifetime_multiplier("hex_shatter"),
		"damage": _scaled_damage(HEX_SHATTER_SPLIT_DAMAGE) * _hex_shatter_damage_multiplier * _weapon_damage_multiplier("hex_shatter"),
		"pierce": 1,
		"speed": HEX_SHATTER_SPLIT_SPEED * _weapon_speed_multiplier("hex_shatter"),
		"radius": 0.24,
		"burst_key": "burst_hex",
		"kind": "hex_shatter_shard"
	})


func _spawn_fractal_shard_projectile(position: Vector3, direction: Vector3) -> void:
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "FractalShardPrimaryProjectile"
	projectile.position = Vector3(position.x, 1.02, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "FractalShardCollisionSphere", 0.44)
	var body := Kit.add_mesh(projectile, "FractalShardDarkDiamondBody", Kit.octahedron_mesh(0.34), _materials["enemy_dark_body"])
	body.scale = Vector3(0.72, 0.54, 1.28)
	body.rotation.x = PI * 0.5
	Kit.add_glowing_edges(projectile, "FractalShardPrimary", _scaled_points(Kit.octahedron_points(0.42), 1.0), Kit.octahedron_edges(), 0.030, 0.011, _materials["fractal_shard"], _materials["fractal_shard_core"])
	var tail := Kit.add_mesh(projectile, "FractalShardMagentaTail", Kit.triangular_prism_mesh(0.34, 0.18, 0.72), _materials["fractal_shard_split"], Vector3(0.0, 0.0, 0.58))
	tail.rotation.x = PI * 0.5
	_apply_weapon_projectile_blender_model(projectile, "fractal_shard")
	_player_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": (FRACTAL_SHARD_LIFE + _fractal_shard_life_bonus) * _weapon_lifetime_multiplier("fractal_shard"),
		"damage": _scaled_damage(FRACTAL_SHARD_DAMAGE) * _fractal_shard_damage_multiplier * _weapon_damage_multiplier("fractal_shard"),
		"pierce": 1 + _fractal_shard_pierce_bonus + _weapon_int_stat_bonus("fractal_shard", "pierce_bonus", 1),
		"speed": FRACTAL_SHARD_SPEED * _weapon_speed_multiplier("fractal_shard"),
		"radius": 0.46,
		"burst_key": "burst_fractal",
		"kind": "fractal_shard",
		"split_count": 5 + _fractal_shard_split_bonus + _weapon_int_stat_bonus("fractal_shard", "split_count_bonus", 2)
	})
	_play_sfx("lance", 0.16)


func _spawn_fractal_shard_split(position: Vector3, incoming_direction: Vector3, split_count: int) -> void:
	var room := PLAYER_PROJECTILE_CAP - _player_projectiles.size()
	var count := mini(clampi(split_count, 4, 9), room)
	if count <= 0:
		return
	var base_angle := atan2(incoming_direction.x, incoming_direction.z)
	for i in range(count):
		var spread := deg_to_rad(-84.0 + 168.0 * float(i) / float(maxi(1, count - 1)))
		var angle := base_angle + spread
		var direction := Vector3(sin(angle), 0.0, cos(angle)).normalized()
		_spawn_fractal_shard_child(position + direction * 0.42, direction)


func _spawn_fractal_shard_child(position: Vector3, direction: Vector3) -> void:
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "FractalShardSplitProjectile"
	projectile.position = Vector3(position.x, 0.98, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "FractalShardSplitCollisionSphere", 0.24)
	var shard := Kit.add_mesh(projectile, "FractalShardTriangleFragmentBody", Kit.triangular_prism_mesh(0.26, 0.16, 0.62), _materials["fractal_shard_split"])
	shard.rotation.x = PI * 0.5
	Kit.tube_between(projectile, "FractalShardSplitWhiteCore", Vector3(0.0, 0.0, 0.26), Vector3(0.0, 0.0, -0.38), 0.015, _materials["fractal_shard_core"], 5)
	_apply_weapon_projectile_blender_model(projectile, "fractal_shard_child")
	_player_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": (FRACTAL_SHARD_SPLIT_LIFE + _fractal_shard_life_bonus * 0.35) * _weapon_lifetime_multiplier("fractal_shard"),
		"damage": _scaled_damage(FRACTAL_SHARD_SPLIT_DAMAGE) * _fractal_shard_damage_multiplier * _weapon_damage_multiplier("fractal_shard"),
		"pierce": 1,
		"speed": FRACTAL_SHARD_SPLIT_SPEED * _weapon_speed_multiplier("fractal_shard"),
		"radius": 0.25,
		"burst_key": "burst_fractal",
		"kind": "fractal_shard_child"
	})


func _spawn_prism_lance_projectile(position: Vector3, direction: Vector3) -> void:
	var projectile := Area3D.new()
	projectile.name = "PrismLancePiercingProjectile"
	projectile.position = Vector3(position.x, 0.96, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "PrismLanceCollisionSphere", 0.38)
	var local_start := Vector3(0.0, 0.0, 0.88)
	var local_end := Vector3(0.0, 0.0, -1.16)
	Kit.tube_between(projectile, "PrismLanceVioletNeonTube", local_start, local_end, 0.072, _materials["prism_lance"], 8)
	Kit.tube_between(projectile, "PrismLanceWhiteHotCore", local_start, local_end, 0.026, _materials["prism_lance_core"], 6)
	var front_ring := Kit.add_mesh(projectile, "PrismLanceForwardStabilizerAnnulus", Kit.torus_mesh(0.22, 0.018, 22, 4), _materials["prism_lance"])
	front_ring.position = Vector3(0.0, 0.0, -1.06)
	front_ring.rotation.x = PI * 0.5
	_apply_weapon_projectile_blender_model(projectile, "prism_lance")
	_player_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": PRISM_LANCE_LIFE * _weapon_lifetime_multiplier("prism_lance"),
		"damage": _scaled_damage(PRISM_LANCE_DAMAGE) * _prism_lance_damage_multiplier * _weapon_damage_multiplier("prism_lance"),
		"pierce": PRISM_LANCE_PIERCE + _prism_lance_pierce_bonus + _weapon_int_stat_bonus("prism_lance", "pierce_bonus", 1),
		"speed": PRISM_LANCE_SPEED * _weapon_speed_multiplier("prism_lance"),
		"radius": 0.42,
		"burst_key": "burst_violet"
	})
	_play_sfx("lance", 0.12)


func _spawn_weapon_projectile(definition_id: String, position: Vector3, direction: Vector3, material_key: String, shape: String, base_damage: float, base_speed: float, base_life: float, pierce: int, radius: float, kind: String, extra := {}) -> void:
	if _player_projectiles.size() >= PLAYER_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "%sProjectile" % definition_id.to_pascal_case()
	projectile.position = Vector3(position.x, 0.96, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 8
	projectile.collision_mask = 2
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "%sCollisionSphere" % definition_id.to_pascal_case(), radius)
	_create_weapon_projectile_visual(projectile, shape, material_key)
	_apply_weapon_projectile_blender_model(projectile, definition_id)
	var projectile_data := {
		"node": projectile,
		"direction": direction.normalized(),
		"life": base_life * _weapon_lifetime_multiplier(definition_id),
		"duration": base_life * _weapon_lifetime_multiplier(definition_id),
		"damage": _scaled_damage(base_damage) * _weapon_damage_multiplier(definition_id),
		"pierce": pierce,
		"speed": base_speed * _weapon_speed_multiplier(definition_id),
		"radius": radius,
		"burst_key": str(extra.get("burst_key", material_key)),
		"kind": kind,
		"weapon_id": definition_id,
		"base_y": projectile.position.y
	}
	for key in extra.keys():
		projectile_data[key] = extra[key]
	_player_projectiles.append(projectile_data)
	_play_sfx("shoot", 0.052)


func _create_weapon_projectile_visual(projectile: Node3D, shape: String, material_key: String) -> void:
	var edge_material: Material = _materials[material_key] if _materials.has(material_key) else _materials["burst_cyan"]
	var core_material: Material = _materials["soft_white"]
	match shape:
		"triangle":
			var tri := Kit.add_mesh(projectile, "TriBurstTriangleBoltBody", Kit.triangular_prism_mesh(0.28, 0.18, 0.62), edge_material)
			tri.rotation.x = PI * 0.5
			Kit.tube_between(projectile, "TriBurstWhiteCore", Vector3(0.0, 0.0, 0.24), Vector3(0.0, 0.0, -0.40), 0.016, core_material, 5)
		"hex":
			var body := Kit.add_mesh(projectile, "HexMortarShellBody", Kit.hex_prism_mesh(0.34, 0.24), _materials["enemy_dark_body"])
			body.rotation.x = PI * 0.5
			Kit.add_glowing_edges(projectile, "HexMortarShellEdges", Kit.hex_prism_points(0.36, 0.26), Kit.hex_prism_edges(), 0.026, 0.010, edge_material, core_material)
		"spear":
			Kit.tube_between(projectile, "VectorSpearRailLine", Vector3(0.0, 0.0, 0.94), Vector3(0.0, 0.0, -1.18), 0.058, edge_material, 7)
			Kit.tube_between(projectile, "VectorSpearWhiteCore", Vector3(0.0, 0.0, 0.72), Vector3(0.0, 0.0, -1.00), 0.020, core_material, 5)
			var head := Kit.add_mesh(projectile, "VectorSpearArrowHead", Kit.tetrahedron_arrow_mesh(), edge_material, Vector3(0.0, 0.0, -1.10))
			head.scale = Vector3.ONE * 0.36
		"needle":
			Kit.tube_between(projectile, "NovaNeedleThinCore", Vector3(0.0, 0.0, 0.52), Vector3(0.0, 0.0, -0.72), 0.026, edge_material, 6)
			var point := Kit.add_mesh(projectile, "NovaNeedleDiamondPoint", Kit.octahedron_mesh(0.16), core_material, Vector3(0.0, 0.0, -0.72))
			point.scale = Vector3(0.45, 0.45, 1.15)
		"bloom":
			var body := Kit.add_mesh(projectile, "FractalBloomDarkDiamondBody", Kit.octahedron_mesh(0.32), _materials["enemy_dark_body"])
			body.scale = Vector3(0.76, 0.58, 1.18)
			body.rotation.x = PI * 0.5
			Kit.add_glowing_edges(projectile, "FractalBloomEdges", _scaled_points(Kit.octahedron_points(0.38), 1.0), Kit.octahedron_edges(), 0.028, 0.010, edge_material, core_material)
		"hammer":
			var hammer := Kit.add_mesh(projectile, "ShieldBreakerHammerShardBody", Kit.octahedron_mesh(0.34), _materials["enemy_dark_body"])
			hammer.scale = Vector3(1.0, 0.72, 1.48)
			hammer.rotation.x = PI * 0.5
			Kit.add_glowing_edges(projectile, "ShieldBreakerHammerEdges", _scaled_points(Kit.octahedron_points(0.44), 1.0), Kit.octahedron_edges(), 0.034, 0.012, edge_material, core_material)
		_:
			var visual := PROJECTILE_SCENE.instantiate() as Node3D
			visual.name = "GenericWeaponProjectileVisual"
			projectile.add_child(visual)


func _spawn_hex_mortar_burst(position: Vector3, incoming_direction: Vector3, split_count: int) -> void:
	_spawn_burst(position, 1.05, "hex_mortar")
	var room := PLAYER_PROJECTILE_CAP - _player_projectiles.size()
	var count := mini(clampi(split_count, 4, 8), room)
	if count <= 0:
		return
	for i in range(count):
		var angle := TAU * float(i) / float(count)
		var direction := Vector3(sin(angle), 0.0, cos(angle)).normalized()
		_spawn_weapon_projectile("hex_mortar", position + direction * 0.36, direction, "hex_mortar", "hex", HEX_MORTAR_DAMAGE * 0.34, HEX_MORTAR_SPEED * 1.38, HEX_MORTAR_LIFE * 0.38, 1, 0.24, "hex_mortar_shard", {"burst_key": "burst_hex"})


func _spawn_fractal_bloom_split(position: Vector3, incoming_direction: Vector3, split_count: int) -> void:
	_spawn_burst(position, 0.95, "fractal_bloom")
	var room := PLAYER_PROJECTILE_CAP - _player_projectiles.size()
	var count := mini(clampi(split_count, 4, 8), room)
	if count <= 0:
		return
	var base_angle := atan2(incoming_direction.x, incoming_direction.z)
	for i in range(count):
		var spread := deg_to_rad(-128.0 + 256.0 * float(i) / float(maxi(1, count - 1)))
		var direction := Vector3(sin(base_angle + spread), 0.0, cos(base_angle + spread)).normalized()
		_spawn_weapon_projectile("fractal_bloom", position + direction * 0.38, direction, "fractal_bloom", "triangle", FRACTAL_BLOOM_DAMAGE * 0.30, FRACTAL_BLOOM_SPEED * 1.18, FRACTAL_BLOOM_LIFE * 0.42, 1, 0.22, "fractal_bloom_child", {"burst_key": "fractal_bloom"})


func _combat_overlay_active() -> bool:
	return _title_menu_active or _manual_pause or _game_over or _run_success or _weapon_reward_decision_active or _level_up_active or _sector_reward_active


func _chain_link_clamped_end(start: Vector3, end: Vector3) -> Vector3:
	var flat_delta := Vector3(end.x - start.x, 0.0, end.z - start.z)
	var length := flat_delta.length()
	if length <= 0.001 or length <= CHAIN_VFX_MAX_SEGMENT_LENGTH:
		return end
	var clamped := start + flat_delta.normalized() * CHAIN_VFX_MAX_SEGMENT_LENGTH
	return Vector3(clamped.x, end.y, clamped.z)


func _spawn_chain_link_effect(start: Vector3, end: Vector3, duration: float, material_key: String) -> void:
	if _beam_effects.size() >= BEAM_EFFECT_CAP or _combat_overlay_active():
		return
	var root := Node3D.new()
	root.name = "%sReadableChainLinkEffect" % material_key.to_pascal_case()
	root.position = Vector3.ZERO
	_fx_root.add_child(root)
	var material: Material = _materials[material_key] if _materials.has(material_key) else _materials["arc_beam"]
	var clamped_end := _chain_link_clamped_end(start, end)
	var local_start := Vector3(start.x, 1.08, start.z)
	var local_end := Vector3(clamped_end.x, 1.08, clamped_end.z)
	var direction := local_end - local_start
	direction.y = 0.0
	var length := direction.length()
	if length <= 0.001:
		root.queue_free()
		return
	var axis := direction.normalized()
	var perpendicular := Vector3(-axis.z, 0.0, axis.x)
	var point_count := clampi(int(ceil(length / 2.35)), 2, 4)
	var points: Array[Vector3] = [local_start]
	for i in range(1, point_count):
		var t := float(i) / float(point_count)
		var offset := perpendicular * (0.090 if i % 2 == 0 else -0.090)
		points.append(local_start.lerp(local_end, t) + offset)
	points.append(local_end)
	var outer_segments: Array = []
	var core_segments: Array = []
	for i in range(points.size() - 1):
		outer_segments.append(Kit.tube_between(root, "%sSegment%02d" % [material_key.to_pascal_case(), i], points[i], points[i + 1], CHAIN_VFX_OUTER_RADIUS, material, 7))
		core_segments.append(Kit.tube_between(root, "%sCore%02d" % [material_key.to_pascal_case(), i], points[i], points[i + 1], CHAIN_VFX_CORE_RADIUS, _materials["arc_beam_core"], 6))
	for i in range(1, points.size() - 1):
		var tick_start := points[i] - perpendicular * 0.145
		var tick_end := points[i] + perpendicular * 0.145
		Kit.tube_between(root, "%sLinkTick%02d" % [material_key.to_pascal_case(), i], tick_start, tick_end, CHAIN_VFX_TICK_RADIUS, material, 6)
		var spark_node := Kit.add_mesh(root, "%sSparkNode%02d" % [material_key.to_pascal_case(), i], Kit.sphere_mesh(CHAIN_VFX_TICK_RADIUS * 2.2, 8, 4), _materials["arc_beam_core"])
		spark_node.position = points[i]
	var impact_ring := Kit.add_mesh(root, "%sTargetImpactRing" % material_key.to_pascal_case(), Kit.torus_mesh(0.24, CHAIN_VFX_TICK_RADIUS * 0.72, 28, 4), material)
	impact_ring.rotation.x = PI * 0.5
	impact_ring.position = local_end
	var impact_core := Kit.add_mesh(root, "%sTargetImpactCore" % material_key.to_pascal_case(), Kit.sphere_mesh(CHAIN_VFX_CORE_RADIUS * 2.25, 8, 4), _materials["arc_beam_core"])
	impact_core.position = local_end
	var safe_duration := clampf(duration, 0.22, CHAIN_VFX_LIFETIME)
	_beam_effects.append({"node": root, "outer": outer_segments, "core": core_segments, "life": safe_duration, "duration": safe_duration, "chain_link": true})


func _spawn_colored_beam_effect(start: Vector3, end: Vector3, duration: float, material_key: String) -> void:
	_spawn_chain_link_effect(start, end, duration, material_key)


func _spawn_weapon_gravity_well(position: Vector3) -> void:
	var well := Area3D.new()
	well.name = "GravityWellWeaponField"
	well.position = Vector3(position.x, 0.62, position.z)
	well.collision_layer = 32
	well.collision_mask = 2
	_gameplay_root.add_child(well)
	var radius := GRAVITY_WELL_RADIUS * _weapon_range_multiplier("gravity_well")
	var life := GRAVITY_WELL_LIFE * _weapon_lifetime_multiplier("gravity_well")
	_add_sphere_collision(well, "GravityWellInfluenceSphere", radius)
	Kit.add_mesh(well, "GravityWellVoidCore", Kit.sphere_mesh(0.22, 12, 6), _materials["enemy_dark_body"])
	var ring_a := Kit.add_mesh(well, "GravityWellVioletAnnulus", Kit.torus_mesh(0.62, 0.048, 44, 5), _materials["gravity_well"])
	var ring_b := Kit.add_mesh(well, "GravityWellWhiteEventHorizon", Kit.torus_mesh(0.34, 0.018, 34, 4), _materials["soft_white"])
	ring_a.rotation.x = PI * 0.5
	ring_b.rotation.x = PI * 0.5
	_add_weapon_blender_model(well, "gravity_well", radius / 0.78, Vector3(0.0, 0.18, 0.0), 0.0, false)
	_mines.append({"node": well, "life": life, "duration": life, "radius": radius, "damage": _scaled_damage(GRAVITY_WELL_DAMAGE) * _weapon_damage_multiplier("gravity_well"), "pull_speed": GRAVITY_PULL_SPEED * 1.30, "burst_key": "gravity_well", "damaged": {}})
	_play_sfx("sector", 0.12)


func _spawn_star_pulse_effect(position: Vector3, radius: float) -> void:
	if _beam_effects.size() >= BEAM_EFFECT_CAP:
		return
	_spawn_burst(position, 1.35, "star_pulse")
	var root := Node3D.new()
	root.name = "StarPulseRadialGeometry"
	root.position = Vector3.ZERO
	_fx_root.add_child(root)
	for i in range(8):
		var angle := TAU * float(i) / 8.0
		var inner := Vector3(position.x + cos(angle) * radius * 0.28, 1.02, position.z + sin(angle) * radius * 0.28)
		var outer := Vector3(position.x + cos(angle) * radius, 1.02, position.z + sin(angle) * radius)
		Kit.tube_between(root, "StarPulseRay%d" % i, inner, outer, 0.034, _materials["star_pulse"], 6)
	var ring := Kit.add_mesh(root, "StarPulseCenterAnnulus", Kit.torus_mesh(0.54, 0.036, 36, 5), _materials["star_pulse"])
	ring.rotation.x = PI * 0.5
	ring.position = Vector3(position.x, 1.02, position.z)
	_add_weapon_blender_model(root, "star_pulse", radius / 0.92, Vector3(position.x, 1.03, position.z), 0.0, false)
	_beam_effects.append({"node": root, "life": 0.34, "duration": 0.34, "nova": false})
	_play_sfx("level", 0.10)
	_add_screen_shake(0.055, 0.12)


func _spawn_enemy_projectile(position: Vector3, direction: Vector3) -> void:
	if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "EnemyEnergyBolt3D"
	projectile.position = Vector3(position.x, 0.90, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 4
	projectile.collision_mask = 1
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "EnemyProjectileCollisionSphere", 0.34)
	var body := Kit.add_mesh(projectile, "EnemyProjectileRedBoltBody", Kit.capsule_mesh(0.13, 0.90, 10, 3), _materials["enemy_projectile"])
	var core := Kit.add_mesh(projectile, "EnemyProjectileWhiteHotCore", Kit.capsule_mesh(0.052, 0.98, 8, 3), _materials["enemy_projectile_core"])
	var basis := Kit.basis_from_y_axis(Vector3(0.0, 0.0, -1.0))
	body.transform = Transform3D(basis, Vector3.ZERO)
	core.transform = Transform3D(basis, Vector3.ZERO)
	_enemy_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": 3.2,
		"damage": 12.0
	})


func _spawn_prism_warden_shard_projectile(position: Vector3, direction: Vector3, speed := 10.2) -> void:
	if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "PrismWardenDiamondShardProjectile"
	projectile.position = Vector3(position.x, 1.00, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 4
	projectile.collision_mask = 1
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "PrismWardenShardCollisionSphere", 0.33)
	var shard := Kit.add_mesh(projectile, "PrismWardenDiamondShardBody", Kit.octahedron_mesh(0.28), _materials["mini_boss"])
	shard.scale = Vector3(0.72, 0.52, 1.18)
	Kit.tube_between(projectile, "PrismWardenWhiteHotShardRail", Vector3(0.0, 0.0, 0.24), Vector3(0.0, 0.0, -0.42), 0.018, _materials["soft_white"], 5)
	_enemy_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": 3.0,
		"damage": 13.0,
		"speed": speed,
		"radius": 0.33
	})


func _spawn_null_shard_projectile(position: Vector3, direction: Vector3, speed := 9.4) -> void:
	if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "NullOctagonNeonShardProjectile"
	projectile.position = Vector3(position.x, 0.98, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 4
	projectile.collision_mask = 1
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "NullShardCollisionSphere", 0.34)
	var shard := Kit.add_mesh(projectile, "NullShardBlackGlassTriangleBody", Kit.triangular_prism_mesh(0.34, 0.22, 0.78), _materials["null_shard"])
	shard.rotation.x = PI * 0.5
	Kit.tube_between(projectile, "NullShardWhiteHotRail", Vector3(0.0, 0.0, 0.34), Vector3(0.0, 0.0, -0.48), 0.022, _materials["null_shard_core"], 6)
	_enemy_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": 3.4,
		"damage": 14.0,
		"speed": speed,
		"radius": 0.34
	})


func _spawn_mini_boss_radial_burst(position: Vector3) -> void:
	_spawn_burst(position, 0.98, "mini_boss")
	var shots := 8
	for i in range(shots):
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		var angle := TAU * float(i) / float(shots) + _survival_time * 0.22
		_spawn_enemy_projectile(position + Vector3(cos(angle), 0.0, sin(angle)) * 1.2, Vector3(cos(angle), 0.0, sin(angle)).normalized())


func _spawn_prism_warden_shard_fan(position: Vector3, target_position: Vector3) -> void:
	_spawn_burst(position, 1.04, "mini_boss")
	var aim := target_position - position
	aim.y = 0.0
	if aim.length_squared() <= 0.001:
		aim = Vector3(0.0, 0.0, 1.0)
	var base_angle := atan2(aim.z, aim.x)
	var shots := 7
	for i in range(shots):
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		var spread := lerpf(-0.58, 0.58, float(i) / float(maxi(1, shots - 1)))
		var angle := base_angle + spread
		var direction := Vector3(cos(angle), 0.0, sin(angle)).normalized()
		_spawn_prism_warden_shard_projectile(position + direction * 1.18, direction, 9.2 + float(i % 2) * 0.55)
	_play_sfx("warning", 0.18)
	_add_screen_shake(0.060, 0.13)


func _spawn_prism_warden_beam_lane(position: Vector3, target_position: Vector3) -> void:
	var aim := target_position - position
	aim.y = 0.0
	if aim.length_squared() <= 0.001:
		aim = Vector3(0.0, 0.0, 1.0)
	var direction := aim.normalized()
	var side := Vector3(-direction.z, 0.0, direction.x)
	_spawn_burst(position, 0.92, "mini_boss")
	for offset in [-0.62, 0.0, 0.62]:
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		_spawn_prism_warden_shard_projectile(position + direction * 1.15 + side * float(offset), direction, 12.2)
	_play_sfx("lance", 0.18)
	_add_screen_shake(0.065, 0.12)


func _spawn_null_octagon_radial_burst(position: Vector3) -> void:
	_spawn_burst(position, 1.20, "burst_null")
	var shots := 12
	for i in range(shots):
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		var angle := TAU * float(i) / float(shots) + _survival_time * 0.18
		var direction := Vector3(cos(angle), 0.0, sin(angle)).normalized()
		_spawn_null_shard_projectile(position + direction * 1.55, direction, 8.6 + float(i % 3) * 0.85)
	_play_sfx("warning", 0.18)
	_add_screen_shake(0.09, 0.16)


func _spawn_null_octagon_prime_multi_ring(position: Vector3) -> void:
	_spawn_burst(position, 1.42, "burst_null")
	var shots := 16
	for i in range(shots):
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		var angle := TAU * float(i) / float(shots) + _survival_time * 0.26
		var direction := Vector3(cos(angle), 0.0, sin(angle)).normalized()
		var speed := 8.8 + float(i % 4) * 0.74
		_spawn_null_shard_projectile(position + direction * (1.45 + float(i % 2) * 0.38), direction, speed)
	_play_sfx("boss_warning", 0.28)
	_add_screen_shake(0.12, 0.20)


func _spawn_hyper_rail_sweep(position: Vector3, target_position: Vector3) -> void:
	var aim := target_position - position
	aim.y = 0.0
	if aim.length_squared() <= 0.001:
		aim = Vector3(1.0, 0.0, 0.0)
	var direction := aim.normalized()
	var side := Vector3(-direction.z, 0.0, direction.x)
	_spawn_burst(position, 1.08, "burst_null")
	for offset in [-1.40, -0.70, 0.0, 0.70, 1.40]:
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		_spawn_null_shard_projectile(position + direction * 1.50 + side * float(offset), direction, 12.5)
	_play_sfx("lance", 0.18)
	_add_screen_shake(0.10, 0.16)


func _spawn_null_octagon_adds(position: Vector3) -> void:
	_spawn_burst(position, 1.05, "burst_null")
	var add_count := mini(2, ENEMY_CAP - _enemies.size())
	for i in range(add_count):
		var angle := _survival_time * 0.7 + TAU * float(i) / float(maxi(1, add_count))
		var offset := Vector3(cos(angle), 0.0, sin(angle)) * 3.2
		var add_type := "hex_slicer" if i % 2 == 0 else "prism_leech"
		_spawn_enemy(add_type, Vector3(clampf(position.x + offset.x, -ARENA_HALF_SIZE + 2.0, ARENA_HALF_SIZE - 2.0), 0.95, clampf(position.z + offset.z, -ARENA_HALF_SIZE + 2.0, ARENA_HALF_SIZE - 2.0)))
	_play_sfx("ui", 0.08)


func _spawn_hex_pulse(position: Vector3) -> void:
	_spawn_burst(position, 0.92, "hex_pulser")
	_spawn_pressure_hazard(position, 3.20, 0.95, "hazard_pulse", 13.0, 0.46)
	_play_sfx("warning", 0.22)


func _spawn_fractal_enemy_shard_projectile(position: Vector3, direction: Vector3, speed := 9.8, damage := 13.0) -> void:
	if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
		return
	var projectile := Area3D.new()
	projectile.name = "FractalCrownEnemyShardProjectile"
	projectile.position = Vector3(position.x, 1.00, position.z)
	projectile.rotation.y = _yaw_for_direction(direction)
	projectile.collision_layer = 4
	projectile.collision_mask = 1
	_gameplay_root.add_child(projectile)
	_add_sphere_collision(projectile, "FractalEnemyShardCollisionSphere", 0.32)
	var shard := Kit.add_mesh(projectile, "FractalEnemyShardDarkBody", Kit.triangular_prism_mesh(0.34, 0.22, 0.82), _materials["enemy_dark_body"])
	shard.rotation.x = PI * 0.5
	Kit.tube_between(projectile, "FractalEnemyShardOrangeEdge", Vector3(0.0, 0.0, 0.36), Vector3(0.0, 0.0, -0.52), 0.024, _materials["fractal_orange"], 6)
	Kit.tube_between(projectile, "FractalEnemyShardWhiteCore", Vector3(0.0, 0.0, 0.26), Vector3(0.0, 0.0, -0.40), 0.011, _materials["soft_white"], 5)
	_enemy_projectiles.append({
		"node": projectile,
		"direction": direction.normalized(),
		"life": 3.1,
		"damage": damage,
		"speed": speed,
		"radius": 0.32
	})


func _spawn_fractal_crown_burst(position: Vector3, phase2: bool) -> void:
	_spawn_burst(position, 1.28 if phase2 else 1.08, "burst_fractal")
	var shots := 12 if phase2 else 9
	var offset := _survival_time * (0.26 if phase2 else 0.18)
	for i in range(shots):
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		var angle := offset + TAU * float(i) / float(shots)
		if phase2 and i % 2 == 1:
			angle += TAU / float(shots) * 0.36
		var direction := Vector3(cos(angle), 0.0, sin(angle)).normalized()
		_spawn_fractal_enemy_shard_projectile(position + direction * 1.32, direction, 9.4 + float(i % 3) * 0.72, 13.0 if not phase2 else 15.0)
	_play_sfx("warning", 0.20)
	_add_screen_shake(0.08 if phase2 else 0.065, 0.15)


func _spawn_fractal_crown_line_pattern(position: Vector3, target_position: Vector3, phase2: bool) -> void:
	_spawn_burst(position, 1.16 if phase2 else 0.98, "burst_fractal")
	var aim := target_position - position
	aim.y = 0.0
	if aim.length_squared() <= 0.001:
		aim = Vector3(0.0, 0.0, 1.0)
	var base_angle := atan2(aim.z, aim.x)
	var shots := 8 if phase2 else 6
	for i in range(shots):
		if _enemy_projectiles.size() >= ENEMY_PROJECTILE_CAP:
			break
		var angle := base_angle + (float(i) - float(shots - 1) * 0.5) * (0.34 if phase2 else 0.42)
		var direction := Vector3(cos(angle), 0.0, sin(angle)).normalized()
		_spawn_fractal_enemy_shard_projectile(position + direction * 1.35, direction, 10.5 if phase2 else 9.4, 14.0 if phase2 else 12.0)
	_play_sfx("warning", 0.18)
	_add_screen_shake(0.075 if phase2 else 0.055, 0.14)


func _spawn_fractal_crown_adds(position: Vector3, phase2: bool) -> void:
	var active_fragments := _count_enemy_type("triad_fragment")
	var add_count := mini(2 if phase2 else 1, ENEMY_CAP - _enemies.size())
	add_count = mini(add_count, maxi(0, 8 - active_fragments))
	for i in range(add_count):
		var angle := _survival_time * 0.56 + TAU * float(i) / float(maxi(1, add_count))
		var offset := Vector3(cos(angle), 0.0, sin(angle)) * 3.0
		_spawn_enemy("triad_fragment", Vector3(clampf(position.x + offset.x, -ARENA_HALF_SIZE + 2.0, ARENA_HALF_SIZE - 2.0), 0.95, clampf(position.z + offset.z, -ARENA_HALF_SIZE + 2.0, ARENA_HALF_SIZE - 2.0)))
	if add_count > 0:
		_spawn_burst(position, 0.94, "burst_fractal")
		_play_sfx("ui", 0.12)


func _schedule_boss_attack(enemy: Dictionary, boss_node: Area3D, attack_id: String, target_position: Vector3, delay: float, cooldown: float, phase2 := false) -> Dictionary:
	enemy["boss_attack_pending"] = true
	enemy["boss_attack_cd"] = cooldown
	enemy["flash"] = maxf(float(enemy.get("flash", 0.0)), 0.18)
	_spawn_boss_attack_telegraph(boss_node, str(enemy.get("type", "")), attack_id, target_position, delay, phase2)
	return enemy


func _spawn_boss_attack_telegraph(boss_node: Area3D, boss_type: String, attack_id: String, target_position: Vector3, delay: float, phase2 := false) -> void:
	if not is_instance_valid(boss_node):
		return
	while _boss_telegraphs.size() >= BOSS_TELEGRAPH_CAP:
		var oldest: Dictionary = _boss_telegraphs.pop_front()
		var old_node: Node3D = oldest.get("node", null)
		if is_instance_valid(old_node):
			old_node.queue_free()
	var root := Node3D.new()
	root.name = "BossAttackTelegraph_%s" % attack_id
	_fx_root.add_child(root)
	var boss_position := boss_node.position
	var material_key := _boss_telegraph_material_key(boss_type)
	var material: Material = _materials[material_key] if _materials.has(material_key) else _materials["boss_telegraph_prism"]
	var core_material: Material = _materials["boss_telegraph_core"]
	_build_boss_telegraph_visual(root, boss_position, target_position, attack_id, material, core_material, phase2)
	_boss_telegraphs.append({
		"node": root,
		"boss_node": boss_node,
		"boss_type": boss_type,
		"attack_id": attack_id,
		"target_position": target_position,
		"phase2": phase2,
		"life": delay,
		"duration": delay
	})
	_show_combat_notice("%s // %s" % [_boss_name_for_type(boss_type), _boss_attack_label(attack_id)], _boss_notice_color(boss_type), 0.92)
	_play_sfx("warning", 0.16)


func _build_boss_telegraph_visual(root: Node3D, boss_position: Vector3, target_position: Vector3, attack_id: String, material: Material, core_material: Material, phase2: bool) -> void:
	var boss_floor := Vector3(boss_position.x, 0.62, boss_position.z)
	var target_floor := Vector3(target_position.x, 0.62, target_position.z)
	var aim := target_floor - boss_floor
	aim.y = 0.0
	if aim.length_squared() <= 0.001:
		aim = Vector3(0.0, 0.0, 1.0)
	var direction := aim.normalized()
	var side := Vector3(-direction.z, 0.0, direction.x)
	match attack_id:
		"prism_beam_lane", "hyper_rail_sweep":
			root.position = boss_floor
			var lane_count := 5 if attack_id == "hyper_rail_sweep" else 3
			for i in range(lane_count):
				var offset := (float(i) - float(lane_count - 1) * 0.5) * (0.70 if attack_id == "hyper_rail_sweep" else 0.62)
				var start := side * offset + direction * 0.82
				var end := direction * 19.0 + side * offset
				Kit.tube_between(root, "BossTelegraphLane%d" % i, start, end, 0.034, material, 7)
				Kit.tube_between(root, "BossTelegraphLaneCore%d" % i, start + Vector3(0.0, 0.012, 0.0), end + Vector3(0.0, 0.012, 0.0), 0.010, core_material, 5)
		"prism_shard_fan", "fractal_line_pattern":
			root.position = boss_floor
			var spread_count := 7 if attack_id == "prism_shard_fan" else 8 if phase2 else 6
			var spread_step := 0.20 if attack_id == "prism_shard_fan" else 0.18
			for i in range(spread_count):
				var angle := (float(i) - float(spread_count - 1) * 0.5) * spread_step
				var lane_dir := direction.rotated(Vector3.UP, angle).normalized()
				Kit.tube_between(root, "BossTelegraphFan%d" % i, lane_dir * 0.86, lane_dir * 10.5, 0.026, material, 6)
		"null_void_pulse":
			root.position = target_floor
			_add_boss_ring_telegraph(root, 2.45, material, core_material)
			_add_boss_ring_telegraph(root, 1.18, material, core_material)
		"null_prime_multi_ring":
			root.position = boss_floor
			_add_boss_ring_telegraph(root, 2.10, material, core_material)
			_add_boss_ring_telegraph(root, 3.05, material, core_material)
			_add_boss_ring_telegraph(root, 4.00, material, core_material)
		"null_radial", "prism_shield_pulse":
			root.position = boss_floor
			_add_boss_ring_telegraph(root, 2.20, material, core_material)
			_add_boss_ring_telegraph(root, 3.12, material, core_material)
		"null_adds", "fractal_adds":
			root.position = boss_floor
			_add_boss_ring_telegraph(root, 2.65, material, core_material)
			for i in range(4):
				var angle := TAU * float(i) / 4.0
				var point := Vector3(cos(angle), 0.0, sin(angle)) * 2.65
				Kit.add_mesh(root, "BossAddSummonNode%d" % i, Kit.octahedron_mesh(0.14), material, point)
		_:
			root.position = boss_floor
			_add_boss_ring_telegraph(root, 2.40, material, core_material)


func _add_boss_ring_telegraph(root: Node3D, radius: float, material: Material, core_material: Material) -> void:
	var ring := Kit.add_mesh(root, "BossTelegraphOuterRing%.2f" % radius, Kit.torus_mesh(radius, 0.035, 58, 5), material)
	ring.rotation.x = PI * 0.5
	var core := Kit.add_mesh(root, "BossTelegraphCoreRing%.2f" % radius, Kit.torus_mesh(radius, 0.011, 54, 4), core_material)
	core.rotation.x = PI * 0.5


func _update_boss_telegraphs(delta: float) -> void:
	for i in range(_boss_telegraphs.size() - 1, -1, -1):
		var telegraph := _boss_telegraphs[i]
		var node: Node3D = telegraph.get("node", null)
		var boss_node: Area3D = telegraph.get("boss_node", null)
		if not is_instance_valid(node) or not is_instance_valid(boss_node):
			if is_instance_valid(node):
				node.queue_free()
			_boss_telegraphs.remove_at(i)
			continue
		telegraph["life"] = float(telegraph["life"]) - delta
		var duration := maxf(0.001, float(telegraph["duration"]))
		var phase := clampf(1.0 - float(telegraph["life"]) / duration, 0.0, 1.0)
		node.rotation.y += delta * (0.55 + phase * 1.35)
		node.scale = Vector3.ONE * (0.78 + phase * 0.28 + sin(_survival_time * 12.0) * 0.020)
		if float(telegraph["life"]) <= 0.0:
			_execute_boss_telegraph_attack(telegraph)
			_set_boss_pending_for_node(boss_node, false)
			node.queue_free()
			_boss_telegraphs.remove_at(i)
		else:
			_boss_telegraphs[i] = telegraph


func _execute_boss_telegraph_attack(telegraph: Dictionary) -> void:
	var boss_node: Area3D = telegraph.get("boss_node", null)
	if not is_instance_valid(boss_node):
		return
	var boss_position := boss_node.position
	var target_position: Vector3 = telegraph.get("target_position", _player_area.position)
	var phase2 := bool(telegraph.get("phase2", false))
	match str(telegraph.get("attack_id", "")):
		"prism_shard_fan":
			_spawn_prism_warden_shard_fan(boss_position, target_position)
		"prism_beam_lane":
			_spawn_prism_warden_beam_lane(boss_position, target_position)
		"prism_shield_pulse":
			_spawn_mini_boss_radial_burst(boss_position)
		"null_radial":
			_spawn_null_octagon_radial_burst(boss_position)
		"null_prime_multi_ring":
			_spawn_null_octagon_prime_multi_ring(boss_position)
		"null_void_pulse":
			_spawn_pressure_hazard(target_position, 2.45 if not phase2 else 2.82, 2.65 if not phase2 else 2.85, "hazard_null", 12.0 if not phase2 else 14.0, 0.72)
			_spawn_burst(target_position, 1.02, "burst_null")
			_play_sfx("warning", 0.18)
		"null_adds":
			_spawn_null_octagon_adds(boss_position)
		"hyper_rail_sweep":
			_spawn_hyper_rail_sweep(boss_position, target_position)
		"fractal_burst":
			_spawn_fractal_crown_burst(boss_position, phase2)
		"fractal_line_pattern":
			_spawn_fractal_crown_line_pattern(boss_position, target_position, phase2)
		"fractal_adds":
			_spawn_fractal_crown_adds(boss_position, phase2)


func _set_boss_pending_for_node(boss_node: Area3D, pending: bool) -> void:
	for i in range(_enemies.size()):
		var enemy := _enemies[i]
		if enemy.get("node", null) == boss_node:
			enemy["boss_attack_pending"] = pending
			_enemies[i] = enemy
			return


func _boss_telegraph_material_key(boss_type: String) -> String:
	match boss_type:
		"fractal_crown":
			return "boss_telegraph_fractal"
		"final_null_octagon":
			return "boss_telegraph_prime"
		"null_octagon":
			return "boss_telegraph_null"
		_:
			return "boss_telegraph_prism"


func _boss_notice_color(boss_type: String) -> Color:
	match boss_type:
		"fractal_crown":
			return Color(1.0, 0.42, 0.04)
		"final_null_octagon":
			return Color(0.74, 0.94, 1.0)
		"null_octagon":
			return Color(0.0, 0.88, 1.0)
		_:
			return Color(1.0, 0.12, 0.88)


func _boss_attack_label(attack_id: String) -> String:
	match attack_id:
		"prism_shard_fan":
			return "SHARD FAN"
		"prism_beam_lane":
			return "BEAM LANE"
		"prism_shield_pulse":
			return "SHIELD PULSE"
		"null_radial":
			return "VOID RING"
		"null_prime_multi_ring":
			return "PRIME MULTI-RING"
		"null_void_pulse":
			return "VOID PULSE"
		"null_adds":
			return "ADD VECTOR"
		"hyper_rail_sweep":
			return "HYPER RAIL SWEEP"
		"fractal_burst":
			return "CROWN BURST"
		"fractal_line_pattern":
			return "FRACTAL LANES"
		"fractal_adds":
			return "SHARD SUMMON"
		_:
			return "ATTACK CHARGE"


func _count_enemy_type(enemy_type: String) -> int:
	var count := 0
	for enemy in _enemies:
		if str(enemy.get("type", "")) == enemy_type:
			count += 1
	return count


func _chain_target_indices(origin: Vector3, range: float, count: int) -> Array[int]:
	var chosen: Array[int] = []
	var current := origin
	while chosen.size() < count:
		var best_index := -1
		var best_distance := range
		for i in range(_enemies.size()):
			if chosen.has(i):
				continue
			var enemy := _enemies[i]
			var node: Node3D = enemy["node"]
			if not is_instance_valid(node):
				continue
			var distance := _xz_distance(current, node.position)
			if distance < best_distance:
				best_distance = distance
				best_index = i
		if best_index == -1:
			break
		chosen.append(best_index)
		current = _enemies[best_index]["node"].position
	return chosen


func _damage_enemy_at(index: int, amount: float, burst_key := "burst") -> void:
	_apply_enemy_damage_at(index, amount, burst_key, 0.50)


func _apply_enemy_damage_at(index: int, amount: float, burst_key := "burst", burst_scale := 0.50) -> bool:
	if index < 0 or index >= _enemies.size():
		return false
	var enemy := _enemies[index]
	var enemy_node: Area3D = enemy["node"]
	if not is_instance_valid(enemy_node):
		return false
	if float(enemy.get("shield_hp", 0.0)) > 0.0:
		enemy["shield_hp"] = maxf(0.0, float(enemy["shield_hp"]) - amount)
		enemy["flash"] = 0.14
		_enemies[index] = enemy
		_spawn_burst(enemy_node.position, burst_scale * 0.88, "burst_shield")
		_play_sfx("hit", 0.035)
		_add_screen_shake(0.020, 0.040)
		return false
	enemy["hp"] = float(enemy["hp"]) - amount
	enemy["flash"] = 0.12
	_enemies[index] = enemy
	_spawn_burst(enemy_node.position, burst_scale, burst_key)
	if float(enemy["hp"]) <= 0.0:
		_kill_enemy_at(index, false)
		return true
	_play_sfx("hit", 0.030)
	_add_screen_shake(0.016, 0.036)
	return false


func _rail_skimmer_dash_direction(direction: Vector3) -> Vector3:
	if direction.length_squared() <= 0.001:
		return Vector3.FORWARD
	var candidates := [
		Vector3.RIGHT,
		Vector3.LEFT,
		Vector3.FORWARD,
		Vector3.BACK,
		Vector3(1.0, 0.0, 1.0).normalized(),
		Vector3(-1.0, 0.0, 1.0).normalized(),
		Vector3(1.0, 0.0, -1.0).normalized(),
		Vector3(-1.0, 0.0, -1.0).normalized()
	]
	var best := direction.normalized()
	var best_dot := -2.0
	for candidate in candidates:
		var dot := direction.normalized().dot(candidate)
		if dot > best_dot:
			best_dot = dot
			best = candidate
	return best


func _spawn_rail_skimmer_dash_telegraph(position: Vector3, direction: Vector3) -> void:
	if direction.length_squared() <= 0.001 or _beam_effects.size() >= BEAM_EFFECT_CAP:
		return
	var root := Node3D.new()
	root.name = "RailSkimmerDashTelegraph"
	_fx_root.add_child(root)
	var start := Vector3(position.x, 0.74, position.z)
	var end := _clamp_to_arena(position + direction.normalized() * 5.8, 2.1)
	end.y = 0.74
	Kit.tube_between(root, "RailSkimmerWarningLane", start, end, 0.040, _materials["rail_skimmer_warning"], 8)
	Kit.tube_between(root, "RailSkimmerWarningLaneCore", start, end, 0.018, _materials["soft_white"], 6)
	_beam_effects.append({"node": root, "life": 0.54, "duration": 0.54, "rail_warning": true})


func _spawn_beam_effect(start: Vector3, end: Vector3, duration: float) -> void:
	_spawn_chain_link_effect(start, end, duration, "arc_beam")


func _spawn_nova_effect(position: Vector3) -> void:
	if _beam_effects.size() >= BEAM_EFFECT_CAP:
		return
	_spawn_burst(position, 1.70, "burst_cyan")
	var root := Node3D.new()
	root.name = "NovaBurstExpandingTorus"
	root.position = Vector3(position.x, 0.90, position.z)
	_fx_root.add_child(root)
	var ring := Kit.add_mesh(root, "NovaShockwaveAnnulus", Kit.torus_mesh(0.50, 0.080, 60, 6), _materials["nova"])
	ring.rotation.x = PI * 0.5
	var core_ring := Kit.add_mesh(root, "NovaWhiteHotTubeCore", Kit.torus_mesh(0.50, 0.028, 56, 5), _materials["burst_hot_core"])
	core_ring.rotation.x = PI * 0.5
	var magenta_ring := Kit.add_mesh(root, "NovaMagentaOuterAccent", Kit.torus_mesh(0.62, 0.028, 56, 5), _materials["burst_magenta"])
	magenta_ring.rotation.x = PI * 0.5
	var nova_art_radius := NOVA_RADIUS * _weapon_range_multiplier("nova_burst")
	_add_weapon_blender_model(root, "nova_burst", nova_art_radius / 0.78, Vector3(0.0, 0.13, 0.0), 0.0, false)
	_beam_effects.append({"node": root, "outer": ring, "core": core_ring, "life": 0.44, "duration": 0.44, "nova": true, "max_radius": NOVA_RADIUS * _weapon_range_multiplier("nova_burst") * 1.55})
	_play_sfx("lance", 0.18)
	_add_screen_shake(0.10, 0.18)


func _spawn_gravity_mine(position: Vector3) -> void:
	var mine := Area3D.new()
	mine.name = "GravityMineGameplayArea"
	mine.position = Vector3(position.x, 0.64, position.z)
	mine.collision_layer = 32
	mine.collision_mask = 2
	_gameplay_root.add_child(mine)
	var mine_radius := (GRAVITY_MINE_RADIUS + _mine_radius_bonus) * _weapon_range_multiplier("gravity_mine")
	var mine_life := GRAVITY_MINE_LIFE * _weapon_lifetime_multiplier("gravity_mine")
	_add_sphere_collision(mine, "GravityMineInfluenceSphere", mine_radius)
	Kit.add_mesh(mine, "GravityMineWhiteHotCore", Kit.sphere_mesh(0.26, 12, 6), _materials["mine_core"])
	var ring_a := Kit.add_mesh(mine, "GravityMinePurpleTorusA", Kit.torus_mesh(0.58, 0.052, 40, 5), _materials["mine_body"])
	var ring_b := Kit.add_mesh(mine, "GravityMinePullFieldAnnulus", Kit.torus_mesh(0.92, 0.032, 48, 5), _materials["mine_field"])
	ring_a.rotation.x = PI * 0.5
	ring_b.rotation.z = PI * 0.5
	_add_weapon_blender_model(mine, "gravity_mine", mine_radius / 0.72, Vector3(0.0, 0.18, 0.0), 0.0, false)
	_mines.append({"node": mine, "life": mine_life, "duration": mine_life, "radius": mine_radius, "damaged": {}})


func _spawn_pressure_hazard(position: Vector3, radius: float, duration: float, material_key := "hazard_leech", damage := 7.0, arm_time := 0.34, source := "") -> void:
	if _hazard_trails.size() >= HAZARD_TRAIL_CAP:
		var oldest: Dictionary = _hazard_trails.pop_front()
		var old_node: Node3D = oldest.get("node", null)
		if is_instance_valid(old_node):
			old_node.queue_free()
	var root := Node3D.new()
	root.name = "NeonPressureHazardRing"
	root.position = Vector3(position.x, 0.54, position.z)
	_fx_root.add_child(root)
	var material: Material = _materials[material_key] if _materials.has(material_key) else _materials["hazard_leech"]
	var ring := Kit.add_mesh(root, "ArmedNeonHazardAnnulus", Kit.torus_mesh(radius, 0.034, 42, 5), material)
	ring.rotation.x = PI * 0.5
	var core := Kit.add_mesh(root, "WhiteHotHazardWarningCore", Kit.torus_mesh(maxf(0.16, radius * 0.46), 0.016, 34, 4), _materials["burst_hot_core"])
	core.rotation.x = PI * 0.5
	_hazard_trails.append({
		"node": root,
		"life": duration,
		"duration": duration,
		"radius": radius,
		"damage": damage,
		"arm_time": arm_time,
		"hit_cd": 0.0,
		"source": source
	})


func _update_hazard_trails(delta: float) -> void:
	for i in range(_hazard_trails.size() - 1, -1, -1):
		var hazard := _hazard_trails[i]
		var node: Node3D = hazard["node"]
		if not is_instance_valid(node):
			_hazard_trails.remove_at(i)
			continue
		hazard["life"] = float(hazard["life"]) - delta
		hazard["hit_cd"] = maxf(0.0, float(hazard.get("hit_cd", 0.0)) - delta)
		var duration := maxf(0.001, float(hazard["duration"]))
		var phase := clampf(1.0 - float(hazard["life"]) / duration, 0.0, 1.0)
		var armed := phase >= float(hazard.get("arm_time", 0.0)) / duration
		node.rotation.y += delta * (1.8 if armed else 3.8)
		node.scale = Vector3.ONE * (lerpf(0.55, 1.0, minf(1.0, phase * 3.0)) + sin(_survival_time * 7.0) * 0.025)
		if armed and float(hazard["hit_cd"]) <= 0.0 and _xz_distance(node.position, _player_area.position) <= PLAYER_RADIUS + float(hazard["radius"]):
			hazard["hit_cd"] = 0.55
			_damage_player(float(hazard["damage"]))
		if float(hazard["life"]) <= 0.0:
			node.queue_free()
			_hazard_trails.remove_at(i)
		else:
			_hazard_trails[i] = hazard


func _update_beam_effects(delta: float) -> void:
	for i in range(_beam_effects.size() - 1, -1, -1):
		var effect := _beam_effects[i]
		var node: Node3D = effect["node"]
		if not is_instance_valid(node):
			_beam_effects.remove_at(i)
			continue
		if bool(effect.get("chain_link", false)) and _combat_overlay_active():
			node.queue_free()
			_beam_effects.remove_at(i)
			continue
		effect["life"] = float(effect["life"]) - delta
		var duration: float = maxf(0.001, float(effect["duration"]))
		var phase := clampf(1.0 - float(effect["life"]) / duration, 0.0, 1.0)
		if bool(effect.get("nova", false)):
			node.scale = Vector3.ONE * lerpf(0.6, float(effect.get("max_radius", NOVA_RADIUS * 1.55)), phase)
		elif bool(effect.get("chain_link", false)):
			node.scale = Vector3.ONE * lerpf(1.0, 0.88, phase)
		else:
			node.scale = Vector3.ONE * (1.0 + sin(_survival_time * 42.0) * 0.025)
		if float(effect["life"]) <= 0.0:
			node.queue_free()
			_beam_effects.remove_at(i)
		else:
			_beam_effects[i] = effect


func _clear_chain_link_effects() -> void:
	for i in range(_beam_effects.size() - 1, -1, -1):
		var effect := _beam_effects[i]
		if not bool(effect.get("chain_link", false)):
			continue
		var node: Node3D = effect.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
		_beam_effects.remove_at(i)


func _update_mines(delta: float) -> void:
	for i in range(_mines.size() - 1, -1, -1):
		var mine := _mines[i]
		var node: Area3D = mine["node"]
		if not is_instance_valid(node):
			_mines.remove_at(i)
			continue
		mine["life"] = float(mine["life"]) - delta
		var radius: float = mine["radius"]
		var phase := clampf(1.0 - float(mine["life"]) / float(mine["duration"]), 0.0, 1.0)
		node.rotation.y += delta * 2.2
		node.scale = Vector3.ONE * (1.0 + sin(_survival_time * 5.0) * 0.055)
		for enemy_index in range(_enemies.size() - 1, -1, -1):
			var enemy := _enemies[enemy_index]
			var enemy_node: Area3D = enemy["node"]
			if not is_instance_valid(enemy_node):
				continue
			var distance := _xz_distance(node.position, enemy_node.position)
			if distance <= radius:
				var to_mine := node.position - enemy_node.position
				to_mine.y = 0.0
				if to_mine.length_squared() > 0.001:
					enemy_node.position += to_mine.normalized() * float(mine.get("pull_speed", GRAVITY_PULL_SPEED)) * (1.0 - distance / radius) * delta
			var damaged: Dictionary = mine["damaged"]
			var enemy_id := enemy_node.get_instance_id()
			if phase > 0.88 and distance <= radius + float(enemy["radius"]) and not damaged.has(enemy_id):
				damaged[enemy_id] = true
				mine["damaged"] = damaged
				_damage_enemy_at(enemy_index, float(mine.get("damage", _scaled_damage(GRAVITY_MINE_DAMAGE) * _weapon_damage_multiplier("gravity_mine"))), str(mine.get("burst_key", "mine_body")))
		if float(mine["life"]) <= 0.0:
			_spawn_burst(node.position, 1.46, str(mine.get("burst_key", "mine_body")))
			_play_sfx("death", 0.12)
			_add_screen_shake(0.08, 0.14)
			node.queue_free()
			_mines.remove_at(i)
		else:
			_mines[i] = mine


func _update_enemies(delta: float) -> void:
	for i in range(_enemies.size() - 1, -1, -1):
		var enemy := _enemies[i]
		var node: Area3D = enemy["node"]
		if not is_instance_valid(node):
			_enemies.remove_at(i)
			continue
		var to_player := _player_area.position - node.position
		to_player.y = 0.0
		var distance := to_player.length()
		var direction := to_player.normalized() if distance > 0.001 else Vector3.ZERO
		var type_name: String = enemy["type"]
		var elite_variant := str(enemy.get("elite_variant", ""))
		var speed: float = enemy["speed"]
		var movement_direction := direction
		if type_name == "shooter" and distance < 9.5:
			speed *= 0.25
		if type_name == "mini_boss" and distance < 7.2:
			speed *= -0.25
		if type_name == "fractal_crown" and distance < 8.8:
			speed *= -0.16
		if _is_null_boss_type(type_name) and distance < 8.4:
			speed *= -0.18
		if type_name == "spiral_drifter" and direction.length_squared() > 0.01:
			var tangent := Vector3(-direction.z, 0.0, direction.x)
			var weave := sin(_survival_time * 3.8 + float(enemy.get("phase", 0.0))) * 0.82
			movement_direction = (direction + tangent * weave).normalized()
		elif type_name == "shield_node":
			speed *= 0.82 if distance < 5.8 else 1.0
		elif type_name == "prism_leech" and direction.length_squared() > 0.01:
			var tangent := Vector3(-direction.z, 0.0, direction.x)
			if distance < 3.6:
				movement_direction = (-direction + tangent * 0.36).normalized()
				speed *= 0.78
			elif distance < 6.0:
				movement_direction = (tangent * (0.74 + sin(_survival_time * 2.0 + float(enemy.get("phase", 0.0))) * 0.26)).normalized()
				speed *= 0.64
			else:
				movement_direction = (direction + tangent * 0.20).normalized()
		elif type_name == "triad_splitter" and direction.length_squared() > 0.01:
			var triad_tangent := Vector3(-direction.z, 0.0, direction.x)
			movement_direction = (direction + triad_tangent * sin(_survival_time * 2.8 + float(enemy.get("phase", 0.0))) * 0.48).normalized()
		elif type_name == "triad_fragment" and direction.length_squared() > 0.01:
			var fragment_tangent := Vector3(-direction.z, 0.0, direction.x)
			movement_direction = (direction + fragment_tangent * sin(_survival_time * 5.6 + float(enemy.get("phase", 0.0))) * 0.28).normalized()
		elif type_name == "grid_splitter" and direction.length_squared() > 0.01:
			var grid_lane := Vector3(signf(direction.x), 0.0, 0.0) if absf(direction.x) > absf(direction.z) else Vector3(0.0, 0.0, signf(direction.z))
			var grid_tangent := Vector3(-direction.z, 0.0, direction.x)
			movement_direction = (direction * 0.70 + grid_lane * 0.26 + grid_tangent * sin(_survival_time * 3.1 + float(enemy.get("phase", 0.0))) * 0.14).normalized()
			speed *= 0.92
		elif type_name == "grid_fragment" and direction.length_squared() > 0.01:
			var fragment_lane := Vector3(signf(direction.x), 0.0, 0.0) if absf(direction.x) > absf(direction.z) else Vector3(0.0, 0.0, signf(direction.z))
			var fragment_tangent := Vector3(-direction.z, 0.0, direction.x)
			movement_direction = (direction * 0.68 + fragment_lane * 0.18 + fragment_tangent * sin(_survival_time * 6.4 + float(enemy.get("phase", 0.0))) * 0.30).normalized()
		elif type_name == "hex_pulser" and direction.length_squared() > 0.01:
			var pulser_tangent := Vector3(-direction.z, 0.0, direction.x)
			if distance < 5.0:
				movement_direction = (-direction + pulser_tangent * 0.30).normalized()
				speed *= 0.52
			elif distance < 8.0:
				movement_direction = (pulser_tangent * (0.82 + sin(_survival_time * 2.4 + float(enemy.get("phase", 0.0))) * 0.18)).normalized()
				speed *= 0.68
			else:
				movement_direction = (direction + pulser_tangent * 0.24).normalized()
		elif type_name == "hex_slicer":
			enemy["dash_cd"] = maxf(0.0, float(enemy.get("dash_cd", 0.0)) - delta)
			enemy["dash_windup"] = maxf(0.0, float(enemy.get("dash_windup", 0.0)) - delta)
			enemy["dash_time"] = maxf(0.0, float(enemy.get("dash_time", 0.0)) - delta)
			if float(enemy["dash_time"]) > 0.0:
				movement_direction = enemy.get("dash_dir", direction)
				speed = 12.8
				enemy["flash"] = maxf(float(enemy["flash"]), 0.10)
			elif float(enemy["dash_windup"]) > 0.0:
				movement_direction = Vector3.ZERO
				speed = 0.0
				enemy["flash"] = maxf(float(enemy["flash"]), 0.16)
				if float(enemy["dash_windup"]) <= delta + 0.001:
					enemy["dash_time"] = 0.34
					enemy["dash_dir"] = direction
			elif distance < 15.0 and float(enemy["dash_cd"]) <= 0.0:
				enemy["dash_windup"] = 0.46
				enemy["dash_cd"] = randf_range(2.4, 3.2)
				enemy["dash_dir"] = direction
				_spawn_burst(node.position, 0.62, "burst_hex")
				movement_direction = Vector3.ZERO
				speed = 0.0
			elif direction.length_squared() > 0.01:
				var slicer_tangent := Vector3(-direction.z, 0.0, direction.x)
				movement_direction = (direction + slicer_tangent * sin(_survival_time * 4.0 + float(enemy.get("phase", 0.0))) * 0.34).normalized()
		elif type_name == "rail_skimmer":
			enemy["dash_cd"] = maxf(0.0, float(enemy.get("dash_cd", 0.0)) - delta)
			enemy["dash_windup"] = maxf(0.0, float(enemy.get("dash_windup", 0.0)) - delta)
			enemy["dash_time"] = maxf(0.0, float(enemy.get("dash_time", 0.0)) - delta)
			if float(enemy["dash_time"]) > 0.0:
				movement_direction = enemy.get("dash_dir", direction)
				speed = 16.2
				enemy["flash"] = maxf(float(enemy["flash"]), 0.12)
			elif float(enemy["dash_windup"]) > 0.0:
				movement_direction = Vector3.ZERO
				speed = 0.0
				enemy["flash"] = maxf(float(enemy["flash"]), 0.18)
				if float(enemy["dash_windup"]) <= delta + 0.001:
					enemy["dash_time"] = 0.30
			elif distance < 17.5 and float(enemy["dash_cd"]) <= 0.0:
				var dash_direction := _rail_skimmer_dash_direction(direction)
				enemy["dash_windup"] = 0.50
				enemy["dash_cd"] = randf_range(2.15, 2.95)
				enemy["dash_dir"] = dash_direction
				_spawn_rail_skimmer_dash_telegraph(node.position, dash_direction)
				_spawn_burst(node.position, 0.72, "rail_skimmer_warning")
				movement_direction = Vector3.ZERO
				speed = 0.0
			elif direction.length_squared() > 0.01:
				var rail_tangent := Vector3(-direction.z, 0.0, direction.x)
				movement_direction = (direction + rail_tangent * sin(_survival_time * 4.8 + float(enemy.get("phase", 0.0))) * 0.20).normalized()
		elif _is_null_boss_type(type_name) and direction.length_squared() > 0.01:
			var null_tangent := Vector3(-direction.z, 0.0, direction.x)
			movement_direction = (movement_direction + null_tangent * sin(_survival_time * 0.9) * 0.28).normalized()
		elif type_name == "fractal_crown" and direction.length_squared() > 0.01:
			var crown_tangent := Vector3(-direction.z, 0.0, direction.x)
			movement_direction = (movement_direction + crown_tangent * sin(_survival_time * 1.1 + float(enemy.get("phase", 0.0))) * (0.34 if bool(enemy.get("phase2", false)) else 0.24)).normalized()
		node.position += movement_direction * speed * delta
		node.position.x = clampf(node.position.x, -ARENA_HALF_SIZE + 0.7, ARENA_HALF_SIZE - 0.7)
		node.position.z = clampf(node.position.z, -ARENA_HALF_SIZE + 0.7, ARENA_HALF_SIZE - 0.7)
		if movement_direction.length_squared() > 0.01:
			node.rotation.y = _yaw_for_direction(movement_direction)

		enemy["contact_cd"] = maxf(0.0, float(enemy["contact_cd"]) - delta)
		enemy["flash"] = maxf(0.0, float(enemy["flash"]) - delta)
		var visual: Node3D = enemy["visual"]
		if is_instance_valid(visual):
			var flash_scale := 1.0 + clampf(float(enemy["flash"]) / 0.12, 0.0, 1.0) * 0.18
			if elite_variant != "":
				flash_scale += 0.045 + sin(_survival_time * 5.8 + float(enemy.get("phase", 0.0))) * 0.020
			if type_name == "shield_node" and float(enemy.get("shield_hp", 0.0)) > 0.0:
				flash_scale += sin(_survival_time * 4.0 + float(enemy.get("phase", 0.0))) * 0.035
			if type_name == "hex_pulser" and float(enemy.get("pulse_windup", 0.0)) > 0.0:
				flash_scale += 0.12 + sin(_survival_time * 18.0) * 0.045
			if type_name == "rail_skimmer" and (float(enemy.get("dash_windup", 0.0)) > 0.0 or float(enemy.get("dash_time", 0.0)) > 0.0):
				flash_scale += 0.10 + sin(_survival_time * 18.0) * 0.035
			if type_name == "fractal_crown" and bool(enemy.get("phase2", false)):
				flash_scale += 0.08 + sin(_survival_time * 8.0) * 0.035
			visual.scale = Vector3.ONE * float(enemy["visual_scale"]) * flash_scale
			var elite_marker := enemy.get("elite_marker", null) as Node3D
			if is_instance_valid(elite_marker):
				var marker_speed := 1.35 if elite_variant == "overcharged" else 1.05 if elite_variant == "volatile" else 0.78
				elite_marker.rotation.y += delta * marker_speed
				elite_marker.rotation.z += delta * 0.18
		if distance <= PLAYER_RADIUS + float(enemy["radius"]) and float(enemy["contact_cd"]) <= 0.0:
			enemy["contact_cd"] = 0.55
			_damage_player(float(enemy["damage"]))

		if type_name == "mini_boss":
			if not bool(enemy.get("boss_attack_pending", false)):
				enemy["boss_attack_cd"] = float(enemy["boss_attack_cd"]) - delta
				if float(enemy["boss_attack_cd"]) <= 0.0:
					var attack_index := int(enemy.get("boss_attack_index", 0))
					var attack_id := "prism_shard_fan"
					var cooldown := randf_range(2.35, 2.85)
					match attack_index % 3:
						1:
							attack_id = "prism_beam_lane"
							cooldown = randf_range(2.65, 3.15)
						2:
							attack_id = "prism_shield_pulse"
							cooldown = randf_range(2.90, 3.35)
					enemy = _schedule_boss_attack(enemy, node, attack_id, _player_area.position, 0.72, cooldown)
					enemy["boss_attack_index"] = attack_index + 1
		elif type_name == "fractal_crown":
			if not bool(enemy.get("phase2", false)) and float(enemy["hp"]) <= float(enemy["max_hp"]) * 0.50:
				enemy["phase2"] = true
				enemy["flash"] = 0.30
				enemy["boss_attack_cd"] = 0.72
				_spawn_burst(node.position, 2.00, "burst_fractal")
				_show_combat_notice("FRACTAL CROWN // PHASE SHIFT", Color(1.0, 0.42, 0.04), 1.45)
				_play_sfx("warning", 0.32)
				_add_screen_shake(0.14, 0.25)
			if not bool(enemy.get("boss_attack_pending", false)):
				enemy["boss_attack_cd"] = float(enemy["boss_attack_cd"]) - delta
				if float(enemy["boss_attack_cd"]) <= 0.0:
					var attack_index := int(enemy.get("fractal_attack_index", 0))
					var phase2 := bool(enemy.get("phase2", false))
					var attack_id := "fractal_burst"
					var cooldown := 2.60 if phase2 else 3.00
					match attack_index % 3:
						1:
							attack_id = "fractal_adds"
							cooldown = 3.25 if phase2 else 3.70
						2:
							attack_id = "fractal_line_pattern"
							cooldown = 2.70 if phase2 else 3.10
					enemy = _schedule_boss_attack(enemy, node, attack_id, _player_area.position, 0.76 if phase2 else 0.84, cooldown, phase2)
					enemy["fractal_attack_index"] = attack_index + 1
		elif _is_null_boss_type(type_name):
			if not bool(enemy.get("phase2", false)) and float(enemy["hp"]) <= float(enemy["max_hp"]) * 0.50:
				enemy["phase2"] = true
				enemy["flash"] = 0.28
				enemy["boss_attack_cd"] = 0.74
				_spawn_burst(node.position, 1.90 if type_name == "final_null_octagon" else 1.55, "burst_null")
				_show_combat_notice("%s // PHASE SHIFT" % _boss_name_for_type(type_name), _boss_notice_color(type_name), 1.45)
				_play_sfx("boss_warning", 0.30)
				_add_screen_shake(0.13 if type_name == "final_null_octagon" else 0.10, 0.22)
			if not bool(enemy.get("boss_attack_pending", false)):
				enemy["boss_attack_cd"] = float(enemy["boss_attack_cd"]) - delta
				if float(enemy["boss_attack_cd"]) <= 0.0:
					var attack_index := int(enemy.get("null_attack_index", 0))
					var phase2 := bool(enemy.get("phase2", false))
					var attack_id := "null_radial"
					var cooldown := 2.45 if type_name == "final_null_octagon" else 2.85
					if type_name == "final_null_octagon":
						match attack_index % 4:
							0:
								attack_id = "null_prime_multi_ring" if phase2 else "null_radial"
								cooldown = 2.55 if phase2 else 2.75
							1:
								attack_id = "null_void_pulse"
								cooldown = 2.82
							2:
								attack_id = "hyper_rail_sweep"
								cooldown = 2.72 if phase2 else 3.00
							_:
								attack_id = "null_adds"
								cooldown = 3.20
					else:
						match attack_index % 3:
							1:
								attack_id = "null_void_pulse"
								cooldown = 3.05 if not phase2 else 2.78
							2:
								attack_id = "null_adds"
								cooldown = 3.42 if not phase2 else 3.18
					enemy = _schedule_boss_attack(enemy, node, attack_id, _player_area.position, 0.82 if phase2 else 0.92, cooldown, phase2)
					enemy["null_attack_index"] = attack_index + 1
		elif type_name == "shooter":
			enemy["shoot_cd"] = float(enemy["shoot_cd"]) - delta
			if float(enemy["shoot_cd"]) <= 0.0 and distance < 18.0:
				enemy["shoot_cd"] = randf_range(1.5, 2.4)
				_spawn_enemy_projectile(node.position + direction * 0.9, direction)
		elif type_name == "prism_leech":
			enemy["hazard_cd"] = float(enemy.get("hazard_cd", 0.0)) - delta
			if float(enemy["hazard_cd"]) <= 0.0 and distance < 8.5:
				enemy["hazard_cd"] = randf_range(0.85, 1.28)
				_spawn_pressure_hazard(node.position, 1.08, 2.35, "hazard_leech", 7.0, 0.38)
		elif type_name == "hex_pulser":
			enemy["pulse_cd"] = maxf(0.0, float(enemy.get("pulse_cd", 0.0)) - delta)
			if float(enemy.get("pulse_windup", 0.0)) > 0.0:
				enemy["pulse_windup"] = maxf(0.0, float(enemy["pulse_windup"]) - delta)
				enemy["flash"] = maxf(float(enemy["flash"]), 0.12)
				if float(enemy["pulse_windup"]) <= 0.0:
					_spawn_hex_pulse(node.position)
			elif distance < 10.5 and float(enemy["pulse_cd"]) <= 0.0:
				enemy["pulse_windup"] = 0.58
				enemy["pulse_cd"] = randf_range(3.2, 4.2)
				_spawn_burst(node.position, 0.62, "hex_pulser")
		elif type_name == "exploder":
			enemy["explode_cd"] = maxf(0.0, float(enemy["explode_cd"]) - delta)
			if distance <= 2.1 and float(enemy["explode_cd"]) <= 0.0:
				_damage_player(26.0)
				_kill_enemy_at(i, true)
				continue

		_enemies[i] = enemy


func _update_projectiles(delta: float) -> void:
	for i in range(_player_projectiles.size() - 1, -1, -1):
		var projectile := _player_projectiles[i]
		var node: Area3D = projectile["node"]
		if not is_instance_valid(node):
			_player_projectiles.remove_at(i)
			continue
		var direction: Vector3 = projectile["direction"]
		var speed := float(projectile.get("speed", PULSE_SPEED))
		var hit_radius := float(projectile.get("radius", 0.32))
		node.position += direction * speed * delta
		projectile["life"] = float(projectile["life"]) - delta
		if projectile.has("arc_height"):
			var duration := maxf(0.001, float(projectile.get("duration", 1.0)))
			var phase := clampf(1.0 - float(projectile["life"]) / duration, 0.0, 1.0)
			node.position.y = float(projectile.get("base_y", 0.96)) + sin(phase * PI) * float(projectile.get("arc_height", 0.0))
		var consumed := false
		for enemy_index in range(_enemies.size() - 1, -1, -1):
			var enemy := _enemies[enemy_index]
			var enemy_node: Area3D = enemy["node"]
			if not is_instance_valid(enemy_node):
				continue
			if _xz_distance(node.position, enemy_node.position) <= float(enemy["radius"]) + hit_radius:
				var burst_key := str(projectile.get("burst_key", _burst_key_for_enemy(enemy["type"])))
				_apply_enemy_damage_at(enemy_index, float(projectile["damage"]), burst_key, 0.54)
				var kind := str(projectile.get("kind", ""))
				if kind == "hex_shatter":
					_spawn_hex_shatter_split(node.position, direction, int(projectile.get("split_count", 5)))
				elif kind == "fractal_shard":
					_spawn_fractal_shard_split(node.position, direction, int(projectile.get("split_count", 5)))
				elif kind == "hex_mortar":
					_spawn_hex_mortar_burst(node.position, direction, int(projectile.get("split_count", 6)))
				elif kind == "fractal_bloom":
					_spawn_fractal_bloom_split(node.position, direction, int(projectile.get("split_count", 6)))
				projectile["pierce"] = int(projectile["pierce"]) - 1
				if int(projectile["pierce"]) <= 0:
					consumed = true
				break
		var outside := _outside_arena(node.position, 2.0)
		if outside and int(projectile.get("bounce", 0)) > 0:
			var bounced_direction := direction
			if absf(node.position.x) > ARENA_HALF_SIZE:
				bounced_direction.x *= -1.0
				node.position.x = clampf(node.position.x, -ARENA_HALF_SIZE + 0.5, ARENA_HALF_SIZE - 0.5)
			if absf(node.position.z) > ARENA_HALF_SIZE:
				bounced_direction.z *= -1.0
				node.position.z = clampf(node.position.z, -ARENA_HALF_SIZE + 0.5, ARENA_HALF_SIZE - 0.5)
			projectile["direction"] = bounced_direction.normalized()
			projectile["bounce"] = int(projectile.get("bounce", 0)) - 1
			node.rotation.y = _yaw_for_direction(projectile["direction"])
			outside = false
		var expired := float(projectile["life"]) <= 0.0
		var kind_on_end := str(projectile.get("kind", ""))
		if not consumed and expired and kind_on_end == "hex_mortar":
			_spawn_hex_mortar_burst(node.position, direction, int(projectile.get("split_count", 6)))
			consumed = true
		if consumed or expired or outside:
			node.queue_free()
			_player_projectiles.remove_at(i)
		else:
			_player_projectiles[i] = projectile

	for i in range(_enemy_projectiles.size() - 1, -1, -1):
		var projectile := _enemy_projectiles[i]
		var node: Area3D = projectile["node"]
		if not is_instance_valid(node):
			_enemy_projectiles.remove_at(i)
			continue
		var direction: Vector3 = projectile["direction"]
		var speed := float(projectile.get("speed", 11.5))
		var hit_radius := float(projectile.get("radius", 0.32))
		node.position += direction * speed * delta
		projectile["life"] = float(projectile["life"]) - delta
		var hit_player := _xz_distance(node.position, _player_area.position) <= PLAYER_RADIUS + hit_radius
		if hit_player:
			_damage_player(float(projectile["damage"]))
		if hit_player or float(projectile["life"]) <= 0.0 or _outside_arena(node.position, 2.0):
			node.queue_free()
			_enemy_projectiles.remove_at(i)
		else:
			_enemy_projectiles[i] = projectile


func _kill_enemy_at(index: int, exploded: bool) -> void:
	if index < 0 or index >= _enemies.size():
		return
	var enemy := _enemies[index]
	var node: Area3D = enemy["node"]
	var position := node.position if is_instance_valid(node) else Vector3.ZERO
	var stats := _enemy_stats(enemy["type"])
	_kills += 1
	var enemy_type: String = enemy["type"]
	var elite_variant := str(enemy.get("elite_variant", ""))
	var is_elite := elite_variant != "" and not _is_boss_type(enemy_type)
	_score += int(enemy.get("score", stats.score))
	var is_mini_boss: bool = enemy_type == "mini_boss"
	var is_fractal_boss: bool = enemy_type == "fractal_crown"
	var is_null_boss: bool = _is_null_boss_type(enemy_type)
	var is_final_boss: bool = enemy_type == "final_null_octagon"
	var is_boss := _is_boss_type(enemy_type)
	var burst_scale := 2.55 if is_null_boss else 2.40 if is_fractal_boss else 2.20 if is_mini_boss else 1.32 if exploded else 0.98
	if is_elite:
		burst_scale += 0.22
	_spawn_burst(position, burst_scale, _burst_key_for_enemy(enemy["type"]))
	if is_elite:
		_handle_elite_death_feedback(enemy, position, elite_variant)
	if bool(enemy.get("run_event_target", false)):
		_handle_run_event_target_enemy_killed(enemy, position)
	_play_sfx("boss_death" if is_boss else "death", 0.12)
	_add_screen_shake(0.26 if is_null_boss else 0.23 if is_fractal_boss else 0.21 if is_mini_boss else 0.07 if exploded else 0.040, 0.34 if is_boss else 0.12)
	var xp_value := int(enemy.get("xp", stats.xp)) + (0 if is_boss else _enemy_xp_reward_bonus)
	_drop_xp(position, xp_value)
	if is_boss:
		_sector_boss_active = false
		if is_mini_boss:
			_mini_boss_active = false
		if is_null_boss:
			_null_octagon_active = false
			_null_octagon_defeated = is_final_boss
		var reward_count := (14 if is_final_boss else 10 if is_null_boss or is_fractal_boss else 6) + _mini_boss_reward_bonus
		for i in range(reward_count):
			var angle := TAU * float(i) / float(maxi(1, reward_count))
			_drop_xp(position + Vector3(cos(angle), 0.0, sin(angle)) * 1.2, 2)
		_show_combat_notice("FINAL BOSS DEFEATED // RUN COMPLETE" if is_final_boss else "%s DEFEATED // SECTOR REWARD UNLOCKED" % _boss_name_for_type(enemy_type), _boss_notice_color(enemy_type), 1.70)
	if is_instance_valid(node):
		node.queue_free()
	_enemies.remove_at(index)
	if enemy_type == "triad_splitter":
		_spawn_triad_fragments(position, elite_variant == "splitter_elite")
	if enemy_type == "grid_splitter":
		_spawn_grid_fragments(position, elite_variant == "overclocked_splitter")
	if is_boss:
		_handle_sector_boss_defeated(enemy_type)


func _handle_elite_death_feedback(enemy: Dictionary, position: Vector3, elite_variant: String) -> void:
	var elite_data := _elite_variant_data(elite_variant)
	var burst_key := str(elite_data.get("burst", "burst_cyan"))
	_spawn_burst(position, 1.12, burst_key)
	if elite_variant == "volatile":
		_spawn_pressure_hazard(position, 2.05, 0.72, "hazard_pulse", 8.0, 0.22)
		_add_screen_shake(0.052, 0.12)
	var dust_chance := float(enemy.get("elite_dust_chance", 0.0))
	var dust_value := int(enemy.get("elite_dust", 0))
	if dust_value > 0 and randf() < dust_chance:
		_grant_neon_dust(dust_value, true)
		_show_combat_notice("%s ELITE DOWN  +%d DUST" % [str(elite_data.get("label", "ELITE")), dust_value], _elite_notice_color(elite_variant), 1.30)
	else:
		_show_combat_notice("%s ELITE DOWN" % str(elite_data.get("label", "ELITE")), _elite_notice_color(elite_variant), 1.05)


func _spawn_triad_fragments(position: Vector3, elite_splitter := false) -> void:
	var active_fragments := _count_enemy_type("triad_fragment")
	var target_count := 4 if elite_splitter else 3
	var fragment_cap := 12 if elite_splitter else 10
	var fragment_count := mini(target_count, ENEMY_CAP - _enemies.size())
	fragment_count = mini(fragment_count, maxi(0, fragment_cap - active_fragments))
	for i in range(fragment_count):
		var angle := TAU * float(i) / float(maxi(1, target_count)) + randf_range(-0.18, 0.18)
		var offset := Vector3(cos(angle), 0.0, sin(angle)) * 0.88
		_spawn_enemy("triad_fragment", Vector3(clampf(position.x + offset.x, -ARENA_HALF_SIZE + 1.5, ARENA_HALF_SIZE - 1.5), 0.95, clampf(position.z + offset.z, -ARENA_HALF_SIZE + 1.5, ARENA_HALF_SIZE - 1.5)))
	if fragment_count > 0:
		_spawn_burst(position, 1.20 if elite_splitter else 1.10, "triad_fragment")


func _spawn_grid_fragments(position: Vector3, elite_splitter := false) -> void:
	var active_fragments := _count_enemy_type("grid_fragment")
	var target_count := 4 if elite_splitter else 3
	var fragment_cap := 14 if elite_splitter else 11
	var fragment_count := mini(target_count, ENEMY_CAP - _enemies.size())
	fragment_count = mini(fragment_count, maxi(0, fragment_cap - active_fragments))
	for i in range(fragment_count):
		var angle := TAU * float(i) / float(maxi(1, target_count)) + randf_range(-0.12, 0.12)
		var offset := Vector3(cos(angle), 0.0, sin(angle)) * 0.82
		var spawn_position := Vector3(clampf(position.x + offset.x, -ARENA_HALF_SIZE + 1.5, ARENA_HALF_SIZE - 1.5), 0.95, clampf(position.z + offset.z, -ARENA_HALF_SIZE + 1.5, ARENA_HALF_SIZE - 1.5))
		_spawn_enemy("grid_fragment", spawn_position)
	if fragment_count > 0:
		_spawn_burst(position, 1.22 if elite_splitter else 1.08, "grid_splitter")


func _handle_sector_boss_defeated(enemy_type: String) -> void:
	var sector := _current_sector()
	if enemy_type != str(sector["boss_type"]):
		return
	if _sector_index >= SECTOR_COUNT - 1:
		_null_octagon_defeated = true
		_complete_run()
		return
	_begin_sector_clear_reward()


func _begin_sector_clear_reward() -> void:
	if _sector_reward_active or _run_success or _game_over:
		return
	var sector := _current_sector()
	_clear_run_event_state()
	_clear_chain_link_effects()
	_sector_reward_active = true
	_level_up_active = true
	_upgrade_selected_index = 0
	_level_nav_cooldown = 0.0
	_upgrade_choices = _roll_sector_reward_choices(3)
	_sector_transition_message = str(sector["transition_message"])
	var dust_bonus := NEON_DUST_SECTOR_CLEAR_BASE + _sector_index * NEON_DUST_SECTOR_CLEAR_STEP
	_grant_neon_dust(dust_bonus, true)
	_sector_transition_cleanup_pending = true
	if _level_up_title:
		_level_up_title.text = "%s CLEAR" % _sector_display_title(_sector_index)
	if _level_up_prompt:
		var next_text := _sector_display_title(_sector_index + 1) if _sector_index + 1 < SECTOR_COUNT else "RUN COMPLETE VECTOR"
		_level_up_prompt.text = "BOSS DEFEATED: %s  //  REWARD UNLOCKED\n+%d NEON DUST BANKED  //  NEXT: %s  //  D-Pad / Left Stick: Select    A / Enter: Route Reward" % [str(sector.get("boss_name", "BOSS")).to_upper(), dust_bonus, next_text]
	for i in range(_upgrade_buttons.size()):
		var button := _upgrade_buttons[i]
		if i < _upgrade_choices.size():
			var upgrade := _upgrade_choices[i]
			button.text = _reward_choice_button_text(upgrade)
			_apply_choice_button_accent(button, upgrade)
			_update_upgrade_choice_icon(i, upgrade)
			button.visible = true
		else:
			_update_upgrade_choice_icon(i, {})
			button.visible = false
	if _level_up_panel:
		_level_up_panel.visible = true
	_focus_upgrade_choice()
	_spawn_burst(_player_area.position, 1.48, "burst_cyan")
	_set_music_state("gameplay")
	_play_sfx("sector", 0.35)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.16, 0.28)
	_trigger_sector_background_reaction(0.82, 1.05)
	_add_screen_shake(0.12, 0.24)
	get_tree().paused = true


func _roll_sector_reward_choices(amount: int) -> Array[Dictionary]:
	var pool := _sector_reward_pool()
	var choices: Array[Dictionary] = []
	if amount > 0:
		choices.append(_make_weapon_reward_choice())
	while choices.size() < amount and pool.size() > 0:
		var index := _upgrade_rng.randi_range(0, pool.size() - 1)
		choices.append(pool[index])
		pool.remove_at(index)
	return choices


func _reward_choice_button_text(choice: Dictionary) -> String:
	if str(choice.get("kind", "stat_upgrade")) == "weapon_loot":
		var instance: Dictionary = choice.get("weapon_instance", {})
		var rarity := str(instance.get("rarity", "Common")).to_upper()
		return "%s\nGENERATED WEAPON SYSTEM\n%s  //  %s\nChoose equip, stash, replace, or scrap next." % [
			str(choice.get("title", "WEAPON LOOT")).to_upper(),
			rarity,
			str(choice.get("category", "WEAPON")).to_upper()
		]
	return "%s\nRUN UPGRADE // %s\nEFFECT: %s" % [str(choice["title"]).to_upper(), str(choice["category"]).to_upper(), str(choice["description"]).to_upper()]


func _apply_choice_button_accent(button: Button, choice: Dictionary) -> void:
	if str(choice.get("kind", "stat_upgrade")) == "weapon_loot":
		var instance: Dictionary = choice.get("weapon_instance", {})
		var color := Color.html("#%s" % WeaponCatalog.rarity_accent_hex(str(instance.get("rarity", "Common"))))
		button.add_theme_color_override("font_color", color)
		button.add_theme_stylebox_override("normal", _button_style(Color(0.0, 0.010, 0.032, 0.86), Color(color.r, color.g, color.b, 0.92), 3, 84))
		button.add_theme_stylebox_override("focus", _button_style(Color(0.030, 0.012, 0.044, 0.96), Color(1.0, 0.92, 0.06, 1.0), 3, 84))
	else:
		button.add_theme_color_override("font_color", Color(0.86, 1.0, 1.0))
		button.add_theme_stylebox_override("normal", _button_style(Color(0.0, 0.010, 0.032, 0.84), Color(0.0, 0.82, 1.0, 0.72), 1, 84))
		button.add_theme_stylebox_override("focus", _button_style(Color(0.030, 0.012, 0.044, 0.94), Color(1.0, 0.92, 0.06, 1.0), 3, 84))


func _update_upgrade_choice_icon(index: int, choice: Dictionary) -> void:
	if index < 0 or index >= _upgrade_choice_icons.size():
		return
	if str(choice.get("kind", "stat_upgrade")) != "weapon_loot":
		_set_weapon_icon(_upgrade_choice_icons[index], "unknown_weapon", false)
		return
	var instance: Dictionary = choice.get("weapon_instance", {})
	_set_weapon_icon(_upgrade_choice_icons[index], instance, not instance.is_empty())


func _sector_reward_pool() -> Array[Dictionary]:
	var rewards: Array[Dictionary] = []
	rewards.assign(ContentCatalog.sector_reward_pool())
	return rewards


func _advance_to_next_sector() -> void:
	_sector_index = clampi(_sector_index + 1, 0, SECTOR_COUNT - 1)
	_sector_elapsed = 0.0
	_sector_boss_spawned = false
	_sector_boss_active = false
	_sector_boss_warning_played = false
	_mini_boss_spawned = false
	_mini_boss_active = false
	_mini_boss_warning_played = false
	_null_octagon_spawned = false
	_null_octagon_active = false
	_null_octagon_warning_played = false
	_null_octagon_warning_start = -1.0
	_wave_index = 0
	_wave_name = str(_current_sector()["intro_wave"])
	_spawn_timer = 0.65
	_reset_run_event_director_for_sector()
	_player_invuln = maxf(_player_invuln, 1.10)
	_apply_sector_visual_identity()
	_trigger_sector_transition_scan()
	_spawn_sector_opening_wave()
	_update_hud()
	_set_music_state("gameplay")
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.08, 0.18)
	_trigger_sector_background_reaction(0.62, 0.82)
	_show_sector_entry_notice(_sector_index)
	print("Neon Swarm sector transition: sector=%d name=%s clear_condition=%s" % [_sector_index + 1, _current_sector_name(), str(_current_sector()["clear_condition"])])


func _spawn_sector_opening_wave() -> void:
	var count := 10 if _sector_index >= 3 else 6 + _sector_index * 2
	if _sector_index == 1 and _enemies.size() < ENEMY_CAP:
		_spawn_enemy("hex_pulser", _spawn_position_on_edge())
	elif _sector_index == 2:
		if _enemies.size() < ENEMY_CAP:
			_spawn_enemy("hex_pulser", _spawn_position_on_edge())
		if _enemies.size() < ENEMY_CAP:
			_spawn_enemy("triad_splitter", _spawn_position_on_edge())
	elif _sector_index == 3:
		for enemy_type in ["rail_skimmer", "grid_splitter", "hex_slicer", "hex_pulser"]:
			if _enemies.size() < ENEMY_CAP:
				_spawn_enemy(enemy_type, _spawn_position_on_edge())
	for i in range(count):
		if _enemies.size() >= ENEMY_CAP:
			return
		_spawn_enemy(_enemy_type_for_sector_phase(_sector_index, 0), _spawn_position_on_edge())


func _clear_transition_combat_state() -> void:
	_clear_run_event_state()
	for i in range(_enemies.size() - 1, -1, -1):
		var enemy := _enemies[i]
		if _is_boss_type(str(enemy["type"])):
			continue
		var node: Node3D = enemy["node"]
		if is_instance_valid(node):
			node.queue_free()
		_enemies.remove_at(i)
	for projectile in _player_projectiles:
		var node: Node3D = projectile.get("node", null)
		if is_instance_valid(node):
			node.queue_free()
	_player_projectiles.clear()
	for mine in _mines:
		var mine_node: Node3D = mine.get("node", null)
		if is_instance_valid(mine_node):
			mine_node.queue_free()
	_mines.clear()
	for effect in _beam_effects:
		var effect_node: Node3D = effect.get("node", null)
		if is_instance_valid(effect_node):
			effect_node.queue_free()
	_beam_effects.clear()
	_clear_enemy_projectiles_and_hazards()


func _drop_xp(position: Vector3, value: int) -> void:
	if _xp_orbs.size() >= XP_CAP:
		return
	var orb := Area3D.new()
	orb.name = "XPOrb3DGameplayPickup"
	orb.position = Vector3(position.x + randf_range(-0.35, 0.35), 0.86, position.z + randf_range(-0.35, 0.35))
	orb.collision_layer = 16
	orb.collision_mask = 1
	_gameplay_root.add_child(orb)
	_add_sphere_collision(orb, "XPOrbCollisionSphere", 0.46)
	var visual := Node3D.new()
	visual.name = "XPOrb3DBlenderVisualRoot"
	visual.scale = Vector3.ONE * clampf(1.02 + float(value) * 0.075, 1.04, 1.34)
	orb.add_child(visual)
	_apply_xp_blender_model(visual)
	var pulse_materials := _prepare_xp_pulse_materials(visual)
	var trail := Kit.tube_between(orb, "XPCollectionEnergyTrail", Vector3.ZERO, Vector3(0.0, 0.0, 0.01), 0.022, _materials["xp_trail"], 6)
	trail.visible = false
	_xp_orbs.append({
		"node": orb,
		"visual": visual,
		"trail": trail,
		"value": value,
		"base_visual_scale": visual.scale.x,
		"pulse_materials": pulse_materials,
		"pulse_phase": randf() * TAU
	})
	if value >= 8:
		_spawn_burst(orb.position, 0.34, "burst_xp")


func _update_xp_orbs(delta: float) -> void:
	var active_trails := 0
	for i in range(_xp_orbs.size() - 1, -1, -1):
		var orb := _xp_orbs[i]
		var node: Area3D = orb["node"]
		if not is_instance_valid(node):
			_xp_orbs.remove_at(i)
			continue
		var visual := orb.get("visual", null) as Node3D
		if is_instance_valid(visual):
			visual.rotation = Vector3.ZERO
			visual.scale = Vector3.ONE * float(orb.get("base_visual_scale", visual.scale.x))
			var pulse_phase := _survival_time * XP_PULSE_SPEED + float(orb.get("pulse_phase", 0.0))
			var pulse_amount := lerpf(XP_PULSE_MIN, XP_PULSE_MAX, 0.5 + 0.5 * sin(pulse_phase))
			_apply_xp_brightness_pulse(orb.get("pulse_materials", []), pulse_amount)
		var to_player := _player_area.position - node.position
		to_player.y = 0.0
		var distance := to_player.length()
		var trail: MeshInstance3D = orb["trail"]
		var pickup_radius := _current_pickup_radius()
		if distance < pickup_radius:
			var strength := 1.0 - clampf(distance / pickup_radius, 0.0, 1.0)
			node.position += to_player.normalized() * (XP_PULL_SPEED + _xp_pull_speed_bonus) * (0.25 + strength) * delta
			if is_instance_valid(trail) and active_trails < XP_TRAIL_VISUAL_CAP and distance > 0.2:
				active_trails += 1
				var direction := to_player.normalized()
				var length := minf(distance, 2.10 + strength * 1.10)
				Kit.update_tube(trail, Vector3.ZERO, direction * length, 0.030 + strength * 0.028)
				trail.visible = true
			elif is_instance_valid(trail):
				trail.visible = false
		elif is_instance_valid(trail):
			trail.visible = false
		if _xz_distance(node.position, _player_area.position) <= XP_COLLECT_RADIUS:
			_collect_xp(int(orb["value"]))
			_spawn_burst(node.position, 0.72, "burst_xp")
			node.queue_free()
			_xp_orbs.remove_at(i)


func _collect_xp(value: int) -> void:
	_player_xp += value
	_score += value * 5
	_play_sfx("xp", 0.030)
	if not _level_up_active and _player_xp >= _xp_required:
		_player_xp -= _xp_required
		_player_level += 1
		_xp_required = int(ceil(float(_xp_required) * 1.16 + 5.0))
		_begin_level_up()


func _begin_level_up() -> void:
	_clear_chain_link_effects()
	_level_up_active = true
	_upgrade_selected_index = 0
	_level_nav_cooldown = 0.0
	_upgrade_choices = _roll_upgrade_choices(3)
	if _level_up_title:
		_level_up_title.text = "LEVEL %d UPGRADE" % _player_level
	if _level_up_prompt:
		_level_up_prompt.text = "D-Pad / Left Stick: Select    A / Enter: Confirm"
	for i in range(_upgrade_buttons.size()):
		var button := _upgrade_buttons[i]
		if i < _upgrade_choices.size():
			var upgrade := _upgrade_choices[i]
			button.text = "%s\n%s\n[%s]" % [upgrade["title"], upgrade["description"], upgrade["category"]]
			_apply_choice_button_accent(button, upgrade)
			_update_upgrade_choice_icon(i, upgrade)
			button.visible = true
		else:
			_update_upgrade_choice_icon(i, {})
			button.visible = false
	if _level_up_panel:
		_level_up_panel.visible = true
	_focus_upgrade_choice()
	_play_sfx("level", 0.25)
	_add_screen_shake(0.06, 0.16)
	get_tree().paused = true


func _roll_upgrade_choices(amount: int) -> Array[Dictionary]:
	var pool := _upgrade_pool.duplicate()
	var choices: Array[Dictionary] = []
	while choices.size() < amount and pool.size() > 0:
		var index := _upgrade_rng.randi_range(0, pool.size() - 1)
		choices.append(pool[index])
		pool.remove_at(index)
	return choices


func _handle_level_up_input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		_confirm_level_up_choice()
		get_viewport().set_input_as_handled()
		return
	if _level_nav_cooldown > 0.0:
		return
	if event.is_action_pressed("move_left"):
		_move_upgrade_selection(-1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_right"):
		_move_upgrade_selection(1)
		get_viewport().set_input_as_handled()


func _move_upgrade_selection(direction: int) -> void:
	if _upgrade_choices.is_empty():
		return
	_upgrade_selected_index = wrapi(_upgrade_selected_index + direction, 0, _upgrade_choices.size())
	_level_nav_cooldown = 0.18
	_focus_upgrade_choice()


func _focus_upgrade_choice() -> void:
	if _upgrade_buttons.is_empty() or _upgrade_choices.is_empty():
		return
	_upgrade_selected_index = clampi(_upgrade_selected_index, 0, _upgrade_choices.size() - 1)
	for i in range(_upgrade_buttons.size()):
		var button := _upgrade_buttons[i]
		if i == _upgrade_selected_index:
			button.grab_focus()


func _confirm_level_up_choice() -> void:
	if not _level_up_active or _upgrade_choices.is_empty():
		return
	_upgrade_selected_index = clampi(_upgrade_selected_index, 0, _upgrade_choices.size() - 1)
	var was_sector_reward := _sector_reward_active
	var selected_upgrade := _upgrade_choices[_upgrade_selected_index]
	if str(selected_upgrade.get("kind", "stat_upgrade")) == "weapon_loot":
		_open_weapon_reward_decision(selected_upgrade, was_sector_reward)
		return
	_apply_upgrade(selected_upgrade)
	_finish_level_up_choice(was_sector_reward)


func _finish_level_up_choice(was_sector_reward: bool) -> void:
	_upgrade_choices.clear()
	if _level_up_panel:
		_level_up_panel.visible = false
	_level_up_active = false
	if was_sector_reward:
		_sector_reward_active = false
		_manual_pause = false
		_advance_to_next_sector()
		get_tree().paused = false
	else:
		get_tree().paused = _manual_pause
	_update_orbit_visual_visibility()
	_update_hud()


func _apply_upgrade(upgrade: Dictionary) -> void:
	if str(upgrade.get("kind", "stat_upgrade")) == "weapon_loot":
		_apply_weapon_reward(upgrade)
		return
	var effects: Dictionary = upgrade["effects"]
	_damage_multiplier += float(effects.get("damage_multiplier_add", 0.0))
	_fire_rate_multiplier += float(effects.get("fire_rate_multiplier_add", 0.0))
	_projectile_count_bonus += int(effects.get("projectile_count_add", 0))
	_pickup_radius_bonus += float(effects.get("pickup_radius_add", 0.0))
	_speed_bonus += float(effects.get("speed_add", 0.0))
	if effects.has("max_health_add"):
		_player_max_health += float(effects["max_health_add"])
	if effects.has("heal_add"):
		_player_health = minf(_player_max_health, _player_health + float(effects["heal_add"]))
	_orbit_count = clampi(_orbit_count + int(effects.get("orbit_count_add", 0)), 1, ORBIT_VISUAL_CAP)
	_nova_cooldown_multiplier = clampf(_nova_cooldown_multiplier + float(effects.get("nova_cooldown_multiplier_add", 0.0)), 0.48, 1.0)
	_beam_duration_bonus = minf(0.34, _beam_duration_bonus + float(effects.get("beam_duration_add", 0.0)))
	_mine_radius_bonus = minf(1.80, _mine_radius_bonus + float(effects.get("mine_radius_add", 0.0)))
	_prism_lance_damage_multiplier += float(effects.get("prism_lance_damage_multiplier_add", 0.0))
	_prism_lance_pierce_bonus = mini(4, _prism_lance_pierce_bonus + int(effects.get("prism_lance_pierce_add", 0)))
	_ring_saw_radius_bonus = minf(1.25, _ring_saw_radius_bonus + float(effects.get("ring_saw_radius_add", 0.0)))
	_ring_saw_spin_bonus = minf(0.72, _ring_saw_spin_bonus + float(effects.get("ring_saw_spin_add", 0.0)))
	_hex_shatter_damage_multiplier += float(effects.get("hex_shatter_damage_multiplier_add", 0.0))
	_hex_shatter_cooldown_multiplier = clampf(_hex_shatter_cooldown_multiplier + float(effects.get("hex_shatter_cooldown_multiplier_add", 0.0)), 0.46, 1.0)
	_hex_shatter_split_bonus = mini(6, _hex_shatter_split_bonus + int(effects.get("hex_shatter_split_add", 0)))
	if bool(effects.get("fractal_shard_enable", false)):
		_fractal_shard_enabled = true
		if _weapon_state.has("fractal_shard"):
			var fractal_state: Dictionary = _weapon_state["fractal_shard"]
			fractal_state["enabled"] = true
			fractal_state["timer"] = minf(float(fractal_state.get("timer", 0.0)), 0.28)
			_weapon_state["fractal_shard"] = fractal_state
	_fractal_shard_damage_multiplier += float(effects.get("fractal_shard_damage_multiplier_add", 0.0))
	_fractal_shard_cooldown_multiplier = clampf(_fractal_shard_cooldown_multiplier + float(effects.get("fractal_shard_cooldown_multiplier_add", 0.0)), 0.52, 1.0)
	_fractal_shard_split_bonus = mini(4, _fractal_shard_split_bonus + int(effects.get("fractal_shard_split_add", 0)))
	_fractal_shard_life_bonus = minf(0.55, _fractal_shard_life_bonus + float(effects.get("fractal_shard_life_add", 0.0)))
	_fractal_shard_pierce_bonus = mini(2, _fractal_shard_pierce_bonus + int(effects.get("fractal_shard_pierce_add", 0)))
	_xp_pull_speed_bonus = minf(6.0, _xp_pull_speed_bonus + float(effects.get("xp_pull_speed_add", 0.0)))
	_enemy_xp_reward_bonus = mini(3, _enemy_xp_reward_bonus + int(effects.get("enemy_xp_bonus_add", 0)))
	_mini_boss_reward_bonus = mini(12, _mini_boss_reward_bonus + int(effects.get("mini_boss_reward_bonus_add", 0)))
	_spawn_burst(_player_area.position, 1.04, "burst_cyan")
	_play_sfx("reward", 0.10)
	_trigger_presentation_flash(Color(1.0, 0.94, 0.18), 0.08, 0.16)
	_show_combat_notice(_upgrade_result_notice_text(upgrade), Color(1.0, 0.94, 0.18), 1.70)


func _upgrade_result_notice_text(upgrade: Dictionary) -> String:
	return "RUN UPGRADE APPLIED // %s // %s" % [str(upgrade.get("title", "UPGRADE")).to_upper(), str(upgrade.get("description", "CURRENT RUN IMPROVED")).to_upper()]


func _update_orbit_visual_visibility() -> void:
	if not _is_weapon_family_equipped("orbit_spark"):
		for node in _orbit_nodes:
			if is_instance_valid(node):
				node.visible = false
		return
	for i in range(_orbit_nodes.size()):
		_orbit_nodes[i].visible = i < clampi(_orbit_count + _weapon_int_stat_bonus("orbit_spark", "orbit_count_bonus", 1), 1, ORBIT_VISUAL_CAP)


func _spawn_burst(position: Vector3, scale: float, burst_key := "burst") -> void:
	if _bursts.size() >= BURST_CAP:
		return
	var spark_material: Material = _materials[burst_key] if _materials.has(burst_key) else _materials["burst"]
	var high_load := _enemies.size() > int(ENEMY_CAP * 0.72) or _bursts.size() > int(BURST_CAP * 0.66)
	var is_xp := burst_key == "burst_xp"
	var root := Node3D.new()
	root.name = "GameplayDeathOrImpactBurst3D"
	root.position = Vector3(position.x, 0.92, position.z)
	root.scale = Vector3.ONE * scale
	_fx_root.add_child(root)
	Kit.add_mesh(root, "BurstWhiteHotPop", Kit.sphere_mesh(0.22 if is_xp else 0.20, 12, 6), _materials["burst_hot_core"])
	var inner_ring := Kit.add_mesh(root, "BurstWhiteHotSnapRing", Kit.torus_mesh(0.30, 0.030, 36, 4), _materials["burst_hot_core"])
	inner_ring.rotation.x = PI * 0.5
	var ring := Kit.add_mesh(root, "BurstShortPlasmaRing", Kit.torus_mesh(0.54, 0.052, 42, 5), _materials["burst_ring"])
	ring.rotation.x = PI * 0.5
	var color_ring := Kit.add_mesh(root, "BurstColorMatchedFlashRing", Kit.torus_mesh(0.80, 0.034, 42, 4), spark_material)
	color_ring.rotation.x = PI * 0.5
	var cover_ring := Kit.add_mesh(root, "BurstCoverArtMagentaEdgeFlash", Kit.torus_mesh(0.66, 0.018, 34, 4), _materials["burst_magenta"])
	cover_ring.rotation.z = PI * 0.5
	var spark_count := 18 if high_load else 26
	var shard_count := 6 if high_load else 11
	match _vfx_intensity:
		0:
			spark_count = maxi(10, int(float(spark_count) * 0.62))
			shard_count = maxi(3, int(float(shard_count) * 0.58))
		2:
			spark_count = mini(30, int(float(spark_count) * 1.14))
			shard_count = mini(13, int(float(shard_count) * 1.12))
	var sparks := Kit.create_spark_multimesh(root, "BurstPooledSparkFragments", Kit.capsule_mesh(0.030, 0.52, 7, 2), spark_material, spark_count)
	var shards := Kit.create_spark_multimesh(root, "BurstGeometricNeonShardFragments", Kit.triangular_prism_mesh(0.18, 0.12, 0.32), spark_material, shard_count)
	var dirs: Array[Vector3] = []
	for i in range(spark_count):
		var angle := TAU * float(i) / float(spark_count)
		dirs.append(Vector3(cos(angle), randf_range(0.02, 0.58), sin(angle)).normalized())
	var shard_dirs: Array[Vector3] = []
	for i in range(shard_count):
		var angle := TAU * (float(i) / float(shard_count) + randf_range(-0.025, 0.025))
		shard_dirs.append(Vector3(cos(angle), randf_range(0.10, 0.70), sin(angle)).normalized())
	_bursts.append({
		"node": root,
		"sparks": sparks,
		"dirs": dirs,
		"shards": shards,
		"shard_dirs": shard_dirs,
		"life": 0.28 if is_xp else 0.42 if scale < 1.6 else 0.54,
		"duration": 0.28 if is_xp else 0.42 if scale < 1.6 else 0.54
	})


func _update_bursts(delta: float) -> void:
	for i in range(_bursts.size() - 1, -1, -1):
		var burst := _bursts[i]
		var node: Node3D = burst["node"]
		if not is_instance_valid(node):
			_bursts.remove_at(i)
			continue
		burst["life"] = float(burst["life"]) - delta
		var duration: float = burst["duration"]
		var phase := clampf(1.0 - float(burst["life"]) / duration, 0.0, 1.0)
		node.rotation.y += delta * 3.4
		node.scale *= 1.0 + delta * 3.35
		var sparks: MultiMeshInstance3D = burst["sparks"]
		var dirs: Array = burst["dirs"]
		if is_instance_valid(sparks):
			for j in range(dirs.size()):
				var direction: Vector3 = dirs[j]
				var pos := direction * sin(phase * PI) * (1.55 + float(j % 4) * 0.34)
				var basis := Kit.basis_from_y_axis(direction)
				var spark_scale := maxf(0.01, sin(phase * PI) * 1.46)
				sparks.multimesh.set_instance_transform(j, Transform3D(basis.scaled(Vector3.ONE * spark_scale), pos))
		var shards: MultiMeshInstance3D = burst.get("shards", null)
		var shard_dirs: Array = burst.get("shard_dirs", [])
		if is_instance_valid(shards):
			for j in range(shard_dirs.size()):
				var direction: Vector3 = shard_dirs[j]
				var pos := direction * sin(phase * PI) * (0.92 + float(j % 3) * 0.42)
				var basis := Kit.basis_from_y_axis(direction).rotated(direction, phase * TAU * (1.0 + float(j % 2)))
				var shard_scale := maxf(0.01, sin(phase * PI) * 0.92)
				shards.multimesh.set_instance_transform(j, Transform3D(basis.scaled(Vector3.ONE * shard_scale), pos))
		if float(burst["life"]) <= 0.0:
			node.queue_free()
			_bursts.remove_at(i)
		else:
			_bursts[i] = burst


func _add_screen_shake(strength: float, duration: float) -> void:
	if not _screen_shake_enabled:
		return
	var multiplier := 0.55 if _vfx_intensity == 0 else 1.12 if _vfx_intensity == 2 else 1.0
	_shake_strength = minf(SCREEN_SHAKE_MAX, maxf(_shake_strength, strength * multiplier))
	_shake_duration = maxf(_shake_duration, duration)
	_shake_time = maxf(_shake_time, duration)


func _update_camera_shake(delta: float) -> void:
	if not is_instance_valid(_camera):
		return
	if _shake_time <= 0.0:
		_camera.position = _camera_base_position
		return
	_shake_time = maxf(0.0, _shake_time - delta)
	var phase := _shake_time / maxf(0.001, _shake_duration)
	var amount := _shake_strength * phase * phase
	var offset := Vector3(randf_range(-amount, amount), randf_range(-amount * 0.16, amount * 0.16), randf_range(-amount, amount))
	_camera.position = _camera_base_position + offset
	if _shake_time <= 0.0:
		_shake_strength = 0.0
		_shake_duration = 0.0
		_camera.position = _camera_base_position


func _check_run_goal() -> void:
	if _run_success or _game_over:
		return
	if _sector_index >= SECTOR_COUNT - 1 and _null_octagon_defeated and not _sector_boss_active:
		_complete_run()


func _run_sectors_cleared_count(success := false) -> int:
	if success:
		return SECTOR_COUNT
	return clampi(_sector_index, 0, SECTOR_COUNT)


func _finalize_run_neon_dust(success: bool) -> void:
	if _run_economy_finalized:
		return
	_run_economy_finalized = true
	var bonus := 0
	if success:
		bonus = NEON_DUST_RUN_COMPLETE_BONUS + int(_kills / 24)
	else:
		bonus = int(_kills / NEON_DUST_DEATH_KILL_DIVISOR) + _run_sectors_cleared_count(false) * 6
		if _kills > 0:
			bonus = maxi(3, bonus)
	_grant_neon_dust(bonus, true)


func _update_run_end_summary(success: bool) -> void:
	var label := _success_summary_label if success else _game_over_summary_label
	if not is_instance_valid(label):
		return
	label.text = "RESULT: %s\nSCORE: %06d  //  KILLS: %d\nSECTORS CLEARED: %d / %d\nWEAPONS GAINED: %d\nNEON DUST EARNED: +%d  //  CURRENT TOTAL: %d" % [
		"RUN COMPLETE" if success else "RUN TERMINATED",
		_score,
		_kills,
		_run_sectors_cleared_count(success),
		SECTOR_COUNT,
		_run_weapons_gained,
		_run_neon_dust_gained,
		_neon_dust
	]


func _complete_run() -> void:
	if _run_success or _game_over:
		return
	_run_success = true
	_clear_run_event_state()
	_clear_enemy_projectiles_and_hazards()
	_clear_chain_link_effects()
	_finalize_run_neon_dust(true)
	_update_run_end_summary(true)
	if _success_panel:
		_success_panel.visible = true
	_spawn_burst(_player_area.position, 1.72, "burst_cyan")
	_set_music_state("none")
	_play_music_sting("run_complete")
	_play_sfx("run_complete", 0.45)
	_trigger_presentation_flash(Color(1.0, 0.94, 0.18), 0.22, 0.34)
	_trigger_sector_background_reaction(1.0, 1.20)
	_add_screen_shake(0.14, 0.30)
	get_tree().paused = true
	print(get_review_build_summary())


func _damage_player(amount: float) -> void:
	if get_tree().paused or _player_invuln > 0.0 or _game_over or _run_success:
		return
	_player_health = maxf(0.0, _player_health - amount)
	_player_invuln = PLAYER_INVULN_TIME
	_spawn_burst(_player_area.position, 0.88, "burst_red")
	_play_sfx("damage", 0.16)
	_trigger_presentation_flash(Color(1.0, 0.06, 0.12), 0.055, 0.12)
	_trigger_sector_background_reaction(0.38, 0.34)
	_add_screen_shake(0.10, 0.18)
	if _player_health <= 0.0:
		_game_over = true
		_clear_run_event_state()
		_clear_chain_link_effects()
		_finalize_run_neon_dust(false)
		_update_run_end_summary(false)
		_game_over_panel.visible = true
		_set_music_state("none")
		_play_music_sting("death")
		_play_sfx("death", 0.20)
		_trigger_presentation_flash(Color(1.0, 0.06, 0.12), 0.20, 0.30)
		_trigger_sector_background_reaction(0.90, 0.90)
		print(get_review_build_summary())


func _is_start_button_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton and event.pressed and event.button_index == JOY_BUTTON_START


func _restart_run() -> void:
	_play_sfx("ui_select", 0.08)
	get_tree().paused = false
	_manual_pause = false
	_help_visible = false
	_level_up_active = false
	_sector_reward_active = false
	_clear_weapon_reward_decision_state()
	_clear_run_event_state()
	_run_success = false
	call_deferred("_reload_official_scene")


func _reload_official_scene() -> void:
	var error := get_tree().reload_current_scene()
	if error != OK:
		error = get_tree().change_scene_to_file("res://scenes/Main.tscn")
	if error != OK:
		push_error("Failed to restart Neon Swarm run. Error code: %d" % error)


func _toggle_pause() -> void:
	if _game_over or _run_success:
		return
	if _level_up_active:
		return
	if _manual_pause:
		_resume_gameplay_from_pause()
		return
	_manual_pause = true
	_pause_options_visible = false
	_pause_menu_selected_index = 0
	_pause_nav_cooldown = 0.0
	_clear_chain_link_effects()
	get_tree().paused = true
	_update_pause_menu_labels()
	_focus_pause_menu_choice()
	_play_sfx("pause", 0.08)
	_trigger_presentation_flash(Color(0.0, 0.94, 1.0), 0.045, 0.14)


func _update_hud() -> void:
	if _timer_label:
		var seconds := int(_survival_time)
		_timer_label.text = "%02d:%02d" % [seconds / 60, seconds % 60]
	if _sector_label:
		_sector_label.text = "SECTOR %02d   %s" % [_sector_index + 1, _current_sector_name().to_upper()]
		_sector_label.add_theme_color_override("font_color", _sector_hud_color())
	if _level_label:
		_level_label.text = "LV %02d" % _player_level
	if _enemy_label:
		_enemy_label.text = "HOSTILES    %03d / %03d" % [_enemies.size(), ENEMY_CAP]
	if _audio_label:
		_audio_label.text = "AUDIO       MUTED" if _audio_muted else "AUDIO       ONLINE"
		_audio_label.add_theme_color_override("font_color", Color(1.0, 0.56, 0.16) if _audio_muted else Color(0.82, 0.96, 1.0))
	if _health_bar:
		_health_bar.max_value = _player_max_health
		_health_bar.value = _player_health
	if _health_text_label:
		_health_text_label.text = "HEALTH  %03d / %03d" % [int(ceil(_player_health)), int(ceil(_player_max_health))]
	if _xp_bar:
		_xp_bar.max_value = float(_xp_required)
		_xp_bar.value = float(_player_xp)
	if _xp_text_label:
		_xp_text_label.text = "SYNC XP %03d / %03d" % [_player_xp, _xp_required]
	if _kills_label:
		_kills_label.text = "KILLS       %03d" % _kills
	if _score_label:
		_score_label.text = "SCORE       %06d" % _score
	_update_loadout_chips()
	_update_boss_hud()


func _update_loadout_chips() -> void:
	_set_loadout_chip("damage", "%.0f%%" % (_damage_multiplier * 100.0))
	_set_loadout_chip("rate", "%.0f%%" % (_fire_rate_multiplier * 100.0))
	_set_loadout_chip("speed", "%.1f" % _current_player_speed())
	_set_loadout_chip("pickup", "%.1f" % _current_pickup_radius())
	_set_loadout_chip("orbit", "%d" % clampi(_orbit_count + _weapon_int_stat_bonus("orbit_spark", "orbit_count_bonus", 1), 1, ORBIT_VISUAL_CAP) if _is_weapon_family_equipped("orbit_spark") else "OFF")
	_set_loadout_chip("lance", "x%.0f" % (_prism_lance_damage_multiplier * 100.0) if _is_weapon_family_equipped("prism_lance") else "OFF")
	_set_loadout_chip("saw", "%.1f" % ((RING_SAW_RADIUS + _ring_saw_radius_bonus) * _weapon_range_multiplier("ring_saw")) if _is_weapon_family_equipped("ring_saw") else "OFF")
	_set_loadout_chip("mine", "%.1f" % ((GRAVITY_MINE_RADIUS + _mine_radius_bonus) * _weapon_range_multiplier("gravity_mine")) if _is_weapon_family_equipped("gravity_mine") else "OFF")


func _set_loadout_chip(key: String, value: String) -> void:
	if not _loadout_chips.has(key):
		return
	var chip: NeonStatChip = _loadout_chips[key]
	if is_instance_valid(chip):
		chip.set_value(value)


func _sector_hud_color() -> Color:
	return _sector_color_for_index(_sector_index)


func _update_boss_hud() -> void:
	var boss: Dictionary = {}
	for enemy in _enemies:
		if _is_null_boss_type(str(enemy["type"])):
			boss = enemy
			break
		if _is_boss_type(str(enemy["type"])) and boss.is_empty():
			boss = enemy
	var visible := not boss.is_empty()
	if not visible and _sector_boss_warning_played and not _sector_boss_spawned:
		if _boss_panel:
			_boss_panel.visible = true
			_boss_panel.set("animated", true)
		if _boss_label:
			_boss_label.visible = true
			_boss_label.text = "WARNING: %s INBOUND" % str(_current_sector()["boss_name"])
		if _boss_bar:
			_boss_bar.visible = true
			_boss_bar.max_value = 1.0
			_boss_bar.value = 0.25 + (sin(_survival_time * 5.2) * 0.5 + 0.5) * 0.55
		return
	if _boss_panel:
		_boss_panel.visible = visible
		_boss_panel.set("animated", visible)
	if _boss_label:
		_boss_label.visible = visible
	if _boss_bar:
		_boss_bar.visible = visible
	if not visible:
		return
	var hp := float(boss["hp"])
	var max_hp := float(boss["max_hp"])
	if _boss_label:
		var label_text := _boss_name_for_type(str(boss["type"]))
		if bool(boss.get("phase2", false)):
			label_text += " // PHASE 2"
		_boss_label.text = label_text
	if _boss_bar:
		_boss_bar.max_value = max_hp
		_boss_bar.value = clampf(hp, 0.0, max_hp)


func _xz_distance(a: Vector3, b: Vector3) -> float:
	return Vector2(a.x, a.z).distance_to(Vector2(b.x, b.z))


func _outside_arena(position: Vector3, margin: float) -> bool:
	return position.x < -ARENA_HALF_SIZE - margin or position.x > ARENA_HALF_SIZE + margin or position.z < -ARENA_HALF_SIZE - margin or position.z > ARENA_HALF_SIZE + margin


func _yaw_for_direction(direction: Vector3) -> float:
	var dir := direction.normalized()
	return atan2(-dir.x, -dir.z)
