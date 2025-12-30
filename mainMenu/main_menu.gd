extends Control

@onready var money_label = $HUD/Panel2/moneyLabel
@onready var diamond_label = $HUD/Panel3/diamondLabel

@onready var player_upgrade_panel = $PlayerUpgradePanel
@onready var turret_upgrade_panel = $TurretUpgradePanel
@onready var upgrade_panel = $UpgradePanel

@onready var playerDamageLabel = $PlayerUpgradePanel/VBoxContainer/damageUpgradePanel/Label
@onready var playerHealthlabel = $PlayerUpgradePanel/VBoxContainer/healthUpgradePanel/Label
@onready var player_attack_speed_label = $PlayerUpgradePanel/VBoxContainer/UpgradePanel/playerAttackSpeedLabel

func _ready():
	update_ui()

func update_ui():
	# Global veriden çekiyoruz
	money_label.text = str(GameData.totalMoney)
	diamond_label.text = str(GameData.totalDiamonds)
	
	# fiyat update
	playerDamageLabel.text = "+1 Player Damage\n" + str(GameData.playerDamageCost) + " Coin" 
	playerHealthlabel.text = "+5 Player Health\n" + str(GameData.playerHealthCost) + " Coin"
	player_attack_speed_label.text = "-0.1 Attack Speed\n" + str(GameData.playerAttackSpeedCost) + " Coin"


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_player_ups_pressed():
	if player_upgrade_panel.visible:
		player_upgrade_panel.visible = false
	else:
		player_upgrade_panel.visible = true
		turret_upgrade_panel.visible = false
		upgrade_panel.visible = false


func _on_turret_ups_pressed():
	if turret_upgrade_panel.visible:
		turret_upgrade_panel.visible = false
	else:
		turret_upgrade_panel.visible = true
		player_upgrade_panel.visible = false
		upgrade_panel.visible = false


func _on_ups_pressed():
	if upgrade_panel.visible:
		upgrade_panel.visible = false
	else: 
		upgrade_panel.visible= true
		player_upgrade_panel.visible = false
		turret_upgrade_panel.visible = false


func _on_player_damage_button_pressed():
	if GameData.totalMoney >= GameData.playerDamageCost:
		GameData.totalMoney -= GameData.playerDamageCost
		GameData.playerDamage += 1
		GameData.playerDamageCost = int(GameData.playerDamageCost * 1.5)
		update_ui()
	else:
		print("no money")


func _on_player_health_button_pressed():
	if GameData.totalMoney >= GameData.playerHealthCost:
		GameData.totalMoney -= GameData.playerHealthCost
		GameData.playerMaxHealth += 5
		GameData.playerHealthCost = int(GameData.playerHealthCost * 1.5)
		update_ui()
	else:
		print("no money")


func _on_attack_speed_button_pressed():
	if GameData.totalMoney >= GameData.playerAttackSpeedCost:
		if GameData.playerAttackSpeed > 0.3 and GameData.playerRotationSpeed > 1:
			GameData.totalMoney -= GameData.playerAttackSpeedCost
			GameData.playerAttackSpeed -= 0.1
			GameData.playerRotationSpeed += 5
			GameData.playerAttackSpeedCost = 2 * GameData.playerAttackSpeedCost
			update_ui()
		else:
			print("speed is 0.1")
	else:
		print("no money")
