`include "uvm_macros.svh"
import uvm_pkg::*;
import axi_package::*;
module tb_top;

  bit aclk;
  axi_intf vif(aclk);
  
  axi4_lite_slave#(12,32) dut(.aclk(aclk),.aresetn(vif.aresetn),.awaddr(vif.awaddr),.awvalid(vif.awvalid),.awready(vif.awready),.wdata(vif.wdata),.wstrb(vif.wstrb),.wvalid(vif.wvalid),.wready(vif.wready),.bresp(vif.bresp),.bvalid(vif.bvalid),.bready(vif.bready),.araddr(vif.araddr),.arvalid(vif.arvalid),.arready(vif.arready),.rdata(vif.rdata),.rresp(vif.rresp),.rvalid(vif.rvalid),.rready(vif.rready));
  
    
  initial
    forever #5 aclk= ~aclk;
  initial begin
    uvm_config_db#(virtual axi_intf)::set(null,"*","vif",vif);
    run_test("axi_test");
  end
    
endmodule
