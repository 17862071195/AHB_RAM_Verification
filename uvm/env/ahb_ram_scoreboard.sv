`ifndef AHB_RAM_SCOREBOARD_SV
`define AHB_RAM_SCOREBOARD_SV

class ahb_ram_scoreboard extends ahb_ram_subscriber;

  bit [31:0] mem [int unsigned];

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

  virtual function void write(lvc_ahb_transaction tr);
    if(is_addr_valid(tr.addr)) begin
      case(tr.xact_type)
        WRITE : store_data_with_hburst(tr);
        READ  : check_data_with_hburst(tr); 
      endcase
    end  
  endfunction

  virtual task do_data_check();

  endtask

  function bit is_addr_valid(bit[31:0] addr);
    if(addr >= cfg.addr_start && addr <= cfg.addr_end)
      return 1;
  endfunction 

  function void store_data_with_hburst(lvc_ahb_transaction tr);
     case(tr.burst_type) 
      SINGLE :  begin     store_data_with_hsize(tr, 0); end
      INCR   : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP4  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR4  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP8  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR8  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP16 : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR16 : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      default : begin `uvm_error("TYPEERR", "burst type not define") end
    endcase       
  endfunction

  function void store_data_with_hsize(lvc_ahb_transaction tr, int beat);
    case(tr.burst_size)
      BURST_SIZE_8BIT    : begin mem[{tr.addr[31:2],2'b00}] = extract_valid_beat(tr, beat);  end
      BURST_SIZE_16BIT   : begin mem[{tr.addr[31:2],2'b00}] = extract_valid_beat(tr, beat);  end
      BURST_SIZE_32BIT   : begin mem[{tr.addr[31:2],2'b00}] = extract_valid_beat(tr, beat);  end
      BURST_SIZE_64BIT   : begin `uvm_error("TYPEERR", "burst size not supprted") end
      BURST_SIZE_128BIT  : begin `uvm_error("TYPEERR", "burst size not supprted") end
      BURST_SIZE_256BIT  : begin `uvm_error("TYPEERR", "burst size not supprted") end
      BURST_SIZE_512BIT  : begin `uvm_error("TYPEERR", "burst size not supprted") end
      BURST_SIZE_1024BIT : begin `uvm_error("TYPEERR", "burst size not supprted") end
      default : begin `uvm_error("TYPEERR", "burst size not supprted") end
    endcase  
  endfunction

  function bit check_data_with_hburst(lvc_ahb_transaction tr);
     case(tr.burst_type)
      SINGLE : begin check_data_with_hburst = check_data_with_hsize(tr, 0); end
      INCR   : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP4  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR4  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP8  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR8  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP16 : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR16 : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      default : begin `uvm_error("TYPEERR", "burst type not define") end
    endcase       
  endfunction
 
  function bit check_data_with_hsize(lvc_ahb_transaction tr, int beat);
    bit [31:0] tdata = extract_valid_data(tr.addr, tr.data[beat], tr.burst_size);
    bit [31:0] mdata = extract_valid_data(tr.addr, mem[{tr.addr[31:2],2'b00}], tr.burst_size);
    check_data_with_hsize = tdata == mdata ? 1 : 0;
    if(check_data_with_hsize == 1) 
      `uvm_info("CHECKDATA", $sformatf("ahb_ram[%0x] is expected value: 'h%x = 'h%x", tr.addr, tdata, mdata), UVM_LOW)
    else begin
      `uvm_error("CHECKDATA", $sformatf("ahb_ram[%0x] is not expected value: 'h%x != 'h%x", tr.addr, tdata, mdata))
      cfg.scb_check_error++; 
    end
    cfg.scb_check_count++; 
  endfunction

  function bit [31:0] extract_valid_beat(lvc_ahb_transaction tr, int beat);
    bit [31:0] mdata = mem[{tr.addr[31:2],2'b00}];
    bit [31:0] tdata = tr.data[beat];
    case(tr.burst_size)
      BURST_SIZE_8BIT  : mdata[(tr.addr[1:0]*8+7) -: 8]  =  tdata >> (tr.addr[1:0]*8);                              
      BURST_SIZE_16BIT : mdata[(tr.addr[1]*16+15) -: 16]  =  tdata >> (tr.addr[1]*16);                                       
      BURST_SIZE_32BIT : mdata = tdata;                                                 
      BURST_SIZE_64BIT : `uvm_error("TYPEERR", "burst size not supported")   
      default : begin `uvm_error("TYPEERR", "burst size not supported") end
    endcase
    return mdata;
  endfunction



 

endclass
`endif // AHB_RAM_SCOREBOARD_SV
