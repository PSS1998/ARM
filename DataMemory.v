module DataMemory (
    input clk, MEM_R_EN, MEM_W_EN,
    input [31:0] VAL_Rm, ALU_Res,
    output [31:0] value 
);

reg [31:0] memory [0:63];


assign value = MEM_R_EN ? memory[(((ALU_Res - 32'd1024) >> 2))]: 32'bx;

always @(posedge clk) begin
    if (MEM_W_EN) begin
        memory[(ALU_Res - 32'd1024)>>2] = VAL_Rm; 
    end
end
    
endmodule
