extends Node

signal upgrade_selected(upgrade: Dictionary)

const PANEL_CYAN := Color(0.0, 0.92, 1.0)
const PANEL_MAGENTA := Color(1.0, 0.06, 0.86)
const FOCUS_GOLD := Color(1.0, 0.94, 0.14)
const DARK_GLASS := Color(0.0, 0.004, 0.018, 0.10)

var rng := RandomNumberGenerator.new()
var overlay: CanvasLayer
var choice_box: HBoxContainer
var level_label: Label
var prompt_label: Label
var current_choices: Array[Dictionary] = []
var selected_index := 0
var navigation_cooldown := 0.0

var upgrades: Array[Dictionary] = [
	{
		"id": "amplified_core",
		"title": "Amplified Core",
		"description": "+15% weapon damage",
		"effects": {"damage_multiplier_add": 0.15}
	},
	{
		"id": "rapid_capacitor",
		"title": "Rapid Capacitor",
		"description": "+12% Pulse Blaster fire rate",
		"effects": {"fire_rate_multiplier_add": 0.12}
	},
	{
		"id": "vector_boots",
		"title": "Vector Boots",
		"description": "+34 movement speed",
		"effects": {"speed_add": 34.0}
	},
	{
		"id": "split_pulse",
		"title": "Split Pulse",
		"description": "+1 Pulse Blaster projectile",
		"effects": {"projectile_count_add": 1}
	},
	{
		"id": "magnet_grid",
		"title": "Magnet Grid",
		"description": "+55 pickup radius",
		"effects": {"pickup_radius_add": 55.0}
	},
	{
		"id": "twin_orbit",
		"title": "Twin Orbit",
		"description": "+1 Orbit Spark",
		"effects": {"orbital_count_add": 1}
	},
	{
		"id": "nova_battery",
		"title": "Nova Battery",
		"description": "-15% Nova Burst cooldown",
		"effects": {"nova_cooldown_multiplier_add": -0.15}
	},
	{
		"id": "dense_core",
		"title": "Dense Core",
		"description": "+25 max health and heal",
		"effects": {"max_health_add": 25.0, "heal_add": 25.0}
	},
	{
		"id": "hot_orbit",
		"title": "Hot Orbit",
		"description": "+25% Orbit Spark damage",
		"effects": {"orbit_damage_multiplier_add": 0.25}
	},
	{
		"id": "piercing_beam",
		"title": "Piercing Beam",
		"description": "Pulse Blaster pierces +1 enemy",
		"effects": {"pulse_pierce_add": 1}
	}
]


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	rng.randomize()
	_build_overlay()


func _process(delta: float) -> void:
	if not is_showing_choices():
		return

	navigation_cooldown = maxf(0.0, navigation_cooldown - delta)


func _input(event: InputEvent) -> void:
	if not is_showing_choices():
		return

	if event.is_action_pressed("confirm"):
		_activate_selected_upgrade()
		get_viewport().set_input_as_handled()
		return

	var direction := _menu_direction_from_event(event)
	if direction != 0 and navigation_cooldown <= 0.0:
		_move_selection(direction)
		navigation_cooldown = 0.18
		get_viewport().set_input_as_handled()


func show_choices(player: CharacterBody2D, level: int) -> void:
	current_choices = _roll_choices(3)
	level_label.text = "LEVEL %d" % level
	selected_index = 0
	navigation_cooldown = 0.0

	for child in choice_box.get_children():
		child.queue_free()

	for upgrade in current_choices:
		var button := Button.new()
		button.text = "%s\n%s" % [upgrade.title, upgrade.description]
		button.custom_minimum_size = Vector2(285.0, 132.0)
		button.focus_mode = Control.FOCUS_ALL
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		button.add_theme_font_size_override("font_size", 18)
		button.add_theme_color_override("font_color", Color(0.92, 1.0, 1.0))
		button.add_theme_color_override("font_hover_color", Color.WHITE)
		button.add_theme_color_override("font_pressed_color", Color(0.1, 0.02, 0.12))
		button.add_theme_constant_override("outline_size", 2)
		button.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.86))
		button.add_theme_color_override("font_focus_color", Color.WHITE)
		button.add_theme_color_override("font_shadow_color", Color(0.0, 0.92, 1.0, 0.52))
		button.add_theme_constant_override("shadow_outline_size", 10)
		button.add_theme_constant_override("shadow_offset_x", 0)
		button.add_theme_constant_override("shadow_offset_y", 0)
		button.add_theme_stylebox_override("normal", _button_style(DARK_GLASS, PANEL_CYAN, 0.38, 1))
		button.add_theme_stylebox_override("hover", _button_style(Color(0.0, 0.010, 0.030, 0.16), PANEL_MAGENTA, 0.48, 1))
		button.add_theme_stylebox_override("focus", _button_style(Color(0.020, 0.018, 0.0, 0.18), FOCUS_GOLD, 0.82, 3))
		button.add_theme_stylebox_override("pressed", _button_style(Color(0.0, 0.95, 1.0, 0.14), Color.WHITE, 0.76, 2))
		button.focus_entered.connect(func() -> void:
			selected_index = choice_box.get_children().find(button)
		)
		button.pressed.connect(func() -> void:
			_select_upgrade(upgrade)
		)
		choice_box.add_child(button)

	overlay.visible = true
	_focus_selected_button()


