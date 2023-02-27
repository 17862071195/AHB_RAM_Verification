`ifndef AHB_RAM_RESET_W2R_VIRT_SEQ_SV
`define AHB_RAM_RESET_W2R_VIRT_SEQ_SV

class ahb_ram_reset_w2r_virt_seq extends ahb_ram_base_virtual_sequence;
  `uvm_object_utils(ahb_ram_reset_w2r_virt_seq)

  function new(string name = "ahb_ram_reset_w2r_virt_seq");
    super.new(name);
  endfunction

  task body();
    bit [31:0] addr, data;
    bit [31:0] addr_q[$];

    super.body();
    `uvm_info("body", "Entered ...", UVM_LOW)
    for(int i=0; i<10; i++) begin
      std::randomize(addr) with {addr[1:0] == 0; addr inside {['h1000:'hFFFF]};};
      std::randomize(wr_val) with {wr_val == (i<<4) + i;};
      data = wr_val;
      addr_q.push_back(addr);
      `uvm_do_with(single_write, {addr == local::addr; data == local::data;})
      `uvm_do_with(single_read, {addr == local::addr;})
      rd_val = single_read.data;
      compare_data(wr_val, rd_val);
    end

    //reset and check ram again  
    vif.assert_reset(10); 
    do begin
      addr = addr_q.pop_front();
      `uvm_do_with(single_read, {addr == local::addr;})
      rd_val = single_read.data;
      if(cfg.init_logic === 1'b0)
        compare_data(32'h0, rd_val);
      else if (cfg.init_logic === 1'bx)
        compare_data(32'bx, rd_val);
      else 
        `uvm_error("TYPEERR", "type of init_logic is not recognized")
    end while(addr_q.size > 0);
   // `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask
endclass
`endif // AHB_RAM_RESET_W2R_VIRT_SEQ_SV
