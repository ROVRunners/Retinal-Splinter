extends CommandMixer


func mix_inputs() -> void:
	# Do mixing stuff here.
	var direction_matrix: Float32Matrix = Float32Matrix.new(Vector2i(1, 8))
	
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
	
