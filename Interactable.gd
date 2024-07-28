extends Area2D

@export var radius : float = 10
@export var interact_id : int
signal change_interact_id(id : int)
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape.radius = radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	change_interact_id.emit(interact_id)


func _on_body_exited(body):
	change_interact_id.emit(0)
