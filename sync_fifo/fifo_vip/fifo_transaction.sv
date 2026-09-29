class fifo_transaction extends uvm_sequence_item;
    rand bit wr_en;
    rand bit rd_en;
    rand bit[15:0] data_in;

    bit [15:0] data_out;
    bit full;
    bit empty;
    bit almostfull;
    bit almostempty;
    bit overflow;
    bit underflow;
    bit wr_ack;
    bit rst_n;

    `uvm_object_utils_begin (fifo_transaction)
        `uvm_field_int  (wr_en,                UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (rd_en,                UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (data_in,              UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (data_out,             UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (full,                 UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (empty,                UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (almostfull,           UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (almostempty,          UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (overflow,             UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (underflow,            UVM_ALL_ON |UVM_HEX)
        `uvm_field_int  (wr_ack,               UVM_ALL_ON |UVM_HEX)
    `uvm_object_utils_end 
    
    constraint wr_en_c {wr_en dist{1:=80, 0:=20};}
    constraint rd_en_c {rd_en dist{1:=70, 0:=70};}

    function new(string name = "fifo_transaction");
        super.new(name);
    endfunction: new

endclass: fifo_transaction
