extends Control

signal inicia

func _ready() -> void:
	get_tree().paused = true

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/main.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
