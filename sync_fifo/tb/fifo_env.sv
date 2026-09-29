class fifo_env extends uvm_env;
    `uvm_component_utils(fifo_env)
    virtual fifo_if fifo_vif;
    fifo_agent agent;
    fifo_scoreboard scoreboard;
    fifo_coverage coverage;
   
    function new(string name = "fifo_env", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("build_phase","Entered...",UVM_LOW)
        if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_vif",fifo_vif))begin
            `uvm_fatal(get_type_name(),$sformatf("Failed to get uart vif from config db!!!!!!!!!!!!"));
        end
  
        scoreboard     = fifo_scoreboard :: type_id :: create ("scoreboard",this);
        agent          = fifo_agent      :: type_id :: create ("agent",this);
        coverage       = fifo_coverage   :: type_id :: create ("coverage",this);

        uvm_config_db#(virtual fifo_if)::set(this, "agent", "fifo_vif", fifo_vif);
        
        `uvm_info("build_phase","Exiting...",UVM_LOW)
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("connect_phase","Entered............",UVM_LOW);
        agent.monitor.mon_port.connect(scoreboard.scb_import);  
        agent.monitor.mon_port.connect(coverage.analysis_export);
        `uvm_info("connect_phase","Exiting............",UVM_LOW);
    endfunction: connect_phase
endclass: fifo_env


