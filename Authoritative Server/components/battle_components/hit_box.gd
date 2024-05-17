extends Area2D
class_name HitBoxComponent

@export var damage = 1.0

signal hit_hurtbox(hurtbox)

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_hurtbox_entered)


func _on_hurtbox_entered(hurtbox: HurtBoxComponent):
	if not hurtbox is HurtBoxComponent: return
	
	if hurtbox.is_invincible: return
	
	hit_hurtbox.emit(hurtbox)

	hurtbox.hurt.emit(self)
