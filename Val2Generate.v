module Val2Generate(
    input Mem_RW,
    input[31:0] Val_Rm,
    input imm,
    input[11:0] Shift_operand,
    output[31:0] out
);

    reg[31:0] tempOut;
    wire[1:0] shift_mode;
    reg[31:0] immediate32_rotate_shift_result;
    reg[31:0] immediate_rotate_shift_result;
   
    assign shift_mode = Shift_operand[6:5];
   
    integer i;
    integer j;
    always @(*) begin
      
		immediate32_rotate_shift_result = Shift_operand[7:0];
		immediate_rotate_shift_result = Val_Rm;

        for (i = 0; i < (Shift_operand[11:8]); i = i + 1) begin
            immediate32_rotate_shift_result = {immediate32_rotate_shift_result[1:0], immediate32_rotate_shift_result[31:2]};
        end
        for (j = 0; j < (Shift_operand[11:7]); j = j + 1) begin
            immediate_rotate_shift_result = {immediate_rotate_shift_result[0], immediate_rotate_shift_result[31:1]};
        end
        
    end

    assign out = Mem_RW ? Shift_operand
					       : ((imm == 1'b1) ? immediate32_rotate_shift_result
					       : (((imm == 1'b0) && (Shift_operand[4] == 1'b0)) ?
					         (
						        (shift_mode == 2'b00) ? (Val_Rm <<  Shift_operand[11:7]) :
						        (shift_mode == 2'b01) ? (Val_Rm >>  Shift_operand[11:7]) :
						        (shift_mode == 2'b10) ? (Val_Rm >>> Shift_operand[11:7]) : 
						        (shift_mode == 2'b11) ? immediate_rotate_shift_result    : 32'b0
						       )
						     : 32'b0));

endmodule
