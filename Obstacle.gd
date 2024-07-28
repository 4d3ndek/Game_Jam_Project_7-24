extends StaticBody2D

@export var size : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	var new_shape = RectangleShape2D.new()
	new_shape.set_size(size)
	$CollisionShape2D.shape = new_shape
	$Sprite2D.scale.x = size.x/$Sprite2D.texture.get_width()
	$Sprite2D.scale.y = size.y/$Sprite2D.texture.get_height()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	z_index = position.y
