module IF_Stage(
  input clk, rst, freeze, Branch_taken,
  input[31:0] BranchAddr,
  output[31:0] PC, Instruction
);
  
  wire[31:0] pc_in, pc_out;
  reg[31:0] inst;

  always @(*) begin
    case(pc_out)
      0: inst <= 32'b1110_00_1_1101_0_0000_0000_000000010100;
      1: inst <= 32'b1110_00_1_1101_0_0000_0001_101000000001;
      2: inst <= 32'b1110_00_1_1101_0_0000_0010_000100000011;
      3: inst <= 32'b1110_00_0_0100_1_0010_0011_000000000010;
      4: inst <= 32'b1110_00_0_0101_0_0000_0100_000000000000;
      5: inst <= 32'b1110_00_0_0010_0_0100_0101_000100000100;
      6: inst <= 32'b1110_00_0_0110_0_0000_0110_000010100000;
      7: inst <= 32'b1110_00_0_1100_0_0101_0111_000101000010;
      8: inst <= 32'b1110_00_0_0000_0_0111_1000_000000000011;
      9: inst <= 32'b1110_00_0_1111_0_0000_1001_000000000110;
      10: inst <= 32'b1110_00_0_0001_0_0100_1010_000000000101;
      11: inst <= 32'b1110_00_0_1010_1_1000_0000_000000000110;
      12: inst <= 32'b0001_00_0_0100_0_0001_0001_000000000001;
      13: inst <= 32'b1110_00_0_1000_1_1001_0000_000000001000;
      14: inst <= 32'b0000_00_0_0100_0_0010_0010_000000000010;
      15: inst <= 32'b1110_00_1_1101_0_0000_0000_101100000001;
      16: inst <= 32'b1110_01_0_0100_0_0000_0001_000000000000;
      17: inst <= 32'b1110_01_0_0100_1_0000_1011_000000000000;
      18: inst <= 32'b1110_01_0_0100_0_0000_0010_000000000100;
      19: inst <= 32'b1110_01_0_0100_0_0000_0011_000000001000;
      20: inst <= 32'b1110_01_0_0100_0_0000_0100_000000001101;
      21: inst <= 32'b1110_01_0_0100_0_0000_0101_000000010000;
      22: inst <= 32'b1110_01_0_0100_0_0000_0110_000000010100;
      23: inst <= 32'b1110_01_0_0100_1_0000_1010_000000000100;
      24: inst <= 32'b1110_01_0_0100_0_0000_0111_000000011000;
      25: inst <= 32'b1110_00_1_1101_0_0000_0001_000000000100;
      26: inst <= 32'b1110_00_1_1101_0_0000_0010_000000000000;
      27: inst <= 32'b1110_00_1_1101_0_0000_0011_000000000000;
      28: inst <= 32'b1110_00_0_0100_0_0000_0100_000100000011;
      29: inst <= 32'b1110_01_0_0100_1_0100_0101_000000000000;
      30: inst <= 32'b1110_01_0_0100_1_0100_0110_000000000100;
      31: inst <= 32'b1110_00_0_1010_1_0101_0000_000000000110;
      32: inst <= 32'b1100_01_0_0100_0_0100_0110_000000000000;
      33: inst <= 32'b1100_01_0_0100_0_0100_0101_000000000100;
      34: inst <= 32'b1110_00_1_0100_0_0011_0011_000000000001;
      35: inst <= 32'b1110_00_1_1010_1_0011_0000_000000000011;
      36: inst <= 32'b1011_10_1_0_111111111111111111110111;
      37: inst <= 32'b1110_00_1_0100_0_0010_0010_000000000001;
      38: inst <= 32'b1110_00_0_1010_1_0010_0000_000000000001;
      39: inst <= 32'b1011_10_1_0_111111111111111111110011;
      40: inst <= 32'b1110_01_0_0100_1_0000_0001_000000000000;
      41: inst <= 32'b1110_01_0_0100_1_0000_0010_000000000100;
      42: inst <= 32'b1110_01_0_0100_1_0000_0011_000000001000;
      43: inst <= 32'b1110_01_0_0100_1_0000_0100_000000001100;
      44: inst <= 32'b1110_01_0_0100_1_0000_0101_000000010000;
      45: inst <= 32'b1110_01_0_0100_1_0000_0110_000000010100;
      46: inst <= 32'b1110_10_1_0_111111111111111111111111;
    endcase
  end

  assign Instruction = inst;

  PC_Reg pc_reg(.clk(clk), .rst(rst), .en(~freeze), .PC_in(pc_in), .PC_out(pc_out));
  
  assign PC = pc_out + 1;
  assign pc_in = Branch_taken ? BranchAddr : PC ;


endmodule