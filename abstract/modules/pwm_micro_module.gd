@abstract
class_name PWMMicroModule
extends AbstractModule

@export var pin: GPIOPin

var _signal_upper: int = 2000
var _signal_lower: int = 1000
@export var microseconds_default: int = int(_signal_upper + _signal_lower) / 2
var _microseconds: int = microseconds_default

@export var signal_upper_bound: int:
	get:
		return _signal_upper
	set (val):
		_signal_upper = val
		_microseconds = _microseconds
@export var signal_lower_bound: int:
	get:
		return _signal_lower
	set (val):
		_signal_lower = val
		_microseconds = _microseconds

@export var microseconds: int:
	get:
		return _microseconds
	set(val):
		_microseconds = clampi(val, _signal_lower, _signal_upper)
