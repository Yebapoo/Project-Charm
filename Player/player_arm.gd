extends MeshInstance3D

@export var armSwingDuration: float = 0.5
@export var endAngleTranslation: float = 30.0

var swinging: bool = false
var currentSwingTime: float = 0
var idleRotation: Vector3

func _ready():
	idleRotation = rotation_degrees


func startArmSwing():
	if not swinging:
		swinging = true
		currentSwingTime = 0.0

func _process(delta):
	if swinging:
		currentSwingTime += delta
		var startAngle = idleRotation.x
		var endAngle = startAngle+ endAngleTranslation
		var progress = currentSwingTime / armSwingDuration
		
		if progress < 0.5:
			var angle = lerp(startAngle, endAngle, progress* 2)
			rotation_degrees.x = angle
		else:
			var angle= lerp(endAngle, startAngle, (progress-0.5) * 2)
			rotation_degrees.x = angle
		if currentSwingTime >= armSwingDuration:
			swinging=false
			currentSwingTime = 0.0
			rotation_degrees=idleRotation
			
			
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and not swinging:
			startArmSwing()
			
