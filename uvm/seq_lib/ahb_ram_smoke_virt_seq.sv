`ifndef AHB_RAM_SMOKE_VIRT_SEQ_SV
`define AHB_RAM_SMOKE_VIRT_SEQ_SV

class ahb_ram_smoke_virt_seq extends ahb_ram_base_virtual_sequence;
  `uvm_object_utils(ahb_ram_smoke_virt_seq)

  function new(string name = "ahb_ram_smoke_virt_seq");
    super.new(name);
  endfunction

  task body();
    super.body();
    `uvm_info("body", "Entered ...", UVM_LOW)

    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask
endclass
`endif // AHB_RAM_SMOKE_VIRT_SEQ_SV
