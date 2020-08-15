module WB_Stage(
  input[31:0] ALU_Res, MEM_Res,
  input MEM_R_EN,
  output[31:0] out
);

  assign out = MEM_R_EN ? MEM_Res : ALU_Res;

endmodule