extends CanvasLayer

var main_node : Node
var interact_id : int = 0
var interact_cnt : int = 0
var interactables = {
	0: {
		"length" : 1,
		"messages" : ["Hi!", "I'm Elaina."],
	},
	2: {
		"length" : 2,
		"messages" : ["Hi!", "I'm Elaina."],
		"portraits" : ["", ""]
	}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	main_node = get_parent()
	$Message.hide()
	$Portrait.hide()
	$HUDBG.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main_node.lock_controls:
		if interact_id in interactables and Input.is_action_just_pressed("interact"):
			if interact_cnt < interactables[interact_id]["length"]:
				show_portrait(interact_cnt)
				show_message(interact_cnt)
				interact_cnt += 1
			else:
				$Portrait.hide()
				$Message.hide()
				$HUDBG.hide()
				interact_cnt = 0
				main_node.lock_controls = false
			
			


func _on_main_interact():
	main_node.lock_controls = true
	match interact_id:
		1:
			main_node.leave_door(1)
		2:
			pass # dialogue
		3: 
			main_node.leave_door(3)
		_:
			main_node.lock_controls = false
	


func _on_interactable_change_interact_id(id):
	interact_id = id
	if interact_id == 0:
		$Portrait.hide()
		$Message.hide()
		$HUDBG.hide()
	else:
		$Message.text = "[E] to interact."
		$Message.show()
		$HUDBG.show()
		
func show_portrait(id):
	var image = Image.load_from_file(interactables[interact_id]["portraits"][id])
	if image:
		$Portrait.texture = ImageTexture.create_from_image(image)
		$Portrait.show()

func show_message(id):
	$Message.text = interactables[interact_id]["messages"][id]
	$Message.show()
	




func _on_inventory_button_pressed():
	if $InventoryGrid.position.x < 640:
		$InventoryGrid.position.x += $InventoryGrid.size.x
		$InventoryButton.position.x += $InventoryGrid.size.x
		main_node.lock_controls = false
	else:
		$InventoryGrid.position.x -= $InventoryGrid.size.x
		$InventoryButton.position.x -= $InventoryGrid.size.x
		main_node.lock_controls = true



