class axi_test extends uvm_test;
  `uvm_component_utils(axi_test)
  string seq_name;
  axi_env env_h;
  axi_wr_seq seq_h;
  slverr_wr_seq slverr_wr;
  slverr_rd_seq slverr_rd;
  axi_wstrb0_seq axi_wstrb0_seq_h;
  axi_wstrb1_seq axi_wstrb1_seq_h;
  axi_wstrb2_seq axi_wstrb2_seq_h;
  axi_wstrb3_seq axi_wstrb3_seq_h;
  axi_wstrb_seq axi_wstrb_seq_h;

  function new(string name="axi_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
    env_h=axi_env::type_id::create("env_h",this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    //if(!($value$plusargs("SEQ=%s",seq_name)))
    if(!($value$plusargs("SEQ=%s",seq_name)))
      seq_name="ALL";
    if(seq_name=="WR")begin
      seq_h=axi_wr_seq::type_id::create("seq_h");
      seq_h.start(env_h.agt.seqr_h);
    end

    else if(seq_name=="SLVERR_WT")begin
      slverr_wr=slverr_wr_seq::type_id::create("slverr_wr");
      slverr_wr.start(env_h.agt.seqr_h);
    end

    else if(seq_name=="SLVERR_RD")begin
      slverr_rd=slverr_rd_seq::type_id::create("slverr_rd");
      slverr_rd.start(env_h.agt.seqr_h);
    end

    else if(seq_name=="WSTRB0")begin
      axi_wstrb0_seq_h=axi_wstrb0_seq::type_id::create("axi_wstrb0_seq_h");
      axi_wstrb0_seq_h.start(env_h.agt.seqr_h);
    end

    else if(seq_name=="WSTRB1")begin
      axi_wstrb1_seq_h=axi_wstrb1_seq::type_id::create("axi_wstrb1_seq_h");
      axi_wstrb1_seq_h.start(env_h.agt.seqr_h);
    end
    
    else if(seq_name=="WSTRB2")begin
      axi_wstrb2_seq_h=axi_wstrb2_seq::type_id::create("axi_wstrb2_seq_h");
      axi_wstrb2_seq_h.start(env_h.agt.seqr_h);
    end
    
    else if(seq_name=="WSTRB3")begin
      axi_wstrb3_seq_h=axi_wstrb3_seq::type_id::create("axi_wstrb3_seq_h");
      axi_wstrb3_seq_h.start(env_h.agt.seqr_h);
    end
    
    else if(seq_name=="WSTRB")begin
      axi_wstrb_seq_h=axi_wstrb_seq::type_id::create("axi_wstrb_seq_h");
      axi_wstrb_seq_h.start(env_h.agt.seqr_h);
    end


    else if(seq_name=="ALL")begin
      `uvm_info("TEST","***********************WRITE_READ TEST************************",0)
      seq_h=axi_wr_seq::type_id::create("seq_h");
      seq_h.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************SLVERR_WRITE TEST************************",0)


      slverr_wr=slverr_wr_seq::type_id::create("slverr_wr");
      slverr_wr.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************SLVERR_READ TEST************************",0)

      
      slverr_rd=slverr_rd_seq::type_id::create("slverr_rd");
      slverr_rd.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************WSTRB0 TEST************************",0)


      axi_wstrb0_seq_h=axi_wstrb0_seq::type_id::create("axi_wstrb0_seq_h");
      axi_wstrb0_seq_h.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************WSTRB1 TEST************************",0)


      axi_wstrb1_seq_h=axi_wstrb1_seq::type_id::create("axi_wstrb1_seq_h");
      axi_wstrb1_seq_h.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************WSTRB2 TEST************************",0)


      axi_wstrb2_seq_h=axi_wstrb2_seq::type_id::create("axi_wstrb2_seq_h");
      axi_wstrb2_seq_h.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************WSTRB3 TEST************************",0)


      axi_wstrb3_seq_h=axi_wstrb3_seq::type_id::create("axi_wstrb3_seq_h");
      axi_wstrb3_seq_h.start(env_h.agt.seqr_h);

      `uvm_info("TEST","***********************WSTRB TEST************************",0)


      axi_wstrb_seq_h=axi_wstrb_seq::type_id::create("axi_wstrb_seq_h");
      axi_wstrb_seq_h.start(env_h.agt.seqr_h);

    end
    else
      `uvm_error("TEST","SEQ NAME NOT FOUND")
    phase.drop_objection(this);
  endtask
endclass  





/*else if(seq_name=="WT")begin
      write_h=write_seq::type_id::create("write_h");
      write_h.start(env_h.agt.seqr_h);
    end
else if(seq_name=="RD")begin
      read_h=read_seq::type_id::create("read_h");
      read_h.start(env_h.agt.seqr_h);
end
 write_h=write_seq::type_id::create("write_h");
      write_h.start(env_h.agt.seqr_h);
      read_h=read_seq::type_id::create("read_h");
      read_h.start(env_h.agt.seqr_h);

*/


