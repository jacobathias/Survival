extends Area3D
class_name HitboxComponent 

var health_component: HealthComponent


func _ready():
	if not get_parent().get_node("HealthComponent"):
		push_warning('No healthComponent found')
		return
	health_component = get_parent().get_node("HealthComponent")
	print(health_component.get_parent())

func damage(attack):
	if health_component:
		health_component.damage(attack)
		if health_component.current_health <=0:
			get_parent().queue_free()

func _on_area_entered(area):
	if health_component:
		health_component.health -= area.get_parent().damage
		area.get_parent().queue_free()
		health_component.die()
