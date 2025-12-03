extends Node

# --- EKONOMİ ---
var totalMoney : int = 1000
var totalDiamonds : int = 0
var moneyPerEnemy : int = 1

# --- PLAYER STATLARI (Kalıcı) ---
var playerDamage : int = 2     # Başlangıç hasarı
var playerMaxHealth : int = 100  # Başlangıç canı
var playerAttackSpeed : float = 1.0 
var player_regen : int = 0          
var player_armor : int = 0

# --- TURRET STATLARI (Kalıcı) ---
var turretDamage : int = 2
var turretFireRate : float = 2.0

# --- FİYATLAR ---
var playerDamageCost : int = 5
var playerHealthCost : int = 10
