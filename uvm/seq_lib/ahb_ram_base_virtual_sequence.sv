`ifndef AHB_RAM_BASE_VIRTUAL_SEQUENCE_SV
`define AHB_RAM_BASE_VIRTUAL_SEQUENCE_SV

class ahb_ram_base_virtual_sequence extends uvm_sequence;
  ahb_ram_config cfg;
  virtual ahb_ram_if vif;
  ahb_ram_reg rgm;
  uvm_status_e status;
  bit [31:0] wr_val, rd_val;
  `uvm_object_utils(ahb_ram_base_virtual_sequence)

  `uvm_declare_p_sequencer(ahb_ram_virtual_sequencer)

  function new(string name ="ahb_ram_base_virtual_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entered ...", UVM_LOW)
    cfg = p_sequencer.cfg;
    vif = cfg.vif;
    rgm = cfg.rgm;
    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask

  virtual function void compare_data( logic[31:0] val1, logic[31:0] val2);
    cfg.seq_check_count++;
    if(val1 === val2)
      `uvm_info("COMPSUC", $sformatf("val1 'h%0x === val2 'h%0x", val1, val2), UVM_LOW)
    else begin 
      cfg.seq_check_error++;
      `uvm_error("COMPERR", $sformatf("val1 'h%0x !== val2 'h%0x", val1, val2))
    end
  endfunction

  task wait_reset_signal_assertted();
    @(posedge vif.rstn);
  endtask

  task wait_reset_signal_releassed();
    @(negedge vif.rstn);
  endtask

endclass
`endif // AHB_RAM_BASE_VIRTUAL_SEQUENCE_SV
