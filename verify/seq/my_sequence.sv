`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction);
   	my_transaction m_trans;
	int unsigned seq_repeat_cnt = 100;

   	function new(string name= "my_sequence");
      	super.new(name);
   	endfunction


   	virtual task body();
	    if($value$plusargs("seq_repeat_cnt=%0d", seq_repeat_cnt)) 
		begin
            `uvm_info("my_seqence", $sformatf("from config_db the repeat: %0d", seq_repeat_cnt), UVM_LOW);
        end else begin
            `uvm_info("py_seqence", $sformatf("no repeat，seq_repeat_cnt: %0d", seq_repeat_cnt), UVM_LOW);
        end

      	if(starting_phase != null) 
         	starting_phase.raise_objection(this);
      	repeat (seq_repeat_cnt) begin
         	`uvm_do(m_trans)
      	end
      	#1000;
      	if(starting_phase != null) 
         	starting_phase.drop_objection(this);
   	endtask
   	`uvm_object_utils(my_sequence)
endclass
`endif
