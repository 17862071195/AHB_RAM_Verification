`ifndef AHB_RAM_REG_SV
`define AHB_RAM_REG_SV

class ahb_ram_reg extends uvm_reg_block;
  uvm_reg_map map;
  `uvm_object_utils(ahb_ram_reg)
   
  function new(string name = "ahb_ram_reg");
    super.new(name, UVM_NO_COVERAGE);
  endfunction 

  function build();
    //TODO
    map = create_map("map", 'h0, 4, UVM_LITTLE_ENDIAN);
  endfunction
endclass
`endif // AHB_RAM_REG_SV
