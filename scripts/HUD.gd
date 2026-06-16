extends CanvasLayer

const CYAN := Color(0.05, 0.96, 1.0)
const MAGENTA := Color(1.0, 0.06, 0.86)
const GOLD := Color(1.0, 0.95, 0.18)
const DANGER := Color(1.0, 0.08, 0.22)
const GRID_BLUE := Color(0.20, 0.58, 1.0)
const PANEL_DARK := Color(0.0, 0.004, 0.018, 0.12)

var player: CharacterBody2D
var main_ref: Node

var hp_bar: ProgressBar
var xp_bar: ProgressBar
var hp_label: Label
var xp_label: Label
var level_label: Label
var timer_label: Label
var score_label: Label
var kills_label: Label
var enemies_label: Label
var stats_label: Label
var pause_panel: PanelContainer
var pause_label: Label
var level_flash_rect: ColorRect
var level_flash_timer := 0.0
var game_over_panel: PanelContainer
var game_over_label: Label


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 10
	_build_hud()


func _process(delta: float) -> void:
	if level_flash_timer <= 0.0:
		return

	level_flash_timer = maxf(0.0, level_flash_timer - delta)
	var alpha := level_flash_timer / 0.55
	level_flash_rect.color = Color(0.0, 0.96, 1.0, 0.08 * alpha)
	level_flash_rect.visible = level_flash_timer > 0.0


func setup(player_node: CharacterBody2D, main_node: Node) -> void:
	player = player_node
	main_ref = main_node
	player.health_changed.connect(_on_health_changed)
	player.xp_changed.connect(_on_xp_changed)
	player.stats_changed.connect(_on_stats_changed)
	_on_health_changed(player.health, player.max_health)
	_on_xp_changed(player.xp, player.xp_required, player.level)
	_on_stats_changed()


func update_match(time_seconds: float, kills: int, score: int, enemy_count: int) -> void:
	timer_label.text = _format_time(time_seconds)
	kills_label.text = "KILLS %d" % kills
	score_label.text = "SCORE %d" % score
	enemies_label.text = "ENEMIES %d" % enemy_count


func show_game_over(time_seconds: float, kills: int, score: int) -> void:
	show_pause(false)
	game_over_label.text = "CORE DESTROYED\nTIME %s   KILLS %d   SCORE %d" % [_format_time(time_seconds), kills, score]
	game_over_panel.visible = true


func show_pause(paused: bool) -> void:
	if pause_panel:
		pause_panel.visible = paused


func show_level_flash() -> void:
	level_flash_timer = 0.55
	if level_flash_rect:
		level_flash_rect.visible = true
		level_flash_rect.color = Color(0.0, 0.96, 1.0, 0.08)


