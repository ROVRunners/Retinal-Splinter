@icon("uid://dhjrd65fquqa3")
class_name CmdModule
extends Node

@export var compatible_cmds: Array[AbstractComms.CmdIDList]
@export var used_comms: AbstractComms

enum BoardTypes {
	ARDUINO_UNO,
	ARDUINO_NANO,
	ARDUINO_MEGA,
	ARDUINO_GIGA,
	ESP32,
	RASPBERRY_PI,
	RASPBERRY_PI_ZERO,
	RASPBERRY_PI_PICO,
}
