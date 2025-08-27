extends Node

var cena_carros = preload("res://cenas/carros.tscn")
var pistas_rapidas_y:Array = [104, 272, 495]
var pistas_lentas_y:Array = [160, 324, 384, 550]
var pistas_reversas_y:Array = [216, 438, 606]
var score_player1:int = 0
var score_player2:int = 0


func _ready():
	get_tree().paused = false
	$HUD/Placar.text = str(score_player1)
	$HUD/Mensagem.hide()
	$HUD/Button.hide()
	$AudioTema.play()
	randomize()
	if Global.multiplayer_enabled:
		$Player2.show()
		$Player2.set_process_mode(Node.ProcessMode.PROCESS_MODE_INHERIT)
		$HUD/Placar.text = "Jogador 1: " + str(score_player1)
		$HUD/Placar_player2.text = "Jogador 2: " + str(score_player2)

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
	if score_player1 <= 10:
		score_player1 += 1
		if $Player2.is_visible_in_tree():
			$HUD/Placar.text = "Jogador 1: " + str(score_player1)
		else:
			$HUD/Placar.text = str(score_player1)
		$AudioPonto.play()
	if score_player1 == 10:
		$HUD/Mensagem.show()
		if $Player2.is_visible_in_tree():
			$HUD/Mensagem.text = "Jogador 1 Venceu!"
		else:
			$HUD/Mensagem.text = "Você Venceu!"
		$HUD/Mensagem.add_theme_color_override("font_color", Color(Color.GREEN))
		$HUD/Button.show()
		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$AudioVitoria.play()
		get_tree().paused = true
		
 
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
	$AudioDerrota.play()
	get_tree().paused = true
	
func _process(delta: float) -> void:
	$HUD/Tempo.text = "Tempo: " + str(int($TimerGameOver.time_left))


func _on_hud_pause() -> void:
	$Pause_Menu.show()
	get_tree().paused = true


func _on_pause_menu_continua() -> void:
	$Pause_Menu.hide()
	get_tree().paused = false


func _on_pause_menu_sair() -> void:
	get_tree().change_scene_to_file("res://cenas/menu.tscn")


func _on_player_2_player_2_pontua() -> void:
	if score_player2 <= 10:
		score_player2 += 1
		$HUD/Placar_player2.text = "Jogador 2: " + str(score_player2)
		$AudioPonto.play()
	if score_player2 == 10:
		$HUD/Mensagem.show()
		$HUD/Mensagem.text = "Jogador 2 Venceu!"
		$HUD/Mensagem.add_theme_color_override("font_color", Color(Color.GREEN))
		$HUD/Button.show()
		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$AudioVitoria.play()
		get_tree().paused = true
