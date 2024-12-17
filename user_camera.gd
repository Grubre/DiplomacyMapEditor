extends Camera2D

@export var movement_speed: float = 1000

var panning_start_mouse_pos = Vector2()
var panning_start_camera_pos = Vector2()
var is_panning = false
var old_cursor_shape:int = Input.CURSOR_ARROW

func _ready() -> void:
	pass # Replace with function body.
	
func handle_zoom(delta: float):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom = zoom * 1.1
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom = zoom / 1.1
		
func handle_camera_movement(delta: float):
	var offset = Vector2()
	if Input.is_action_pressed("camera_move_left"):
		offset.x -= 1
	if Input.is_action_pressed("camera_move_right"):
		offset.x += 1
	if Input.is_action_pressed("camera_move_down"):
		offset.y += 1
	if Input.is_action_pressed("camera_move_up"):
		offset.y -= 1
	
	offset = offset.normalized() * movement_speed * delta * (1/zoom.x)
	translate(offset)
	
func handle_panning(delta):
	if !is_panning and Input.is_action_just_pressed("camera_pan"):
		panning_start_mouse_pos = get_viewport().get_mouse_position()
		panning_start_camera_pos = position
		is_panning = true
		old_cursor_shape = Input.get_current_cursor_shape()
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		
	if is_panning and Input.is_action_just_released("camera_pan"):
		Input.set_default_cursor_shape(old_cursor_shape)
		is_panning = false
		
	if is_panning:
		var offset = get_viewport().get_mouse_position() - panning_start_mouse_pos
		position = panning_start_camera_pos - offset * 1/zoom.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_zoom(delta)
	handle_camera_movement(delta)
	handle_panning(delta)
	pass
