`ifndef AHB_RAM_VIRTUAL_SEQUENCER_SV
`define AHB_RAM_VIRTUAL_SEQUENCER_SV

class ahb_ram_virtual_sequencer extends uvm_sequencer;
  ahb_ram_config cfg;

  `uvm_component_utils(ahb_ram_virtual_sequencer)


  lvc_ahb_master_sequencer ahb_mst_sqr;

  function new(string name ="ahb_ram_virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(ahb_ram_config)::get(this,"","cfg",cfg))begin
      `uvm_fatal("GETCFG", "virtaul sequenceer cannot get cfg from config DB")
    end

  endfunction
endclass

`endif // AHB_RAM_VIRTUAL_SEQUENCER_SV
