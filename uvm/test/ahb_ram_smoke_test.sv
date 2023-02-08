`ifndef AHB_RAM_SMOKE_TEST_SV
`define AHB_RAM_SMOKE_TEST_SV

class ahb_ram_smoke_test extends ahb_ram_base_test;
  `uvm_component_utils(ahb_ram_smoke_test)
  function new(string name = "ahb_ram_smoke_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    ahb_ram_smoke_virt_seq seq = ahb_ram_smoke_virt_seq::type_id::create("ahb_ram_smoke_virt_seq");
    super.run_phase(phase);
    phase.raise_objection(this);
    seq.start(env.virt_sqr);
    phase.drop_objection(this);
  endtask
endclass
`endif // AHB_RAM_SMOKE_TEST_SV
