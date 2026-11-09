extends CanvasLayer

@onready var day_label: Label = $DayLabel

func _ready() -> void:
	update_day_label()

func update_day_label() -> void:
	day_label.text = "День " + str(Global.day)
