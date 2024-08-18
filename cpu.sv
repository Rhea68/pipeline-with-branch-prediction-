`include "alucodes.sv"
module cpu #( parameter n = 8,Psize = 5,Isize =20) // data bus width
(input logic clk,  
  input logic nreset, 
 output logic outport
);       
//pc
//logic PCincr; // program counter control
logic [Psize-1 : 0]ProgAddress;// Program Memory
logic [Psize-1 : 0]reg_pc_plus;
logic [Psize-1 : 0] predicted_target;
logic mispredict;
logic branch_actual;
//prog
logic [Isize-1:0] I,reg_I; // I - instruction code

//Table
logic [Psize-1:0] pc_plus;
logic take_branch;

//decoder
logic [1:0] ALUfunc; // ALU function
logic imm; // immediate operand signal
logic [n-1:0] b; // output from imm MUX
logic show;
logic w,sw,lw; // register write control
logic LT;

//regs
logic [n-1:0] Rdata1, Rdata2; // Register data
logic [n-1:0]Wdata;

logic [n-1:0] dout;
logic [n-1:0]result;
logic [7:0] mem [199:0];


//------------- code starts here ---------
// module instantiations
PC  #(.Psize(Psize)) progCounter (
        .clk(clk),
        .nreset(nreset),
        .show(show),
        .mispredict(mispredict),       	
		.take_branch(take_branch),
        .reg_pc_plus(reg_pc_plus), 
		.predicted_target(predicted_target),
        .pc(ProgAddress),
		.pc_plus(pc_plus));

prog #(.Psize(Psize),.Isize(Isize)) 
      progMemory (.ProgAddress(ProgAddress),.I(I));
	  
BPre_Table #(.Psize(Psize)) Table (
        //.clk(clk),
        //.nreset(nreset),
		.pc_plus(pc_plus),
		.predicted_target(predicted_target),
		.take_branch(take_branch)		 
		);
		
BpredLogic 	Logic(.reg_take_branch(reg_take_branch),
                  .branch_actual(branch_actual),
				  .mispredict(mispredict));	
				  
pipeline_regs #(.Psize(Psize),.Isize(Isize)) pipe (
            .clk(clk),
            .nreset(nreset),
			.take_branch(take_branch),
			.pc_plus(pc_plus),
			.I(I),
			.reg_take_branch(reg_take_branch),
			.reg_pc_plus(reg_pc_plus),
			.reg_I(reg_I),
			.mispredict(mispredict));

decoder  D (.opcode(reg_I[Isize-1:Isize-4]),
            .LT(LT),
			.branch_actual(branch_actual),					          
			.show(show),
		    .ALUfunc(ALUfunc),
		    .imm(imm),		 
		    .w(w),
			.sw(sw),
			.lw(lw));

regs   #(.n(n))  gpr(
        .clk(clk),
		.nreset(nreset),		
		.w(w),
        .Wdata(Wdata),		
		.Raddr1(reg_I[Isize-5:Isize-8]),  // reg %d number
		.Raddr2(reg_I[Isize-9:Isize-12]), // reg %s number
        .Rdata1(Rdata1),
		.Rdata2(Rdata2)
		);
		

alu    #(.n(n))  iu(
       .a(Rdata1),
	   .b(b),
	   .result(result),
       .ALUfunc(ALUfunc)
       ); // ALU result -> destination reg
	   
branch   #(.n(n))  br(
       .Rdata1(Rdata1),
	   .Rdata2(Rdata2),
       .LT(LT)
	   );
	   
ram    #(.n(n))  Memory(
       .clk(clk),
	   .RAMAddress(result),       	   
	   .din(Rdata2),
	   .sw(sw),
	   .show(show),
	   .dout(dout)
	   ); 
	   


// create MUX for immediate operand
assign b = (imm ? reg_I[n-1:0] : Rdata2);

assign Wdata=(lw)? dout: result;

always_ff @(posedge clk or negedge nreset)
begin
	if (!nreset) // sync reset
                outport <= 1'b0;
	else if(show)
                outport <= 1'b1;
end


endmodule