@icon("res://Node Icons/Firearm.png")
extends Node3D
class_name FireArmComponent

var Projectile = preload("res://Assets/projectile.tscn")

@export var weapon_name: String = "M1911"
@export var clip_max: int = 7
@export var clip: int = 7
@export var ammo_pouch: int = 70
@export var fire_power: int = 7

@export var reload_speed: float = 7.0
@export var swap_speed: float = 7.0
@export var rate_of_fire: float = 7.0
@export var weight: float = 1.0
@onready var TipOfGun: Node3D = $"../TipOfGun"
@onready var World: Node = get_tree().get_root().get_child(0)
@onready var Player: CharacterBody3D = $"../../../.."
var projectile_speed: float = 200 

# UI Elements
@onready var Ui = World.get_node('Ui')
@onready var WeaponNameLabel = Ui.get_child(1).get_child(0).get_node('WeaponNameLabel')
@onready var ClipSizeLabel = Ui.get_child(1).get_child(0).get_node('ClipSize')
@onready var TotalBulletsLabel = Ui.get_child(1).get_child(0).get_node('TotalBullets')

func _ready():
	update_gun_ui()

func reload():
	if clip == clip_max or ammo_pouch <= 0:
		return
	
	# Determine bullets to reload
	var reload_amount = min(clip_max - clip, ammo_pouch)
	
	# Update ammo counts
	clip += reload_amount
	ammo_pouch -= reload_amount
	update_gun_ui()

func update_gun_ui():
	ClipSizeLabel.text = str(clip)
	TotalBulletsLabel.text = str("| ",+ammo_pouch)
	WeaponNameLabel.text = weapon_name

func shoot():
	if not Input.is_action_just_pressed("mouse_click") or not can_shoot():
		return
	
	clip -= 1
	var projectile: RigidBody3D = Projectile.instantiate()
	projectile.global_transform = TipOfGun.global_transform
	projectile.apply_impulse(-TipOfGun.global_transform.basis.z * projectile_speed)

	World.add_child(projectile)
	update_gun_ui()

func can_shoot() -> bool:
	return clip > 0
