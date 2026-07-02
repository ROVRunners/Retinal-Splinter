@abstract
class_name CommandMixer
extends Node

@export var mobility_modules: Dictionary[AbstractModule, ModuleTypes]
@export_enum("Global", "Relative") var mixer_type: int

enum ModuleTypes {
	## Variable Velocity Control
	PWM_MICRO_THRUSTER,
	## Positional Acceleration Control
	PWM_MICRO_VBS_ACTUATOR,
	## Positional Position Control
	PWM_MICRO_LIFT_ACTUATOR,
	## Variable Velocity Control
	PWM_MICRO_CRANE_MOTOR,
	## Grounded Variable Velocity Control
	PWM_MICRO_WHEEL_MOTOR,
	
	## Toggle Velocity Control
	RELAY_THRUSTER,
	## Toggle Acceleration Control
	RELAY_VBS_ACTUATOR,
	## Grounded Toggle Position Control
	RELAY_LIFT_ACTUATOR,
	## Toggle Velocity Control
	RELAY_CRANE_MOTOR,
	## Grounded Toggle Velocity Control
	RELAY_WHEEL_MOTOR,
	
	## Positional Position Control
	STEPPER_LIFT_ACTUATOR,
	## Positional Position Control
	STEPPER_CRANE_MOTOR,
	## Positional Position Control
	STEPPER_WHEEL_MOTOR,
}

## Grabs the relevant input vectors based on its mixer type and mixes them into the devices given.
## If it's global and cannot fulfill an axis of the global vector, it does what it can and returns
## the remainder it could not fulfill, rotated based on the ROV's orientation, to the relative mixer
## to handle.
@abstract
func mix_inputs() -> Vector3
