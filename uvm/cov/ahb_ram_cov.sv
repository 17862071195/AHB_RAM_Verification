`ifndef AHB_RAM_COV_SV
`define AHB_RAM_COV_SV

class ahb_ram_cov extends ahb_ram_subscriber;
  `uvm_component_utils(ahb_ram_cov)
  
  // T1 AHB address 
  covergroup  ahb_ram_address_cg (bit [31:0] addr_start, bit [31:0] addr_end) with function sample(bit [31:0] addr);
    option.name = "T1 AHBram address range coverage";
    ADDR : coverpoint addr {
      bins addr_start          = {[addr_start : addr_start+3]};
      bins addr_end            = {[addr_end-3 : addr_end]};
      bins legal_range         = {[addr_start : addr_end]};
      bins out_of_range        = {[addr_end+1 : 32'hFFFF_FFFF]};
    }
    BYTEACC : coverpoint addr[1:0] {
      bins addr_byte_acc_b01   = {2'b01};
      bins addr_byte_acc_b02   = {2'b10};
      bins addr_byte_acc_b03   = {2'b11};
      bins addr_byte_acc_b00   = {2'b00};
    }  
  endgroup

  // T2 AHB type and size
  covergroup ahb_ram_type_size_cg with function sample(burst_type_enum btype, burst_size_enum bsize);
    option.name = "ahb_ram_type_size_cg";
    BURST_TYPE : coverpoint btype {
      bins single = {SINGLE};  
      bins incr   = {INCR};  
      bins wrap4  = {WRAP4};  
      bins incr4  = {INCR4};  
    } 
    BURST_SIZE : coverpoint bsize {
      bins size_8bit  = {BURST_SIZE_8BIT};
      bins size_16bit = {BURST_SIZE_16BIT};
      bins size_32bit = {BURST_SIZE_32BIT};
      bins size_64bit = {BURST_SIZE_64BIT};
    }
  endgroup

  function new(string name = "ahb_ram_cov", uvm_component parent);
    super.new(name, parent);
    ahb_ram_address_cg = new(32'h0000, 32'hFFFF);
    ahb_ram_type_size_cg = new();
  endfunction

  function void buils_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(lvc_ahb_transaction tr); 
    ahb_ram_address_cg.sample(tr.addr);
    ahb_ram_type_size_cg.sample(tr.burst_type, tr.burst_size);
  endfunction
  
endclass

`endif // AHB_RAM_COV_SV
