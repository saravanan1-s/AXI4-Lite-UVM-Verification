class axi_transaction extends uvm_sequence_item;
  parameter ADDR_WIDTH=12,DATA_WIDTH=32;
  
  rand bit write;
  
  bit awvalid;
  bit awready;
  rand bit[ADDR_WIDTH-1:0] awaddr;  
  
  bit wvalid;
  bit wready;
  rand bit [(DATA_WIDTH/8)-1:0]wstrb;
  rand bit[DATA_WIDTH-1:0] wdata;
  
  bit [1:0]bresp;
  bit bvalid;
  bit bready;
  
  rand bit [ADDR_WIDTH-1:0]araddr;
  bit arvalid;
  bit arready;
  
  bit [DATA_WIDTH-1:0]rdata;
  bit [1:0] rresp;
  bit rvalid;
  bit rready;
  
  `uvm_object_utils_begin(axi_transaction)
  `uvm_field_int(awaddr,UVM_ALL_ON)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(wstrb,UVM_ALL_ON)
  `uvm_field_int(araddr,UVM_ALL_ON)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_field_int(rresp,UVM_ALL_ON)
  `uvm_field_int(bresp,UVM_ALL_ON)
  `uvm_field_int(write,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="axi_transaction");
    super.new(name);
  endfunction

  
  constraint c1 {
    if(write){
    soft awaddr inside {[0:4095]};
    soft awaddr % 4 == 0;
    
    } 
  }
   constraint c2{
     if(!write){  
       soft araddr inside {[0:4095]};
       soft araddr % 4 == 0;}
  }
  constraint c3{
    soft wstrb inside {[4'b0000:4'b1111]};
  }
       constraint c4{
         wdata inside {'hAAAA_AAAA,'h5555_5555,'hAAAA_5555,'h5555_AAAA,'hA5A5_A5A5,'h5A5A_5A5A,'hFFFF_FFFF}; 
       }
endclass :axi_transaction


