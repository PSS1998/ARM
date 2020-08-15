module Forwarding_Unit(
  input en,
  input[3:0] src1,
  input[3:0] src2,
  input[3:0] WB_Dest, MEM_Dest,
  input WB_WB_en, MEM_WB_en,
  output[1:0] Sel_src1, Sel_src2
);

    assign Sel_src1 = ~en ? 2'd0 
            : (MEM_WB_en && (src1 == MEM_Dest)) ? 2'd1 
            : (WB_WB_en && (src1 == WB_Dest))   ? 2'd2 
            : 2'd0; 

    assign Sel_src2 = ~en ? 2'd0 
            : (MEM_WB_en && (src2 == MEM_Dest)) ? 2'd1 
            : (WB_WB_en && (src2 == WB_Dest))   ? 2'd2 
            : 2'd0;   

endmodule