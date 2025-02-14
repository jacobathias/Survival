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
@onready var PlayerPosition: Marker3D = $PlayerPosition
@onready var WeaponPosition: Marker3D
@onready var Weapon: MeshInstance3D

func _ready() -> void:
	#WeaponPosition= $WeaponPosition
	#Weapon = $WeaponPosition.get_child(0)
	WeaponPosition= $PlayerPosition/WeaponPosition
	Weapon = $PlayerPosition/WeaponPosition.get_child(0)
	

func _physics_process(delta):
	Weapon.can_shoot()
	point_gun()
	handle_movement(delta)
	reload()

func reload():
	if Input.is_action_just_pressed("reload"):
		#if not Weapon.reload(): return
		Weapon.reload()
	
func point_gun():
	if Input.is_action_pressed("mouse_right_click"):
		Weapon.visible = true
		
		# Converte a posição do mouse para um ponto no mundo
		var space_state = get_world_3d().direct_space_state
		var from = cam.project_ray_origin(get_viewport().get_mouse_position())
		var to = from + cam.project_ray_normal(get_viewport().get_mouse_position()) * 1000
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		
		if result:
			var target_position = result.position
			var offset = Vector3(0.7, 0, 0)  # Offset to the right

	# Rotate the offset around the Y-axis using WeaponPosition's rotation
			var rotated_offset = offset.rotated(Vector3.UP, WeaponPosition.rotation.y)

	# Make the weapon look at the target position
			WeaponPosition.look_at(target_position, Vector3.UP)

	# Align the player's rotation with the weapon's rotation
			PlayerMesh.rotation.y = WeaponPosition.rotation.y

	# Apply the rotated offset to position the weapon correctly
			WeaponPosition.position = PlayerMesh.position + rotated_offset

		
	else:
		Weapon.visible = false




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
