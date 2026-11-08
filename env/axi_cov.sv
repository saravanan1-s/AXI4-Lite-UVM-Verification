 class axi_coverage extends uvm_subscriber#(axi_transaction);
   `uvm_component_utils(axi_coverage)
    function new(string name="axi_coverage",uvm_component parent=null);
    super.new(name,parent);
    coverage_cg=new();
  endfunction : new
   
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  covergroup coverage_cg with function sample(axi_transaction tr);
    option.per_instance = 1;
    cp1 : coverpoint tr.write{
      
      bins write={1};
      bins read={0};
    }
     cp2 : coverpoint tr.awaddr{
       bins awaddr_low={[0:255]};
       bins awaddr_mid={[256:1024]};
       bins awaddr_high={[1024:4095]};
     }
    /*cp2 : coverpoint tr.awaddr{
      bins  awaddr={[0:4095]};
    }*/
    cp3 : coverpoint tr.wdata{
      bins wdata={[32'h00000000:32'hFFFFFFFF]};
    }
    cp4 : coverpoint tr.awvalid{
      bins awvalid_low={0};
      bins awvalid_high={1};
    }
    cp5 : coverpoint tr.awready{
      bins awready_low={0};
      bins awready_high={1};
    }
    cp6 : coverpoint tr.wvalid{
      bins wvalid_low={0};
      bins wvalid_high={1};
    }
    cp7 : coverpoint tr.wready{
      bins wready_low={0};
      bins wready_high={1};
    }
    cp8 : coverpoint tr.bvalid{
      bins bvalid_low={0};
      bins bvalid_high={1};
    }
    cp9 : coverpoint tr.bready{
      bins bready_low={0};
      bins bready_high={1};
    }
    cp10 : coverpoint tr.bresp{
      bins ok_resp={2'b00};
      ignore_bins EXok_bresp={2'b01};  //NOT USED  IN AXI4LITE
      bins slvr_bresp={2'b10};
      ignore_bins decerr_bresp={2'b11}; //NOT USED  IN GIVEN DESIGN
    }
    cp11 : coverpoint tr.arready{
      bins arready_low={0};
      bins arready_high={1};
    }
    cp12 : coverpoint tr.arvalid{
      bins arvalid_low={0};
      bins arvalid_high={1};
    }
     cp13 : coverpoint tr.araddr{
           bins araddr_low={[0:255]};
           bins araddr_mid={[256:1024]};
           bins araddr_high={[1024:4095]};
     }
     /*cp13 : coverpoint tr.araddr{
      bins  araddr={[0:4095]};
    }*/
    cp14 : coverpoint tr.rvalid{
      bins rvalid_low={0};
      bins rready_high={1};
    }      
    cp15 : coverpoint tr.rready{
      bins rready_low={0};
      bins rready_high={1};
    }
    cp16 : coverpoint tr.rdata{
      bins rdata={[32'h00000000:32'hFFFFFFFF]};
    }
    cp17 : coverpoint tr.rresp{
      bins ok_rresp={2'b00};
      ignore_bins EXok_rresp={2'b01};  //NOT USED  IN AXI4LITE
      bins slvr_rresp={2'b10};
      ignore_bins decerr_rresp={2'b11};  //NOT USED  IN GIVEN DESIGN
    }
    cp18 : coverpoint tr.wstrb{
      bins byte0={4'b0001};
      bins byte1={4'b0010};
      bins byte2={4'b0100};
      bins byte3={4'b1000};
      bins byte_full={4'b1111};
    }
  endgroup : coverage_cg
  
  function void write(axi_transaction t);
    coverage_cg.sample(t);
  endfunction : write

  function void report_phase(uvm_phase phase);

  super.report_phase(phase);

  
    `uvm_info("COVERAGE",$sformatf("TOTAL COVERAGE = %0.2f%%",      coverage_cg.get_inst_coverage()),UVM_NONE)

    `uvm_info("COVERAGE",$sformatf("WRITE/READ COVERAGE = %0.2f%%",  coverage_cg.cp1.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("AWADDR COVERAGE = %0.2f%%",  coverage_cg.cp2.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("WDATA COVERAGE = %0.2f%%",      coverage_cg.cp3.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("AWVALID COVERAGE = %0.2f%%",    coverage_cg.cp4.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("AWREADY COVERAGE = %0.2f%%",    coverage_cg.cp5.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf(" WVALID COVERAGE = %0.2f%%",    coverage_cg.cp6.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("WREADY COVERAGE = %0.2f%%",      coverage_cg.cp7.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("BVALID COVERAGE = %0.2f%%",      coverage_cg.cp8.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("BREADY COVERAGE = %0.2f%%",      coverage_cg.cp9.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("BRESP COVERAGE = %0.2f%%",      coverage_cg.cp10.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("ARREADY COVERAGE = %0.2f%%",    coverage_cg.cp11.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("ARVALID COVERAGE = %0.2f%%",    coverage_cg.cp12.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("ARADDR COVERAGE = %0.2f%%",  coverage_cg.cp13.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("RVALID COVERAGE = %0.2f%%",      coverage_cg.cp14.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("RREADY COVERAGE = %0.2f%%",      coverage_cg.cp15.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("RDATA COVERAGE = %0.2f%%",      coverage_cg.cp16.get_inst_coverage()),UVM_NONE)

    `uvm_info("COVERAGE",$sformatf("RRESP COVERAGE = %0.2f%%",      coverage_cg.cp17.get_inst_coverage()),UVM_NONE)
    
    `uvm_info("COVERAGE",$sformatf("WSTRB COVERAGE = %0.2f%%",      coverage_cg.cp18.get_inst_coverage()),UVM_NONE)

endfunction : report_phase

endclass : axi_coverage

