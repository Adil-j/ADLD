`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:54 05/12/2023 
// Design Name: 
// Module Name:    appmul 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
 module appmul(
  input signed [7:0] A,
  input signed [7:0] B,
  output reg [15:0] result,
  output wire [15:0] actual,
  output wire [15:0] diff);

  wire [3:0] Am;
  wire [3:0] Al;
  wire [3:0] Bm;
  wire [3:0] Bl;

  wire [3:0] Ma = 4'b1000;
  wire [3:0] Mb = 4'b1000;

  wire [3:0] An;
  wire [3:0] Bn;

  wire [7:0] AmBm; 
  wire [15:0] AmBn;
  wire [15:0] AnBm; 
  wire [15:0] AnBn;
  wire [15:0] x;                                     //wire msb;
                                                    
																	  
  
  // Split A and B into two equal parts
  assign Am = A[7:4];
  assign Al = A[3:0];
  assign Bm = B[7:4];
  assign Bl = B[3:0]; 
                                                          
                                                          
  // Mask Al and Bl with Ma and Mb type of encoding
  assign An = Al & Ma;
  assign Bn = Bl & Mb;
                                                          
  
  //full precision signed multiplier of msb bits                                                    
  bm4 a0(Am,Bm,AmBm);
                                                          
                                                          
  //lsb       unsigned multiplication                                                       
  bm1 a1(Am,Bn,AmBn);
  bm1 a2(An,Bm,AnBm);
  bm1 a3(An,Bn,AnBn);
  
  //msb alignment 
   assign x = {AmBm,8'd0};
  	
    // Perform align and or operations on the products
  always @* begin
	 result[15:0] =  x +  AmBn + AnBm +  AnBn; 
  end
  
  //actual signed multiplication
  b5 a4(A,B,actual);
  
  //difference in products higher value - lower value
 // assign diff = result - actual;
  difference a5(result,actual,diff);
endmodule

