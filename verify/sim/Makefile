#!/bin/sh

VERB=UVM_LOW
SEED ?= $(shell date +%s)
TEST ?=tinyalu

TB=top_tb

COVERAGE_DIR = coverage
MERGECOV = mergecov 
MERGED_COVERAGE_UCDB = merged_coverage.ucdb

all:comp run

comp:clean
	vcs -full64 -sverilog -fsdb -debug_access+all -lca -kdb \
	+nospecify  \
	+UVM_VERBOSITY=UVM_DEBUG \
	${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
	-timescale=1ns/1ps \
	-f ${WORK_HOME}/verify/tb/filelist.f \
	-l sim.log \

run: 
	./simv \
	+UVM_VERBOSITY=${VERB} \
	+ntb_random_seed=${SEED} \
	+UVM_NO_RELNOTES
verdi:
	verdi \
	-sv \
	-uvm \
	-f ${WORK_HOME}/verify/tb/filelist.f \
	-top ${TB} \
	-nologo \
	-ssf sim.fsdb &

clean:
	rm -rf *.log *.dat *.fsdb *.key *.h ${COVERAGE_DIR} csrc ${LOG_DIR} simv.daidir \
	simv DVEfiles verdiLog *.conf *.rc

run_uvm:clean
	vcs -sverilog ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -timescale=1ns/1ps -f ${WORK_HOME}/verify/tb/filelist.f 
	./simv 
