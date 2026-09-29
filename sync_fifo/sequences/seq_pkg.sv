//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : seq_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_SEQ_PKG__SV
`define GUARD_UART_SEQ_PKG__SV

package seq_pkg;
  import uvm_pkg::*;
  import fifo_pkg::*;

  // Include your file
  `include "write_sequence.sv"
  `include "read_sequence.sv"
  `include "concurrent_sequence.sv"
  `include "write_disable_sequence.sv"

endpackage: seq_pkg

`endif


