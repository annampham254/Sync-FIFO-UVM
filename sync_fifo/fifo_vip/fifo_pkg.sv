//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : uart_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_PKG__SV
`define GUARD_UART_PKG__SV
package fifo_pkg;
  import uvm_pkg::*;

  // Include your file
    `include "fifo_transaction.sv"
    `include "fifo_sequencer.sv"
    `include "fifo_driver.sv"
    `include "fifo_monitor.sv"
    `include "fifo_agent.sv" 
    
endpackage: fifo_pkg

`endif

