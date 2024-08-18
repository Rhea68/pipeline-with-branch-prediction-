//-----------------------------------------------------
// File Name   : alu.sv
// Function    : ALU module for picoMIPS
// Author:  rz
// Last rev. 24/06/2024
//-----------------------------------------------------

`include "alucodes.sv"  
module alu #(parameter n =8) (
   input logic signed [n-1:0] a, b, // ALU operands
   input logic [1:0] ALUfunc, // ALU function code
   //output logic [n-1:0] RAMAddress,
   output logic [n-1:0] result // ALU result
);       
//------------- code starts here ---------

// create an n-bit adder 
// and then build the ALU around the adder

logic[2*n-1:0] mr;

always_comb
begin
  
  mr = 0;
  result = 0; // default
  case(ALUfunc)
  	
    `RADD  : begin
	    result = a+b;  
		end
   
	`RMUL :begin
	    
		mr = a*b;
		result = mr[7:0];

		  end
	
	`RDIVIDED :
	   begin
	   result = b/a;
	   end
	   
	`RNOP :;
   endcase
	 
 
 
 end //always_comb

endmodule //end of module ALU

