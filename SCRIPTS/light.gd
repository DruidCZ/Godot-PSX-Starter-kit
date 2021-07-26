extends Interactable

export var light : NodePath
export var on_by_default = false
export var on_energy = 5
export var off_energy = 0

onready var light_node = get_node(light)
onready var on = on_by_default

func _ready() -> void:
	set_light_energy()

func get_interaction_text():
	return "Lights off" if on else "Lights ON!"

func interact():
	on = !on
	set_light_energy()

func set_light_energy():
	light_node.set_param(Light.PARAM_ENERGY, on_energy if on else off_energy)
