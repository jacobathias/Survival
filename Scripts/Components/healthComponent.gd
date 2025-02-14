@icon ("res://Node Icons/health.png")
extends Node
class_name HealthComponent

#Health
@export var max_health:  int = 100
@export var defense:     int = 10
var health: 			 int

#STATS
@export var vitality:   int
@export var strength:    int
@export var dexterity:   int
@export var intelligence: int
@export var luck:        int

#UI
@onready var World = get_tree().get_root().get_child(0)
@onready var Ui = get_tree().get_root().get_child(0).get_node('Ui')
@onready var PlayerHealthBar: ProgressBar = Ui.get_node('PlayerHealthBar')
@onready var Camera: Camera3D = get_tree().get_root().get_child(0).get_node('Camera')
var HealthBar: ProgressBar 
#@onready var HealthBar: ProgressBar = Ui.get_node('PanelContainer').get_child(0).get_node('HealthBar')

var isAlive:             bool = true
var isPlayer: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	HealthBar = $CanvasLayer/HealthBar
	health = max_health
	if get_parent().name == "Player": 
		isPlayer = true
		HealthBar.get_parent().queue_free()
	update_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#update_ui()
	if not isPlayer: HealthBar.position = world_to_screen()

func damage(dmg: int):
	#print('hit')
	if not isAlive: return
	health = health - clamp(dmg-defense,0,max_health)
	update_ui()
	check_if_is_alive()

func check_if_is_alive():
	if health <= 0:
		isAlive = false
		get_parent().queue_free()
		return isAlive
	else:
		isAlive = true
		return isAlive
		
func update_ui():
	if isPlayer:
		PlayerHealthBar.value = health
		PlayerHealthBar.max_value = max_health
		return
		
	HealthBar.value = health
	HealthBar.max_value = max_health
		

func world_to_screen()-> Vector2:
	var world_position = get_parent().position
	var screen_position = Camera.unproject_position(world_position)
	return screen_position

func check_if_isPLayer()-> bool:
	return isPlayer
