class slverr_wr_seq extends uvm_sequence#(axi_transaction);
  `uvm_object_utils(slverr_wr_seq)
  axi_transaction tr;
  function new(string name="slverr_wr_seq");
    super.new(name);
  endfunction
  task body();
    repeat(5)begin
      tr=axi_transaction::type_id::create("tr");
      start_item(tr);
      if(!(tr.randomize()with{write==1;awaddr%4!=0;}))
        `uvm_error("SLVERR WRITE","Randomization Failed")
        `uvm_info("SLVERR WRITE",$sformatf("tr.awaddr=%0h,tr.wdata=%0h",tr.awaddr,tr.wdata),0)
      finish_item(tr);
    end
  endtask : body
endclass : slverr_wr_seq

