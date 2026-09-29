//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : test_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_TEST_PKG__SV
`define GUARD_UART_TEST_PKG__SV

package test_pkg;
  import uvm_pkg::*;
  import fifo_pkg::*;
  import seq_pkg::*;
  import env_pkg::*;

  // Include your file
  `include "base_test.sv"

  `include "wr_rd_during_reset_test.sv"
  `include "reset_on_fly_full_test.sv"
  `include "reset_on_fly_empty_test.sv"
  `include "write_disable_test.sv"
  `include "write_test.sv"
  `include "read_test.sv"
  `include "write_read_test.sv"
  `include "fifo_full_test.sv"
  `include "fifo_empty_test.sv"
  `include "almost_full_test.sv"
  `include "almost_empty_test.sv"
  `include "overflow_test.sv"
  `include "underflow_test.sv"
  `include "rw_concurrent_test.sv"
  `include "rw_concurrent_empty_test.sv"
  `include "rw_concurrent_full_test.sv"
  `include "rw_concurrent_almostempty_test.sv"
  `include "rw_concurrent_almostfull_test.sv"

endpackage: test_pkg

`endif


