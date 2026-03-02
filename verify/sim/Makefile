#!/bin/sh

VERB= UVM_LOW
SEED ?= $(shell date +%s)
TEST ?= base_test
NUM ?= 100 

TB = top_tb

COVERAGE_DIR = coverage
MERGECOV = mergecov 
MERGED_COVERAGE_UCDB = merged_coverage.ucdb

all:comp run

comp:clean
	vcs -full64 -sverilog -fsdb -debug_access+all -lca -kdb \
	-cm line+cond+fsm -cm_dir ${COVERAGE_DIR}/${TEST}_${SEED} \
	+nospecify  \
	+UVM_VERBOSITY=UVM_DEBUG \
	${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
	-timescale=1ns/1ps \
	-f ${WORK_HOME}/verify/tb/filelist.f \
	-l sim.log \

$(COVERAGE_DIR):
	mkdir -p ${COVERAGE_DIR}

run: $(COVERAGE_DIR)
	./simv \
	+UVM_VERBOSITY=${VERB} \
	+ntb_random_seed=${SEED} \
	+UVM_TESTNAME=${TEST} \
	+UVM_NO_RELNOTES \
	-cm line+cond+fsm -cm_count \
	-l ./${TEST}.log -coverage \
	+seq_repeat_cnt=${NUM}

verdi:
	verdi \
	-sv \
	-uvm \
	-f ${WORK_HOME}/verify/tb/filelist.f \
	-top ${TB} \
	-nologo \
	-ssf sim.fsdb &

cov:
	urg -full64 -format both -report coverage -dir ${COVERAGE_DIR}/*.vdb \
	-dbname merged.vdb 
	urg -full64 -dir merged.vdb -format text -report coverage_summary
	urg -full64 -dir merged.vdb -report coverage_html 
	firefox ./coverage_html/dashboard.html &
	#dve -full64 -cov -covdir merged.vdb


clean:
	rm -rf *.log *.dat *.fsdb *.key *.h *.txt *.vdb ${COVERAGE_DIR} csrc ${LOG_DIR} simv.daidir coverage_summary coverage_html \
	simv DVEfiles verdiLog *.conf *.rc vdCovLog simv.cst



