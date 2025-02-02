extends CharacterBody3D

# Constants
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const PROJECTILE_PATH = "res://Assets/Projectile.tscn"

# Exported Variables
@export var Player: CharacterBody3D

# Variables
var EnemyMesh: MeshInstance3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Node References
@onready var Weapon = $EnemyMesh/WeaponPosition.get_child(0)
@onready var WeaponComponent = Weapon.get_node
@onready var Hitbox = $HitboxComponent
#@onready var fireArmComponent: FireArmComponent = $FireArmComponent

# Initialization
func _ready():
	EnemyMesh = $PlayerMesh

# Physics Update
func _physics_process(delta):
	# TODO: Uncomment and implement functionality
	# Weapon.can_shoot()
	# look_at(Player.position)
	if not is_on_floor(): velocity.y -= gravity * delta
	move_and_slide()
	




# Event Handlers
func _on_hitbox_component_area_entered(area):
	print("Hitbox triggered by:", area)
