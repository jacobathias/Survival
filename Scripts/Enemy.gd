extends CharacterBody3D

var EnemyMesh: MeshInstance3D
var Player: CharacterBody3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var Projectile = "res://Assets/Projectile.tscn"
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var Weapon = $PlayerMesh/WeaponPosition.get_child(0)
@onready var WeaponComponent = Weapon.get_node
#@onready var fireArmComponent: FireArmComponent = $FireArmComponent

func _ready():
	Player = get_tree().get_root().get_child(0).get_node('Player')
	
func _physics_process(delta):
	#Weapon.can_shoot()
	move_and_slide()
	point_at_player()


#ENEMY BEHAVIOR

func point_at_player():
	var target = $PlayerMesh/WeaponPosition
	look_at(Player.position)
	#target.look_at(cam.mouse_position)
	#mouse_label.set_position(cam.mouse_position)
	#mouse_label.text = str(cam.mouse_position)
	#$"../p".set_position(cam.mouse_position)
