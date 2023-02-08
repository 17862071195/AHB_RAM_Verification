
module ahb_ram_tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import ahb_ram_pkg::*;
  
  //ahb_blockram_32 dut();

  lvc_ahb_if ahb_if();
  ahb_ram_if ram_if();



  initial begin
    uvm_config_db#(virtual lvc_ahb_if)::set(uvm_root::get(),"uvm_test_top.env.ahb_mst","vif", ahb_if);
    uvm_config_db#(virtual ahb_ram_if)::set(uvm_root::get(),"uvm_test_top","vif", ram_if);
    uvm_config_db#(virtual ahb_ram_if)::set(uvm_root::get(),"uvm_test_top.env","vif", ram_if);
    uvm_config_db#(virtual ahb_ram_if)::set(uvm_root::get(),"uvm_test_top.env.virt_sqr","vif", ram_if);
    run_test("");
  end

endmodule
