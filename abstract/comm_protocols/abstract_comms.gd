@abstract
class_name AbstractComms
extends Node


## Command ID list
enum CmdIDList {
	# Internal
	HEARTBEAT = 0,  ## [CmdID]
	
	# Pins
	SET_PIN = 1,  ## [CmdID] [Pin#] [Mode] 2b[Value] 4b[Frequency]
	SHUTDOWN_PINS,  ## [CmdID]
	
	# I2C
	CREATE_I2C_BUS,  ## [CmdID] [BusID] [DataPin#] [ClkPin#] 4b[Baudrate]
	WRITE_I2C_BUS,  ## [CmdID] [BusID] [Address] [X#OfBytes] Xb[Bytes]
	
	# SPI
	CREATE_SPI_BUS,  ## [CmdID] [BusID] [MISOPin#] [MOSIPin#] [ClkPin#]
	XFER_SPI_BUS,  ## [CmdID] [BusID] [CSPin#] 4b[Baudrate] [SPIMode] [X#BytesPerWord] [usecWordDelay] [Y#OfWords] X*Yb[words]  -- SPIMode consists of the bits [1xClkPolarity, 1xClkPhase, 1xCSHigh, 1xNoCS, 1xLSBFirst, 1xThreewire, 1xRead0, 1xLoopBack]
	XFER_UNTIL_SPI_BUS,  ## [CmdID] [BusID] [CSPin#] 4b[Baudrate] [SPIMode] [X#BitsPerWord] [usecWordDelay] [Y#OfWords] (X/8)*Yb[words] [usecPollDelay] (X/8)b[ResponseWord]
	
	# Serial
	CREATE_SERIAL_UART_BUS,  ## [CmdID] [BusID] 4b[Baudrate] -- NOTE: Bus 0 may be used by comm protocols.
	CREATE_SERIAL_SOFTWARE_UART_BUS,  ## [CmdID] [BusID] [TXPin#] [RXPin#] 4b[Baudrate] -- NOTE: Bus IDs 0-3 are reserved for built-in UART as above
	CREATE_SERIAL_USB_BUS,  ## [CmdID] [BusID] 4b[Baudrate] [X#AddrBytes] Xb[Addr]
	WRITE_SERIAL_BUS,  ## [CmdID] [BusID] [X#OfBytes] Xb[Bytes]
	READ_BYTES_SERIAL_BUS,  ## [CmdID] [BusID] [X#OfBytes]
	READ_ALL_SERIAL_BUS,  ## [CmdID] [BusID]
	READ_UNTIL_SERIAL_BUS,  ## [CmdID] [BusID] [EndByte]
	
	# TODO: Figure out how a CAN bus works.
	CREATE_CAN_BUS,  ## [CmdID] [BusID] [TXPin#] [RXPin#] 4b[Baudrate]
	USE_CAN_BUS,  ## [CmdID] [BusID] [TXPin#] [RXPin#] [Baudrate]
	
	# TODO: Figure out one-wire
	
	# TODO: Add camera stream stuff.
	
	# TODO: Add arbirtary console command stuff.
}
