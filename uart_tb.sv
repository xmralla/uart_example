module uart_tb;
    parameter BIT_CLK = 8;

    reg[7:0] txdata1 = 0;
    reg clk = 0;
    reg cts = 0;
    wire control1;


    uart_core #(.BIT_CLK(BIT_CLK)) u1
    (
        .clk   (clk),
        .cts   (control1),
        .txdata(txdata1),
        .txd   (txd)
    );

    initial
    begin
        #(BIT_CLK);
        cts <= !cts;
        txdata1 <= 'h77;
        #(150*BIT_CLK);
        txdata1 <= 'haa;
        #(150*BIT_CLK);
        txdata1 <= 'h33;
    end
    
    always
    begin
        #(BIT_CLK)
        clk <= !clk;
    end
    assign control1 = cts;
endmodule
