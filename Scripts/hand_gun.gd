extends MeshInstance3D
class_name RangedWeapon

@onready var fireArmComponent: FireArmComponent = $FireArmComponent

@export var damage: int 
@export var penetration: int
@export var elemental_damage:int
@export var critical_chance:float
@export var projectile_life_time: float = 50

@export var is_blast_damage: bool
@export var elemental_type: Array = ["fire", "water", "thunder", "poison"]
var timer :Timer 


func can_shoot():
	if fireArmComponent.can_shoot():
		fireArmComponent.shoot()
		
func reload():
	fireArmComponent.reload()
