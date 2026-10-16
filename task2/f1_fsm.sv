module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    output  logic [7:0] data_out
);


    /*
    logic [2:0] state_num;

    always_ff @(posedge clk) begin
        if (rst) begin
            data_out  <= 8'd0;
            state_num <= 3'd0;
        end
        else if (en) begin
            if (data_out == 8'hFF) begin
                data_out  <= 8'd0;
                state_num <= 3'd0;
            end
            else begin
                data_out  <= data_out + (8'b1 << state_num);
                state_num <= state_num + 1'b1;
            end
        end
    end
    */


    /*
    always_ff(@posedge clk) begin
        if (rst) begin
            data_out <= 8'd0;
        end
        else if (en) begin
            if (data_out == 8'b11111111) begin
                data_out <= 8'd0;
            end
            else begin
                data_out <= {data_out[6:0], 1'b1};
            end
        end
    end
    */

    typedef enum [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8} state_t;
    state_t current, next;

    always_comb begin // calculating next state
        case (current)
            S0: next = S1;
            S1: next = S2;
            S2: next = S3;
            S3: next = S4;
            S4: next = S5;
            S5: next = S6;
            S6: next = S7;
            S7: next = S8;
            S8: next = S0;
            default: next = S0;
        endcase   
    end
    always_comb begin // calculating output
        case (current)
            S0: data_out = 8'b00000000;
            S1: data_out = 8'b00000001;
            S2: data_out = 8'b00000011;
            S3: data_out = 8'b00000111;
            S4: data_out = 8'b00001111;
            S5: data_out = 8'b00011111;
            S6: data_out = 8'b00111111;
            S7: data_out = 8'b01111111;
            S8: data_out = 8'b11111111;
            default: data_out = 8'd0;
        endcase
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            current <= S0;
        end
        else if (en) begin
            current <= next;
        end
    end

endmodule

