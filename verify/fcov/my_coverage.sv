`ifndef MY_COVERAGE__SV
`define MY_COVERAGE__SV

`include "my_transaction.sv"

class my_coverage extends uvm_subscriber #(my_transaction);
    `uvm_component_utils(my_coverage)

    covergroup my_cg with function sample(my_transaction tr);
        option.per_instance = 1;  
        option.goal = 100;        
        option.comment = "TinyALU founction coverage";

        cp_op_type: coverpoint tr.op {
            bins OP_ADD  = {3'b001};  
            bins OP_AND  = {3'b010};  
            bins OP_OR   = {3'b011};  
            bins OP_MUL[]  = {[3'b100:3'b111]};  		
		}

        cp_A_value: coverpoint tr.A {
            bins zero     = {8'h00};          
            bins max      = {8'hFF};          
            bins low[]      = {[8'h01:8'h3F]};  
            bins mid[]      = {[8'h40:8'h7F]};  
            bins high[]     = {[8'h80:8'hBF]};  
            bins ultra_high[] = {[8'hC0:8'hFE]};
        }

        
        cp_B_value: coverpoint tr.B {
            bins zero     = {8'h00};
            bins max      = {8'hFF};
            bins low[]      = {[8'h01:8'h3F]};
            bins mid[]      = {[8'h40:8'h7F]};
            bins high[]     = {[8'h80:8'hBF]};
            bins ultra_high[] = {[8'hC0:8'hFE]};
        }

        
        cc_x_A: cross cp_op_type, cp_A_value;
        cc_x_B: cross cp_op_type, cp_B_value;

        cp_and_result: coverpoint tr.result iff (tr.op == 3'b010) {
            bins carry[] = {[16'h0000:16'h00FF]};  
        }

        cp_or_result: coverpoint tr.result iff (tr.op == 3'b011) {
            bins carry[] = {[16'h0000:16'h00FF]};  
        }


        cp_mult_result: coverpoint tr.result iff (tr.op inside {[3'b100:3'b111]}) {
    		bins low_rslt    = {[16'h0000 : 16'h3FFF]}; 
    		bins medium_rslt = {[16'h4000 : 16'h7FFF]}; 
    		bins high_rslt   = {[16'h8000 : 16'hBFFF]}; 
    		bins ultra_rslt  = {[16'hC000 : 16'hFFFF]};         
		}

        cp_add_result: coverpoint tr.result iff (tr.op == 3'b001) {
            bins no_carry[] = {[16'h0000:16'h00FF]};  
            bins carry[]    = {[16'h0100:16'h01FE]};  
        }

    endgroup

 
    function new(string name = "my_coverage", uvm_component parent = null);
        super.new(name, parent);
        my_cg = new();
	endfunction


    virtual function void write(my_transaction t);
        `uvm_info("MY_COVERAGE", "Sampling transaction for coverage", UVM_DEBUG);
        my_cg.sample(t);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        real total_cov = my_cg.get_coverage();
        `uvm_info(get_type_name(), "=== TinyALU founction ===", UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("total cov: %.2f%%", total_cov), UVM_LOW);
        
        `uvm_info(get_type_name(), $sformatf("cp_op_type: %.2f%%", my_cg.cp_op_type.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("cp_A_value: %.2f%%", my_cg.cp_A_value.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("cp_B_value: %.2f%%", my_cg.cp_B_value.get_coverage()), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("cp_and_result: %.2f%%", my_cg.cp_and_result.get_coverage()), UVM_LOW);
		`uvm_info(get_type_name(), $sformatf("cp_or_result: %.2f%%", my_cg.cp_or_result.get_coverage()), UVM_LOW);
		`uvm_info(get_type_name(), $sformatf("cp_mult_result: %.2f%%", my_cg.cp_mult_result.get_coverage()), UVM_LOW);
		`uvm_info(get_type_name(), $sformatf("cp_add_result: %.2f%%", my_cg.cp_add_result.get_coverage()), UVM_LOW);
    endfunction

endclass
`endif
