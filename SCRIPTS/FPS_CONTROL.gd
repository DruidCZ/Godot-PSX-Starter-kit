extends VBoxContainer

export var def_fog_begin = 10
export var def_fog_end = 40

export(Environment) var environment
export(Material) var dither
export(Material) var blur
export(Material) var led
export(Material) var vhs

#Debug components

#FPS control
onready var fps_slider = $fps_slider
onready var fps_label = $FPS_LABEL

#Fog control
onready var fog_begin_label = $begin
onready var fog_begin_slider = $fog_begin_slider

onready var fog_end_label = $end
onready var fog_end_slider = $fog_end_slider

#Post process control
onready var dither_box = get_parent().get_node("PP_setup/PP_buttons/dither_b")
onready var blur_box = get_parent().get_node("PP_setup/PP_buttons/blur_b")
onready var led_box = get_parent().get_node("PP_setup/PP_buttons/led_b")
onready var vhs_box = get_parent().get_node("PP_setup2/PP_buttons/vhs_b")
onready var ntsc_box = get_parent().get_node("PP_setup/PP_buttons/ntsc_b")
onready var noir_box = get_parent().get_node("PP_setup2/PP_buttons/noir_b")
onready var grain_box = get_parent().get_node("PP_setup2/PP_buttons/grain_b")
onready var tv_box = get_parent().get_node("PP_setup2/PP_buttons/tv_b")


onready var ntsc_overlay = get_parent().get_parent().get_parent().get_parent().get_node("Screen_effects/BB_NTSC/NTSC")
onready var vhs_overlay = get_parent().get_parent().get_parent().get_parent().get_node("Screen_effects/BB_VHS/VHS")
onready var noir_overlay = get_parent().get_parent().get_parent().get_parent().get_node("Screen_effects/BB_BW/BW")
onready var grain_overlay = get_parent().get_parent().get_parent().get_parent().get_node("Screen_effects/BB_Grain/Grain")
onready var tv_overlay = get_parent().get_parent().get_parent().get_parent().get_node("Screen_effects/BB_TV/TV")
#Colors setup
onready var color_label = get_parent().get_node("COL_setup/col_label")
onready var color_slider = get_parent().get_node("COL_setup/color_slider")

#Fps export value
export var fps = 24

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_settings()
	
func reset_settings():
	#Setup default fps
	fps_slider.min_value = 24
	fps_slider.max_value = 120
	fps_slider.value = 25
	Engine.set_target_fps(fps_slider.value)
	fps_label.text = "FPS : "+str(fps_slider.value)
	
	#Setup default fog
	fog_begin_slider.min_value = 0
	fog_end_slider.min_value = 0
	fog_begin_slider.max_value = 50
	fog_end_slider.max_value = 100
	fog_begin_slider.value = def_fog_begin
	fog_end_slider.value = def_fog_end
	
	#Setup default PP
	dither.set_shader_param("dither_banding",true)
	led.set_shader_param("enabled", false)
	blur.set_shader_param("enabled", false)
	ntsc_overlay.visible = false
	vhs_overlay.visible = false
	noir_overlay.visible = false
	tv_overlay.visible = false
	grain_overlay.visible = false
	
	#Setup default colors
	color_slider.value = 15
	color_label.text = "Colors : "+str(color_slider.value)
	
	#Reset buttons
	blur_box.pressed = false
	vhs_box.pressed = false
	ntsc_box.pressed = false
	noir_box.pressed = false
	tv_box.pressed = false
	led_box.pressed = false
	grain_box.pressed = false
	
	
	
#Button functions
func set_post_process_blur(enabled: bool):
	blur.set_shader_param("enabled", enabled)
func set_post_process_led(enabled: bool):
	led.set_shader_param("enabled", enabled)
func set_dithering(enabled: bool):
	dither.set_shader_param("dither_banding",enabled)
func set_post_process_ntsc(_visible):
	ntsc_overlay.visible = !ntsc_overlay.visible
func set_post_process_vhs(_visible):
	vhs_overlay.visible = !vhs_overlay.visible
func set_post_process_noir(_visible):
	noir_overlay.visible = !noir_overlay.visible
func set_post_process_grain(_visible):
	grain_overlay.visible = !grain_overlay.visible
func set_post_process_tv(_visible):
	tv_overlay.visible = !tv_overlay.visible

func _process(_delta: float) -> void:
	pass


func _on_fps_slider_value_changed(_value: float) -> void:
	Engine.set_target_fps(fps_slider.value)
	fps_label.text = "FPS : "+str(fps_slider.value)


func _on_fog_begin_slider_value_changed(_value: float) -> void:
	environment.set_fog_depth_begin(fog_begin_slider.value)
	fog_begin_label.text = "begin : "+str(fog_begin_slider.value)


func _on_fog_end_slider_value_changed(_value: float) -> void:
	environment.set_fog_depth_end(fog_end_slider.value)
	fog_end_label.text = "end : "+str(fog_end_slider.value)


func _on_color_slider_value_changed(value: int) -> void:
	dither.set_shader_param("col_depth", value)
	color_label.text = "Colors : "+str(color_slider.value)



func _on_Button_pressed() -> void:
	reset_settings()


func _on_Button_button_up() -> void:
	reset_settings()
