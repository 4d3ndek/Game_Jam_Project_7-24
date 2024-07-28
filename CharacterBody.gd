extends CharacterBody2D

var screen_size
@export var speed = 400
var main_node : Node
@export var size : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2.ZERO
	main_node = get_parent()
	var new_shape = RectangleShape2D.new()
	new_shape.set_size(size)
	$CollisionShape2D.shape = new_shape
	$Sprite2D.scale.x = size.x/$Sprite2D.texture.get_width()
	$Sprite2D.scale.y = size.y/$Sprite2D.texture.get_height()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not main_node.lock_controls:
		position = position.clamp(Vector2(32, 32), screen_size-Vector2(32, 32))
	z_index = position.y
	

