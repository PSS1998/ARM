module ID_Stage_Reg(
  input clk, rst, flush,
  input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,
  input B_IN, S_IN,
  input[3:0] EXE_CMD_IN, src1, src2,
  input[31:0] PC_in,
  input[31:0] Val_Rn_IN, Val_Rm_IN,
  input imm_IN,
  input[11:0] Shift_operand_IN,
  input[23:0] Signed_imm_24_IN,
  input[3:0] Dest_IN,
  input[3:0] SR_In,

  output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S,
  output reg[3:0] EXE_CMD,
  output reg[31:0] PC,
  output reg[31:0] Val_Rm, Val_Rn,
  output reg imm,
  output reg[11:0] Shift_operand,
  output reg[23:0] Signed_imm_24,
  output reg[3:0] Dest,
  output reg[3:0] SR, ID_reg_out_src1, ID_reg_out_src2
);

  always@(posedge clk, posedge rst) begin
    if(rst) begin
      PC <= 0; Dest <= 0; Signed_imm_24 <= 0; Shift_operand <= 0; imm <= 0; Val_Rm <= 0; Val_Rn <= 0;
      EXE_CMD <= 0; WB_EN <=0; MEM_R_EN <= 0; MEM_W_EN <= 0; B <= 0; S <= 0; SR <= 0;
      ID_reg_out_src1 <= 0; ID_reg_out_src2 <= 0;
    end
	  else if (flush) begin
		  PC <= 0; Dest <= 0; Signed_imm_24 <= 0; Shift_operand <= 0; imm <= 0; Val_Rm <= 0; Val_Rn <= 0;
      EXE_CMD <= 0; WB_EN <=0; MEM_R_EN <= 0; MEM_W_EN <= 0; B <= 0; S <= 0; SR <= 0;
      ID_reg_out_src1 <= 0; ID_reg_out_src2 <= 0;
	  end
    else begin
      PC <= PC_in; Dest <= Dest_IN; Signed_imm_24 <= Signed_imm_24_IN; Shift_operand <= Shift_operand_IN; imm <= imm_IN; Val_Rm <= Val_Rm_IN; Val_Rn <= Val_Rn_IN;
      EXE_CMD <= EXE_CMD_IN; WB_EN <=WB_EN_IN; MEM_R_EN <= MEM_R_EN_IN; MEM_W_EN <= MEM_W_EN_IN; B <= B_IN; S <= S_IN; SR <= SR_In;
      ID_reg_out_src1 <= src1; ID_reg_out_src2 <= src2;
    end
  end

endmodule