func _build_overlay() -> void:
	overlay = CanvasLayer.new()
	overlay.name = "UpgradeOverlay"
	overlay.layer = 20
	overlay.process_mode = Node.PROCESS_MODE_ALWAYS
	overlay.visible = false
	add_child(overlay)

	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.process_mode = Node.PROCESS_MODE_ALWAYS
	overlay.add_child(root)

	var dim := ColorRect.new()
	dim.color = Color(0.0, 0.0, 0.0, 0.82)
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_child(dim)

	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(980.0, 300.0)
	panel.add_theme_stylebox_override("panel", _panel_style())
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 24)
	margin.add_theme_constant_override("margin_top", 22)
	margin.add_theme_constant_override("margin_right", 24)
	margin.add_theme_constant_override("margin_bottom", 24)
	panel.add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 18)
	margin.add_child(layout)

	level_label = Label.new()
	level_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level_label.add_theme_font_size_override("font_size", 28)
	level_label.add_theme_color_override("font_color", FOCUS_GOLD)
	level_label.add_theme_constant_override("outline_size", 3)
	level_label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.9))
	level_label.add_theme_color_override("font_shadow_color", Color(FOCUS_GOLD.r, FOCUS_GOLD.g, FOCUS_GOLD.b, 0.62))
	level_label.add_theme_constant_override("shadow_outline_size", 13)
	level_label.add_theme_constant_override("shadow_offset_x", 0)
	level_label.add_theme_constant_override("shadow_offset_y", 0)
	layout.add_child(level_label)

	prompt_label = Label.new()
	prompt_label.text = "Controller: Left Stick / D-Pad Select   A Confirm"
	prompt_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt_label.add_theme_font_size_override("font_size", 14)
	prompt_label.add_theme_color_override("font_color", Color(0.78, 0.98, 1.0, 0.92))
	prompt_label.add_theme_color_override("font_shadow_color", Color(0.0, 0.9, 1.0, 0.42))
	prompt_label.add_theme_constant_override("shadow_outline_size", 8)
	layout.add_child(prompt_label)

	choice_box = HBoxContainer.new()
	choice_box.add_theme_constant_override("separation", 14)
	layout.add_child(choice_box)


func is_showing_choices() -> bool:
	return overlay != null and overlay.visible


func _roll_choices(amount: int) -> Array[Dictionary]:
	var pool := upgrades.duplicate()
	var choices: Array[Dictionary] = []
	while choices.size() < amount and pool.size() > 0:
		var index := rng.randi_range(0, pool.size() - 1)
		choices.append(pool[index])
		pool.remove_at(index)
	return choices


func _select_upgrade(upgrade: Dictionary) -> void:
	overlay.visible = false
	upgrade_selected.emit(upgrade)


func _activate_selected_upgrade() -> void:
	if current_choices.is_empty():
		return

	selected_index = clampi(selected_index, 0, current_choices.size() - 1)
	_select_upgrade(current_choices[selected_index])


func _move_selection(direction: int) -> void:
	var count := choice_box.get_child_count()
	if count <= 0:
		return

	selected_index = wrapi(selected_index + direction, 0, count)
	_focus_selected_button()


func _focus_selected_button() -> void:
	if choice_box.get_child_count() <= 0:
		return

	selected_index = clampi(selected_index, 0, choice_box.get_child_count() - 1)
	var button := choice_box.get_child(selected_index)
	if button is Control:
		button.grab_focus()


func _menu_direction_from_event(event: InputEvent) -> int:
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_up"):
		return -1
	if event.is_action_pressed("move_right") or event.is_action_pressed("move_down"):
		return 1
	return 0


func _panel_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.0, 0.004, 0.016, 0.14)
	style.border_color = Color(PANEL_CYAN.r, PANEL_CYAN.g, PANEL_CYAN.b, 0.98)
	style.set_border_width_all(1)
	style.set_corner_radius_all(2)
	style.shadow_color = Color(PANEL_CYAN.r, PANEL_CYAN.g, PANEL_CYAN.b, 0.50)
	style.shadow_size = 30
	return style


func _button_style(bg: Color, border: Color, shadow_alpha: float = 0.28, border_width: int = 1) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = Color(border.r, border.g, border.b, 0.98)
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(2)
	style.shadow_color = Color(border.r, border.g, border.b, shadow_alpha)
	style.shadow_size = 26
	style.content_margin_left = 14.0
	style.content_margin_right = 14.0
	style.content_margin_top = 12.0
	style.content_margin_bottom = 12.0
	return style
