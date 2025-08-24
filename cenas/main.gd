extends Node

var cena_carros = preload("res://cenas/carros.tscn")
var pistas_rapidas_y:Array = [104, 272, 488]
var pistas_lentas_y:Array = [160, 216, 324, 384, 438, 550, 606]
var score:int = 0


func _ready():
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


func _on_player_pontua():
	if score <= 10:
		score += 1
		$HUD/Placar.text = str(score)
		$AudioPonto.play()
	if score == 10:
		$HUD/Mensagem.show()
		$HUD/Button.show()
		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$AudioVitoria.play()
		$Player.speed = 0
		
 
func _on_hud_reinicia():
	get_tree().reload_current_scene()
