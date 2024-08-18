module pipeline_regs  #(parameter Psize = 5, Isize = 20) 
(input logic clk, nreset, 
 input logic take_branch,
 input logic [Psize-1:0] pc_plus,
 input logic [Isize-1:0] I,
 input logic mispredict,
 output logic reg_take_branch,
 output logic [Psize-1:0] reg_pc_plus,
 output logic [Isize-1:0] reg_I
);

//------------- code starts here---------

always_ff @(posedge clk or negedge nreset) 
  begin
  if (!nreset) 
   begin
      reg_take_branch <= 0;
	  reg_pc_plus<={Psize{1'b0}};	  
	end
	else
	 begin 
	  reg_take_branch <= take_branch;
	  reg_pc_plus<=pc_plus;	  
	  end
  end 
  
  always_ff @(posedge clk or negedge nreset) 
  begin
  if (!nreset)        
	  reg_I<=20'b11110000000000000000;	
	else if (mispredict)	 
	    reg_I<=20'b11110000000000000000;
	   else 	 
	      reg_I<=I;
	 
   end 
 endmodule