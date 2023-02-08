`ifndef AHB_RAM_ENV_SV
`define AHB_RAM_ENV_SV

class ahb_ram_env extends uvm_env;

  ahb_ram_config cfg;
  lvc_ahb_master_agent ahb_mst;
  ahb_ram_virtual_sequencer virt_sqr;

  ahb_ram_reg rgm;
  ahb_ram_reg_adapter adapter;
  uvm_reg_predictor#(lvc_ahb_transaction) predictor; 

  ahb_ram_scoreboard  scb;
  ahb_ram_cov cov;
  `uvm_component_utils(ahb_ram_env)

  function new(string name ="ahb_ram_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(ahb_ram_config)::get(this,"", "cfg", cfg))
      `uvm_fatal("GETCFG", "Cannot get config from config DB!")
    uvm_config_db#(lvc_ahb_agent_configuration)::set(this, "ahb_mst", "cfg", cfg.ahb_cfg);
    ahb_mst = lvc_ahb_master_agent::type_id::create("ahb_mst", this);

    uvm_config_db#(ahb_ram_config)::set(this, "virt_sqr", "cfg", cfg);
    virt_sqr = ahb_ram_virtual_sequencer::type_id::create("virt_sqr", this);

    uvm_config_db#(ahb_ram_config)::set(this, "scb", "cfg", cfg);
    uvm_config_db#(ahb_ram_config)::set(this, "cov", "cfg", cfg);

    if(!uvm_config_db#(ahb_ram_reg)::get(this, "", "rgm", rgm)) begin
      rgm = ahb_ram_reg::type_id::create("rgm", this);
      rgm.build();
    end
    
    adapter = ahb_ram_reg_adapter::type_id::create("adapter", this);
    predictor = uvm_reg_predictor#(lvc_ahb_transaction)::type_id::create("predictor", this);
    cov = ahb_ram_cov::type_id::create("cov", this);
    scb = ahb_ram_scoreboard::type_id::create("scb", this);   
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    virt_sqr.ahb_mst_sqr = ahb_mst.sequencer;
    
    rgm.map.set_sequencer(ahb_mst.sequencer, adapter);  
    ahb_mst.monitor.item_observed_port.connect(predictor.bus_in);
    predictor.map = rgm.map;
    predictor.adapter = adapter;

    ahb_mst.monitor.item_observed_port.connect(cov.ahb_trans_observed_imp);
    ahb_mst.monitor.item_observed_port.connect(scb.ahb_trans_observed_imp);



  endfunction

endclass
`endif // AHB_RAM_ENV_SV
