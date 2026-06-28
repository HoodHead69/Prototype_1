extends Area2D
class_name TransitionArea

var On_range: bool = false 
const SCENE_FOLDER = "res://RoomTest/"
var scene_array: Array = []
var IS_ENTRY: bool = false
var LEAD_TO = null
@onready var LABEL:Label = $Label


func _ready() -> void:
	SceneManager.pick_player(get_parent())
	if IS_ENTRY:
		LEAD_TO = SceneManager.PREVIOUS_ROOM
		LABEL.text = "ENTRY"
	else:
		LABEL.text = "EXIT"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		if On_range and !IS_ENTRY:
			SceneManager.transition_to_new(get_parent(), GenerateRoom())
			LEAD_TO = SceneManager.NEXT_ROOM
			IS_ENTRY = true
		elif On_range and IS_ENTRY:
			SceneManager.return_to(get_parent(),LEAD_TO)
		
			
			
func GenerateRoom():
	scene_array = SceneManager.load_scene_from_folder(SCENE_FOLDER)
	var choosen_scene = scene_array.pick_random()
	return choosen_scene


func _on_body_entered(body: Player) -> void:
	On_range = true
	print("On Range = True")

func _on_body_exited(body: Player) -> void:
	On_range = false
	print('On Range = False')
