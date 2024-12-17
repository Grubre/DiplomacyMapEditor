extends Node2D

@onready var file_dialog: FileDialog = $FileDialog
@onready var background: Sprite2D = $Background
@onready var error_label: Label = $ErrorLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("open_file_dialog"):
		open_file_dialog()
	pass
	
func open_file_dialog():
	error_label.text = ""
	file_dialog.visible = true

func _on_file_dialog_file_selected(path: String) -> void:
	var image = Image.new()
	var err = image.load(path)
	if(err != 0):
		error_label.text = "Could not load file '" + path + "'"
	
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	background.texture = image_texture
	
	background.position = background.texture.get_size() / 2
