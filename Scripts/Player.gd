extends CharacterBody3D

var Projectile = preload("res://Assets/projectile.tscn")
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
const SPEED = 7.0
const JUMP_VELOCITY = 4.5
@export var cam: Camera3D
@onready var mouse_label : Label3D = $"../Label"
@onready var healthComponent: HealthComponent = $HealthComponent
@onready var hitboxComponent: HitboxComponent = $HitboxComponent
@onready var PlayerMesh: MeshInstance3D = $PlayerMesh
@onready var WeaponPosition: Marker3D = $PlayerMesh/WeaponPosition
@onready var Weapon = $PlayerMesh/WeaponPosition.get_child(0)
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
	var target = $PlayerMesh/WeaponPosition
	target.look_at(cam.mouse_position)
	mouse_label.set_position(cam.mouse_position)
	mouse_label.text = str(cam.mouse_position)
	$"../p".set_position(cam.mouse_position)
func handle_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
