extends RayCast

var current_collider


func _process(_delta: float) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			set_interaction_text(collider.get_interaction_text())
			
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text("")
			

func set_interaction_text(_text):
#	if !text:
#		interaction_label.set_text("")
#		interaction_label.set_visible(false)
#	else:
#		var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)
#		interaction_label.set_text(text)
#		interaction_label.set_visible(true)
	pass
	
