`ifndef LVC_AHB_MASTER_DRIVER_SV
`define LVC_AHB_MASTER_DRIVER_SV

class lvc_ahb_master_driver extends lvc_ahb_driver;
  `uvm_component_utils(lvc_ahb_master_driver)

  function new(string name = "lvc_ahb_master_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  virtual task driver_transfer(REQ t);
    case(t.burst_type) 
      SINGLE :  begin do_atomic_trans(t); end
      INCR   : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP4  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR4  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP8  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR8  : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      WRAP16 : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      INCR16 : begin `uvm_error("TYPEERR", "burst type not be supported yet") end
      default : begin `uvm_error("TYPEERR", "burst type not define") end
    endcase    
  endtask

  virtual task do_atomic_trans(REQ t);
    case(t.xact_type)
      READ      : do_read(t); 
      WRITE     : do_write(t);
      IDLE_XACT : begin  `uvm_error("TYPERR", "trans type not supported")  end
      default   : begin  `uvm_error("TYPERR", "trans type not define")  end     
    endcase
  endtask

  virtual task wait_bus_grant();
    @(vif.cb_mst iff vif.cb_mst.hgrant === 1'b1);
  endtask

  virtual task do_write(REQ t);
    //@(vif.cb_mst);
    do_init_write(t);
    do_proc_write(t);
  endtask

  virtual task do_read(REQ t);
    do_init_read(t);
    do_proc_read(t);
  endtask

  virtual task do_init_write(REQ t);
    wait_bus_grant();
    vif.cb_mst.htrans <= NSEQ;
    vif.cb_mst.haddr  <= t.addr;
    vif.cb_mst.hburst <= t.burst_type; 
    vif.cb_mst.hsize <= t.burst_size;
    vif.cb_mst.hwrite <= 1'b1;
    @(vif.cb_mst);
    if(t.burst_type == SINGLE) begin
      _do_drive_idle();
    end
    vif.cb_mst.hwdata <= t.data[0];
    forever begin
      @(negedge vif.hclk);
      if(vif.cb_mst.hready === 1'b1) begin  break;  end
      else @(vif.cb_mst);
    end
    //update current trans type   
    t.trans_type = NSEQ;
    //start beat from 0 to data array index to make consistance
    t.current_data_beat_num = 0;
    t.all_beat_response[t.current_data_beat_num] = response_type_enum'(vif.hresp);   
  endtask

  virtual task do_init_read(REQ t);
    wait_bus_grant();
    vif.cb_mst.htrans <= NSEQ;
    vif.cb_mst.haddr  <= t.addr;
    vif.cb_mst.hburst <= t.burst_type; 
    vif.cb_mst.hsize <= t.burst_size;
    vif.cb_mst.hwrite <= 1'b0;
    @(vif.cb_mst);
    if(t.burst_type == SINGLE) begin
      _do_drive_idle();
    end
    forever begin
      @(negedge vif.hclk);
      if(vif.cb_mst.hready === 1'b1) begin  break;  end
      else @(vif.cb_mst);
    end
    t.data = new[t.current_data_beat_num + 1] (t.data);
    t.data[0] = vif.hrdata;

    //update current trans type   ??? why do update
    t.trans_type = NSEQ;
    //start beat from 0 to data array index to make consistance
    t.current_data_beat_num = 0;
    t.all_beat_response[t.current_data_beat_num] = response_type_enum'(vif.hresp);   
  endtask

  virtual task do_proc_write(REQ t);
    //do_init_idle();
  endtask

  virtual task do_proc_read(REQ t);
    //do_init_idle();
  endtask

  virtual task do_init_idle();
    @(vif.cb_mst);
    _do_drive_idle();  
endtask

  virtual protected task _do_drive_idle();
    vif.cb_mst.haddr    <= 0;
    vif.cb_mst.hburst   <= 0;
    vif.cb_mst.hbusreq  <= 0;
    vif.cb_mst.hlock    <= 0;
    vif.cb_mst.hport    <= 0;
    vif.cb_mst.hsize    <= 0;
    vif.cb_mst.htrans   <= 0;
    vif.cb_mst.hwdata   <= 0;
    vif.cb_mst.hwrite   <= 0;
  endtask

  virtual protected task reset_listener();
    `uvm_info(get_type_name(), "reset_listener", UVM_HIGH)
    fork
      forever begin
        @(negedge vif.hresetn);
        _do_drive_idle();    
      end
    join_none
  endtask

endclass 

`endif //LVC_AHB_MASTER_DRIVER_SV
