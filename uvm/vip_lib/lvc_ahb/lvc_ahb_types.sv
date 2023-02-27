`ifndef LVC_AHB_TYPES_SV
`define LVC_AHB_TYPES_SV

  typedef enum bit[1:0] {
      OKAY  = 2'b00, 
      ERROR = 2'b01,
      RETRY = 2'b10,
      SPLIT = 2'b11
  } response_type_enum;
  
  typedef enum bit [1:0]{
      IDLE  = 2'b00, 
      BUSY  = 2'b01,
      NSEQ = 2'b10,
      SEQ   = 2'b11
  } trans_type_enum;

  typedef enum bit [2:0]{
      BURST_SIZE_8BIT     = 3'b000, 
      BURST_SIZE_16BIT    = 3'b001, 
      BURST_SIZE_32BIT    = 3'b010, 
      BURST_SIZE_64BIT    = 3'b011, 
      BURST_SIZE_128BIT   = 3'b100, 
      BURST_SIZE_256BIT   = 3'b101, 
      BURST_SIZE_512BIT   = 3'b110, 
      BURST_SIZE_1024BIT  = 3'b111
  } burst_size_enum;

  typedef enum bit [2:0]{
      SINGLE     = 3'b000, 
      INCR       = 3'b001, 
      WRAP4      = 3'b010, 
      INCR4      = 3'b011, 
      WRAP8      = 3'b100, 
      INCR8      = 3'b101, 
      WRAP16     = 3'b110, 
      INCR16     = 3'b111 
  } burst_type_enum;

  typedef enum bit [1:0]{
      READ       = 2'b00, 
      WRITE      = 2'b01, 
      IDLE_XACT  = 2'b10  
  } xact_type_enum;

  typedef enum bit [1:0] {
      INITIAL            ='b00,     // Indicates the default state of the flag. It 
                                    // gets update once the beat level transfer begins
      PARTIAL_ACCEPT     ='b01,     // The status changes from INTIAL to PATIEA_ACCEPT 
                                    // once the address of each beat is accepted by slave
      ACCEPT             ='b10,     // The status changes to ACCEPT once the beat level 
                                    // data is accepted by the slace 
      ABORTED            ='B11      // The status changes to ABORTin case the transaction 
                                    // is ABORTED due to ERROR/SPLT or RETRY response from 
                                    // the slave or in case of EBT 
  } status_enum;

  function bit [31:0] extract_valid_data(bit [`LVC_AHB_MAX_ADDR_WIDTH-1 : 0] addr
                                        ,bit [`LVC_AHB_MAX_DATA_WIDTH-1 : 0] data
                                        ,burst_size_enum bsize);
    case(bsize)
      BURST_SIZE_8BIT  : return (data >> (addr[1:0]*8)) & 8'hFF;                              
      BURST_SIZE_16BIT : return (data >> (addr[1]*16))  & 16'hFFFF;                                       
      BURST_SIZE_32BIT : return data & 32'hFFFF_FFFF;                                                 
      BURST_SIZE_64BIT : `uvm_error("TYPEERR", "burst size not supported")   
      default : begin `uvm_error("TYPEERR", "burst size not supported") end
    endcase
  endfunction

`endif // LVC_AHB_TYPES_SVH
