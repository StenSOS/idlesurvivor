extends Node2D

@onready var health_bar = $healthBar
@onready var enemy_holder = $"../enemyHolder"
@onready var playerSprite = $Sprite2D

@export var maxHealth : int 
@export var health: int
@export var playerDamage :int 
@export var attack_cooldown : float 
@export var rotationSpeed : float = 10.0

var current_attack_timer : float = 0.0
var isDead : bool = false

# Hedefin pozisyonunu ve kim olduğunu ayrı ayrı tutuyoruz
var target_position : Vector2 = Vector2.INF 
var target_enemy_node = null # Ateş edeceğimiz düşman objesi

func _ready():
	health_bar.max_value = maxHealth
	health_bar.value = health
	maxHealth = GameData.playerMaxHealth
	health = maxHealth
	playerDamage = GameData.playerDamage
	attack_cooldown = GameData.playerAttackSpeed

func _process(delta):
	if not isDead:
		current_attack_timer += delta
		
		# Sürekli en yakın düşmanı bul ve hedefi güncelle
		find_target()
		
		# Eğer geçerli bir hedef pozisyonu varsa
		if target_position != Vector2.INF:
			var target_angle = (target_position - global_position).angle()
			
			# 1. DÖNME İŞLEMİ
			playerSprite.rotation = lerp_angle(playerSprite.rotation, target_angle, rotationSpeed * delta)
			
			# 2. AÇI KONTROLÜ (Nişan aldık mı?)
			# Şu anki açımız ile hedef açı arasındaki farkı buluyoruz
			var angle_diff = abs(angle_difference(playerSprite.rotation, target_angle))
			
			# Eğer fark 0.1 radyandan (yaklaşık 5-6 derece) küçükse VE zamanı geldiyse ateş et
			if angle_diff < 0.1: 
				if current_attack_timer >= attack_cooldown:
					fire_at_target()
					current_attack_timer = 0.0

func updateHealthUI():
	health_bar.max_value = maxHealth
	health_bar.value = health

# Bu fonksiyon artık sadece hedefi belirliyor, ateş etmiyor
func find_target():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest_enemy = null
	var min_dist = INF
	
	for enemy in enemies:
		if is_instance_valid(enemy):
			var dist = global_position.distance_to(enemy.global_position)
			if dist < min_dist and dist < 400:
				min_dist = dist
				nearest_enemy = enemy
	
	if nearest_enemy:
		target_enemy_node = nearest_enemy
		target_position = nearest_enemy.global_position
	else:
		# Eğer etrafta kimse yoksa hedefi boşa düşürebilirsin
		# target_enemy_node = null
		pass

# Ateş etme işlemini ayırdık
func fire_at_target():
	# Ateş anında hedef hala hayatta mı?
	if is_instance_valid(target_enemy_node):
		target_enemy_node.takeDamage(playerDamage)
		print("Nişan alındı ve vuruldu!")
		
		# Eğer tek atıyorsan, vurduğun an hedef öleceği için;
		# Bir sonraki karede ölü yere bakmamak için hedefi temizleyebiliriz (opsiyonel)
		# target_enemy_node = null 
	else:
		print("Hedef tam ateş ederken öldü veya kayboldu.")

func takeDamage(damageAmount : int):
	health -= damageAmount
	updateHealthUI()
	gameOver()

func gameOver():
	if health <= 0:
		isDead = true
		get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
