class axi_driver extends uvm_driver#(axi_transaction);
  `uvm_component_utils(axi_driver)
  virtual axi_intf vif;
  axi_transaction tr;
  
  function new(string name="axi_driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi_intf)::get(this,"","vif",vif))
      `uvm_error("DRV","interface not found")
  endfunction : build_phase
  task initial_reset();
    
    vif.drv_cb.aresetn<=0;
    
    vif.drv_cb.awvalid<=0;
    vif.drv_cb.wvalid<=0;
    vif.drv_cb.arvalid<=0;
    vif.drv_cb.bready<=0;
    vif.drv_cb.rready<=0;
    repeat(2)
      @(vif.drv_cb);
    
    vif.drv_cb.aresetn <= 1;
    
  endtask : initial_reset
  task  run_phase(uvm_phase phase);
    initial_reset();
    forever begin
      seq_item_port.get_next_item(tr);
      `uvm_info("DRV",
      "Transaction received from sequencer",
      UVM_LOW)

      tr.print();

      if(tr.write)
        write_transfer();
      else
        read_transfer();
      seq_item_port.item_done();
    end
  endtask : run_phase
    
  task write_transfer();
    
    vif.drv_cb.awvalid<=1'b1;
    vif.drv_cb.awaddr<=tr.awaddr;
    
    while(!vif.drv_cb.awready)
      @(vif.drv_cb);
    
    vif.drv_cb.awvalid<=1'b0;
    
    vif.drv_cb.wvalid<=1'b1;
    vif.drv_cb.wdata<=tr.wdata;
    vif.drv_cb.wstrb<=tr.wstrb;
    
     while(!vif.drv_cb.wready)
      @(vif.drv_cb);
    
    vif.drv_cb.wvalid<=1'b0;
    
    vif.drv_cb.bready<=1'b1;
    
    while(!vif.drv_cb.bvalid)
      @(vif.drv_cb);
    
    tr.bresp=vif.drv_cb.bresp;

    vif.drv_cb.bready<=0;
    tr.print();
  endtask : write_transfer
 
  task read_transfer();
    
    vif.drv_cb.arvalid<=1'b1;
    vif.drv_cb.araddr<=tr.araddr;
    
    while(!vif.drv_cb.arready)
      @(vif.drv_cb);    
    vif.drv_cb.arvalid<=1'b0;
    
    vif.drv_cb.rready<=1'b1;
   
  while(!vif.drv_cb.rvalid)
      @(vif.drv_cb);  
    
    tr.rdata=vif.drv_cb.rdata;
    tr.rresp=vif.drv_cb.rresp;
    
    vif.drv_cb.rready<=1'b0;
    
  endtask : read_transfer

endclass : axi_driver


