extends RigidBody3D

@onready var timer :Timer = $Timer
# Called when the node enters the scene tree for the first time.


func _on_timer_timeout():
	queue_free()
