extends CharacterBody3D
class_name Player

var Projectile = preload("res://Assets/projectile.tscn")
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var SPEED = 500.0
@export var JUMP_VELOCITY = 4.5
@export var cam: Camera3D

@onready var mouse_label : Label3D = $"../Label"
@onready var healthComponent: HealthComponent = $HealthComponent
@onready var hitboxComponent: HitboxComponent = $HitboxComponent
@onready var PlayerMesh: MeshInstance3D = $Mesh
@onready var WeaponPosition: Marker3D = $Mesh/WeaponPosition
@onready var Weapon: MeshInstance3D = $Mesh/WeaponPosition.get_child(0)
@onready var WeaponComponent = Weapon.get_node


func _physics_process(delta):
	Weapon.can_shoot()
	handle_movement(delta)
	point_gun()
	reload()

func reload():
	if Input.is_action_just_pressed("reload"):
		#if not Weapon.reload(): return
		Weapon.reload()
	
func point_gun():
	Weapon.visible = false
	var target = $Mesh/WeaponPosition
	target.look_at(cam.mouse_position)
	mouse_label.set_position(cam.mouse_position)
	mouse_label.text = str(cam.mouse_position)

func handle_movement(delta):
	if not is_on_floor(): # Makes character fall if in the air
		velocity.y -= gravity * delta

	# Get input direction
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.z = direction.z * SPEED * delta
		
		# Compute target rotation based on direction
		var target_rotation = atan2(-direction.x, -direction.z)  # atan2(y, x) gives the correct angle
		
		# Smoothly rotate the PlayerMesh
		PlayerMesh.rotation.y = lerp_angle(PlayerMesh.rotation.y, target_rotation, 0.2)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)
	move_and_slide()
