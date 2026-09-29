class reset_on_fly_empty_test extends base_test;
    `uvm_component_utils(reset_on_fly_empty_test)
    write_sequence write_seq;
    read_sequence  read_seq;

    function new(string name = "reset_on_fly_empty_test", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        repeat (5) @(posedge fifo_vif.clk);
        
        repeat (1) @(posedge fifo_vif.clk);
        fifo_vif.rst_n <= 1'b0;
        repeat (1) @(posedge fifo_vif.clk);
        fifo_vif.rst_n <= 1'b1;

        read_seq = read_sequence :: type_id :: create ("read_seq",this);
        read_seq.num_item = 1;
        read_seq.start(env.agent.sequencer);
       
        repeat (3) @(posedge fifo_vif.clk);
        phase.drop_objection(this);
    endtask: run_phase
endclass: reset_on_fly_empty_test
