`ifndef MY_MODEL__SV
`define MY_MODEL__SV

`include "my_transaction.sv"

class my_model extends uvm_component;
   
   	uvm_blocking_get_port #(my_transaction)  port;
   	uvm_analysis_port #(my_transaction)  ap;

   	extern function new(string name, uvm_component parent);
   	extern function void build_phase(uvm_phase phase);
   	extern virtual  task main_phase(uvm_phase phase);
	extern function my_transaction calc_result(my_transaction tr);

   	`uvm_component_utils(my_model)
endclass 

function my_model::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction 

function void my_model::build_phase(uvm_phase phase);
   	super.build_phase(phase);
   	port = new("port", this);
   	ap = new("ap", this);
endfunction

task my_model::main_phase(uvm_phase phase);
   	my_transaction tr;
   	my_transaction exp_tr;
   	super.main_phase(phase);
   	while(1) begin
      	port.get(tr);
		`uvm_info("my_model", "get port transaction:", UVM_LOW);
      	tr.my_print();
//      	exp_tr = new("exp_tr");
//      	exp_tr.copy(tr);
		exp_tr = calc_result(tr);
      	`uvm_info("my_model", "get one transaction, calc and print it:", UVM_LOW);
      	exp_tr.my_print();
      	ap.write(exp_tr);
   end
endtask

function my_transaction my_model::calc_result(my_transaction tr);
   	my_transaction exp_tr;
	logic [15:0] exp_result;  
   	exp_result = 16'b0;
	
    exp_tr = new("exp_tr");

   	case (tr.op)
      	3'b001: exp_result = {8'b0, tr.A} + {8'b0, tr.B};
      	3'b010: exp_result = {8'b0, tr.A} & {8'b0, tr.B};
      	3'b011: exp_result = {8'b0, tr.A} ^ {8'b0, tr.B};

      	3'b100: exp_result = tr.A * tr.B;                   
      
      	default: exp_result = 16'b0;
   	endcase

   	exp_tr.A	  = tr.A;
	exp_tr.B	  = tr.B;	
	exp_tr.op	  = tr.op;
	exp_tr.result = exp_result;
	`uvm_info("my_model",$sformatf("calc finish::A=%0h, B=%0h, op=%0h, exp=%0h,exp_result=%0h", exp_tr.A, exp_tr.B, exp_tr.op, exp_tr.result, exp_result), UVM_LOW);

	return exp_tr;

endfunction

`endif

