module ConditionCheck(
  input[3:0] cond, statusReg,
  output conditionCheck_out
);

  reg tempConditionCheck_out;
  wire N, ZE, C, V;
  assign N = statusReg[3];
  assign ZE = statusReg[2];
  assign C = statusReg[1];
  assign V = statusReg[0];

  always @(*) begin
    case (cond)
      4'b0000: tempConditionCheck_out <= ZE == 1'b1;
      4'b0001: tempConditionCheck_out <= ZE == 1'b0;
      4'b0010: tempConditionCheck_out <= C == 1'b1;
      4'b0011: tempConditionCheck_out <= C == 1'b0;
      4'b0100: tempConditionCheck_out <= N == 1'b1;
      4'b0101: tempConditionCheck_out <= N == 1'b0;
      4'b0110: tempConditionCheck_out <= V == 1'b1;
      4'b0111: tempConditionCheck_out <= V == 1'b0;
      4'b1000: tempConditionCheck_out <= C == 1'b1 && ZE == 1'b0;
      4'b1001: tempConditionCheck_out <= C == 1'b0 || ZE == 1'b1;
      4'b1010: tempConditionCheck_out <= N == V;
      4'b1011: tempConditionCheck_out <= N != V;
      4'b1100: tempConditionCheck_out <= ZE == 1'b0 && N == V;
      4'b1101: tempConditionCheck_out <= ZE == 1'b1 || N != V;
      4'b1110: tempConditionCheck_out <= 1'b1;
      default: tempConditionCheck_out <= 1'b0;
    endcase
  end

  assign conditionCheck_out = tempConditionCheck_out;

endmodule
