extends Camera3D
var Marker: Marker3D
var intersection
var intersect_point
@export var Player : CharacterBody3D
var mouse_position: Vector3 = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = $"../Player"
	Marker=$Marker3D



func _process(delta):
	#print(Player.get_child(1))
	
	position = Vector3(Player.get_child(1).global_position.x,17, Player.get_child(1).global_position.z +10  )
	#if Input.is_action_just_pressed("mouse_click"):
	var space_state = get_world_3d().direct_space_state
	var mous_position = get_viewport().get_mouse_position()
	var ray_origin = project_ray_origin(mous_position)
	var ray_end = ray_origin + project_ray_normal(mous_position) * 1000

	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	intersection = space_state.intersect_ray(params) # Change 1000 to your desired ray length
	if not intersection.is_empty():
		intersect_point = intersection["position"]
	else : return
	mouse_position = Vector3(intersect_point)
	#mouse_position = Vector3(intersect_point.x, 1 ,intersect_point.z)
	Player.get_child(1).look_at(mouse_position)
