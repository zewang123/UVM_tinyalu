`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV

class my_transaction extends uvm_sequence_item;

	rand logic 	[7:0]  	A;
	rand logic 	[7:0] 	B;
	rand logic 	[2:0]  	op;
	logic 				start;
	logic 				done;
	logic		[15:0] 	result;

   constraint op_cons{
      op inside {0,1,2};
      A inside {[0:128]};
      B inside {[128:255]};
	  }

   function bit[15:0] calc_expected_result();
      case(op)
         0: return A + B; 
         1: return A - B;  
         2: return A * B; 
         3: return (B!=0) ? (A / B) : 16'hFFFF;          		
		 default: return 16'h0000;
      endcase
   endfunction

   `uvm_object_utils(my_transaction)

   function new(string name = "my_transaction");
      super.new();
   endfunction

	function void my_print();
		`uvm_info("my_transaction", $sformatf("A=0x%02h",A), UVM_LOW);
	    `uvm_info("my_transaction", $sformatf("B=0x%02h",B), UVM_LOW);
      	`uvm_info("my_transaction", $sformatf("op=0x%01h",op),UVM_LOW);
      	`uvm_info("my_transaction", $sformatf("start=%b",start),UVM_LOW);
      	`uvm_info("my_transaction", $sformatf("done=%b",done),UVM_LOW);
      	`uvm_info("my_transaction", $sformatf("result=0x%04h",result),UVM_LOW);
	endfunction



endclass
`endif
