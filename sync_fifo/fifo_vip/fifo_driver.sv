class fifo_driver extends uvm_driver#(fifo_transaction);
    `uvm_component_utils(fifo_driver)
    virtual fifo_if fifo_vif;

    function new(string name = "fifo_driver", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_vif",fifo_vif))begin
            `uvm_fatal(get_type_name(),$sformatf("Failed get fifo_vif from config db !!!!!!!!!"))
        end
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        @(posedge fifo_vif.rst_n);
        forever begin
        seq_item_port.get_next_item(req);
        drive(req);
        seq_item_port.item_done();
        end
    endtask: run_phase
    
    task drive(fifo_transaction trans);
       @(posedge fifo_vif.clk);
       if(trans.wr_en) begin
            fifo_vif.wr_en <= 1'b1;
            fifo_vif.data_in <= trans.data_in;
       end 
       if(trans.rd_en)  begin
            fifo_vif.rd_en <= 1'b1;
       end
       @(posedge fifo_vif.clk);
       fifo_vif.wr_en <= 1'b0;
       fifo_vif.rd_en <= 1'b0;

    endtask: drive

endclass: fifo_driver
