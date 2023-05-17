module test_carpark;

reg pass,auth,clk;
wire pout;

carpark cpt(pout,pass,auth,clk);

always #5 clk = ~clk;

initial begin
 #10 pass = 1'b01; #10 auth = 1'b01;
 #20 pass = 1'b00; #20 auth = 1'b01;
 #30 pass = 1'b11; #30 auth = 1'b01;
 #40 pass = 1'b10; #40 auth = 1'b01;
end

initial begin
  $display("password:%2d, Carparked:%2d",pass,pout);
end

endmodule



module carpark(pout,pass,auth,clk);

input [1:0]pass,auth; //password and authentication
parameter fsnsr = 2'b01,bsnsr= 2'b11,nscar= 2'b00,ocm = 1'b0; //front sensor , back sensor , next car , outcome of parking
input clk;

output pout;  // output car parked

always@(posedge clk)

if((pass == 1'b1) && (auth == 1'b1))  // check for password and authentify
 begin
  fsnsr <= 2'b01; bsnsr <= 2'b10; ocm <= 1'b0; 
  nscar <= 2'b00; 
 end

else                    // check again for password
 begin
  fsnsr <= 2'b01; bsnsr <= 2'b00;
  ocm <= 1'b0; nscar <= 2'b00;
 end

if(bsnsr == 2'b01)  // passowrd is correct and car parked notify next car
  begin
   fsnsr <= 2'b00; 
	nscar <= 2'b11; 
	ocm <= 1'b1;
  end

assign pout = ocm;



endmodule


  
 


