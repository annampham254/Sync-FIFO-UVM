//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : env_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_ENV_PKG__SV
`define GUARD_UART_ENV_PKG__SV

package env_pkg;
  import uvm_pkg::*;
  import fifo_pkg::*;

  // Include your file
    `include "fifo_scoreboard.sv"
    `include "fifo_coverage.sv"
    `include "fifo_env.sv" 
endpackage: env_pkg

`endif


