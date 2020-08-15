module ALU(
  input signed [31:0] Val1, Val2,
  input[3:0] EXE_CMD,
  input C_in,
  output [3:0] Status_Bits,
  output reg signed[31:0] ALU_Res
);

  parameter ALU_MOV = 1, ALU_MVN = 9, ALU_ADD = 2, ALU_ADC = 3, ALU_SUB = 4,
           	ALU_SBC = 5, ALU_AND = 6, ALU_ORR= 7, ALU_EOR = 8,
            ALU_CMP = 4, ALU_TST = 6, ALU_LDR = 2, ALU_STR = 2, ALU_BRANCH = 4'bx;

  reg rC;
  
  always @(*) begin
    ALU_Res = 32'sb0;
    rC = 0;
    case (EXE_CMD)
        ALU_MOV: ALU_Res = Val2;
        ALU_MVN: ALU_Res = ~Val2;
        ALU_ADD: {rC, ALU_Res} = Val1 + Val2;
        ALU_ADC: {rC, ALU_Res} = Val1 + Val2 + C_in;
        ALU_SUB: {rC, ALU_Res} = Val1 - Val2;
        ALU_SBC: {rC, ALU_Res} = Val1 - Val2 - C_in;
        ALU_EOR: ALU_Res = Val1 ^ Val2;
        ALU_AND: ALU_Res = Val1 & Val2;
        ALU_ORR: ALU_Res = Val1 | Val2;
        ALU_CMP: ALU_Res = Val1 - Val2;
        ALU_TST: ALU_Res = Val1 & Val2;
        ALU_LDR: ALU_Res = Val1 + Val2;
    endcase
  end

  assign Z = ALU_Res == 16'b0 ? 1 : 0;
  assign N = ALU_Res < 0 ? 1 : 0;
  assign V = Val1[31] == (Val2[31] ^ (EXE_CMD == ALU_SUB)) && ALU_Res[31] != Val1[31];
  assign C = rC;
  assign Status_Bits[3] = N;
  assign Status_Bits[2] = Z;
  assign Status_Bits[1] = C;
  assign Status_Bits[0] = V;

endmodule

module ALUTB();
	reg signed [31:0] a, b;
	reg[3:0] op;
  reg c;
	wire signed [31:0] o;
	wire[3:0] status_bits;
	wire Z, C, N, V;

    parameter ALU_MOV = 1, ALU_MVN = 9, ALU_ADD = 2, ALU_ADC = 3, ALU_SUB = 4,
        ALU_SBC = 5, ALU_AND = 6, ALU_ORR= 7, ALU_EOR = 8,
        ALU_CMP = 4, ALU_TST = 6, ALU_LDR = 2, ALU_STR = 2, ALU_BRANCH = 4'bx;

	
	ALU al(a, b, op, c, N, Z, C, V, o);
	
	assign N = status_bits[3];
  assign Z = status_bits[2];
  assign C = status_bits[1];
  assign V = status_bits[0];
  
	initial begin
	a = -12; b = 20; op = 4'b0; c = 0;
	#10 op = ALU_MOV;
	#10 op = ALU_ADD;
	#10 op = ALU_ADC;
	#10 op = ALU_TST;
	#10 op = ALU_SBC;
	#10 $stop;
	end
endmodule