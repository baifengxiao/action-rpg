#extends Node2D
extends AnimatedSprite2D
#重构，不再是子节点了
#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_finished.connect(_on_animated_finished)
	#animated_sprite_2d.
	play("Animate")


func _on_animated_finished() -> void:
	queue_free()
