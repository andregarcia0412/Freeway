extends CanvasLayer

signal continua
signal sair
var is_paused:bool = false

func _on_continuar_pressed() -> void:
	emit_signal("continua")


func _on_sair_pressed() -> void:
	emit_signal("sair")
	Global.multiplayer_enabled = false
