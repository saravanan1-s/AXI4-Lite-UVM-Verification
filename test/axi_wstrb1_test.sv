class axi_wstrb1_seq_test extends uvm_test;
  `uvm_component_utils(axi_wstrb1_seq_test)
axi_env env_h;
axi_wstrb1_seq seq_h;
 function new(string name="axi_wstrb1_seq_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
   env_h=axi_env::type_id::create("env_h",this);
endfunction
task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   seq_h=axi_wstrb1_seq::type_id::create("seq_h");
   seq_h.start(env_h.agt.seqr_h);
   phase.drop_objection(this);
endtask
endclass
