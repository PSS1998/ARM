module DataMemory (
    input clk, MEM_R_EN, MEM_W_EN,
    input [31:0] VAL_Rm, ALU_Res,
    output [31:0] value 
);

reg [31:0] memory [0:63];

wire [31:0] address;

assign address = ((ALU_Res - 32'd1024) >> 2);
assign value = MEM_R_EN ? memory[address]: 32'bz;

always @(posedge clk) begin
    if (MEM_W_EN) begin
        memory[address] <= VAL_Rm; 
    end
end
    
endmodule

