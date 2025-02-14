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

@onready var weapon: RangedWeapon = $PlayerPosition/WeaponPosition.get_child(0)


func _ready():
	damage = weapon.damage
	penetration = weapon.penetration
	elemental_damage = weapon.elemental_damage
	critical_chance = weapon.critical_chance
	projectile_life_time = weapon.projectile_life_time
	timer = $Timer
	timer.wait_time = projectile_life_time


func _on_damage_collision_area_entered(area: Area3D) -> void:
	if area is HitboxComponent:
		area.damage(15)
		

func _on_timer_timeout():
	queue_free()
