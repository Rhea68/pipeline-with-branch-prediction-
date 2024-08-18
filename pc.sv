//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute and relative branches
// Author: rz
// Last rev. 24/06/2024
//-----------------------------------------------------
module PC #(parameter Psize = 5) // up to 32 instructions
(input logic clk, nreset, 
 input logic mispredict,
 input logic show,
 input logic take_branch,
 input logic [Psize-1:0] reg_pc_plus,
 input logic [Psize-1:0] predicted_target,
 output logic [Psize-1 : 0]pc,
 output logic [Psize-1 : 0]pc_plus
);

//------------- code starts here---------

always_ff @(posedge clk or negedge nreset) 
  begin
  if (!nreset) 
      pc <= {Psize{1'b0}}; 
	 else if (mispredict)
        pc <= reg_pc_plus;   
	  else if (take_branch)
          pc <= predicted_target; 
	    else if (show)
            pc <= pc-1'b1; 
	           else  
                  pc <= pc+1'b1;
	end

always_comb
  begin
  pc_plus= pc+1'b1;
  end
	 
endmodule 