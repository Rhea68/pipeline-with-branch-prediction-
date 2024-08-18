module BPre_Table #(parameter Psize = 5) (   
    input logic [Psize-1:0] pc_plus,          // current PC+1	
    output logic [Psize-1:0] predicted_target,   
    output logic take_branch                // take branch or not
);

    typedef struct packed {
        logic [Psize-1:0] pc_t;                    // PC address of branch instruction
        logic [Psize-1:0] target_t;                // Predicted jump target address
    } bpred_entry_t;

    bpred_entry_t bpred_table[2];  // A prediction table with two entries

    // Branch prediction table initialization
    initial begin
        bpred_table[0].pc_t = 28;     // BLT instruction PC address
        bpred_table[0].target_t = 5;  // The starting address of loop_x

        bpred_table[1].pc_t = 30;     // BLT instruction PC address
        bpred_table[1].target_t = 4;  // The starting address of loop_y
    end
   	  
always_comb
 begin
    predicted_target = 5'b0;
     take_branch = 0;
	if (bpred_table[0].pc_t == pc_plus)
		  begin
		      predicted_target = bpred_table[0].target_t;
              take_branch = 1'b1; 
		  end 
		 else if (bpred_table[1].pc_t == pc_plus)
		  begin
		      predicted_target = bpred_table[1].target_t;
              take_branch = 1'b1; 
		  end 
      end 
     
  endmodule
  
  // 预测逻辑
	/*always_ff @(posedge clk or negedge nreset) // async reset
      begin
        
		if (!nreset)
		 begin 
		  predicted_target <= 5'b0;
          take_branch <= 0;
		 end 
		else if (bpred_table[0].pc_t == pc_plus)
		  begin
		      predicted_target <= bpred_table[0].target_t;
              take_branch <= 1; 
		  end 
		 else if (bpred_table[1].pc_t == pc_plus)
		  begin
		      predicted_target <= bpred_table[1].target_t;
              take_branch <= 1; 
		  end 
      end*/