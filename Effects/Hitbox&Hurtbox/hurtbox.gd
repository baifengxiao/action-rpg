extends Area2D

@export var show_hit:bool = true

const HIT_EFFECT = preload("res://Effects/hit_effect.tscn")

func _on_area_entered(area: Area2D) -> void:
	if show_hit:		
		var effect = HIT_EFFECT.instantiate()
		
		#不使用get_parent().add_child()实例化，因为parent会被free（）
		var main = get_tree().current_scene
		
		main.add_child(effect)
		effect.global_position = global_position
