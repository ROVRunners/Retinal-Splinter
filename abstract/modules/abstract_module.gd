@abstract
class_name AbstractModule
extends Node


@export var version_number: String = "1.0.0"
@export var enabled: bool = true


func send_command(cmd: AbstractComms.CmdIDList, args: PackedByteArray) -> void:
	var command: Command = Command.new(cmd, args)
	
