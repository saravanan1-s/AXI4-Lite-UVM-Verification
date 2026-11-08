class axi_agent extends uvm_agent;
  `uvm_component_utils(axi_agent)
  axi_seqr seqr_h;
  axi_driver drv;
  axi_monitor mon;
  function new(string name="axi_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr_h=axi_seqr::type_id::create("seqr",this);
    drv=axi_driver::type_id::create("drv",this);
    mon=axi_monitor::type_id::create("mon",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction
  
endclass

