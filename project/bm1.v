`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:46 05/12/2023 
// Design Name: 
// Module Name:    bm1 
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

module bm1(
  input [3:0] multiplicand,
  input [3:0] multiplier,
  output [15:0] product
);

  wire signed [15:0] signed_product;
  wire [15:0] unsigned_product;

  assign signed_product = multiplicand * multiplier;
  assign unsigned_product = (signed_product < 0) ? ~signed_product + 1 : signed_product;

  assign product = {(signed_product < 0) ? unsigned_product + 128 : unsigned_product};

endmodule

