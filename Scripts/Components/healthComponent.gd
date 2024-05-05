@icon ("res://Node Icons/health.png")
extends Node
class_name HealthComponent

#Health
@export var max_health:  int = 100
@export var defense:     int = 10
var health:      int = max_health

#STATS
@export var vitatlity:   int
@export var strenght:    int
@export var dexterity:   int
@export var inteligence: int
@export var luck:        int

#UI
@onready var World = get_tree().get_root().get_child(0)
@onready var Ui = get_tree().get_root().get_child(0).get_node('Ui')
@onready var HealthBar: ProgressBar = Ui.get_node('HealthBar')
#@onready var HealthBar: ProgressBar = Ui.get_node('PanelContainer').get_child(0).get_node('HealthBar')

var isAlive:             bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print(HealthBar)
	health = max_health
	update_ui()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(damage: int):
	if not isAlive: return
	health =- damage - defense
	check_if_is_alive()
	update_ui()


func check_if_is_alive():
	if health <= 0:
		isAlive = false
		return isAlive
	else:
		isAlive = true
		return isAlive
		
func update_ui():
	HealthBar.value = health
	HealthBar.max_value = max_health
	pass
		
		
