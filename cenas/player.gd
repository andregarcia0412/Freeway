extends Area2D
signal pontua
@export var speed: float = 100.0
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(640, 690)

func _ready() -> void: 
	screen_size = get_viewport_rect().size
	position = posicao_inicial
	$Colisao.disabled = true
	$ColisaoHorizontal.disabled = false

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$Animacao.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$Animacao.flip_h = true
	
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position.y = clamp(position.y, 0, screen_size.y)
	position.x = clamp(position.x, 0, screen_size.x)

	if velocity.y > 0:
		$Animacao.play("baixo")
		$Colisao.disabled = false
		$ColisaoHorizontal.disabled = true
	elif velocity.y < 0:
		$Animacao.play("cima")
		$Colisao.disabled = false
		$ColisaoHorizontal.disabled = true
	elif velocity.x != 0:
		$Animacao.play("horizontal")
		$Colisao.disabled = true
		$ColisaoHorizontal.disabled = false
	else:
		$Animacao.stop()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "LinhaChegada":
		emit_signal("pontua")
	else:
		$Audio.play()
		position = posicao_inicial
		
