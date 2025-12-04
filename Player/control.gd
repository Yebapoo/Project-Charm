extends Control

@export var dot_radius = 2
@export var dot_color = Color (1,1,1)

func _ready():
	set_process_input(false)
	queue_redraw()

func  _draw():
	var center = get_size()/2
	draw_circle(center,dot_radius, dot_color)
