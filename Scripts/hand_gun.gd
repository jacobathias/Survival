
extends MeshInstance3D

@onready var fireArmComponent: FireArmComponent = $FireArmComponent

func can_shoot():
	if fireArmComponent.can_shoot():
		fireArmComponent.shoot()
		
func reload():
	fireArmComponent.reload()
