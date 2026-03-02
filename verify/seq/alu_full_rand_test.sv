`ifndef ALU_FULL__SV
`define ALU_FULL__SV
class full_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
   int unsigned seq_repeat_cnt = 100;

   function  new(string name= "full_sequence");
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
		 `uvm_info("alu_full_rand_test", "op = 3'bxxx , full_rand:", UVM_LOW);
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(full_sequence)
endclass


class alu_full_rand_test extends base_test;

   function new(string name = "alu_full_rand_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(alu_full_rand_test)
endclass


function void alu_full_rand_test::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           full_sequence::type_id::get());
endfunction

`endif
