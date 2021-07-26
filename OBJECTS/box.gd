extends Interactable

#Set up path to label or your dialog system in interaction script.
#Function get interaction text will return .... text
#Key for interacting is E. You can change it in project settings.

onready var box_anim = get_parent().get_node("AnimationPlayer")

func _ready() -> void:
	pass

func get_interaction_text():
	return "The mystery box."

func interact():
	box_anim.play("jump")
	
	
