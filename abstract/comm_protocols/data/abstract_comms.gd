@abstract
class_name AbstractComms
extends Node


## Buffer of all commands to be sent to the command breakout on the ROV.
var command_buffer: Array[Command]
## Buffer of all packets received from the command breakout on the ROV.
var data_packet_buffer: Array[DataPacket]


## List of all commands in the current spec which a command breakout is designed to handle.
## A breakout my not be able to act on all of the following commands, but it will recognize them.
enum CmdIDList {
	# Internal
	HEARTBEAT = 0,  ## 4b[MsgID] [CmdID]
	
	# Pins
	SET_PIN = 10,  ## 4b[MsgID] [CmdID] [Pin#] [Mode] 2b[Value] 4b[Frequency]
	READ_PIN = 11,  ## 4b[MsgID] [CmdID] [Pin#] [Mode]
	SHUTDOWN_PIN = 12,  ## 4b[MsgID] [CmdID] [Pin#]
	SHUTDOWN_PINS = 13,  ## 4b[MsgID] [CmdID]
	
	# I2C
	CREATE_I2C_BUS = 20,  ## 4b[MsgID] [CmdID] [BusID] [DataPin#] [ClkPin#] 4b[Baudrate]
	WRITE_I2C_BUS = 21,  ## 4b[MsgID] [CmdID] [BusID] [Address] [X#OfBytes] Xb[Bytes]
	READ_I2C_BUS = 22,  ## 4b[MsgID] [CmdID] [BusID] [Address] [X#OfBytes]
	READ_UNTIL_I2C_BUS = 23,  ## 4b[MsgID] [CmdID] [BusID] [Address] [X#OfBytes] Xb[EndBytes]
	
	# SPI
	CREATE_SPI_BUS = 30,  ## 4b[MsgID] [CmdID] [BusID] [MISOPin#] [MOSIPin#] [ClkPin#]
	XFER_SPI_BUS = 31,  ## 4b[MsgID] [CmdID] [BusID] [CSPin#] 4b[Baudrate] [SPIMode] [X#BytesPerWord] [usecWordDelay] [Y#OfWords] X*Yb[words]  -- SPIMode consists of the bits [1xClkPolarity, 1xClkPhase, 1xCSHigh, 1xNoCS, 1xLSBFirst, 1xThreewire, 1xRead0, 1xLoopBack]
	XFER_UNTIL_SPI_BUS = 32,  ## 4b[MsgID] [CmdID] [BusID] [CSPin#] 4b[Baudrate] [SPIMode] [X#BitsPerWord] [usecWordDelay] [Y#OfWords] (X/8)*Yb[words] [usecPollDelay] (X/8)b[ResponseWord]
	
	# Serial
	CREATE_SERIAL_UART_BUS = 40,  ## 4b[MsgID] [CmdID] [BusID] 4b[Baudrate] -- NOTE: Bus 0 may be used by comm protocols.
	CREATE_SERIAL_SOFTWARE_UART_BUS = 41,  ## 4b[MsgID] [CmdID] [BusID] [TXPin#] [RXPin#] 4b[Baudrate] -- NOTE: Bus IDs 0-3 are reserved for built-in UART as above
	CREATE_SERIAL_USB_BUS = 42,  ## 4b[MsgID] [CmdID] [BusID] 4b[Baudrate] [X#AddrBytes] Xb[Addr]
	WRITE_SERIAL_BUS = 43,  ## 4b[MsgID] [CmdID] [BusID] [X#OfBytes] Xb[Bytes]
	READ_BYTES_SERIAL_BUS = 44,  ## 4b[MsgID] [CmdID] [BusID] [X#OfBytes]
	READ_ALL_SERIAL_BUS = 45,  ## 4b[MsgID] [CmdID] [BusID]
	READ_UNTIL_SERIAL_BUS = 46,  ## 4b[MsgID] [CmdID] [BusID] [EndByte]
	
	# TODO: Figure out how a CAN bus works.
	CREATE_CAN_BUS = 50,  ## 4b[MsgID] [CmdID] [BusID] [TXPin#] [RXPin#] 4b[Baudrate]
	USE_CAN_BUS = 51,  ## 4b[MsgID] [CmdID] [BusID] [TXPin#] [RXPin#] [Baudrate]
	
	# TODO: Figure out one-wire
	# 60s
	
	# TODO: Add camera stream stuff.
	# 70s
	
	# TODO: Add arbirtary console command stuff.
	# 80s
}
