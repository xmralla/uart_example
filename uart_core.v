module uart_core
    #(
        parameter BIT_CLK = 87
    )
    (
        input        clk,
        input        cts,
        input [7:0]  txdata,
        input        rxd,
        output       rts,
        output       txd,
        output [7:0] rxdata

    );
    uart_tx #(.BIT_CLK(BIT_CLK)) tx
    (
        .clk   (clk),
        .cts   (cts),
        .txdata(txdata),
        .txd   (txd)
    );
endmodule
