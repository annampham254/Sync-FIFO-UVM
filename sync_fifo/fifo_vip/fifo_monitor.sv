class fifo_monitor extends uvm_monitor;
    `uvm_component_utils(fifo_monitor)
    uvm_analysis_port #(fifo_transaction) mon_port;
    virtual fifo_if fifo_vif;
    fifo_transaction trans;

    function new (string name = "fifo_monitor", uvm_component parent);
        super.new(name,parent);
        mon_port = new("mon_port",this);
    endfunction: new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_vif",fifo_vif))begin
           `uvm_fatal(get_type_name(),$sformatf("Failed get fifo_vif from config db !!!!!!!!!")) 
        end
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        forever begin
            trans = fifo_transaction :: type_id :: create("trans",this);
            @(posedge fifo_vif.clk); #1;
            trans.rst_n         = fifo_vif.rst_n;
            trans.wr_en         = fifo_vif.wr_en;
            trans.rd_en         = fifo_vif.rd_en;
            trans.data_in       = fifo_vif.data_in;
            trans.wr_ack        = fifo_vif.wr_ack;
            trans.full          = fifo_vif.full;
            trans.empty         = fifo_vif.empty;
            trans.overflow      = fifo_vif.overflow;
            trans.underflow     = fifo_vif.underflow;
            trans.almostfull    = fifo_vif.almostfull;
            trans.almostempty   = fifo_vif.almostempty;

            if(trans.rd_en)begin
                @(posedge fifo_vif.clk);#1;
                trans.data_out      = fifo_vif.data_out;
            end
            `uvm_info("body",$sformatf("Transaction Monitor catched and send to Scoreboard: \n %s", trans.sprint()),UVM_LOW)
            mon_port.write(trans);
        end
    endtask: run_phase
endclass: fifo_monitor
