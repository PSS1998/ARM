module StatusRegister (
    input clk, rst, S, 
    input [3:0] Status_Bits,
    output reg [3:0] Status_Reg
);

  always @(negedge clk, posedge rst) begin
      if (rst) begin
          Status_Reg <= 4'b0;
      end else if(S) begin
          Status_Reg <= Status_Bits;
     	end
  end
    
endmodule


