default: all

VER_FLAGS = --cc -x-assign 0 -sv --Wall --Wno-fatal --trace

VER_PREFIX = uart_core
VER_TOP    = $(VER_PREFIX)

SRC = uart_tx.v\
	  uart_rx.v \
	  uart_core.v

msim-clean:
	if [ -d work ]; then  rm -rf work; fi
msim-build: msim-clean
	vlib work
	vlog +incdir+$(LIBDIR) $(SRC) uart_tb.sv

iver-clean:
	if [ -f $(VER_TOP) ]; then  rm $(VER_TOP); fi
iver-build: iver-clean
	iverilog $(SRC) uart_tb.sv -o $(VER_TOP)

ver-clean:
	if [ -d obj_dir ]; then rm -rf obj_dir; fi
	if [ -d logs ]; then rm -rf logs; fi
ver-build: ver-clean
	verilator $(VER_FLAGS) $(SRC) --exe test.cpp --top-module $(VER_TOP) --prefix $(VER_PREFIX)
	make -j -C obj_dir -f $(VER_PREFIX).mk $(TOP)

msim-test: msim-build
	vsim uart_tb -do wave.do

ver-test: ver-build
	./obj_dir/$(VER_PREFIX)


test: ver-test

all: ver-test
