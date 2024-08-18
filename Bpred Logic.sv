//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute and relative branches
// Author: rz
// Last rev. 24/06/2024
//-----------------------------------------------------
module BpredLogic 
( input logic reg_take_branch, //predict
  input logic branch_actual,// actual  
  output logic mispredict
  
);

//------------- code starts here---------

always_comb
 begin
  mispredict=1'b0; 
  if (reg_take_branch==1&&branch_actual==0)
  mispredict=1'b1;
 end 
	 
endmodule // module pc