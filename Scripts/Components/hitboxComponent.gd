extends Area3D
class_name HitboxComponent 

@export var health_component: HealthComponent

func damage(attack):
	if health_component:
		health_component.damage(attack)
		if health_component.current_health <=0:
			get_parent().queue_free()


func _on_area_entered(area):
	print(area)
