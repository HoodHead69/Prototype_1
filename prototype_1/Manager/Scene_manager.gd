class_name scene_manager extends Node
var PLAYER: Player
var PREVIOUS_ROOM: Room 
var NEXT_ROOM: Room

#FUNGSI UNTUK MEMINDAHKAN PLAYER DARI ORIGIN KE DESTINATION
	
func transition_to_new(origin: Room, destination:PackedScene) -> void:
	PLAYER = origin.PLAYER
	PLAYER.get_parent().remove_child(PLAYER)
	
	PREVIOUS_ROOM = origin
	
	#MENGUBAH CURRENT_SCENE(ORIGIN) PADA ROOT(WINDOW) MENJADI NEW_ROOM(DESTINATION)
	get_tree().root.remove_child(origin)
	var new_room = destination.instantiate()
	
	NEXT_ROOM = new_room
	
	get_tree().root.add_child(new_room)
	get_tree().current_scene = new_room
	new_room.add_child(PLAYER)
	PLAYER.position = new_room.ENTRY_DOOR_LOCATION.position
	
func return_to(origin:Room, room:Room):
	PLAYER.get_parent().remove_child(PLAYER)
	get_tree().root.remove_child(origin)
	get_tree().root.add_child(room)
	get_tree().current_scene = room
	room.add_child(PLAYER)
	print("RETURN")
	PLAYER.position = room.EXIT_DOOR_LOCATION.position
	
	
#FUNGSI UNTUK MENGUBAH SCENE DALAM FOLDER MENJADI SEBUAH ARRAY
func load_scene_from_folder(path: String) -> Array:
	var scenes: Array = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if !dir.current_is_dir() and (file_name.ends_with(".tscn") or file_name.ends_with(".scn")):
				var full_path = path.path_join(file_name)
				var loaded_scene = load(full_path)
				
				if loaded_scene:
					scenes.append(loaded_scene)
			file_name = dir.get_next()
	dir.list_dir_end()
	return scenes
	
func pick_player(origin):
	PLAYER = origin.PLAYER
	
	
