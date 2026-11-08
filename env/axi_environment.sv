class axi_env extends uvm_env;
  `uvm_component_utils(axi_env)
  axi_agent agt;
  axi_scoreboard sco;
  axi_coverage cov;
  
  function new(string name="axi_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction  : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt=axi_agent::type_id::create("agt",this);
    sco=axi_scoreboard::type_id::create("sco",this);
    cov=axi_coverage::type_id::create("cov",this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.mon_ap.connect(sco.sco_imp);
    agt.mon.mon_ap.connect(cov.analysis_export);
  endfunction : connect_phase

endclass : axi_env


