module uart_rx
    #(
        parameter BIT_CLK = 87
    )
    (
        input        clk,
        input        reset,
        output       rts,
        output [7:0] rxdata,
        input        rxd
    );
    localparam IDLE  = 0,
               START = 1,
               DATA  = 2,
               STOP  = 3,
               CLEAN = 4;

    reg [2:0] state   = CLEAN;
    reg       flow_en = 0;
    reg [7:0] data    = 0;
    reg [7:0] count   = 0;
    reg [2:0] index   = 0;

    // state
    always @(posedge clk)
    begin
        if(reset)
        begin
            state <= CLEAN;
        end
        else
        begin
            case (state)
            IDLE:
                begin
                    if(rxd == 0)
                        state <= START;
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
    end

    // read data
    always @(posedge clk)
    begin
        if(reset)
        begin
            data  <= 0;
        end
        else
        begin
            if(state == DATA && count == 0)
            begin
                data[index] <= rxd;
            end
        end
    end
   
    // clock divider count
    always @(posedge clk)
    begin
        if(reset)
        begin
            count  <= 0;
        end
        else
        begin
            if(state == CLEAN)
            begin
                count <= 0;
            end
            else if(state != IDLE)
            begin
                if(count == BIT_CLK-1)
                    count <= 0;
                else
                    count <= count + 1;
            end
        end
    end
   
    // count received serial data
    always @(posedge clk)
    begin
        if(reset)
        begin
            index  <= 0;
        end
        else
        begin
            if (state == DATA)
            begin
                if(count == BIT_CLK-1)
                begin
                    index <= index + 1;
                end
            end
        end
    end

     // flow control
    always @(posedge clk)
    begin
        if(reset)
        begin
            flow_en <= 0;
        end
        else
        begin
            if(state == IDLE)
            begin
                flow_en <= 1;
            end
        end
    end

    assign rts    = flow_en;
    assign rxdata = data;

endmodule
