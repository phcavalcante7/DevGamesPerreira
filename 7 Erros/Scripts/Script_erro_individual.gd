extends Area2D

var mouse_in_area = false
export var marca_x : PackedScene
var red_x = preload("res://Scenes/Red_x.tscn")
onready var colllision_child = get_child(0)

func _ready():
	connect("mouse_entered", self, "on_area_mouse_entered")
	connect("mouse_exited", self, "on_area_mouse_exit")


func _input(event):
	if mouse_in_area and event.is_pressed() and event.button_index == BUTTON_LEFT:
		play_audio()
		print("clicked")
		Data_Difficult.find_errors += 1
		var child = red_x.instance()
		child.position = colllision_child.position
		child.z_index = 1
		add_child(child)
		colllision_child.visible = false
		

func on_area_mouse_entered():
	mouse_in_area = true
	

func on_area_mouse_exit():
	mouse_in_area = false


func on_audio_ends():
	$Audio.queue_free()


func play_audio():
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.name = "Audio"
	audio.connect("finished", self, "on_audio_ends")
	audio.stream = preload("res://Assets/Sounds/success_bell-6776.mp3")
	audio.play(0.0)
