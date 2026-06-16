extends Node

var main_ref: Node
var player: CharacterBody2D
var elapsed := 0.0
var spawn_timer := 0.0
var rng := RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()


func configure(main_node: Node, player_node: CharacterBody2D) -> void:
	main_ref = main_node
	player = player_node
	elapsed = 0.0
	spawn_timer = 0.2


func _process(delta: float) -> void:
	if not is_instance_valid(main_ref) or not is_instance_valid(player):
		return
	if main_ref.has_method("can_spawn_enemy") and not main_ref.can_spawn_enemy():
		spawn_timer = maxf(spawn_timer, 0.35)
		return

	elapsed += delta
	spawn_timer -= delta
	if spawn_timer > 0.0:
		return

	_spawn_pack()
	spawn_timer = maxf(0.28, 1.25 - elapsed / 180.0)


func _spawn_pack() -> void:
	var count := 3 + int(elapsed / 28.0)
	count = mini(count, 10)

	for i in range(count):
		main_ref.spawn_enemy(_pick_enemy_type(), _pick_spawn_position())


func _pick_enemy_type() -> String:
	var roll := rng.randf()

	if elapsed < 18.0:
		return "chaser"
	if elapsed < 42.0:
		return "tank" if roll < 0.22 else "chaser"

	if roll < 0.14:
		return "shooter"
	if roll < 0.30:
		return "exploder"
	if roll < 0.50:
		return "tank"
	return "chaser"


func _pick_spawn_position() -> Vector2:
	var angle := rng.randf_range(0.0, TAU)
	var distance := rng.randf_range(620.0, 820.0)
	var position := player.global_position + Vector2.from_angle(angle) * distance

	if main_ref and main_ref.has_method("clamp_to_arena"):
		position = main_ref.clamp_to_arena(position, 44.0)

	if position.distance_to(player.global_position) < 360.0:
		position = player.global_position + (position - player.global_position).normalized() * 360.0

	return position
