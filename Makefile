default: all

VER_FLAGS = --cc -x-assign 0 -sv --Wall --Wno-fatal --trace

VER_PREFIX = uart_core
VER_TOP    = $(VER_PREFIX)

SRC = uart_tx.v\
	  uart_rx.v \
	  uart_core.v

msim-build:
	rm -rf work
	vlib work
	vlog +incdir+$(LIBDIR) $(SRC) uart_tb.sv

iver-build:
	rm a.out
	iverilog $(SRC) uart_tb.sv

ver-build:
	rm -rf ./obj_dir
	rm -rf logs
	verilator $(VER_FLAGS) $(SRC) --exe test.cpp --top-module $(VER_TOP) --prefix $(VER_PREFIX)
	make -j -C obj_dir -f $(VER_PREFIX).mk $(TOP)

msim-test: msim-build
	vsim uart_tb -do wave.do

ver-test: ver-build
	./obj_dir/$(VER_PREFIX)


test: ver-test

all: 
