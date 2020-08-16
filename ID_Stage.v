module ID_Stage(
  input clk, rst,
  input[31:0] Instruction, Result_WB,
  input writeBackEn,
  input[3:0] Dest_wb,
  input hazard,
  input[3:0] SR,
  output WB_EN, MEM_R_EN, MEM_W_EN, B, S,
  output[3:0] EXE_CMD,
  output[31:0] Val_Rn, Val_Rm,
  output imm,
  output[11:0] Shift_operand,
  output[23:0] Signed_imm_24,
  output[3:0] Dest, src1, src2,
  output Two_src
);

  wire[3:0] Rn, Rm;
  wire conditionCheck_out;
  wire[8:0] controlUnitCommands, commands;
  
  assign Rm = Instruction[3:0];
  assign Rn = Instruction[19:16];
  assign commands = hazard || ~conditionCheck_out ? 6'b0 : controlUnitCommands;
  assign WB_EN = commands[8];
  assign MEM_R_EN = commands[7];
  assign MEM_W_EN = commands[6];
  assign EXE_CMD = commands[5:2];
  assign B = commands[1];
  assign S = commands[0];
  assign src1 = Rn;
  assign src2 = MEM_W_EN ? Dest : Rm;
  assign Two_src = MEM_R_EN || ~Instruction[25];
  assign imm = Instruction[25];
  assign Shift_operand = Instruction[11:0];
  assign Signed_imm_24 = Instruction[23:0];
  assign Dest = Instruction[15:12];

  ControlUnit CU(.s(Instruction[20]), .mode(Instruction[27:26]), .opCode(Instruction[24:21]), .WB_EN(controlUnitCommands[8]), .MEM_R_EN(controlUnitCommands[7]), .MEM_W_EN(controlUnitCommands[6]), .EXE_CMD(controlUnitCommands[5:2]), .B(controlUnitCommands[1]), .S(controlUnitCommands[0]));
  ConditionCheck CC(.cond(Instruction[31:28]), .statusReg(SR), .conditionCheck_out(conditionCheck_out));
  RegisterFile RF(.clk(clk), .rst(rst), .src1(Rn), .src2(MEM_W_EN ? Dest : Rm), .Dest_wb(Dest_wb), .Result_WB(Result_WB), .writeBackEn(writeBackEn), .reg1(Val_Rn), .reg2(Val_Rm));

endmodule