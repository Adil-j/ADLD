module t_ram();
reg [7:0]di;
reg [9:0]ad;
reg w,cs;
wire [7:0]do;
integer k,l;
ram r1(do,di,ad,w,cs);
initial l=10; 
/*initial begin
  for(k=0;k<=1023;k=k+1)
   begin 
	#2 w=1;cs=1;
	ad=k;
	di=k+10;
	#2 w=0;cs=0;
   end */
repeat(20)
 begin
	 ad=$random(l);
	w=0;cs=1;
	$display("Address:%d,Data:%d",ad,do);

 end
end
endmodule

