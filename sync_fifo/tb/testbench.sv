module testbench;  
  import uvm_pkg::*;
  import fifo_pkg::*;
  import test_pkg::*;

  bit clk = 0;
  always #5 clk = ~clk;

  fifo_if fif(clk);
  fifo_dut dut (.FIFOif(fif));

  

  // Set the VIP interface on the environment 
  initial begin
    uvm_config_db#(virtual fifo_if)::set(uvm_root::get(),"uvm_test_top","fifo_vif",fif);
    run_test();
  end

  initial begin
    fif.rst_n = 1'b0;
    fif.wr_en = 1'b0;
    fif.rd_en = 1'b0;
    fif.data_in = 16'h0;
    #20;
    fif.rst_n = 1'b1;
  end

endmodule


