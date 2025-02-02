extends Camera3D

@onready var Player: CharacterBody3D = $"../Player"
@onready var Marker: Marker3D = $Marker3D

var tween: Tween  # Stores the active tween
var intersection: Dictionary
var mouse_position: Vector3 = Vector3.ZERO

const MAX_FOV: float = 70.0
const MIN_FOV: float = 40.0
const FOV_SPEED: int = 10

func _process(delta):
	# Update camera position relative to the player
	var player_pos = Player.get_child(1).global_position
	position = Vector3(player_pos.x, 17, player_pos.z + 10)

	# Raycasting for mouse position detection
	var space_state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = project_ray_origin(mouse_pos)
	var ray_end = ray_origin + project_ray_normal(mouse_pos) * 1000

	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	
	intersection = space_state.intersect_ray(params)
	if intersection:
		mouse_position = intersection["position"]

	# Handle zoom with mouse wheel
	if Input.is_action_just_pressed("mouse_wheel_up"):
		start_fov_tween(adjust_fov(1))

	if Input.is_action_just_pressed("mouse_wheel_down"):
		start_fov_tween(adjust_fov(-1))

func start_fov_tween(target_fov: float):
	# Kill existing tween if it's active
	if tween and tween.is_running():
		tween.kill()
	
	# Create a new tween and animate FOV
	tween = get_tree().create_tween()
	tween.tween_property(self, "fov", target_fov, 0.1)

func adjust_fov(factor: int) -> float:
	return clamp(fov - FOV_SPEED * factor, MIN_FOV, MAX_FOV)
