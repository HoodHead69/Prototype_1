extends CharacterBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var main_sprite: Node2D = $Main_Sprite

const SPEED = 1200.0
const JUMP_VELOCITY = -100.0
var is_in_range: bool = false
var target_object = []
@onready var marker_2d: Marker2D = $Main_Sprite/Right_Arm/Right_Hand/Marker2D
var inventory = []



func _physics_process(delta: float) -> void:
	Interact()
	if not is_on_floor():
		velocity.y += 300 * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("Left", "Right")
	
	velocity.x = direction * SPEED * delta 
	
	
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if velocity.x > 0:
		main_sprite.scale.x = sign(velocity.x)
		anim_player.play("Walk_3", 1)
	elif velocity.x < 0:
		main_sprite.scale.x = sign(velocity.x)
		anim_player.play("Walk_3", 1)
	else:
		anim_player.play("Idle", 1)
	
	if Input.is_action_just_pressed("Punch"):
		anim_player.play("Punch" )
	if Input.is_action_pressed("Interact"):
		anim_player.play("interact", 1)
		
	if Input.is_action_just_pressed("Drop"):
		print("Berhasil")
		Drop()
		
func Interact() -> void:
	if is_in_range:
		if Input.is_action_just_pressed("Interact"):
			var Picked_Object = target_object[0].duplicate(true)
			inventory.append(Picked_Object)
			target_object[0].queue_free()
			target_object.erase(0)
			if target_object.size() != 0:
				is_in_range = true
			else:
				is_in_range = false
			print(target_object)
			print(inventory)
			
func Drop() -> void:
	if inventory.size() != 0:
		var Dropped_Item: PackedScene = inventory[0]
		var existing_item: Node = Dropped_Item.instantiate()
		existing_item.position = main_sprite.position
		get_parent().add_child(existing_item)
		
				
			
func _on_interact_range_body_entered(body: Node2D) -> void:
	if body is Item:
		is_in_range = true
		target_object.append(body)
		print(is_in_range)


func _on_interact_range_body_exited(body: Node2D) -> void:
	if body is Item:
		target_object.erase(body)
		if target_object.size() == 0:
			is_in_range = false
		print(is_in_range)
