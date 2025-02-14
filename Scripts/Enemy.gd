extends Player

const PROJECTILE_PATH = "res://Assets/Projectile.tscn"
@export var Player: CharacterBody3D

var EnemyMesh: MeshInstance3D

func _ready():
	EnemyMesh = $PlayerMesh

# Physics Update
func _physics_process(delta):

	if not is_on_floor(): velocity.y -= gravity * delta
	move_and_slide()
