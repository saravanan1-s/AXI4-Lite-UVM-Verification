class slverr_rd_seq extends uvm_sequence#(axi_transaction);
  `uvm_object_utils(slverr_rd_seq)
  axi_transaction tr;
  function new(string name="slverr_rd_seq");
    super.new(name);
  endfunction
  task body();
    repeat(5)begin
      tr=axi_transaction::type_id::create("tr");
      start_item(tr);
      if(!(tr.randomize()with{write==0;araddr%4!=0;}))
        `uvm_error("SLVERR READ","Randomization Failed")
        `uvm_info("SLVERR READ",$sformatf("tr.araddr=%0h,tr.rdata=%0h",tr.araddr,tr.rdata),0)
      finish_item(tr);
    end
  endtask :body
endclass : slverr_rd_seq

