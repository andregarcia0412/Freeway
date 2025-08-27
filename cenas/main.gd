extends Node

var cena_carros = preload("res://cenas/carros.tscn")
var pistas_rapidas_y:Array = [104, 272, 495]
var pistas_lentas_y:Array = [160, 324, 384, 550]
var pistas_reversas_y:Array = [216, 438, 606]
var score:int = 0


func _ready():
	get_tree().paused = false
	$HUD/Placar.text = str(score)
	$HUD/Mensagem.hide()
	$HUD/Button.hide()
	$AudioTema.play()
	randomize()

func _on_timer_carros_rapidos_timeout():
	var carro = cena_carros.instantiate()
	add_child(carro)
	var pista_y = pistas_rapidas_y[randi_range(0, pistas_rapidas_y.size()-1)]
	carro.position = Vector2(-10,pista_y)
	carro.linear_velocity = Vector2(randi_range(700, 720), 0)
	carro.set_linear_damp(0)

func _on_timer_carros_lentos_timeout():
	var carro = cena_carros.instantiate()
	add_child(carro)
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size()-1)]
	carro.position = Vector2(-10, pista_y)
	carro.linear_velocity = Vector2(randi_range(300, 320),0)
	carro.set_linear_damp(0)
	
func _on_timer_carros_reversos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro)
	var pista_y = pistas_reversas_y[randi_range(0, pistas_reversas_y.size()-1)]
	carro.position = Vector2(1290, pista_y)
	carro.linear_velocity = Vector2(randi_range(-430, -450),0)
	carro.set_linear_damp(0)
	


func _on_player_pontua():
	if score <= 10:
		score += 1
		$HUD/Placar.text = str(score)
		$AudioPonto.play()
	if score == 10:
		$HUD/Mensagem.show()
		$HUD/Mensagem.text = "Você Venceu!"
		$HUD/Mensagem.add_theme_color_override("font_color", Color(Color.GREEN))
		$HUD/Button.show()
		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$AudioVitoria.play()
		$Player.speed = 0
		
 
func _on_hud_reinicia():
	get_tree().reload_current_scene()


func _on_timer_game_over_timeout() -> void:
	$HUD/Mensagem.show()
	$HUD/Mensagem.text = "Game Over!"
	$HUD/Mensagem.add_theme_color_override("font_color", Color(Color.RED))
	$HUD/Button.show()
	$TimerCarrosLentos.stop()
	$TimerCarrosRapidos.stop()
	$AudioVitoria.play()
	$Player.speed = 0
	$AudioDerrota.play()
	get_tree().paused = true
	
func _process(delta: float) -> void:
	$HUD/Tempo.text = "Tempo: " + str(int($TimerGameOver.time_left))
