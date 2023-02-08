`ifndef AHB_RAM_BASE_TEST_SV
`define AHB_RAM_BASE_TEST_SV

class ahb_ram_base_test extends uvm_test;
  ahb_ram_config cfg;
  ahb_ram_env env;
  ahb_ram_reg rgm;

  `uvm_component_utils(ahb_ram_base_test)

  function new(string name = "ahb_ram_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rgm = ahb_ram_reg::type_id::create("rgm", this);
    rgm.build();
    uvm_config_db#(ahb_ram_reg)::set(this,"env","rgm", rgm);
    cfg = ahb_ram_config::type_id::create("cfg");
    cfg.rgm = rgm;
    if(!uvm_config_db#(virtual ahb_ram_if)::get(this,"","vif",cfg.vif)) begin
      `uvm_fatal("GETVIF", "base_test cannot get vif from config DB")
    end
    uvm_config_db#(ahb_ram_config)::set(this, "env", "cfg", cfg);
    env = ahb_ram_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.phase_done.set_drain_time(this, 1us);
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask

endclass
`endif // AHB_RAM_BASE_TEST_SV
