module IF_Stage_Reg(
  input clk, rst, freeze, flush,
  input[31:0] PC_in, Instruction_in,
  output reg[31:0] PC, Instruction
);

  always@(posedge clk, posedge rst) begin
    if(rst) begin
      PC <= 0;
      Instruction <= 0;
    end
	  else if (flush) begin
		  PC <= 0;
      Instruction <= 0;
	  end
    else begin
      if(~freeze) begin
        PC <= PC_in;
        Instruction <= Instruction_in;
      end
    end
  end

endmodule