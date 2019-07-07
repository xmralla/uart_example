module uart_tb;
    parameter BIT_CLK = 8;

    reg clk = 0;

    wire control1;
    wire control2;

    wire serial1;
    wire serial2;


    reg[7:0] txdata1 = 0;
    reg[7:0] txdata2 = 0;


    wire[7:0] rxdata1;
    wire[7:0] rxdata2;

    uart_core #(.BIT_CLK(BIT_CLK)) u1
    (
        .clk   (clk),
        .cts   (control1),
        .rts   (control2),
        .rxdata(rxdata1),
        .txdata(txdata1),
        .txd   (serial1),
        .rxd   (serial2)
    );

    uart_core #(.BIT_CLK(BIT_CLK)) u2
    (
        .clk   (clk),
        .cts   (control2),
        .rts   (control1),
        .rxdata(rxdata2),
        .txdata(txdata2),
        .rxd   (serial1),
        .txd   (serial2)
    );
reg [7:0] a;
reg [7:0] b;

initial
  a = 0;

initial
  b = a;

initial
  begin
    #1;
    $display("Value a=%d Value of b=%d",a,b);
end    

    initial
    begin
        #(BIT_CLK);
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
endmodule
