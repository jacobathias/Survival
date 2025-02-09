extends Player

# Constants

const PROJECTILE_PATH = "res://Assets/Projectile.tscn"

# Exported Variables
@export var Player: CharacterBody3D

# Variables
var EnemyMesh: MeshInstance3D


# Node References

@onready var Hitbox = $HitboxComponent #??????????????????


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
