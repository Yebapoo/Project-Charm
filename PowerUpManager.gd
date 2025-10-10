extends Node
class_name PowerUpManager

var owner_player: CharacterBody3D
var active_powerups := {}  # {effect_name: {value: float, timer: Timer}}

func init(player: CharacterBody3D):
	owner_player = player
	

func apply_power_up(effect_name: String, value: float, duration: float) -> void:
	match effect_name:
		"speed":
			owner_player.speed *= value
		"jump":
			owner_player.jump_velocity *= value
# add more effects here
	
	if active_powerups.has(effect_name):
		active_powerups[effect_name]["timer"].stop()
		active_powerups[effect_name]["timer"].start(duration)
	else:
		var timer = Timer.new()
		timer.one_shot = true
		timer.timeout.connect(func(): _remove_power_up(effect_name, value))
		add_child(timer)
		timer.start(duration)
		active_powerups[effect_name] = {"value": value, "timer": timer}
		
func _remove_power_up(effect_name: String, value: float) -> void:
	match effect_name:
		"speed":
			owner_player.speed /= value
		"jump":
			owner_player.jump_velocity /= value
# reverse other effects here
	active_powerups.erase(effect_name)