func _build_hud() -> void:
	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(root)

	var top_margin := MarginContainer.new()
	top_margin.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top_margin.offset_left = 12.0
	top_margin.offset_top = 10.0
	top_margin.offset_right = -12.0
	top_margin.offset_bottom = 88.0
	root.add_child(top_margin)

	var top_row := HBoxContainer.new()
	top_row.add_theme_constant_override("separation", 10)
	top_margin.add_child(top_row)

	var left_panel := PanelContainer.new()
	left_panel.custom_minimum_size = Vector2(318.0, 76.0)
	left_panel.add_theme_stylebox_override("panel", _panel_style(CYAN))
	top_row.add_child(left_panel)

	var left_margin := MarginContainer.new()
	left_margin.add_theme_constant_override("margin_left", 10)
	left_margin.add_theme_constant_override("margin_top", 6)
	left_margin.add_theme_constant_override("margin_right", 10)
	left_margin.add_theme_constant_override("margin_bottom", 6)
	left_panel.add_child(left_margin)

	var gauges := VBoxContainer.new()
	gauges.add_theme_constant_override("separation", 4)
	left_margin.add_child(gauges)

	level_label = _make_label("LEVEL 1", 16, GOLD)
	gauges.add_child(level_label)

	hp_label = _make_label("HP", 12, Color(1.0, 0.82, 0.88))
	gauges.add_child(hp_label)
	hp_bar = _make_bar(DANGER)
	gauges.add_child(hp_bar)

	xp_label = _make_label("XP", 12, Color(0.92, 1.0, 0.74))
	gauges.add_child(xp_label)
	xp_bar = _make_bar(GOLD)
	gauges.add_child(xp_bar)

	var middle_panel := PanelContainer.new()
	middle_panel.custom_minimum_size = Vector2(210.0, 76.0)
	middle_panel.add_theme_stylebox_override("panel", _panel_style(MAGENTA))
	top_row.add_child(middle_panel)

	var middle_margin := MarginContainer.new()
	middle_margin.add_theme_constant_override("margin_left", 10)
	middle_margin.add_theme_constant_override("margin_top", 6)
	middle_margin.add_theme_constant_override("margin_right", 10)
	middle_margin.add_theme_constant_override("margin_bottom", 6)
	middle_panel.add_child(middle_margin)

	var match_stats := VBoxContainer.new()
	match_stats.add_theme_constant_override("separation", 3)
	middle_margin.add_child(match_stats)

	timer_label = _make_label("00:00", 23, Color.WHITE)
	match_stats.add_child(timer_label)
	kills_label = _make_label("KILLS 0", 12, Color(0.82, 0.98, 1.0))
	match_stats.add_child(kills_label)
	score_label = _make_label("SCORE 0", 12, Color(0.82, 0.98, 1.0))
	match_stats.add_child(score_label)
	enemies_label = _make_label("ENEMIES 0", 12, Color(0.82, 0.98, 1.0))
	match_stats.add_child(enemies_label)

	var stat_panel := PanelContainer.new()
	stat_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	stat_panel.custom_minimum_size = Vector2(300.0, 76.0)
	stat_panel.add_theme_stylebox_override("panel", _panel_style(GRID_BLUE))
	top_row.add_child(stat_panel)

	var stat_margin := MarginContainer.new()
	stat_margin.add_theme_constant_override("margin_left", 10)
	stat_margin.add_theme_constant_override("margin_top", 6)
	stat_margin.add_theme_constant_override("margin_right", 10)
	stat_margin.add_theme_constant_override("margin_bottom", 6)
	stat_panel.add_child(stat_margin)

	stats_label = _make_label("", 11, Color(0.68, 0.88, 1.0))
	stats_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	stat_margin.add_child(stats_label)

	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_child(center)

	var center_stack := VBoxContainer.new()
	center_stack.alignment = BoxContainer.ALIGNMENT_CENTER
	center_stack.add_theme_constant_override("separation", 14)
	center.add_child(center_stack)

	pause_panel = PanelContainer.new()
	pause_panel.visible = false
	pause_panel.custom_minimum_size = Vector2(380.0, 105.0)
	pause_panel.add_theme_stylebox_override("panel", _panel_style(CYAN, 0.12, 0.58, 2))
	center_stack.add_child(pause_panel)

	var pause_margin := MarginContainer.new()
	pause_margin.add_theme_constant_override("margin_left", 18)
	pause_margin.add_theme_constant_override("margin_top", 16)
	pause_margin.add_theme_constant_override("margin_right", 18)
	pause_margin.add_theme_constant_override("margin_bottom", 16)
	pause_panel.add_child(pause_margin)

	pause_label = _make_label("SYSTEM PAUSED\nStart / P / Esc: Resume", 24, Color.WHITE)
	pause_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pause_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	pause_margin.add_child(pause_label)

	game_over_panel = PanelContainer.new()
	game_over_panel.visible = false
	game_over_panel.custom_minimum_size = Vector2(560.0, 130.0)
	game_over_panel.add_theme_stylebox_override("panel", _panel_style(DANGER, 0.13, 0.58, 2))
	center_stack.add_child(game_over_panel)

	var over_margin := MarginContainer.new()
	over_margin.add_theme_constant_override("margin_left", 18)
	over_margin.add_theme_constant_override("margin_top", 18)
	over_margin.add_theme_constant_override("margin_right", 18)
	over_margin.add_theme_constant_override("margin_bottom", 18)
	game_over_panel.add_child(over_margin)

	game_over_label = _make_label("", 24, Color.WHITE)
	game_over_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	game_over_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	over_margin.add_child(game_over_label)

	level_flash_rect = ColorRect.new()
	level_flash_rect.visible = false
	level_flash_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	level_flash_rect.color = Color(0.2, 1.0, 0.62, 0.0)
	level_flash_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_child(level_flash_rect)


