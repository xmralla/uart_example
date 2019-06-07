SRC = uart_tx.v\
	  uart_rx.v \
	  uart_core.v
all:
	rm -rf work
	vlib work
	vlog +incdir+$(LIBDIR) $(SRC) uart_tb.sv

