extends Spatial

onready var camera_controller: Node = $camera_controller
onready var maxwells_wheel: Spatial = $maxwells_wheel


signal kinematic_energy_changed(kinematic_energy)
signal potential_energy_changed(potential_energy)
signal linear_velocity_changed(linear_velocity)
signal angle_velocity_changed(angle_velocity)
signal height_changed(height)
signal time_changed(time)


func _ready():
	pass

# Called when mouse entered the viewport container
# to enable camera control
func _on_viewport_container_mouse_entered() -> void:
	camera_controller.is_mouse_entered = true

# Called when mouse left the viewport container
# to disabled camera control
func _on_viewport_container_mouse_exited() -> void:
	camera_controller.is_mouse_entered = false

# Called when pressed start button
# to continue the flow of time
func _on_start_pressed() -> void:
	maxwells_wheel.is_time_reversed = false
	maxwells_wheel.is_time_stoped = false

# Called when pressed stop button
# to stop the flow of time
func _on_stop_pressed() -> void:
	maxwells_wheel.is_time_stoped = true

# Called when pressed back button
# to reverse the flow of time
func _on_back_pressed() -> void:
	maxwells_wheel.is_time_reversed = true
	maxwells_wheel.is_time_stoped = false

# Called when pressed drop button
func _on_drop_pressed() -> void:
	maxwells_wheel.time = 0.0
	maxwells_wheel.time_oscillation = 0.0
	maxwells_wheel.rebuild_construction()
	maxwells_wheel.vibration_step(0.0)
	maxwells_wheel.is_time_reversed = false
	maxwells_wheel.is_time_stoped = true


func _on_wire_length_value_changed(value):
	maxwells_wheel.HEIGHT = value
	maxwells_wheel.rebuild_construction()


func _on_radius_minor_value_changed(value):
	maxwells_wheel.RADIUS_MINOR = value
	maxwells_wheel.rebuild_construction()


func _on_radius_major_value_changed(value):
	maxwells_wheel.RADIUS_MAJOR = value
	maxwells_wheel.rebuild_construction()


func _on_mass_major_value_changed(value):
	maxwells_wheel.MASS_MAJOR = value
	maxwells_wheel.rebuild_construction()


func _on_mass_minor_value_changed(value):
	maxwells_wheel.MASS_MINOR = value
	maxwells_wheel.rebuild_construction()


func _on_maxwells_wheel_values_ready(kinematic_energy, potential_energy,
		linear_velocity, angle_velocity, height, time):
	emit_signal("kinematic_energy_changed", kinematic_energy)
	emit_signal("potential_energy_changed", potential_energy)
	emit_signal("linear_velocity_changed", linear_velocity)
	emit_signal("angle_velocity_changed", angle_velocity)
	emit_signal("height_changed", height)
	emit_signal("time_changed", time)
