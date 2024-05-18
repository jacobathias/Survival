extends RigidBody3D

var damage: int = 0
@onready var timer :Timer = $Timer
# Called when the node enters the scene tree for the first time.


func _on_timer_timeout():
	queue_free()

func set_damage(fire_power: int):
	damage = fire_power
	
