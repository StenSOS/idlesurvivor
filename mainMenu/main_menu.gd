extends Control

@onready var money_label = $HUD/Panel2/moneyLabel
@onready var diamond_label = $HUD/Panel3/diamondLabel
@onready var player_upgrade_panel = $PlayerUpgradePanel


func _ready():
	update_ui()

func update_ui():
	# Global veriden çekiyoruz
	money_label.text = str(GameData.totalMoney)
	diamond_label.text = str(GameData.totalDiamonds)


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_player_ups_pressed():
	if player_upgrade_panel.visible:
		player_upgrade_panel.visible = false
	else:
		player_upgrade_panel.visible = true


func _on_turret_ups_pressed():
	print("turret ups nuttom")


func _on_ups_pressed():
	print("ups button")
