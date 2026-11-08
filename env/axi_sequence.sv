class axi_wr_seq extends uvm_sequence #(axi_transaction);

  `uvm_object_utils(axi_wr_seq)

  axi_transaction transaction_h;
  axi_transaction read_transaction_h;

  function new(string name = "axi_wr_seq");
    super.new(name);
  endfunction

  task body();
    repeat(5) begin

      transaction_h = axi_transaction::type_id::create("transaction_h");
      start_item(transaction_h);
      if (!transaction_h.randomize() with {write == 1;wstrb==4'b1111;})
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
endclass : axi_wr_seq

// class seq extends uvm_sequence #(transaction);

//   `uvm_object_utils(seq)

//   transaction tr;

//   bit [11:0] write_addr [5];
//   bit [31:0] write_data [5];

//   function new(string name="seq");
//     super.new(name);
//   endfunction

//   task body();

//     int i;

//     //========================
//     // 5 WRITE TRANSACTIONS
//     //========================
//     i = 0;

//     repeat(5) begin

//       tr = transaction::type_id::create("tr");

//       start_item(tr);

//       if (!tr.randomize() with {
//         write == 1;
//       })
//         `uvm_error("SEQ", "Write randomization failed")

//       // Save write address and data
//       write_addr[i] = tr.awaddr;
//       write_data[i] = tr.wdata;

//       finish_item(tr);

//       `uvm_info("SEQ",
//         $sformatf("WRITE[%0d] ADDR=%0h DATA=%0h",
//                   i, tr.awaddr, tr.wdata),
//         UVM_LOW)

//       tr.print();

//       i++;

//     end


//     //========================
//     // 5 READ TRANSACTIONS
//     //========================
//     i = 0;

//     repeat(5) begin

//       tr = transaction::type_id::create("tr");

//       start_item(tr);

//       if (!tr.randomize() with {
//         write  == 0;
//         araddr == write_addr[i];
//       })
//         `uvm_error("SEQ", "Read randomization failed")

//       finish_item(tr);

//       `uvm_info("SEQ",
//         $sformatf("READ[%0d] ADDR=%0h EXPECTED=%0h ACTUAL=%0h",
//                   i, tr.araddr, write_data[i], tr.rdata),
//         UVM_LOW)

//       tr.print();

//       i++;

//     end

//   endtask

// endclass

