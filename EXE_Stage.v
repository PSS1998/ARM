module EXE_Stage(
  input clk,
  input[3:0] EXE_CMD,
  input MEM_R_EN, MEM_W_EN,
  input[31:0] PC, Val_Rn, Val_Rm,
  input imm,
  input[11:0] Shift_operand,
  input[23:0] Signed_imm_24,
  input[3:0] SR,
  input[31:0] ALU_result_reg, WB_WB_DEST,
  input[1:0] sel_src1, sel_src2,
  output[31:0] ALU_result, Br_addr, EXE_out_Val_Rm,
  output[3:0] status
);

  wire[31:0] Val2GenerateOut, Val2GenerateIn, AluIn1;
  wire[31:0] Signed_imm_24_Sign_Extension;

  assign Signed_imm_24_Sign_Extension = Signed_imm_24[23] == 1'b1 ? {8'b11111111, Signed_imm_24} : {8'b0, Signed_imm_24};
  assign Br_addr = PC + (Signed_imm_24_Sign_Extension);

  // mux before ALU input 1 and 2
  assign AluIn1 = sel_src1 == 2'd0 ? Val_Rn : sel_src1 == 2'd1 ? ALU_result_reg 
                  : sel_src1 == 2'd2 ? WB_WB_DEST : 32'bx;
  assign Val2GenerateIn = sel_src2 == 2'd0 ? Val_Rm : sel_src2 == 2'd1 ? ALU_result_reg 
                  : sel_src2 == 2'd2 ? WB_WB_DEST : 32'bx;
                  
  assign EXE_out_Val_Rm = Val2GenerateIn;
  

  ALU alu(.Val1(AluIn1), .Val2(Val2GenerateOut), .EXE_CMD(EXE_CMD), .C_in(SR[1]), .Status_Bits(status), .ALU_Res(ALU_result));

  Val2Generate v2g(.Mem_RW(MEM_R_EN | MEM_W_EN), .Val_Rm(Val2GenerateIn),
                    .imm(imm), .Shift_operand(Shift_operand), .out(Val2GenerateOut));
                    
  
endmodule