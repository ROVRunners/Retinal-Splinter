class_name Thruster
extends PWMMicroModule

## Given an input of -1.0 to 1.0, this represents the typical output of the thruster in Newtons.
@export var thrust_curve: Curve
## The thrust curve with axes swapped for thrust calculations.
var inverted_thrust_curve: Curve
## Toggle if the output of the thruster should be reversed due to it being wired backwards or similar
@export var reversed: bool = false
## Position of the center of the thruster relative to the center of the ROV.
@export var position: Vector3
## Vector of thrust applied to the ROV where X = Forwards, Y= Right, and Z = Up
@export var thrust_vector: Vector3
## Efficiency value of the thruster compared to its rated thrust curve.
@export_range(0, 1, .001) var efficiency: float = 1.0
