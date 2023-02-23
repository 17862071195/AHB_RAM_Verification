`ifndef AHB_RAM_DIFF_HADDR_VIRT_SEQ_SV
`define AHB_RAM_DIFF_HADDR_VIRT_SEQ_SV

class ahb_ram_diff_haddr_virt_seq extends ahb_ram_base_virtual_sequence;
  `uvm_object_utils(ahb_ram_diff_haddr_virt_seq)

  function new(string name = "ahb_ram_diff_haddr_virt_seq");
    super.new(name);
  endfunction

  task body();
    bit [31:0] addr, data;
    super.body();
    `uvm_info("body", "Entered ...", UVM_LOW)
    for(int i=0; i<(cfg.addr_end>>4); i++) begin
      std::randomize(addr) with {addr[1:0] == 0; addr inside {['h1000:'hFFFF]};};
      std::randomize(wr_val) with {wr_val == (i<<8) + i;};
      data = wr_val;
      `uvm_do_with(single_write, {addr == local::addr; data == local::data; })
      `uvm_do_with(single_read, {addr == local::addr;})
      rd_val = single_read.data;
      compare_data(wr_val, rd_val);
    end
    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask
endclass
`endif // AHB_RAM_DIFF_HADDR_VIRT_SEQ_SV
