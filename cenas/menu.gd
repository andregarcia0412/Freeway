extends Control


func _ready() -> void:
	get_tree().paused = true
	Global.speed = 250

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/main.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_easy_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.speed = 350


func _on_medium_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.speed = 250


func _on_hard_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.speed = 150


func _on_check_button_toggled(toggled_on: bool) -> void:
	Global.multiplayer_enabled = !Global.multiplayer_enabled
