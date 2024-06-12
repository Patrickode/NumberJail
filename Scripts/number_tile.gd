@tool
extends Node2D

signal valueChanged

@export var baseValue: int :
	set(value):
		baseValue = value % 10 if value > -1 else 9;
		if (Engine.is_editor_hint()): 
			UpdateNumberGraphics()
			notify_property_list_changed()
		valueChanged.emit()

@export var label : Label
@export var border : Panel

func _ready() -> void:
	UpdateNumberGraphics();

func UpdateNumberGraphics() -> void:
	# If the label already matches the current value we don't need to do the following.
	if label and int(label.text) == baseValue: return
	
	if label:
		label.text = str(baseValue)
		label.add_theme_color_override("font_color", Configuration.numberColors[baseValue])
	else:
		print_rich("[color=yellow]WARNING: No label assigned. Did you forget to set one in the inspector?")
		return
		
	if border:
		# To access the border color we need to get the style thing it's a part of; the name "panel" as listed in the docs is not a property, it's this name!
		var style := border.get_theme_stylebox("panel") as StyleBoxFlat
		style.border_color = Configuration.numberColors[baseValue]
	else:
		print_rich("[color=yellow]WARNING: No border assigned. Did you forget to set one in the inspector?")
		return
