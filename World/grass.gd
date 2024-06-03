extends Node2D

func create_grass_effect():	
	const GRASS_EFFECT = preload("res://Effects/grass_effect.tscn")
	var grassEffect = GRASS_EFFECT.instantiate()
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("attack"):
		#
		#
		#queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	create_grass_effect()
	queue_free()
