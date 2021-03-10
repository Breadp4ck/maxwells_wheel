extends Spatial

export(float) var camera_acc = 0.5

onready var camera: Camera = $camera

var camrot_h: float = 0.0
var camrot_v: float = 0.0

var camrot_v_max: float = 45.0
var camrot_v_min: float = -45.0

var is_mouse_entered: bool = false
var is_mouse_pressed: bool = false
var scale_step: Vector3 = Vector3(0.1, 0.1, 0.1)
var size_step: float = 0.1

func _ready():
	camrot_v = -15.0 / camera_acc
	camera.size = 5.0

func _input(event) -> void:
	if is_mouse_entered:
		if Input.is_action_pressed("drag_camera") and event is InputEventMouseMotion:
			camrot_h += -event.relative.x
			camrot_v += -event.relative.y
		if event.is_action_pressed("zoom_in") and self.scale.x > 0.5:
			self.scale -= scale_step
			camera.size -= size_step
		if event.is_action_pressed("zoom_out") and self.scale.x < 3.0:
			self.scale += scale_step
			camera.size += size_step
		
		if Input.is_action_just_pressed("side_x"):
			camrot_h = 0.0
			camrot_v = 0.0
		if Input.is_action_just_pressed("side_y"):
			camrot_h = 90.0 / camera_acc
			camrot_v = 0.0
		if Input.is_action_just_pressed("side_z"):
			camrot_h = 0.0
			camrot_v = -90.0 / camera_acc
		if Input.is_action_just_pressed("side_invert"):
			camrot_h += 180.0/camera_acc
			if camrot_v/camera_acc == -90.0 or camrot_v/camera_acc == 90:
				camrot_v += 180.0/camera_acc
		
		if Input.is_action_just_pressed("orthographic_mode"):
			if camera.projection == Camera.PROJECTION_ORTHOGONAL:
				camera.projection = Camera.PROJECTION_PERSPECTIVE
			else:
				camera.projection = Camera.PROJECTION_ORTHOGONAL
				

func _physics_process(_delta):
	rotation_degrees.y = camrot_h * camera_acc
	rotation_degrees.x = camrot_v * camera_acc
