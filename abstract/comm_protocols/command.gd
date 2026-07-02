class_name Command
extends Node

var _command: AbstractComms.CmdIDList = AbstractComms.CmdIDList.HEARTBEAT
var _args: PackedByteArray


func _init(command: AbstractComms.CmdIDList, args: PackedByteArray) -> void:
	_command = command
	_args = args
