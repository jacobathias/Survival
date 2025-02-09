extends RigidBody3D
class_name Projectile

var damage: int 
var penetration: int
var elemental_damage:int
var critical_chance:float
var projectile_life_time: float = 50

var is_blast_damage: bool
var elemental_type: Array = ["fire", "water", "thunder", "poison"]

var timer :Timer 

func _ready():
	timer = $Timer
	timer.wait_time = projectile_life_time
	
#func _physics_process(delta):
	#print(timer.time_left)

func _on_timer_timeout():
	queue_free()
