`ifndef LVC_AHB_BASE_SEQUENCE_SVH
`define LVC_AHB_BASE_SEQUENCE_SVH

class lvc_ahb_base_sequence extends uvm_sequence #(lvc_ahb_transaction);
  
  `uvm_object_utils(lvc_ahb_base_sequence)
  function new (string name = "lvc_ahb_base_sequence");
    super.new(name);
  endfunction


endclass : lvc_ahb_base_sequence

`endif // LVC_AHB_BASE_SEQUENCE_SVH
