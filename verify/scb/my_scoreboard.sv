`ifndef MY_SCOREBOARD__SV
`define MY_SCOREBOARD__SV
class my_scoreboard extends uvm_scoreboard;
   my_transaction  expect_queue[$];
   uvm_blocking_get_port #(my_transaction)  exp_port;
   uvm_blocking_get_port #(my_transaction)  act_port;
   `uvm_component_utils(my_scoreboard)

   extern function new(string name, uvm_component parent = null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual task main_phase(uvm_phase phase);
endclass 

function my_scoreboard::new(string name, uvm_component parent = null);
   super.new(name, parent);
endfunction 

function void my_scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   exp_port = new("exp_port", this);
   act_port = new("act_port", this);
endfunction 

task my_scoreboard::main_phase(uvm_phase phase);

   
	my_transaction  get_actual;
	my_transaction  get_expect;
	bit result;

   	super.main_phase(phase);

	fork
	while (1) begin

	exp_port.get(get_expect);
	act_port.get(get_actual);
	result = get_actual.compare(get_expect);

	if(result) begin 
    	`uvm_info("my_scoreboard", "Compare SUCCESSFULLY!!!!", UVM_LOW);
		$display("the pkt is");
		`uvm_info("my_scoreboard", $sformatf("get_actual_result=%0h,get_expect_result=%0h",get_actual.result,get_expect.result), UVM_LOW);
    end
    else begin
    	`uvm_error("my_scoreboard", "Compare FAILED");
        $display("the expect pkt is");
        get_expect.print();
        $display("the actual pkt is");
        get_actual.print();
    end

	end
	join

	endtask
`endif
