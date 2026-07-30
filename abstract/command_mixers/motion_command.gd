class_name MotionCommand
extends Node

var pos_delta: Vector3
var rot_delta: Vector3


func _init(rel_pos: Vector3, rel_rot: Vector3) -> void:
	pos_delta = rel_pos
	rot_delta = rel_rot
