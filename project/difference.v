`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:29 05/13/2023 
// Design Name: 
// Module Name:    difference 
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
module difference(
    input [15:0] A,
    input [15:0] B,
    output reg [15:0] diff
);

reg [15:0] high;
reg [15:0] low;

// Compare A and B to determine the higher and lower numbers
always @* begin
    if (A >= B) begin
        high = A;
        low = B;
    end else begin
        high = B;
        low = A;
    end
end

// Calculate the difference between the higher and lower numbers
always @* begin
    diff = high - low;
end

endmodule
