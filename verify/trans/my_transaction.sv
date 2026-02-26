`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV

class my_transaction extends uvm_sequence_item;

	rand logic 	[7:0]  	A;
	rand logic 	[7:0] 	B;
	rand logic 	[2:0]  	op;
	logic		[15:0] 	result;

   constraint op_cons{
      op[2] inside {0,1};
	  op[1:0] inside {1,2,3};
      A inside {[0:128]};
      B inside {[128:255]};
	  }

   `uvm_object_utils(my_transaction);

   function new(string name = "my_transaction");
      super.new();
   endfunction

	function void my_print();
		`uvm_info("my_transaction", $sformatf("A=0x%02h",A), UVM_LOW);
	    `uvm_info("my_transaction", $sformatf("B=0x%02h",B), UVM_LOW);
      	`uvm_info("my_transaction", $sformatf("op=0x%01h",op),UVM_LOW);
      	`uvm_info("my_transaction", $sformatf("result=0x%04h",result),UVM_LOW);
	endfunction

   function void my_copy(my_transaction tr);
      A 	 = tr.A;
	  B 	 = tr.B;
	  op 	 = tr.op;
	  result = tr.result;
   endfunction


endclass
`endif
