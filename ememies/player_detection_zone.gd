extends Area2D

var player = null

#能否看到玩家
func can_see_player():
	return player != null

#检测玩家进入

func _on_area_entered(area):
	
	
	player=area


func _on_area_exited(area):
	
	player=null
