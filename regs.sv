//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 32 x n registers, %0 == 0
// Author: rz
// Last rev. 24/07/2024
//-----------------------------------------------------
module regs #(parameter n = 8) // n - data bus width
(input logic clk, nreset,//clk and reset control
 input logic w,
 input logic [n-1:0] Wdata,
 input logic [3:0] Raddr1, Raddr2,
 output logic [n-1:0] Rdata1, Rdata2
 );
//logic i;
 	// Declare 14 n-bit registers 
	logic [n-1:0] gpr [13:0];
	
	// write process, dest reg is Raddr1
	always_ff @ (posedge clk,negedge nreset)
	begin
		if (!nreset)
          begin		
            gpr[0] <= 0;
			gpr[1] <= 0;
			gpr[2] <= 0;
			gpr[3] <= 0;
			gpr[4] <= 0;
			gpr[5] <= 0;
			gpr[6] <= 0;
			gpr[7] <= 0;
			gpr[8] <= 0;
			gpr[9] <= 0;
			gpr[10] <= 0;
			gpr[11] <= 0;
			gpr[12] <= 0;
			gpr[13] <= 0;
			
			end 
		else if (w)
		begin
            gpr[Raddr2] <= Wdata;
		
		end
	end
		

	// read process, output 0 if %0 is selected
	always_comb
	
	begin
	   if (Raddr2==4'd0)
	         Rdata2 =  {n{1'b0}};
		
              else  
			    Rdata2 = gpr[Raddr2];
	 
        if (Raddr1==4'd0)
	        Rdata1 =  {n{1'b0}};
	  else  Rdata1 = gpr[Raddr1];
	  end
	  
	
	
	

endmodule // module regs