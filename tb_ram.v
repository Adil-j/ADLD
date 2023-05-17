module t_ram();
reg [7:0]di;
reg [7:0]ad;
reg w,cs;
wire [7:0]do;
integer k,l;
ram r1(do,di,ad,w,cs);
initial l=10; 
initial begin
  for(k=0;k<=256;k=k+1)
   begin 
	#2 w=1;cs=1;
	ad=k;
	di=k+10;
	#2 w=0;cs=0;
   end 

repeat(20)
 begin
	 ad=$random(l);
	w=0;cs=1;
	$display("Address:%d,Data:%d",ad,do);

end
end
endmodule

module ram(do,di,ad,w,cs);
parameter word=8,addr =8,mems=256;
output [word-1:0]do;
input [word-1:0]di;
input [addr-1:0]ad;
input w,cs;
reg [word-1:0]mem[0:mems-1];
assign do=mem[ad];
always@(w or cs)
if(w) mem[ad]=di;
endmodule

