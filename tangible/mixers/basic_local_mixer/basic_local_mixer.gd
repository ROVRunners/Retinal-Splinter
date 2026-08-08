extends CommandMixer

var thrusters: Array[Thruster] = []


func mix_inputs() -> void:
	_filter_modules()
	
	# Build the desired 6x1 Direction Matrix.
	var direction_matrix: Float32Matrix = _build_vector_matrix()
	
	# Build the nx6 unit thrust matrix.
	var unit_thrust_matrix: Float32Matrix = _build_unit_thrust_matrix()
	
	# Get the direction of each thruster using the [unit_thrust_matrix].
	var unit_output_matrix: Float32Matrix = _multiply_matricies(unit_thrust_matrix, direction_matrix)
	
	# Get and apply the directional values of the thrusters' outputs.
	var true_thrust_matrix: Float32Matrix = _build_true_thrust_matrix(unit_thrust_matrix, unit_output_matrix)
	
	# Use the true values to get the final output matrix.
	var final_output_matrix: Float32Matrix = _multiply_matricies(true_thrust_matrix, direction_matrix)
	
	# Normalize the values to the thrusters max values
	var normalized_output_array: Array[float] = _normalize_output(final_output_matrix)
	
	# Apply the values
	_command_thrusters(normalized_output_array)


func _filter_modules() -> void:
	for module in mobility_modules.keys():
		if mobility_modules[module] == ModuleTypes.PWM_MICRO_THRUSTER:
			thrusters.append(module)


## Set up the desired movement direction matrix.
func _build_vector_matrix() -> Float32Matrix:
	
	var direction_matrix: Float32Matrix = Float32Matrix.new(Vector2i(6, 1))
	
	direction_matrix.data = [
		0,
		0,
		0,
		
		0,
		0,
		0,
	]
	
	for vec in vector_buffer:
		direction_matrix.data = [
			direction_matrix.data[0] + vec.pos_delta.x,
			direction_matrix.data[1] + vec.pos_delta.y,
			direction_matrix.data[2] + vec.pos_delta.z,
			
			direction_matrix.data[3] + vec.rot_delta.x,
			direction_matrix.data[4] + vec.rot_delta.y,
			direction_matrix.data[5] + vec.rot_delta.z,
		]
	
	return direction_matrix


## Update the [unit_thrust_matrix] variable.
func _build_unit_thrust_matrix() -> Float32Matrix:
	
	# Summarize the data to an array.
	
	var unit_thrust_array: Array[Array] = []
	for module in thrusters:
		unit_thrust_array.append_array([
			module.thrust_unit_vector.x,
			module.thrust_unit_vector.y,
			module.thrust_unit_vector.z,
			module.torque_vector_constant.x,
			module.torque_vector_constant.y,
			module.torque_vector_constant.z,
		])
	
	# Convert the array into the matrix.
	
	## The matrix of thruster unit vectors used to determine thrust direction.
	var unit_thrust_matrix: Float32Matrix = Float32Matrix.new(Vector2i(6, len(unit_thrust_array)))
	
	for i in range(len(unit_thrust_array)):
		for j in range(len(unit_thrust_array[i])):
			unit_thrust_matrix.data[6*i+j] = unit_thrust_array[i][j]
	
	return unit_thrust_matrix


func _multiply_matricies(thrust_matrix: Float32Matrix, direction_matrix: Float32Matrix) -> Float32Matrix:
	return thrust_matrix.mul(direction_matrix)


func _build_true_thrust_matrix(unit_thrust_matrix: Float32Matrix, unit_output_matrix: Float32Matrix) -> Float32Matrix:
	var true_thrust_matrix: Float32Matrix = Float32Matrix.new(Vector2i(unit_thrust_matrix.x, unit_thrust_matrix.y))
	true_thrust_matrix.data = unit_thrust_matrix.data.duplicate()
	
	var i: int = 0
	for module in thrusters:
		for j in range(6):
			if unit_output_matrix.data[i] >= 0:
				true_thrust_matrix.data[6*i+j] *= module.max_forward_thrust
			else:
				true_thrust_matrix.data[6*i+j] *= module.max_reverse_thrust
		i += 1
	
	return true_thrust_matrix


func _normalize_output(final_output_matrix: Float32Matrix) -> Array[float]:
	var max_divisor: float = 1.0
	
	for i in range(len(final_output_matrix.data)):
		#normalized_array.append(val)
		var thruster_max: float = 0
		if final_output_matrix.data[i] == 0:
			continue
		if final_output_matrix.data[i] > 0:
			thruster_max = thrusters[i].max_forward_thrust
		if final_output_matrix.data[i] < 0:
			thruster_max = thrusters[i].max_reverse_thrust
		
		var div: float = final_output_matrix.data[i] / thruster_max
		max_divisor = max(max_divisor, div)
	
	final_output_matrix.mul_scalar(1.0 / max_divisor)
	return final_output_matrix.data


func _command_thrusters(normalized_output_array: Array[float]) -> void:
	for i in range(len(thrusters)):
		thrusters[i].set_thrust(normalized_output_array[i])
