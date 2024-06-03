extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		
		#引用摧毁特效
		const GRASS_EFFECT = preload("res://Effects/grass_effect.tscn")
		#实例化
		var grassEffect = GRASS_EFFECT.instantiate()
		
		#用代码实例化它，要求它必须是一个节点的子节点，这里是world节点的子节点
		var world = get_tree().current_scene
		world.add_child(grassEffect)
		
		grassEffect.global_position = global_position
		queue_free()
