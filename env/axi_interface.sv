interface axi_intf(input bit aclk);
  parameter ADDR_WIDTH=12,DATA_WIDTH=32;
  // Write Address Channel
  logic aresetn;
  logic [ADDR_WIDTH-1:0]awaddr;
  logic awvalid;
  logic awready;
    
  // Write Data Channel
  logic [DATA_WIDTH-1:0]wdata;
  logic [(DATA_WIDTH/8)-1:0]wstrb;
  logic wvalid;
  logic wready;
    
  // Write Response Channel
  logic [1:0]bresp;
  logic bvalid;
  logic bready;
    
  // Read Address Channel
  logic [ADDR_WIDTH-1:0]araddr;
  logic arvalid;
  logic arready;
    
  // Read Data Channel
  bit [DATA_WIDTH-1:0]rdata;
  logic [1:0] rresp;
  logic rvalid;
  logic rready;
  
  clocking drv_cb @(posedge aclk);
    
    output aresetn;
    
    output awaddr;
    output awvalid;
    input awready;
    
    output wdata;
    output wstrb;
    output wvalid;
    input wready;
    
    output bready;
    input bresp;
    input bvalid;
    
    output araddr;
    output arvalid;
    input arready;
    
    input rvalid;
    input rdata;
    input rresp;
    output rready;
    
  endclocking : drv_cb
  
  clocking mon_cb @(posedge aclk);
    
    input awaddr;
    input awvalid;
    input awready;
    
    input wdata;
    input wstrb;
    input wvalid;
    input wready;
    
    input bready;
    input bresp;
    input bvalid;
    
    input araddr;
    input arvalid;
    input arready;
    
    input rdata;
    input rvalid;
    input rready;
    input rresp;
    
  endclocking : mon_cb
  
endinterface : axi_intf
