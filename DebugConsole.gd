extends Control

@export var max_lines: int = 10  # how many lines to keep

var lines: Array[String] = []

@onready var label: Label = $Panel/MarginContainer/Label

func _ready() -> void:
	# Clear label on start
	label.text = ""
	# Start listening for custom logs
	if not Engine.has_singleton("DebugConsole"):
		Engine.register_singleton("DebugConsole", self)

func log(text: String) -> void:
	# Add a line to our console
	lines.append(text)
	if lines.size() > max_lines:
		lines.pop_front()
	label.text = "\n".join(lines)
