module uart_core
    #(
        parameter BIT_CLK = 87
    )
    (
        input        clk,
        input        reset,
        input        cts, // from rts
        input [7:0]  txdata, // from host 
        input        rxd, // from txd

        output       rts, // to cts
        output       txd, // to rxd
        output [7:0] rxdata // to host

    );
    uart_tx #(.BIT_CLK(BIT_CLK)) tx_u
    (
        .clk   (clk),
        .reset (reset),
        .cts   (cts),
        .txdata(txdata),
        .txd   (txd)
    );

    uart_rx #(.BIT_CLK(BIT_CLK)) rx_u
    (
        .clk   (clk),
        .reset (reset),
        .rts   (rts),
        .rxdata(rxdata),
        .rxd   (rxd)
    );
endmodule
