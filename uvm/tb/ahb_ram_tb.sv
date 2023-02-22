`timescale 1ns/1ns

module ahb_ram_tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import ahb_ram_pkg::*;
  
  logic clk;
  logic rstn;

  initial begin : clk_gen
    clk = 0;
    forever begin  
      #2ns clk = !clk;
    end
  end

  ahb_blockram_32 #(.ADDRESSWIDTH(16)) dut(
    .HCLK(ahb_if.hclk)          // system bus clock
    ,.HRESETn(ahb_if.hresetn)   // system bus reset
    ,.HSELBRAM(1'b1)            // AHB peripheral select
    ,.HREADY(ahb_if.hready)     // AHB ready input
    ,.HTRANS(ahb_if.htrans)     // AHB transfer type
    ,.HSIZE(ahb_if.hsize)       // AHB hsize
    ,.HWRITE(ahb_if.hwrite)     // AHB hwrite
    ,.HADDR(ahb_if.haddr)       // AHB address bus
    ,.HWDATA(ahb_if.hwdata)     // AHB write data bus
    ,.HREADYOUT(ahb_if.hready)  // AHB ready output to S->M mux
    ,.HRESP(ahb_if.hresp)       // AHB response
    ,.HRDATA(ahb_if.hrdata)     // AHB read data bus
    );

  lvc_ahb_if ahb_if();
  assign ahb_if.hclk   = clk;
  assign ahb_if.hresetn = rstn;
  assign ahb_if.hgrant = 1'b1;

  ahb_ram_if ram_if();
  assign ram_if.clk = clk;
  assign rstn       = ram_if.rstn;



  initial begin
    uvm_config_db#(virtual lvc_ahb_if)::set(uvm_root::get(),"uvm_test_top.env.ahb_mst","vif", ahb_if);
    uvm_config_db#(virtual ahb_ram_if)::set(uvm_root::get(),"uvm_test_top","vif", ram_if);
    uvm_config_db#(virtual ahb_ram_if)::set(uvm_root::get(),"uvm_test_top.env","vif", ram_if);
    uvm_config_db#(virtual ahb_ram_if)::set(uvm_root::get(),"uvm_test_top.env.virt_sqr","vif", ram_if);
    run_test("");
  end

endmodule
