extends Node2D

@export var enemyScene: PackedScene = preload("res://enemy/enemy.tscn")
@export var spawnRadius: float = 700.0

var timer: float = 0.0
var spawnRate: float = 2.0
var difficultyTimer: float = 0.0

# --- AYARLAR ---
const DIFFICULTY_STEP: float = 30.0 # Her 30 saniyede zorluk artar
const MIN_SPAWN_RATE: float = 0.1   # En hızlı 0.1 saniyede bir düşman (Çok hızlı!)
const SPAWN_REDUCTION: float = 0.85 # Her seviyede süre %15 azalır (0.85 ile çarpılır)

func _process(delta: float) -> void:
	timer += delta
	difficultyTimer += delta

	if timer >= spawnRate:
		spawnWave() # Artık tek değil, gerekirse çoklu spawn fonksiyonu
		timer = 0.0

	# --- ZORLUK MANTIĞI (KAOS MODU) ---
	var difficultyLevel = int(difficultyTimer / DIFFICULTY_STEP)

	# Matematik: Başlangıç süresini her seviyede 0.85 ile çarpıyoruz.
	# Örnek: 2.0 -> 1.7 -> 1.44 -> 1.22 ... -> 0.1 (Limit)
	var newRate = 2.0 * pow(SPAWN_REDUCTION, difficultyLevel)
	
	spawnRate = max(newRate, MIN_SPAWN_RATE)

func spawnWave():
	# Zorluk seviyesini al
	var difficultyLevel = int(difficultyTimer / DIFFICULTY_STEP)
	
	# Seviye 5'ten sonra her seferde 1 yerine 2, 3... düşman gelsin
	# Örneğin: 150. saniyeden sonra her tikte 2 düşman çıkar.
	var enemiesPerWave = 1 + int(difficultyLevel / 5.0) 

	for i in range(enemiesPerWave):
		spawnEnemy(difficultyLevel)

func spawnEnemy(level: int):
	if enemyScene == null: return

	var enemy = enemyScene.instantiate()
	
	# Hafif dağınık spawn (hepsi üst üste binmesin diye)
	var angle = randf() * TAU
	# Yarıçapı biraz rastgele yapalım ki tam çember olmasın, doğal dursun
	var randomDist = spawnRadius + randf_range(-50.0, 50.0) 
	var pos = Vector2(cos(angle), sin(angle)) * randomDist
	
	enemy.global_position = pos
	
	# HP Artışı
	if "maxHp" in enemy:
		enemy.maxHp += level * 5

	get_parent().add_child(enemy)
