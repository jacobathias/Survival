@icon ("res://Node Icons/Hitbox.png")
extends Area3D
class_name HitboxComponent 

@export var health_component: HealthComponent

var parent
func _ready() -> void:
	parent = get_parent()
	check_health_component()
	
func check_health_component():
	if health_component == null :
		printerr("Pleas assign a health component to the node ")
		
	
func damage(attack):
	"Calculate damage"
	if health_component:
		health_component.damage(attack)
		
		if health_component.health <=0:
			print(health_component.health)
			get_parent().queue_free()
