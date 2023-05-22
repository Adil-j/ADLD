module test_parity;
reg clk, x;
wire z;
parity_gen PAR (x, clk, z);
initial
begin
//$dumpfile ("parity.vcd");
clk = 1'b0;
end
always #5 clk=~clk;
initial
begin
$monitor($time," x=%b z=%b",x,z);
#2  x = 0; #10 x = 1; #10 x = 1; #10 x = 1;
#10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
#10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;

#10 $finish;
end
endmodule


module parity_gen (x, clk, z);
input x, clk;
output reg z;
reg even_odd;
// The machine state
parameter EVEN=0, ODD=1;
always @(posedge clk)
case (even_odd)	
EVEN: begin
z <= x ? 1 : 0;	
even_odd <= x ? ODD : EVEN;
end
ODD: begin
z <= x ? 0 : 1;
even_odd <= x ? EVEN : ODD;
end
default: even_odd <= EVEN;
endcase
endmodule

