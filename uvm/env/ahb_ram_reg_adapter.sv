`ifndef AHB_RAM_REG_ADAPTER_SV
`define AHB_RAM_REG_ADAPTER_SV

class ahb_ram_reg_adapter extends uvm_reg_adapter;
  `uvm_object_utils(ahb_ram_reg_adapter)

  function new(string name = "ahb_ram_reg_adapter");
    super.new(name);
    provides_responses = 1;
  endfunction

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);

  endfunction

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    
  endfunction

endclass
`endif // AHB_RAM_REG_ADAPTER_SV
