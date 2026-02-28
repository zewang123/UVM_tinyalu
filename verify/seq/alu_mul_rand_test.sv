`ifndef ALU_MUL__SV
`define ALU_MUL__SV
class mul_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "mul_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         `uvm_do_with(m_trans, {m_trans.op[2] == 1'b1;})
		 `uvm_info("alu_mul_rand_test", "mul = 3'b1xx , mul_rand:", UVM_LOW);
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(mul_sequence)
endclass


class alu_mul_rand_test extends base_test;

   function new(string name = "alu_mul_rand_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(alu_mul_rand_test)
endclass


function void alu_mul_rand_test::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           mul_sequence::type_id::get());
endfunction

`endif
