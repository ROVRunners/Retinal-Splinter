class_name Thruster
extends PWMMicroModule

## Given an input of -1.0 to 1.0, this represents the typical output of the thruster in Newtons.
## Maximum positive output should always be on the right and negative outpput should be on the left.
@export var thrust_curve: Curve = Curve.new()
## Toggle if the output of the thruster should be reversed due to it being wired backwards or
## high pwm values otherwise translating to reversed direction.
@export var reversed: bool = false
## Position of the center of the thruster relative to the center of the ROV measured in meters.
@export var position: Vector3
## Vector of length 1 describing the direction of thrust applied where X = Forwards, Y= Right, and Z = Up
var _thrust_unit_vector: Vector3 = Vector3(1, 0, 0)

## Vector of length 1 describing the direction of thrust applied where X = Forwards, Y= Right, and Z = Up.
## Auto-normalizes, but please don't rely on that too much...
@export var thrust_unit_vector: Vector3:
	get:
		return _thrust_unit_vector
	set(val):
		if val != Vector3.ZERO:
			_thrust_unit_vector = val.normalized()


## Efficiency value of the thruster compared to its rated thrust curve.
@export_range(0, 1, .001) var efficiency: float = 1.0

## The thrust curve with axes swapped for thrust calculations.
var inverted_thrust_curve: Curve
var max_forward_thrust: float = thrust_curve.get_point_position(-1).y
var max_reverse_thrust: float = thrust_curve.get_point_position(0).y
## Torque of the thruster on the ROV when the thruster is spinning forwards where
## X = roll to the left, Y = pitch nose up, and Z = yaw left.
var effective_forward_torque: float
## Thrust of the thruster on the ROV along the axes when the thruster is spinning forwards where
## X = Forwards, Y = Right, and Z = Up.
var effective_forward_thrust: float
## Torque of the thruster on the ROV when the thruster is spinning backwards where
## X = roll to the left, Y = pitch nose up, and Z = yaw left.
var effective_reverse_torque: float
## Thrust of the thruster on the ROV along the axes when the thruster is spinning backwards where
## X = Forwards, Y = Right, and Z = Up.
var effective_reverse_thrust: float


func _ready():
	# Set up the inverted curve.
	_invert_curve()


func _invert_curve() -> void:
	inverted_thrust_curve = Curve.new()
	
	# Flip the domains and value ranges.
	inverted_thrust_curve.set_max_domain(thrust_curve.get_max_value())
	inverted_thrust_curve.set_min_domain(thrust_curve.get_min_value())
	inverted_thrust_curve.set_max_value(thrust_curve.get_max_domain())
	inverted_thrust_curve.set_min_value(thrust_curve.get_min_domain())
	
	# Transpose points and modes.
	for i in range(thrust_curve.point_count):
		var old_pos = thrust_curve.get_point_position(i)
		inverted_thrust_curve.add_point(Vector2(old_pos.y, old_pos.x))
		inverted_thrust_curve.set_point_left_mode(i, Curve.TANGENT_LINEAR)
		inverted_thrust_curve.set_point_right_mode(i, Curve.TANGENT_LINEAR)


func _test_transposition() -> void:
	var multiplier = 30.0
	for i: float in range(thrust_curve.min_domain*multiplier, thrust_curve.max_domain*multiplier):
		var thrust_curve_sample: float = thrust_curve.sample(i/multiplier)
		#print("Sample at: \t", i/multiplier, " \t=\t", thrust_curve_sample)
		var reverse_sample: float = inverted_thrust_curve.sample(thrust_curve_sample)
		#print("Reverse sample at: \t", thrust_curve_sample, " \t=\t ", reverse_sample)
		print("Difference: ", i/multiplier - reverse_sample)


func _calc_thrust_and_torque() -> void:
	var rov = self.get_parent()
	if rov is ROV:
		var center_of_mass_rel_pos: Vector3 = position - rov.center_of_mass
		
		
		
		#effective_torque
	else:
		print("Error! Thruster recalc is impossible because thruster parent is not an ROV!")
		return
