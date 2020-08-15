module MEM_Stage(
    input clk, rst, MEM_R_EN, MEM_W_EN,
    input [31:0] ALU_Res, VAL_Rm,
    output [31:0] MEM_Res
);

DataMemory DM(
    .clk(clk), .MEM_R_EN(MEM_R_EN), .MEM_W_EN(MEM_W_EN),
    .VAL_Rm(VAL_Rm), .ALU_Res(ALU_Res),
    .value(MEM_Res)
);    

endmodule