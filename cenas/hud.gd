extends CanvasLayer

signal reinicia
signal pause

func _ready() -> void:
	if Global.multiplayer_enabled:
		$Placar.text = "Jogador 1: 0"
		$Placar.set("theme_override_font_sizes/font_size", 16)
		$Placar.position = Vector2(350,0)
		$Placar_player2.position = Vector2(750,0)
		$Placar_player2.show()
		$Placar_player2.show()

func _on_button_pressed():
	emit_signal("reinicia")

func _on_pause_pressed() -> void:
	emit_signal("pause")
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		emit_signal("pause")
