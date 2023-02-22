`ifndef AHB_RAM_IF_SV
`define AHB_RAM_IF_SV

interface ahb_ram_if;
  logic clk;
  logic rstn;
  
  initial begin : rstn_gen
   assert_reset(10); 
  end
  
  task assert_reset(int nclks = 0, int delay = 0);
    #(delay * 1ns);
    repeat(nclks) @(posedge clk);
    rstn <= 0;
    repeat(5) @(posedge clk);
    rstn <= 1;
  endtask

endinterface

`endif //AHB_RAM_IF_SV

