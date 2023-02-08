`ifndef AHB_RAM_COONFIG_SV
`define AHB_RAM_COONFIG_SV

class ahb_ram_config extends uvm_object;
  int seq_check_count;
  int seq_check_error;
  `uvm_object_utils(ahb_ram_config)

  lvc_ahb_agent_configuration ahb_cfg;
  virtual ahb_ram_if vif;
  ahb_ram_reg rgm;
  function new(string name = "ahb_ram_config");
    super.new(name);
    ahb_cfg = lvc_ahb_agent_configuration::type_id::create("ahb_cfg");
  endfunction

endclass

`endif  // AHB_RAM_COONFIG_SV
