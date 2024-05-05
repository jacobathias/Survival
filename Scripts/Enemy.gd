extends CharacterBody3D

var EnemyMesh: MeshInstance3D
@export var Player: CharacterBody3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var Projectile = "res://Assets/Projectile.tscn"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var Weapon = $PlayerMesh/WeaponPosition.get_child(0)
@onready var WeaponComponent = Weapon.get_node
#@onready var fireArmComponent: FireArmComponent = $FireArmComponent
func _ready():
	EnemyMesh = $PlayerMesh
	
func _physics_process(delta):
	Weapon.can_shoot()
	look_at(Player.position)

	move_and_slide()
