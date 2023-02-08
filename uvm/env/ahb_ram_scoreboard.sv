`ifndef AHB_RAM_SCOREBOARD_SV
`define AHB_RAM_SCOREBOARD_SV

class ahb_ram_scoreboard extends ahb_ram_subscriber;

  `uvm_component_utils(ahb_ram_scoreboard)

  function new(string name = "ahb_ram_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    do_data_check();
  endtask

  virtual task do_data_check();

  endtask

endclass
`endif // AHB_RAM_SCOREBOARD_SV
