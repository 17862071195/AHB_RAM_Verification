`ifndef AHB_RAM_SINGLE_WRITE_SEQ_SV
`define AHB_RAM_SINGLE_WRITE_SEQ_SV

class ahb_ram_single_write_seq extends ahb_ram_base_element_sequence;

  rand bit [31:0] addr;
  rand bit [31:0] data;
  rand burst_size_enum bsize;
  constraint single_write_cstr {
    soft addr[1:0] == 0;
    soft bsize == BURST_SIZE_32BIT;
  }
  `uvm_object_utils(ahb_ram_single_write_seq)
  function new(string name = "ahb_ram_single_write_seq");
    super.new(name);
  endfunction

  virtual task body();
    lvc_ahb_master_single_trnas ahb_single;
    `uvm_info("body", "Entered...", UVM_LOW) 
    `uvm_do_on_with(ahb_single, p_sequencer.ahb_mst_sqr, {
                    addr == local::addr; 
                    data == local::data;
                    xact == WRITE;
                    bsize == local::bsize;}
                   )
    `uvm_info("body", "Exiting...", UVM_LOW) 
  endtask

endclass

`endif //  AHB_RAM_SINGLE_WRITE_SEQ_SV
