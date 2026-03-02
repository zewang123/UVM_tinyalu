`ifndef MY_COVERAGE__SV
`define MY_COVERAGE__SV
`include "my_transaction.sv"


`ifdef ENABLE_MY_COVERAGE
class my_coverage extends uvm_subscriber #(my_transaction);
    `uvm_component_utils(my_coverage)


    covergroup my_cg with function sample(my_transaction tr);
        option.per_instance = 1;
        option.goal = 100;
        option.comment = "TinyALU功能覆盖率（基于my_transaction）";

 
        cp_op_type: coverpoint tr.op {
            bins OP_ADD  = {3'b001};
            bins OP_AND  = {3'b010};
            bins OP_XOR  = {3'b011};
            bins OP_MULT = {[3'b100:3'b111]};
            bins OP_IDLE = {3'b000};
            bins all_ops[] = {OP_ADD, OP_AND, OP_XOR, OP_MULT, OP_IDLE};
        }

 
        cp_A_value: coverpoint tr.A {
            bins zero     = {8'h00};
            bins max      = {8'hFF};
            bins low      = {[8'h01:8'h3F]};
            bins mid      = {[8'h40:8'h7F]};
            bins high     = {[8'h80:8'hBF]};
            bins ultra_high = {[8'hC0:8'hFE]};
        }


        cp_B_value: coverpoint tr.B {
            bins zero     = {8'h00};
            bins max      = {8'hFF};
            bins low      = {[8'h01:8'h3F]};
            bins mid      = {[8'h40:8'h7F]};
            bins high     = {[8'h80:8'hBF]};
            bins ultra_high = {[8'hC0:8'hFE]};
        }


        op_x_A: cross cp_op_type, cp_A_value {
            ignore_bins idle_A = binsof(cp_op_type.OP_IDLE);
        }

  
        op_x_B: cross cp_op_type, cp_B_value {
            ignore_bins idle_B = binsof(cp_op_type.OP_IDLE);
        }

        cp_mult_result: coverpoint tr.result iff (tr.op inside {[3'b100:3'b111]}) {
            bins small  = {[0:8'h00FF]};
            bins medium = {[8'h0100:8'hFFFF]};
            bins large  = {[8'h10000:8'hFFFF_FFFF]};
        }


        cp_add_result: coverpoint tr.result iff (tr.op == 3'b001) {
            bins no_carry = {[0:8'h00FF]};
            bins carry    = {[8'h0100:8'h01FE]};
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




endclass
`else  
class my_coverage extends uvm_component;
    `uvm_component_utils(my_coverage)

    function new(string name = "my_coverage", uvm_component parent = null);
        super.new(name, parent);
    endfunction


    virtual function void write(my_transaction t);
        `uvm_info("MY_COVERAGE", "Coverage is disabled", UVM_DEBUG);
    endfunction


    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Coverage collection is disabled", UVM_MEDIUM);
    endfunction
endclass
`endif  // ENABLE_MY_COVERAGE

`endif  // MY_COVERAGE__SV
