`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_driver.sv"
`include "my_if.sv"
`include "my_transaction.sv"
`include "my_env.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "my_model.sv"


module top_tb;
	
reg 		clk;
reg 		rst_n;

reg [7:0]  	A;
reg [7:0] 	B;
reg [2:0]  	op;
reg 		start;
reg 		done;
reg [15:0] 	result;

my_if input_if(clk, rst_n);
my_if output_if(clk, rst_n);

tinyalu tinyalu_tb( .A(input_if.A),
					.B(input_if.B), 
					.clk(clk), 
					.op(input_if.op), 
					.reset_n(rst_n), 
					.start(input_if.start), 
					.done(output_if.done), 
					.result(output_if.result)); 

assign output_if.A     = input_if.A;
assign output_if.B     = input_if.B;
assign output_if.op    = input_if.op;
assign output_if.start = input_if.start;
assign input_if.done   = output_if.done;
assign input_if.result = output_if.result;


initial begin
   clk = 0;
   forever begin
      #100 clk = ~clk;
   end
end

initial begin
   rst_n = 1'b0;
   #1000;
   rst_n = 1'b1;
end

initial begin
	run_test("my_env");
end

initial begin
	uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.i_agt.drv", "vif", input_if);
	uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.i_agt.mon", "vif", input_if);
   	uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.o_agt.mon", "vif", output_if);
end


initial begin
	$fsdbDumpfile("sim.fsdb");
	$fsdbDumpvars(0,tinyalu_tb);
end

endmodule




