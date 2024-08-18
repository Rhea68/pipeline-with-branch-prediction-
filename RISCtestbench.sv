module testpicoRISC;
    logic clk, nreset,outport; //readyin;
    
	
	cpu c1(.*);
	initial
		begin
		clk='0;
		nreset = '1;
 		#2ns nreset = '0;
 		#2ns nreset = '1;
		forever #2ns clk=~clk;
		end
		

endmodule