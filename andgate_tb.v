module andgate_tb();
reg a,b;
wire c;
andgate DUT(a,b,c);
initial begin 
$monitor("a=%b b=%b c=%b",a,b,c);
a=0;
b=0;
#10;
a=0;
b=1;
#10;
a=1;
b=0;
#10;
a=1;
b=1;
#40 $finish;
end 
endmodule



module andgate(a,b,c);
input a,b;
output c;
assign c= a & b;
endmodule
