//-----------------------------------------------------
// File Name: opcodes.sv
// Function: opcodes for decoder
// Author: rz
// Last rev. 24/06/2024
//-----------------------------------------------------

 `define ADD       4'b0010  // ADD %d, %s;  %s = %d + %s

 `define ADDI      4'b0011  // ADDI %d, %s, imm;  %s = %d + imm

 `define MULI      4'b0100  // MUL %d, %s, imm ;  %s =%d * imm  

 `define DIVIDED   4'b0101  // DIVIDED %d, %s;  %s = %d / %s 
 
 `define SHOW      4'b0110  //show finish
 
 `define LOAD1     4'b1000  //select register,ALU and RAM
 
 `define LOAD2     4'b1001  //Write RAM output into registers
 
 `define STORE     4'b1010  //store word in RAM
 
 `define BLT       4'b1011  //branch less than
 
 `define NOP       4'b1111 