@icon ("res://Node Icons/Firearm.png")
extends Node3D
class_name FireArmComponent

var Projectile = preload("res://Assets/projectile.tscn")
@export var weapon_name : String = "M1911"
#@export var ammunition_type: = '.45 cal'
@export var clip_max : int = 7
@export var clip : int = 7
@export var ammo_pouch : int = 70
#@export var max_ammo_pouch : int = 7
@export var fire_power : int = 7

@export var reload_speed : float = 7
@export var swap_speed : float = 7
@export var rate_of_fire : float = 7
@export var weight: float = 1

@onready var TipOfGun =$"../TipOfGun"
@onready var World = get_tree().get_root().get_child(0)

@onready var Ui: CanvasLayer
@onready var Player: CharacterBody3D = $"../../../.."
#@onready var timer: Timer = $Timer
@onready var WeponIcon:TextureRect = $PanelContainer/GridContainer/WeaponIcon
@onready var WeaponNameLabel:Label = $PanelContainer/GridContainer/WeaponNameLabel
@onready var ClipSizeLabel:Label
@onready var TotalBulletsLabel:Label

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Player)
	Ui = World.get_node('Ui')
	WeaponNameLabel = Ui.get_child(1).get_child(0).get_node('WeaponNameLabel')
	ClipSizeLabel = Ui.get_child(1).get_child(0).get_node('ClipSize')
	TotalBulletsLabel = Ui.get_child(1).get_child(0).get_node('TotalBullets')
	update_gun_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reload():
	if clip == clip_max: return
	if ammo_pouch <= 0: return
	#reload_request is the amount of bulletes requested
	var reload_request = clip_max - clip

	#Reload Logic
	if reload_request > ammo_pouch: 
		reload_request = ammo_pouch 
	ammo_pouch -= reload_request
	clip       += reload_request
	update_gun_ui()

func update_gun_ui():
	ClipSizeLabel.text = str(clip)
	TotalBulletsLabel.text = str("| ",+ammo_pouch)
	WeaponNameLabel.text = str(weapon_name)
	
func shoot():
	#if Input.is_action_just_pressed("mouse_click") and Player.is_on_floor():
	if Input.is_action_just_pressed("mouse_click"):
		if not can_shoot(): return
		if clip <= 0: return
		clip -= 1

		var projectile :RigidBody3D = Projectile.instantiate()
		projectile.set_position(TipOfGun.global_position)
		projectile.set_rotation(TipOfGun.global_rotation)
		projectile.apply_force(-TipOfGun.global_transform.basis.z * 15000,)
		World.add_child(projectile)
		update_gun_ui()

func can_shoot() -> bool:
	var flag = clip > 0
	return flag
	
