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
@export var moment: Vector3

# Mission Stats

var global_position: Vector3
var global_velocity: Vector3
var relative_velocity: Vector3
var rotation: Vector3
var rotational_velocity: Vector3

var mission_time_seconds: float = 0.0
var mission_start_time_seconds: float = 0.0

# Sensor Data

@export var comm_protocol: AbstractComms
var data_packets: Array[DataPacket]

# Controller Outputs

## An un-normalized vector added to by all of the Controllers representing how the Controllers which
## care about global position want the ROV to move.
var desired_global_position: Vector3
## An un-normalized vector added to by all of the Controllers representing how the Controllers which
## care about global position want the ROV to move.
var desired_global_velocity: Vector3
## An un-normalized vector added to by all of the Controllers representing how the Controllers which
## care about relative motion want the ROV to move.
var desired_relative_velocity: Vector3
## An un-normalized vector added to by all of the Controllers representing how the Controllers which
## care about rotational motion want the ROV to move.
var desired_rotational_velocity: Vector3

# Command Mixers

@export var global_mixer: CommandMixer
@export var relative_mixer: CommandMixer

# Command queue

var command_queue: Array[Command]


func enter_testing() -> void:
	# Tell all modules to initialize.
	# Tell the comm protocal to send the command queue.
	
	pass
