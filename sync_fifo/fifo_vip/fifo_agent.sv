class fifo_agent extends uvm_agent;
    `uvm_component_utils(fifo_agent)
    virtual fifo_if fifo_vif;
    fifo_sequencer sequencer;
    fifo_driver    driver;
    fifo_monitor   monitor;

    function new(string name = "fifo_agent", uvm_component phase);
        super.new(name,phase);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("build_phase","Entered...",UVM_LOW)

        if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_vif",fifo_vif))begin
            `uvm_fatal(get_type_name(),$sformatf("Failed get fifo_vif from config db !!!!!!!!!"))
        end
        if(is_active == UVM_ACTIVE)begin
            `uvm_info(get_type_name(),$sformatf("ACTIVE Agent is config !!!"),UVM_LOW)
            sequencer    = fifo_sequencer :: type_id :: create ("sequencer",this);
            driver       = fifo_driver    :: type_id :: create ("driver",this);
            monitor      = fifo_monitor   :: type_id :: create ("monitor",this);
            uvm_config_db#(virtual fifo_if)::set(this,"driver" ,"fifo_vif",fifo_vif);
            uvm_config_db#(virtual fifo_if)::set(this,"monitor","fifo_vif",fifo_vif);
        end else begin
            `uvm_info(get_type_name(),$sformatf("PASSIVE Agent is config !!!"),UVM_LOW)
            monitor = fifo_monitor  :: type_id :: create ("monitor",this);
            uvm_config_db#(virtual fifo_if)::set(this,"monitor","fifo_vif",fifo_vif);
        end

        `uvm_info("build_phase","Exiting...",UVM_LOW)
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        `uvm_info("connect_phase","Entered............",UVM_LOW);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        `uvm_info("connect_phase","Exiting............",UVM_LOW);
    endfunction: connect_phase
endclass: fifo_agent
