`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:28:25 05/13/2023 
// Design Name: 
// Module Name:    b5 
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
module b5(X, Y, Z);
      input signed [7:0] X, Y;
       output signed [15:0] Z;
       reg signed [15:0] Z;
       reg [1:0] temp;
       integer i; 
       reg E1;
       reg [7:0] Y1;
       always @ (X, Y)
       begin
       Z = 16'd0;
       E1 = 1'd0;
       for (i = 0; i < 8; i = i + 1)
       begin
       temp = {X[i], E1};
		 Y1 = - Y;
  case (temp)
       2'd2 : Z [15 : 8] = Z [15 : 8] + Y1;
       2'd1 : Z [15 : 8] = Z [15 : 8] + Y;
       default : begin end
       endcase
       Z = Z >> 1;
       
       Z[15] = Z[14];
       
      
       E1 = X[i];
           end
       if (Y == 8'd16)
      
      
           begin
               Z = - Z;
           end
      
       end
      
      //Z={Z,8'b0}; 
endmodule 