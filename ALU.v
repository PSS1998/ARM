module ALU(
  input signed [31:0] Val1, Val2,
  input[3:0] EXE_CMD,
  input C_in,
  output [3:0] Status_Bits,
  output signed[31:0] ALU_Res
);

  parameter ALU_MOV = 1, ALU_MVN = 9, 
            ALU_ADD = 2, ALU_ADC = 3, ALU_SUB = 4, ALU_SBC = 5, 
            ALU_AND = 6, ALU_ORR= 7, ALU_EOR = 8,
            ALU_CMP = 4, ALU_TST = 6, 
            ALU_LDR = 2, ALU_STR = 2, 
            ALU_BRANCH = 4'bx;

  reg Co;
  reg signed[31:0] ALU_Res_temp;
  
  always @(*) begin
    Co = 0;
    case (EXE_CMD)
        ALU_MOV: ALU_Res_temp <= Val2;
        ALU_MVN: ALU_Res_temp <= ~Val2;
        ALU_ADD: {Co, ALU_Res_temp} <= Val1 + Val2;
        ALU_ADC: {Co, ALU_Res_temp} <= Val1 + Val2 + C_in;
        ALU_SUB: {Co, ALU_Res_temp} <= Val1 - Val2;
        ALU_SBC: {Co, ALU_Res_temp} <= Val1 - Val2 - C_in;
        ALU_EOR: ALU_Res_temp <= Val1 ^ Val2;
        ALU_AND: ALU_Res_temp <= Val1 & Val2;
        ALU_ORR: ALU_Res_temp <= Val1 | Val2;
        ALU_CMP: ALU_Res_temp <= Val1 - Val2;
        ALU_TST: ALU_Res_temp <= Val1 & Val2;
        ALU_LDR: ALU_Res_temp <= Val1 + Val2;
        default: ALU_Res_temp <= 32'sb0;
    endcase
  end

  assign Z = (ALU_Res_temp == 16'b0) ? 1'b1 : 1'b0;
  assign N = (ALU_Res_temp < 0) ? 1'b1 : 1'b0;
  assign V = ((EXE_CMD == ALU_ADD) || (EXE_CMD == ALU_ADC) || (EXE_CMD == ALU_SUB) || (EXE_CMD == ALU_SBC)) ? 
              (
                (((EXE_CMD == ALU_ADD) || (EXE_CMD == ALU_ADC)) && (Val1[31] == Val2[31]) && (ALU_Res_temp[31] != Val1[31])) ? 1'b1 : 
                (((EXE_CMD == ALU_SUB) || (EXE_CMD == ALU_SBC)) && (Val1[31] != Val2[31]) && (ALU_Res_temp[31] != Val1[31])) ? 1'b1 : 1'b0  
              )
             : 1'b0;
  assign C = Co;
  assign Status_Bits[3] = N;
  assign Status_Bits[2] = Z;
  assign Status_Bits[1] = C;
  assign Status_Bits[0] = V;
  
  assign ALU_Res = ALU_Res_temp;

endmodule