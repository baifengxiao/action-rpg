extends Control

var hearts = 4:set = set_hearts
var max_hearts = 4:set = set_max_hearts

@onready var hert_ui_empty: TextureRect = $HertUIEmpty
@onready var hert_ui_full: TextureRect = $HertUIFull


#@onready var label = $Label

#检查hearts
func set_hearts(value):
	hearts = clamp(value,0,max_hearts)
	if hert_ui_full != null:
		#15根据材质大小来的
		hert_ui_full.size.x = hearts * 15
	#if label != null:
		#label.text = "HP = " +str(hearts)
	
func set_max_hearts(value):
	max_hearts = max(value,1)
	self.hearts = min(hearts,max_hearts)
	if hert_ui_empty != null:
		hert_ui_empty.size.x = max_hearts * 15

func _ready() -> void:
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed",Callable(self,"set_hearts"))
	PlayerStats.connect("max_health_changed",Callable(self,"set_max_hearts"))
