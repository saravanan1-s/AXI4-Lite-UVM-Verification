class axi_seqr extends uvm_sequencer#(axi_transaction);
  `uvm_component_utils(axi_seqr)
  function new(string name="axi_seqr",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
endclass
