@icon("uid://du0r7svwmv51l")
@abstract
class_name AbstractModule
extends Node


@export_category("Module Base")
## The name of the type of module which can be instanced multiple times (e.g.
## "Blue Robotics T200 Thruster".
@export var base_name: String
@export var version_number: String = "1.0.0"
@export_category("Instance ")
## The name of the specific instance of the module
@export var instance_name: String
@export var enabled: bool = true


# TODO: Make a function for receiving the 'check for missing requirements' command from the ROV.


# TODO: Make a function for receiving the 'initialization' command from the ROV.


# TODO: Make a function for receiving the 'loop' command from the ROV.


# TODO: Make a generalized function for receiving commands from controllers.
#func send_command(cmd: AbstractComms.CmdIDList, args: PackedByteArray) -> void:
	#var command: Command = Command.new(cmd, args)
	
