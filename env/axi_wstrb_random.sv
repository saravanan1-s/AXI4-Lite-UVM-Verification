class axi_wstrb_seq extends uvm_sequence #(axi_transaction);

  `uvm_object_utils(axi_wstrb_seq)

  axi_transaction transaction_h;
  axi_transaction read_transaction_h;

  function new(string name = "axi_wstrb_seq");
    super.new(name);
  endfunction

  task body();
    repeat(5) begin

      transaction_h = axi_transaction::type_id::create("transaction_h");
      start_item(transaction_h);
      if (!transaction_h.randomize() with {write == 1;})
        `uvm_error("SEQ", "Write randomization failed")

      finish_item(transaction_h);

      transaction_h.print();
           
      read_transaction_h =axi_transaction::type_id::create("read_transaction_h");

      start_item(read_transaction_h);

      if (!read_transaction_h.randomize() with {write  == 0;araddr == transaction_h.awaddr;})
        `uvm_error("SEQ", "Read randomization failed")
      finish_item(read_transaction_h);
      read_transaction_h.print();
    end
 endtask : body
endclass : axi_wstrb_seq
