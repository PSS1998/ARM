module PC_Reg(input clk, rst, en, input[31:0] PC_in, output reg[31:0] PC_out);

    always @(posedge clk, posedge rst) begin
        if (rst) PC_out <= 32'd0;
        else begin
            if (en) PC_out <= PC_in;
        end
    end

endmodule

