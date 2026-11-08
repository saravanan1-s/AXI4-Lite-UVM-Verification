class axi_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(axi_scoreboard)

  uvm_analysis_imp #(axi_transaction,axi_scoreboard) sco_imp;  
  bit [31:0] mem[bit [11:0]];

  function new(string name="axi_scoreboard",uvm_component parent=null);
    super.new(name,parent);
  endfunction


  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    sco_imp = new("sco_imp",this);

  endfunction


  function void write(input axi_transaction tr);

    if (tr.write) begin
      
      if (!mem.exists(tr.awaddr))
        mem[tr.awaddr] = 32'h00000000;


      // WSTRB[0] -> byte 0
      if (tr.wstrb[0])
        mem[tr.awaddr][7:0] = tr.wdata[7:0];


      // WSTRB[1] -> byte 1
      if (tr.wstrb[1])
        mem[tr.awaddr][15:8] = tr.wdata[15:8];


      // WSTRB[2] -> byte 2
      if (tr.wstrb[2])
        mem[tr.awaddr][23:16] = tr.wdata[23:16];


      // WSTRB[3] -> byte 3
      if (tr.wstrb[3])
        mem[tr.awaddr][31:24] = tr.wdata[31:24];


      `uvm_info("WRITE PASS",$sformatf("ADDR=%0h WDATA=%0h WSTRB=%0b EXPECTED_MEM=%0h",     tr.awaddr,tr.wdata,tr.wstrb,mem[tr.awaddr]),UVM_NONE)

    end
    else begin

      if (mem.exists(tr.araddr)) begin

        if (tr.rdata == mem[tr.araddr]) begin

          `uvm_info("READ PASS",$sformatf("ADDR=%0h RDATA=%0h EXPECTED=%0h",tr.araddr,      tr.rdata,mem[tr.araddr]),UVM_NONE)
        end

        else begin

          `uvm_error("READ FAIL",$sformatf("ADDR=%0h RDATA=%0h EXPECTED=%0h",tr.araddr,     tr.rdata,mem[tr.araddr]))
        end

      end

      else begin

        `uvm_warning("SCOREBOARD",$sformatf("READ address %0h was never written",           tr.araddr))
      end
    end

  endfunction

endclass
