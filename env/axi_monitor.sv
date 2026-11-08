class axi_monitor extends uvm_monitor;
  `uvm_component_utils(axi_monitor)
  uvm_analysis_port#(axi_transaction)mon_ap;
  axi_transaction tr;
  virtual axi_intf  vif;
  function new(string name="axi_monitor",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap=new("mon_ap",this);
    if(!uvm_config_db#(virtual axi_intf)::get(this,"","vif",vif))
      `uvm_error("MON","INTERFCE NOT FOUND")
  endfunction :build_phase
  task run_phase(uvm_phase phase);
    forever begin
      @(vif.mon_cb);
      if(vif.mon_cb.awvalid && vif.mon_cb.awready)
        mon_write();
      else if(vif.mon_cb.arvalid && vif.mon_cb.arready)
        mon_read();
    end
  endtask : run_phase
    
  task mon_write();
    
    tr=axi_transaction::type_id::create("tr");
    
    tr.write=1;
    tr.awaddr=vif.mon_cb.awaddr;
    tr.awvalid=vif.mon_cb.awvalid;
    tr.awready=vif.mon_cb.awready;
    
    while(!(vif.mon_cb.wvalid && vif.mon_cb.wready))
      @(vif.mon_cb);
    tr.wvalid=vif.mon_cb.wvalid;
    tr.wready=vif.mon_cb.wready;
    tr.wdata=vif.mon_cb.wdata;
    tr.wstrb=vif.mon_cb.wstrb;
    
    while(!(vif.mon_cb.bvalid && vif.mon_cb.bready))
      @(vif.mon_cb);
    tr.bvalid=vif.mon_cb.bvalid;
    tr.bready=vif.mon_cb.bready;
    tr.bresp=vif.mon_cb.bresp;
    
    `uvm_info("MON",$sformatf("WRITE: AWADDR=%0h WDATA=%0h WSTRB=%0h BRESP=%0h",tr.awaddr,tr.wdata,tr.wstrb,tr.bresp),UVM_LOW)
    tr.print();
    mon_ap.write(tr);
  endtask : mon_write

    task mon_read();
      tr=axi_transaction::type_id::create("tr");
      tr.write=0;
      tr.araddr=vif.mon_cb.araddr;
      tr.arvalid=vif.mon_cb.arvalid;
      tr.arready=vif.mon_cb.arready;
      while(!(vif.mon_cb.rvalid&&vif.mon_cb.rready))
        @(vif.mon_cb);
      tr.rvalid=vif.mon_cb.rvalid;
      tr.rready=vif.mon_cb.rready;
      tr.rdata=vif.mon_cb.rdata;
      tr.rresp=vif.mon_cb.rresp;
      `uvm_info("MON",$sformatf("READ: ARADDR=%0h RDATA=%0h RRESP=%0h",      tr.araddr,tr.rdata,tr.rresp),UVM_LOW)
    tr.print();
    mon_ap.write(tr);

  endtask : mon_read

endclass

