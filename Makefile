default: all

VER_FLAGS = --cc -x-assign 0 -sv --Wall --Wno-fatal --trace

SRC = uart_tx.v\
	  uart_rx.v \
	  uart_core.v

msim-all:
	rm -rf work
	vlib work
	vlog +incdir+$(LIBDIR) $(SRC) uart_tb.sv

iver-all:
	rm a.out
	iverilog $(SRC) uart_tb.sv

ver-all:
	rm -rf ./obj_dir
	rm -rf logs
	verilator $(VER_FLAGS) $(SRC) --exe test.cpp --top-module uart_core --prefix uart_core

msim-test:
	vsim uart_tb -do wave.do

test: msim-test

all: msim-all
