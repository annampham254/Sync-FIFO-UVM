class fifo_coverage extends uvm_subscriber #(fifo_transaction);
    `uvm_component_utils(fifo_coverage)
    fifo_transaction trans;

    covergroup fifo_CG;
        write_read: coverpoint {trans.wr_en, trans.rd_en}{
            bins idle       = {2'b00};
            bins write_only = {2'b10};
            bins read_only  = {2'b01};
            bins concurrent = {2'b11};
        }
        data_in: coverpoint trans.data_in{
            bins low        = {[16'h0000:16'h3FFF]};
            bins middle     = {[16'h4000:16'hBFFF]};
            bins high       = {[16'hC000:16'hFFFF]};
        }
        state: coverpoint {trans.almostempty, trans.almostfull, trans.empty, trans.full}{
            bins almostempty = {4'b1000};
            bins almostfull  = {4'b0100};
            bins empty       = {4'b0010};
            bins full        = {4'b0001};
        }
        overflow: coverpoint trans.overflow{
            bins high = {1'b1};
            bins low  = {1'b0};
        }
        underflow: coverpoint trans.underflow{
            bins high = {1'b1};
            bins low  = {1'b0};
        }
        wr_ack: coverpoint trans.wr_ack{
            bins high = {1'b1};
            bins low  = {1'b0};
        }
        control_state: cross write_read, state;
    endgroup

    function new(string name = "fifo_coverage", uvm_component parent);
        super.new(name,parent);
        fifo_CG = new();
    endfunction: new
    
    virtual function void write(fifo_transaction t);
        trans = t;
        fifo_CG.sample();
    endfunction: write
endclass: fifo_coverage
