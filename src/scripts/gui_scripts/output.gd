extends Control

export(String) var label = "Cutic energy"
export(String) var suffix = "J"

onready var name_label: Label = $HBoxContainer/Name
onready var value_label: Label = $HBoxContainer/Value

var value: float = 0.0

func _ready():
	update_translation()

func update_translation():
	name_label.text = tr(label)
	update_value_label()

func update_value_label():
	value_label.text = String("%6.3f" % value) + ' ' + tr(suffix)


func _on_world_potential_energy_changed(potential_energy):
	value = potential_energy
	update_value_label()


func _on_world_linear_velocity_changed(linear_velocity):
	value = linear_velocity
	update_value_label()


func _on_world_kinematic_energy_changed(kinematic_energy):
	value = kinematic_energy
	update_value_label()


func _on_world_height_changed(height):
	value = height
	update_value_label()


func _on_world_angle_velocity_changed(angle_velocity):
	value = angle_velocity
	update_value_label()


func _on_world_time_changed(time):
	value = time
	update_value_label()
