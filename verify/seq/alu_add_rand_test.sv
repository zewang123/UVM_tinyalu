`ifndef ALU_ADD__SV
`define ALU_ADD__SV
class add_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "add_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         `uvm_do_with(m_trans, {m_trans.op == 3'b001;})
		 `uvm_info("alu_add_rand_test", "op = 3'b001 , add_rand:", UVM_LOW);
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(add_sequence)
endclass


class alu_add_rand_test extends base_test;

   function new(string name = "alu_add_rand_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(alu_add_rand_test)
endclass


function void alu_add_rand_test::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           add_sequence::type_id::get());
endfunction

`endif
