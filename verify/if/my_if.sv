`ifndef MY_IF__SV
`define MY_IF__SV

interface my_if(input clk, input rst_n);

	logic [7:0]  	A;
	logic [7:0] 	B;
	logic [2:0]  	op;
	logic 			start;
	logic 			done;
	logic [15:0] 	result;

endinterface

`endif
