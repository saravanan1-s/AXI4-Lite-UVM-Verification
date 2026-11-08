RTL=../rtl/design.sv #<enter design file name(.sv|.v file)>
INF=../env/axi_interface.sv
PKG=../test/axi_package.sv
TOP=../top/axi_top.sv
INC=+incdir+../test/ +incdir+../env/ +incdir+../top/

COM=vcs -full64 -sverilog -ntb_opts uvm-1.2 -kdb -debug_access+all ${RTL} ${INF} ${PKG} ${TOP} ${INC} #${FILES}
compile:
	${COM}

RUN=vcs -R -full64 -sverilog -ntb_opts uvm-1.2 -kdb -debug_access+all ${RTL} ${INF} ${PKG} ${TOP} ${INC}
run:
	${RUN}
tc1:
	${RUN} -cm_dir $(TEST1)_coverage.vdb +UVM_TESTNAME=$(TEST1) -l $(TEST1).log; urg -dir $(TEST1)_coverage.vdb -report $(TEST1)_report
TEST1=axi_wr_seq_test
tc2:
	${RUN} -cm_dir $(TEST2)_coverage.vdb +UVM_TESTNAME=$(TEST2) -l $(TEST2).log; urg -dir $(TEST2)_coverage.vdb -report $(TEST2)_report
TEST2=axi_slverr_read_test
tc3:
	${RUN} -cm_dir $(TEST3)_coverage.vdb +UVM_TESTNAME=$(TEST3) -l $(TEST3).log; urg -dir $(TEST3)_coverage.vdb -report $(TEST3)_report
TEST3=axi_slverr_write_test
tc4:
	${RUN} -cm_dir $(TEST4)_coverage.vdb +UVM_TESTNAME=$(TEST4) -l $(TEST4).log; urg -dir $(TEST4)_coverage.vdb -report $(TEST4)_report
TEST4=axi_wstrb0_seq_test
tc5:
	${RUN} -cm_dir $(TEST5)_coverage.vdb +UVM_TESTNAME=$(TEST5) -l $(TEST5).log; urg -dir $(TEST5)_coverage.vdb -report $(TEST5)_report
TEST5=axi_wstrb1_seq_test
tc6:
	${RUN} -cm_dir $(TEST6)_coverage.vdb +UVM_TESTNAME=$(TEST6) -l $(TEST6).log; urg -dir $(TEST6)_coverage.vdb -report $(TEST6)_report
TEST6=axi_wstrb2_seq_test

tc7:
	${RUN} -cm_dir $(TEST7)_coverage.vdb +UVM_TESTNAME=$(TEST7) -l $(TEST7).log; urg -dir $(TEST7)_coverage.vdb -report $(TEST7)_report
TEST7=axi_wstrb3_seq_test
tc8:
	${RUN} -cm_dir $(TEST8)_coverage.vdb +UVM_TESTNAME=$(TEST8) -l $(TEST8).log; urg -dir $(TEST8)_coverage.vdb -report $(TEST8)_report
TEST8=axi_wstrb_seq_test

tc: tc1 tc2 tc3 tc4 tc5 tc6 tc7 tc8 
merge:
	urg -dir $(TEST1)_coverage.vdb $(TEST2)_coverage.vdb $(TEST3)_coverage.vdb $(TEST4)_coverage.vdb $(TEST5)_coverage.vdb $(TEST6)_coverage.vdb $(TEST7)_coverage.vdb $(TEST8)_coverage.vdb -format both -report merged_report -dbname merged.vdb
cov:
	verdi -cov -covdir ./merged.vdb &

report:
	firefox merged/dashboard.html&
regression: tc merge reporrt
clean:
	rm -rf csrc simv.daidir ucli.key simv *.vcd *.dump *.vdb *_report *_test nova* v*

final: merge report
help:

