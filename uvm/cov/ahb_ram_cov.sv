`ifndef AHB_RAM_COV_SV
`define AHB_RAM_COV_SV

class ahb_ram_cov extends ahb_ram_subscriber;
  `uvm_component_utils(ahb_ram_cov)
  function new(string name = "ahb_ram_cov", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void buils_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
endclass
`endif // AHB_RAM_COV_SV
