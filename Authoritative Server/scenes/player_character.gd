extends CharacterBody2D

@onready var hurtbox_component: HurtBoxComponent = $HurtBoxComponent
@onready var hitbox_component: HitBoxComponent = $HitBoxComponent

func _ready():
	hurtbox_component.hurt.connect(
		func(hitbox):
			print(name, ": Ow! Fuck that hurt")
	)
	
