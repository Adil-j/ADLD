module pipe(f,a,b,c,d,clk);
parameter n=10;
input [n-1:0]a,b,c,d;
input clk;
output  [n-1:0]f;
reg[n-1:0]l12_x1,l12_x2,l12_d,l23_x3,l23_d,l34_f;


always@(posedge clk)
 begin
  l12_x1<= #4 a+b;
  l12_x2<= #4 c-d;
  l12_d<= d;
  
  l23_x3<= #4 l12_x1 + l12_x2;
  l23_d<=l12_d;
   
  l34_f<= #6 l23_x3 * l23_d;
 end
assign f=l34_f;
endmodule

module pipe_tb();
parameter n=10;
reg [n-1:0]a,b,c,d;
reg clk;
wire [n-1:0]f;
pipe dut(f,a,b,c,d,clk);
//wire [n-1:0]l12_x1,l12_x2,l12_d,l23_x3,l23_d,l34_f;
initial clk=1'b0;
always #5 clk=~clk;
initial begin
#4 a=10'd2;
b=10'd3;
c=10'd9;
d=10'd5;
end
initial begin
 $monitor($time , "F:%d",f);
 #600 $finish;
end

endmodule
