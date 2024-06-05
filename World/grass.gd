extends Node2D

const GRASS_EFFECT = preload("res://Effects/grass_effect.tscn")

func create_grass_effect():	
	
	var grassEffect = GRASS_EFFECT.instantiate()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("attack"):
		#
		#
		#queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	create_grass_effect()
	queue_free()
