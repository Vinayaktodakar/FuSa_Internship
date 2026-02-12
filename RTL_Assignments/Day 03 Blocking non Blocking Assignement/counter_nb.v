`timescale 1ns/1ps
module counter(clk, rst, count);
  input clk, rst;
  output reg [3:0] count;

 always @(posedge clk)
  begin
    if (rst) 
      count <= 4'b0;
    else 
      count <= 2;
  end
endmodule

module tb;
reg clk,rst;
wire [3:0]count;

counter c1(.clk(clk), .rst(rst), .count(count));

initial begin
	clk=0;
	rst=1;

	#15
	rst=0;

	#80 
	rst=1;
end

initial begin
	$monitor($time,"\tcounter : %0d",count);
	#100 
	$finish;
end
always #5 clk=~clk;
endmodule

