module rca(x,y,s,ci,co);
input[3:0]x,y;
input ci;
output[3:0]s;
output co;
wire w1,w2,w3;
fulladder u1(x[0],y[0],ci,s[0],w1);
fulladder u2(x[1],y[1],w1,s[1],w2);
fulladder u3(x[2],y[2],w2,s[2],w3);
fulladder u4(x[3],y[3],w3,s[3],co);
endmodule
