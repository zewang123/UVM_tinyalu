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
$WORK_HOME/verify/tb/top_tb.sv
$WORK_HOME/verify/if/my_if.sv
$WORK_HOME/verify/drv/my_driver.sv
$WORK_HOME/verify/trans/my_transaction.sv
$WORK_HOME/verify/env/my_env.sv
$WORK_HOME/verify/mon/my_monitor.sv
$WORK_HOME/verify/agent/my_agent.sv
$WORK_HOME/verify/model/my_model.sv
$WORK_HOME/verify/scb/my_scoreboard.sv

