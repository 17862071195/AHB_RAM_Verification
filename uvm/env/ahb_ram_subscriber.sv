`ifndef AHB_RAM_SUBSCRIBER_SV
`define AHB_RAM_SUBSCRIBER_SV

class ahb_ram_subscriber extends uvm_component;

  uvm_analysis_imp #(lvc_ahb_transaction, ahb_ram_subscriber) ahb_trans_observed_imp;

  protected uvm_event_pool _ep;

  `uvm_component_utils(ahb_ram_subscriber)
  
  function new(string name = "ahb_ram_subscriber", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_trans_observed_imp = new("ahb_trans_observed_imp", this);
    _ep = new("_ep");
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    do_evnents_trigger();
    do_listen_events();
  endtask

  virtual function write(lvc_ahb_transaction tr);
  endfunction 

  virtual task do_evnents_trigger();
  endtask

  virtual task do_listen_events();
  endtask

endclass

`endif //AHB_RAM_SUBSCRIBER_SV
