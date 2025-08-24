extends CanvasLayer

signal reinicia

func _on_button_pressed():
	emit_signal("reinicia")
