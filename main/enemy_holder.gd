extends Node2D

@export var enemy_scene: PackedScene = preload("res://enemy/enemy.tscn")
@export var spawn_radius: float = 500.0

var timer := 0.0
var spawn_rate := 2.0  # Başlangıç: 2 saniye
var difficulty_timer := 0.0
const MIN_SPAWN_RATE := 0.5

func _process(delta: float) -> void:
	timer += delta
	difficulty_timer += delta

	# Spawn zamanı?
	if timer >= spawn_rate:
		spawn_enemy()
		timer = 0.0

	# Zorluk artışı (her 60 saniyede spawn hızlanır)
	var new_rate = 2.0 - (difficulty_timer / 60.0)
	spawn_rate = max(new_rate, MIN_SPAWN_RATE)  # Asla 0.5'ten aşağı düşmez


func spawn_enemy():
	if enemy_scene == null:
		print("ERROR: enemy_scene bağlı değil!")
		return

	var enemy = enemy_scene.instantiate()

	# Çemberde rastgele konum
	var angle = randf() * TAU
	var pos = Vector2(cos(angle), sin(angle)) * spawn_radius
	enemy.global_position = pos

	# Enemy HP güçlendirme
	var extraHp = int(difficulty_timer / 30.0) * 5  # her 30 sn +5 HP
	enemy.maxHp += extraHp

	# Sahneye ekle
	get_parent().add_child(enemy)
