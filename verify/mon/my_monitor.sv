`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV
class my_monitor extends uvm_monitor;

   virtual my_if vif;

   `uvm_component_utils(my_monitor)
   function new(string name = "my_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
	  `uvm_info("my_moniter", "build_phase is called", UVM_LOW);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_moniter", "virtual interface must be set for vif!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(my_transaction tr);
endclass

task my_monitor::main_phase(uvm_phase phase);
   my_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
   end
endtask

task my_monitor::collect_one_pkt(my_transaction tr);

   	`uvm_info("my_monitor", "begin to collect one pkt", UVM_LOW);

  	while(1) begin
  	    @(posedge vif.clk);
  	    if(vif.done) break;
   	end
   	tr.A = vif.A;
   	tr.B = vif.B;
   	tr.op = vif.op;
   	tr.start = vif.start;
   	tr.done = vif.done;
  	tr.result = vif.result;

	`uvm_info("my_monitor", $sformatf("Monitor path：%s", this.get_full_name()), UVM_LOW);
	tr.my_print();

endtask


`endif
