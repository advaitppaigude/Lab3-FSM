module lfsr_7 (
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [6:0] data_out
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            data_out <= 4'd1;
        end
        else if (en) begin
            // primitive polynomial is 1 + X**3 + X**7
            data_out <= {data_out[5:0], data_out[6] ^ data_out[2]};
        end
    end

endmodule
