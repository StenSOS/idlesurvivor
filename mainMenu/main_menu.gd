extends Control

@onready var money_label = $HUD/Panel2/moneyLabel
@onready var diamond_label = $HUD/Panel3/diamondLabel

@onready var player_upgrade_panel = $PlayerUpgradePanel
@onready var turret_upgrade_panel = $TurretUpgradePanel
@onready var upgrade_panel = $UpgradePanel

@onready var playerDamageLabel = $PlayerUpgradePanel/VBoxContainer/damageUpgradePanel/Label

func _ready():
	update_ui()

func update_ui():
	# Global veriden çekiyoruz
	money_label.text = str(GameData.totalMoney)
	diamond_label.text = str(GameData.totalDiamonds)
	
	# fiyat update
	playerDamageLabel.text = "+1 Player Damage\n" + str(GameData.playerDamageCost) + " Coin" 


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
		playerDamageLabel.text = "+1 Player Damage\n" + str(GameData.playerDamageCost) + " Coin" 
		update_ui()
	else:
		print("no money")
