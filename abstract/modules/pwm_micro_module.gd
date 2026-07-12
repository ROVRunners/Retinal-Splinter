@abstract
class_name PWMMicroModule
extends AbstractModule

@export var pin: GPIOPin

var _microseconds_upper: int = 2000
var _microseconds_lower: int = 1000
@export var microseconds_default: int = int(_microseconds_upper + _microseconds_lower) / 2
var _microseconds: int = microseconds_default

@export var microseconds_upper_bound: int:
	get:
		return _microseconds_upper
	set (val):
		_microseconds_upper = val
		_microseconds = _microseconds
@export var microseconds_lower_bound: int:
	get:
		return _microseconds_lower
	set (val):
		_microseconds_lower = val
		_microseconds = _microseconds

var microseconds: int:
	get:
		return _microseconds
	set(val):
		_microseconds = clampi(val, _microseconds_lower, _microseconds_upper)
