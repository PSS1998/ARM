module Arm_TB();
  
    reg clk=0,rst=0;
    
    
    ARM CPU (clk,rst);


    initial begin
        repeat (5000) #10 clk=~clk;
    end

    initial begin
        #10 rst=1;
        #10 rst=0;
    end
    
endmodule 
