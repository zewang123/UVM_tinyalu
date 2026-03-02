#UVM SOURCE
+incdir+$UVM_HOME/src
$UVM_HOME/src/uvm_pkg.sv

#RTL /home/host/DV/tinyalu
$WORK_HOME/rtl/tinyalu.sv
$WORK_HOME/rtl/three_cycle_mult.sv
$WORK_HOME/rtl/single_cycle_add_and_xor.sv

#TB
+incdir+$WORK_HOME/verify 
+incdir+$WORK_HOME/verify/drv
+incdir+$WORK_HOME/verify/env
+incdir+$WORK_HOME/verify/tb
+incdir+$WORK_HOME/verify/seq
+incdir+$WORK_HOME/verify/if
+incdir+$WORK_HOME/verify/trans
+incdir+$WORK_HOME/verify/mon
+incdir+$WORK_HOME/verify/agent
+incdir+$WORK_HOME/verify/model
+incdir+$WORK_HOME/verify/scb
+incdir+$WORK_HOME/verify/sqr
+incdir+$WORK_HOME/verify/base
+incdir+$WORK_HOME/verify/fcov
$WORK_HOME/verify/tb/top_tb.sv
