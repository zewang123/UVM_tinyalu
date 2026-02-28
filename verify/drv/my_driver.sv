`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

`include "my_transaction.sv"



class my_driver extends uvm_driver#(my_transaction);

	virtual my_if vif;

	`uvm_component_utils(my_driver)
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
      `uvm_info("my_driver", "new is called", UVM_LOW);
   endfunction

	virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("my_driver", "build_phase is called", UVM_LOW);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(my_transaction tr);

endclass

task my_driver::main_phase(uvm_phase phase);
	`uvm_info("my_driver", "main_phase is called", UVM_LOW);

  	vif.A 		<= 8'b0; 
   	vif.B		<= 8'b0;
	vif.start	<= 1'b0;
	vif.op  	<= 3'b0;
	vif.done 	<= 1'b0;

   	while(!vif.rst_n)
      	@(posedge vif.clk);
   	while(1) begin
      	seq_item_port.try_next_item(req);
		if(req == null)
			@(posedge vif.clk);
		else begin
      		drive_one_pkt(req);
      		seq_item_port.item_done();
		end
   	end		
	`uvm_info("my_driver", "data is done!!!!", UVM_LOW);
endtask

task my_driver::drive_one_pkt(my_transaction tr);
	`uvm_info("my_driver", "begin to drive one calc pkt", UVM_LOW);

	repeat(5) @(posedge vif.clk);
	vif.A 		<= tr.A; 
   	vif.B		<= tr.B;
	vif.op		<= tr.op;
	vif.start 	<= 1'b1;
	vif.result	<= 8'b0;
	vif.done    <= 1'b0;

	repeat(1) @(posedge vif.clk);
   	vif.start <= 1'b0;
    `uvm_info("my_driver", "end drive one pkt", UVM_LOW);

	repeat(5) @(posedge vif.clk);
   `uvm_info("my_driver", $sformatf("end drive one calc pkt:A=%0h, B=%0h, op=%01h,result=%0h", tr.A, tr.B, tr.op, tr.result), UVM_LOW);


endtask

`endif



