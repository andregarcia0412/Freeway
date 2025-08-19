extends RigidBody2D
@onready var animacao: AnimatedSprite2D = $Animacao

func _ready():
	var tipos_carros = animacao.sprite_frames.get_animation_names()
	var carro = tipos_carros[randi_range(0, tipos_carros.size() - 1)]
	animacao.animation = carro
	if animacao.animation == "cavalo":
		animacao.rotation = -PI/2
		animacao.scale = Vector2(1.6, 1.6)
	else:
		animacao.rotation = 0
		animacao.scale = Vector2(0.3, 0.3)
		

func _on_notificador_screen_exited():
	queue_free()
