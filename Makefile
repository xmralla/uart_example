default: all

SRC = uart_tx.v\
	  uart_rx.v \
	  uart_core.v

msim-all:
	rm -rf work
	vlib work
	vlog +incdir+$(LIBDIR) $(SRC) uart_tb.sv

msim-test:
	vsim uart_tb -do wave.do

test: msim-test

all: msim-all
