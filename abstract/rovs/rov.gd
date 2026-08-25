class_name ROV
extends Node

# ROV Stats

## The position of the center of mass relative to a given reference point on the ROV.
## The reference point must be used for all relative positions going forward. It is recommended
## to be in the physical center, front, or rear of the ROV for ease of reference.
@export var center_of_mass: Vector3
## The position of the average buoyant center of the ROV relative to the reference point.
## (If you take the median X, Y, and Z positions of all volume on the ROV, where is that point?) 
@export var center_of_buoyancy: Vector3
## The position of the average drag center of the ROV relative to the reference point.
## (If you could hold the ROV by a single point at which it doesn't rotate when faced by currents in
## any cardinal direction, where would that point be?)
@export var center_of_drag: Vector3

## Mass of the ROV as a whole in kg.
@export var mass: float
## Buoyant force of the ROV as a whole in kg.
@export var buoyancy: float
## Moment of inertia of the ROV as a whole where X = roll, Y = pitch, and Z = yaw.
@export var moment_of_inertia: Vector3

# Mission Stats

var global_position: Vector3
var global_velocity: Vector3
var relative_velocity: Vector3
## The ROV's orientation where X = roll to the left, Y = pitch nose up, and Z = yaw left.
var rotation: Vector3
## Rate of change of the ROV's orientation where X = roll to the left, Y = pitch nose up, and Z = yaw left.
var rotational_velocity: Vector3

var mission_end_time_seconds: float = 0.0
var mission_start_time_seconds: float = 0.0

# ROV Link

@export var command_breakout: CommandBreakout

# Command Mixer

@export var command_mixer: CommandMixer

# Signals

	# Setup
	
	# Initialization
## A signal to all connected modules to send their GUI elements to the HUD.
signal initialize_runtime_gui
## A signal to the comms and vidcomms to tell them to start trying to connect to the ROV.
signal connect_comms
## A signal to all modules to perform one-time startup procedures like setting up busses or calibrating thrusters/sensors.
## All modules should stay in testing mode
signal enter_testing

signal begin_mission
	
	# Runtime
signal send_heartbeat
signal loop_modules(delta: float)
signal controllers_update
#signal mix_commands


# External Functions


# TODO: Implement
func add_gui_elements(icon, positional, settings, hud) -> void:
	pass


# Internal Functions

func _ready() -> void:
	#get_tree().call_group(group_names[Groups.MIXERS], "mix_inputs")
	pass


func enter_setup() -> void:
	# Tell all modules to set up their internal variables and possibly return UIs
	# for user settings changing like determining position and vector of thrusters.
	pass


func initialize_rov() -> void:
	command_breakout.connect_to_rov()
	

#func begin_mission() -> void:
	## Tell all modules to initialize their ROV counterparts.
	## Tell the comm protocal to send the command queue.
	#exit_testing.emit()


func _process(_delta: float) -> void:
	send_heartbeat.emit()
	loop_modules.emit(_delta)
	controllers_update.emit()
	command_mixer.mix_inputs()
	
