extends CharacterBody2D

var max_hp = 100
var hp = 100

var sun_damage = 5
var sun_damage_time = 3.0
var sun_timer = 0.0
var sun 

enum {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@onready var anim = $AnimatedSprite2D
var speed = 100
var idle_dir = DOWN

func _ready():
	var suns = get_tree().get_nodes_in_group("Sun")
	if suns.size()>0:
		sun = suns[0]
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		up_move()
	elif Input.is_action_pressed("down"):
		down_move()
	elif Input.is_action_pressed("left"):
		left_move()
	elif Input.is_action_pressed("right"):
		right_move()
	else:
		idle()
	
	move_and_slide()
	if sun!=null:
		if not sun.is_player_in_shadow(self):
			sun_timer+=delta
			if sun_timer>=sun_damage_time:
				hp-=sun_damage
				sun_timer=0
				print("HP:",hp)
		else:
			sun_timer=0

func up_move():
	anim.play("Up")
	velocity.x = 0
	velocity.y = -speed
	idle_dir = UP

func down_move():
	anim.play("Down")
	velocity.x = 0
	velocity.y = speed
	idle_dir = DOWN

func right_move():
	anim.flip_h = false
	anim.play("Front")
	velocity.x = speed
	velocity.y = 0
	idle_dir = RIGHT

func left_move():
	anim.flip_h = true
	anim.play("Front")
	velocity.x = -speed
	velocity.y = 0
	idle_dir = LEFT

func idle():
	velocity.x = 0
	velocity.y = 0
	if velocity.x == 0 and velocity.y == 0:
		match idle_dir:
			DOWN:
				anim.play("Idle_down")
			UP:
				anim.play("Idle_up")
			LEFT:
				anim.flip_h = true
				anim.play("Idle_front")
			RIGHT:
				anim.flip_h = false
				anim.play("Idle_front")
