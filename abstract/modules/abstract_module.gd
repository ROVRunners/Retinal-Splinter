@icon("uid://du0r7svwmv51l")
@abstract
class_name ROVModule
extends Node


@export_category("Module Base")
## The name of the type of module which can be instanced multiple times (e.g.
## "Blue Robotics T200 Thruster".
@export var base_name: String
@export var version_number: String = "1.0.0"
@export_category("Instance")
## The name of the specific instance of the module
@export var instance_name: String
## Tier of execution. Higher is earlier. -1 is disabled.
@export var execution_tier: int = -1
## The ROV object to be used for signal connection.
@export var rov_object: ROV


## Check the exports to make sure everything is valid.
@abstract
func check_requirements() -> Array[String]


## Connect to the ROV's signals
@abstract
func connect_to_rov(rov: ROV) -> void


# TODO: Make a function for receiving the 'loop' command from the ROV.


# TODO: Make a generalized function for receiving commands from controllers.
#func send_command(cmd: AbstractComms.CmdIDList, args: PackedByteArray) -> void:
	#var command: Command = Command.new(cmd, args)
	
