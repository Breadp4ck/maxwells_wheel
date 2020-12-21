extends Spatial

onready var wheel: KinematicBody = $wheel
onready var wire: MeshInstance = $wire
onready var pipes_v: MeshInstance = $pipes_v
onready var pipes_h: MeshInstance = $pipes_h
onready var pipes_bends: MeshInstance = $pipes_bends

var RADIUS_MAJOR: float = 0.1
var RADIUS_MINOR: float = 0.005
var MASS_MAJOR: float = 0.4
var MASS_MINOR: float = 0.05
var GRAVITY: float = 9.8
var HEIGHT: float = 1.0

# Height to set the space between the roller and the surfaces
const EXTRA_HEIGHT: float = 0.3

var linear_velocity: float
var height: float
var time: float
var time_oscillation: float
var angle_velocity: float
var angle: float
var kinematic_energy: float
var potential_energy: float
var half_life: float = 0.0 # Rise and shine, Mr. Freeman

var is_time_reversed: bool = false
var is_time_stoped: bool = false

var computing_coefficient: float = 0.0
var computeing_result: float = 0.0
var temp_computeing_result: float = 0.0
const RADIAN: float = 57.29577951308

signal values_ready(kinematic_energy, potential_energy,
		linear_velocity, angle_velocity, height, time)


func _ready() -> void:
	rebuild_construction()


func _physics_process(delta) -> void:
	if !is_time_stoped:
		if is_time_reversed:
			vibration_step(-delta)
		else:
			vibration_step(delta)


func vibration_step(delta) -> void:
	time_oscillation += delta
	time += delta
	
	computeing_result = computing_coefficient * (time_oscillation * time_oscillation)
	
	angle = computeing_result * RADIAN
	height = HEIGHT - computeing_result * RADIUS_MINOR
	
	if height <= 0:
		height = 0
		time_oscillation = -half_life
		linear_velocity = sqrt(2 * GRAVITY * HEIGHT)
		angle_velocity = sqrt(2 * GRAVITY * HEIGHT) / RADIUS_MAJOR
	elif delta != 0:
		linear_velocity = (temp_computeing_result - computeing_result) * RADIUS_MINOR / delta
		angle_velocity = (temp_computeing_result - computeing_result) / delta
	
	potential_energy = (MASS_MAJOR + MASS_MINOR) * GRAVITY * height
	kinematic_energy = (MASS_MAJOR + MASS_MINOR) * GRAVITY * HEIGHT - potential_energy
	
	temp_computeing_result = computeing_result
	
	wire.scale.y = HEIGHT + EXTRA_HEIGHT - height
	wheel.global_transform.origin.y = height + EXTRA_HEIGHT
	wheel.rotation_degrees.x = angle
	
	send_values()


func rebuild_construction() -> void:
	is_time_stoped = true
	time = 0.0	
	
	height = HEIGHT
	potential_energy = (MASS_MAJOR + MASS_MINOR) * GRAVITY * height
	kinematic_energy = 0.0
	linear_velocity = 0.0
	angle_velocity = 0.0
	temp_computeing_result = 0.0
	
	computing_coefficient = MASS_MAJOR * GRAVITY * RADIUS_MINOR / (MASS_MAJOR * (RADIUS_MAJOR * RADIUS_MAJOR + RADIUS_MINOR * RADIUS_MINOR) + MASS_MINOR * RADIUS_MINOR * RADIUS_MINOR)
	half_life = sqrt(HEIGHT / (computing_coefficient * RADIUS_MINOR))
	
	wheel.cylinder.scale.y = RADIUS_MAJOR
	wheel.cylinder.scale.z = RADIUS_MAJOR
	
	wheel.roller.scale.y = RADIUS_MINOR * 40
	wheel.roller.scale.z = RADIUS_MINOR * 40
	
	wheel.global_transform.origin.y = HEIGHT + EXTRA_HEIGHT
	wheel.rotation_degrees.x = angle
	
	wire.scale.y = EXTRA_HEIGHT
	wire.global_transform.origin.y = HEIGHT + EXTRA_HEIGHT * 2
	
	pipes_v.scale.y = HEIGHT + EXTRA_HEIGHT * 2
	pipes_h.global_transform.origin.y = HEIGHT + EXTRA_HEIGHT * 2
	pipes_bends.global_transform.origin.y = HEIGHT + EXTRA_HEIGHT * 2
	
	send_values()


func send_values():
	emit_signal("values_ready", kinematic_energy, potential_energy,
			linear_velocity, angle_velocity, height, time)
