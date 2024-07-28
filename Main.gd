extends Node

var room_scene: Node
var player_speed = 400
var lock_controls : bool = true
var player_velocity: Vector2
var doorways = { 
	1 : 3,
	3 : 1
}
var door_rooms = { 
	1 : "Room",
	3 : "Room2"
}
var door_enter_id : int
signal interact
# Called when the node enters the scene tree for the first time.
func _ready():
	# room_scene = tutorial
	$Player.hide()
	room_scene = $Room
	$Room2.position = Vector2(1000, 1000)
	# player enters the room
	door_enter_id = 1
	$DoorLeaveTimer.start()
	# start dialogue scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not lock_controls:
		player_velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			player_velocity.x += 1
		if Input.is_action_pressed("move_left"):
			player_velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			player_velocity.y += 1
		if Input.is_action_pressed("move_up"):
			player_velocity.y -= 1
		if Input.is_action_just_pressed("interact"):
			player_velocity = Vector2.ZERO
			interact.emit()
	$Player.velocity = player_velocity.normalized() * player_speed
	$Player.move_and_slide()
	$Player.position.y = max($Player.position.y, room_scene.floor_top)
			
func leave_door(door_id : int):
	if door_id % 2 == 1:
		player_velocity = Vector2(1, 0)
	else:
		player_velocity = Vector2(-1, 0)
	door_enter_id = doorways[door_id]
	$DoorLeaveTimer.start()

func _on_door_leave_timer_timeout():
	player_velocity = Vector2.ZERO
	enter_door(door_enter_id)

func enter_door(door_id : int):
	room_scene.position = Vector2(1000, 1000)
	room_scene = get_node(door_rooms[door_id])
	room_scene.position = Vector2(320, 256)
	if door_id % 2 == 1:
		player_velocity = Vector2(-1, 0)
		$Player.position.x = 672
	else:
		player_velocity = Vector2(1, 0)
		$Player.position.x = -32
	$DoorEnterTimer.start()
	$Player.show()


func _on_door_enter_timer_timeout():
	player_velocity = Vector2.ZERO
	lock_controls = false

