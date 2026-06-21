extends RefCounted

const MOVE_DEADZONE := 0.24
const AIM_DEADZONE := 0.28


static func ensure_actions() -> void:
	_configure_action("move_left", MOVE_DEADZONE, [
		_key(KEY_A),
		_key(KEY_LEFT),
		_joy_motion(JOY_AXIS_LEFT_X, -1.0),
		_joy_button(JOY_BUTTON_DPAD_LEFT)
	])
	_configure_action("move_right", MOVE_DEADZONE, [
		_key(KEY_D),
		_key(KEY_RIGHT),
		_joy_motion(JOY_AXIS_LEFT_X, 1.0),
		_joy_button(JOY_BUTTON_DPAD_RIGHT)
	])
	_configure_action("move_up", MOVE_DEADZONE, [
		_key(KEY_W),
		_key(KEY_UP),
		_joy_motion(JOY_AXIS_LEFT_Y, -1.0),
		_joy_button(JOY_BUTTON_DPAD_UP)
	])
	_configure_action("move_down", MOVE_DEADZONE, [
		_key(KEY_S),
		_key(KEY_DOWN),
		_joy_motion(JOY_AXIS_LEFT_Y, 1.0),
		_joy_button(JOY_BUTTON_DPAD_DOWN)
	])

	_configure_action("aim_left", AIM_DEADZONE, [
		_key(KEY_J),
		_joy_motion(JOY_AXIS_RIGHT_X, -1.0)
	])
	_configure_action("aim_right", AIM_DEADZONE, [
		_key(KEY_L),
		_joy_motion(JOY_AXIS_RIGHT_X, 1.0)
	])
	_configure_action("aim_up", AIM_DEADZONE, [
		_key(KEY_I),
		_joy_motion(JOY_AXIS_RIGHT_Y, -1.0)
	])
	_configure_action("aim_down", AIM_DEADZONE, [
		_key(KEY_K),
		_joy_motion(JOY_AXIS_RIGHT_Y, 1.0)
	])

	_configure_action("fire_weapon_slot_1", 0.2, [
		_mouse_button(MOUSE_BUTTON_LEFT),
		_joy_motion(JOY_AXIS_TRIGGER_RIGHT, 1.0)
	])
	_configure_action("fire_weapon_slot_2", 0.2, [
		_mouse_button(MOUSE_BUTTON_RIGHT),
		_joy_motion(JOY_AXIS_TRIGGER_LEFT, 1.0)
	])
	_configure_action("fire_weapon_slot_3", 0.2, [
		_key(KEY_Q),
		_joy_button(JOY_BUTTON_RIGHT_SHOULDER)
	])
	_configure_action("fire_weapon_slot_4", 0.2, [
		_key(KEY_E),
		_joy_button(JOY_BUTTON_LEFT_SHOULDER)
	])
	_configure_action("fire_weapon_slot_5", 0.2, [
		_key(KEY_R)
	])
	_configure_action("fire_weapon_slot_6", 0.2, [
		_key(KEY_F)
	])
	_configure_action("fire_weapon_slot_7", 0.2, [
		_key(KEY_Z)
	])
	_configure_action("fire_weapon_slot_8", 0.2, [
		_key(KEY_X)
	])

	_configure_action("confirm", 0.2, [
		_key(KEY_ENTER),
		_key(KEY_KP_ENTER),
		_key(KEY_SPACE),
		_joy_button(JOY_BUTTON_A)
	])
	_configure_action("cancel", 0.2, [
		_key(KEY_ESCAPE),
		_key(KEY_BACKSPACE),
		_joy_button(JOY_BUTTON_B)
	])
	_configure_action("pause", 0.2, [
		_key(KEY_ESCAPE),
		_key(KEY_P),
		_joy_button(JOY_BUTTON_START)
	])
	_configure_action("mute_audio", 0.2, [
		_key(KEY_M)
	])


static func _configure_action(action_name: StringName, deadzone: float, events: Array) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name, deadzone)
	else:
		InputMap.action_erase_events(action_name)
		InputMap.action_set_deadzone(action_name, deadzone)

	for event in events:
		InputMap.action_add_event(action_name, event)


static func _key(keycode: Key) -> InputEventKey:
	var event := InputEventKey.new()
	event.keycode = keycode
	return event


static func _joy_button(button: JoyButton) -> InputEventJoypadButton:
	var event := InputEventJoypadButton.new()
	event.button_index = button
	return event


static func _mouse_button(button_index: MouseButton) -> InputEventMouseButton:
	var event := InputEventMouseButton.new()
	event.button_index = button_index
	return event


static func _joy_motion(axis: JoyAxis, axis_value: float) -> InputEventJoypadMotion:
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = axis_value
	return event
