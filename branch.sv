//-----------------------------------------------------
// File Name   : branch.sv
// Function    : branch comparator module
// Author:  rz
// Last rev. 24/06/2024
//-----------------------------------------------------

//`include "opcodes.sv"
module branch #(parameter n =8) (
   input logic [n-1:0] Rdata1, Rdata2,
   output logic LT
);       
always_comb 
begin 
  LT=1'b0;
  if (Rdata1<Rdata2)
     LT=1'b1;
	 	
 end
endmodule 

