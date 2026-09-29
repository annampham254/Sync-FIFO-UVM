interface fifo_if(input bit clk);
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;

    logic [FIFO_WIDTH-1:0] data_in;
    logic rst_n, wr_en, rd_en;

    logic [FIFO_WIDTH-1:0] data_out;
    logic wr_ack, overflow;
    logic full, empty, almostfull, almostempty, underflow;

    modport DUT(
        input clk, data_in, rst_n, wr_en, rd_en,
        output data_out, wr_ack, overflow, full, empty, almostfull, almostempty, underflow
    );

    property p0;
        @(posedge clk) disable iff (!rst_n)
        !(full && empty);
    endproperty
    assert property(p0) else $error("ASSERTION ERROR: full and empty asserted at the same time !!!");

    property p1;
        @(posedge clk) disable iff (!rst_n)
        wr_ack |-> wr_en;
    endproperty
    assert property(p1) else $error("ASSERTION ERROR: wr_ack = 1 without wr_en !!!");

    property p2;
        @(posedge clk) disable iff (!rst_n)
        overflow |-> full;
    endproperty
    assert property(p2) else $error("ASSERTION ERROR: overflow without full !!!");

    property p3;
        @(posedge clk) disable iff (!rst_n)
        underflow |-> empty;
    endproperty
    assert property(p3) else $error("ASSERTION ERROR: underflow without empty!!!");

    property p4;
        @(posedge clk) disable iff (!rst_n)
        full |-> !wr_ack;
    endproperty
    assert property(p4) else $error("ASSERTION ERROR: wr_ack asserted while full !!!");

    property p5;
        @(posedge clk) disable iff (!rst_n)
        almostempty |-> !full;
    endproperty
    assert property(p5) else $error("ASSERTION ERROR: almost_empty and full asserted at the same time !!!");

    property p6;
        @(posedge clk) disable iff (!rst_n)
        (wr_en && wr_ack && !rd_en && !full) |=> !empty;
    endproperty
    assert property(p6) else $error("ASSERTION ERROR: still empty after successfull write !!!");

    property p7;
        @(posedge clk) disable iff (!rst_n)
        (!wr_en && rd_en && !empty) |=> !full;
    endproperty
    assert property(p7) else $error("ASSERTION ERROR: still full after successfull read !!!");

    property p8;
        @(posedge clk) disable iff (!rst_n)
        (wr_en && rd_en && !empty && !full) |=> ($stable(full) && $stable(empty));
    endproperty
    assert property(p8) else $error("ASSERTION ERROR: flag change on concurrent write read !!!");


    
    //assert property(
    //    @(posedge clk) disable iff (!rst_n)
    //    wr_en |-> wr_ack
    //)else $error("Error Assrtions") ;
endinterface
