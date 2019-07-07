module uart_tx
    #(
        parameter BIT_CLK = 87
    )
    (
        input       clk,
        input       reset,
        input       cts,
        input [7:0] txdata,
        output      txd
    );
    localparam IDLE  = 0,
               START = 1,
               DATA  = 2,
               STOP  = 3,
               CLEAN = 4;

    reg [2:0] state = CLEAN;
    reg       tx    = 1;
    reg [7:0] data  = 0;
    reg [7:0] count = 0;
    reg [2:0] index = 0;

    // state
    always @(posedge clk)
    begin
        case (state)
            IDLE:
                begin
                    if (cts)
                    begin
                        state <= START;
                    end
                end
            START:
                begin
                    if(count == BIT_CLK-1)
                        state <= DATA;
                end
            DATA:
                begin
                    if (index == 7 && count == 7)
                        state <= STOP;
                end
            STOP:
                begin
                    if(count == BIT_CLK-1)
                        state <= CLEAN;
                end
            CLEAN:
                begin
                    state <= IDLE;
                end
            default:
                begin
                    state <= CLEAN;
                end

        endcase
    end

    // load data to TX buffer
    always @(posedge clk)
    begin
        if (state  ==IDLE)
        begin
            if (cts)
                data  <= txdata;
        end
    end

    // send data to TX line
    always @(posedge clk)
    begin
        case (state)
            START:
                begin
                    tx <= 0;
                    if(count == BIT_CLK-1)
                    begin
                        count <= 0;
                    end
                    else
                        count <= count + 1;
                end
            DATA:
                begin
                    tx    <= data[index];
                    if(count == BIT_CLK-1)
                    begin
                        count <= 0;
                        index <= index + 1;
                    end
                    else
                        count <= count + 1;
                end
            STOP:
                begin
                    tx    <= 1;
                    if(count == BIT_CLK-1)
                        count <= 0;
                    else
                        count <= count + 1;
                end
            CLEAN:
                begin
                    tx    <= 1;
                    count <= 0;
                    index <= 0;
                end
        endcase
    end
    assign txd = tx;
endmodule
