class_name CmdModule
extends Node

@export var board_type: String
@export var compatible_cmds: Array[AbstractComms.CmdIDList]
@export var compatible_comms: Array[AbstractComms]

var command_queue: Array[GPIOPin]

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