func _on_health_changed(current: float, maximum: float) -> void:
	hp_bar.max_value = maximum
	hp_bar.value = current
	hp_label.text = "HP %d / %d" % [int(ceil(current)), int(maximum)]


func _on_xp_changed(current: int, required: int, level: int) -> void:
	level_label.text = "LEVEL %d" % level
	xp_bar.max_value = required
	xp_bar.value = current
	xp_label.text = "XP %d / %d" % [current, required]


func _on_stats_changed() -> void:
	if not is_instance_valid(player):
		return

	stats_label.text = "DMG %.0f%%   RATE %.0f%%   SPEED %d\nPULSE +%d   ORBITS %d   PICKUP %d   NOVA %.0f%%" % [
		player.damage_multiplier * 100.0,
		player.fire_rate_multiplier * 100.0,
		int(player.speed),
		player.projectile_count_bonus,
		1 + player.orbital_count_bonus,
		int(player.pickup_radius),
		player.nova_cooldown_multiplier * 100.0
	]


func _make_label(text: String, font_size: int, color: Color) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.add_theme_constant_override("outline_size", 2)
	label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.86))
	label.add_theme_color_override("font_shadow_color", Color(color.r, color.g, color.b, 0.52))
	label.add_theme_constant_override("shadow_offset_x", 0)
	label.add_theme_constant_override("shadow_offset_y", 0)
	label.add_theme_constant_override("shadow_outline_size", 9)
	label.clip_text = true
	return label


func _make_bar(fill_color: Color) -> ProgressBar:
	var bar := ProgressBar.new()
	bar.custom_minimum_size = Vector2(0.0, 8.0)
	bar.show_percentage = false
	bar.add_theme_stylebox_override("background", _bar_background_style(fill_color))
	bar.add_theme_stylebox_override("fill", _bar_fill_style(fill_color))
	return bar


func _panel_style(border: Color, bg_alpha: float = 0.13, shadow_alpha: float = 0.44, border_width: int = 1) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(PANEL_DARK.r, PANEL_DARK.g, PANEL_DARK.b, bg_alpha)
	style.border_color = Color(border.r, border.g, border.b, 0.96)
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(2)
	style.shadow_color = Color(border.r, border.g, border.b, shadow_alpha)
	style.shadow_size = 16
	style.content_margin_left = 8.0
	style.content_margin_right = 8.0
	style.content_margin_top = 6.0
	style.content_margin_bottom = 6.0
	return style


func _bar_background_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.0, 0.0, 0.0, 0.30)
	style.border_color = Color(color.r, color.g, color.b, 0.82)
	style.set_border_width_all(1)
	style.set_corner_radius_all(1)
	style.shadow_color = Color(color.r, color.g, color.b, 0.28)
	style.shadow_size = 8
	return style


func _bar_fill_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(color.r, color.g, color.b, 0.94)
	style.border_color = Color(1.0, 1.0, 1.0, 0.88)
	style.set_border_width(SIDE_TOP, 1)
	style.set_border_width(SIDE_BOTTOM, 1)
	style.set_corner_radius_all(1)
	style.shadow_color = Color(color.r, color.g, color.b, 0.62)
	style.shadow_size = 10
	return style


func _format_time(time_seconds: float) -> String:
	var total := int(floor(time_seconds))
	var minutes := total / 60
	var seconds := total % 60
	return "%02d:%02d" % [minutes, seconds]
