class_name GPIOPin
extends Node


## The pin number used on the ROV Command Module.
@export var pin_number: int
## The value either to be sent to the ROV Command Module or received from it,
## depending on the mode.
@export var value: int
## The rate at which to either operate the pin as it relates to its mode (e.g.
## PWM Frequency or UART Baudrate), depending on the mode.
@export var frequency: int
## What the pin is being used for.
@export var mode: GPIOType
## What the pin can be used for.
@export var compatible_mode: GPIOType
var owners: Array[abstract]

enum GPIOType {
	NONE = 0,
	
	DIGITAL_OUTPUT = 1,
	DIGITAL_INPUT = 2,
	ANALOG_OUTPUT = 3,
	ANALOG_INPUT = 4,
	
	SERVO_ANGLE = 5,
	SERVO_MICRO = 6,
	
	I2C_DATA = 7,
	I2C_CLK = 8,
	
	SPI_MOSI = 9,
	SPI_MISO = 10,
	SPI_CLK = 11,
	SPI_CS = 12,
	
	UART_TX = 13,
	UART_RX = 14,
	
	CAN_TX = 15,
	CAN_RX = 16,
	
	ONE_WIRE = 17,
}
