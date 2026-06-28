class_name Room extends Node

@onready var PLAYER: Player = $Player
@onready var INTERACTABLE_MARKER: Node2D = $Interactable_Marker
var NUMBER_OF_DOOR = 2
var ENTRY_DOOR_LOCATION: Marker2D
var ENTRY_DOOR: TransitionArea
var EXIT_DOOR_LOCATION

func _ready() -> void:
	ENTRY_DOOR_LOCATION = define_marker().pick_random()
	room_entered()
		
#MEMILIH MARKER YANG ADA PADA SCENE SECARA RANDOM 
func define_marker() -> Array:
	var MARKER_ARRAY = []
	for marker in INTERACTABLE_MARKER.get_children():
		if marker is Marker2D:
			MARKER_ARRAY.append(marker)
	return MARKER_ARRAY
	
#MEMILIH SCENE INTERACTABLE DARI FOLDER TYPE SECARA RANDOM 
func choose_interactable(TYPE):
	var INTERACTABLE_ARRAY = []
	INTERACTABLE_ARRAY = SceneManager.load_scene_from_folder("res://Interactable/" + TYPE + "/")
	var CHOOSEN_INTERACTABLE = INTERACTABLE_ARRAY.pick_random()
	return CHOOSEN_INTERACTABLE

#INSTANTIATE ASSIGNED_INTERACTABLE PADA POSISI MARKER
func assign_interactable(MARKER: Marker2D, ASSIGNED_INTERACTABLE, ENTRY:bool):
	var INTERACTABLE = ASSIGNED_INTERACTABLE.instantiate()
	if ENTRY == true:
		INTERACTABLE.IS_ENTRY = true
		print("ENTRY")
	INTERACTABLE.position = MARKER.position
	add_child(INTERACTABLE)

	
func room_entered():
	if SceneManager.PLAYER:
		if PLAYER:
			PLAYER.queue_free()
		PLAYER = SceneManager.PLAYER
		add_child(PLAYER)
		assign_interactable(ENTRY_DOOR_LOCATION, choose_interactable("Transition"), true)
		EXIT_DOOR_LOCATION = ENTRY_DOOR_LOCATION
		while EXIT_DOOR_LOCATION == ENTRY_DOOR_LOCATION:
			EXIT_DOOR_LOCATION = define_marker().pick_random()
		assign_interactable(EXIT_DOOR_LOCATION, choose_interactable("Transition"), false)
	else:
		assign_interactable(ENTRY_DOOR_LOCATION, choose_interactable("Transition"), true)
		EXIT_DOOR_LOCATION = ENTRY_DOOR_LOCATION
		while EXIT_DOOR_LOCATION == ENTRY_DOOR_LOCATION:
			EXIT_DOOR_LOCATION = define_marker().pick_random()
		assign_interactable(EXIT_DOOR_LOCATION, choose_interactable("Transition"), false)
		
	print("Player in Scene:" + SceneManager.PLAYER.name)
	print(PLAYER.name)
	print(PLAYER)
	
func position_player():
	PLAYER.position = ENTRY_DOOR_LOCATION.position
	
	
	
