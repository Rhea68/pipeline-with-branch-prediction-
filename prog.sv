//-----------------------------------------------------
// File Name : prog.sv
// Function : Program memory Psize x Isize - reads from file prog.hex
// Author: rz 
// Last rev. 24/06/2024
//-----------------------------------------------------
module prog #(parameter Psize = 5, Isize = 20) // psize - address width, Isize - instruction width
(input logic [Psize-1:0] ProgAddress,
output logic [Isize-1:0] I); // I - instruction code

// program memory declaration, note: 1<<n is same as 2^n
logic [Isize-1:0] progMem[30:0];
//logic i;
// get memory contents from file
initial
   
    $readmemh("prog.hex", progMem);
  //end
// program memory read 
always_comb
  I = progMem[ProgAddress];
  
endmodule // end of module prog