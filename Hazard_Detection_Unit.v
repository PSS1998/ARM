module Hazard_Detection_Unit(
  input[3:0] src1,
  input[3:0] src2,
  input[3:0] Exe_Dest,
  input Exe_WB_EN,
  input Two_src,
  input[3:0] Mem_Dest,
  input Mem_WB_EN,
  input forward_en,
  input MEM_R_EN,
  output hazard_detected
);

  wire hazard, hazard_forward;
  
  assign hazard = ( (Exe_WB_EN == 1'b1) && (src1 == Exe_Dest) ||
                    (Mem_WB_EN == 1'b1) && (src1 == Mem_Dest) ||
                    (Two_src == 1'b1) && (Exe_WB_EN == 1'b1) && (src2 == Exe_Dest) ||
                    (Two_src == 1'b1) && (Mem_WB_EN == 1'b1) && (src2 == Mem_Dest) ) ?
                  1'b1 : 1'b0;
                  
  assign hazard_forward = (((src1 == Exe_Dest) || ((src2 == Mem_Dest) && (Two_src == 1'b1))) && (hazard && MEM_R_EN));
  
  assign hazard_detected = (forward_en == 1'b0) ? hazard : hazard_forward;

endmodule

